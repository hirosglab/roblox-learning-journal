local tool = script.Parent
local handle = tool:WaitForChild("Handle")
local prompt = handle:WaitForChild("ProximityPrompt")

-- ==========================================
-- アニメーションID管理（テキストベース）
-- ==========================================
local REACH_ANIM_ID = "rbxassetid://103450024420625" -- 掴むアニメーションID
local EAT_ANIM_ID   = "rbxassetid://125675335877414"  -- 食べるアニメーションID


-- 誰かが近づいてボタンを長押しし終えたときの処理
prompt.Triggered:Connect(function(player)
	local character = player.Character
	if not character then return end
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		-- 1. その場でお菓子を固定し、プロンプトを消す（連打防止）
		prompt.Enabled = false
		handle.Anchored = true

		-- 2. 「手を伸ばす」アニメーションを再生
		local reachAnim = Instance.new("Animation")
		reachAnim.AnimationId = REACH_ANIM_ID
		local track = humanoid:LoadAnimation(reachAnim)
		track.Priority = Enum.AnimationPriority.Action
		track:Play()

		-- 3. 手を伸ばしきるまでちょっと待つ
		task.wait(0.3)

		-- 4. 物理固定を解除して、アバターのバックパックへ強制移動（自動装備）
		handle.Anchored = false
		tool.Parent = character
	end
end)


-- 5. 装備した後にクリックしたら「食べる」処理
tool.Activated:Connect(function()
	local character = tool.Parent
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		print("食べています...")

		-- 「食べる」アニメーションの作成と設定
		local eatAnim = Instance.new("Animation")
		eatAnim.AnimationId = EAT_ANIM_ID

		-- 【修正】変数名を eatAnim に統一し、Priorityを設定
		local loungeAnim = humanoid:LoadAnimation(eatAnim)
		loungeAnim.Priority = Enum.AnimationPriority.Action
		loungeAnim:Play()

		-- アニメーションに合わせて待機し、オブジェクトを消失させる
		task.wait(0.6)
		tool:Destroy()
	end
end)

local tool = script.Parent
local handle = tool:WaitForChild("Handle")
local eatAnimation = tool:WaitForChild("EatAnimation")

local isEaten = false

-- ツールを装備した瞬間に、物理固定(Anchored)を自動で解除する
tool.Equipped:Connect(function()
	handle.Anchored = false
end)

tool.Activated:Connect(function()
	if isEaten then return end
	isEaten = true

	local character = tool.Parent
	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		-- アニメーションの再生
		local loungeAnim = humanoid:LoadAnimation(eatAnimation)
		loungeAnim:Play()

		task.wait(0.6) -- 食べるモーションを待つ（秒数は後で調整可）

		-- ここに後で音（Sound）や食べかす（Particle）のコードを足せます

		tool:Destroy() -- 食べ終わったら消える
	end
end)

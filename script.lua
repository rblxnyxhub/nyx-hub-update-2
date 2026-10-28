local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")
if not game:IsLoaded() then game.Loaded:Wait() end
repeat task.wait() until Players.LocalPlayer and workspace.CurrentCamera
print("[Nyx Hub] starting...")
local genv = (getgenv and getgenv()) or _G
if genv.NyxUnload then pcall(genv.NyxUnload) end
local ACCESS_KEY = "NYXHUB99"
local KEY_FILE = "NyxHub_key.txt"
local keySaved = false
pcall(function()
	if isfile and readfile and isfile(KEY_FILE) then
		keySaved = ((readfile(KEY_FILE):gsub("%s", ""))) == ACCESS_KEY
	end
end)

if not keySaved then
	local KEY_ANIM = true
	local function ktween(obj, info, props)
		if KEY_ANIM then
			local tw = TweenService:Create(obj, info, props)
			tw:Play()
			return tw
		end
		for k, v in pairs(props) do obj[k] = v end
	end
	local lp = Players.LocalPlayer
	local parent = (gethui and gethui()) or lp:WaitForChild("PlayerGui")
	local keyGui = Instance.new("ScreenGui")
	keyGui.Name = "NyxKey"
	keyGui.ResetOnSpawn = false
	keyGui.IgnoreGuiInset = true
	keyGui.DisplayOrder = 100
	keyGui.Parent = parent
	local keyBlur = Instance.new("BlurEffect")
	keyBlur.Name = "NyxKeyBlur"
	keyBlur.Size = 0
	keyBlur.Parent = Lighting
	ktween(keyBlur, TweenInfo.new(0.5), {Size = 18})
	local unlocked, cancelled = false, false
	genv.NyxUnload = function()
		cancelled = true
		keyBlur:Destroy()
		keyGui:Destroy()
	end
	local dim = Instance.new("Frame")
	dim.Size = UDim2.fromScale(1, 1)
	dim.BackgroundColor3 = Color3.new(0, 0, 0)
	dim.BackgroundTransparency = 0.4
	dim.BorderSizePixel = 0
	dim.Parent = keyGui
	for i = 1, (KEY_ANIM and 16 or 0) do
		task.spawn(function()
			local dot = Instance.new("Frame")
			local s = math.random(3, 7)
			dot.Size = UDim2.fromOffset(s, s)
			dot.BackgroundColor3 = Color3.fromRGB(112, 92, 255)
			dot.BackgroundTransparency = 0.6
			dot.BorderSizePixel = 0
			dot.Parent = keyGui
			Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
			task.wait(math.random() * 3)
			while keyGui.Parent and not cancelled do
				local x = math.random()
				dot.Position = UDim2.fromScale(x, 1.05)
				local t = math.random(40, 90) / 10
				local tw = TweenService:Create(dot, TweenInfo.new(t, Enum.EasingStyle.Linear),
					{Position = UDim2.fromScale(x + (math.random() - 0.5) * 0.2, -0.05)})
				tw:Play()
				tw.Completed:Wait()
			end
		end)
	end
	local box = Instance.new("CanvasGroup")
	box.AnchorPoint = Vector2.new(0.5, 0.5)
	box.Position = UDim2.fromScale(0.5, 0.5)
	box.Size = UDim2.fromOffset(360, 250)
	box.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
	box.BorderSizePixel = 0
	box.GroupTransparency = 1
	box.Parent = keyGui
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 16)
	local boxStroke = Instance.new("UIStroke")
	boxStroke.Color = Color3.new(1, 1, 1)
	boxStroke.Thickness = 2
	boxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	boxStroke.Parent = box
	local grad = Instance.new("UIGradient")
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(112, 92, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(24, 24, 30)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(112, 92, 255)),
	})
	grad.Parent = boxStroke
	ktween(grad, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {Rotation = 360})
	local boxScale = Instance.new("UIScale")
	boxScale.Scale = 0.85
	boxScale.Parent = box
	local lock = Instance.new("TextLabel")
	lock.Size = UDim2.new(1, 0, 0, 36)
	lock.Position = UDim2.fromOffset(0, 14)
	lock.BackgroundTransparency = 1
	lock.Text = "\u{1F512}"
	lock.TextSize = 28
	lock.Font = Enum.Font.GothamBold
	lock.TextColor3 = Color3.new(1, 1, 1)
	lock.Parent = box
	local ttl = Instance.new("TextLabel")
	ttl.Size = UDim2.new(1, 0, 0, 34)
	ttl.Position = UDim2.fromOffset(0, 50)
	ttl.BackgroundTransparency = 1
	ttl.RichText = true
	ttl.Text = '<font color="#7064FF">NYX</font> HUB'
	ttl.TextSize = 26
	ttl.Font = Enum.Font.GothamBlack
	ttl.TextColor3 = Color3.new(1, 1, 1)
	ttl.Parent = box
	local sub = Instance.new("TextLabel")
	sub.Size = UDim2.new(1, 0, 0, 16)
	sub.Position = UDim2.fromOffset(0, 84)
	sub.BackgroundTransparency = 1
	sub.Text = "A C C E S S   R E Q U I R E D"
	sub.TextSize = 11
	sub.Font = Enum.Font.GothamBold
	sub.TextColor3 = Color3.fromRGB(140, 140, 156)
	sub.Parent = box
	local input = Instance.new("TextBox")
	input.AnchorPoint = Vector2.new(0.5, 0)
	input.Position = UDim2.new(0.5, 0, 0, 114)
	input.Size = UDim2.new(1, -50, 0, 40)
	input.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	input.BorderSizePixel = 0
	input.PlaceholderText = "Enter access code"
	input.PlaceholderColor3 = Color3.fromRGB(110, 110, 130)
	input.Text = ""
	input.ClearTextOnFocus = false
	input.TextSize = 15
	input.Font = Enum.Font.GothamBold
	input.TextColor3 = Color3.new(1, 1, 1)
	input.Parent = box
	Instance.new("UICorner", input).CornerRadius = UDim.new(0, 10)
	local inStroke = Instance.new("UIStroke")
	inStroke.Color = Color3.fromRGB(112, 92, 255)
	inStroke.Thickness = 1.5
	inStroke.Transparency = 1
	inStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	inStroke.Parent = input
	input.Focused:Connect(function()
		ktween(inStroke, TweenInfo.new(0.15), {Transparency = 0})
	end)
	input.FocusLost:Connect(function()
		ktween(inStroke, TweenInfo.new(0.2), {Transparency = 1})
	end)
	local btn = Instance.new("TextButton")
	btn.AnchorPoint = Vector2.new(0.5, 0)
	btn.Position = UDim2.new(0.5, 0, 0, 164)
	btn.Size = UDim2.new(1, -50, 0, 40)
	btn.BackgroundColor3 = Color3.fromRGB(112, 92, 255)
	btn.BorderSizePixel = 0
	btn.AutoButtonColor = false
	btn.Text = "UNLOCK"
	btn.TextSize = 14
	btn.Font = Enum.Font.GothamBold
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Parent = box
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	btn.MouseEnter:Connect(function()
		ktween(btn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(135, 118, 255)})
	end)
	btn.MouseLeave:Connect(function()
		ktween(btn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(112, 92, 255)})
	end)
	local msg = Instance.new("TextLabel")
	msg.AnchorPoint = Vector2.new(0.5, 0)
	msg.Position = UDim2.new(0.5, 0, 0, 216)
	msg.Size = UDim2.new(1, -20, 0, 18)
	msg.BackgroundTransparency = 1
	msg.Text = ""
	msg.TextSize = 12
	msg.Font = Enum.Font.GothamMedium
	msg.TextColor3 = Color3.fromRGB(235, 70, 80)
	msg.Parent = box
	local barBack = Instance.new("Frame")
	barBack.AnchorPoint = Vector2.new(0.5, 0)
	barBack.Position = UDim2.new(0.5, 0, 0, 150)
	barBack.Size = UDim2.new(1, -60, 0, 8)
	barBack.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
	barBack.BorderSizePixel = 0
	barBack.Visible = false
	barBack.Parent = box
	Instance.new("UICorner", barBack).CornerRadius = UDim.new(1, 0)
	local barFill = Instance.new("Frame")
	barFill.Size = UDim2.fromScale(0, 1)
	barFill.BackgroundColor3 = Color3.fromRGB(60, 235, 110)
	barFill.BorderSizePixel = 0
	barFill.Parent = barBack
	Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)
	ktween(box, TweenInfo.new(0.35), {GroupTransparency = 0})
	ktween(boxScale, TweenInfo.new(0.45, Enum.EasingStyle.Back), {Scale = 1})
	local function shake()
		if not KEY_ANIM then return end
		local base = box.Position
		for i = 1, 8 do
			box.Position = base + UDim2.fromOffset((i % 2 == 0 and 9 or -9), 0)
			task.wait(0.035)
		end
		box.Position = base
	end
	local attempts, checking = 0, false
	local function submit()
		if checking or unlocked then return end
		checking = true
		local entered = input.Text:gsub("%s", "")
		if entered == ACCESS_KEY then
			unlocked = true
			pcall(function()
				if writefile then writefile(KEY_FILE, ACCESS_KEY) end
			end)
			lock.Text = "\u{1F513}"
			sub.Text = "A C C E S S   G R A N T E D"
			sub.TextColor3 = Color3.fromRGB(60, 235, 110)
			input.Visible, btn.Visible = false, false
			barBack.Visible = true
			msg.TextColor3 = Color3.fromRGB(140, 140, 156)
			local stages = {"Loading movement...", "Loading ESP + aim...", "Loading world tools...",
			"Loading performance...", "Starting Nyx Hub..."}
			for i, s in ipairs(stages) do
				msg.Text = s
				ktween(barFill, TweenInfo.new(0.22, Enum.EasingStyle.Quad), {Size = UDim2.fromScale(i / #stages, 1)})
				task.wait(KEY_ANIM and 0.24 or 0.05)
			end
			ktween(boxScale, TweenInfo.new(0.25), {Scale = 1.08})
			ktween(box, TweenInfo.new(0.25), {GroupTransparency = 1})
			ktween(keyBlur, TweenInfo.new(0.3), {Size = 0})
			ktween(dim, TweenInfo.new(0.3), {BackgroundTransparency = 1})
			task.wait(KEY_ANIM and 0.3 or 0)
		else
			attempts += 1
			msg.TextColor3 = Color3.fromRGB(235, 70, 80)
			msg.Text = ("Wrong access code  (attempt %d)"):format(attempts)
			input.Text = ""
			shake()
		end
		checking = false
	end
	btn.MouseButton1Click:Connect(submit)
	input.FocusLost:Connect(function(enter) if enter then submit() end end)
	while not unlocked and not cancelled do task.wait(0.1) end
	pcall(function() keyBlur:Destroy() end)
	keyGui:Destroy()
	if cancelled then return end
end

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local char, humanoid, root
local bodyGyro, bodyVelocity
local spawnCFrame
local lastSafe
local capturedDefaults = false
local conns = {}
local function connect(signal, fn)
	local c = signal:Connect(fn)
	table.insert(conns, c)
	return c
end

local ICONS = {
	movement = "\u{1F3C3}",
	players = "\u{1F465}",
	esp = "\u{1F441}\u{FE0F}",
	world = "\u{1F30D}",
	server = "\u{1F310}",
	misc = "\u{2699}\u{FE0F}",
	aim = "\u{1F3AF}",
	perf = "\u{26A1}",
}

local defaults = {
	walk = 16,
	jump = 50,
	gravity = workspace.Gravity,
	fov = camera.FieldOfView,
	zoom = player.CameraMaxZoomDistance,
}

local state = {
	noCharAnim = false,
	flying = false,
	flySpeed = 70,
	noclip = false,
	walkOn = false, walkSpeed = 16,
	jumpOn = false, jumpPower = 50,
	cframeSpeed = false,
	forceJump = false,
	infJump = false,
	spin = false, spinSpeed = 360,
	clickTP = false,
	freecam = false, fcSpeed = 60,
	freeze = false,
	invis = false,
	bhop = false,
	slowFall = false, fallSpeed = 20,
	antiVoid = false,
	dashPower = 90,
	sprint = false, sprintBoost = 30,
	vehFly = false, vehSpeed = 100, vehFace = true,
	gravityOn = false, gravity = workspace.Gravity,
	fovOn = false, fov = camera.FieldOfView,
	zoomOn = false, zoom = player.CameraMaxZoomDistance,
	fullbright = false,
	noFog = false,
	clockOn = false, clock = 14,
	antiAfk = true,
	autoRejoin = false,
	followTarget = nil,
	spectateTarget = nil,
}

local sync = {}
local ui = {registry = {}, groupMap = {}}
local infoLabels = {}
local function setStatus(_) end
local perf = {
	s = {capOn = false, cap = 240, low = false, shadows = false, fx = false,
	flat = false, post = false, decals = false, black = false},
	reset = function() end,
	cleanup = function() end,
	snapshot = function() return {} end,
	load = function() end,
	toggleBlack = function() end,
	setCapValue = function() end,
	presetByName = function() end,
	clean = function() end,
}

local function stopFly()
	state.flying = false
	if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
	if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
	if humanoid then humanoid.PlatformStand = false end
end

local function startFly()
	if state.flying or not root or not humanoid then return end
	state.flying = true
	bodyGyro = Instance.new("BodyGyro")
	bodyGyro.P = 100000
	bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
	bodyGyro.CFrame = root.CFrame
	bodyGyro.Parent = root
	bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
	bodyVelocity.Velocity = Vector3.zero
	bodyVelocity.Parent = root
	humanoid.PlatformStand = true
end

connect(RunService.RenderStepped, function()
	camera = workspace.CurrentCamera
	if not (state.flying and bodyVelocity and bodyGyro and humanoid) then return end
	local cf = camera.CFrame
	bodyGyro.CFrame = cf
	local md = humanoid.MoveDirection
	local look = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
	local right = Vector3.new(cf.RightVector.X, 0, cf.RightVector.Z)
	local vel = Vector3.zero
	if md.Magnitude > 0 and look.Magnitude > 0.001 and right.Magnitude > 0.001 then
		local fwd = md:Dot(look.Unit)
		local rgt = md:Dot(right.Unit)
		vel = cf.LookVector * fwd + right.Unit * rgt
	end
	if UIS:IsKeyDown(Enum.KeyCode.Space) or UIS:IsKeyDown(Enum.KeyCode.E) then
		vel += Vector3.yAxis
	end
	if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.Q) then
		vel -= Vector3.yAxis
	end
	bodyVelocity.Velocity = vel * state.flySpeed
end)

connect(RunService.Stepped, function()
	if state.noclip and char then
		for _, v in ipairs(char:GetDescendants()) do
			if v:IsA("BasePart") then v.CanCollide = false end
		end
	end
end)

local function setNoclip(on)
	state.noclip = on
	if not on and char then
		for _, v in ipairs(char:GetDescendants()) do
			if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
				v.CanCollide = true
			end
		end
	end
end

connect(UIS.JumpRequest, function()
	if state.infJump and humanoid then
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

local atmos = Lighting:FindFirstChildOfClass("Atmosphere")
local savedDensity = atmos and atmos.Density
local savedClock = Lighting.ClockTime
local savedLighting = {
	Brightness = Lighting.Brightness,
	FogEnd = Lighting.FogEnd,
	GlobalShadows = Lighting.GlobalShadows,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
}

local function applyLighting()
	if state.fullbright then
		Lighting.Brightness = 2
		Lighting.GlobalShadows = false
		Lighting.Ambient = Color3.new(1, 1, 1)
		Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
	end
	if state.fullbright or state.noFog then
		Lighting.FogEnd = 1e9
		atmos = atmos or Lighting:FindFirstChildOfClass("Atmosphere")
		if atmos then atmos.Density = 0 end
	end
	if state.clockOn then Lighting.ClockTime = state.clock end
end

local function restoreLighting()
	for k, v in pairs(savedLighting) do Lighting[k] = v end
	if atmos and savedDensity then atmos.Density = savedDensity end
end

local function setFullbright(on)
	state.fullbright = on
	if not on then restoreLighting() end
end

local function setNoFog(on)
	state.noFog = on
	if not on then restoreLighting() end
end

local function getRoot(p)
	local c = p and p.Character
	return c and c:FindFirstChild("HumanoidRootPart")
end

local function teleportToPlayer(p)
	local t = getRoot(p)
	if not (t and root) then
		setStatus(p.Name .. " isn't loaded / has no character")
		return false
	end
	root.AssemblyLinearVelocity = Vector3.zero
	root.CFrame = t.CFrame * CFrame.new(0, 0, 3)
	setStatus("Teleported to " .. p.DisplayName)
	return true
end

local function stopSpectate()
	state.spectateTarget = nil
	if humanoid then camera.CameraSubject = humanoid end
end

local function startSpectate(p)
	local c = p.Character
	local h = c and c:FindFirstChildOfClass("Humanoid")
	if not h then setStatus("Can't spectate " .. p.Name) return end
	state.spectateTarget = p
	camera.CameraSubject = h
	setStatus("Spectating " .. p.DisplayName)
end

local function stopFollow()
	state.followTarget = nil
end

connect(UIS.InputBegan, function(input, gp)
	if gp or not state.clickTP or not root then return end
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
	if not UIS:IsKeyDown(Enum.KeyCode.LeftAlt) then return end
	local m = UIS:GetMouseLocation()
	local ray = camera:ViewportPointToRay(m.X, m.Y)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {char}
	local hit = workspace:Raycast(ray.Origin, ray.Direction * 5000, params)
	if hit then
		root.AssemblyLinearVelocity = Vector3.zero
		root.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3, 0))
	end
end)

local fc = {pos = Vector3.zero, yaw = 0, pitch = 0}
local function setFreecam(on)
	if on == state.freecam then return end
	state.freecam = on
	if on then
		local cf = camera.CFrame
		fc.pos = cf.Position
		fc.pitch, fc.yaw = cf:ToOrientation()
		camera.CameraType = Enum.CameraType.Scriptable
		if root then root.Anchored = true end
	else
		UIS.MouseBehavior = Enum.MouseBehavior.Default
		camera.CameraType = Enum.CameraType.Custom
		if humanoid then camera.CameraSubject = humanoid end
		if root then root.Anchored = state.freeze end
	end
end

connect(RunService.RenderStepped, function(dt)
	if not state.freecam then return end
	local rot = CFrame.fromOrientation(fc.pitch, fc.yaw, 0)
	if not UIS:GetFocusedTextBox() then
		local dir = Vector3.zero
		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += rot.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= rot.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += rot.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= rot.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.E) or UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
		if UIS:IsKeyDown(Enum.KeyCode.Q) then dir -= Vector3.yAxis end
		if dir.Magnitude > 0 then
			local mult = UIS:IsKeyDown(Enum.KeyCode.LeftShift) and 3 or 1
			fc.pos += dir.Unit * state.fcSpeed * mult * dt
		end
	end
	camera.CFrame = CFrame.new(fc.pos) * rot
end)

connect(UIS.InputChanged, function(input)
	if state.freecam and input.UserInputType == Enum.UserInputType.MouseMovement
			and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
		fc.yaw -= input.Delta.X * 0.004
		fc.pitch = math.clamp(fc.pitch - input.Delta.Y * 0.004, -1.5, 1.5)
	end
end)

connect(UIS.InputBegan, function(input)
	if state.freecam and input.UserInputType == Enum.UserInputType.MouseButton2 then
		UIS.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
	end
end)

connect(UIS.InputEnded, function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		UIS.MouseBehavior = Enum.MouseBehavior.Default
	end
end)

local function setFreeze(on)
	state.freeze = on
	if root then
		if on then
			root.AssemblyLinearVelocity = Vector3.zero
			root.AssemblyAngularVelocity = Vector3.zero
		end
		root.Anchored = on or state.freecam
	end
end

local function doDash()
	if not root or state.freeze then return end
	local look = camera.CFrame.LookVector
	local flat = Vector3.new(look.X, 0, look.Z)
	if flat.Magnitude < 0.01 then return end
	root.AssemblyLinearVelocity = flat.Unit * state.dashPower + Vector3.new(0, 25, 0)
end

local animConn
local function stopAnimTracks()
	local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
	if not animator then return end
	for _, tr in ipairs(animator:GetPlayingAnimationTracks()) do
		tr:Stop(0)
	end
end

local function setCharAnim(on)
	state.noCharAnim = on
	local a = char and char:FindFirstChild("Animate")
	if a and a:IsA("LocalScript") then a.Disabled = on end
	if animConn then animConn:Disconnect() animConn = nil end
	if on then
		stopAnimTracks()
		local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
		if animator then
			animConn = animator.AnimationPlayed:Connect(function(tr)
				if state.noCharAnim then tr:Stop(0) end
			end)
		end
	end
end

local invisSeat, invisToken = nil, 0
local INVIS_FAR = Vector3.new(-25.95, 84, 3537.55)
local function setInvis(on)
	invisToken += 1
	local my = invisToken
	if on then
		if state.invis then return end
		local torso = char and (char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"))
		if not (root and humanoid and torso) or humanoid.Health <= 0 then
			setStatus("No character to hide")
			if sync.invis then sync.invis(false) end
			return
		end
		state.invis = true
		task.spawn(function()
			local saved = root.CFrame
			char:PivotTo(CFrame.new(INVIS_FAR))
			task.wait(0.15)
			if invisToken ~= my or not (root and root.Parent) then return end
			local seat = Instance.new("Seat")
			seat.Name = "NyxInvisSeat"
			seat.Anchored = false
			seat.CanCollide = false
			seat.Transparency = 1
			seat.Position = INVIS_FAR
			seat.Parent = workspace
			local weld = Instance.new("Weld")
			weld.Part0, weld.Part1 = seat, torso
			weld.Parent = seat
			task.wait()
			seat.CFrame = saved
			invisSeat = seat
		end)
	else
		if not state.invis then return end
		state.invis = false
		if invisSeat then invisSeat:Destroy() invisSeat = nil end
		if root then root.AssemblyLinearVelocity = Vector3.zero end
	end
end

local veh = {}
function veh.stop()
	if veh.gyro then veh.gyro:Destroy() veh.gyro = nil end
	if veh.vel then veh.vel:Destroy() veh.vel = nil end
	veh.root, veh.lock = nil, nil
end

connect(RunService.Heartbeat, function()
	if not state.vehFly then
		if veh.root then veh.stop() end
		return
	end
	local seat = humanoid and humanoid.SeatPart
	local base = seat and (seat.AssemblyRootPart or seat)
	if not base or not base.Parent then
		if veh.root then veh.stop() end
		return
	end
	if veh.root ~= base then
		veh.stop()
		veh.root = base
		veh.lock = base.CFrame.Rotation
		veh.gyro = Instance.new("BodyGyro")
		veh.gyro.P = 50000
		veh.gyro.D = 2000
		veh.gyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
		veh.gyro.CFrame = base.CFrame
		veh.gyro.Parent = base
		veh.vel = Instance.new("BodyVelocity")
		veh.vel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
		veh.vel.Velocity = Vector3.zero
		veh.vel.Parent = base
	end
	local cf = camera.CFrame
	local dir = Vector3.zero
	if not UIS:GetFocusedTextBox() then
		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cf.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cf.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cf.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cf.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) or UIS:IsKeyDown(Enum.KeyCode.E) then dir += Vector3.yAxis end
		if UIS:IsKeyDown(Enum.KeyCode.LeftShift) or UIS:IsKeyDown(Enum.KeyCode.Q) then dir -= Vector3.yAxis end
	end
	if dir.Magnitude > 0 then dir = dir.Unit end
	veh.vel.Velocity = dir * state.vehSpeed
	local flat = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
	if state.vehFace and flat.Magnitude > 0.001 then
		veh.gyro.CFrame = CFrame.lookAt(base.Position, base.Position + flat)
	else
		veh.gyro.CFrame = CFrame.new(base.Position) * veh.lock
	end
end)

connect(player.Idled, function()
	if state.antiAfk then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

connect(GuiService.ErrorMessageChanged, function(msg)
	if state.autoRejoin and msg and msg ~= "" then
		task.wait(2)
		pcall(function() TeleportService:Teleport(game.PlaceId, player) end)
	end
end)

do
	local fpsFrames, fpsTime = 0, 0
	connect(RunService.Heartbeat, function(dt)
		fpsFrames += 1
		fpsTime += dt
		if fpsTime >= 0.5 then
			local fps = math.floor(fpsFrames / fpsTime + 0.5)
			fpsFrames, fpsTime = 0, 0
			if infoLabels.fps then infoLabels.fps.Text = "FPS: " .. fps end
			if infoLabels.ping then
				infoLabels.ping.Text = "Ping: " .. math.floor(player:GetNetworkPing() * 1000) .. " ms"
			end
			if infoLabels.players then
				infoLabels.players.Text = ("Players: %d / %d"):format(#Players:GetPlayers(), Players.MaxPlayers)
			end
		end
		if state.gravityOn and workspace.Gravity ~= state.gravity then
			workspace.Gravity = state.gravity
		end
		if state.fovOn and camera.FieldOfView ~= state.fov then
			camera.FieldOfView = state.fov
		end
		if state.zoomOn and player.CameraMaxZoomDistance ~= state.zoom then
			player.CameraMaxZoomDistance = state.zoom
		end
		applyLighting()
		if not (humanoid and humanoid.Parent and root) then return end
		if state.noCharAnim then stopAnimTracks() end
		if state.walkOn and not state.cframeSpeed then
			if humanoid.WalkSpeed ~= state.walkSpeed then
				humanoid.WalkSpeed = state.walkSpeed
			end
		end
		if state.cframeSpeed and not state.flying and not state.freeze then
			local extra = math.max(state.walkSpeed - defaults.walk, 0)
			local md = humanoid.MoveDirection
			if extra > 0 and md.Magnitude > 0 then
				root.CFrame = root.CFrame + md * extra * dt
			end
		end
		if state.sprint and not state.flying and not state.freeze
				and UIS:IsKeyDown(Enum.KeyCode.LeftShift) and not UIS:GetFocusedTextBox() then
			local md = humanoid.MoveDirection
			if md.Magnitude > 0 then
				root.CFrame = root.CFrame + md * state.sprintBoost * dt
			end
		end
		if state.jumpOn and not state.forceJump then
			if not humanoid.UseJumpPower then humanoid.UseJumpPower = true end
			if humanoid.JumpPower ~= state.jumpPower then
				humanoid.JumpPower = state.jumpPower
			end
		end
		if state.spin and not state.flying then
			root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(state.spinSpeed) * dt, 0)
		end
		if state.bhop and not state.flying and UIS:IsKeyDown(Enum.KeyCode.Space)
				and not UIS:GetFocusedTextBox() then
			humanoid.Jump = true
		end
		if state.slowFall and not state.flying then
			local v = root.AssemblyLinearVelocity
			if v.Y < -state.fallSpeed then
				root.AssemblyLinearVelocity = Vector3.new(v.X, -state.fallSpeed, v.Z)
			end
		end
		if state.antiVoid then
			local floor = workspace.FallenPartsDestroyHeight
			if humanoid.FloorMaterial ~= Enum.Material.Air and root.Position.Y > floor + 150 then
				lastSafe = root.CFrame
			elseif lastSafe and root.Position.Y < floor + 80 then
				root.AssemblyLinearVelocity = Vector3.zero
				root.CFrame = lastSafe + Vector3.new(0, 5, 0)
			end
		end
		if state.followTarget then
			if not state.followTarget.Parent then
				stopFollow()
			else
				local t = getRoot(state.followTarget)
				if t then root.CFrame = t.CFrame * CFrame.new(0, 0, 3) end
			end
		end
	end)
end

local function onCharacter(c)
	char = c
	humanoid = c:WaitForChild("Humanoid")
	root = c:WaitForChild("HumanoidRootPart")
	spawnCFrame = root.CFrame
	bodyGyro, bodyVelocity = nil, nil
	state.flying = false
	if sync.fly then sync.fly(false) end
	if not capturedDefaults then
		capturedDefaults = true
		defaults.walk = humanoid.WalkSpeed
		defaults.jump = humanoid.JumpPower
	end
	humanoid.StateChanged:Connect(function(_, new)
		if state.forceJump and state.jumpOn and new == Enum.HumanoidStateType.Jumping and root then
			local v = root.AssemblyLinearVelocity
			root.AssemblyLinearVelocity = Vector3.new(v.X, state.jumpPower, v.Z)
		end
	end)
	if state.spectateTarget then stopSpectate() end
	if state.freecam then
		setFreecam(false)
		if sync.freecam then sync.freecam(false) end
	end
	if state.invis then
		invisToken += 1
		state.invis = false
		invisSeat = nil
		if sync.invis then sync.invis(false) end
	end
	if state.freeze then
		state.freeze = false
		if sync.freeze then sync.freeze(false) end
	end
	animConn = nil
	if state.noCharAnim then
		task.spawn(function()
			c:WaitForChild("Animate", 5)
			c:WaitForChild("Humanoid"):WaitForChild("Animator", 5)
			if char == c then setCharAnim(true) end
		end)
	end
end

connect(player.CharacterAdded, onCharacter)
onCharacter(player.Character or player.CharacterAdded:Wait())
local guiParent = (gethui and gethui()) or player:WaitForChild("PlayerGui")
local gui = Instance.new("ScreenGui")
gui.Name = "NyxHub"
gui.ResetOnSpawn = false
gui.Parent = guiParent
local esp = {
	on = false,
	box = false,
	name = false,
	health = false,
	distance = false,
	item = false,
	chams = false,
	tracers = false,
	tracerOrigin = "Bottom",
	skeleton = false,
	colorMode = "Team",
	fixedIdx = 1,
	hideTeam = false,
	maxDist = 2000,
	tracerThick = 1,
	tracerAlpha = 0.7,
	boxAlpha = 1,
	textAlpha = 1,
	skelAlpha = 0.9,
	chamFill = 0.5,
}

state.esp = esp
local FIXED_COLORS = {
	{"Red", Color3.fromRGB(255, 70, 70)},
	{"Green", Color3.fromRGB(60, 235, 110)},
	{"Blue", Color3.fromRGB(70, 140, 255)},
	{"Yellow", Color3.fromRGB(255, 225, 70)},
	{"Pink", Color3.fromRGB(255, 100, 190)},
	{"White", Color3.fromRGB(255, 255, 255)},
}

local aim = {
	on = false,
	mode = "Hold",
	key = "RMB",
	keys = {"RMB", "X", "C", "Z", "LeftShift", "LeftAlt"},
	part = "Head",
	partNames = {Head = "Head", HumanoidRootPart = "Torso", Closest = "Closest"},
	priority = "Cursor",
	fov = 150,
	smooth = 0.25,
	maxDist = 1000,
	predict = false,
	predictAmt = 0.12,
	sticky = false,
	humanize = 0,
	teamCheck = true,
	wallCheck = false,
	showFov = true,
	fovAlpha = 0.35,
	fovColor = "White",
	snapline = true,
	targetInfo = true,
	trigger = false,
	trigDelay = 0.1,
}

local radar = {
	on = false,
	range = 200,
	size = 150,
	corner = "Top Right",
	corners = {"Top Right", "Top Left", "Bottom Left", "Bottom Right"},
}

local hud = {watermark = true, list = true, blur = true}
local blur = Instance.new("BlurEffect")
blur.Name = "NyxBlur"
blur.Size = 0
blur.Parent = Lighting
local espFolder = Instance.new("Folder")
espFolder.Name = "NyxESP"
espFolder.Parent = guiParent
local tracerGui = Instance.new("ScreenGui")
tracerGui.Name = "NyxTracers"
tracerGui.ResetOnSpawn = false
tracerGui.IgnoreGuiInset = true
tracerGui.DisplayOrder = -1
tracerGui.Parent = guiParent
local espObjects = {}
local function makeBillboard(size, offset)
	local b = Instance.new("BillboardGui")
	b.AlwaysOnTop = true
	b.LightInfluence = 0
	b.Size = size
	b.StudsOffset = offset or Vector3.zero
	b.ResetOnSpawn = false
	b.Enabled = false
	b.Parent = espFolder
	return b
end

local function makeESPLabel(parent)
	local l = Instance.new("TextLabel")
	l.Size = UDim2.fromScale(1, 1)
	l.BackgroundTransparency = 1
	l.Font = Enum.Font.GothamBold
	l.TextSize = 13
	l.TextColor3 = Color3.new(1, 1, 1)
	l.TextStrokeTransparency = 0
	l.TextStrokeColor3 = Color3.new(0, 0, 0)
	l.Parent = parent
	return l
end

local function createESP(p)
	local o = {}
	o.boxGui = makeBillboard(UDim2.new(4, 0, 6, 0))
	o.boxFrame = Instance.new("Frame")
	o.boxFrame.Size = UDim2.fromScale(1, 1)
	o.boxFrame.BackgroundTransparency = 1
	o.boxFrame.BorderSizePixel = 0
	o.boxFrame.Parent = o.boxGui
	o.boxStroke = Instance.new("UIStroke")
	o.boxStroke.Thickness = 1.5
	o.boxStroke.Parent = o.boxFrame
	o.hpBack = Instance.new("Frame")
	o.hpBack.AnchorPoint = Vector2.new(1, 0)
	o.hpBack.Position = UDim2.new(0, -4, 0, 0)
	o.hpBack.Size = UDim2.new(0, 3, 1, 0)
	o.hpBack.BackgroundColor3 = Color3.new(0, 0, 0)
	o.hpBack.BorderSizePixel = 0
	o.hpBack.Parent = o.boxGui
	o.hpFill = Instance.new("Frame")
	o.hpFill.AnchorPoint = Vector2.new(0, 1)
	o.hpFill.Position = UDim2.fromScale(0, 1)
	o.hpFill.Size = UDim2.fromScale(1, 1)
	o.hpFill.BorderSizePixel = 0
	o.hpFill.Parent = o.hpBack
	o.topGui = makeBillboard(UDim2.fromOffset(220, 18), Vector3.new(0, 3.8, 0))
	o.nameLabel = makeESPLabel(o.topGui)
	o.botGui = makeBillboard(UDim2.fromOffset(280, 16), Vector3.new(0, -3.8, 0))
	o.infoLabel = makeESPLabel(o.botGui)
	o.infoLabel.TextSize = 12
	o.hl = Instance.new("Highlight")
	o.hl.FillTransparency = 0.5
	o.hl.OutlineTransparency = 0
	o.hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	o.hl.Enabled = false
	o.hl.Parent = espFolder
	o.tracer = Instance.new("Frame")
	o.tracer.AnchorPoint = Vector2.new(0.5, 0.5)
	o.tracer.BorderSizePixel = 0
	o.tracer.Visible = false
	o.tracer.Parent = tracerGui
	o.bones = {}
	espObjects[p] = o
	return o
end

local function hideESP(o)
	o.boxGui.Enabled = false
	o.topGui.Enabled = false
	o.botGui.Enabled = false
	o.hl.Enabled = false
	o.tracer.Visible = false
	for _, f in ipairs(o.bones) do f.Visible = false end
end

local function removeESP(p)
	local o = espObjects[p]
	if not o then return end
	o.boxGui:Destroy() o.topGui:Destroy() o.botGui:Destroy()
	o.hl:Destroy() o.tracer:Destroy()
	for _, f in ipairs(o.bones) do f:Destroy() end
	espObjects[p] = nil
end

connect(Players.PlayerRemoving, removeESP)
local drawSkeleton
do
	local function setLine(f, a, b, color, thickness)
		local d = b - a
		f.Size = UDim2.fromOffset(d.Magnitude, thickness)
		f.Position = UDim2.fromOffset((a.X + b.X) / 2, (a.Y + b.Y) / 2)
		f.Rotation = math.deg(math.atan2(d.Y, d.X))
		f.BackgroundColor3 = color
		f.BackgroundTransparency = 1 - esp.skelAlpha
		f.Visible = true
	end
	local R15_BONES = {
		{"Head", "UpperTorso"}, {"UpperTorso", "LowerTorso"},
		{"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
		{"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
		{"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
		{"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"},
	}
	local R6_BONES = {
		{"Head", "Torso"}, {"Torso", "Left Arm"}, {"Torso", "Right Arm"},
		{"Torso", "Left Leg"}, {"Torso", "Right Leg"},
	}
	drawSkeleton = function(o, c, color)
		local set = c:FindFirstChild("UpperTorso") and R15_BONES or R6_BONES
		for i, pair in ipairs(set) do
			local f = o.bones[i]
			if not f then
				f = Instance.new("Frame")
				f.AnchorPoint = Vector2.new(0.5, 0.5)
				f.BorderSizePixel = 0
				f.Visible = false
				f.Parent = tracerGui
				o.bones[i] = f
			end
			local a, b = c:FindFirstChild(pair[1]), c:FindFirstChild(pair[2])
			if a and b then
				local pa, onA = camera:WorldToViewportPoint(a.Position)
				local pb, onB = camera:WorldToViewportPoint(b.Position)
				if onA and onB then
					setLine(f, Vector2.new(pa.X, pa.Y), Vector2.new(pb.X, pb.Y), color, 1.5)
				else
					f.Visible = false
				end
			else
				f.Visible = false
			end
		end
		for i = #set + 1, #o.bones do o.bones[i].Visible = false end
	end
end

local function espColor(p, ratio, idx)
	local m = esp.colorMode
	if m == "Team" then
		return p.Team and p.TeamColor.Color or Color3.new(1, 1, 1)
	elseif m == "Health" then
		return Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(50, 255, 90), ratio)
	elseif m == "Rainbow" then
		return Color3.fromHSV((os.clock() * 0.25 + idx * 0.07) % 1, 1, 1)
	end
	return FIXED_COLORS[esp.fixedIdx][2]
end

do
	local circle = Instance.new("Frame")
	circle.AnchorPoint = Vector2.new(0.5, 0.5)
	circle.BackgroundTransparency = 1
	circle.Visible = false
	circle.Parent = tracerGui
	local cc = Instance.new("UICorner")
	cc.CornerRadius = UDim.new(1, 0)
	cc.Parent = circle
	local cs = Instance.new("UIStroke")
	cs.Thickness = 1.5
	cs.Color = Color3.new(1, 1, 1)
	cs.Transparency = 0.65
	cs.Parent = circle

	-- thin line from your cursor to the locked target
	local snap = Instance.new("Frame")
	snap.AnchorPoint = Vector2.new(0.5, 0.5)
	snap.BorderSizePixel = 0
	snap.BackgroundColor3 = Color3.new(1, 1, 1)
	snap.BackgroundTransparency = 0.4
	snap.Visible = false
	snap.Parent = tracerGui

	-- little readout under the circle: name | health | distance
	local infoL = Instance.new("TextLabel")
	infoL.AnchorPoint = Vector2.new(0.5, 0)
	infoL.Size = UDim2.fromOffset(260, 16)
	infoL.BackgroundTransparency = 1
	infoL.Font = Enum.Font.GothamBold
	infoL.TextSize = 12
	infoL.TextColor3 = Color3.new(1, 1, 1)
	infoL.TextStrokeTransparency = 0.5
	infoL.Visible = false
	infoL.Parent = tracerGui

	local lockedPlayer = nil
	local toggled = false

	local function fovColor()
		for _, c in ipairs(FIXED_COLORS) do
			if c[1] == aim.fovColor then return c[2] end
		end
		return Color3.new(1, 1, 1)
	end

	local function keyMatches(input)
		if aim.key == "RMB" then
			return input.UserInputType == Enum.UserInputType.MouseButton2
		end
		local ok, kc = pcall(function() return Enum.KeyCode[aim.key] end)
		return ok and kc ~= nil and input.KeyCode == kc
	end

	local function held()
		if aim.key == "RMB" then
			return UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
		end
		local ok, kc = pcall(function() return Enum.KeyCode[aim.key] end)
		return ok and kc and UIS:IsKeyDown(kc)
	end

	connect(UIS.InputBegan, function(input)
		if aim.mode ~= "Toggle" or UIS:GetFocusedTextBox() then return end
		if keyMatches(input) then
			toggled = not toggled
			if not toggled then lockedPlayer = nil end
		end
	end)

	local function active()
		if aim.mode == "Toggle" then return toggled end
		return held()
	end

	local function visibleTo(part, targetChar)
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Exclude
		params.FilterDescendantsInstances = {char, targetChar}
		local origin = camera.CFrame.Position
		return workspace:Raycast(origin, part.Position - origin, params) == nil
	end

	local PART_LIST = {"Head", "UpperTorso", "Torso", "HumanoidRootPart",
		"LeftUpperArm", "RightUpperArm", "LeftUpperLeg", "RightUpperLeg",
		"Left Arm", "Right Arm", "Left Leg", "Right Leg"}

	local function pickPart(c, mouse)
		if aim.part == "Closest" then
			local best, bd
			for _, n in ipairs(PART_LIST) do
				local p = c:FindFirstChild(n)
				if p and p:IsA("BasePart") then
					local sp, on = camera:WorldToViewportPoint(p.Position)
					if on then
						local d = (Vector2.new(sp.X, sp.Y) - mouse).Magnitude
						if not bd or d < bd then best, bd = p, d end
					end
				end
			end
			return best
		end
		if aim.part == "HumanoidRootPart" then
			return c:FindFirstChild("UpperTorso") or c:FindFirstChild("Torso") or c:FindFirstChild("HumanoidRootPart")
		end
		return c:FindFirstChild(aim.part) or c:FindFirstChild("HumanoidRootPart")
	end

	-- returns part, distance-from-cursor, humanoid when the player is a valid target
	local function evaluate(p, mouse, ignoreFov)
		if p == player then return end
		if aim.teamCheck and player.Team and p.Team == player.Team then return end
		local c = p.Character
		local h = c and c:FindFirstChildOfClass("Humanoid")
		if not (h and h.Health > 0) then return end
		local part = pickPart(c, mouse)
		if not part then return end
		if root and (part.Position - root.Position).Magnitude > aim.maxDist then return end
		local sp, on = camera:WorldToViewportPoint(part.Position)
		if not on then return end
		local d2 = (Vector2.new(sp.X, sp.Y) - mouse).Magnitude
		if not ignoreFov and d2 > aim.fov then return end
		if aim.wallCheck and not visibleTo(part, c) then return end
		return part, d2, h
	end

	local function getTarget(mouse)
		if aim.sticky and lockedPlayer then
			local part, _, h = evaluate(lockedPlayer, mouse, true)
			if part then return part, lockedPlayer, h end
			lockedPlayer = nil
		end
		local best, bestScore, bestP, bestH
		for _, p in ipairs(Players:GetPlayers()) do
			local part, d2, h = evaluate(p, mouse, false)
			if part then
				local score = d2
				if aim.priority == "Distance" and root then
					score = (part.Position - root.Position).Magnitude
				elseif aim.priority == "Health" then
					score = h.Health
				end
				if not bestScore or score < bestScore then
					best, bestScore, bestP, bestH = part, score, p, h
				end
			end
		end
		return best, bestP, bestH
	end

	pcall(function() RunService:UnbindFromRenderStep("NyxAim") end)
	RunService:BindToRenderStep("NyxAim", Enum.RenderPriority.Camera.Value + 1, function()
		local mouse = UIS:GetMouseLocation()
		circle.Visible = aim.on and aim.showFov
		if circle.Visible then
			circle.Size = UDim2.fromOffset(aim.fov * 2, aim.fov * 2)
			circle.Position = UDim2.fromOffset(mouse.X, mouse.Y)
			cs.Transparency = 1 - aim.fovAlpha
			cs.Color = fovColor()
		end
		snap.Visible, infoL.Visible = false, false
		if not aim.on or state.freecam or not root then lockedPlayer = nil return end
		if UIS:GetFocusedTextBox() or not active() then lockedPlayer = nil return end

		local part, p, h = getTarget(mouse)
		if not part then return end
		lockedPlayer = p

		local pos = part.Position
		if aim.predict then pos += part.AssemblyLinearVelocity * aim.predictAmt end
		if aim.humanize > 0 then
			pos += Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * aim.humanize * 1.5
		end
		local cf = camera.CFrame
		camera.CFrame = cf:Lerp(CFrame.lookAt(cf.Position, pos), math.clamp(aim.smooth, 0.02, 1))

		local sp = camera:WorldToViewportPoint(pos)
		if aim.snapline then
			local b2 = Vector2.new(sp.X, sp.Y)
			local d = b2 - mouse
			snap.Size = UDim2.fromOffset(d.Magnitude, 1)
			snap.Position = UDim2.fromOffset((mouse.X + b2.X) / 2, (mouse.Y + b2.Y) / 2)
			snap.Rotation = math.deg(math.atan2(d.Y, d.X))
			snap.BackgroundColor3 = fovColor()
			snap.Visible = true
		end
		if aim.targetInfo then
			local dist = root and math.floor((part.Position - root.Position).Magnitude) or 0
			infoL.Text = ("%s  |  %d HP  |  %dm"):format(p.DisplayName, math.floor(h.Health), dist)
			infoL.Position = UDim2.fromOffset(mouse.X, mouse.Y + aim.fov + 10)
			infoL.Visible = true
		end
	end)
	table.insert(conns, {Disconnect = function()
		pcall(function() RunService:UnbindFromRenderStep("NyxAim") end)
	end})
end

do
	local frame = Instance.new("Frame")
	frame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
	frame.BackgroundTransparency = 0.35
	frame.BorderSizePixel = 0
	frame.Visible = false
	frame.Parent = tracerGui
	local fc2 = Instance.new("UICorner")
	fc2.CornerRadius = UDim.new(1, 0)
	fc2.Parent = frame
	local fs = Instance.new("UIStroke")
	fs.Thickness = 2
	fs.Color = Color3.new(1, 1, 1)
	fs.Transparency = 0.5
	fs.Parent = frame
	local hLine = Instance.new("Frame")
	hLine.AnchorPoint = Vector2.new(0, 0.5)
	hLine.Position = UDim2.fromScale(0, 0.5)
	hLine.Size = UDim2.new(1, 0, 0, 1)
	hLine.BackgroundColor3 = Color3.new(1, 1, 1)
	hLine.BackgroundTransparency = 0.85
	hLine.BorderSizePixel = 0
	hLine.Parent = frame
	local vLine = Instance.new("Frame")
	vLine.AnchorPoint = Vector2.new(0.5, 0)
	vLine.Position = UDim2.fromScale(0.5, 0)
	vLine.Size = UDim2.new(0, 1, 1, 0)
	vLine.BackgroundColor3 = Color3.new(1, 1, 1)
	vLine.BackgroundTransparency = 0.85
	vLine.BorderSizePixel = 0
	vLine.Parent = frame
	local me = Instance.new("Frame")
	me.AnchorPoint = Vector2.new(0.5, 0.5)
	me.Position = UDim2.fromScale(0.5, 0.5)
	me.Size = UDim2.fromOffset(7, 7)
	me.BackgroundColor3 = Color3.new(1, 1, 1)
	me.BorderSizePixel = 0
	me.Parent = frame
	local mc = Instance.new("UICorner")
	mc.CornerRadius = UDim.new(1, 0)
	mc.Parent = me
	function radar.apply()
		local s = radar.size
		frame.Size = UDim2.fromOffset(s, s)
		local c = radar.corner
		if c == "Top Left" then
			frame.AnchorPoint = Vector2.new(0, 0)
			frame.Position = UDim2.new(0, 12, 0, 60)
		elseif c == "Bottom Left" then
			frame.AnchorPoint = Vector2.new(0, 1)
			frame.Position = UDim2.new(0, 12, 1, -12)
		elseif c == "Bottom Right" then
			frame.AnchorPoint = Vector2.new(1, 1)
			frame.Position = UDim2.new(1, -12, 1, -12)
		else
			frame.AnchorPoint = Vector2.new(1, 0)
			frame.Position = UDim2.new(1, -12, 0, 60)
		end
	end
	radar.apply()
	local dots = {}
	local lastFlat = CFrame.new()
	connect(Players.PlayerRemoving, function(p)
		if dots[p] then dots[p]:Destroy() dots[p] = nil end
	end)
	connect(RunService.RenderStepped, function()
		if not radar.on or not root then
			frame.Visible = false
			return
		end
		frame.Visible = true
		local look = camera.CFrame.LookVector
		local flat = Vector3.new(look.X, 0, look.Z)
		if flat.Magnitude > 0.01 then lastFlat = CFrame.lookAt(Vector3.zero, flat) end
		local rad = radar.size / 2 - 5
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player then
				local c = p.Character
				local r = c and c:FindFirstChild("HumanoidRootPart")
				local h = c and c:FindFirstChildOfClass("Humanoid")
				local dot = dots[p]
				local show = r and h and h.Health > 0
				if show and esp.hideTeam and player.Team and p.Team == player.Team then show = false end
				if show then
					if not dot then
						dot = Instance.new("Frame")
						dot.AnchorPoint = Vector2.new(0.5, 0.5)
						dot.Size = UDim2.fromOffset(6, 6)
						dot.BorderSizePixel = 0
						dot.Parent = frame
						local dc = Instance.new("UICorner")
						dc.CornerRadius = UDim.new(1, 0)
						dc.Parent = dot
						dots[p] = dot
					end
					local delta = r.Position - root.Position
					local rel = lastFlat:VectorToObjectSpace(Vector3.new(delta.X, 0, delta.Z))
					local v = Vector2.new(rel.X, rel.Z) / radar.range * rad
					local clamped = v.Magnitude > rad
					if clamped then v = v.Unit * rad end
					local ratio = math.clamp(h.Health / math.max(h.MaxHealth, 1), 0, 1)
					dot.Position = UDim2.new(0.5, v.X, 0.5, v.Y)
					dot.BackgroundColor3 = espColor(p, ratio, p.UserId % 13)
					dot.BackgroundTransparency = clamped and 0.6 or 0
					dot.Visible = true
				elseif dot then
					dot.Visible = false
				end
			end
		end
	end)
end

connect(RunService.RenderStepped, function()
	if not esp.on then
		for _, o in pairs(espObjects) do hideESP(o) end
		return
	end
	local vp = camera.ViewportSize
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			local o = espObjects[p] or createESP(p)
			local c = p.Character
			local r = c and c:FindFirstChild("HumanoidRootPart")
			local h = c and c:FindFirstChildOfClass("Humanoid")
			local show = r and h and h.Health > 0
			if show and esp.hideTeam and player.Team and p.Team == player.Team then
				show = false
			end
			local dist = 0
			if show and root then
				dist = (r.Position - root.Position).Magnitude
				if dist > esp.maxDist then show = false end
			end
			if not show then
				hideESP(o)
			else
				local ratio0 = math.clamp(h.Health / math.max(h.MaxHealth, 1), 0, 1)
				local color = espColor(p, ratio0, p.UserId % 13)
				local ratio = math.clamp(h.Health / math.max(h.MaxHealth, 1), 0, 1)
				local hpColor = Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(50, 255, 90), ratio)
				o.boxGui.Adornee = r
				o.boxGui.Enabled = esp.box or esp.health
				o.boxStroke.Color = color
				o.boxStroke.Enabled = esp.box
				o.boxStroke.Transparency = 1 - esp.boxAlpha
				o.hpBack.Visible = esp.health
				o.hpFill.Size = UDim2.fromScale(1, ratio)
				o.hpFill.BackgroundColor3 = hpColor
				o.topGui.Adornee = r
				o.topGui.Enabled = esp.name
				o.nameLabel.Text = p.DisplayName
				o.nameLabel.TextColor3 = color
				o.nameLabel.TextTransparency = 1 - esp.textAlpha
				local parts = {}
				if esp.health then table.insert(parts, math.floor(h.Health) .. " HP") end
				if esp.distance then table.insert(parts, math.floor(dist) .. "m") end
				if esp.item then
					local tool = c:FindFirstChildOfClass("Tool")
					if tool then table.insert(parts, tool.Name) end
				end
				o.botGui.Adornee = r
				o.botGui.Enabled = #parts > 0
				o.infoLabel.Text = table.concat(parts, "  |  ")
				o.infoLabel.TextColor3 = esp.health and hpColor or Color3.new(1, 1, 1)
				o.infoLabel.TextTransparency = 1 - esp.textAlpha
				o.hl.Adornee = c
				o.hl.Enabled = esp.chams
				o.hl.FillColor = color
				o.hl.OutlineColor = color
				o.hl.FillTransparency = 1 - esp.chamFill
				if esp.skeleton then
					drawSkeleton(o, c, color)
				else
					for _, f in ipairs(o.bones) do f.Visible = false end
				end
				if esp.tracers then
					local sp, onScreen = camera:WorldToViewportPoint(r.Position)
					if onScreen then
						local origin
						if esp.tracerOrigin == "Center" then
							origin = vp / 2
						elseif esp.tracerOrigin == "Mouse" then
							origin = UIS:GetMouseLocation()
						else
							origin = Vector2.new(vp.X / 2, vp.Y)
						end
						local target = Vector2.new(sp.X, sp.Y)
						local d = target - origin
						o.tracer.Size = UDim2.fromOffset(d.Magnitude, esp.tracerThick)
						o.tracer.Position = UDim2.fromOffset((origin.X + target.X) / 2, (origin.Y + target.Y) / 2)
						o.tracer.Rotation = math.deg(math.atan2(d.Y, d.X))
						o.tracer.BackgroundColor3 = color
						o.tracer.BackgroundTransparency = 1 - esp.tracerAlpha
						o.tracer.Visible = true
					else
						o.tracer.Visible = false
					end
				else
					o.tracer.Visible = false
				end
			end
		end
	end
end)

local busy = false
local function httpGet(url)
	local ok, res = pcall(function() return game:HttpGet(url) end)
	if ok and res then return res end
	local req = (syn and syn.request) or (http and http.request) or http_request or request
	if req then
		local ok2, r = pcall(function() return req({Url = url, Method = "GET"}) end)
		if ok2 and r and r.Body then return r.Body end
	end
	return nil
end

local function rejoin()
	if busy then return end
	busy = true
	if ui.queueLoader then ui.queueLoader() end
	setStatus("Rejoining...")
	if #Players:GetPlayers() <= 1 then
		player:Kick("\nRejoining...")
		task.wait()
		TeleportService:Teleport(game.PlaceId, player)
	else
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, player)
	end
	task.delay(10, function() busy = false end)
end

local function serverHop(mode)
	if busy then return end
	busy = true
	setStatus("Searching for a server...")
	task.spawn(function()
		local candidates = {}
		local cursor
		for _ = 1, 5 do
			local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100")
				:format(game.PlaceId)
			if cursor then url = url .. "&cursor=" .. cursor end
			local body = httpGet(url)
			if not body then break end
			local ok, data = pcall(function() return HttpService:JSONDecode(body) end)
			if not ok or type(data) ~= "table" or not data.data then break end
			for _, s in ipairs(data.data) do
				if s.id ~= game.JobId and s.playing and s.maxPlayers and s.playing < s.maxPlayers - 1 then
					table.insert(candidates, s)
				end
			end
			cursor = data.nextPageCursor
			if not cursor or (mode == "small" and #candidates > 0) then break end
		end
		if #candidates == 0 then
			setStatus("No other servers found")
			busy = false
			return
		end
		local pick
		if mode == "small" then
			table.sort(candidates, function(a, b) return a.playing < b.playing end)
			pick = candidates[1]
		else
			pick = candidates[math.random(#candidates)]
		end
		if ui.queueLoader then ui.queueLoader() end
		setStatus(("Hopping (%d/%d players)..."):format(pick.playing, pick.maxPlayers))
		local ok = pcall(function()
			TeleportService:TeleportToPlaceInstance(game.PlaceId, pick.id, player)
		end)
		if not ok then setStatus("Teleport failed") end
		task.delay(10, function() busy = false end)
	end)
end

local function joinJob(id)
	id = (id or ""):gsub("%s", "")
	if id == "" then setStatus("Enter a Job ID first") return end
	if busy then return end
	busy = true
	if ui.queueLoader then ui.queueLoader() end
	setStatus("Joining server...")
	local ok = pcall(function()
		TeleportService:TeleportToPlaceInstance(game.PlaceId, id, player)
	end)
	if not ok then setStatus("Teleport failed") end
	task.delay(10, function() busy = false end)
end

connect(TeleportService.TeleportInitFailed, function()
	busy = false
	setStatus("Teleport failed, try again")
end)

local C = {
	bg = Color3.fromRGB(18, 18, 19),
	panel = Color3.fromRGB(23, 23, 25),
	elem = Color3.fromRGB(30, 30, 33),
	input = Color3.fromRGB(21, 21, 23),
	off = Color3.fromRGB(62, 62, 66),
	line = Color3.fromRGB(40, 40, 44),
	accent = Color3.fromRGB(112, 92, 255),
	danger = Color3.fromRGB(190, 60, 70),
	text = Color3.new(1, 1, 1),
	sub = Color3.fromRGB(150, 150, 158),
}

local function tween(obj, t, props, style, dir)
	local tw = TweenService:Create(obj,
		TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props)
	tw:Play()
	return tw
end

local function corner(obj, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 8)
	c.Parent = obj
end

local function padding(obj, l, t, r, b)
	local p = Instance.new("UIPadding")
	p.PaddingLeft = UDim.new(0, l or 0)
	p.PaddingTop = UDim.new(0, t or 0)
	p.PaddingRight = UDim.new(0, r or 0)
	p.PaddingBottom = UDim.new(0, b or 0)
	p.Parent = obj
end

local function capText(obj, max)
	local c = Instance.new("UITextSizeConstraint")
	c.MaxTextSize = max or 14
	c.MinTextSize = 8
	c.Parent = obj
end

local function decorate(b, base)
	base = base or C.elem
	b.AutoButtonColor = false
	b.BorderSizePixel = 0
	b.BackgroundColor3 = base
	b:SetAttribute("base", base)
	corner(b, 10)
	local sc = Instance.new("UIScale")
	sc.Parent = b
	b.MouseEnter:Connect(function()
		tween(b, 0.12, {BackgroundColor3 = b:GetAttribute("base"):Lerp(Color3.new(1, 1, 1), 0.12)})
	end)
	b.MouseLeave:Connect(function()
		tween(b, 0.12, {BackgroundColor3 = b:GetAttribute("base")})
		tween(sc, 0.1, {Scale = 1})
	end)
	b.MouseButton1Down:Connect(function()
		tween(sc, 0.08, {Scale = 0.96})
	end)
	b.MouseButton1Up:Connect(function()
		tween(sc, 0.15, {Scale = 1}, Enum.EasingStyle.Back)
	end)
end

-- flat rows (toggles / plain buttons): see-through until hovered, with the same press squish
local function flatRow(b)
	b.AutoButtonColor = false
	b.BorderSizePixel = 0
	b.BackgroundColor3 = C.elem
	b.BackgroundTransparency = 1
	corner(b, 10)
	local sc = Instance.new("UIScale")
	sc.Parent = b
	b.MouseEnter:Connect(function()
		tween(b, 0.12, {BackgroundTransparency = 0.45})
	end)
	b.MouseLeave:Connect(function()
		tween(b, 0.12, {BackgroundTransparency = 1})
		tween(sc, 0.1, {Scale = 1})
	end)
	b.MouseButton1Down:Connect(function()
		tween(sc, 0.08, {Scale = 0.97})
	end)
	b.MouseButton1Up:Connect(function()
		tween(sc, 0.15, {Scale = 1}, Enum.EasingStyle.Back)
	end)
end

local function setBase(b, color)
	b:SetAttribute("base", color)
	tween(b, 0.15, {BackgroundColor3 = color})
end

local function makeIcon(parent, icon)
	if string.find(icon, "^rbxassetid://") then
		local i = Instance.new("ImageLabel")
		i.BackgroundTransparency = 1
		i.AnchorPoint = Vector2.new(0.5, 0.5)
		i.Position = UDim2.fromScale(0.5, 0.5)
		i.Size = UDim2.fromOffset(20, 20)
		i.Image = icon
		i.ImageColor3 = C.sub
		i.Parent = parent
		return i
	else
		local l = Instance.new("TextLabel")
		l.BackgroundTransparency = 1
		l.Size = UDim2.fromScale(1, 1)
		l.Text = icon
		l.TextSize = 18
		l.Font = Enum.Font.GothamBold
		l.TextColor3 = C.text
		l.TextTransparency = 0.45
		l.Parent = parent
		return l
	end
end

local loopTweens = {}
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.fromOffset(46, 46)
openBtn.Position = UDim2.new(0, 14, 0.5, -23)
openBtn.Text = "≡"
openBtn.TextSize = 26
openBtn.Font = Enum.Font.GothamBold
openBtn.TextColor3 = C.text
openBtn.Parent = gui
decorate(openBtn, C.elem)
corner(openBtn, 23)
local openMoved = false
local openStroke
do
	openStroke = Instance.new("UIStroke")
	openStroke.Thickness = 1
	openStroke.Color = C.line
	openStroke.Transparency = 0
	openStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	openStroke.Parent = openBtn
	local down, origin, startPos2
	openBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
			down = true
			openMoved = false
			origin = input.Position
			startPos2 = openBtn.Position
		end
	end)
	connect(UIS.InputChanged, function(input)
		if down and (input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch) then
			local d = input.Position - origin
			if d.Magnitude > 6 then openMoved = true end
			if openMoved then
				openBtn.Position = UDim2.new(startPos2.X.Scale, startPos2.X.Offset + d.X,
				startPos2.Y.Scale, startPos2.Y.Offset + d.Y)
			end
		end
	end)
	connect(UIS.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
			down = false
		end
	end)
end

-- ======================
-- WINDOW  (sidebar on the left, header + page on the right)
-- ======================
local SIDEBAR_W, HEADER_H = 156, 46
local PAGE_X, PAGE_Y = SIDEBAR_W + 14, HEADER_H + 10

local hub = Instance.new("CanvasGroup")
hub.AnchorPoint = Vector2.new(0.5, 0.5)
hub.Size = UDim2.fromScale(0.56, 0.78)
hub.Position = UDim2.fromScale(0.5, 0.5)
hub.BackgroundColor3 = C.bg
hub.BorderSizePixel = 0
hub.GroupTransparency = 1
hub.Visible = false
hub.Parent = gui
corner(hub, 18)
local function applyGradient() end
do
	local hubStroke = Instance.new("UIStroke")
	hubStroke.Thickness = 1
	hubStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	hubStroke.Color = C.line
	hubStroke.Parent = hub
end

local hubScale = Instance.new("UIScale")
hubScale.Scale = 0.88
hubScale.Parent = hub
do
	local lim = Instance.new("UISizeConstraint")
	lim.MinSize = Vector2.new(520, 320)
	lim.MaxSize = Vector2.new(700, 520)
	lim.Parent = hub
end

-- left column
local side = Instance.new("Frame")
side.Name = "Side"
side.Size = UDim2.new(0, SIDEBAR_W, 1, 0)
side.BackgroundColor3 = Color3.fromRGB(14, 14, 15)
side.BorderSizePixel = 0
side.Parent = hub

local sideLine = Instance.new("Frame")
sideLine.Position = UDim2.fromOffset(SIDEBAR_W, 0)
sideLine.Size = UDim2.new(0, 1, 1, 0)
sideLine.BackgroundColor3 = C.line
sideLine.BackgroundTransparency = 0
sideLine.BorderSizePixel = 0
sideLine.Parent = hub

local brandTop = Instance.new("Frame")
brandTop.Size = UDim2.new(1, 0, 0, 84)
brandTop.BackgroundTransparency = 1
brandTop.Parent = side

local function dotBtn(x, color)
	local d = Instance.new("TextButton")
	d.Size = UDim2.fromOffset(12, 12)
	d.Position = UDim2.fromOffset(x, 12)
	d.Text = ""
	d.AutoButtonColor = false
	d.BackgroundColor3 = color
	d.BorderSizePixel = 0
	d.Parent = brandTop
	corner(d, 6)
	return d
end
local closeBtn = dotBtn(14, Color3.fromRGB(255, 95, 87))
local minBtn = dotBtn(32, Color3.fromRGB(254, 188, 46))
dotBtn(50, Color3.fromRGB(44, 44, 50))

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -56, 0, 22)
title.Position = UDim2.fromOffset(16, 32)
title.BackgroundTransparency = 1
title.Text = "Nyx Hub"
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextColor3 = C.text
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = brandTop

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, -16, 0, 14)
subTitle.Position = UDim2.fromOffset(16, 56)
subTitle.BackgroundTransparency = 1
subTitle.Text = "discord.gg/FpMNg4fJz9"
subTitle.TextSize = 10
subTitle.Font = Enum.Font.GothamMedium
subTitle.TextColor3 = C.sub
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Parent = brandTop

local globeBtn = Instance.new("TextButton")
globeBtn.AnchorPoint = Vector2.new(1, 0)
globeBtn.Position = UDim2.new(1, -12, 0, 32)
globeBtn.Size = UDim2.fromOffset(24, 24)
globeBtn.BackgroundTransparency = 1
globeBtn.Text = "\u{1F310}"
globeBtn.TextSize = 18
globeBtn.Font = Enum.Font.GothamBold
globeBtn.TextColor3 = C.text
globeBtn.TextTransparency = 0.3
globeBtn.Parent = brandTop
globeBtn.MouseEnter:Connect(function() tween(globeBtn, 0.12, {TextTransparency = 0}) end)
globeBtn.MouseLeave:Connect(function() tween(globeBtn, 0.12, {TextTransparency = 0.3}) end)
globeBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard("https://discord.gg/FpMNg4fJz9")
		setStatus("Discord invite copied")
	else
		setStatus("discord.gg/FpMNg4fJz9")
	end
end)

local brandLine = Instance.new("Frame")
brandLine.Position = UDim2.fromOffset(0, 84)
brandLine.Size = UDim2.new(1, 0, 0, 1)
brandLine.BackgroundColor3 = C.line
brandLine.BackgroundTransparency = 0
brandLine.BorderSizePixel = 0
brandLine.Parent = side

-- tab list
local sidebar = Instance.new("ScrollingFrame")
sidebar.Size = UDim2.new(1, -16, 1, -(92 + 68))
sidebar.Position = UDim2.fromOffset(8, 92)
sidebar.BackgroundTransparency = 1
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 0
sidebar.CanvasSize = UDim2.new()
sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
sidebar.Parent = side
padding(sidebar, 0, 2, 0, 2)
do
	local sl = Instance.new("UIListLayout")
	sl.Padding = UDim.new(0, 4)
	sl.SortOrder = Enum.SortOrder.LayoutOrder
	sl.HorizontalAlignment = Enum.HorizontalAlignment.Center
	sl.Parent = sidebar
end

-- profile card at the bottom: always the person running the script
local profile = Instance.new("Frame")
profile.AnchorPoint = Vector2.new(0, 1)
profile.Position = UDim2.fromScale(0, 1)
profile.Size = UDim2.new(1, 0, 0, 64)
profile.BackgroundTransparency = 1
profile.Parent = side
do
	local pl = Instance.new("Frame")
	pl.Size = UDim2.new(1, 0, 0, 1)
	pl.BackgroundColor3 = C.line
	pl.BackgroundTransparency = 0
	pl.BorderSizePixel = 0
	pl.Parent = profile

	local av = Instance.new("ImageLabel")
	av.Position = UDim2.fromOffset(14, 14)
	av.Size = UDim2.fromOffset(38, 38)
	av.BackgroundColor3 = C.elem
	av.BorderSizePixel = 0
	av.Parent = profile
	corner(av, 19)
	task.spawn(function()
		local ok, img = pcall(function()
			return Players:GetUserThumbnailAsync(player.UserId,
				Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
		end)
		if ok and av.Parent then av.Image = img end
	end)

	local nm = Instance.new("TextLabel")
	nm.Position = UDim2.fromOffset(60, 15)
	nm.Size = UDim2.new(1, -66, 0, 18)
	nm.BackgroundTransparency = 1
	nm.Text = player.DisplayName
	nm.TextSize = 14
	nm.Font = Enum.Font.GothamBold
	nm.TextColor3 = C.text
	nm.TextXAlignment = Enum.TextXAlignment.Left
	nm.TextTruncate = Enum.TextTruncate.AtEnd
	nm.Parent = profile

	local un = Instance.new("TextLabel")
	un.Position = UDim2.fromOffset(60, 33)
	un.Size = UDim2.new(1, -66, 0, 16)
	un.BackgroundTransparency = 1
	un.Text = "@" .. player.Name
	un.TextSize = 11
	un.Font = Enum.Font.GothamMedium
	un.TextColor3 = C.sub
	un.TextXAlignment = Enum.TextXAlignment.Left
	un.TextTruncate = Enum.TextTruncate.AtEnd
	un.Parent = profile
end

-- header on the right (page title, search, move handle)
local header = Instance.new("Frame")
header.Position = UDim2.fromOffset(SIDEBAR_W + 1, 0)
header.Size = UDim2.new(1, -(SIDEBAR_W + 1), 0, HEADER_H)
header.BackgroundTransparency = 1
header.Parent = hub

local headerLine = Instance.new("Frame")
headerLine.AnchorPoint = Vector2.new(0, 1)
headerLine.Position = UDim2.fromScale(0, 1)
headerLine.Size = UDim2.new(1, 0, 0, 1)
headerLine.BackgroundColor3 = C.line
headerLine.BackgroundTransparency = 0
headerLine.BorderSizePixel = 0
headerLine.Parent = header

local pageTitle = Instance.new("TextLabel")
pageTitle.Size = UDim2.new(0, 130, 1, 0)
pageTitle.Position = UDim2.fromOffset(16, 0)
pageTitle.BackgroundTransparency = 1
pageTitle.Text = ""
pageTitle.TextSize = 15
pageTitle.Font = Enum.Font.GothamBold
pageTitle.TextColor3 = C.text
pageTitle.TextXAlignment = Enum.TextXAlignment.Left
pageTitle.Parent = header

-- little four-way arrow (drag handle hint), drawn from frames so it never shows a missing glyph
do
	local mv = Instance.new("Frame")
	mv.AnchorPoint = Vector2.new(1, 0.5)
	mv.Position = UDim2.new(1, -16, 0.5, 0)
	mv.Size = UDim2.fromOffset(16, 16)
	mv.BackgroundTransparency = 1
	mv.Parent = header
	local function part(w, h, x, y, rot)
		local f = Instance.new("Frame")
		f.AnchorPoint = Vector2.new(0.5, 0.5)
		f.Position = UDim2.fromOffset(x, y)
		f.Size = UDim2.fromOffset(w, h)
		f.Rotation = rot or 0
		f.BackgroundColor3 = C.sub
		f.BorderSizePixel = 0
		f.Parent = mv
	end
	part(14, 2, 8, 8)
	part(2, 14, 8, 8)
	part(4, 4, 8, 1, 45)
	part(4, 4, 8, 15, 45)
	part(4, 4, 1, 8, 45)
	part(4, 4, 15, 8, 45)
end

-- drag the window by the header or the brand area
do
	local function makeDraggable(handle)
		local dragging, dragStart, startPos
		handle.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch
					or input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				dragStart = input.Position
				startPos = hub.Position
			end
		end)
		connect(UIS.InputChanged, function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.Touch
					or input.UserInputType == Enum.UserInputType.MouseMovement) then
				local d = input.Position - dragStart
				hub.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
				startPos.Y.Scale, startPos.Y.Offset + d.Y)
			end
		end)
		connect(UIS.InputEnded, function(input)
			if input.UserInputType == Enum.UserInputType.Touch
					or input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)
	end
	makeDraggable(header)
	makeDraggable(brandTop)
end

local tabs = {}
local currentTab
local function showTab(id)
	for k, t in pairs(tabs) do
		local sel = (k == id)
		if not sel then t.page.Visible = false end
		t.sel = sel
		tween(t.btn, 0.2, {BackgroundTransparency = sel and 0 or 1})
		tween(t.lbl, 0.2, {TextColor3 = sel and C.text or C.sub})
		if t.ico:IsA("ImageLabel") then
			tween(t.ico, 0.2, {ImageColor3 = sel and C.text or C.sub})
		else
			tween(t.ico, 0.2, {TextTransparency = sel and 0 or 0.45})
		end
	end
	local t = tabs[id]
	if currentTab ~= id then
		t.page.Visible = true
		local sc = t.btn:FindFirstChildOfClass("UIScale")
		if sc then
			sc.Scale = 0.92
			tween(sc, 0.35, {Scale = 1}, Enum.EasingStyle.Back)
		end
		t.page.GroupTransparency = 1
		t.page.Position = UDim2.fromOffset(PAGE_X, PAGE_Y + 10)
		tween(t.page, 0.25, {GroupTransparency = 0, Position = UDim2.fromOffset(PAGE_X, PAGE_Y)})
		local plist = t.page:FindFirstChildWhichIsA("ScrollingFrame")
		if plist then
			local n = 0
			for _, g in ipairs(plist:GetChildren()) do
				local pop = g:FindFirstChild("PopScale")
				if pop then
					n += 1
					pop.Scale = 0.93
					task.delay((n - 1) * 0.045, function()
						tween(pop, 0.35, {Scale = 1}, Enum.EasingStyle.Back)
					end)
				end
			end
		end
	end
	currentTab = id
	pageTitle.Text = t.title
	if ui.clearSearch then ui.clearSearch() end
end

local function addTab(id, icon, label, layoutOrder)
	if label ~= "ESP" then label = label:sub(1, 1) .. label:sub(2):lower() end
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, 0, 0, 34)
	b.Text = ""
	b.LayoutOrder = layoutOrder
	b.AutoButtonColor = false
	b.BorderSizePixel = 0
	b.BackgroundColor3 = C.elem
	b.BackgroundTransparency = 1
	b.Parent = sidebar
	corner(b, 11)
	local sc = Instance.new("UIScale")
	sc.Parent = b
	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.Position = UDim2.fromOffset(6, 0)
	holder.Size = UDim2.fromOffset(28, 34)
	holder.Parent = b
	local ico = makeIcon(holder, icon)
	local lbl = Instance.new("TextLabel")
	lbl.BackgroundTransparency = 1
	lbl.Position = UDim2.fromOffset(38, 0)
	lbl.Size = UDim2.new(1, -44, 1, 0)
	lbl.Text = label
	lbl.TextSize = 14
	lbl.Font = Enum.Font.GothamMedium
	lbl.TextColor3 = C.sub
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Parent = b
	local page = Instance.new("CanvasGroup")
	page.Size = UDim2.new(1, -(PAGE_X + 12), 1, -(PAGE_Y + 40))
	page.Position = UDim2.fromOffset(PAGE_X, PAGE_Y)
	page.BackgroundTransparency = 1
	page.Visible = false
	page.Parent = hub
	tabs[id] = {btn = b, page = page, title = label, icon = icon, ico = ico, lbl = lbl, sel = false}
	b.MouseButton1Click:Connect(function() showTab(id) end)
	b.MouseEnter:Connect(function()
		if not tabs[id].sel then tween(b, 0.12, {BackgroundTransparency = 0.7}) end
	end)
	b.MouseLeave:Connect(function()
		if not tabs[id].sel then tween(b, 0.12, {BackgroundTransparency = 1}) end
		tween(sc, 0.1, {Scale = 1})
	end)
	b.MouseButton1Down:Connect(function() tween(sc, 0.08, {Scale = 0.96}) end)
	b.MouseButton1Up:Connect(function() tween(sc, 0.15, {Scale = 1}, Enum.EasingStyle.Back) end)
	return page
end

local function addDivider(layoutOrder)
	local d = Instance.new("Frame")
	d.Size = UDim2.new(1, -12, 0, 1)
	d.BackgroundColor3 = C.line
	d.BackgroundTransparency = 0
	d.BorderSizePixel = 0
	d.LayoutOrder = layoutOrder
	d.Parent = sidebar
end

local function makeList(parent)
	local l = Instance.new("ScrollingFrame")
	l.Size = UDim2.fromScale(1, 1)
	l.BackgroundTransparency = 1
	l.BorderSizePixel = 0
	l.ScrollBarThickness = 3
	l.ScrollBarImageColor3 = C.accent
	l.CanvasSize = UDim2.new()
	l.AutomaticCanvasSize = Enum.AutomaticSize.Y
	l.Parent = parent
	local pad = Instance.new("UIPadding")
	pad.PaddingRight = UDim.new(0, 6)
	pad.PaddingBottom = UDim.new(0, 6)
	pad.Parent = l
	local lay = Instance.new("UIListLayout")
	lay.Padding = UDim.new(0, 8)
	lay.SortOrder = Enum.SortOrder.LayoutOrder
	lay.Parent = l
	return l
end

-- settings search (lives in the header; results cover the page area)
do
	local sbox = Instance.new("Frame")
	sbox.AnchorPoint = Vector2.new(1, 0.5)
	sbox.Position = UDim2.new(1, -46, 0.5, 0)
	sbox.Size = UDim2.fromOffset(160, 28)
	sbox.BackgroundColor3 = C.elem
	sbox.BorderSizePixel = 0
	sbox.Parent = header
	corner(sbox, 14)
	local sstroke = Instance.new("UIStroke")
	sstroke.Color = C.accent
	sstroke.Thickness = 1.3
	sstroke.Transparency = 1
	sstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	sstroke.Parent = sbox
	local ico = Instance.new("TextLabel")
	ico.Size = UDim2.new(0, 26, 1, 0)
	ico.Position = UDim2.fromOffset(4, 0)
	ico.BackgroundTransparency = 1
	ico.Text = "\u{1F50D}"
	ico.TextSize = 13
	ico.Font = Enum.Font.GothamBold
	ico.TextColor3 = C.sub
	ico.Parent = sbox
	local tb = Instance.new("TextBox")
	tb.Position = UDim2.fromOffset(28, 0)
	tb.Size = UDim2.new(1, -52, 1, 0)
	tb.BackgroundTransparency = 1
	tb.PlaceholderText = "Search...  ( / )"
	tb.PlaceholderColor3 = Color3.fromRGB(110, 110, 130)
	tb.Text = ""
	tb.ClearTextOnFocus = false
	tb.TextSize = 13
	tb.Font = Enum.Font.GothamMedium
	tb.TextColor3 = C.text
	tb.TextXAlignment = Enum.TextXAlignment.Left
	tb.ClipsDescendants = true
	tb.Parent = sbox
	local clr = Instance.new("TextButton")
	clr.AnchorPoint = Vector2.new(1, 0.5)
	clr.Position = UDim2.new(1, -5, 0.5, 0)
	clr.Size = UDim2.fromOffset(20, 20)
	clr.BackgroundTransparency = 1
	clr.Text = "\u{00D7}"
	clr.TextSize = 18
	clr.Font = Enum.Font.GothamBold
	clr.TextColor3 = C.sub
	clr.Visible = false
	clr.Parent = sbox
	local results = Instance.new("ScrollingFrame")
	results.Position = UDim2.fromOffset(PAGE_X, PAGE_Y)
	results.Size = UDim2.new(1, -(PAGE_X + 12), 1, -(PAGE_Y + 40))
	results.BackgroundColor3 = C.bg
	results.BorderSizePixel = 0
	results.ScrollBarThickness = 3
	results.ScrollBarImageColor3 = C.accent
	results.CanvasSize = UDim2.new()
	results.AutomaticCanvasSize = Enum.AutomaticSize.Y
	results.Visible = false
	results.ZIndex = 10
	results.Parent = hub
	local rpad = Instance.new("UIPadding")
	rpad.PaddingRight = UDim.new(0, 6)
	rpad.PaddingBottom = UDim.new(0, 6)
	rpad.Parent = results
	local rlay = Instance.new("UIListLayout")
	rlay.Padding = UDim.new(0, 6)
	rlay.SortOrder = Enum.SortOrder.LayoutOrder
	rlay.Parent = results
	local function titleFor(t)
		return t.title
	end
	local function tabOf(inst)
		local p = inst
		while p and p ~= hub do
			for id, t in pairs(tabs) do
				if t.page == p then return id end
			end
			p = p.Parent
		end
	end
	local function listOf(inst)
		local p = inst.Parent
		while p and p ~= hub do
			if p:IsA("ScrollingFrame") then return p end
			p = p.Parent
		end
	end
	local function flash(row)
		local st = Instance.new("UIStroke")
		st.Color = C.accent
		st.Thickness = 2.5
		st.Transparency = 0
		st.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		st.Parent = row
		local tw = tween(st, 1.3, {Transparency = 1})
		tw.Completed:Connect(function() st:Destroy() end)
	end
	local function jumpTo(entry)
		local row = entry.row
		local id = tabOf(row)
		if not id then return end
		tb.Text = ""
		local pp = row
		while pp and pp ~= hub do
			local openFn = ui.groupMap[pp]
			if openFn then openFn(true, true) end
			pp = pp.Parent
		end
		showTab(id)
		task.delay(0.3, function()
			if not row.Parent then return end
			local list = listOf(row)
			if list then
				local y = (row.AbsolutePosition.Y - list.AbsolutePosition.Y) / hubScale.Scale
				+ list.CanvasPosition.Y - 10
				list.CanvasPosition = Vector2.new(0, math.max(y, 0))
			end
			flash(row)
		end)
	end
	local shown, firstEntry = {}, nil
	local function render(q)
		for _, r in ipairs(shown) do r:Destroy() end
		shown, firstEntry = {}, nil
		local tokens = {}
		for w in string.gmatch(string.lower(q), "%S+") do table.insert(tokens, w) end
		local n = 0
		for _, e in ipairs(ui.registry) do
			if n >= 40 then break end
			local row = e.row
			if row and row.Parent then
				local id = tabOf(row)
				if id then
					local text = e.name
					if not e.group and row:IsA("TextButton") and row.Text ~= "" then text = row.Text end
					local hay = string.lower(text .. " " .. tabs[id].title)
					local ok = true
					for _, w in ipairs(tokens) do
						if not string.find(hay, w, 1, true) then ok = false break end
					end
					if ok then
						n += 1
						firstEntry = firstEntry or e
						local b = Instance.new("TextButton")
						b.Size = UDim2.new(1, 0, 0, 36)
						b.Text = ""
						b.LayoutOrder = n
						b.ZIndex = 11
						b.Parent = results
						decorate(b, C.elem)
						local nl = Instance.new("TextLabel")
						nl.Size = UDim2.new(1, -118, 1, 0)
						nl.Position = UDim2.fromOffset(12, 0)
						nl.BackgroundTransparency = 1
						nl.Text = text
						nl.TextSize = 13
						nl.Font = e.group and Enum.Font.GothamBold or Enum.Font.GothamMedium
						nl.TextColor3 = e.group and C.accent or C.text
						nl.TextXAlignment = Enum.TextXAlignment.Left
						nl.TextTruncate = Enum.TextTruncate.AtEnd
						nl.ZIndex = 12
						nl.Parent = b
						local wl = Instance.new("TextLabel")
						wl.AnchorPoint = Vector2.new(1, 0)
						wl.Position = UDim2.new(1, -10, 0, 0)
						wl.Size = UDim2.new(0, 100, 1, 0)
						wl.BackgroundTransparency = 1
						wl.Text = tabs[id].title
						wl.TextSize = 11
						wl.Font = Enum.Font.GothamBold
						wl.TextColor3 = C.sub
						wl.TextXAlignment = Enum.TextXAlignment.Right
						wl.ZIndex = 12
						wl.Parent = b
						b.MouseButton1Click:Connect(function() jumpTo(e) end)
						table.insert(shown, b)
					end
				end
			end
		end
		if n == 0 then
			local l = Instance.new("TextLabel")
			l.Size = UDim2.new(1, 0, 0, 40)
			l.BackgroundTransparency = 1
			l.Text = 'No settings match "' .. q .. '"'
			l.TextSize = 13
			l.Font = Enum.Font.GothamMedium
			l.TextColor3 = C.sub
			l.ZIndex = 11
			l.Parent = results
			table.insert(shown, l)
		end
	end
	tb:GetPropertyChangedSignal("Text"):Connect(function()
		local q = tb.Text
		clr.Visible = q ~= ""
		if string.match(q, "^%s*$") then
			results.Visible = false
			local t = tabs[currentTab]
			if t then pageTitle.Text = titleFor(t) end
		else
			results.Visible = true
			results.CanvasPosition = Vector2.zero
			pageTitle.Text = "Search"
			render(q)
		end
	end)
	tb.Focused:Connect(function() tween(sstroke, 0.15, {Transparency = 0}) end)
	tb.FocusLost:Connect(function(enter)
		tween(sstroke, 0.2, {Transparency = 1})
		if enter and firstEntry then jumpTo(firstEntry) end
	end)
	clr.MouseButton1Click:Connect(function() tb.Text = "" end)
	ui.clearSearch = function() if tb.Text ~= "" then tb.Text = "" end end
	ui.setSearch = function(q) tb.Text = q or "" end
	ui.focusSearch = function()
		tb:CaptureFocus()
		task.defer(function() tb.Text = "" end)
		task.delay(0.05, function() if tb.Text == "/" then tb.Text = "" end end)
	end
end

local notifGui = Instance.new("ScreenGui")
notifGui.Name = "NyxNotifs"
notifGui.ResetOnSpawn = false
notifGui.IgnoreGuiInset = true
notifGui.DisplayOrder = 50
notifGui.Parent = guiParent
local notify
do
	local holder = Instance.new("Frame")
	holder.AnchorPoint = Vector2.new(1, 1)
	holder.Position = UDim2.new(1, -14, 1, -14)
	holder.Size = UDim2.fromOffset(250, 320)
	holder.BackgroundTransparency = 1
	holder.Parent = notifGui
	local lay = Instance.new("UIListLayout")
	lay.Padding = UDim.new(0, 6)
	lay.SortOrder = Enum.SortOrder.LayoutOrder
	lay.VerticalAlignment = Enum.VerticalAlignment.Bottom
	lay.Parent = holder
	local KINDS = {
		info = {"\u{2139}\u{FE0F}", C.accent},
		ok = {"\u{2705}", Color3.fromRGB(60, 200, 110)},
		warn = {"\u{26A0}\u{FE0F}", Color3.fromRGB(255, 190, 60)},
		err = {"\u{274C}", C.danger},
	}
	local count = 0
	notify = function(titleText, body, kind)
		local k = KINDS[kind or "info"] or KINDS.info
		count += 1
		local wrap = Instance.new("Frame")
		wrap.Size = UDim2.new(1, 0, 0, 46)
		wrap.BackgroundTransparency = 1
		wrap.LayoutOrder = count
		wrap.Parent = holder
		local card = Instance.new("Frame")
		card.Size = UDim2.fromScale(1, 1)
		card.Position = UDim2.fromScale(1.2, 0)
		card.BackgroundColor3 = C.panel
		card.BorderSizePixel = 0
		card.Parent = wrap
		corner(card, 10)
		local stroke = Instance.new("UIStroke")
		stroke.Color = k[2]
		stroke.Thickness = 1.5
		stroke.Transparency = 0.4
		stroke.Parent = card
		local icon = Instance.new("TextLabel")
		icon.Size = UDim2.new(0, 40, 1, 0)
		icon.BackgroundTransparency = 1
		icon.Text = k[1]
		icon.TextSize = 20
		icon.Font = Enum.Font.GothamBold
		icon.TextColor3 = C.text
		icon.Parent = card
		local t1 = Instance.new("TextLabel")
		t1.Size = UDim2.new(1, -48, 0, 18)
		t1.Position = UDim2.fromOffset(44, 6)
		t1.BackgroundTransparency = 1
		t1.Text = titleText or ""
		t1.TextSize = 13
		t1.Font = Enum.Font.GothamBold
		t1.TextColor3 = C.text
		t1.TextXAlignment = Enum.TextXAlignment.Left
		t1.TextTruncate = Enum.TextTruncate.AtEnd
		t1.Parent = card
		local t2 = Instance.new("TextLabel")
		t2.Size = UDim2.new(1, -48, 0, 16)
		t2.Position = UDim2.fromOffset(44, 24)
		t2.BackgroundTransparency = 1
		t2.Text = body or ""
		t2.TextSize = 12
		t2.Font = Enum.Font.GothamMedium
		t2.TextColor3 = C.sub
		t2.TextXAlignment = Enum.TextXAlignment.Left
		t2.TextTruncate = Enum.TextTruncate.AtEnd
		t2.Parent = card
		tween(card, 0.35, {Position = UDim2.fromScale(0, 0)}, Enum.EasingStyle.Back)
		task.delay(3.2, function()
			if not card.Parent then return end
			local tw = tween(card, 0.3, {Position = UDim2.fromScale(1.2, 0)},
			Enum.EasingStyle.Quad, Enum.EasingDirection.In)
			tw.Completed:Connect(function() wrap:Destroy() end)
		end)
	end
end

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -(PAGE_X + 12), 0, 26)
statusLabel.Position = UDim2.new(0, PAGE_X, 1, -34)
statusLabel.BackgroundColor3 = C.panel
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextSize = 13
statusLabel.Font = Enum.Font.GothamMedium
statusLabel.TextColor3 = C.sub
statusLabel.TextTransparency = 1
statusLabel.ZIndex = 5
statusLabel.Parent = hub
corner(statusLabel, 8)
do
	local statusToken = 0
	setStatus = function(text)
		statusToken += 1
		local my = statusToken
		statusLabel.Text = text
		if not hub.Visible then notify("Nyx Hub", text) end
		tween(statusLabel, 0.2, {TextTransparency = 0, BackgroundTransparency = 0})
		task.delay(3, function()
			if statusToken == my then
				tween(statusLabel, 0.3, {TextTransparency = 1, BackgroundTransparency = 1})
			end
		end)
	end
end

local inputs = {}
local sliderMove
connect(UIS.InputChanged, function(input)
	if sliderMove and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
		sliderMove(input.Position.X)
	end
end)

connect(UIS.InputEnded, function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
		sliderMove = nil
	end
end)

local function titleCase(str)
	str = str:lower():gsub("(%a)([%w']*)", function(a, r) return a:upper() .. r end)
	str = str:gsub("Afk", "AFK"):gsub("Esp", "ESP"):gsub("Hud", "HUD")
	return str
end

local function builder(parent, nosearch)
	local order = 0
	local groupCount = 0
	local function nx() order += 1 return order end
	local function register(name, row, group)
		if nosearch or not name or name == "" then return end
		table.insert(ui.registry, {name = name, row = row, group = group})
	end
	local B = {}
	-- a card whose header opens / closes its rows (first group on each page starts open)
	function B.group(titleText)
		groupCount += 1
		local open = (groupCount == 1)
		local shown = titleCase((titleText:gsub("^[^%w]+", "")))
		local f = Instance.new("Frame")
		f.Size = UDim2.new(1, 0, 0, 0)
		f.AutomaticSize = Enum.AutomaticSize.Y
		f.BackgroundColor3 = C.panel
		f.BorderSizePixel = 0
		f.LayoutOrder = nx()
		f.Parent = parent
		corner(f, 14)
		padding(f, 6, 6, 6, 6)
		register(shown, f, true)
		local gstroke = Instance.new("UIStroke")
		gstroke.Color = C.line
		gstroke.Thickness = 1
		gstroke.Transparency = 0
		gstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		gstroke.Parent = f
		local pop = Instance.new("UIScale")
		pop.Name = "PopScale"
		pop.Parent = f
		local lay = Instance.new("UIListLayout")
		lay.Padding = UDim.new(0, 2)
		lay.SortOrder = Enum.SortOrder.LayoutOrder
		lay.Parent = f

		local head = Instance.new("TextButton")
		head.Size = UDim2.new(1, 0, 0, 38)
		head.Text = ""
		head.LayoutOrder = 0
		head.Parent = f
		flatRow(head)
		local t = Instance.new("TextLabel")
		t.Size = UDim2.new(1, -44, 1, 0)
		t.Position = UDim2.fromOffset(12, 0)
		t.BackgroundTransparency = 1
		t.Text = shown
		t.TextSize = 14
		t.Font = Enum.Font.GothamBold
		t.TextColor3 = C.text
		t.TextXAlignment = Enum.TextXAlignment.Left
		t.Parent = head
		local chev = Instance.new("TextLabel")
		chev.AnchorPoint = Vector2.new(1, 0.5)
		chev.Position = UDim2.new(1, -8, 0.5, -1)
		chev.Size = UDim2.fromOffset(16, 20)
		chev.BackgroundTransparency = 1
		chev.Text = "\u{203A}"
		chev.TextSize = 22
		chev.Font = Enum.Font.GothamMedium
		chev.TextColor3 = C.sub
		chev.Rotation = open and 90 or 0
		chev.Parent = head

		local content = Instance.new("Frame")
		content.Size = UDim2.new(1, 0, 0, 0)
		content.AutomaticSize = Enum.AutomaticSize.Y
		content.BackgroundTransparency = 1
		content.BorderSizePixel = 0
		content.LayoutOrder = 1
		content.Visible = open
		content.Parent = f
		padding(content, 0, 4, 0, 2)
		local clay = Instance.new("UIListLayout")
		clay.Padding = UDim.new(0, 4)
		clay.SortOrder = Enum.SortOrder.LayoutOrder
		clay.Parent = content

		local tok = 0
		local function setOpen(v, instant)
			if v == open then return end
			open = v
			tok += 1
			local my = tok
			if instant then
				chev.Rotation = v and 90 or 0
				content.AutomaticSize = Enum.AutomaticSize.Y
				content.ClipsDescendants = false
				content.Size = UDim2.new(1, 0, 0, 0)
				content.Visible = v
				return
			end
			tween(chev, 0.2, {Rotation = v and 90 or 0})
			if v then
				content.Visible = true
				content.AutomaticSize = Enum.AutomaticSize.None
				content.ClipsDescendants = true
				content.Size = UDim2.new(1, 0, 0, 0)
				task.spawn(function()
					task.wait()
					if tok ~= my then return end
					local tw = tween(content, 0.22, {Size = UDim2.new(1, 0, 0, clay.AbsoluteContentSize.Y + 6)})
					tw.Completed:Connect(function()
						if tok == my then
							content.AutomaticSize = Enum.AutomaticSize.Y
							content.ClipsDescendants = false
						end
					end)
				end)
			else
				content.AutomaticSize = Enum.AutomaticSize.None
				content.ClipsDescendants = true
				content.Size = UDim2.new(1, 0, 0, content.AbsoluteSize.Y)
				local tw = tween(content, 0.18, {Size = UDim2.new(1, 0, 0, 0)})
				tw.Completed:Connect(function()
					if tok == my then content.Visible = false end
				end)
			end
		end
		head.MouseButton1Click:Connect(function() setOpen(not open) end)
		ui.groupMap[f] = setOpen
		ui.groupMap[content] = setOpen
		return builder(content, nosearch)
	end
	function B.label(text)
		local l = Instance.new("TextLabel")
		l.Size = UDim2.new(1, 0, 0, 18)
		l.BackgroundTransparency = 1
		l.Text = text
		l.TextSize = 13
		l.Font = Enum.Font.GothamMedium
		l.TextColor3 = C.sub
		l.TextXAlignment = Enum.TextXAlignment.Left
		l.TextTruncate = Enum.TextTruncate.AtEnd
		l.LayoutOrder = nx()
		l.Parent = parent
		return l
	end
	function B.custom(height)
		local f = Instance.new("Frame")
		f.Size = UDim2.new(1, 0, 0, height)
		f.BackgroundColor3 = C.elem
		f.BorderSizePixel = 0
		f.LayoutOrder = nx()
		f.Parent = parent
		corner(f, 8)
		return f
	end
	function B.toggle(name, initial, callback)
		local row = Instance.new("TextButton")
		row.Size = UDim2.new(1, 0, 0, 38)
		row.Text = ""
		row.LayoutOrder = nx()
		row.Parent = parent
		flatRow(row)
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(1, -64, 1, 0)
		lbl.Position = UDim2.fromOffset(8, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text = name
		lbl.TextScaled = true
		lbl.Font = Enum.Font.GothamMedium
		lbl.TextColor3 = C.text
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.Parent = row
		capText(lbl, 14)
		local track = Instance.new("Frame")
		track.Size = UDim2.fromOffset(42, 22)
		track.AnchorPoint = Vector2.new(1, 0.5)
		track.Position = UDim2.new(1, -8, 0.5, 0)
		track.BorderSizePixel = 0
		track.Parent = row
		corner(track, 11)
		local knob = Instance.new("Frame")
		knob.Size = UDim2.fromOffset(16, 16)
		knob.AnchorPoint = Vector2.new(0, 0.5)
		knob.BorderSizePixel = 0
		knob.Parent = track
		corner(knob, 8)
		register(name, row)
		local on = initial
		local function refresh(animate)
			local t = animate and 0.2 or 0
			tween(track, t, {BackgroundColor3 = on and C.accent or C.off})
			tween(knob, t, {
				Position = on and UDim2.new(0, 23, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
				BackgroundColor3 = on and C.text or Color3.fromRGB(34, 34, 40),
			}, Enum.EasingStyle.Back)
		end
		refresh(false)
		row.MouseButton1Click:Connect(function()
			on = not on
			refresh(true)
			callback(on)
		end)
		return function(v) on = v refresh(true) end
	end
	function B.input(name, default, min, max, callback)
		local row = Instance.new("Frame")
		row.Size = UDim2.new(1, 0, 0, 48)
		row.BackgroundTransparency = 1
		row.BorderSizePixel = 0
		row.LayoutOrder = nx()
		row.Parent = parent
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(0.55, -12, 0, 30)
		lbl.Position = UDim2.fromOffset(8, 3)
		lbl.BackgroundTransparency = 1
		lbl.Text = name
		lbl.TextScaled = true
		lbl.Font = Enum.Font.GothamMedium
		lbl.TextColor3 = C.text
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.Parent = row
		capText(lbl, 14)
		local t = Instance.new("TextBox")
		t.Size = UDim2.new(0.4, 0, 0, 26)
		t.AnchorPoint = Vector2.new(1, 0)
		t.Position = UDim2.new(1, -4, 0, 5)
		t.BackgroundColor3 = C.elem
		t.BorderSizePixel = 0
		t.PlaceholderText = tostring(default)
		t.PlaceholderColor3 = Color3.fromRGB(110, 110, 130)
		t.Text = ""
		t.ClearTextOnFocus = false
		t.TextSize = 14
		t.Font = Enum.Font.GothamBold
		t.TextColor3 = C.text
		t.Parent = row
		corner(t, 6)
		local stroke = Instance.new("UIStroke")
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Color = C.accent
		stroke.Thickness = 1.5
		stroke.Transparency = 1
		stroke.Parent = t
		local track = Instance.new("Frame")
		track.Size = UDim2.new(1, -16, 0, 4)
		track.Position = UDim2.new(0, 8, 1, -11)
		track.BackgroundColor3 = Color3.fromRGB(46, 46, 50)
		track.BorderSizePixel = 0
		track.Parent = row
		corner(track, 2)
		local fill = Instance.new("Frame")
		fill.Size = UDim2.fromScale(0, 1)
		fill.BackgroundColor3 = C.accent
		fill.BorderSizePixel = 0
		fill.Parent = track
		corner(fill, 2)
		register(name, row)
		local function setFill(v)
			local f = math.clamp((v - min) / math.max(max - min, 1e-9), 0, 1)
			tween(fill, 0.12, {Size = UDim2.fromScale(f, 1)})
		end
		setFill(default)
		local hit = Instance.new("TextButton")
		hit.Size = UDim2.new(1, 0, 0, 20)
		hit.AnchorPoint = Vector2.new(0, 0.5)
		hit.Position = UDim2.fromScale(0, 0.5)
		hit.BackgroundTransparency = 1
		hit.Text = ""
		hit.Parent = track
		local function applyX(x)
			local f = math.clamp((x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
			local v = min + (max - min) * f
			if max - min > 20 then
				v = math.floor(v + 0.5)
			else
				v = math.floor(v * 100 + 0.5) / 100
			end
			t.Text = tostring(v)
			callback(v)
		end
		hit.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch then
				sliderMove = applyX
				applyX(input.Position.X)
			end
		end)
		t:GetPropertyChangedSignal("Text"):Connect(function()
			setFill(tonumber(t.Text) or default)
		end)
		t.Focused:Connect(function() tween(stroke, 0.15, {Transparency = 0}) end)
		t.FocusLost:Connect(function()
			tween(stroke, 0.2, {Transparency = 1})
			local v = tonumber(t.Text)
			if v then
				v = math.clamp(v, min, max)
				t.Text = tostring(v)
				callback(v)
			end
		end)
		table.insert(inputs, t)
		return t
	end
	function B.textInput(name, placeholder)
		local row = Instance.new("Frame")
		row.Size = UDim2.new(1, 0, 0, 38)
		row.BackgroundColor3 = C.elem
		row.BorderSizePixel = 0
		row.LayoutOrder = nx()
		row.Parent = parent
		corner(row, 8)
		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(0.25, -12, 1, 0)
		lbl.Position = UDim2.fromOffset(12, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text = name
		lbl.TextScaled = true
		lbl.Font = Enum.Font.GothamMedium
		lbl.TextColor3 = C.text
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.Parent = row
		capText(lbl, 14)
		local t = Instance.new("TextBox")
		t.Size = UDim2.new(0.7, 0, 0, 26)
		t.AnchorPoint = Vector2.new(1, 0.5)
		t.Position = UDim2.new(1, -8, 0.5, 0)
		t.BackgroundColor3 = C.input
		t.BorderSizePixel = 0
		t.PlaceholderText = placeholder or ""
		t.PlaceholderColor3 = Color3.fromRGB(110, 110, 130)
		t.Text = ""
		t.ClearTextOnFocus = false
		register(name, row)
		t.ClipsDescendants = true
		t.TextSize = 12
		t.Font = Enum.Font.GothamMedium
		t.TextColor3 = C.text
		t.Parent = row
		corner(t, 6)
		local stroke = Instance.new("UIStroke")
		stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		stroke.Color = C.accent
		stroke.Thickness = 1.5
		stroke.Transparency = 1
		stroke.Parent = t
		t.Focused:Connect(function() tween(stroke, 0.15, {Transparency = 0}) end)
		t.FocusLost:Connect(function() tween(stroke, 0.2, {Transparency = 1}) end)
		return t
	end
	function B.button(name, callback, color)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(1, 0, 0, 38)
		b.Text = name
		b.TextSize = 14
		b.TextColor3 = C.text
		b.LayoutOrder = nx()
		b.Parent = parent
		if color then
			-- coloured buttons stay solid so they read as actions
			b.Font = Enum.Font.GothamBold
			decorate(b, color)
		else
			-- plain buttons are flat rows with a chevron, like the reference menu
			b.Font = Enum.Font.GothamMedium
			b.TextXAlignment = Enum.TextXAlignment.Left
			padding(b, 8, 0, 0, 0)
			flatRow(b)
			local chev = Instance.new("TextLabel")
			chev.AnchorPoint = Vector2.new(1, 0.5)
			chev.Position = UDim2.new(1, -6, 0.5, -1)
			chev.Size = UDim2.fromOffset(16, 20)
			chev.BackgroundTransparency = 1
			chev.Text = "\u{203A}"
			chev.TextSize = 22
			chev.Font = Enum.Font.GothamMedium
			chev.TextColor3 = C.sub
			chev.Parent = b
		end
		register(name, b)
		b.MouseButton1Click:Connect(function() callback(b) end)
		return b
	end
	function B.dropdown(label, options, initial, onPick)
		local holder = Instance.new("Frame")
		holder.Size = UDim2.new(1, 0, 0, 0)
		holder.AutomaticSize = Enum.AutomaticSize.Y
		holder.BackgroundTransparency = 1
		holder.BorderSizePixel = 0
		holder.LayoutOrder = nx()
		holder.Parent = parent
		local hl = Instance.new("UIListLayout")
		hl.Padding = UDim.new(0, 4)
		hl.SortOrder = Enum.SortOrder.LayoutOrder
		hl.Parent = holder

		local b = Instance.new("TextButton")
		b.Size = UDim2.new(1, 0, 0, 38)
		b.Text = label .. ": " .. tostring(initial)
		b.TextSize = 14
		b.Font = Enum.Font.GothamMedium
		b.TextColor3 = C.text
		b.TextXAlignment = Enum.TextXAlignment.Left
		b.LayoutOrder = 0
		b.Parent = holder
		padding(b, 12, 0, 0, 0)
		decorate(b, C.elem)
		local arrow = Instance.new("TextLabel")
		arrow.AnchorPoint = Vector2.new(1, 0.5)
		arrow.Position = UDim2.new(1, -8, 0.5, -1)
		arrow.Size = UDim2.fromOffset(16, 20)
		arrow.BackgroundTransparency = 1
		arrow.Text = "\u{203A}"
		arrow.TextSize = 22
		arrow.Font = Enum.Font.GothamMedium
		arrow.TextColor3 = C.sub
		arrow.Rotation = 90
		arrow.Parent = b

		local list = Instance.new("Frame")
		list.Size = UDim2.new(1, 0, 0, 0)
		list.AutomaticSize = Enum.AutomaticSize.Y
		list.BackgroundColor3 = C.input
		list.BorderSizePixel = 0
		list.LayoutOrder = 1
		list.Visible = false
		list.Parent = holder
		corner(list, 10)
		padding(list, 4, 4, 4, 4)
		local ls = Instance.new("UIStroke")
		ls.Color = C.line
		ls.Thickness = 1
		ls.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		ls.Parent = list
		local llay = Instance.new("UIListLayout")
		llay.Padding = UDim.new(0, 2)
		llay.SortOrder = Enum.SortOrder.LayoutOrder
		llay.Parent = list

		local optBtns = {}
		local open = false
		local function setOpen(v)
			open = v
			list.Visible = v
			tween(arrow, 0.15, {Rotation = v and -90 or 90})
			if v then
				for name, ob in pairs(optBtns) do
					ob.TextColor3 = (b.Text == label .. ": " .. name) and C.text or C.sub
				end
			end
		end
		for i, opt in ipairs(options) do
			local name = tostring(opt)
			local ob = Instance.new("TextButton")
			ob.Size = UDim2.new(1, 0, 0, 30)
			ob.Text = name
			ob.TextSize = 13
			ob.Font = Enum.Font.GothamMedium
			ob.TextColor3 = C.sub
			ob.TextXAlignment = Enum.TextXAlignment.Left
			ob.LayoutOrder = i
			ob.Parent = list
			padding(ob, 10, 0, 0, 0)
			flatRow(ob)
			ob.MouseButton1Click:Connect(function()
				b.Text = label .. ": " .. name
				setOpen(false)
				onPick(opt)
			end)
			optBtns[name] = ob
		end
		b.MouseButton1Click:Connect(function() setOpen(not open) end)
		register(label, b)
		return b
	end
	return B
end

local playersPage = addTab("players", ICONS.players, "PLAYERS", 2)
addDivider(10)
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, 0, 0, 34)
searchBox.PlaceholderText = "Search player..."
searchBox.PlaceholderColor3 = Color3.fromRGB(110, 110, 130)
searchBox.Text = ""
searchBox.ClearTextOnFocus = false
searchBox.TextSize = 14
searchBox.Font = Enum.Font.GothamBold
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.BackgroundColor3 = C.elem
searchBox.BorderSizePixel = 0
searchBox.TextColor3 = C.text
searchBox.Parent = playersPage
corner(searchBox, 8)
padding(searchBox, 12, 0, 0, 0)
local searchStroke = Instance.new("UIStroke")
searchStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
searchStroke.Color = C.accent
searchStroke.Thickness = 1.5
searchStroke.Transparency = 1
searchStroke.Parent = searchBox
searchBox.Focused:Connect(function() tween(searchStroke, 0.15, {Transparency = 0}) end)
searchBox.FocusLost:Connect(function() tween(searchStroke, 0.2, {Transparency = 1}) end)
local playerList = makeList(playersPage)
playerList.Size = UDim2.new(1, 0, 1, -42)
playerList.Position = UDim2.fromOffset(0, 42)
local function rowButton(parent, text, xScale, wScale, color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(wScale, -4, 1, 0)
	b.Position = UDim2.new(xScale, 0, 0, 0)
	b.Text = text
	b.TextScaled = true
	b.Font = Enum.Font.GothamBold
	b.TextColor3 = C.text
	b.Parent = parent
	decorate(b, color or C.elem)
	capText(b, 14)
	return b
end

local showInfoCard
local refreshPlayers
refreshPlayers = function()
	for _, c in ipairs(playerList:GetChildren()) do
		if c:IsA("Frame") or c:IsA("TextButton") then c:Destroy() end
	end
	local query = string.lower(searchBox.Text)
	local others = {}
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= player then
			if query == "" or string.find(string.lower(p.Name), query, 1, true)
					or string.find(string.lower(p.DisplayName), query, 1, true) then
				table.insert(others, p)
			end
		end
	end
	table.sort(others, function(a, b) return a.DisplayName:lower() < b.DisplayName:lower() end)
	local top = Instance.new("Frame")
	top.Size = UDim2.new(1, 0, 0, 38)
	top.BackgroundTransparency = 1
	top.LayoutOrder = 0
	top.Parent = playerList
	local nearBtn = rowButton(top, "NEAREST", 0, 0.5, C.accent)
	local randBtn = rowButton(top, "RANDOM", 0.5, 0.5, C.accent)
	nearBtn.MouseButton1Click:Connect(function()
		if not root then return end
		local best, bestDist
		for _, p in ipairs(Players:GetPlayers()) do
			local r = (p ~= player) and getRoot(p)
			if r then
				local d = (r.Position - root.Position).Magnitude
				if not bestDist or d < bestDist then best, bestDist = p, d end
			end
		end
		if best then teleportToPlayer(best) else setStatus("No players found") end
	end)
	randBtn.MouseButton1Click:Connect(function()
		local pool = {}
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and getRoot(p) then table.insert(pool, p) end
		end
		if #pool > 0 then teleportToPlayer(pool[math.random(#pool)]) else setStatus("No players found") end
	end)
	for i, p in ipairs(others) do
		local row = Instance.new("Frame")
		row.Size = UDim2.new(1, 0, 0, 38)
		row.BackgroundTransparency = 1
		row.LayoutOrder = i
		row.Parent = playerList
		local tp = rowButton(row, p.DisplayName, 0, 0.38)
		local infoBtn = rowButton(row, "INFO", 0.38, 0.14)
		local pip = Instance.new("Frame")
		pip.Size = UDim2.new(0, 4, 1, -14)
		pip.Position = UDim2.new(0, 5, 0, 7)
		pip.BackgroundColor3 = p.Team and p.TeamColor.Color or C.off
		pip.BorderSizePixel = 0
		pip.Parent = tp
		corner(pip, 2)
		local spec = rowButton(row, "SPEC", 0.52, 0.22,
			(state.spectateTarget == p) and C.accent or C.elem)
		local fol = rowButton(row, "FOLLOW", 0.74, 0.26,
			(state.followTarget == p) and C.accent or C.elem)
		tp.MouseButton1Click:Connect(function() teleportToPlayer(p) end)
		infoBtn.MouseButton1Click:Connect(function() showInfoCard(p) end)
		spec.MouseButton1Click:Connect(function()
			if state.spectateTarget == p then stopSpectate() else startSpectate(p) end
			refreshPlayers()
		end)
		fol.MouseButton1Click:Connect(function()
			if state.followTarget == p then
				stopFollow()
				setStatus("Stopped following")
			else
				state.followTarget = p
				setStatus("Following " .. p.DisplayName)
			end
			refreshPlayers()
		end)
	end
end

do
	local card = makeList(playersPage)
	card.Visible = false
	card.Active = true
	card.BackgroundTransparency = 0
	card.BackgroundColor3 = C.bg
	local cb = builder(card, true)
	local MONTHS = {"January", "February", "March", "April", "May", "June", "July",
	"August", "September", "October", "November", "December"}
	local target
	local head = Instance.new("Frame")
	head.Size = UDim2.new(1, 0, 0, 64)
	head.BackgroundTransparency = 1
	head.LayoutOrder = 0
	head.Parent = card
	local avatar = Instance.new("ImageLabel")
	avatar.Size = UDim2.fromOffset(60, 60)
	avatar.BackgroundColor3 = C.elem
	avatar.BorderSizePixel = 0
	avatar.Parent = head
	corner(avatar, 12)
	local nameL = Instance.new("TextLabel")
	nameL.Size = UDim2.new(1, -72, 0, 24)
	nameL.Position = UDim2.fromOffset(70, 6)
	nameL.BackgroundTransparency = 1
	nameL.Text = ""
	nameL.TextSize = 16
	nameL.Font = Enum.Font.GothamBold
	nameL.TextColor3 = C.text
	nameL.TextXAlignment = Enum.TextXAlignment.Left
	nameL.TextTruncate = Enum.TextTruncate.AtEnd
	nameL.Parent = head
	local userL = Instance.new("TextLabel")
	userL.Size = UDim2.new(1, -72, 0, 18)
	userL.Position = UDim2.fromOffset(70, 32)
	userL.BackgroundTransparency = 1
	userL.Text = ""
	userL.TextSize = 12
	userL.Font = Enum.Font.GothamMedium
	userL.TextColor3 = C.sub
	userL.TextXAlignment = Enum.TextXAlignment.Left
	userL.TextTruncate = Enum.TextTruncate.AtEnd
	userL.Parent = head
	local L = {
		age = cb.label(""),
		created = cb.label(""),
		team = cb.label(""),
		health = cb.label(""),
		dist = cb.label(""),
		item = cb.label(""),
	}
	local specBtn, folBtn
	local function refreshButtons()
		if not target then return end
		specBtn.Text = (state.spectateTarget == target) and "STOP SPECTATING" or "SPECTATE"
		folBtn.Text = (state.followTarget == target) and "STOP FOLLOWING" or "FOLLOW"
	end
	cb.button("TELEPORT TO PLAYER", function()
		if target then teleportToPlayer(target) end
	end, C.accent)
	specBtn = cb.button("SPECTATE", function()
		if not target then return end
		if state.spectateTarget == target then stopSpectate() else startSpectate(target) end
		refreshButtons()
		refreshPlayers()
	end)
	folBtn = cb.button("FOLLOW", function()
		if not target then return end
		if state.followTarget == target then
			stopFollow()
			setStatus("Stopped following")
		else
			state.followTarget = target
			setStatus("Following " .. target.DisplayName)
		end
		refreshButtons()
		refreshPlayers()
	end)
	cb.button("COPY USER ID", function()
		if not target then return end
		if setclipboard then
			setclipboard(tostring(target.UserId))
			setStatus("User ID copied")
		else
			setStatus("Clipboard not supported")
		end
	end)
	cb.button("BACK", function()
		target = nil
		card.Visible = false
	end)
	showInfoCard = function(p)
		target = p
		nameL.Text = p.DisplayName
		userL.Text = "@" .. p.Name .. "  |  " .. p.UserId
		local days = math.floor(p.AccountAge)
		L.age.Text = ("Account age: %dy %dd"):format(math.floor(days / 365), days % 365)
		L.created.Text = "Created: loading..."
		task.spawn(function()
			local text
			local body = httpGet("https://users.roblox.com/v1/users/" .. p.UserId)
			if body then
				local ok, data = pcall(function() return HttpService:JSONDecode(body) end)
				if ok and type(data) == "table" and type(data.created) == "string" then
					local y, m, d = string.match(data.created, "^(%d+)-(%d+)-(%d+)")
					if y and MONTHS[tonumber(m)] then
						text = ("%s %d, %s"):format(MONTHS[tonumber(m)], tonumber(d), y)
					end
				end
			end
			if not text then
				text = os.date("!%B %d, %Y", os.time() - days * 86400) .. " (approx.)"
			end
			if target == p then L.created.Text = "Created: " .. text end
		end)
		avatar.Image = ""
		task.spawn(function()
			local ok, img = pcall(function()
				return Players:GetUserThumbnailAsync(p.UserId,
				Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
			end)
			if ok and target == p then avatar.Image = img end
		end)
		refreshButtons()
		card.CanvasPosition = Vector2.zero
		card.Visible = true
	end
	local acc = 0
	connect(RunService.Heartbeat, function(dt)
		if not (target and card.Visible) then return end
		acc += dt
		if acc < 0.2 then return end
		acc = 0
		local c = target.Character
		local h = c and c:FindFirstChildOfClass("Humanoid")
		local r = c and c:FindFirstChild("HumanoidRootPart")
		if target.Team then
			L.team.Text = "Team: " .. target.Team.Name
			L.team.TextColor3 = target.TeamColor.Color
		else
			L.team.Text = "Team: None"
			L.team.TextColor3 = C.sub
		end
		L.health.Text = h and ("Health: %d / %d"):format(math.floor(h.Health), math.floor(h.MaxHealth))
			or "Health: -"
		L.dist.Text = (r and root)
			and ("Distance: %d studs"):format(math.floor((r.Position - root.Position).Magnitude))
			or "Distance: -"
		local tool = c and c:FindFirstChildOfClass("Tool")
		L.item.Text = "Holding: " .. (tool and tool.Name or "nothing")
	end)
	connect(Players.PlayerRemoving, function(p)
		if p == target then
			target = nil
			card.Visible = false
		end
	end)
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function() refreshPlayers() end)
connect(Players.PlayerAdded, function() refreshPlayers() end)
connect(Players.PlayerRemoving, function(p)
	if state.followTarget == p then stopFollow() end
	if state.spectateTarget == p then stopSpectate() end
	task.defer(refreshPlayers)
end)

refreshPlayers()
do
	local move = builder(makeList(addTab("movement", ICONS.movement, "MOVEMENT", 1)))
	local flight = move.group("\u{1F680}  FLIGHT")
	sync.fly = flight.toggle("Fly", false, function(on)
		if on then startFly() else stopFly() end
	end)
	local flyBox = flight.input("Fly Speed", 70, 1, 500, function(v) state.flySpeed = v end)
	sync.noclip = flight.toggle("Noclip", false, setNoclip)
	local vehG = move.group("\u{1F697}  VEHICLE")
	sync.vehFly = vehG.toggle("Vehicle Fly  (H)", false, function(on)
		state.vehFly = on
		if on and not (humanoid and humanoid.SeatPart) then setStatus("Sit in a vehicle first") end
		if not on then veh.stop() end
	end)
	ui.vehBox = vehG.input("Vehicle Fly Speed", 100, 5, 500, function(v) state.vehSpeed = v end)
	sync.vehFace = vehG.toggle("Face Camera Direction", true, function(on) state.vehFace = on end)
	vehG.label("Sit in a vehicle, then steer with the camera")
	local speed = move.group("\u{26A1}  SPEED")
	local walkBox = speed.input("WalkSpeed", 16, 0, 500, function(v)
		state.walkSpeed = v
		state.walkOn = true
		if humanoid and not state.cframeSpeed then humanoid.WalkSpeed = v end
	end)
	sync.cfSpeed = speed.toggle("Speed Bypass (CFrame)", false, function(on)
		state.cframeSpeed = on
		if not on and state.walkOn and humanoid then humanoid.WalkSpeed = state.walkSpeed end
		if on and humanoid then humanoid.WalkSpeed = defaults.walk end
	end)
	sync.sprint = speed.toggle("Sprint (hold Shift)", false, function(on) state.sprint = on end)
	speed.input("Sprint Boost", 30, 5, 200, function(v) state.sprintBoost = v end)
	local jump = move.group("\u{1F998}  JUMP")
	local jumpBox = jump.input("JumpPower", 50, 0, 500, function(v)
		state.jumpPower = v
		state.jumpOn = true
		if humanoid and not state.forceJump then
			humanoid.UseJumpPower = true
			humanoid.JumpPower = v
		end
	end)
	sync.forceJump = jump.toggle("Jump Bypass (Velocity)", false, function(on)
		state.forceJump = on
	end)
	sync.infJump = jump.toggle("Infinite Jump", false, function(on) state.infJump = on end)
	sync.bhop = jump.toggle("Bunny Hop (hold Space)", false, function(on) state.bhop = on end)
	sync.slowFall = jump.toggle("Slow Fall", false, function(on) state.slowFall = on end)
	jump.input("Fall Speed", 20, 2, 100, function(v) state.fallSpeed = v end)
	local fun = move.group("\u{2728}  EXTRAS")
	sync.invis = fun.toggle("Invisible  (I)", false, setInvis)
	sync.charAnim = fun.toggle("No Character Animations", false, setCharAnim)
	sync.spin = fun.toggle("Spin", false, function(on) state.spin = on end)
	ui.spinBox = fun.input("Spin Speed (deg/s)", 360, 30, 3600, function(v) state.spinSpeed = v end)
	sync.clickTP = fun.toggle("Alt + Click Teleport", false, function(on) state.clickTP = on end)
	sync.freecam = fun.toggle("Freecam (RMB to look)", false, setFreecam)
	fun.input("Freecam Speed", 60, 5, 500, function(v) state.fcSpeed = v end)
	sync.freeze = fun.toggle("Freeze In Place", false, setFreeze)
	sync.antiVoid = fun.toggle("Anti-Void", false, function(on) state.antiVoid = on end)
	fun.input("Dash Power", 90, 20, 400, function(v) state.dashPower = v end)
	fun.button("Dash Forward  (V)", function() doDash() end)
	fun.button("Sit Down", function()
		if humanoid then humanoid.Sit = true end
	end)
	fun.button("Teleport to Spawn", function()
		if root and spawnCFrame then
			root.AssemblyLinearVelocity = Vector3.zero
			root.CFrame = spawnCFrame + Vector3.new(0, 3, 0)
		end
	end)
	fun.button("Reset Character", function()
		if humanoid then humanoid.Health = 0 end
	end, C.danger)
	do
		local wpG = move.group("\u{1F4CD}  WAYPOINTS")
		local wpSlot = 1
		local waypoints = {}
		local function slotText()
			return "Slot: " .. wpSlot .. (waypoints[wpSlot] and "  (saved)" or "  (empty)")
		end
		local slotBtn = wpG.button(slotText(), function(b)
			wpSlot = wpSlot % 5 + 1
			b.Text = slotText()
		end)
		wpG.button("Save Position Here", function()
			if not root then return end
			waypoints[wpSlot] = root.CFrame
			slotBtn.Text = slotText()
			setStatus("Saved slot " .. wpSlot)
		end)
		wpG.button("Teleport To Slot", function()
			local cf = waypoints[wpSlot]
			if cf and root then
				root.AssemblyLinearVelocity = Vector3.zero
				root.CFrame = cf
				setStatus("Teleported to slot " .. wpSlot)
			else
				setStatus("Slot " .. wpSlot .. " is empty")
			end
		end)
		wpG.button("Copy My Position", function()
			if not root then return end
			if setclipboard then
				local p = root.Position
				setclipboard(("Vector3.new(%.1f, %.1f, %.1f)"):format(p.X, p.Y, p.Z))
				setStatus("Position copied")
			else
				setStatus("Clipboard not supported")
			end
		end)
	end
	ui.flyBox, ui.walkBox, ui.jumpBox = flyBox, walkBox, jumpBox
end

local espB = builder(makeList(addTab("esp", ICONS.esp, "ESP", 3)))
local FIXED_NAMES = {}
for _, c in ipairs(FIXED_COLORS) do table.insert(FIXED_NAMES, c[1]) end
do
	local espMaster = espB.group("\u{1F39B}  MASTER")
	sync.esp = espMaster.toggle("ESP Enabled", false, function(on) esp.on = on end)
	local maxDistBox = espMaster.input("Max Distance", 2000, 50, 10000, function(v) esp.maxDist = v end)
	local espEl = espB.group("\u{1F9E9}  ELEMENTS")
	sync.espBox = espEl.toggle("Box", false, function(on) esp.box = on end)
	sync.espName = espEl.toggle("Nametags", false, function(on) esp.name = on end)
	sync.espHealth = espEl.toggle("Health Bar + Text", false, function(on) esp.health = on end)
	sync.espDist = espEl.toggle("Distance", false, function(on) esp.distance = on end)
	sync.espItem = espEl.toggle("Held Item", false, function(on) esp.item = on end)
	sync.espChams = espEl.toggle("Chams (Highlight)", false, function(on) esp.chams = on end)
	sync.espSkeleton = espEl.toggle("Skeleton", false, function(on) esp.skeleton = on end)
	local espTr = espB.group("\u{1F4CF}  TRACERS")
	sync.espTracers = espTr.toggle("Tracers", false, function(on) esp.tracers = on end)
	local tracerBtn = espTr.dropdown("Origin", {"Bottom", "Center", "Mouse"}, "Bottom", function(v)
		esp.tracerOrigin = v
	end)
	ui.trThickBox = espTr.input("Tracer Thickness", 1, 0.5, 4, function(v) esp.tracerThick = v end)
	ui.trAlphaBox = espTr.input("Tracer Opacity", 0.7, 0, 1, function(v) esp.tracerAlpha = v end)
	local espSt = espB.group("\u{1F4A0}  OPACITY")
	ui.boxAlphaBox = espSt.input("Box Opacity", 1, 0, 1, function(v) esp.boxAlpha = v end)
	ui.skelAlphaBox = espSt.input("Skeleton Opacity", 0.9, 0, 1, function(v) esp.skelAlpha = v end)
	ui.chamFillBox = espSt.input("Chams Fill Opacity", 0.5, 0, 1, function(v) esp.chamFill = v end)
	ui.textAlphaBox = espSt.input("Text Opacity", 1, 0, 1, function(v) esp.textAlpha = v end)
	local espCol = espB.group("\u{1F3A8}  COLORS")
	local COLOR_MODES = {"Team", "Health", "Rainbow", "Fixed"}
	local colorBtn = espCol.dropdown("Color", COLOR_MODES, "Team", function(v) esp.colorMode = v end)
	local fixedBtn = espCol.dropdown("Fixed Color", FIXED_NAMES, "Red", function(v)
		for i, c in ipairs(FIXED_COLORS) do
			if c[1] == v then esp.fixedIdx = i end
		end
	end)
	sync.espHideTeam = espCol.toggle("Hide Teammates", false, function(on) esp.hideTeam = on end)
	ui.maxDistBox, ui.tracerBtn, ui.colorBtn, ui.fixedBtn, ui.COLOR_MODES =
	maxDistBox, tracerBtn, colorBtn, fixedBtn, COLOR_MODES
end

do
	local aimPage = addTab("aim", ICONS.aim, "AIM", 4)
	local ab = builder(makeList(aimPage))
	local mainG = ab.group("\u{1F3AF}  AIMLOCK")
	sync.aimOn = mainG.toggle("Aimlock Enabled", false, function(on) aim.on = on end)
	ui.aimModeBtn = mainG.dropdown("Mode", {"Hold", "Toggle"}, "Hold", function(v) aim.mode = v end)
	ui.aimKeyBtn = mainG.dropdown("Key", aim.keys, "RMB", function(v) aim.key = v end)
	ui.aimPartBtn = mainG.dropdown("Target", {"Head", "Torso", "Closest"}, "Head", function(v)
		aim.part = (v == "Torso") and "HumanoidRootPart" or v
	end)
	ui.aimPrioBtn = mainG.dropdown("Priority", {"Cursor", "Distance", "Health"}, "Cursor", function(v)
		aim.priority = v
	end)
	local tuneG = ab.group("\u{1F527}  TUNING")
	ui.aimFovBox = tuneG.input("FOV Radius", 150, 20, 800, function(v) aim.fov = v end)
	ui.aimSmoothBox = tuneG.input("Smoothness", 0.25, 0.02, 1, function(v) aim.smooth = v end)
	ui.aimMaxBox = tuneG.input("Max Distance", 1000, 50, 5000, function(v) aim.maxDist = v end)
	sync.aimPredict = tuneG.toggle("Prediction", false, function(on) aim.predict = on end)
	ui.aimPredBox = tuneG.input("Prediction Amount", 0.12, 0, 0.5, function(v) aim.predictAmt = v end)
	sync.aimSticky = tuneG.toggle("Sticky Target", false, function(on) aim.sticky = on end)
	ui.aimHumBox = tuneG.input("Humanize", 0, 0, 1, function(v) aim.humanize = v end)
	local chkG = ab.group("\u{2705}  CHECKS")
	sync.aimTeam = chkG.toggle("Team Check", true, function(on) aim.teamCheck = on end)
	sync.aimWall = chkG.toggle("Wall Check", false, function(on) aim.wallCheck = on end)
	local visG = ab.group("\u{1F441}  VISUALS")
	sync.aimFov = visG.toggle("Show FOV Circle", true, function(on) aim.showFov = on end)
	ui.aimFovAlphaBox = visG.input("FOV Opacity", 0.35, 0, 1, function(v) aim.fovAlpha = v end)
	ui.aimFovColorBtn = visG.dropdown("FOV Color", FIXED_NAMES, "White", function(v) aim.fovColor = v end)
	sync.aimSnap = visG.toggle("Snapline To Target", true, function(on) aim.snapline = on end)
	sync.aimInfo = visG.toggle("Target Info", true, function(on) aim.targetInfo = on end)
	local trigG = ab.group("\u{1F52B}  TRIGGERBOT")
	sync.trigger = trigG.toggle("Triggerbot Enabled", false, function(on) aim.trigger = on end)
	ui.trigDelayBox = trigG.input("Click Delay (s)", 0.1, 0.02, 1, function(v) aim.trigDelay = v end)
	trigG.label("Left clicks when a player is under your")
	trigG.label("screen centre. Uses the Team Check above.")
	do
		local VIM
		pcall(function() VIM = game:GetService("VirtualInputManager") end)
		local lastShot = 0
		local function click()
			if mouse1click then
				pcall(mouse1click)
			elseif VIM then
				pcall(function()
					local m = UIS:GetMouseLocation()
					VIM:SendMouseButtonEvent(m.X, m.Y, 0, true, game, 0)
					VIM:SendMouseButtonEvent(m.X, m.Y, 0, false, game, 0)
				end)
			end
		end
		local function underCrosshair()
			local vp = camera.ViewportSize
			local ray = camera:ViewportPointToRay(vp.X / 2, vp.Y / 2)
			local params = RaycastParams.new()
			params.FilterType = Enum.RaycastFilterType.Exclude
			params.FilterDescendantsInstances = {char}
			local hit = workspace:Raycast(ray.Origin, ray.Direction * 2000, params)
			if not hit then return false end
			local model = hit.Instance:FindFirstAncestorOfClass("Model")
			local p = model and Players:GetPlayerFromCharacter(model)
			if not p or p == player then return false end
			if aim.teamCheck and player.Team and p.Team == player.Team then return false end
			local h = model:FindFirstChildOfClass("Humanoid")
			return h ~= nil and h.Health > 0
		end
		connect(RunService.RenderStepped, function()
			if not aim.trigger or not root or state.freecam or hub.Visible then return end
			if UIS:GetFocusedTextBox() then return end
			if os.clock() - lastShot < aim.trigDelay then return end
			if underCrosshair() then
				lastShot = os.clock()
				click()
			end
		end)
	end
	local helpG = ab.group("\u{1F4A1}  HOW IT WORKS")
	helpG.label("Hold (or toggle) the key to lock onto a target.")
	helpG.label("Priority picks who: closest to cursor, nearest, or")
	helpG.label("lowest health. Sticky keeps the same target.")
	helpG.label("Prediction leads moving targets. Smoothness 1 = snap.")
	local radG = espB.group("\u{1F4E1}  RADAR")
	sync.radar = radG.toggle("Radar", false, function(on) radar.on = on end)
	ui.radarRangeBox = radG.input("Range (studs)", 200, 25, 2000, function(v) radar.range = v end)
	ui.radarSizeBox = radG.input("Size (px)", 150, 80, 300, function(v)
		radar.size = v
		radar.apply()
	end)
	ui.radarPosBtn = radG.dropdown("Position", radar.corners, "Top Right", function(v)
		radar.corner = v
		radar.apply()
	end)
end

local fx = {idx = 1, fp = false}
fx.cc = Instance.new("ColorCorrectionEffect")
fx.cc.Name = "NyxCC"
fx.cc.Parent = Lighting
fx.bloom = Instance.new("BloomEffect")
fx.bloom.Name = "NyxBloom"
fx.bloom.Intensity = 0.6
fx.bloom.Size = 28
fx.bloom.Threshold = 0.9
fx.bloom.Enabled = false
fx.bloom.Parent = Lighting
fx.rays = Instance.new("SunRaysEffect")
fx.rays.Name = "NyxRays"
fx.rays.Intensity = 0.15
fx.rays.Enabled = false
fx.rays.Parent = Lighting
do
	local world = builder(makeList(addTab("world", ICONS.world, "WORLD", 5)))
	local lightG = world.group("\u{1F31E}  LIGHTING")
	sync.fullbright = lightG.toggle("Fullbright", false, setFullbright)
	sync.noFog = lightG.toggle("No Fog", false, setNoFog)
	ui.timeBox = lightG.input("Time of Day (0-24)", 14, 0, 24, function(v)
		state.clock = v
		state.clockOn = true
	end)
	local camG = world.group("\u{1F4F7}  CAMERA")
	ui.fovBox = camG.input("Field of View", 70, 30, 120, function(v)
		state.fov = v
		state.fovOn = true
		camera.FieldOfView = v
	end)
	camG.input("Max Zoom Distance", 128, 5, 5000, function(v)
		state.zoom = v
		state.zoomOn = true
		player.CameraMaxZoomDistance = v
	end)
	local crosshair = Instance.new("Frame")
	crosshair.AnchorPoint = Vector2.new(0.5, 0.5)
	crosshair.Position = UDim2.fromScale(0.5, 0.5)
	crosshair.Size = UDim2.fromOffset(16, 16)
	crosshair.BackgroundTransparency = 1
	crosshair.Visible = false
	crosshair.Parent = tracerGui
	for _, sz in ipairs({UDim2.new(1, 0, 0, 2), UDim2.new(0, 2, 1, 0)}) do
		local bar = Instance.new("Frame")
		bar.AnchorPoint = Vector2.new(0.5, 0.5)
		bar.Position = UDim2.fromScale(0.5, 0.5)
		bar.Size = sz
		bar.BackgroundColor3 = Color3.new(1, 1, 1)
		bar.BorderSizePixel = 1
		bar.BorderColor3 = Color3.new(0, 0, 0)
		bar.Parent = crosshair
	end
	sync.crosshair = camG.toggle("Crosshair", false, function(on) crosshair.Visible = on end)
	sync.firstPerson = camG.toggle("Lock First Person", false, function(on)
		fx.fp = on
		player.CameraMode = on and Enum.CameraMode.LockFirstPerson or Enum.CameraMode.Classic
	end)
	local skyG = world.group("\u{1F305}  SKY")
	do
		local SKY = {{"Dawn", 6}, {"Noon", 12}, {"Sunset", 18}, {"Midnight", 0}}
		local skyIdx = 0
		local skyNames = {}
		for _, sk in ipairs(SKY) do table.insert(skyNames, sk[1]) end
		skyG.dropdown("Time Preset", skyNames, "-", function(v)
			for _, p in ipairs(SKY) do
				if p[1] == v then
					state.clock, state.clockOn = p[2], true
					ui.timeBox.Text = tostring(p[2])
				end
			end
		end)
	end
	local fxG = world.group("\u{1F39E}\u{FE0F}  FILTERS")
	ui.satBox = fxG.input("Saturation", 0, -1, 3, function(v) fx.cc.Saturation = v end)
	ui.conBox = fxG.input("Contrast", 0, -1, 1, function(v) fx.cc.Contrast = v end)
	ui.briBox = fxG.input("Brightness", 0, -0.5, 0.5, function(v) fx.cc.Brightness = v end)
	do
		local FILTERS = {
			{"None", 0, 0, 0, Color3.new(1, 1, 1)},
			{"Vivid", 0.9, 0.15, 0, Color3.fromRGB(255, 250, 245)},
			{"Warm", 0.2, 0.05, 0, Color3.fromRGB(255, 225, 190)},
			{"Cool", 0.1, 0.05, 0, Color3.fromRGB(190, 215, 255)},
			{"Vintage", -0.35, 0.2, 0.02, Color3.fromRGB(255, 230, 200)},
			{"Noir", -1, 0.3, -0.02, Color3.new(1, 1, 1)},
		}
		local filterNames = {}
		for _, fl in ipairs(FILTERS) do table.insert(filterNames, fl[1]) end
		ui.filterBtn = fxG.dropdown("Filter", filterNames, "None", function(v)
			for i, f in ipairs(FILTERS) do
				if f[1] == v then
					fx.idx = i
					fx.cc.Saturation, fx.cc.Contrast, fx.cc.Brightness, fx.cc.TintColor = f[2], f[3], f[4], f[5]
					ui.satBox.Text, ui.conBox.Text, ui.briBox.Text = tostring(f[2]), tostring(f[3]), tostring(f[4])
				end
			end
		end)
	end
	sync.bloom = fxG.toggle("Bloom", false, function(on) fx.bloom.Enabled = on end)
	sync.rays = fxG.toggle("Sun Rays", false, function(on) fx.rays.Enabled = on end)
	local physG = world.group("\u{1F34E}  PHYSICS")
	ui.gravBox = physG.input("Gravity", math.floor(defaults.gravity), 0, 500, function(v)
		state.gravity = v
		state.gravityOn = true
		workspace.Gravity = v
	end)
	ui.crosshair = crosshair
end

do
	local server = builder(makeList(addTab("server", ICONS.server, "SERVER", 11)))
	local infoG = server.group("\u{2139}  INFO")
	infoLabels.players = infoG.label("Players: ...")
	infoLabels.ping = infoG.label("Ping: ...")
	infoLabels.fps = infoG.label("FPS: ...")
	infoG.label("Job ID: " .. string.sub(game.JobId, 1, 18) .. "...")
	local actG = server.group("\u{1F501}  ACTIONS")
	actG.button("Rejoin Server", rejoin, C.accent)
	actG.button("Server Hop (Random)", function() serverHop("random") end, C.accent)
	actG.button("Hop to Smallest Server", function() serverHop("small") end, C.accent)
	local joinG = server.group("\u{1F517}  JOIN / SHARE")
	local jobBox = joinG.textInput("Job ID", "paste a server's Job ID")
	joinG.button("Join Job ID", function() joinJob(jobBox.Text) end)
	joinG.button("Copy Job ID", function()
		if setclipboard then
			setclipboard(game.JobId)
			setStatus("Job ID copied")
		else
			setStatus("Clipboard not supported")
		end
	end)
	joinG.button("Copy Join Script", function()
		if setclipboard then
			setclipboard(('game:GetService("TeleportService"):TeleportToPlaceInstance(%d, "%s", game.Players.LocalPlayer)')
					:format(game.PlaceId, game.JobId))
			setStatus("Join script copied")
		else
			setStatus("Clipboard not supported")
		end
	end)
	local autoG = server.group("\u{1F916}  AUTOMATION")
	autoG.toggle("Auto Rejoin On Kick", false, function(on) state.autoRejoin = on end)
end

do
	local Stats = game:GetService("Stats")
	local S = perf.s
	local pb = builder(makeList(addTab("perf", ICONS.perf, "PERFORMANCE", 6)))
	local origCap = 60
	pcall(function()
		if getfpscap then origCap = tonumber(getfpscap()) or 60 end
	end)
	if origCap <= 0 or origCap > 1000 then origCap = 60 end
	local origQuality
	pcall(function() origQuality = settings().Rendering.QualityLevel end)
	local saved = {fx = {}, mat = {}, decal = {}, post = {}, water = nil}
	local watchers = {}
	local presetIdx = 1
	local capBox, applyPreset
	local function stopWatch(k)
		if watchers[k] then watchers[k]:Disconnect() watchers[k] = nil end
	end
	local function each(fn)
		task.spawn(function()
			local n = 0
			for _, i in ipairs(workspace:GetDescendants()) do
				pcall(fn, i)
				n += 1
				if n % 1500 == 0 then task.wait() end
			end
		end)
	end
	local function isOurs(i)
		return string.sub(i.Name, 1, 3) == "Nyx"
	end
	local function applyCap()
		if not setfpscap then return false end
		pcall(setfpscap, S.capOn and S.cap or origCap)
		return true
	end
	local function setCapOn(on)
		if on and not setfpscap then
			S.capOn = false
			if sync.pCap then sync.pCap(false) end
			setStatus("Your executor has no setfpscap")
			return
		end
		S.capOn = on
		applyCap()
	end
	local FX_CLASSES = {ParticleEmitter = true, Trail = true, Beam = true,
	Fire = true, Smoke = true, Sparkles = true}
	local function setFx(on)
		S.fx = on
		stopWatch("fx")
		if on then
			local function hit(i)
				if FX_CLASSES[i.ClassName] and saved.fx[i] == nil then
					saved.fx[i] = i.Enabled
					i.Enabled = false
				end
			end
			each(hit)
			watchers.fx = workspace.DescendantAdded:Connect(function(i) pcall(hit, i) end)
		else
			for i, v in pairs(saved.fx) do
				if i.Parent then pcall(function() i.Enabled = v end) end
			end
			saved.fx = {}
		end
	end
	local function setFlat(on)
		S.flat = on
		stopWatch("flat")
		if on then
			local function hit(i)
				if i:IsA("BasePart") and not i:IsA("Terrain") and saved.mat[i] == nil then
					saved.mat[i] = {i.Material, i.Reflectance}
					i.Material = Enum.Material.SmoothPlastic
					i.Reflectance = 0
				end
			end
			each(hit)
			watchers.flat = workspace.DescendantAdded:Connect(function(i) pcall(hit, i) end)
		else
			for i, v in pairs(saved.mat) do
				if i.Parent then pcall(function() i.Material = v[1] i.Reflectance = v[2] end) end
			end
			saved.mat = {}
		end
	end
	local function setDecals(on)
		S.decals = on
		stopWatch("decals")
		if on then
			local function hit(i)
				if (i:IsA("Decal") or i:IsA("Texture")) and saved.decal[i] == nil then
					saved.decal[i] = i.Transparency
					i.Transparency = 1
				end
			end
			each(hit)
			watchers.decals = workspace.DescendantAdded:Connect(function(i) pcall(hit, i) end)
		else
			for i, v in pairs(saved.decal) do
				if i.Parent then pcall(function() i.Transparency = v end) end
			end
			saved.decal = {}
		end
	end
	local function setPost(on)
		S.post = on
		stopWatch("post")
		if on then
			local function hit(i)
				if i:IsA("PostEffect") and not isOurs(i) and saved.post[i] == nil then
					saved.post[i] = i.Enabled
					i.Enabled = false
				end
			end
			for _, i in ipairs(Lighting:GetChildren()) do pcall(hit, i) end
			watchers.post = Lighting.ChildAdded:Connect(function(i)
				task.defer(function() pcall(hit, i) end)
			end)
		else
			for i, v in pairs(saved.post) do
				if i.Parent then pcall(function() i.Enabled = v end) end
			end
			saved.post = {}
		end
	end
	local function setShadows(on)
		S.shadows = on
		Lighting.GlobalShadows = on and false or savedLighting.GlobalShadows
	end
	local function setLow(on)
		S.low = on
		pcall(function()
			settings().Rendering.QualityLevel = on and Enum.QualityLevel.Level01
				or (origQuality or Enum.QualityLevel.Automatic)
		end)
		pcall(function()
			local t = workspace:FindFirstChildOfClass("Terrain")
			if not t then return end
			if on then
				if not saved.water then
					saved.water = {t.WaterWaveSize, t.WaterWaveSpeed, t.WaterReflectance}
				end
				t.WaterWaveSize, t.WaterWaveSpeed, t.WaterReflectance = 0, 0, 0
			elseif saved.water then
				t.WaterWaveSize, t.WaterWaveSpeed, t.WaterReflectance =
				saved.water[1], saved.water[2], saved.water[3]
				saved.water = nil
			end
		end)
	end
	local overlay = Instance.new("Frame")
	overlay.Size = UDim2.fromScale(1, 1)
	overlay.BackgroundColor3 = Color3.fromRGB(6, 6, 10)
	overlay.BorderSizePixel = 0
	overlay.Visible = false
	overlay.ZIndex = 0
	overlay.Parent = tracerGui
	local overlayText = Instance.new("TextLabel")
	overlayText.AnchorPoint = Vector2.new(0.5, 0.5)
	overlayText.Position = UDim2.fromScale(0.5, 0.5)
	overlayText.Size = UDim2.fromOffset(420, 80)
	overlayText.BackgroundTransparency = 1
	overlayText.RichText = true
	overlayText.Text = ""
	overlayText.TextSize = 16
	overlayText.Font = Enum.Font.GothamBold
	overlayText.TextColor3 = C.sub
	overlayText.Parent = overlay
	local function setBlack(on)
		S.black = on
		pcall(function() RunService:Set3dRenderingEnabled(not on) end)
		overlay.Visible = on
	end
	local PRESETS = {
		{"STOCK", nil, {}},
		{"BOOST", 144, {"shadows", "post", "fx"}},
		{"TURBO", 360, {"shadows", "post", "fx", "low", "decals"}},
		{"INSANE", 999, {"shadows", "post", "fx", "low", "decals", "flat"}},
	}
	local oc = pb.group("\u{1F525}  OVERCLOCKER")
	local gf = oc.custom(76)
	local big = Instance.new("TextLabel")
	big.Size = UDim2.new(1, 0, 0, 40)
	big.Position = UDim2.fromOffset(0, 4)
	big.BackgroundTransparency = 1
	big.Text = "-- FPS"
	big.TextSize = 30
	big.Font = Enum.Font.GothamBlack
	big.TextColor3 = C.text
	big.Parent = gf
	local subL = Instance.new("TextLabel")
	subL.Size = UDim2.new(1, 0, 0, 16)
	subL.Position = UDim2.fromOffset(0, 44)
	subL.BackgroundTransparency = 1
	subL.Text = ""
	subL.TextSize = 12
	subL.Font = Enum.Font.GothamMedium
	subL.TextColor3 = C.sub
	subL.Parent = gf
	local gBack = Instance.new("Frame")
	gBack.Position = UDim2.new(0, 12, 0, 65)
	gBack.Size = UDim2.new(1, -24, 0, 5)
	gBack.BackgroundColor3 = C.input
	gBack.BorderSizePixel = 0
	gBack.Parent = gf
	corner(gBack, 3)
	local gFill = Instance.new("Frame")
	gFill.Size = UDim2.fromScale(0, 1)
	gFill.BackgroundColor3 = C.accent
	gFill.BorderSizePixel = 0
	gFill.Parent = gBack
	corner(gFill, 3)
	local presetNames = {}
	for _, pr in ipairs(PRESETS) do table.insert(presetNames, pr[1]) end
	local presetBtn = oc.dropdown("Preset", presetNames, "STOCK", function(v)
		for i, p in ipairs(PRESETS) do
			if p[1] == v then
				presetIdx = i
				applyPreset(i)
			end
		end
	end)
	sync.pCap = oc.toggle("Unlock FPS Cap", false, setCapOn)
	capBox = oc.input("FPS Cap (999 = max)", 240, 30, 999, function(v)
		S.cap = math.floor(v)
		if S.capOn then applyCap() end
	end)
	local rg = pb.group("\u{1F3A8}  RENDER TWEAKS")
	local setters = {low = setLow, shadows = setShadows, post = setPost,
	fx = setFx, decals = setDecals, flat = setFlat}
	sync.p_low = rg.toggle("Low Graphics", false, setLow)
	sync.p_shadows = rg.toggle("No Shadows", false, setShadows)
	sync.p_post = rg.toggle("No Post Effects", false, setPost)
	sync.p_fx = rg.toggle("No Particles / Trails", false, setFx)
	sync.p_decals = rg.toggle("Hide Decals + Textures", false, setDecals)
	sync.p_flat = rg.toggle("Flat Materials (Potato)", false, setFlat)
	applyPreset = function(i, silent)
		local p = PRESETS[i]
		local want = {}
		for _, k in ipairs(p[3]) do want[k] = true end
		for key, fn in pairs(setters) do
			local v = want[key] or false
			if S[key] ~= v then fn(v) end
			sync["p_" .. key](v)
		end
		if p[2] then
			if setfpscap then
				S.cap = p[2]
				capBox.Text = tostring(p[2])
				setCapOn(true)
				sync.pCap(S.capOn)
			else
				setStatus("No setfpscap here - render tweaks only")
			end
		else
			setCapOn(false)
			sync.pCap(false)
		end
		if not silent then notify("Overclocker", "Preset: " .. p[1], "ok") end
	end
	local ag = pb.group("\u{1F319}  AFK SAVER")
	sync.pBlack = ag.toggle("Black Screen (3D off)  [B]", false, setBlack)
	ag.label("Stops 3D rendering to save CPU / GPU while AFK")
	local sg = pb.group("\u{1F4C8}  LIVE STATS")
	local N = 48
	local graph = sg.custom(72)
	graph.BackgroundColor3 = C.input
	graph.ClipsDescendants = true
	local hist, bars = {}, {}
	for i = 1, N do
		hist[i] = 0
		local b = Instance.new("Frame")
		b.AnchorPoint = Vector2.new(0, 1)
		b.Position = UDim2.new((i - 1) / N, 0, 1, -2)
		b.Size = UDim2.new(1 / N, -1, 0, 0)
		b.BackgroundColor3 = C.accent
		b.BorderSizePixel = 0
		b.Parent = graph
		bars[i] = b
	end
	local rangeL = sg.label("Avg / Min / Max: ...")
	local ftL = sg.label("Frame time: ...")
	local memL = sg.label("Memory: ...")
	local upL = sg.label("Session: 0:00")
	sg.button("Clean Memory", function() perf.clean() end)
	local GREEN = Color3.fromRGB(60, 235, 110)
	local YELLOW = Color3.fromRGB(255, 200, 70)
	local RED = Color3.fromRGB(255, 80, 80)
	local function fpsColor(v)
		return v >= 55 and GREEN or (v >= 30 and YELLOW or RED)
	end
	local function memMb()
		local ok, v = pcall(function() return Stats:GetTotalMemoryUsageMb() end)
		return ok and v or 0
	end
	local fcount, facc, t0 = 0, 0, os.clock()
	connect(RunService.Heartbeat, function(dt)
		fcount += 1
		facc += dt
		if S.shadows and Lighting.GlobalShadows then Lighting.GlobalShadows = false end
		if facc < 0.2 then return end
		local fps = math.floor(fcount / facc + 0.5)
		fcount, facc = 0, 0
		table.remove(hist, 1)
		table.insert(hist, fps)
		if S.black then
			overlayText.Text = ('<font color="#7064FF">AFK SAVER</font>\n3D rendering off  -  press B to wake\n%d FPS')
				:format(fps)
		end
		local page = tabs.perf and tabs.perf.page
		if not (page and page.Visible) then return end
		local target = S.capOn and S.cap or origCap
		local col = fpsColor(fps)
		big.Text = fps .. " FPS"
		big.TextColor3 = col
		gFill.BackgroundColor3 = col
		tween(gFill, 0.15, {Size = UDim2.fromScale(math.clamp(fps / math.max(target, 1), 0, 1), 1)})
		subL.Text = ("%s   |   cap %s"):format(PRESETS[presetIdx][1],
			S.capOn and tostring(S.cap) or ("stock " .. origCap))
		local mx, mn, sum, cnt = 60, math.huge, 0, 0
		for _, v in ipairs(hist) do
			if v > mx then mx = v end
			if v > 0 then
				if v < mn then mn = v end
				sum += v
				cnt += 1
			end
		end
		for i = 1, N do
			local v = hist[i]
			bars[i].Size = UDim2.new(1 / N, -1, math.clamp(v / mx, 0, 1) * 0.94, 0)
			bars[i].BackgroundColor3 = fpsColor(v)
		end
		local avg = cnt > 0 and math.floor(sum / cnt + 0.5) or 0
		rangeL.Text = ("Avg %d    Min %d    Max %d"):format(avg, cnt > 0 and mn or 0, mx == 60 and math.max(fps, 60) or mx)
		ftL.Text = ("Frame %.1f ms    Ping %d ms"):format(1000 / math.max(fps, 1),
			math.floor(player:GetNetworkPing() * 1000))
		memL.Text = ("Memory: %d MB"):format(math.floor(memMb()))
		local up = math.floor(os.clock() - t0)
		upL.Text = ("Session: %d:%02d"):format(math.floor(up / 60), up % 60)
	end)
	perf.snapshot = function()
		local t = {}
		for _, k in ipairs({"capOn", "cap", "low", "shadows", "fx", "flat", "post", "decals"}) do
			t[k] = S[k]
		end
		return t
	end
	perf.load = function(t)
		if type(t) ~= "table" then return end
		if type(t.cap) == "number" then
			S.cap = math.clamp(math.floor(t.cap), 30, 999)
			capBox.Text = tostring(S.cap)
		end
		for key, fn in pairs(setters) do
			if type(t[key]) == "boolean" then
				if S[key] ~= t[key] then fn(t[key]) end
				sync["p_" .. key](t[key])
			end
		end
		if type(t.capOn) == "boolean" then
			setCapOn(t.capOn)
			sync.pCap(S.capOn)
		end
	end
	perf.reset = function()
		setBlack(false)
		sync.pBlack(false)
		applyPreset(1, true)
		S.cap = 240
		presetIdx = 1
		presetBtn.Text = "Preset: STOCK"
	end
	perf.cleanup = function()
		for k in pairs(watchers) do stopWatch(k) end
		setBlack(false)
	end
	perf.toggleBlack = function()
		setBlack(not S.black)
		sync.pBlack(S.black)
	end
	perf.setCapValue = function(v)
		S.cap = math.clamp(math.floor(v), 30, 999)
		capBox.Text = tostring(S.cap)
		setCapOn(true)
		sync.pCap(S.capOn)
		if S.capOn then notify("FPS Cap", tostring(S.cap), "ok") end
	end
	perf.presetByName = function(name)
		name = string.upper(name or "")
		for i, p in ipairs(PRESETS) do
			if p[1] == name then
				presetIdx = i
				applyPreset(i)
				presetBtn.Text = ("Preset: %s"):format(p[1])
				return true
			end
		end
		return false
	end
	perf.clean = function()
		local before = memMb()
		pcall(function() collectgarbage("collect") end)
		task.wait(0.2)
		notify("Memory", ("%d MB  ->  %d MB"):format(math.floor(before), math.floor(memMb())), "ok")
	end
end

local function resetAll()
	stopFly() sync.fly(false)
	setNoclip(false) sync.noclip(false)
	stopFollow() stopSpectate()
	state.cframeSpeed, state.forceJump, state.infJump = false, false, false
	sync.cfSpeed(false) sync.forceJump(false) sync.infJump(false)
	state.spin, state.clickTP = false, false
	sync.spin(false) sync.clickTP(false)
	setFreecam(false) sync.freecam(false)
	setFreeze(false) sync.freeze(false)
	setInvis(false) sync.invis(false)
	setCharAnim(false) sync.charAnim(false)
	state.bhop, state.slowFall, state.antiVoid = false, false, false
	state.fallSpeed, state.dashPower = 20, 90
	sync.bhop(false) sync.slowFall(false) sync.antiVoid(false)
	state.sprint, state.sprintBoost = false, 30
	sync.sprint(false)
	state.vehFly, state.vehSpeed, state.vehFace = false, 100, true
	sync.vehFly(false) sync.vehFace(true)
	veh.stop()
	state.walkOn, state.jumpOn, state.gravityOn, state.fovOn, state.zoomOn = false, false, false, false, false
	state.flySpeed, state.spinSpeed = 70, 360
	state.walkSpeed, state.jumpPower = defaults.walk, defaults.jump
	state.gravity, state.fov, state.zoom = defaults.gravity, defaults.fov, defaults.zoom
	state.fullbright, state.noFog, state.clockOn = false, false, false
	sync.fullbright(false) sync.noFog(false)
	restoreLighting()
	Lighting.ClockTime = savedClock
	esp.on, esp.box, esp.name, esp.health, esp.distance = false, false, false, false, false
	esp.item, esp.chams, esp.tracers = false, false, false
	esp.skeleton, esp.colorMode, esp.fixedIdx = false, "Team", 1
	esp.hideTeam, esp.maxDist, esp.tracerOrigin = false, 2000, "Bottom"
	esp.tracerThick, esp.tracerAlpha, esp.boxAlpha = 1, 0.7, 1
	esp.textAlpha, esp.skelAlpha, esp.chamFill = 1, 0.9, 0.5
	sync.esp(false) sync.espBox(false) sync.espName(false) sync.espHealth(false)
	sync.espDist(false) sync.espItem(false) sync.espChams(false) sync.espTracers(false)
	sync.espSkeleton(false) sync.espHideTeam(false)
	ui.tracerBtn.Text = "Origin: Bottom"
	ui.colorBtn.Text = "Color: Team"
	ui.fixedBtn.Text = "Fixed Color: Red"
	ui.crosshair.Visible = false sync.crosshair(false)
	fx.cc.Saturation, fx.cc.Contrast, fx.cc.Brightness = 0, 0, 0
	fx.cc.TintColor = Color3.new(1, 1, 1)
	fx.bloom.Enabled, fx.rays.Enabled, fx.idx = false, false, 1
	sync.bloom(false) sync.rays(false)
	ui.filterBtn.Text = "Filter: None"
	if fx.fp then
		fx.fp = false
		player.CameraMode = Enum.CameraMode.Classic
		sync.firstPerson(false)
	end
	aim.on, aim.key, aim.part, aim.fov, aim.smooth = false, "RMB", "Head", 150, 0.25
	aim.teamCheck, aim.wallCheck, aim.showFov = true, false, true
	aim.trigger, aim.trigDelay = false, 0.1
	sync.aimOn(false) sync.aimTeam(true) sync.aimWall(false) sync.aimFov(true)
	sync.trigger(false)
	aim.mode, aim.priority, aim.predict, aim.predictAmt = "Hold", "Cursor", false, 0.12
	aim.sticky, aim.maxDist, aim.snapline, aim.targetInfo = false, 1000, true, true
	aim.fovAlpha, aim.fovColor, aim.humanize = 0.35, "White", 0
	sync.aimPredict(false) sync.aimSticky(false) sync.aimSnap(true) sync.aimInfo(true)
	ui.aimModeBtn.Text = "Mode: Hold"
	ui.aimKeyBtn.Text = "Key: RMB"
	ui.aimPartBtn.Text = "Target: Head"
	ui.aimPrioBtn.Text = "Priority: Cursor"
	ui.aimFovColorBtn.Text = "FOV Color: White"
	radar.on, radar.range, radar.size, radar.corner = false, 200, 150, "Top Right"
	sync.radar(false)
	ui.radarPosBtn.Text = "Position: Top Right"
	radar.apply()
	perf.reset()
	if humanoid then
		humanoid.WalkSpeed = defaults.walk
		humanoid.UseJumpPower = true
		humanoid.JumpPower = defaults.jump
	end
	workspace.Gravity = defaults.gravity
	camera.FieldOfView = defaults.fov
	player.CameraMaxZoomDistance = defaults.zoom
	for _, t in ipairs(inputs) do t.Text = "" end
	refreshPlayers()
end

local function unload()
	resetAll()
	perf.cleanup()
	for _, c in ipairs(conns) do c:Disconnect() end
	for p in pairs(espObjects) do removeESP(p) end
	espFolder:Destroy()
	tracerGui:Destroy()
	notifGui:Destroy()
	blur:Destroy()
	for _, k in ipairs({"cc", "bloom", "rays"}) do fx[k]:Destroy() end
	gui:Destroy()
end

genv.NyxUnload = unload
local misc = builder(makeList(addTab("misc", ICONS.misc, "SETTINGS", 12)))
do
	local utilG = misc.group("\u{1F9F0}  UTILITY")
	utilG.toggle("Anti-AFK", true, function(on) state.antiAfk = on end)
	utilG.button("Reset All Settings", function()
		resetAll()
		setStatus("Settings reset")
	end)
	utilG.button("Forget Saved Key", function()
		if delfile and isfile and isfile(KEY_FILE) then
			pcall(delfile, KEY_FILE)
			setStatus("Saved key removed - you'll be asked next time")
		else
			setStatus("No saved key found")
		end
	end)
	utilG.button("Unload Hub", unload, C.danger)
end

do
	local AUTO_FILE = "NyxHub_autoload.json"
	local queueFn = queue_on_teleport or (syn and syn.queue_on_teleport)
		or (fluxus and fluxus.queue_on_teleport)
	local cfg = {on = false, src = "NyxHub.lua"}
	pcall(function()
		if isfile and readfile and isfile(AUTO_FILE) then
			local d = HttpService:JSONDecode(readfile(AUTO_FILE))
			if type(d) == "table" then
				cfg.on = d.on == true
				if type(d.src) == "string" and d.src ~= "" then cfg.src = d.src end
			end
		end
	end)
	local function save()
		if writefile then
			pcall(function() writefile(AUTO_FILE, HttpService:JSONEncode(cfg)) end)
		end
	end
	local function loaderCode()
		local tail = ' end) if not ok then warn("[Nyx Hub] autoload failed: " .. tostring(e)) end'
		if cfg.src:match("^https?://") then
			return ('local ok, e = pcall(function() loadstring(game:HttpGet(%q))()'):format(cfg.src) .. tail
		end
		return ('local ok, e = pcall(function() loadstring(readfile(%q))()'):format(cfg.src) .. tail
	end
	local AUTOEXEC_PATHS = {"autoexec/NyxHub_loader.lua", "../autoexec/NyxHub_loader.lua"}
	local function writeAutoexec(on)
		if not writefile then return false end
		local done = false
		for _, path in ipairs(AUTOEXEC_PATHS) do
			if on then
				if pcall(writefile, path, loaderCode()) then done = true end
			elseif delfile and isfile and isfile(path) then
				pcall(delfile, path)
			end
		end
		return done
	end
	local queued = false
	local function queueLoader()
		if not (cfg.on and queueFn) or queued then return end
		queued = true
		pcall(queueFn, loaderCode())
	end
	ui.queueLoader = queueLoader
	if cfg.on then pcall(queueLoader) end
	connect(player.OnTeleport, function(st)
		if st == Enum.TeleportState.Started then queueLoader() end
	end)
	local autoG = misc.group("\u{1F680}  AUTO LOAD")
	sync.autoLoad = autoG.toggle("Auto Load On Join", cfg.on, function(on)
		cfg.on = on
		save()
		local wrote = writeAutoexec(on)
		if on then queueLoader() end
		if on and not cfg.src:match("^https?://") and isfile and not isfile(cfg.src) then
			setStatus(cfg.src .. " not found in workspace - save the script there")
			notify("Auto Load", "Save this script as " .. cfg.src .. " in your workspace folder", "warn")
		elseif on then
			if wrote then
				setStatus("Auto load on: runs on join + teleports")
			elseif queueFn then
				setStatus("Auto load on teleports only - put script in autoexec for joins")
			else
				setStatus("Executor can't auto load - use its autoexec folder")
			end
		else
			setStatus("Auto load off")
		end
	end)
	local srcBox = autoG.textInput("Script", "workspace file or URL")
	srcBox.Text = cfg.src
	srcBox.FocusLost:Connect(function()
		if srcBox.Text:gsub("%s", "") ~= "" then cfg.src = srcBox.Text end
		save()
	end)
	autoG.label("Save this script as NyxHub.lua in your executor's workspace")
	autoG.label("(or paste a URL). Turning this on also tries to write")
	autoG.label("a loader to your autoexec folder for fresh joins.")
end

local THEMES = {
	{"Purple", Color3.fromRGB(112, 92, 255)},
	{"Blue", Color3.fromRGB(64, 140, 255)},
	{"Cyan", Color3.fromRGB(40, 200, 220)},
	{"Green", Color3.fromRGB(60, 200, 110)},
	{"Pink", Color3.fromRGB(255, 90, 170)},
	{"Orange", Color3.fromRGB(255, 150, 50)},
	{"Red", Color3.fromRGB(235, 70, 80)},
	{"Teal", Color3.fromRGB(20, 184, 166)},
	{"Gold", Color3.fromRGB(250, 204, 21)},
	{"Lime", Color3.fromRGB(163, 230, 53)},
}

local themeIdx = 1
local menuScale = 1
local function setAccent(idx)
	themeIdx = idx
	local new = THEMES[idx][2]
	local old = C.accent
	if old == new then return end
	C.accent = new
	local function recolor(d)
		if d:IsA("GuiObject") then
			if d.BackgroundColor3 == old then d.BackgroundColor3 = new end
			if d:GetAttribute("base") == old then d:SetAttribute("base", new) end
		end
		if (d:IsA("TextLabel") or d:IsA("TextButton")) and d.TextColor3 == old then
			d.TextColor3 = new
		end
		if d:IsA("ScrollingFrame") and d.ScrollBarImageColor3 == old then
			d.ScrollBarImageColor3 = new
		end
		if d:IsA("UIStroke") and d.Color == old then d.Color = new end
	end
	for _, d in ipairs(hub:GetDescendants()) do recolor(d) end
	for _, d in ipairs(openBtn:GetDescendants()) do recolor(d) end
	recolor(openBtn)
	applyGradient(new)
end

do
	local themeG = misc.group("\u{1F308}  APPEARANCE")
	local themeNames = {}
	for _, th in ipairs(THEMES) do table.insert(themeNames, th[1]) end
	local themeBtn = themeG.dropdown("Accent", themeNames, "Purple", function(v)
		for i, th in ipairs(THEMES) do
			if th[1] == v then setAccent(i) end
		end
	end)
	local scaleBox = themeG.input("Menu Scale", 1, 0.6, 1.5, function(v)
		menuScale = v
		if hub.Visible then tween(hubScale, 0.2, {Scale = v}) end
	end)
	ui.themeBtn, ui.scaleBox = themeBtn, scaleBox
end

do
	local CONFIG_SLOTS = 5
	local cfgSlot = 1
	local function slotFile(i) return ("NyxHub_slot%d.json"):format(i) end
	local function hasSlot(i) return (isfile and isfile(slotFile(i))) and true or false end
	local function slotLabel()
		return ("Slot: %d  (%s)"):format(cfgSlot, hasSlot(cfgSlot) and "saved" or "empty")
	end
	local ESP_KEYS = {"on", "box", "name", "health", "distance", "item", "chams", "tracers",
	"tracerOrigin", "skeleton", "colorMode", "fixedIdx", "hideTeam", "maxDist",
	"tracerThick", "tracerAlpha", "boxAlpha", "textAlpha", "skelAlpha", "chamFill"}
	local AIM_SAVED = {"on", "key", "part", "fov", "smooth", "teamCheck", "wallCheck", "showFov", "trigger", "trigDelay",
	"mode", "priority", "predict", "predictAmt", "sticky", "maxDist", "snapline", "targetInfo", "fovAlpha", "fovColor", "humanize"}
	local RADAR_SAVED = {"on", "range", "size", "corner"}
	local STATE_KEYS = {"flySpeed", "spinSpeed", "walkOn", "walkSpeed", "jumpOn", "jumpPower",
		"cframeSpeed", "forceJump", "infJump", "spin", "clickTP", "noclip", "fullbright", "noFog",
		"fovOn", "fov", "gravityOn", "gravity", "bhop", "slowFall", "fallSpeed", "antiVoid", "dashPower",
	"sprint", "sprintBoost", "vehSpeed", "vehFace", "noCharAnim"}
	local ESP_SYNC = {
		on = "esp", box = "espBox", name = "espName", health = "espHealth", distance = "espDist",
		item = "espItem", chams = "espChams", tracers = "espTracers", skeleton = "espSkeleton",
		hideTeam = "espHideTeam",
	}
	local TOGGLE_SYNC = {
		noclip = "noclip", infJump = "infJump", cframeSpeed = "cfSpeed", forceJump = "forceJump",
		spin = "spin", clickTP = "clickTP", fullbright = "fullbright", noFog = "noFog",
		bhop = "bhop", slowFall = "slowFall", antiVoid = "antiVoid", sprint = "sprint", vehFace = "vehFace",
		noCharAnim = "charAnim",
	}
	local function pick(from, keys)
		local out = {}
		for _, k in ipairs(keys) do out[k] = from[k] end
		return out
	end
	local function merge(into, from, keys)
		if type(from) ~= "table" then return end
		for _, k in ipairs(keys) do
			if from[k] ~= nil and type(from[k]) == type(into[k]) then into[k] = from[k] end
		end
	end
	local function saveConfig(i)
		if not writefile then setStatus("Saving isn't supported here") return end
		local data = {
			esp = pick(esp, ESP_KEYS),
			aim = pick(aim, AIM_SAVED),
			radar = pick(radar, RADAR_SAVED),
			state = pick(state, STATE_KEYS),
			perf = perf.snapshot(),
			theme = themeIdx,
			scale = menuScale,
		}
		local ok = pcall(function() writefile(slotFile(i), HttpService:JSONEncode(data)) end)
		setStatus(ok and ("Saved to slot " .. i) or "Couldn't save config")
	end
	local function loadConfig(i)
		if not (readfile and hasSlot(i)) then setStatus("Slot " .. i .. " is empty") return end
		local ok, data = pcall(function() return HttpService:JSONDecode(readfile(slotFile(i))) end)
		if not ok or type(data) ~= "table" then setStatus("Slot " .. i .. " is corrupted") return end
		merge(esp, data.esp, ESP_KEYS)
		merge(aim, data.aim, AIM_SAVED)
		merge(radar, data.radar, RADAR_SAVED)
		merge(state, data.state, STATE_KEYS)
		if not FIXED_COLORS[esp.fixedIdx] then esp.fixedIdx = 1 end
		if not table.find(ui.COLOR_MODES, esp.colorMode) then esp.colorMode = "Team" end
		if not table.find({"Bottom", "Center", "Mouse"}, esp.tracerOrigin) then esp.tracerOrigin = "Bottom" end
		if not table.find(aim.keys, aim.key) then aim.key = "RMB" end
		if not aim.partNames[aim.part] then aim.part = "Head" end
		if aim.mode ~= "Hold" and aim.mode ~= "Toggle" then aim.mode = "Hold" end
		if not table.find({"Cursor", "Distance", "Health"}, aim.priority) then aim.priority = "Cursor" end
		if not table.find(FIXED_NAMES, aim.fovColor) then aim.fovColor = "White" end
		if not table.find(radar.corners, radar.corner) then radar.corner = "Top Right" end
		aim.fov = math.clamp(aim.fov, 20, 800)
		aim.smooth = math.clamp(aim.smooth, 0.02, 1)
		aim.trigDelay = math.clamp(aim.trigDelay, 0.02, 1)
		aim.predictAmt = math.clamp(aim.predictAmt, 0, 0.5)
		aim.maxDist = math.clamp(aim.maxDist, 50, 5000)
		aim.fovAlpha = math.clamp(aim.fovAlpha, 0, 1)
		aim.humanize = math.clamp(aim.humanize, 0, 1)
		esp.tracerThick = math.clamp(esp.tracerThick, 0.5, 4)
		esp.tracerAlpha = math.clamp(esp.tracerAlpha, 0, 1)
		esp.boxAlpha = math.clamp(esp.boxAlpha, 0, 1)
		esp.textAlpha = math.clamp(esp.textAlpha, 0, 1)
		esp.skelAlpha = math.clamp(esp.skelAlpha, 0, 1)
		esp.chamFill = math.clamp(esp.chamFill, 0, 1)
		radar.range = math.clamp(radar.range, 25, 2000)
		radar.size = math.clamp(radar.size, 80, 300)
		for key, name in pairs(ESP_SYNC) do sync[name](esp[key]) end
		ui.colorBtn.Text = "Color: " .. esp.colorMode
		ui.fixedBtn.Text = "Fixed Color: " .. FIXED_COLORS[esp.fixedIdx][1]
		ui.tracerBtn.Text = "Origin: " .. esp.tracerOrigin
		ui.maxDistBox.Text = tostring(esp.maxDist)
		ui.trThickBox.Text = tostring(esp.tracerThick)
		ui.trAlphaBox.Text = tostring(esp.tracerAlpha)
		ui.boxAlphaBox.Text = tostring(esp.boxAlpha)
		ui.skelAlphaBox.Text = tostring(esp.skelAlpha)
		ui.chamFillBox.Text = tostring(esp.chamFill)
		ui.textAlphaBox.Text = tostring(esp.textAlpha)
		sync.aimOn(aim.on) sync.aimTeam(aim.teamCheck) sync.aimWall(aim.wallCheck) sync.aimFov(aim.showFov)
		ui.aimModeBtn.Text = "Mode: " .. aim.mode
		ui.aimKeyBtn.Text = "Key: " .. aim.key
		ui.aimPartBtn.Text = "Target: " .. aim.partNames[aim.part]
		ui.aimPrioBtn.Text = "Priority: " .. aim.priority
		ui.aimFovColorBtn.Text = "FOV Color: " .. aim.fovColor
		sync.aimPredict(aim.predict) sync.aimSticky(aim.sticky)
		sync.aimSnap(aim.snapline) sync.aimInfo(aim.targetInfo)
		ui.aimPredBox.Text = tostring(aim.predictAmt)
		ui.aimMaxBox.Text = tostring(aim.maxDist)
		ui.aimFovAlphaBox.Text = tostring(aim.fovAlpha)
		ui.aimHumBox.Text = tostring(aim.humanize)
		ui.aimFovBox.Text = tostring(aim.fov)
		ui.aimSmoothBox.Text = tostring(aim.smooth)
		sync.trigger(aim.trigger)
		ui.trigDelayBox.Text = tostring(aim.trigDelay)
		sync.radar(radar.on)
		ui.radarRangeBox.Text = tostring(radar.range)
		ui.radarSizeBox.Text = tostring(radar.size)
		ui.radarPosBtn.Text = "Position: " .. radar.corner
		radar.apply()
		for key, name in pairs(TOGGLE_SYNC) do sync[name](state[key]) end
		setNoclip(state.noclip)
		setFullbright(state.fullbright)
		setNoFog(state.noFog)
		setCharAnim(state.noCharAnim)
		ui.flyBox.Text = tostring(state.flySpeed)
		ui.spinBox.Text = tostring(state.spinSpeed)
		if state.walkOn then ui.walkBox.Text = tostring(state.walkSpeed) end
		if state.jumpOn then ui.jumpBox.Text = tostring(state.jumpPower) end
		if state.fovOn then ui.fovBox.Text = tostring(state.fov) end
		if state.gravityOn then ui.gravBox.Text = tostring(state.gravity) end
		ui.vehBox.Text = tostring(state.vehSpeed)
		perf.load(data.perf)
		if type(data.theme) == "number" and THEMES[data.theme] then
			setAccent(data.theme)
			ui.themeBtn.Text = "Accent: " .. THEMES[themeIdx][1]
		end
		if type(data.scale) == "number" then
			menuScale = math.clamp(data.scale, 0.6, 1.5)
			ui.scaleBox.Text = tostring(menuScale)
			if hub.Visible then tween(hubScale, 0.2, {Scale = menuScale}) end
		end
		setStatus("Loaded slot " .. i)
	end
	local cfgG = misc.group("\u{1F4BE}  CONFIG SLOTS")
	local slotBtn = cfgG.button(slotLabel(), function(b)
		cfgSlot = cfgSlot % CONFIG_SLOTS + 1
		b.Text = slotLabel()
	end)
	cfgG.button("Save To Slot", function()
		saveConfig(cfgSlot)
		slotBtn.Text = slotLabel()
	end, C.accent)
	cfgG.button("Load From Slot", function() loadConfig(cfgSlot) end)
	cfgG.button("Delete Slot", function()
		if delfile and hasSlot(cfgSlot) then
			pcall(function() delfile(slotFile(cfgSlot)) end)
			setStatus("Deleted slot " .. cfgSlot)
		else
			setStatus("Slot " .. cfgSlot .. " is already empty")
		end
		slotBtn.Text = slotLabel()
	end, C.danger)
end

do
	local hudG = misc.group("\u{1F4CA}  HUD")
	sync.hudMark = hudG.toggle("Watermark (FPS / ping)", true, function(on) hud.watermark = on end)
	sync.hudList = hudG.toggle("Active Feature List", true, function(on) hud.list = on end)
	sync.menuBlur = hudG.toggle("Menu Background Blur", true, function(on)
		hud.blur = on
		if hub.Visible then tween(blur, 0.25, {Size = on and 14 or 0}) end
	end)
	hudG.button("Test Notification", function()
		notify("Nyx Hub", "Notifications look like this", "ok")
	end)
	local keyG = misc.group("\u{2328}  HOTKEYS")
	keyG.label("M  -  open / close menu")
	keyG.label("F  -  fly      N  -  noclip")
	keyG.label("J  -  infinite jump      K  -  ESP")
	keyG.label("P  -  freecam      G  -  freeze in place")
	keyG.label("I  -  invisible")
	keyG.label("V  -  dash      ;  -  command bar")
	keyG.label("B  -  AFK saver (3D rendering off)")
	keyG.label("/  -  search settings")
	keyG.label("H  -  vehicle fly")
	keyG.label("Tab  -  complete a command (command bar)")
	keyG.label("Hold Shift  -  sprint (if enabled)")
	keyG.label("Hold aim key  -  lock on (AIM tab)")
	keyG.label("Left Ctrl  -  hide all GUI")
	keyG.label("Alt + Click  -  teleport (if enabled)")
end

local hubOpen = false
local function setHub(open)
	hubOpen = open
	setBase(openBtn, open and C.accent or C.elem)
	if open then
		hub.Visible = true
		tween(hub, 0.25, {GroupTransparency = 0})
		if hud.blur then tween(blur, 0.3, {Size = 14}) end
		tween(hubScale, 0.35, {Scale = menuScale}, Enum.EasingStyle.Back)
	else
		tween(hub, 0.18, {GroupTransparency = 1})
		tween(blur, 0.2, {Size = 0})
		local tw = tween(hubScale, 0.18, {Scale = 0.9})
		tw.Completed:Connect(function()
			if not hubOpen then hub.Visible = false end
		end)
	end
end

openBtn.MouseButton1Click:Connect(function()
	if openMoved then openMoved = false return end
	setHub(not hubOpen)
end)

closeBtn.MouseButton1Click:Connect(function() setHub(false) end)
minBtn.MouseButton1Click:Connect(function() setHub(false) end)
showTab("movement")
local binds = {
	menu = Enum.KeyCode.M,
	fly = Enum.KeyCode.F,
	noclip = Enum.KeyCode.N,
	infJump = Enum.KeyCode.J,
	esp = Enum.KeyCode.K,
	freecam = Enum.KeyCode.P,
	freeze = Enum.KeyCode.G,
	hideGui = Enum.KeyCode.LeftControl,
}

local actions = {
	menu = function() setHub(not hubOpen) end,
	fly = function()
		if state.flying then stopFly() sync.fly(false) else startFly() sync.fly(true) end
	end,
	noclip = function() setNoclip(not state.noclip) sync.noclip(state.noclip) end,
	infJump = function() state.infJump = not state.infJump sync.infJump(state.infJump) end,
	esp = function() esp.on = not esp.on sync.esp(esp.on) end,
	freecam = function() setFreecam(not state.freecam) sync.freecam(state.freecam) end,
	freeze = function() setFreeze(not state.freeze) sync.freeze(state.freeze) end,
	hideGui = function() gui.Enabled = not gui.Enabled end,
}

binds.dash = Enum.KeyCode.V
binds.cmd = Enum.KeyCode.Semicolon
binds.black = Enum.KeyCode.B
binds.search = Enum.KeyCode.Slash
binds.vehFly = Enum.KeyCode.H
binds.invis = Enum.KeyCode.I
actions.dash = function() doDash() end
actions.invis = function()
	setInvis(not state.invis)
	sync.invis(state.invis)
end

actions.vehFly = function()
	state.vehFly = not state.vehFly
	sync.vehFly(state.vehFly)
	if state.vehFly and not (humanoid and humanoid.SeatPart) then setStatus("Sit in a vehicle first") end
	if not state.vehFly then veh.stop() end
end

actions.black = function() perf.toggleBlack() end
actions.search = function()
	setHub(true)
	ui.focusSearch()
end

do
	local INFO = {
		fly = {"Fly", function() return state.flying end},
		noclip = {"Noclip", function() return state.noclip end},
		infJump = {"Infinite Jump", function() return state.infJump end},
		esp = {"ESP", function() return esp.on end},
		freecam = {"Freecam", function() return state.freecam end},
		freeze = {"Freeze", function() return state.freeze end},
		black = {"AFK Saver", function() return perf.s.black end},
		vehFly = {"Vehicle Fly", function() return state.vehFly end},
		invis = {"Invisible", function() return state.invis end},
	}
	for key, info in pairs(INFO) do
		local fn = actions[key]
		actions[key] = function()
			fn()
			local on = info[2]() and true or false
			notify(info[1], on and "Enabled" or "Disabled", on and "ok" or "info")
		end
	end
end

do
	local bar = Instance.new("Frame")
	bar.AnchorPoint = Vector2.new(0.5, 1)
	bar.Position = UDim2.new(0.5, 0, 1, 60)
	bar.Size = UDim2.fromOffset(360, 42)
	bar.BackgroundColor3 = C.panel
	bar.BorderSizePixel = 0
	bar.Visible = false
	bar.Parent = notifGui
	corner(bar, 12)
	local bs = Instance.new("UIStroke")
	bs.Color = C.accent
	bs.Thickness = 1.5
	bs.Parent = bar
	local prompt = Instance.new("TextLabel")
	prompt.Size = UDim2.fromOffset(28, 42)
	prompt.Position = UDim2.fromOffset(6, 0)
	prompt.BackgroundTransparency = 1
	prompt.Text = ">"
	prompt.TextSize = 20
	prompt.Font = Enum.Font.GothamBlack
	prompt.TextColor3 = C.accent
	prompt.Parent = bar
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(1, -44, 1, 0)
	box.Position = UDim2.fromOffset(34, 0)
	box.BackgroundTransparency = 1
	box.PlaceholderText = "type a command...  (Tab completes)"
	box.PlaceholderColor3 = Color3.fromRGB(110, 110, 130)
	box.Text = ""
	box.ClearTextOnFocus = false
	box.TextSize = 14
	box.Font = Enum.Font.GothamMedium
	box.TextColor3 = C.text
	box.TextXAlignment = Enum.TextXAlignment.Left
	box.Parent = bar
	local sug = Instance.new("Frame")
	sug.AnchorPoint = Vector2.new(0, 1)
	sug.Position = UDim2.new(0, 0, 0, -8)
	sug.Size = UDim2.new(1, 0, 0, 0)
	sug.BackgroundColor3 = C.panel
	sug.BorderSizePixel = 0
	sug.ClipsDescendants = true
	sug.Visible = false
	sug.Parent = bar
	corner(sug, 12)
	local sugStroke = Instance.new("UIStroke")
	sugStroke.Color = C.off
	sugStroke.Thickness = 1.2
	sugStroke.Transparency = 0.3
	sugStroke.Parent = sug
	local sugList = Instance.new("ScrollingFrame")
	sugList.Size = UDim2.new(1, -8, 1, -8)
	sugList.Position = UDim2.fromOffset(4, 4)
	sugList.BackgroundTransparency = 1
	sugList.BorderSizePixel = 0
	sugList.ScrollBarThickness = 3
	sugList.ScrollBarImageColor3 = C.accent
	sugList.CanvasSize = UDim2.new()
	sugList.AutomaticCanvasSize = Enum.AutomaticSize.Y
	sugList.Parent = sug
	local slay = Instance.new("UIListLayout")
	slay.Padding = UDim.new(0, 2)
	slay.SortOrder = Enum.SortOrder.LayoutOrder
	slay.Parent = sugList
	local function findPlayer(q)
		q = string.lower(q)
		if q == "" then return nil end
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and (string.find(string.lower(p.Name), q, 1, true) == 1
					or string.find(string.lower(p.DisplayName), q, 1, true) == 1) then
				return p
			end
		end
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= player and (string.find(string.lower(p.Name), q, 1, true)
					or string.find(string.lower(p.DisplayName), q, 1, true)) then
				return p
			end
		end
	end
	local cmds = {}
	for name, key in pairs({fly = "fly", noclip = "noclip", esp = "esp", freecam = "freecam",
	freeze = "freeze", infjump = "infJump", invis = "invis"}) do
		cmds[name] = function() actions[key]() end
	end
	cmds.bright = function()
		local on = not state.fullbright
		setFullbright(on)
		sync.fullbright(on)
		notify("Fullbright", on and "Enabled" or "Disabled", on and "ok" or "info")
	end
	cmds.anim = function()
		local on = not state.noCharAnim
		setCharAnim(on)
		sync.charAnim(on)
		notify("Character Anims", on and "Disabled" or "Enabled", on and "info" or "ok")
	end
	cmds.aim = function()
		aim.on = not aim.on
		sync.aimOn(aim.on)
		notify("Aimlock", aim.on and "Enabled" or "Disabled", aim.on and "ok" or "info")
	end
	cmds.trigger = function()
		aim.trigger = not aim.trigger
		sync.trigger(aim.trigger)
		notify("Triggerbot", aim.trigger and "Enabled" or "Disabled", aim.trigger and "ok" or "info")
	end
	cmds.radar = function()
		radar.on = not radar.on
		sync.radar(radar.on)
		notify("Radar", radar.on and "Enabled" or "Disabled", radar.on and "ok" or "info")
	end
	cmds.dash = function() doDash() end
	cmds.vfly = function() actions.vehFly() end
	cmds.vspeed = function(a)
		local v = tonumber(a)
		if not v then notify("vspeed", "usage: vspeed 150", "warn") return end
		v = math.clamp(v, 5, 500)
		state.vehSpeed = v
		ui.vehBox.Text = tostring(v)
		notify("Vehicle Speed", tostring(v), "ok")
	end
	cmds.afk = function() actions.black() end
	cmds.sit = function() if humanoid then humanoid.Sit = true end end
	cmds.clean = function() task.spawn(perf.clean) end
	cmds.fps = function(a)
		local v = tonumber(a)
		if not v then notify("fps", "usage: fps 240", "warn") return end
		perf.setCapValue(v)
	end
	cmds.boost = function(a)
		if not perf.presetByName(a) then
			notify("boost", "usage: boost stock|boost|turbo|insane", "warn")
		end
	end
	cmds.speed = function(a)
		local v = tonumber(a)
		if not v then notify("speed", "usage: speed 100", "warn") return end
		v = math.clamp(v, 0, 500)
		state.walkSpeed, state.walkOn = v, true
		ui.walkBox.Text = tostring(v)
		if humanoid and not state.cframeSpeed then humanoid.WalkSpeed = v end
		notify("WalkSpeed", tostring(v), "ok")
	end
	cmds.jump = function(a)
		local v = tonumber(a)
		if not v then notify("jump", "usage: jump 100", "warn") return end
		v = math.clamp(v, 0, 500)
		state.jumpPower, state.jumpOn = v, true
		ui.jumpBox.Text = tostring(v)
		if humanoid and not state.forceJump then
			humanoid.UseJumpPower = true
			humanoid.JumpPower = v
		end
		notify("JumpPower", tostring(v), "ok")
	end
	cmds.fov = function(a)
		local v = tonumber(a)
		if not v then notify("fov", "usage: fov 90", "warn") return end
		v = math.clamp(v, 30, 120)
		state.fov, state.fovOn = v, true
		ui.fovBox.Text = tostring(v)
		camera.FieldOfView = v
		notify("Field of View", tostring(v), "ok")
	end
	cmds.gravity = function(a)
		local v = tonumber(a)
		if not v then notify("gravity", "usage: gravity 50", "warn") return end
		v = math.clamp(v, 0, 500)
		state.gravity, state.gravityOn = v, true
		ui.gravBox.Text = tostring(v)
		workspace.Gravity = v
		notify("Gravity", tostring(v), "ok")
	end
	cmds.flyspeed = function(a)
		local v = tonumber(a)
		if not v then notify("flyspeed", "usage: flyspeed 100", "warn") return end
		v = math.clamp(v, 1, 500)
		state.flySpeed = v
		ui.flyBox.Text = tostring(v)
		notify("Fly Speed", tostring(v), "ok")
	end
	cmds["goto"] = function(a)
		local p = findPlayer(a)
		if p then teleportToPlayer(p) else notify("goto", "player not found", "warn") end
	end
	cmds.spawn = function()
		if root and spawnCFrame then
			root.AssemblyLinearVelocity = Vector3.zero
			root.CFrame = spawnCFrame + Vector3.new(0, 3, 0)
		end
	end
	cmds.reset = function() if humanoid then humanoid.Health = 0 end end
	cmds.rejoin = function() rejoin() end
	cmds.hop = function() serverHop("random") end
	cmds.unload = function() unload() end
	cmds.tab = function(a)
		local q = string.lower(a)
		if q == "" then notify("tab", "usage: tab esp", "warn") return end
		for id, t in pairs(tabs) do
			if string.find(string.lower(t.title), q, 1, true) == 1 or string.find(id, q, 1, true) == 1 then
				setHub(true)
				showTab(id)
				return
			end
		end
		notify("tab", "no tab named " .. a, "warn")
	end
	cmds.search = function(a)
		setHub(true)
		ui.setSearch(a)
	end
	cmds.theme = function(a)
		local q = string.lower(a)
		for i, t in ipairs(THEMES) do
			if q ~= "" and string.find(string.lower(t[1]), q, 1, true) == 1 then
				setAccent(i)
				ui.themeBtn.Text = "Accent: " .. t[1]
				notify("Theme", t[1], "ok")
				return
			end
		end
		notify("theme", "usage: theme purple|blue|cyan|green|pink|orange|red|teal|gold|lime", "warn")
	end
	cmds.help = function()
		notify("Commands", "open the bar with ;  then Tab completes", "info")
		notify("Search", "press /  to search every setting", "info")
	end
	local USAGE = {
		afk = {"", "toggle AFK saver (3D off)"},
		aim = {"", "toggle aimlock"},
		anim = {"", "toggle character animations"},
		boost = {"[preset]", "stock / boost / turbo / insane"},
		bright = {"", "toggle fullbright"},
		clean = {"", "free up memory"},
		dash = {"", "dash forward"},
		esp = {"", "toggle ESP"},
		fly = {"", "toggle flight"},
		flyspeed = {"[number]", "set fly speed"},
		fov = {"[30-120]", "set field of view"},
		fps = {"[30-999]", "unlock + set FPS cap"},
		freecam = {"", "toggle freecam"},
		freeze = {"", "freeze in place"},
		["goto"] = {"[player]", "teleport to a player"},
		gravity = {"[number]", "set gravity"},
		help = {"", "how the command bar works"},
		hop = {"", "server hop"},
		infjump = {"", "toggle infinite jump"},
		invis = {"", "toggle invisible"},
		jump = {"[number]", "set jump power"},
		noclip = {"", "toggle noclip"},
		radar = {"", "toggle radar"},
		rejoin = {"", "rejoin this server"},
		reset = {"", "reset your character"},
		search = {"[text]", "search settings"},
		sit = {"", "sit down"},
		spawn = {"", "teleport to spawn"},
		speed = {"[number]", "set walk speed"},
		tab = {"[name]", "open a tab"},
		trigger = {"", "toggle triggerbot"},
		theme = {"[color]", "change accent color"},
		unload = {"", "unload the hub"},
		vfly = {"", "toggle vehicle fly"},
		vspeed = {"[number]", "set vehicle fly speed"},
	}
	local names = {}
	for k in pairs(cmds) do table.insert(names, k) end
	table.sort(names)
	local function resolve(cmd)
		cmd = string.lower(cmd)
		if cmds[cmd] then return cmd end
		local found
		for _, n in ipairs(names) do
			if string.sub(n, 1, #cmd) == cmd then
				if found then return nil end
				found = n
			end
		end
		return found
	end
	local function run(text)
		local cmd, arg = string.match(text, "^%s*(%S+)%s*(.-)%s*$")
		if not cmd then return end
		local name = resolve(cmd)
		if name then
			local ok, err = pcall(cmds[name], arg)
			if not ok then notify("Command failed", string.sub(tostring(err), 1, 40), "err") end
		else
			notify("Unknown command", cmd .. "   (open the list with ;)", "warn")
		end
	end
	local isOpen = false
	local curMatches, selIdx = {}, 1
	local ROW_H = 26
	local function complete(name)
		box.Text = name .. " "
		box.CursorPosition = #box.Text + 1
	end
	local function refreshSug()
		for _, c in ipairs(sugList:GetChildren()) do
			if c:IsA("GuiObject") then c:Destroy() end
		end
		if not isOpen then return end
		local first, rest = string.match(box.Text, "^%s*(%S*)(.*)$")
		first = string.lower(first or "")
		rest = rest or ""
		local matches = {}
		if rest ~= "" and cmds[first] then
			matches = {first}
		else
			for _, n in ipairs(names) do
				if first == "" or string.sub(n, 1, #first) == first then table.insert(matches, n) end
			end
			if #matches == 0 then
				for _, n in ipairs(names) do
					if string.find(n, first, 1, true) then table.insert(matches, n) end
				end
			end
		end
		curMatches = matches
		selIdx = math.clamp(selIdx, 1, math.max(#matches, 1))
		if #matches == 0 then
			local l = Instance.new("TextLabel")
			l.Size = UDim2.new(1, 0, 0, ROW_H)
			l.BackgroundTransparency = 1
			l.Text = "no matching command"
			l.TextSize = 12
			l.Font = Enum.Font.GothamMedium
			l.TextColor3 = C.sub
			l.Parent = sugList
		end
		local accentHex = C.accent:ToHex()
		for i, n in ipairs(matches) do
			local u = USAGE[n] or {"", ""}
			local row = Instance.new("TextButton")
			row.Size = UDim2.new(1, 0, 0, ROW_H)
			row.LayoutOrder = i
			row.BorderSizePixel = 0
			row.AutoButtonColor = false
			row.Text = ""
			row.BackgroundColor3 = C.accent
			row.BackgroundTransparency = (i == selIdx) and 0.72 or 1
			row.Parent = sugList
			corner(row, 6)
			local nl = Instance.new("TextLabel")
			nl.Size = UDim2.new(0.5, -10, 1, 0)
			nl.Position = UDim2.fromOffset(10, 0)
			nl.BackgroundTransparency = 1
			nl.RichText = true
			nl.Text = ('<font color="#%s">%s</font>  <font color="#96969c">%s</font>'):format(accentHex, n, u[1])
			nl.TextSize = 13
			nl.Font = Enum.Font.GothamBold
			nl.TextColor3 = C.text
			nl.TextXAlignment = Enum.TextXAlignment.Left
			nl.TextTruncate = Enum.TextTruncate.AtEnd
			nl.Parent = row
			local dl = Instance.new("TextLabel")
			dl.Size = UDim2.new(0.5, -10, 1, 0)
			dl.Position = UDim2.new(0.5, 0, 0, 0)
			dl.BackgroundTransparency = 1
			dl.Text = u[2]
			dl.TextSize = 12
			dl.Font = Enum.Font.GothamMedium
			dl.TextColor3 = C.sub
			dl.TextXAlignment = Enum.TextXAlignment.Right
			dl.TextTruncate = Enum.TextTruncate.AtEnd
			dl.Parent = row
			row.MouseButton1Click:Connect(function()
				complete(n)
				box:CaptureFocus()
				box.CursorPosition = #box.Text + 1
			end)
		end
		local rows = math.max(#matches, 1)
		local h = math.min(rows, 8) * (ROW_H + 2) + 8
		sug.Visible = true
		tween(sug, 0.12, {Size = UDim2.new(1, 0, 0, h)})
		local top = sugList.CanvasPosition.Y
		local rowTop = (selIdx - 1) * (ROW_H + 2)
		local view = h - 8
		if rowTop < top then
			top = rowTop
		elseif rowTop + ROW_H > top + view then
			top = rowTop + ROW_H - view
		end
		sugList.CanvasPosition = Vector2.new(0, math.max(top, 0))
	end
	box:GetPropertyChangedSignal("Text"):Connect(function()
		selIdx = 1
		refreshSug()
	end)
	connect(UIS.InputBegan, function(input)
		if not (isOpen and box:IsFocused()) or #curMatches == 0 then return end
		local k = input.KeyCode
		if k == Enum.KeyCode.Tab then
			complete(curMatches[selIdx])
		elseif k == Enum.KeyCode.Down then
			selIdx = selIdx % #curMatches + 1
			refreshSug()
		elseif k == Enum.KeyCode.Up then
			selIdx = (selIdx - 2) % #curMatches + 1
			refreshSug()
		end
	end)
	local function openBar()
		isOpen = true
		bar.Visible = true
		bs.Color = C.accent
		prompt.TextColor3 = C.accent
		tween(bar, 0.3, {Position = UDim2.new(0.5, 0, 1, -24)}, Enum.EasingStyle.Back)
		box.Text = ""
		box:CaptureFocus()
		task.defer(function()
			box.Text = ""
			selIdx = 1
			refreshSug()
		end)
		task.delay(0.05, function() if box.Text == ";" then box.Text = "" end end)
	end
	local function closeBar()
		isOpen = false
		tween(bar, 0.2, {Position = UDim2.new(0.5, 0, 1, 60)})
		task.delay(0.22, function()
			if not isOpen then
				bar.Visible = false
				sug.Visible = false
				sug.Size = UDim2.new(1, 0, 0, 0)
			end
		end)
	end
	box.FocusLost:Connect(function(enter)
		local text = box.Text
		if enter then
			closeBar()
			if text ~= "" then run(text) end
		else
			task.delay(0.25, function()
				if isOpen and not box:IsFocused() then closeBar() end
			end)
		end
	end)
	actions.cmd = function()
		if isOpen then box:ReleaseFocus() else openBar() end
	end
end

do
	local LINE = Color3.fromRGB(50, 50, 62)
	local mark = Instance.new("Frame")
	mark.Name = "NyxBar"
	mark.AnchorPoint = Vector2.new(0.5, 0)
	mark.Position = UDim2.new(0.5, 0, 0, 12)
	mark.Size = UDim2.fromOffset(0, 38)
	mark.AutomaticSize = Enum.AutomaticSize.X
	mark.BackgroundColor3 = Color3.fromRGB(10, 10, 13)
	mark.BackgroundTransparency = 0.05
	mark.BorderSizePixel = 0
	mark.Parent = notifGui
	corner(mark, 12)
	padding(mark, 10, 0, 16, 0)
	local ms = Instance.new("UIStroke")
	ms.Color = LINE
	ms.Thickness = 1
	ms.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	ms.Parent = mark
	local ml = Instance.new("UIListLayout")
	ml.FillDirection = Enum.FillDirection.Horizontal
	ml.VerticalAlignment = Enum.VerticalAlignment.Center
	ml.SortOrder = Enum.SortOrder.LayoutOrder
	ml.Padding = UDim.new(0, 10)
	ml.Parent = mark
	local av = Instance.new("ImageLabel")
	av.Size = UDim2.fromOffset(26, 26)
	av.BackgroundColor3 = C.elem
	av.BorderSizePixel = 0
	av.LayoutOrder = 1
	av.Parent = mark
	corner(av, 13)
	task.spawn(function()
		local ok, img = pcall(function()
			return Players:GetUserThumbnailAsync(player.UserId,
				Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
		end)
		if ok and av.Parent then av.Image = img end
	end)
	local nm = Instance.new("TextLabel")
	nm.Size = UDim2.fromOffset(0, 20)
	nm.AutomaticSize = Enum.AutomaticSize.X
	nm.BackgroundTransparency = 1
	nm.Text = "Nyx Universal"
	nm.TextSize = 14
	nm.Font = Enum.Font.GothamBold
	nm.TextColor3 = C.text
	nm.LayoutOrder = 2
	nm.Parent = mark
	local function sep(o)
		local f = Instance.new("Frame")
		f.Size = UDim2.fromOffset(1, 18)
		f.BackgroundColor3 = LINE
		f.BorderSizePixel = 0
		f.LayoutOrder = o
		f.Parent = mark
	end
	local function stat(o, width)
		local g = Instance.new("Frame")
		g.Size = UDim2.fromOffset(0, 20)
		g.AutomaticSize = Enum.AutomaticSize.X
		g.BackgroundTransparency = 1
		g.LayoutOrder = o
		g.Parent = mark
		local l = Instance.new("UIListLayout")
		l.FillDirection = Enum.FillDirection.Horizontal
		l.VerticalAlignment = Enum.VerticalAlignment.Center
		l.SortOrder = Enum.SortOrder.LayoutOrder
		l.Padding = UDim.new(0, 7)
		l.Parent = g
		local icon = Instance.new("Frame")
		icon.Size = UDim2.fromOffset(16, 16)
		icon.BackgroundTransparency = 1
		icon.LayoutOrder = 1
		icon.Parent = g
		local t = Instance.new("TextLabel")
		t.Size = UDim2.fromOffset(width, 20)
		t.BackgroundTransparency = 1
		t.RichText = true
		t.Text = ""
		t.TextSize = 14
		t.Font = Enum.Font.GothamBold
		t.TextColor3 = C.text
		t.TextXAlignment = Enum.TextXAlignment.Left
		t.LayoutOrder = 2
		t.Parent = g
		return icon, t
	end
	local function block(parent, x, y, w, h, r)
		local f = Instance.new("Frame")
		f.Position = UDim2.fromOffset(x, y)
		f.Size = UDim2.fromOffset(w, h)
		f.BackgroundColor3 = C.sub
		f.BorderSizePixel = 0
		f.Parent = parent
		if r then corner(f, r) end
		return f
	end
	sep(3)
	local pingIcon, pingLabel = stat(4, 52)
	local pingBars = {}
	for i = 1, 4 do
		local b = block(pingIcon, (i - 1) * 4, 16 - (3 + i * 3), 3, 3 + i * 3, 1)
		pingBars[i] = b
	end
	sep(5)
	local fpsIcon, fpsLabel = stat(6, 60)
	do
		local ring = Instance.new("Frame")
		ring.Position = UDim2.fromOffset(2, 3)
		ring.Size = UDim2.fromOffset(12, 12)
		ring.BackgroundTransparency = 1
		ring.Parent = fpsIcon
		corner(ring, 6)
		local rs = Instance.new("UIStroke")
		rs.Color = C.sub
		rs.Thickness = 1.5
		rs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		rs.Parent = ring
		block(fpsIcon, 6, 0, 4, 2, 1)
		block(fpsIcon, 7, 5, 2, 4, 1)
	end
	sep(7)
	local plrIcon, plrLabel = stat(8, 78)
	block(plrIcon, 5, 1, 6, 6, 3)
	block(plrIcon, 2, 9, 12, 7, 5)
	local UNIT = '<font color="#8A8A99">%s</font>'
	local function updateMark(fps, ping)
		pingLabel.Text = ("%d "):format(ping) .. UNIT:format("ms")
		fpsLabel.Text = ("%d "):format(fps) .. UNIT:format("fps")
		local n = #Players:GetPlayers()
		plrLabel.Text = ("%d "):format(n) .. UNIT:format(n == 1 and "player" or "players")
		local lit = ping < 70 and 4 or (ping < 130 and 3 or (ping < 220 and 2 or 1))
		local col = lit >= 3 and Color3.fromRGB(60, 235, 110)
			or (lit == 2 and Color3.fromRGB(255, 200, 70) or Color3.fromRGB(255, 80, 80))
		for i, b in ipairs(pingBars) do
			b.BackgroundColor3 = (i <= lit) and col or LINE
		end
	end
	local list = Instance.new("Frame")
	list.AnchorPoint = Vector2.new(1, 0.5)
	list.Position = UDim2.new(1, -10, 0.5, 0)
	list.Size = UDim2.fromOffset(180, 0)
	list.AutomaticSize = Enum.AutomaticSize.Y
	list.BackgroundTransparency = 1
	list.Parent = notifGui
	local lay = Instance.new("UIListLayout")
	lay.Padding = UDim.new(0, 2)
	lay.SortOrder = Enum.SortOrder.LayoutOrder
	lay.HorizontalAlignment = Enum.HorizontalAlignment.Right
	lay.Parent = list
	local FEATURES = {
		{"Fly", function() return state.flying end},
		{"Noclip", function() return state.noclip end},
		{"Invisible", function() return state.invis end},
		{"No Char Anims", function() return state.noCharAnim end},
		{"Speed Bypass", function() return state.cframeSpeed end},
		{"Sprint", function() return state.sprint end},
		{"Vehicle Fly", function() return state.vehFly end},
		{"Jump Bypass", function() return state.forceJump end},
		{"Infinite Jump", function() return state.infJump end},
		{"Bunny Hop", function() return state.bhop end},
		{"Slow Fall", function() return state.slowFall end},
		{"Anti-Void", function() return state.antiVoid end},
		{"Spin", function() return state.spin end},
		{"Click TP", function() return state.clickTP end},
		{"Freecam", function() return state.freecam end},
		{"Freeze", function() return state.freeze end},
		{"Fullbright", function() return state.fullbright end},
		{"No Fog", function() return state.noFog end},
		{"ESP", function() return esp.on end},
		{"Aimlock", function() return aim.on end},
		{"Triggerbot", function() return aim.trigger end},
		{"Radar", function() return radar.on end},
		{"FPS Unlocked", function() return perf.s.capOn end},
		{"Low Graphics", function() return perf.s.low end},
		{"Potato Mode", function() return perf.s.flat end},
		{"AFK Saver", function() return perf.s.black end},
	}
	local rows, shown = {}, {}
	for i, f in ipairs(FEATURES) do
		local l = Instance.new("TextLabel")
		l.Size = UDim2.fromOffset(0, 16)
		l.AutomaticSize = Enum.AutomaticSize.X
		l.BackgroundTransparency = 1
		l.Text = f[1]
		l.TextSize = 13
		l.Font = Enum.Font.GothamBold
		l.TextColor3 = C.accent
		l.TextStrokeColor3 = Color3.new(0, 0, 0)
		l.TextStrokeTransparency = 1
		l.TextTransparency = 1
		l.TextXAlignment = Enum.TextXAlignment.Right
		l.Visible = false
		l.LayoutOrder = i
		l.Parent = list
		rows[f[1]] = l
		shown[f[1]] = false
	end
	local acc, frames = 0, 0
	connect(RunService.Heartbeat, function(dt)
		frames += 1
		acc += dt
		if acc < 0.25 then return end
		local fps = math.floor(frames / acc + 0.5)
		acc, frames = 0, 0
		mark.Visible = hud.watermark
		if hud.watermark then
			updateMark(fps, math.floor(player:GetNetworkPing() * 1000))
		end
		list.Visible = hud.list
		if hud.list then
			for _, f in ipairs(FEATURES) do
				local lbl = rows[f[1]]
				local on = f[2]() and true or false
				if on ~= shown[f[1]] then
					shown[f[1]] = on
					if on then
						lbl.Visible = true
						lbl.TextTransparency = 1
						tween(lbl, 0.25, {TextTransparency = 0, TextStrokeTransparency = 0.5})
					else
						local tw = tween(lbl, 0.25, {TextTransparency = 1, TextStrokeTransparency = 1})
						tw.Completed:Connect(function()
							if not shown[f[1]] then lbl.Visible = false end
						end)
					end
				end
				lbl.TextColor3 = C.accent
			end
		end
	end)
end

connect(UIS.InputBegan, function(input)
	if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
	if UIS:GetFocusedTextBox() then return end
	for name, key in pairs(binds) do
		if input.KeyCode == key then actions[name]() end
	end
end)

notify("Nyx Hub loaded", "M = menu    ; = commands    / = search", "ok")
print("[Nyx Hub] loaded OK")

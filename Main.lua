--[[ Oc1DvHUB - FINAL + Air Hub Features
     - Tab: Rumah, Fake Purchase, MemeRush, Universal, Live, Tema, Misc, Credit
     - Semua fitur Air Hub (TpWalk, Auto Attack, dll) dalam UI RRFMLY
]]
print("[Oc1DvHUB] Loading FINAL + Air Hub...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local Debris = game:GetService("Debris")
local Stats = game:GetService("Stats")
local MPS = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LP = Players.LocalPlayer

local CONFIG = {
    DISCORD = "https://discord.gg/wtVKkDvyz",
    LOGO = "rbxassetid://78682047053280",
    SND = "rbxassetid://7405483764",
}

local BG_LIST = {
    {name = "UTAMA", id = "rbxassetid://124159830401488"},
    {name = "LANSKYP", id = "rbxassetid://70693066629625"},
    {name = "LUFFY", id = "rbxassetid://77692656015127"},
    {name = "TEXT", id = "rbxassetid://136619070579232"},
    {name = "MBG BLUE", id = "rbxassetid://75442560708193"},
}

local IC = {
    Rumah = "rbxassetid://10734950020",
    Fake = "rbxassetid://10734950309",
    MemeRush = "rbxassetid://10734942198",
    Universal = "rbxassetid://10734961809",
    Live = "rbxassetid://10734942198",
    Tema = "rbxassetid://10734961809",
    Misc = "rbxassetid://10734961809",
    Credit = "rbxassetid://10734950309",
}

local C = {
    Pri = Color3.fromRGB(255, 145, 80),
    PriDark = Color3.fromRGB(210, 110, 55),
    Bg = Color3.fromRGB(24, 24, 28),
    Panel = Color3.fromRGB(34, 34, 40),
    Card = Color3.fromRGB(44, 44, 52),
    Txt = Color3.fromRGB(240, 240, 245),
    Dim = Color3.fromRGB(150, 150, 160),
    Off = Color3.fromRGB(70, 70, 78),
    Red = Color3.fromRGB(255, 100, 110),
    Grn = Color3.fromRGB(110, 220, 140),
    Yel = Color3.fromRGB(255, 210, 110),
    Cyn = Color3.fromRGB(110, 200, 245),
    Stroke = Color3.fromRGB(255,255,255),
}

local S = {
    StartTime = os.time(),
    GameName = "Loading...",
    curBG = 1, selBG = 1,
    HueColor = C.Pri,
    BGBrightness = 0.55,
    MiniMode = true,
    FPRunning = false,
}

local colorEls = {}
local function track(obj, prop) table.insert(colorEls, {obj = obj, prop = prop}) end

local function applyColor(newC)
    C.Pri = newC
    C.PriDark = Color3.new(newC.R*0.82, newC.G*0.82, newC.B*0.82)
    for _, e in ipairs(colorEls) do
        if e.obj and e.obj.Parent then
            pcall(function() e.obj[e.prop] = newC end)
        end
    end
end

local searchables = {}
local function trackSearch(frame, text)
    frame:SetAttribute("SearchText", string.lower(text))
    table.insert(searchables, frame)
end

local pg = LP:WaitForChild("PlayerGui", 10) or game:GetService("CoreGui")
local old = pg:FindFirstChild("Oc1DvHUB_UI")
if old then old:Destroy() end

task.spawn(function()
    local ok, info = pcall(function() return MPS:GetProductInfo(game.PlaceId) end)
    S.GameName = (ok and info and info.Name) or "Unknown"
end)

local function sfx()
    pcall(function()
        local s = Instance.new("Sound")
        s.SoundId = CONFIG.SND; s.Volume = 0.25; s.Parent = pg
        s:Play(); Debris:AddItem(s, 2)
    end)
end

local SG = Instance.new("ScreenGui")
SG.Name = "Oc1DvHUB_UI"
SG.ResetOnSpawn = false
SG.IgnoreGuiInset = true
SG.Parent = pg

-- Notify system
local NotifyContainer = Instance.new("Frame")
NotifyContainer.Size = UDim2.new(0, 300, 0, 400)
NotifyContainer.Position = UDim2.new(1, -310, 1, -410)
NotifyContainer.BackgroundTransparency = 1
NotifyContainer.ZIndex = 490
NotifyContainer.Parent = SG

local NotifyLayout = Instance.new("UIListLayout", NotifyContainer)
NotifyLayout.FillDirection = Enum.FillDirection.Vertical
NotifyLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifyLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotifyLayout.Padding = UDim.new(0, 6)

local function NotifyUser(title, msg, tp)
    tp = tp or "info"
    local colors = {success=C.Grn, error=C.Red, warn=C.Yel, info=C.Cyn}
    local iconTxt = {success="OK", error="X", warn="!", info="i"}
    local card = Instance.new("Frame")
    card.Size = UDim2.new(0, 290, 0, 60)
    card.BackgroundColor3 = Color3.fromRGB(22,22,28)
    card.BackgroundTransparency = 0.08
    card.BorderSizePixel = 0
    card.ZIndex = 500
    card.Parent = NotifyContainer
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,10)
    local stroke = Instance.new("UIStroke", card)
    stroke.Color = colors[tp] or C.Pri
    stroke.Thickness = 1.5
    stroke.Transparency = 0.2
    stroke.Parent = card
    local accent = Instance.new("Frame", card)
    accent.Size = UDim2.new(0, 4, 1, -8)
    accent.Position = UDim2.new(0, 4, 0, 4)
    accent.BackgroundColor3 = colors[tp] or C.Pri
    accent.BorderSizePixel = 0
    accent.ZIndex = 501
    Instance.new("UICorner", accent).CornerRadius = UDim.new(1,0)
    local iconBox = Instance.new("Frame", card)
    iconBox.Size = UDim2.new(0, 32, 0, 32)
    iconBox.Position = UDim2.new(0, 16, 0.5, -16)
    iconBox.BackgroundColor3 = colors[tp] or C.Pri
    iconBox.BackgroundTransparency = 0.15
    iconBox.BorderSizePixel = 0
    iconBox.ZIndex = 501
    Instance.new("UICorner", iconBox).CornerRadius = UDim.new(1,0)
    local icon = Instance.new("TextLabel", iconBox)
    icon.Size = UDim2.new(1,0,1,0)
    icon.BackgroundTransparency = 1
    icon.Text = iconTxt[tp] or "i"
    icon.TextColor3 = Color3.fromRGB(20,20,20)
    icon.TextSize = 16
    icon.Font = Enum.Font.GothamBold
    icon.ZIndex = 502
    local titleL = Instance.new("TextLabel", card)
    titleL.Size = UDim2.new(1, -64, 0, 20)
    titleL.Position = UDim2.new(0, 56, 0, 8)
    titleL.BackgroundTransparency = 1
    titleL.Text = title
    titleL.TextColor3 = colors[tp] or C.Pri
    titleL.TextSize = 14
    titleL.Font = Enum.Font.GothamBold
    titleL.TextXAlignment = Enum.TextXAlignment.Left
    titleL.TextTruncate = Enum.TextTruncate.AtEnd
    titleL.ZIndex = 501
    local msgL = Instance.new("TextLabel", card)
    msgL.Size = UDim2.new(1, -64, 0, 22)
    msgL.Position = UDim2.new(0, 56, 0, 28)
    msgL.BackgroundTransparency = 1
    msgL.Text = msg
    msgL.TextColor3 = C.Txt
    msgL.TextSize = 12
    msgL.Font = Enum.Font.Gotham
    msgL.TextXAlignment = Enum.TextXAlignment.Left
    msgL.TextWrapped = true
    msgL.TextTruncate = Enum.TextTruncate.AtEnd
    msgL.ZIndex = 501
    card.Position = UDim2.new(0, 340, 0, 0)
    TS:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
    task.delay(3.5, function()
        pcall(function()
            TS:Create(card, TweenInfo.new(0.3), {Position = UDim2.new(0, 340, 0, 0), BackgroundTransparency = 1}):Play()
            task.wait(0.3)
            card:Destroy()
        end)
    end)
end

local LiveLog = {}
local liveRef = nil
local function Log(txt, tp)
    tp = tp or "info"
    table.insert(LiveLog, {t = "[" .. os.date("%H:%M:%S") .. "] " .. txt, tp = tp})
    if #LiveLog > 80 then table.remove(LiveLog, 1) end
    if liveRef and liveRef.Parent then
        task.spawn(function()
            pcall(function()
                for _, c in ipairs(liveRef:GetChildren()) do
                    if c:IsA("TextLabel") then c:Destroy() end
                end
                local cm = {success=C.Grn, error=C.Red, warn=C.Yel, info=C.Cyn}
                for i, e in ipairs(LiveLog) do
                    local l = Instance.new("TextLabel")
                    l.Size = UDim2.new(1,-8,0,18)
                    l.Position = UDim2.new(0,4,0,(i-1)*20)
                    l.BackgroundTransparency = 1
                    l.Text = e.t
                    l.TextColor3 = cm[e.tp] or C.Cyn
                    l.TextSize = 12
                    l.Font = Enum.Font.Gotham
                    l.TextXAlignment = Enum.TextXAlignment.Left
                    l.TextTruncate = Enum.TextTruncate.AtEnd
                    l.ZIndex = 15
                    l.Parent = liveRef
                end
                liveRef.CanvasSize = UDim2.new(0,0,0,#LiveLog*20+8)
                liveRef.CanvasPosition = Vector2.new(0, #LiveLog*20)
            end)
        end)
    end
    print("[LIVE]["..tp:upper().."] "..txt)
end

local TW, TH = 480, 360
local TW_NORMAL, TH_NORMAL = 560, 440

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,TW,0,TH)
Main.Position = UDim2.new(0.5,-TW/2,0.5,-TH/2)
Main.BackgroundColor3 = C.Bg
Main.BackgroundTransparency = 1
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Active = true
Main.Parent = SG
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,16)

local bgI = Instance.new("ImageLabel", Main)
bgI.Size = UDim2.new(1,0,1,0)
bgI.BackgroundTransparency = 1
bgI.Image = BG_LIST[S.curBG].id
bgI.ImageTransparency = 0.15
bgI.ScaleType = Enum.ScaleType.Crop
bgI.ZIndex = 0
Instance.new("UICorner", bgI).CornerRadius = UDim.new(0,16)

local ovl = Instance.new("Frame", Main)
ovl.Size = UDim2.new(1,0,1,0)
ovl.BackgroundColor3 = C.Bg
ovl.BackgroundTransparency = S.BGBrightness
ovl.BorderSizePixel = 0
ovl.ZIndex = 1
Instance.new("UICorner", ovl).CornerRadius = UDim.new(0,16)

local mst = Instance.new("UIStroke", Main)
mst.Thickness = 1.5
mst.Color = C.Pri
mst.Transparency = 0.35
mst.Parent = Main
track(mst, "Color")

-- Effects layer
local effectsLayer = Instance.new("Frame", Main)
effectsLayer.Size = UDim2.new(1,0,1,0)
effectsLayer.BackgroundTransparency = 1
effectsLayer.ClipsDescendants = true
effectsLayer.ZIndex = 2
Instance.new("UICorner", effectsLayer).CornerRadius = UDim.new(0,16)

local gradLayer = Instance.new("Frame", effectsLayer)
gradLayer.Size = UDim2.new(1,0,1,0)
gradLayer.BackgroundColor3 = Color3.fromRGB(255,255,255)
gradLayer.BackgroundTransparency = 0.78
gradLayer.BorderSizePixel = 0
gradLayer.ZIndex = 3
Instance.new("UICorner", gradLayer).CornerRadius = UDim.new(0,16)

local gradBg = Instance.new("UIGradient", gradLayer)
gradBg.Rotation = 45
gradBg.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255, 140, 70)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 200, 120)),
    ColorSequenceKeypoint.new(1.0, Color3.fromRGB(255, 100, 50)),
})
gradBg.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.85),
    NumberSequenceKeypoint.new(0.5, 0.5),
    NumberSequenceKeypoint.new(1, 0.85),
})

task.spawn(function()
    while gradLayer.Parent do
        for i = 0, 1, 0.015 do
            if not gradLayer.Parent then break end
            gradBg.Rotation = 45 + i * 360
            task.wait(0.03)
        end
    end
end)

local bgOrbs = {}
for i = 1, 6 do
    local orb = Instance.new("ImageLabel", effectsLayer)
    local sz = math.random(60, 140)
    orb.Size = UDim2.new(0, sz, 0, sz)
    orb.Position = UDim2.new(math.random(), 0, math.random(), 0)
    orb.BackgroundTransparency = 1
    orb.Image = "rbxassetid://5028857084"
    orb.ImageColor3 = Color3.fromRGB(255, 130, 60)
    orb.ImageTransparency = math.random(70, 90) / 100
    orb.ZIndex = 4
    table.insert(bgOrbs, {obj = orb, phase = math.random() * math.pi * 2})
end

task.spawn(function()
    while effectsLayer.Parent do
        local t = os.clock()
        for _, o in ipairs(bgOrbs) do
            if o.obj and o.obj.Parent then
                local x = 0.5 + math.sin(t * 0.3 + o.phase) * 0.4
                local y = 0.5 + math.cos(t * 0.25 + o.phase) * 0.4
                o.obj.Position = UDim2.new(x, 0, y, 0)
                o.obj.ImageTransparency = 0.75 + math.sin(t + o.phase) * 0.15
            end
        end
        task.wait(0.03)
    end
end)

local pulseStroke = Instance.new("UIStroke", Main)
pulseStroke.Color = C.Pri
pulseStroke.Thickness = 1.5
pulseStroke.Transparency = 0.5
pulseStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
pulseStroke.Parent = Main
track(pulseStroke, "Color")

task.spawn(function()
    while Main.Parent do
        local t = os.clock()
        pulseStroke.Transparency = 0.5 + math.sin(t * 2) * 0.25
        pulseStroke.Thickness = 1.5 + math.sin(t * 2) * 0.5
        task.wait(0.05)
    end
end)

-- Title bar
local TH_H = 40
local Title = Instance.new("Frame", Main)
Title.Size = UDim2.new(1,0,0,TH_H)
Title.BackgroundColor3 = C.PriDark
Title.BackgroundTransparency = 0.8
Title.BorderSizePixel = 0
Title.ZIndex = 20
Title.Active = true
Instance.new("UICorner", Title).CornerRadius = UDim.new(0,16)
track(Title, "BackgroundColor3")

local Ttl = Instance.new("TextLabel", Title)
Ttl.Size = UDim2.new(1,-100,1,0)
Ttl.Position = UDim2.new(0,14,0,0)
Ttl.BackgroundTransparency = 1
Ttl.RichText = true
Ttl.Text = '<font color="rgb(240,240,245)">Oc1Dv</font><font color="rgb(255,145,80)">HUB</font>'
Ttl.TextSize = 16
Ttl.Font = Enum.Font.GothamBold
Ttl.TextXAlignment = Enum.TextXAlignment.Left
Ttl.ZIndex = 21

local function updTitleColor(nc)
    local r, g, b = math.floor(nc.R*255), math.floor(nc.G*255), math.floor(nc.B*255)
    Ttl.Text = string.format('<font color="rgb(240,240,245)">Oc1Dv</font><font color="rgb(%d,%d,%d)">HUB</font>', r, g, b)
end

local DOT_SIZE = 12
local DOT_Y = 0.5

local GrnB = Instance.new("TextButton", Title)
GrnB.Size = UDim2.new(0,DOT_SIZE,0,DOT_SIZE)
GrnB.Position = UDim2.new(1,-72,DOT_Y,-DOT_SIZE/2)
GrnB.BackgroundColor3 = Color3.fromRGB(80, 220, 120)
GrnB.BorderSizePixel = 0
GrnB.Text = ""
GrnB.AutoButtonColor = false
GrnB.ZIndex = 22
Instance.new("UICorner", GrnB).CornerRadius = UDim.new(1,0)

local MinB = Instance.new("TextButton", Title)
MinB.Size = UDim2.new(0,DOT_SIZE,0,DOT_SIZE)
MinB.Position = UDim2.new(1,-52,DOT_Y,-DOT_SIZE/2)
MinB.BackgroundColor3 = Color3.fromRGB(255,200,70)
MinB.BorderSizePixel = 0
MinB.Text = ""
MinB.AutoButtonColor = false
MinB.ZIndex = 22
Instance.new("UICorner", MinB).CornerRadius = UDim.new(1,0)

local ClsB = Instance.new("TextButton", Title)
ClsB.Size = UDim2.new(0,DOT_SIZE,0,DOT_SIZE)
ClsB.Position = UDim2.new(1,-32,DOT_Y,-DOT_SIZE/2)
ClsB.BackgroundColor3 = Color3.fromRGB(255,95,90)
ClsB.BorderSizePixel = 0
ClsB.Text = ""
ClsB.AutoButtonColor = false
ClsB.ZIndex = 22
Instance.new("UICorner", ClsB).CornerRadius = UDim.new(1,0)

-- Floating button
local FB = Instance.new("TextButton")
FB.Size = UDim2.new(0,52,0,52)
FB.Position = UDim2.new(0,15,0,150)
FB.BackgroundColor3 = C.Bg
FB.BackgroundTransparency = 0.15
FB.BorderSizePixel = 0
FB.Text = ""
FB.AutoButtonColor = false
FB.Visible = false
FB.ZIndex = 100
FB.Parent = SG
Instance.new("UICorner", FB).CornerRadius = UDim.new(0,12)
local fbs = Instance.new("UIStroke", FB)
fbs.Color = C.Pri; fbs.Thickness = 2; fbs.Transparency = 0.3; fbs.Parent = FB
track(fbs, "Color")
local fbi = Instance.new("ImageLabel", FB)
fbi.Size = UDim2.new(1,-10,1,-10)
fbi.Position = UDim2.new(0,5,0,5)
fbi.BackgroundTransparency = 1
fbi.Image = CONFIG.LOGO
fbi.ZIndex = 101

-- Drag
local drg, dst, spt
Title.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        drg=true; dst=i.Position; spt=Main.Position
    end
end)
Title.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drg=false end
end)
UIS.InputChanged:Connect(function(i)
    if drg and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - dst
        Main.Position = UDim2.new(spt.X.Scale, spt.X.Offset + d.X, spt.Y.Scale, spt.Y.Offset + d.Y)
    end
end)

local fdrg, fdst, fspt
FB.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        fdrg=true; fdst=i.Position; fspt=FB.Position
    end
end)
FB.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then fdrg=false end
end)
UIS.InputChanged:Connect(function(i)
    if fdrg and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = i.Position - fdst
        FB.Position = UDim2.new(fspt.X.Scale, fspt.X.Offset + d.X, fspt.Y.Scale, fspt.Y.Offset + d.Y)
    end
end)

local function doClose() sfx() Main.Visible=false; FB.Visible=true end
local function doShow() sfx() Main.Visible=true; FB.Visible=false end

ClsB.MouseButton1Click:Connect(doClose)
MinB.MouseButton1Click:Connect(function()
    sfx()
    local isMin = Main.AbsoluteSize.Y <= TH_H + 5
    TS:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = isMin and UDim2.new(0,TW,0,TH) or UDim2.new(0,TW,0,TH_H)}):Play()
end)
GrnB.MouseButton1Click:Connect(function()
    sfx()
    S.MiniMode = not S.MiniMode
    local tw, th = S.MiniMode and TW or TW_NORMAL, S.MiniMode and TH or TH_NORMAL
    TS:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, tw, 0, th)}):Play()
end)
FB.MouseButton1Click:Connect(doShow)

-- Sidebar
local SX, SY = 10, TH_H + 10
local SW = 110
local UH = 46
local CX = SX + SW + 8

local SB = Instance.new("Frame", Main)
SB.Size = UDim2.new(0,SW,1,-SY-UH-14)
SB.Position = UDim2.new(0,SX,0,SY)
SB.BackgroundColor3 = C.Panel
SB.BackgroundTransparency = 0.5
SB.BorderSizePixel = 0
SB.ZIndex = 10
SB.Active = true
Instance.new("UICorner", SB).CornerRadius = UDim.new(0,10)
local sbs = Instance.new("UIStroke", SB)
sbs.Color = C.Pri; sbs.Thickness = 1; sbs.Transparency = 0.7; sbs.Parent = SB
track(sbs, "Color")

local UI_ = Instance.new("Frame", Main)
UI_.Size = UDim2.new(0,SW,0,UH)
UI_.Position = UDim2.new(0,SX,1,-(UH+10))
UI_.BackgroundColor3 = C.Panel
UI_.BackgroundTransparency = 0.5
UI_.BorderSizePixel = 0
UI_.ZIndex = 10
Instance.new("UICorner", UI_).CornerRadius = UDim.new(0,10)

local AV = Instance.new("Frame", UI_)
AV.Size = UDim2.new(0,30,0,30)
AV.Position = UDim2.new(0,8,0.5,-15)
AV.BackgroundColor3 = Color3.fromRGB(50,50,58)
AV.BorderSizePixel = 0
AV.ZIndex = 11
Instance.new("UICorner", AV).CornerRadius = UDim.new(1,0)
local avs = Instance.new("UIStroke", AV)
avs.Color = C.Pri; avs.Thickness = 1.5; avs.Transparency = 0.35; avs.Parent = AV
track(avs, "Color")

local AVi = Instance.new("ImageLabel", AV)
AVi.Size = UDim2.new(1,-4,1,-4)
AVi.Position = UDim2.new(0,2,0,2)
AVi.BackgroundTransparency = 1
AVi.ZIndex = 12
Instance.new("UICorner", AVi).CornerRadius = UDim.new(1,0)
task.spawn(function()
    local ok, t = pcall(function() return Players:GetUserThumbnailAsync(LP.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100) end)
    if ok and t then AVi.Image = t end
end)

local DN = Instance.new("TextLabel", UI_)
DN.Size = UDim2.new(1,-48,0,14)
DN.Position = UDim2.new(0,44,0,8)
DN.BackgroundTransparency = 1
DN.Text = LP.DisplayName or LP.Name
DN.TextColor3 = C.Txt
DN.TextSize = 11
DN.Font = Enum.Font.GothamMedium
DN.TextXAlignment = Enum.TextXAlignment.Left
DN.TextTruncate = Enum.TextTruncate.AtEnd
DN.ZIndex = 11

-- Content area
local Cont = Instance.new("Frame", Main)
Cont.Size = UDim2.new(1,-(CX+10),1,-SY-10)
Cont.Position = UDim2.new(0,CX,0,SY)
Cont.BackgroundColor3 = C.Panel
Cont.BackgroundTransparency = 0.55
Cont.BorderSizePixel = 0
Cont.ZIndex = 10
Instance.new("UICorner", Cont).CornerRadius = UDim.new(0,10)
local cts = Instance.new("UIStroke", Cont)
cts.Color = C.Pri; cts.Thickness = 1; cts.Transparency = 0.7; cts.Parent = Cont
track(cts, "Color")

-- Search
local SearchBar = Instance.new("Frame", Cont)
SearchBar.Size = UDim2.new(1,-16,0,26)
SearchBar.Position = UDim2.new(0,8,0,8)
SearchBar.BackgroundColor3 = Color3.fromRGB(52,52,60)
SearchBar.BackgroundTransparency = 0.25
SearchBar.BorderSizePixel = 0
SearchBar.ZIndex = 11
Instance.new("UICorner", SearchBar).CornerRadius = UDim.new(0,8)

local SearchInput = Instance.new("TextBox", SearchBar)
SearchInput.Size = UDim2.new(1,-12,1,0)
SearchInput.Position = UDim2.new(0,6,0,0)
SearchInput.BackgroundTransparency = 1
SearchInput.Text = ""
SearchInput.PlaceholderText = "Cari fitur..."
SearchInput.PlaceholderColor3 = C.Dim
SearchInput.TextColor3 = C.Txt
SearchInput.TextSize = 11
SearchInput.Font = Enum.Font.Gotham
SearchInput.TextXAlignment = Enum.TextXAlignment.Left
SearchInput.ClearTextOnFocus = false
SearchInput.ZIndex = 12

-- Tab header
local THF = Instance.new("Frame", Cont)
THF.Size = UDim2.new(1,-16,0,22)
THF.Position = UDim2.new(0,8,0,40)
THF.BackgroundTransparency = 1
THF.ZIndex = 11

local THt = Instance.new("TextLabel", THF)
THt.Size = UDim2.new(1,-30,1,0)
THt.Position = UDim2.new(0,4,0,0)
THt.BackgroundTransparency = 1
THt.Text = "Rumah"
THt.TextColor3 = C.Txt
THt.TextSize = 13
THt.Font = Enum.Font.GothamMedium
THt.TextXAlignment = Enum.TextXAlignment.Left
THt.ZIndex = 12

local tabData = {
    {name="Rumah", icon=IC.Rumah},
    {name="Fake Purchase", icon=IC.Fake},
    {name="MemeRush", icon=IC.MemeRush},
    {name="Universal", icon=IC.Universal},
    {name="Live", icon=IC.Live},
    {name="Tema", icon=IC.Tema},
    {name="Misc", icon=IC.Misc},
    {name="Credit", icon=IC.Credit},
}

local tabContent = {}
local CONTENT_Y = 70

for i, t in ipairs(tabData) do
    local sc = Instance.new("ScrollingFrame", Cont)
    sc.Size = UDim2.new(1,-16,1,-CONTENT_Y-8)
    sc.Position = UDim2.new(0,8,0,CONTENT_Y)
    sc.BackgroundTransparency = 1
    sc.BorderSizePixel = 0
    sc.ScrollBarThickness = 3
    sc.ScrollBarImageColor3 = C.Pri
    sc.CanvasSize = UDim2.new(0,0,0,0)
    sc.AutomaticCanvasSize = Enum.AutomaticSize.Y
    sc.Visible = (i == 1)
    sc.ZIndex = 10
    tabContent[t.name] = sc
    track(sc, "ScrollBarImageColor3")
    local lay = Instance.new("UIListLayout", sc)
    lay.Padding = UDim.new(0,6)
    lay.SortOrder = Enum.SortOrder.LayoutOrder
    local pad = Instance.new("UIPadding", sc)
    pad.PaddingRight = UDim.new(0,4)
end

local tabBtns = {}
local curTab = "Rumah"

for i, t in ipairs(tabData) do
    local b = Instance.new("TextButton", SB)
    b.Size = UDim2.new(1,-16,0,24)
    b.Position = UDim2.new(0,8,0,6+(i-1)*28)
    b.BackgroundColor3 = (i==1) and C.Pri or Color3.fromRGB(50,50,58)
    b.BackgroundTransparency = (i==1) and 0.05 or 0.35
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.Active = true
    b.ZIndex = 100
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    tabBtns[t.name] = b
    if i == 1 then track(b, "BackgroundColor3") end
    
    local ic = Instance.new("ImageLabel", b)
    ic.Size = UDim2.new(0,10,0,10)
    ic.Position = UDim2.new(0,6,0.5,-5)
    ic.BackgroundTransparency = 1
    ic.Image = t.icon
    ic.ImageColor3 = (i==1) and Color3.fromRGB(255,255,255) or C.Dim
    ic.ZIndex = 101
    ic.Active = false
    
    local lb = Instance.new("TextLabel", b)
    lb.Size = UDim2.new(1,-22,1,0)
    lb.Position = UDim2.new(0,20,0,0)
    lb.BackgroundTransparency = 1
    lb.Text = t.name
    lb.TextColor3 = (i==1) and Color3.fromRGB(255,255,255) or C.Txt
    lb.TextSize = 10
    lb.Font = Enum.Font.GothamMedium
    lb.TextXAlignment = Enum.TextXAlignment.Left
    lb.TextTruncate = Enum.TextTruncate.AtEnd
    lb.ZIndex = 101
    lb.Active = false
    
    b.MouseButton1Click:Connect(function()
        if curTab == t.name then return end
        sfx()
        curTab = t.name
        for n, bb in pairs(tabBtns) do
            local on = (n == t.name)
            TS:Create(bb, TweenInfo.new(0.2), {
                BackgroundColor3 = on and C.Pri or Color3.fromRGB(50,50,58),
                BackgroundTransparency = on and 0.05 or 0.35,
            }):Play()
            for _, ch in ipairs(bb:GetChildren()) do
                if ch:IsA("ImageLabel") then
                    TS:Create(ch, TweenInfo.new(0.2), {ImageColor3 = on and Color3.fromRGB(255,255,255) or C.Dim}):Play()
                elseif ch:IsA("TextLabel") then
                    TS:Create(ch, TweenInfo.new(0.2), {TextColor3 = on and Color3.fromRGB(255,255,255) or C.Txt}):Play()
                end
            end
        end
        THt.Text = t.name
        for n, c in pairs(tabContent) do c.Visible = (n == t.name) end
    end)
end

-- Search filter
SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
    local q = string.lower(SearchInput.Text)
    for _, el in ipairs(searchables) do
        if el and el.Parent then
            if q == "" then el.Visible = true
            else
                local txt = el:GetAttribute("SearchText") or ""
                el.Visible = (txt:find(q, 1, true) ~= nil)
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════════════
-- COMPONENTS
-- ═══════════════════════════════════════════════════════════
local function Btn(parent, text, cb, col)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1,-4,0,32)
    b.BackgroundColor3 = col or C.Card
    b.BackgroundTransparency = 0.2
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = (col and Color3.fromRGB(255,255,255)) or C.Pri
    b.TextSize = 12
    b.Font = Enum.Font.GothamMedium
    b.AutoButtonColor = false
    b.ZIndex = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    if not col then track(b, "TextColor3") end
    trackSearch(b, text)
    b.MouseEnter:Connect(function() TS:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0.05}):Play() end)
    b.MouseLeave:Connect(function() TS:Create(b, TweenInfo.new(0.15), {BackgroundTransparency = 0.2}):Play() end)
    b.MouseButton1Click:Connect(function()
        sfx()
        if cb then pcall(cb) end
    end)
    return b
end

local function Sect(parent, text)
    local l = Instance.new("TextLabel", parent)
    l.Size = UDim2.new(1,-4,0,18)
    l.BackgroundTransparency = 1
    l.Text = text
    l.TextColor3 = C.Pri
    l.TextSize = 10
    l.Font = Enum.Font.GothamBold
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 10
    track(l, "TextColor3")
    trackSearch(l, text)
end

local function Input(parent, title, def, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1,-4,0,36)
    f.BackgroundColor3 = C.Card
    f.BackgroundTransparency = 0.2
    f.BorderSizePixel = 0
    f.ZIndex = 10
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)
    trackSearch(f, title)
    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.new(0.4,0,1,0)
    lbl.Position = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = title
    lbl.TextColor3 = C.Txt
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 11
    local box = Instance.new("TextBox", f)
    box.Size = UDim2.new(0.6,-16,1,-8)
    box.Position = UDim2.new(0.4,5,0,4)
    box.BackgroundColor3 = Color3.fromRGB(60,60,68)
    box.BackgroundTransparency = 0.1
    box.BorderSizePixel = 0
    box.Text = def or ""
    box.TextColor3 = C.Pri
    box.TextSize = 10
    box.Font = Enum.Font.GothamMedium
    box.ClearTextOnFocus = false
    box.ZIndex = 12
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,7)
    box.FocusLost:Connect(function() if cb then pcall(cb, box.Text) end end)
    return box
end

local function Toggle(parent, title, def, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1,-4,0,32)
    f.BackgroundColor3 = C.Card
    f.BackgroundTransparency = 0.2
    f.BorderSizePixel = 0
    f.ZIndex = 10
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)
    trackSearch(f, title)
    
    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.new(1,-70,1,0)
    lbl.Position = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = title
    lbl.TextColor3 = C.Txt
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 11
    
    local bg = Instance.new("Frame", f)
    bg.Size = UDim2.new(0,42,0,20)
    bg.Position = UDim2.new(1,-52,0.5,-10)
    bg.BackgroundColor3 = def and C.Grn or Color3.fromRGB(60,60,68)
    bg.BorderSizePixel = 0
    bg.ZIndex = 11
    Instance.new("UICorner", bg).CornerRadius = UDim.new(1,0)
    
    local knob = Instance.new("Frame", bg)
    knob.Size = UDim2.new(0,16,0,16)
    knob.Position = def and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 12
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
    
    local state = def or false
    local btn = Instance.new("TextButton", f)
    btn.Size = UDim2.new(1,0,1,0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 13
    btn.MouseButton1Click:Connect(function()
        sfx()
        state = not state
        TS:Create(knob, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
        }):Play()
        TS:Create(bg, TweenInfo.new(0.2), {
            BackgroundColor3 = state and C.Grn or Color3.fromRGB(60,60,68)
        }):Play()
        if cb then pcall(cb, state) end
    end)
    return f
end

local function Slider(parent, title, mn, mx, df, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1,-4,0,44)
    f.BackgroundColor3 = C.Card
    f.BackgroundTransparency = 0.25
    f.BorderSizePixel = 0
    f.ZIndex = 10
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)
    local s = Instance.new("UIStroke", f)
    s.Color = C.Stroke; s.Thickness = 1; s.Transparency = 0.82; s.Parent = f
    trackSearch(f, title)
    
    local l = Instance.new("TextLabel", f)
    l.Size = UDim2.new(1,-14,0,14)
    l.Position = UDim2.new(0,10,0,6)
    l.BackgroundTransparency = 1
    l.Text = title .. ": " .. df
    l.TextColor3 = C.Txt
    l.TextSize = 11
    l.Font = Enum.Font.GothamMedium
    l.TextXAlignment = Enum.TextXAlignment.Left
    l.ZIndex = 11
    
    local bar = Instance.new("Frame", f)
    bar.Size = UDim2.new(1,-20,0,8)
    bar.Position = UDim2.new(0,10,0,26)
    bar.BackgroundColor3 = Color3.fromRGB(60,60,68)
    bar.BorderSizePixel = 0
    bar.ZIndex = 11
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)
    
    local fl = Instance.new("Frame", bar)
    fl.Size = UDim2.new((df-mn)/(mx-mn),0,1,0)
    fl.BackgroundColor3 = C.Pri
    fl.BorderSizePixel = 0
    fl.ZIndex = 12
    Instance.new("UICorner", fl).CornerRadius = UDim.new(1,0)
    track(fl, "BackgroundColor3")
    
    local knob = Instance.new("Frame", fl)
    knob.Size = UDim2.new(0,14,0,14)
    knob.Position = UDim2.new(1,-7,0.5,-7)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 13
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1,0)
    
    local dr = false
    bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dr = true end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dr = false end
    end)
    UIS.InputChanged:Connect(function(i)
        if dr and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local bs = bar.AbsoluteSize.X
            if bs <= 0 then return end
            local pct = math.clamp((i.Position.X - bar.AbsolutePosition.X)/bs, 0, 1)
            local v = math.floor(mn + (mx-mn)*pct)
            fl.Size = UDim2.new(pct,0,1,0)
            l.Text = title .. ": " .. v
            if cb then pcall(cb, v) end
        end
    end)
end

local function Dropdown(parent, title, options, default, cb)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1,-4,0,32)
    f.BackgroundColor3 = C.Card
    f.BackgroundTransparency = 0.2
    f.BorderSizePixel = 0
    f.ZIndex = 10
    Instance.new("UICorner", f).CornerRadius = UDim.new(0,10)
    trackSearch(f, title)
    
    local lbl = Instance.new("TextLabel", f)
    lbl.Size = UDim2.new(0.5,0,1,0)
    lbl.Position = UDim2.new(0,10,0,0)
    lbl.BackgroundTransparency = 1
    lbl.Text = title
    lbl.TextColor3 = C.Txt
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 11
    
    local cur = default or (options[1] or "")
    local selBtn = Instance.new("TextButton", f)
    selBtn.Size = UDim2.new(0.5,-14,1,-8)
    selBtn.Position = UDim2.new(0.5,4,0,4)
    selBtn.BackgroundColor3 = Color3.fromRGB(60,60,68)
    selBtn.BorderSizePixel = 0
    selBtn.Text = cur
    selBtn.TextColor3 = C.Pri
    selBtn.TextSize = 10
    selBtn.Font = Enum.Font.GothamMedium
    selBtn.AutoButtonColor = false
    selBtn.ZIndex = 12
    Instance.new("UICorner", selBtn).CornerRadius = UDim.new(0,7)
    
    local idx = 1
    for i, o in ipairs(options) do
        if o == cur then idx = i break end
    end
    
    selBtn.MouseButton1Click:Connect(function()
        sfx()
        idx = idx + 1
        if idx > #options then idx = 1 end
        cur = options[idx]
        selBtn.Text = cur
        if cb then pcall(cb, cur) end
    end)
    return cur
end

-- ═══════════════════════════════════════════════════════════
-- FILL: RUMAH (existing)
-- ═══════════════════════════════════════════════════════════
local welcomeCard = Instance.new("Frame", tabContent.Rumah)
welcomeCard.Size = UDim2.new(1,-4,0,70)
welcomeCard.BackgroundColor3 = C.Card
welcomeCard.BackgroundTransparency = 0.25
welcomeCard.BorderSizePixel = 0
welcomeCard.ZIndex = 10
Instance.new("UICorner", welcomeCard).CornerRadius = UDim.new(0,12)

local greetLbl = Instance.new("TextLabel", welcomeCard)
greetLbl.Size = UDim2.new(1,-20,0,18)
greetLbl.Position = UDim2.new(0,12,0,12)
greetLbl.BackgroundTransparency = 1
greetLbl.Text = "Halo, " .. (LP.DisplayName or LP.Name) .. "!"
greetLbl.TextColor3 = C.Txt
greetLbl.TextSize = 13
greetLbl.Font = Enum.Font.GothamMedium
greetLbl.TextXAlignment = Enum.TextXAlignment.Left
greetLbl.ZIndex = 12

local clockLbl = Instance.new("TextLabel", welcomeCard)
clockLbl.Size = UDim2.new(1,-20,0,14)
clockLbl.Position = UDim2.new(0,12,0,32)
clockLbl.BackgroundTransparency = 1
clockLbl.Text = "--"
clockLbl.TextColor3 = C.Dim
clockLbl.TextSize = 10
clockLbl.Font = Enum.Font.Gotham
clockLbl.TextXAlignment = Enum.TextXAlignment.Left
clockLbl.ZIndex = 12

local uptimeLbl = Instance.new("TextLabel", welcomeCard)
uptimeLbl.Size = UDim2.new(1,-20,0,14)
uptimeLbl.Position = UDim2.new(0,12,0,48)
uptimeLbl.BackgroundTransparency = 1
uptimeLbl.Text = "Playtime: 00:00:00"
uptimeLbl.TextColor3 = C.Dim
uptimeLbl.TextSize = 10
uptimeLbl.Font = Enum.Font.Gotham
uptimeLbl.TextXAlignment = Enum.TextXAlignment.Left
uptimeLbl.ZIndex = 12

Sect(tabContent.Rumah, "LIVE STATS")

local statsCard = Instance.new("Frame", tabContent.Rumah)
statsCard.Size = UDim2.new(1,-4,0,58)
statsCard.BackgroundColor3 = C.Card
statsCard.BackgroundTransparency = 0.25
statsCard.BorderSizePixel = 0
statsCard.ZIndex = 10
Instance.new("UICorner", statsCard).CornerRadius = UDim.new(0,12)

local function mkStatBox(parent, x, title)
    local box = Instance.new("Frame", parent)
    box.Size = UDim2.new(0,100,0,48)
    box.Position = UDim2.new(0,x,0.5,-24)
    box.BackgroundColor3 = Color3.fromRGB(52,52,60)
    box.BackgroundTransparency = 0.2
    box.BorderSizePixel = 0
    box.ZIndex = 11
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)
    local tL = Instance.new("TextLabel", box)
    tL.Size = UDim2.new(1,0,0,12)
    tL.Position = UDim2.new(0,0,0,6)
    tL.BackgroundTransparency = 1
    tL.Text = title
    tL.TextColor3 = C.Dim
    tL.TextSize = 9
    tL.Font = Enum.Font.GothamMedium
    tL.ZIndex = 12
    local vL = Instance.new("TextLabel", box)
    vL.Size = UDim2.new(1,0,0,20)
    vL.Position = UDim2.new(0,0,0,22)
    vL.BackgroundTransparency = 1
    vL.Text = "--"
    vL.TextColor3 = C.Pri
    vL.TextSize = 14
    vL.Font = Enum.Font.GothamBold
    vL.ZIndex = 12
    track(vL, "TextColor3")
    return vL
end

local fpsVal = mkStatBox(statsCard, 8, "FPS")
local pingVal = mkStatBox(statsCard, 116, "PING")
local playerVal = mkStatBox(statsCard, 224, "PLAYERS")

Sect(tabContent.Rumah, "SERVER INFO")

local infoCard = Instance.new("Frame", tabContent.Rumah)
infoCard.Size = UDim2.new(1,-4,0,86)
infoCard.BackgroundColor3 = C.Card
infoCard.BackgroundTransparency = 0.25
infoCard.BorderSizePixel = 0
infoCard.ZIndex = 10
Instance.new("UICorner", infoCard).CornerRadius = UDim.new(0,12)

local function mkInfoRow(parent, y, label)
    local rL = Instance.new("TextLabel", parent)
    rL.Size = UDim2.new(0,80,0,16)
    rL.Position = UDim2.new(0,12,0,y)
    rL.BackgroundTransparency = 1
    rL.Text = label
    rL.TextColor3 = C.Dim
    rL.TextSize = 10
    rL.Font = Enum.Font.Gotham
    rL.TextXAlignment = Enum.TextXAlignment.Left
    rL.ZIndex = 12
    local vL = Instance.new("TextLabel", parent)
    vL.Size = UDim2.new(1,-106,0,16)
    vL.Position = UDim2.new(0,98,0,y)
    vL.BackgroundTransparency = 1
    vL.Text = "--"
    vL.TextColor3 = C.Txt
    vL.TextSize = 10
    vL.Font = Enum.Font.Gotham
    vL.TextXAlignment = Enum.TextXAlignment.Left
    vL.TextTruncate = Enum.TextTruncate.AtEnd
    vL.ZIndex = 12
    return vL
end

local jobVal = mkInfoRow(infoCard, 8, "Job ID")
local placeVal = mkInfoRow(infoCard, 28, "Place ID")
local gameVal = mkInfoRow(infoCard, 48, "Game")
local regionVal = mkInfoRow(infoCard, 68, "Region")
placeVal.Text = tostring(game.PlaceId)
jobVal.Text = game.JobId ~= "" and game.JobId or "Studio/Private"
gameVal.Text = S.GameName
regionVal.Text = (game.JobId ~= "" and "Online") or "Studio"

local fpsCount, fpsTime, curFPS = 0, 0, 0
RunService.RenderStepped:Connect(function(dt)
    fpsCount = fpsCount + 1
    fpsTime = fpsTime + dt
    if fpsTime >= 1 then
        curFPS = math.floor(fpsCount / fpsTime)
        fpsCount = 0; fpsTime = 0
    end
end)

task.spawn(function()
    while task.wait(1) do
        local t = os.date("*t")
        local clockStr = string.format("%02d:%02d:%02d", t.hour, t.min, t.sec)
        local greet
        if t.hour < 12 then greet = "Selamat Pagi"
        elseif t.hour < 15 then greet = "Selamat Siang"
        elseif t.hour < 18 then greet = "Selamat Sore"
        else greet = "Selamat Malam" end
        clockLbl.Text = clockStr
        greetLbl.Text = greet .. ", " .. (LP.DisplayName or LP.Name) .. "!"
        local el = os.time() - S.StartTime
        uptimeLbl.Text = string.format("Playtime: %02d:%02d:%02d", math.floor(el/3600), math.floor((el%3600)/60), el%60)
        fpsVal.Text = tostring(curFPS)
        pcall(function()
            local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
            pingVal.Text = math.floor(ping) .. "ms"
        end)
        playerVal.Text = #Players:GetPlayers() .. "/" .. Players.MaxPlayers
        if S.GameName ~= "Loading..." then gameVal.Text = S.GameName end
    end
end)

-- ═══════════════════════════════════════════════════════════
-- FILL: FAKE PURCHASE (existing)
-- ═══════════════════════════════════════════════════════════
Sect(tabContent["Fake Purchase"], "FAKE PURCHASE UGC")

local fpIdBox = Input(tabContent["Fake Purchase"], "UGC ID", "82120626157139", function(txt) end)
local fpTimeBox = Input(tabContent["Fake Purchase"], "Delay (sec)", "0.001", function(txt) end)

local fpItemLbl = Instance.new("TextLabel", tabContent["Fake Purchase"])
fpItemLbl.Size = UDim2.new(1,-4,0,24)
fpItemLbl.BackgroundColor3 = C.Card
fpItemLbl.BackgroundTransparency = 0.25
fpItemLbl.BorderSizePixel = 0
fpItemLbl.Text = "Item: -"
fpItemLbl.TextColor3 = C.Txt
fpItemLbl.TextSize = 11
fpItemLbl.Font = Enum.Font.GothamBold
fpItemLbl.ZIndex = 10
Instance.new("UICorner", fpItemLbl).CornerRadius = UDim.new(0,8)

local fpPriceLbl = Instance.new("TextLabel", tabContent["Fake Purchase"])
fpPriceLbl.Size = UDim2.new(1,-4,0,24)
fpPriceLbl.BackgroundColor3 = C.Card
fpPriceLbl.BackgroundTransparency = 0.25
fpPriceLbl.BorderSizePixel = 0
fpPriceLbl.Text = "Price: -"
fpPriceLbl.TextColor3 = C.Grn
fpPriceLbl.TextSize = 11
fpPriceLbl.Font = Enum.Font.Gotham
fpPriceLbl.ZIndex = 10
Instance.new("UICorner", fpPriceLbl).CornerRadius = UDim.new(0,8)

local lastId = nil
local cachedName = "Unknown"
local cachedPrice = "-"

local function doFakePurchase()
    local idStr = fpIdBox.Text:gsub("%s+", "")
    local id = tonumber(idStr)
    if not id then
        NotifyUser("Fake Purchase", "Invalid ID!", "error")
        return
    end
    local name, price = cachedName, cachedPrice
    if id ~= lastId then
        local ok, info = pcall(function() return MPS:GetProductInfo(id) end)
        if ok and info then
            name = info.Name
            price = (info.PriceInRobux or 0) .. " R$"
            cachedName = name; cachedPrice = price
            fpItemLbl.Text = "Item: " .. name
            fpPriceLbl.Text = "Price: " .. price
        end
        lastId = id
    end
    pcall(function() MPS:SignalPromptPurchaseFinished(LP, id, true) end)
    Log("Fake purchase: " .. name, "success")
end

Btn(tabContent["Fake Purchase"], "Purchase Once", function() doFakePurchase() end, Color3.fromRGB(60, 120, 90))

Btn(tabContent["Fake Purchase"], "Ultra Loop 1000x", function()
    S.FPRunning = not S.FPRunning
    if S.FPRunning then
        Log("Fake Purchase LOOP STARTED", "success")
        NotifyUser("Fake Purchase", "Ultra Loop ON", "success")
        task.spawn(function()
            while S.FPRunning do
                doFakePurchase()
                local rawDelay = tonumber(fpTimeBox.Text) or 0.001
                local d = math.max(0.001, rawDelay)
                task.wait(d)
            end
        end)
    else
        Log("Fake Purchase LOOP STOPPED", "warn")
    end
end, Color3.fromRGB(140, 90, 50))

Btn(tabContent["Fake Purchase"], "Stop Loop", function()
    S.FPRunning = false
    Log("Fake Purchase stopped", "warn")
end, Color3.fromRGB(150, 60, 70))

-- ═══════════════════════════════════════════════════════════
-- FILL: MEMERUSH (NEW — Air Hub features)
-- ═══════════════════════════════════════════════════════════
local mrTab = tabContent["MemeRush"]

local function getRoot(char)
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart") 
        or char:FindFirstChild("Torso") 
        or char:FindFirstChild("UpperTorso")
end

-- Remotes
local attackEvent = nil
local requestEvent = nil
pcall(function()
    local mr = ReplicatedStorage:WaitForChild("MemeRush", 10)
    if mr then
        local remotes = mr:WaitForChild("Remotes", 10)
        if remotes then
            attackEvent = remotes:WaitForChild("Attack", 10)
            requestEvent = remotes:WaitForChild("Request", 10)
        end
    end
end)

Sect(mrTab, "MOVEMENT")

-- TpWalk
local tpWalkEnabled = false
local tpWalkSpeed = 16

RunService.Stepped:Connect(function()
    if tpWalkEnabled then
        local char = LP.Character
        local root = getRoot(char)
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if root and humanoid and humanoid.MoveDirection.Magnitude > 0 then
            root.CFrame = root.CFrame + (humanoid.MoveDirection * tpWalkSpeed * 0.05)
        end
    end
end)

Toggle(mrTab, "TpWalk", false, function(v) tpWalkEnabled = v end)
Slider(mrTab, "TpWalk Speed", 1, 100, 16, function(v) tpWalkSpeed = v end)

Btn(mrTab, "Teleport ke Safe Zone", function()
    local root = getRoot(LP.Character)
    if root then
        root.CFrame = CFrame.new(-436, 18, 259)
    end
end, Color3.fromRGB(60, 120, 180))

-- Infinite Jump
local infJumpEnabled = false
UIS.JumpRequest:Connect(function()
    if infJumpEnabled then
        local char = LP.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
Toggle(mrTab, "Lompatan Tak Terhingga", false, function(v) infJumpEnabled = v end)

Sect(mrTab, "COMBAT")

-- Auto Attack
local autoAttackEnabled = false
task.spawn(function()
    while true do
        task.wait(0.1)
        if autoAttackEnabled and attackEvent then
            pcall(function() attackEvent:FireServer(1) end)
        end
    end
end)
Toggle(mrTab, "Serangan Otomatis (0.1s)", false, function(v) autoAttackEnabled = v end)

Sect(mrTab, "EGGS")

-- Open All Eggs
Btn(mrTab, "Buka Semua Telur", function()
    pcall(function() if requestEvent then requestEvent:InvokeServer("OpenAllEggs") end end)
end)

local autoOpenEggsEnabled = false
task.spawn(function()
    while true do
        task.wait(0.5)
        if autoOpenEggsEnabled and requestEvent then
            pcall(function() requestEvent:InvokeServer("OpenAllEggs") end)
        end
    end
end)
Toggle(mrTab, "Telur Terbuka Otomatis", false, function(v) autoOpenEggsEnabled = v end)

-- Place All Eggs
Btn(mrTab, "Letakkan Semua Telur", function()
    pcall(function() if requestEvent then requestEvent:InvokeServer("PlaceAllEggs") end end)
end)

local autoPlaceEggsEnabled = false
task.spawn(function()
    while true do
        task.wait(1)
        if autoPlaceEggsEnabled and requestEvent then
            pcall(function() requestEvent:InvokeServer("PlaceAllEggs") end)
        end
    end
end)
Toggle(mrTab, "Penempatan Telur Otomatis", false, function(v) autoPlaceEggsEnabled = v end)

Sect(mrTab, "CLAIM")

-- Claim Gift
Btn(mrTab, "Klaim Hadiah", function()
    pcall(function() if requestEvent then requestEvent:InvokeServer("ClaimGift") end end)
end)

local autoClaimGiftEnabled = false
task.spawn(function()
    while true do
        task.wait(1)
        if autoClaimGiftEnabled and requestEvent then
            pcall(function() requestEvent:InvokeServer("ClaimGift") end)
        end
    end
end)
Toggle(mrTab, "Klaim Hadiah Otomatis", false, function(v) autoClaimGiftEnabled = v end)

-- Claim Social
Btn(mrTab, "Klaim Hadiah Sosial", function()
    pcall(function() if requestEvent then requestEvent:InvokeServer("ClaimSocial") end end)
end)

local autoClaimSocialEnabled = false
task.spawn(function()
    while true do
        task.wait(3)
        if autoClaimSocialEnabled and requestEvent then
            pcall(function() requestEvent:InvokeServer("ClaimSocial") end)
        end
    end
end)
Toggle(mrTab, "Klaim Sosial Otomatis", false, function(v) autoClaimSocialEnabled = v end)

-- Auto Equip Best
local autoEquipBestEnabled = false
task.spawn(function()
    while true do
        task.wait(1)
        if autoEquipBestEnabled and requestEvent then
            pcall(function() requestEvent:InvokeServer("EquipBest") end)
        end
    end
end)
Toggle(mrTab, "Equip Best Otomatis", false, function(v) autoEquipBestEnabled = v end)

-- Auto Claim Index
local autoClaimIndexEnabled = false
task.spawn(function()
    while true do
        task.wait(2)
        if autoClaimIndexEnabled and requestEvent then
            pcall(function() requestEvent:InvokeServer("ClaimIndex") end)
        end
    end
end)
Toggle(mrTab, "Klaim Index Otomatis", false, function(v) autoClaimIndexEnabled = v end)

Sect(mrTab, "SELL")

local itemsToSell = {
    "i18", "i17", "i12", "i13", "i7", "i14", "i22", "i21",
    "i24", "i23", "i2", "i4", "i5", "i20", "i26", "i27",
    "i25", "i1", "i3", "i6"
}
Btn(mrTab, "Jual Barang", function()
    pcall(function() if requestEvent then requestEvent:InvokeServer("SellItems", "Pets", itemsToSell) end end)
end)

local autoSellItemsEnabled = false
task.spawn(function()
    while true do
        task.wait(2)
        if autoSellItemsEnabled and requestEvent then
            pcall(function() requestEvent:InvokeServer("SellItems", "Pets", itemsToSell) end)
        end
    end
end)
Toggle(mrTab, "Jual Barang Otomatis", false, function(v) autoSellItemsEnabled = v end)

Sect(mrTab, "SHOP")

-- Buy Weapon
Btn(mrTab, "Beli Senjata", function()
    pcall(function() if requestEvent then requestEvent:InvokeServer("BuyWeapon") end end)
end)
local autoBuyWeaponEnabled = false
task.spawn(function()
    while true do
        task.wait(0.5)
        if autoBuyWeaponEnabled and requestEvent then
            pcall(function() requestEvent:InvokeServer("BuyWeapon") end)
        end
    end
end)
Toggle(mrTab, "Beli Senjata Otomatis", false, function(v) autoBuyWeaponEnabled = v end)

-- Buy Armor
Btn(mrTab, "Beli Armor", function()
    pcall(function() if requestEvent then requestEvent:InvokeServer("BuyArmor") end end)
end)
local autoBuyArmorEnabled = false
task.spawn(function()
    while true do
        task.wait(0.5)
        if autoBuyArmorEnabled and requestEvent then
            pcall(function() requestEvent:InvokeServer("BuyArmor") end)
        end
    end
end)
Toggle(mrTab, "Beli Armor Otomatis", false, function(v) autoBuyArmorEnabled = v end)

-- Buy Treadmill
Btn(mrTab, "Beli Treadmill", function()
    pcall(function() if requestEvent then requestEvent:InvokeServer("BuyTreadmill") end end)
end)
local autoBuyTreadmillEnabled = false
task.spawn(function()
    while true do
        task.wait(0.5)
        if autoBuyTreadmillEnabled and requestEvent then
            pcall(function() requestEvent:InvokeServer("BuyTreadmill") end)
        end
    end
end)
Toggle(mrTab, "Beli Treadmill Otomatis", false, function(v) autoBuyTreadmillEnabled = v end)

Sect(mrTab, "TRAILS")

local selectedTrail = "Gray"
local allTrails = {"Gray", "Green", "Blue", "Purple", "Gold", "Red", "Galaxy", "Secret", "Eternal", "Divine", "MoonBloom"}
Dropdown(mrTab, "Pilih Trail", allTrails, "Gray", function(v) selectedTrail = v end)

Btn(mrTab, "Beli Trail Dipilih", function()
    pcall(function() if requestEvent then requestEvent:InvokeServer("BuyTrail", selectedTrail) end end)
end)
Btn(mrTab, "Beli Semua Trail (Auto)", function()
    task.spawn(function()
        for _, trail in ipairs(allTrails) do
            pcall(function() if requestEvent then requestEvent:InvokeServer("BuyTrail", trail) end end)
            task.wait(0.1)
        end
    end)
end, Color3.fromRGB(120, 80, 40))

-- ═══════════════════════════════════════════════════════════
-- FILL: UNIVERSAL (NEW)
-- ═══════════════════════════════════════════════════════════
local uniTab = tabContent["Universal"]

Sect(uniTab, "TIME")

local timeLbl = Instance.new("TextLabel", uniTab)
timeLbl.Size = UDim2.new(1,-4,0,26)
timeLbl.BackgroundColor3 = C.Card
timeLbl.BackgroundTransparency = 0.25
timeLbl.BorderSizePixel = 0
timeLbl.Text = "🕐 --:--:--"
timeLbl.TextColor3 = C.Pri
timeLbl.TextSize = 12
timeLbl.Font = Enum.Font.GothamBold
timeLbl.ZIndex = 10
track(timeLbl, "TextColor3")
Instance.new("UICorner", timeLbl).CornerRadius = UDim.new(0,8)

task.spawn(function()
    while task.wait(1) do
        local t = os.date("*t")
        timeLbl.Text = string.format("🕐 %02d:%02d:%02d", t.hour, t.min, t.sec)
    end
end)

Toggle(uniTab, "Waktu Malam", false, function(v)
    Lighting.ClockTime = v and 0 or 14
end)

Sect(uniTab, "GRAPHICS")

local originalFogEnd = Lighting.FogEnd
Toggle(uniTab, "Tanpa Kabut", false, function(v)
    if v then Lighting.FogEnd = 1000000
    else Lighting.FogEnd = originalFogEnd end
end)

local fullbrightConn = nil
Toggle(uniTab, "Fullbright", false, function(v)
    if v then
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        fullbrightConn = RunService.RenderStepped:Connect(function()
            Lighting.Brightness = 2
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        end)
    else
        if fullbrightConn then
            fullbrightConn:Disconnect()
            fullbrightConn = nil
        end
        Lighting.GlobalShadows = true
        Lighting.Brightness = 1
        Lighting.OutdoorAmbient = Color3.fromRGB(127, 127, 127)
    end
end)

Btn(uniTab, "⚡ Peningkatan FPS (Grafik Kentang)", function()
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
            end
            if obj:IsA("ParticleEmitter") or obj:IsA("Trail") 
               or obj:IsA("Smoke") or obj:IsA("Fire") then
                obj.Enabled = false
            end
        end
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
    end)
    NotifyUser("FPS Boost", "Grafis diturunkan!", "success")
end, Color3.fromRGB(140, 90, 50))

-- ═══════════════════════════════════════════════════════════
-- FILL: LIVE (existing)
-- ═══════════════════════════════════════════════════════════
local liveFrame = Instance.new("Frame", tabContent.Live)
liveFrame.Size = UDim2.new(1,-4,0,260)
liveFrame.BackgroundColor3 = Color3.fromRGB(15,8,5)
liveFrame.BackgroundTransparency = 0.3
liveFrame.BorderSizePixel = 0
liveFrame.ZIndex = 10
Instance.new("UICorner", liveFrame).CornerRadius = UDim.new(0,8)

local clearLive = Instance.new("TextButton", liveFrame)
clearLive.Size = UDim2.new(0,56,0,22)
clearLive.Position = UDim2.new(1,-64,0,6)
clearLive.BackgroundColor3 = C.Red
clearLive.BackgroundTransparency = 0.15
clearLive.BorderSizePixel = 0
clearLive.Text = "CLEAR"
clearLive.TextColor3 = Color3.fromRGB(255,255,255)
clearLive.TextSize = 10
clearLive.Font = Enum.Font.GothamMedium
clearLive.AutoButtonColor = false
clearLive.ZIndex = 15
Instance.new("UICorner", clearLive).CornerRadius = UDim.new(0,6)

local liveScroll = Instance.new("ScrollingFrame", liveFrame)
liveScroll.Size = UDim2.new(1,-8,1,-32)
liveScroll.Position = UDim2.new(0,4,0,30)
liveScroll.BackgroundTransparency = 1
liveScroll.BorderSizePixel = 0
liveScroll.ScrollBarThickness = 3
liveScroll.ScrollBarImageColor3 = C.Pri
liveScroll.CanvasSize = UDim2.new(0,0,0,0)
liveScroll.ZIndex = 12
liveRef = liveScroll

clearLive.MouseButton1Click:Connect(function()
    LiveLog = {}
    for _, c in ipairs(liveRef:GetChildren()) do
        if c:IsA("TextLabel") then c:Destroy() end
    end
    liveRef.CanvasSize = UDim2.new(0,0,0,0)
    Log("Log cleared", "info")
end)

-- ═══════════════════════════════════════════════════════════
-- FILL: TEMA (existing)
-- ═══════════════════════════════════════════════════════════
Sect(tabContent.Tema, "BACKGROUND IMAGE")

local themeBtns = {}
for i, bg in ipairs(BG_LIST) do
    local b = Instance.new("TextButton", tabContent.Tema)
    b.Size = UDim2.new(1,-4,0,44)
    b.BackgroundColor3 = C.Card
    b.BackgroundTransparency = 0.25
    b.BorderSizePixel = 0
    b.Text = ""
    b.AutoButtonColor = false
    b.ZIndex = 11
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    local s = Instance.new("UIStroke", b)
    s.Color = (i == S.selBG) and C.Pri or Color3.fromRGB(80,80,88)
    s.Thickness = (i == S.selBG) and 2 or 1
    s.Transparency = (i == S.selBG) and 0.2 or 0.6
    s.Parent = b
    trackSearch(b, "Theme " .. bg.name)
    
    local prev = Instance.new("ImageLabel", b)
    prev.Size = UDim2.new(0,36,0,36)
    prev.Position = UDim2.new(0,6,0.5,-18)
    prev.BackgroundColor3 = Color3.fromRGB(55,55,63)
    prev.BorderSizePixel = 0
    prev.Image = bg.id
    prev.ZIndex = 12
    Instance.new("UICorner", prev).CornerRadius = UDim.new(0,7)
    
    local lbl = Instance.new("TextLabel", b)
    lbl.Size = UDim2.new(1,-86,0,14)
    lbl.Position = UDim2.new(0,48,0,8)
    lbl.BackgroundTransparency = 1
    lbl.Text = i .. ". " .. bg.name
    lbl.TextColor3 = (i == S.selBG) and C.Pri or C.Txt
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamMedium
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 12
    
    local chk = Instance.new("TextLabel", b)
    chk.Size = UDim2.new(0,24,1,0)
    chk.Position = UDim2.new(1,-28,0,0)
    chk.BackgroundTransparency = 1
    chk.Text = (i == S.selBG) and "V" or ""
    chk.TextColor3 = C.Pri
    chk.TextSize = 16
    chk.Font = Enum.Font.GothamBold
    chk.ZIndex = 12
    
    themeBtns[i] = {btn=b, stroke=s, lbl=lbl, chk=chk}
    
    b.MouseButton1Click:Connect(function()
        sfx()
        S.selBG = i
        for j, item in pairs(themeBtns) do
            local isSel = (j == S.selBG)
            item.stroke.Color = isSel and C.Pri or Color3.fromRGB(80,80,88)
            item.stroke.Thickness = isSel and 2 or 1
            item.stroke.Transparency = isSel and 0.2 or 0.6
            item.lbl.TextColor3 = isSel and C.Pri or C.Txt
            item.chk.Text = isSel and "V" or ""
        end
    end)
end

Btn(tabContent.Tema, "Ganti Background", function()
    if S.selBG == S.curBG then
        Log("Sama", "warn"); return
    end
    S.curBG = S.selBG
    bgI.Image = BG_LIST[S.curBG].id
    Log("BG: " .. BG_LIST[S.curBG].name, "success")
end, Color3.fromRGB(60,120,90))

Sect(tabContent.Tema, "BG BRIGHTNESS")
Slider(tabContent.Tema, "Kegelapan BG (x100)", 0, 80, math.floor(S.BGBrightness*100), function(v)
    S.BGBrightness = v/100
    ovl.BackgroundTransparency = S.BGBrightness
end)

-- ═══════════════════════════════════════════════════════════
-- FILL: MISC (existing)
-- ═══════════════════════════════════════════════════════════
Sect(tabContent.Misc, "UTILITY")
Btn(tabContent.Misc, "Rejoin Server", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, LP)
end, Color3.fromRGB(60, 120, 90))
Btn(tabContent.Misc, "Copy Discord Invite", function()
    if setclipboard then setclipboard(CONFIG.DISCORD) Log("Discord copied", "success") end
end)

Sect(tabContent.Misc, "RESET")
Btn(tabContent.Misc, "Unload UI", function()
    S.FPRunning = false
    task.wait(0.3)
    SG:Destroy()
end, Color3.fromRGB(150, 60, 70))

-- ═══════════════════════════════════════════════════════════
-- FILL: CREDIT (existing)
-- ═══════════════════════════════════════════════════════════
local creditCard = Instance.new("Frame", tabContent.Credit)
creditCard.Size = UDim2.new(1,-4,0,130)
creditCard.BackgroundColor3 = C.Card
creditCard.BackgroundTransparency = 0.25
creditCard.BorderSizePixel = 0
creditCard.ZIndex = 10
Instance.new("UICorner", creditCard).CornerRadius = UDim.new(0,12)

local creditLogo = Instance.new("ImageLabel", creditCard)
creditLogo.Size = UDim2.new(0, 56, 0, 56)
creditLogo.Position = UDim2.new(0.5, -28, 0, 10)
creditLogo.BackgroundTransparency = 1
creditLogo.Image = CONFIG.LOGO
creditLogo.ZIndex = 12

local creditTitle = Instance.new("TextLabel", creditCard)
creditTitle.Size = UDim2.new(1, -20, 0, 22)
creditTitle.Position = UDim2.new(0, 10, 0, 70)
creditTitle.BackgroundTransparency = 1
creditTitle.RichText = true
creditTitle.Text = '<font color="rgb(255,140,70)">Oc1Dv</font><font color="rgb(240,240,245)">HUB</font>'
creditTitle.TextSize = 18
creditTitle.Font = Enum.Font.GothamBlack
creditTitle.TextXAlignment = Enum.TextXAlignment.Center
creditTitle.ZIndex = 12

local creditSub = Instance.new("TextLabel", creditCard)
creditSub.Size = UDim2.new(1, -20, 0, 16)
creditSub.Position = UDim2.new(0, 10, 0, 94)
creditSub.BackgroundTransparency = 1
creditSub.Text = "RRFMLY UI + Air Hub"
creditSub.TextColor3 = C.Dim
creditSub.TextSize = 11
creditSub.Font = Enum.Font.GothamMedium
creditSub.TextXAlignment = Enum.TextXAlignment.Center
creditSub.ZIndex = 12

local creditMade = Instance.new("TextLabel", creditCard)
creditMade.Size = UDim2.new(1, -20, 0, 14)
creditMade.Position = UDim2.new(0, 10, 0, 112)
creditMade.BackgroundTransparency = 1
creditMade.Text = "Made by Oc1DvHUB - (c) 2026"
creditMade.TextColor3 = C.Dim
creditMade.TextSize = 10
creditMade.Font = Enum.Font.Gotham
creditMade.TextXAlignment = Enum.TextXAlignment.Center
creditMade.ZIndex = 12

Sect(tabContent.Credit, "DEVELOPER")
local devCard = Instance.new("Frame", tabContent.Credit)
devCard.Size = UDim2.new(1,-4,0,60)
devCard.BackgroundColor3 = C.Card
devCard.BackgroundTransparency = 0.25
devCard.BorderSizePixel = 0
devCard.ZIndex = 10
Instance.new("UICorner", devCard).CornerRadius = UDim.new(0,12)

local devName = Instance.new("TextLabel", devCard)
devName.Size = UDim2.new(1, -20, 0, 18)
devName.Position = UDim2.new(0, 12, 0, 12)
devName.BackgroundTransparency = 1
devName.Text = "Oc1DvHUB"
devName.TextColor3 = C.Txt
devName.TextSize = 13
devName.Font = Enum.Font.GothamBold
devName.TextXAlignment = Enum.TextXAlignment.Left
devName.ZIndex = 11

local devRole = Instance.new("TextLabel", devCard)
devRole.Size = UDim2.new(1, -20, 0, 16)
devRole.Position = UDim2.new(0, 12, 0, 32)
devRole.BackgroundTransparency = 1
devRole.Text = "UI Developer"
devRole.TextColor3 = C.Dim
devRole.TextSize = 10
devRole.Font = Enum.Font.Gotham
devRole.TextXAlignment = Enum.TextXAlignment.Left
devRole.ZIndex = 11

Sect(tabContent.Credit, "DISCORD")
local dcCard = Instance.new("Frame", tabContent.Credit)
dcCard.Size = UDim2.new(1,-4,0,54)
dcCard.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
dcCard.BackgroundTransparency = 0.15
dcCard.BorderSizePixel = 0
dcCard.ZIndex = 10
Instance.new("UICorner", dcCard).CornerRadius = UDim.new(0,12)

local dcTitle = Instance.new("TextLabel", dcCard)
dcTitle.Size = UDim2.new(1, -20, 0, 18)
dcTitle.Position = UDim2.new(0, 10, 0, 8)
dcTitle.BackgroundTransparency = 1
dcTitle.Text = "Join Discord Oc1DvHUB"
dcTitle.TextColor3 = Color3.fromRGB(255,255,255)
dcTitle.TextSize = 12
dcTitle.Font = Enum.Font.GothamBold
dcTitle.TextXAlignment = Enum.TextXAlignment.Left
dcTitle.ZIndex = 11

local dcSub = Instance.new("TextLabel", dcCard)
dcSub.Size = UDim2.new(1, -20, 0, 16)
dcSub.Position = UDim2.new(0, 10, 0, 28)
dcSub.BackgroundTransparency = 1
dcSub.Text = "discord.gg/wtVKkDvyz"
dcSub.TextColor3 = Color3.fromRGB(220,220,255)
dcSub.TextSize = 10
dcSub.Font = Enum.Font.GothamMedium
dcSub.TextXAlignment = Enum.TextXAlignment.Left
dcSub.ZIndex = 11

-- ═══════════════════════════════════════════════════════════
UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.RightShift then
        if Main.Visible then doClose() else doShow() end
    end
end)

Log("FINAL + Air Hub ready", "success")
NotifyUser("Oc1DvHUB", "FINAL + Air Hub loaded!", "success")
print("[Oc1DvHUB] FINAL + Air Hub loaded")

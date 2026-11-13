--========================================
-- REGAREZZ PRIVATE GUI V1.0
-- Owner: Dxrietzz
-- Theme: Midnight Blue / Mafia Gold
--========================================

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Old = PlayerGui:FindFirstChild("REGAREZZ_GUI")
if Old then Old:Destroy() end

local GUI = Instance.new("ScreenGui")
GUI.Name = "REGAREZZ_GUI"
GUI.ResetOnSpawn = false
GUI.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(310, 390)
Main.Position = UDim2.new(0.5, -155, 0.5, -195)
Main.BackgroundColor3 = Color3.fromRGB(10, 13, 23)
Main.BorderSizePixel = 0
Main.Parent = GUI

Instance.new("UICorner", Main).CornerRadius =
    UDim.new(0, 12)

local Border = Instance.new("UIStroke", Main)
Border.Color = Color3.fromRGB(190, 155, 75)
Border.Thickness = 1.5

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 48)
Header.BackgroundColor3 = Color3.fromRGB(20, 29, 48)
Header.BorderSizePixel = 0
Header.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.fromOffset(12, 0)
Title.BackgroundTransparency = 1
Title.Text = "REGAREZZ PRIVATE"
Title.TextColor3 = Color3.fromRGB(225, 190, 110)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(35, 30)
Close.Position = UDim2.new(1, -43, 0, 9)
Close.Text = "X"
Close.TextColor3 = Color3.new(1,1,1)
Close.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
Close.Font = Enum.Font.GothamBold
Close.Parent = Header

local Content = Instance.new("Frame")
Content.Position = UDim2.fromOffset(12, 60)
Content.Size = UDim2.new(1, -24, 1, -72)
Content.BackgroundTransparency = 1
Content.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 9)
Layout.Parent = Content

local function Label(text)
    local L = Instance.new("TextLabel")
    L.Size = UDim2.new(1, 0, 0, 38)
    L.BackgroundColor3 = Color3.fromRGB(22, 31, 49)
    L.TextColor3 = Color3.fromRGB(235, 235, 235)
    L.Text = text
    L.Font = Enum.Font.GothamMedium
    L.TextSize = 12
    L.Parent = Content

    Instance.new("UICorner", L).CornerRadius =
        UDim.new(0, 7)

    return L
end

Label("OWNER : Dxrietzz")

local Health = Label("HEALTH : Loading...")
local Position = Label("POSITION : Loading...")
local Speed = Label("SPEED : Loading...")
local Session = Label("SESSION : 00:00:00")
local Mining = Label("MINING COUNT : 0")

local Count = 0
local StartTime = os.time()

local Add = Instance.new("TextButton")
Add.Size = UDim2.new(1, 0, 0, 38)
Add.BackgroundColor3 = Color3.fromRGB(115, 87, 42)
Add.TextColor3 = Color3.new(1,1,1)
Add.Text = "+ ADD MINING COUNT"
Add.Font = Enum.Font.GothamBold
Add.TextSize = 12
Add.Parent = Content

Instance.new("UICorner", Add).CornerRadius =
    UDim.new(0, 7)

Add.MouseButton1Click:Connect(function()
    Count += 1
    Mining.Text = "MINING COUNT : " .. Count
end)

-- DRAG SYSTEM

local Dragging = false
local DragStart
local StartPos

Header.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = Input.Position
        StartPos = Main.Position
    end
end)

UIS.InputChanged:Connect(function(Input)
    if Dragging and (
        Input.UserInputType == Enum.UserInputType.MouseMovement
        or Input.UserInputType == Enum.UserInputType.Touch
    ) then

        local Delta = Input.Position - DragStart

        Main.Position = UDim2.new(
            StartPos.X.Scale,
            StartPos.X.Offset + Delta.X,
            StartPos.Y.Scale,
            StartPos.Y.Offset + Delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1
    or Input.UserInputType == Enum.UserInputType.Touch then
        Dragging = false
    end
end)

-- LIVE MONITOR

local Connection

Connection = RunService.RenderStepped:Connect(function()

    local Character = Player.Character
    local Humanoid = Character and
        Character:FindFirstChildOfClass("Humanoid")

    local Root = Character and
        Character:FindFirstChild("HumanoidRootPart")

    if Humanoid then
        Health.Text = "HEALTH : " ..
            math.floor(Humanoid.Health) .. "/" ..
            math.floor(Humanoid.MaxHealth)

        Speed.Text = "SPEED : " ..
            math.floor(Humanoid.WalkSpeed)
    end

    if Root then
        local P = Root.Position

        Position.Text = string.format(
            "POSITION : %.0f / %.0f / %.0f",
            P.X, P.Y, P.Z
        )
    end

    local T = os.time() - StartTime

    Session.Text = string.format(
        "SESSION : %02d:%02d:%02d",
        math.floor(T / 3600),
        math.floor((T % 3600) / 60),
        T % 60
    )
end)

Close.MouseButton1Click:Connect(function()
    if Connection then
        Connection:Disconnect()
    end

    GUI:Destroy()
end)

print("REGAREZZ PRIVATE GUI LOADED")

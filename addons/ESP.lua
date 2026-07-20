--!strict
-- Cyan player ESP addon. Uses Roblox Highlight instances and does not alter
-- character geometry or gameplay state.

local Players: Players = game:GetService("Players")
local CoreGui: CoreGui = game:GetService("CoreGui")
local RunService: RunService = game:GetService("RunService")
local UserInputService: UserInputService = game:GetService("UserInputService")

local gethui = gethui or function()
    return CoreGui
end

local ESP = {
    Enabled = false,
    TeamCheck = false,
    FillColor = Color3.fromRGB(125, 85, 255),
    OutlineColor = Color3.new(1, 1, 1),
    FillTransparency = 0.5,
    OutlineTransparency = 0,
    MaxTargetDistance = math.huge,
    TargetHotkey = Enum.KeyCode.Q,
    UpdateInterval = 0,
    Highlights = {},
    Connections = {},
}

local Container = Instance.new("Folder")
Container.Name = "CyanESP"
Container.Parent = gethui()

local Overlay = Instance.new("ScreenGui")
Overlay.Name = "CyanESPOverlay"
Overlay.ResetOnSpawn = false
Overlay.IgnoreGuiInset = true
Overlay.Parent = gethui()

local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "FOV"
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.BackgroundTransparency = 1
FOVCircle.Visible = false
FOVCircle.Parent = Overlay
local FOVCorner = Instance.new("UICorner")
FOVCorner.CornerRadius = UDim.new(1, 0)
FOVCorner.Parent = FOVCircle
local FOVStroke = Instance.new("UIStroke")
FOVStroke.Thickness = 1
FOVStroke.Color = ESP.OutlineColor
FOVStroke.Parent = FOVCircle

local TargetLabel = Instance.new("TextLabel")
TargetLabel.BackgroundTransparency = 1
TargetLabel.TextColor3 = Color3.new(1, 1, 1)
TargetLabel.TextSize = 14
TargetLabel.Visible = false
TargetLabel.Parent = Overlay

local function IsValidPlayer(Player: Player): boolean
    local LocalPlayer = Players.LocalPlayer
    return Player ~= LocalPlayer and (not ESP.TeamCheck or not LocalPlayer or Player.Team ~= LocalPlayer.Team)
end

function ESP:RemovePlayer(Player: Player)
    local Highlight = self.Highlights[Player]
    if Highlight then
        Highlight:Destroy()
        self.Highlights[Player] = nil
    end
end

function ESP:AddPlayer(Player: Player)
    if not self.Enabled or not IsValidPlayer(Player) then
        self:RemovePlayer(Player)
        return
    end

    local Character = Player.Character
    if not Character then
        return
    end

    local Highlight = self.Highlights[Player]
    if not Highlight then
        Highlight = Instance.new("Highlight")
        Highlight.Name = Player.Name
        Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        Highlight.Parent = Container
        self.Highlights[Player] = Highlight
    end

    Highlight.Adornee = Character
    Highlight.FillColor = self.FillColor
    Highlight.OutlineColor = self.OutlineColor
    Highlight.FillTransparency = self.FillTransparency
    Highlight.OutlineTransparency = self.OutlineTransparency
end

function ESP:Refresh()
    for _, Player in Players:GetPlayers() do
        self:AddPlayer(Player)
    end
end

function ESP:SetTeamCheck(Value: boolean)
    self.TeamCheck = Value
    self:Refresh()
end

function ESP:SetColors(FillColor: Color3, OutlineColor: Color3?)
    self.FillColor = FillColor
    if OutlineColor then
        self.OutlineColor = OutlineColor
    end
    self:Refresh()
end

function ESP:SetMaxTargetDistance(Distance: number)
    assert(Distance > 0, "Distance must be greater than 0")
    self.MaxTargetDistance = Distance
end

-- Returns the living player closest to the screen center. This is a read-only
-- selector: it never moves the camera or sends input on the user's behalf.
function ESP:GetNearestTarget(FOVRadius: number?): Player?
    local Camera = workspace.CurrentCamera
    local LocalPlayer = Players.LocalPlayer
    if not Camera or not LocalPlayer then return nil end

    local Viewport = Camera.ViewportSize
    local Center = Vector2.new(Viewport.X / 2, Viewport.Y / 2)
    local BestPlayer, BestDistance = nil, FOVRadius or math.huge

    for _, Player in Players:GetPlayers() do
        if IsValidPlayer(Player) then
            local Character = Player.Character
            local Root = Character and Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
            if Root and Humanoid and Humanoid.Health > 0 then
                local Point, OnScreen = Camera:WorldToViewportPoint(Root.Position)
                if OnScreen then
                    local Distance = (Vector2.new(Point.X, Point.Y) - Center).Magnitude
                    local WorldDistance = (Root.Position - Camera.CFrame.Position).Magnitude
                    if Distance <= BestDistance and WorldDistance <= self.MaxTargetDistance then
                        BestPlayer, BestDistance = Player, Distance
                    end
                end
            end
        end
    end

    return BestPlayer
end

function ESP:SetPerformanceMode(Value: boolean)
    -- Throttle overlay calculations when many players are present.
    self.UpdateInterval = Value and (1 / 15) or 0
end

function ESP:SetOverlayVisible(Value: boolean)
    FOVCircle.Visible = Value
    TargetLabel.Visible = Value
end

function ESP:SetFOVRadius(Radius: number)
    assert(Radius > 0, "FOV radius must be greater than 0")
    FOVCircle.Size = UDim2.fromOffset(Radius * 2, Radius * 2)
end

function ESP:SetTargetHotkey(Key: Enum.KeyCode)
    self.TargetHotkey = Key
end

local UpdateAccumulator = 0
local OverlayConnection = RunService.RenderStepped:Connect(function(DeltaTime)
    if not ESP.Enabled then return end
    UpdateAccumulator += DeltaTime
    if UpdateAccumulator < ESP.UpdateInterval then return end
    UpdateAccumulator = 0
    local Camera = workspace.CurrentCamera
    if not Camera then return end
    local Viewport = Camera.ViewportSize
    FOVCircle.Position = UDim2.fromOffset(Viewport.X / 2, Viewport.Y / 2)
    FOVStroke.Color = ESP.OutlineColor
    local Target = ESP:GetNearestTarget(FOVCircle.AbsoluteSize.X / 2)
    if Target and Target.Character then
        local Root = Target.Character:FindFirstChild("HumanoidRootPart")
        local Humanoid = Target.Character:FindFirstChildOfClass("Humanoid")
        if Root and Humanoid then
            local Point = Camera:WorldToViewportPoint(Root.Position)
            TargetLabel.Position = UDim2.fromOffset(Point.X + 10, Point.Y)
            TargetLabel.Text = string.format("%s | %.0f studs | HP %.0f", Target.Name, (Root.Position - Camera.CFrame.Position).Magnitude, Humanoid.Health)
            TargetLabel.Visible = FOVCircle.Visible
            return
        end
    end
    TargetLabel.Visible = false
end)
table.insert(ESP.Connections, OverlayConnection)

table.insert(ESP.Connections, UserInputService.InputBegan:Connect(function(Input, Processed)
    if not Processed and ESP.Enabled and Input.KeyCode == ESP.TargetHotkey then
        ESP.SelectedTarget = ESP:GetNearestTarget(FOVCircle.AbsoluteSize.X / 2)
    end
end))

function ESP:Enable()
    if self.Enabled then return end
    self.Enabled = true
    self:Refresh()
end

function ESP:Disable()
    self.Enabled = false
    for Player in self.Highlights do
        self:RemovePlayer(Player)
    end
end

function ESP:Destroy()
    self:Disable()
    for _, Connection in self.Connections do
        Connection:Disconnect()
    end
    table.clear(self.Connections)
    Container:Destroy()
    Overlay:Destroy()
end

table.insert(ESP.Connections, Players.PlayerAdded:Connect(function(Player)
    table.insert(ESP.Connections, Player.CharacterAdded:Connect(function()
        task.defer(function() ESP:AddPlayer(Player) end)
    end))
end))

table.insert(ESP.Connections, Players.PlayerRemoving:Connect(function(Player)
    ESP:RemovePlayer(Player)
end))

for _, Player in Players:GetPlayers() do
    table.insert(ESP.Connections, Player.CharacterAdded:Connect(function()
        task.defer(function() ESP:AddPlayer(Player) end)
    end))
end

return ESP

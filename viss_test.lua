    local ToolNames = {
        ["Bruno's M4A1"] = true, ["Crossbow"] = true, ["Salvaged Shovel"] = true, ["Salvaged Pipe Rifle"] = true,
        ["Steel Axe"] = true, ["Salvaged RPG"] = true, ["Small Medkit"] = true, ["Yellow Keycard"] = true,
        ["Salvaged Pump Action"] = true, ["Pink Keycard"] = true, ["Salvaged SMG"] = true, ["Salvaged AK47"] = true,
        ["Boulder"] = true, ["Care Package Signal"] = true, ["Salvaged AK74u"] = true, ["ez shovel"] = true,
        ["Dynamite Stick"] = true, ["Military Barrett"] = true, ["Nail Gun"] = true, ["Iron Shard Hatchet"] = true,
        ["Military M4A1"] = true, ["Wooden Spear"] = true, ["Dynamite Bundle"] = true, ["Stone Spear"] = true,
        ["Salvaged P250"] = true, ["Iron Shard Pickaxe"] = true, ["Military PKM"] = true, ["Steel Shovel"] = true,
        ["Timed Charge"] = true, ["Steel Pickaxe"] = true, ["Lighter"] = true, ["Blueprint"] = true,
        ["Salvaged M14"] = true, ["Machete"] = true, ["Stone Hatchet"] = true, ["Bandage"] = true,
        ["Saw Bat"] = true, ["Wooden Bow"] = true, ["Military Grenade"] = true, ["Health Pen"] = true,
        ["Candy Cane"] = true, ["Hammer"] = true, ["Military AA12"] = true, ["Salvaged Python"] = true,
        ["Purple Keycard"] = true, ["Bone Tool"] = true, ["Stone Pickaxe"] = true, ["Salvaged Skorpion"] = true,
        ["Salvaged Break Action"] = true
    }

-- Services
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Framework
local Framework = {}; Framework.__index = Framework; do
    function Framework:Round_V2(V2)
        return Vector2.new(math.floor(V2.X + 0.5), math.floor(V2.Y + 0.5))
    end
    function Framework:V3_To_V2(V3)
        return Vector2.new(V3.X, V3.Y)
    end
    function Framework:Draw(Object, Properties)
        Object = Drawing.new(Object)
        for Property, Value in pairs(Properties) do
            Object[Property] = Value
        end
        return Object
    end
    function Framework:Instance(Object, Properties)
        Object = Instance.new(Object)
        for Property, Value in pairs(Properties) do
            Object[Property] = Value
        end
        return Object
    end
    function Framework:Get_Bounding_Vectors(Part)
        local Part_CFrame, Part_Size = Part.CFrame, Part.Size 
        local X, Y, Z = Part_Size.X, Part_Size.Y, Part_Size.Z
        return {
            TBRC = Part_CFrame * CFrame.new(X, Y * 1.3, Z),
            TBLC = Part_CFrame * CFrame.new(-X, Y * 1.3, Z),
            TFRC = Part_CFrame * CFrame.new(X, Y * 1.3, -Z),
            TFLC = Part_CFrame * CFrame.new(-X, Y * 1.3, -Z),
            BBRC = Part_CFrame * CFrame.new(X, -Y * 1.6, Z),
            BBLC = Part_CFrame * CFrame.new(-X, -Y * 1.6, Z),
            BFRC = Part_CFrame * CFrame.new(X, -Y * 1.6, -Z),
            BFLC = Part_CFrame * CFrame.new(-X, -Y * 1.6, -Z),
        };
    end
    function Framework:Drawing_Transparency(Transparency)
        return 1 - Transparency
    end
end

-- Main
if not isfolder("ESP") then makefolder("ESP") end
if not isfolder("ESP/assets") then makefolder("ESP/assets") end
if not isfile("ESP/assets/taxi.oh") then
    writefile("ESP/assets/taxi.oh", game:HttpGet("https://raw.githubusercontent.com/tatar0071/IonHub/main/Assets/taxi.png"))
end
if not isfile("ESP/assets/gorilla.oh") then
    writefile("ESP/assets/gorilla.oh", game:HttpGet("https://raw.githubusercontent.com/tatar0071/IonHub/main/Assets/gorilla.png"))
end
if not isfile("ESP/assets/saul_goodman.oh") then
    writefile("ESP/assets/saul_goodman.oh", game:HttpGet("https://raw.githubusercontent.com/tatar0071/IonHub/main/Assets/saul_goodman.png"))
end
if not isfile("ESP/assets/peter_griffin.oh") then
    writefile("ESP/assets/peter_griffin.oh", game:HttpGet("https://raw.githubusercontent.com/tatar0071/IonHub/main/Assets/peter_griffin.png"))
end
if not isfile("ESP/assets/john_herbert.oh") then
    writefile("ESP/assets/john_herbert.oh", game:HttpGet("https://raw.githubusercontent.com/tatar0071/IonHub/main/Assets/john_herbert.png"))
end
if not isfile("ESP/assets/fortnite.oh") then
    writefile("ESP/assets/fortnite.oh", game:HttpGet("https://raw.githubusercontent.com/tatar0071/IonHub/main/Assets/fortnite.png"))
end
local Images = {
    Taxi = readfile("ESP/assets/taxi.oh"),
    Gorilla = readfile("ESP/assets/gorilla.oh"),
    ["Saul Goodman"] = readfile("ESP/assets/saul_goodman.oh"),
    ["Peter Griffin"] = readfile("ESP/assets/peter_griffin.oh"),
    ["John Herbert"] = readfile("ESP/assets/john_herbert.oh"),
    ["Fortnite"] = readfile("ESP/assets/fortnite.oh")
}

local ESP; ESP = {
    Settings = {
        Enabled = true,
        Bold_Text = true,
        Objects_Enabled = false,
        Team_Check = false,
        Improved_Visible_Check = false,
        Maximal_Distance = 1000,
        Object_Maximal_Distance = 1000,
        Weapon_Icons = {Enabled = true, Color = Color3.new(1,1,1),Position = "Bottom"},
        Highlight = {Enabled = false, Color = Color3.new(1, 0, 0), Target = ""},
        Box = {Enabled = true, Color = Color3.new(1, 1, 1), Transparency = 0},
        Box_Outline = {Enabled = true, Color = Color3.new(0, 0, 0), Transparency = 0, Outline_Size = 1},
        Healthbar = {Enabled = true, Position = "Left", Color = Color3.new(1, 1, 1), Color_Lerp = Color3.fromRGB(40, 252, 3)},
        Name = {Enabled = true, Position = "Top", Color = Color3.new(1, 1, 1), Transparency = 0, OutlineColor = Color3.new(0, 0, 0)},
        Distance = {Enabled = true, Position = "Bottom", Color = Color3.new(1, 1, 1), Transparency = 0, OutlineColor = Color3.new(0, 0, 0)},
        Tool = {Enabled = true, Position = "Right", Color = Color3.new(1, 1, 1), Transparency = 0, OutlineColor = Color3.new(0, 0, 0)},
        Health = {Enabled = true, Position = "Right", Transparency = 0, OutlineColor = Color3.new(0, 0, 0)},
        Image = {Enabled = false, Image = "Taxi", Raw = Images.Taxi},
        China_Hat = {Enabled = false, Color = Color3.new(1, 1, 1), Transparency = 0.5, Height = 0.5, Radius = 1, Offset = 1}
    },
    Objects = {},
    Overrides = {},
    China_Hat = {},
    second = false
}
ESP.__index = ESP

function ESP:UpdateImages()
    self.Settings.Image.Raw = Images[self.Settings.Image.Image]
    for _, Object in pairs(self.Objects) do
        for Index, Drawing in pairs(Object.Components) do
            if Index == "Image" then
                Drawing.Data = self.Settings.Image.Raw
            end
        end
    end
end

function ESP:GetObject(Object)
    return self.Objects[Object]
end

function ESP:Toggle(State)
    self.Settings.Enabled = State
end

function ESP:Get_Team(Player)
    if self.Overrides.Get_Team ~= nil then
        return self.Overrides.Get_Team(Player)
    end
    return Player.Team
end



function ESP:Get_Character(Player)
    if ESP.Overrides.Get_Character ~= nil then
        return ESP.Overrides.Get_Character(Player)
    end
    return Player.Character
end

function ESP:Get_Tool(Player)
    if self.Overrides.Get_Tool ~= nil then
        return self.Overrides.Get_Tool(Player)
    end
    for _, v in ipairs(Player.Character:GetChildren()) do
        if ToolNames[v.Name] then 
            return v.Name 
        end
    end
    return "Hands"
end

function ESP:Get_Health(Player)
   if self.Overrides.Get_Character ~= nil then
        return self.Overrides.Get_Health(Player)
    end
    local Character = self:Get_Character(Player)
    if Character then
        local Humanoid = Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            return Humanoid.Health
        end
    end
    return 100
end

local Passed = false
local function Pass_Through(From, Target, RaycastParams_, Ignore_Table)
    RaycastParams_.FilterDescendantsInstances = Ignore_Table
    local Result = Workspace:Raycast(From, (Target.Position - From).unit * 10000, RaycastParams_)
    if Result then
        local Instance_ = Result.Instance
        if Instance_:IsDescendantOf(Target.Parent) then
            Passed = true
            return true
        elseif Instance_.CanCollide == false or Instance_.Transparency == 1 then
            if Instance_.Name ~= "Head" and Instance_.Name ~= "HumanoidRootPart" then
                table.insert(Ignore_Table, Instance_)
                Pass_Through(Result.Position, Target, RaycastParams_, Ignore_Table)
            end
        end
    end
end

function ESP:Check_Visible(Target, FromHead)
    if self.Overrides.Check_Visible ~= nil then
        return self.Overrides.Check_Visible(Player)
    end
    local Character = LocalPlayer.Character
    if not Character then return false end
    local Head = Character:FindFirstChild("Head")
    if not Head then return false end
    local RaycastParams_ = RaycastParams.new();
    RaycastParams_.FilterType = Enum.RaycastFilterType.Blacklist;
    local Ignore_Table = {Camera, LocalPlayer.Character}
    RaycastParams_.FilterDescendantsInstances = Ignore_Table;
    RaycastParams_.IgnoreWater = true;
    local From = FromHead and Head.Position or Camera.CFrame.p
    local Result = Workspace:Raycast(From, (Target.Position - From).unit * 10000, RaycastParams_)
    Passed = false
    if Result then
        local Instance_ = Result.Instance
        if Instance_:IsDescendantOf(Target.Parent) then
            return true
        elseif ESP.Settings.Improved_Visible_Check and Instance_.CanCollide == false or Instance_.Transparency == 1 then
            if Instance_.Name ~= "Head" and Instance_.Name ~= "HumanoidRootPart" then
                table.insert(Ignore_Table, Instance_)
                Pass_Through(Result.Position, Target, RaycastParams_, Ignore_Table)
            end
        end
    end
    return Passed
end

local Player_Metatable = {}
do -- Player Metatable
    Player_Metatable.__index = Player_Metatable
    function Player_Metatable:Destroy()
        for Index, Component in pairs(self.Components) do

            Component.Visible = false
            Component:Remove()
            self.Components[Index] = nil
        end
        ESP.Objects[self.Player] = nil
    end
    function Player_Metatable:Update()
        local Box, Box_Outline = self.Components.Box, self.Components.Box_Outline
        local Healthbar, Healthbar_Outline = self.Components.Healthbar, self.Components.Healthbar_Outline
        local Name, NameBold = self.Components.Name, self.Components.NameBold
        local Distance, DistanceBold = self.Components.Distance, self.Components.DistanceBold
        local WeaponIcons = self.Components.WeaponIcons
        local Tool, ToolBold = self.Components.Tool, self.Components.ToolBold
        local Health, HealthBold = self.Components.Health, self.Components.HealthBold
      
        local Image = self.Components.Image
        if Box == nil or Box_Outline == nil or Healthbar == nil or Healthbar_Outline == nil or Name == nil or NameBold == nil or Distance == nil or DistanceBold == nil or Tool == nil or ToolBold == nil or Health == nil or HealthBold == nil or WeaponIcons == nil then
            self:Destroy()
        end
        local Character = ESP:Get_Character(self.Player)
        if Character ~= nil then
            local Head, HumanoidRootPart = Character:FindFirstChild("Head"), Character:FindFirstChild("HumanoidRootPart")
            if not HumanoidRootPart then
                Box.Visible = false
                Box_Outline.Visible = false
                Healthbar.Visible = false
                Healthbar_Outline.Visible = false
                Name.Visible = false
                NameBold.Visible = false
                Distance.Visible = false
                DistanceBold.Visible = false
                WeaponIcons.Visible = false
                Tool.Visible = false
                ToolBold.Visible = false
                Health.Visible = false
                HealthBold.Visible = false
               
                Image.Visible = false
                return
            end

            local Current_Health, Health_Maximum = ESP:Get_Health(self.Player), 100
            if Head and HumanoidRootPart and Current_Health > 0 then
                local Dimensions = Framework:Get_Bounding_Vectors(HumanoidRootPart)
                local HRP_Position, On_Screen = Camera:WorldToViewportPoint(HumanoidRootPart.Position)
                local Stud_Distance, Meter_Distance = math.floor(HRP_Position.Z + 0.5), math.floor(HRP_Position.Z / 3.5714285714 + 0.5)

                local Y_Minimal, Y_Maximal = Camera.ViewportSize.X, 0
                local X_Minimal, X_Maximal = Camera.ViewportSize.X, 0

                for _, CF in pairs(Dimensions) do
                    local Vector = Camera:WorldToViewportPoint(CF.Position)
                    local X, Y = Vector.X, Vector.Y
                    if X < X_Minimal then 
                        X_Minimal = X
                    end
                    if X > X_Maximal then 
                        X_Maximal = X
                    end
                    if Y < Y_Minimal then 
                        Y_Minimal = Y
                    end
                    if Y > Y_Maximal then
                        Y_Maximal = Y
                    end
                end

                local Box_Size = Framework:Round_V2(Vector2.new(X_Minimal - X_Maximal, Y_Minimal - Y_Maximal))
                local Box_Position = Framework:Round_V2(Vector2.new(X_Maximal + Box_Size.X / X_Minimal, Y_Maximal + Box_Size.Y / Y_Minimal))
                local Good = false

                if ESP.Settings.Team_Check then
                    if ESP:Get_Team(self.Player) ~= ESP:Get_Team(LocalPlayer) then
                        Good = true
                    end
                else
                    Good = true
                end

                if ESP.Settings.Enabled and On_Screen and Meter_Distance < ESP.Settings.Maximal_Distance and Good then
                    local Highlight_Settings = ESP.Settings.Highlight
                    local Is_Highlighted = Highlight_Settings.Enabled and Highlight_Settings.Target == Character or false
                    local Highlight_Color = Highlight_Settings.Color

                    -- Offsets
                    local Top_Offset = 3
                    local Bottom_Offset = Y_Maximal + 1
                    local Left_Offset = 0
                    local Right_Offset = 0

                    -- Box
                    local Box_Settings = ESP.Settings.Box
                    Box.Size = Box_Size
                    Box.Position = Box_Position
                    Box.Color = Is_Highlighted and Highlight_Color or Box_Settings.Color
                    Box.Transparency = Framework:Drawing_Transparency(Box_Settings.Transparency)
                    Box.Visible = Box_Settings.Enabled

                    local Box_Outline_Settings = ESP.Settings.Box_Outline
                    Box_Outline.Size = Box_Size
                    Box_Outline.Position = Box_Position
                    Box_Outline.Color = Box_Outline_Settings.Color
                    Box_Outline.Thickness = Box_Outline_Settings.Outline_Size + 2
                    Box_Outline.Transparency = Framework:Drawing_Transparency(Box_Outline_Settings.Transparency)
                    Box_Outline.Visible = Box_Settings.Enabled and Box_Outline_Settings.Enabled or false

                    local Image_Settings = ESP.Settings.Image
                    local Image_Enabled = Image_Settings.Enabled
                    if Image_Enabled then
                        Image.Size = -Box_Size
                        Image.Position = Box_Position + Box_Size
                    end
                    Image.Visible = Image_Enabled

                    -- Healthbar
                    local Health_Top_Size_Outline = Vector2.new(Box_Size.X - 4, 3)
                    local Health_Top_Pos_Outline = Box_Position + Vector2.new(2, Box_Size.Y - 6)
                    local Health_Top_Size_Fill = Vector2.new((Current_Health * Health_Top_Size_Outline.X / Health_Maximum) + 2, 1)
                    local Health_Top_Pos_Fill = Health_Top_Pos_Outline + Vector2.new(1 + -(Health_Top_Size_Fill.X - Health_Top_Size_Outline.X),1);

                    local Health_Left_Size_Outline = Vector2.new(3, Box_Size.Y - 4)
                    local Health_Left_Pos_Outline = Vector2.new(X_Maximal + Box_Size.X - 6, Box_Position.Y + 2)
                    local Health_Left_Size_Fill = Vector2.new(1, (Current_Health * Health_Left_Size_Outline.Y / Health_Maximum) + 2)
                    local Health_Left_Pos_Fill = Health_Left_Pos_Outline + Vector2.new(1,-1 + -(Health_Left_Size_Fill.Y - Health_Left_Size_Fill.Y));

                    local Healthbar_Settings = ESP.Settings.Healthbar
                    local Healthbar_Enabled = Healthbar_Settings.Enabled
                    local Healthbar_Position = Healthbar_Settings.Position
                    local Health_Lerp_Color = Healthbar_Settings.Color:Lerp(Healthbar_Settings.Color_Lerp, Current_Health / Health_Maximum)
                    if Healthbar_Enabled then
                        if Healthbar_Position == "Left" then
                            Healthbar.Size = Health_Left_Size_Fill;
                            Healthbar.Position = Health_Left_Pos_Fill;
                            Healthbar_Outline.Size = Health_Left_Size_Outline;
                            Healthbar_Outline.Position = Health_Left_Pos_Outline;
                        elseif Healthbar_Position == "Right" then
                            Healthbar.Size = Health_Left_Size_Fill;
                            Healthbar.Position = Vector2.new(X_Maximal + Box_Size.X + 4, Box_Position.Y + 1) - Vector2.new(Box_Size.X, 0)
                            Healthbar_Outline.Size = Health_Left_Size_Outline
                            Healthbar_Outline.Position = Vector2.new(X_Maximal + Box_Size.X + 3, Box_Position.Y + 2) - Vector2.new(Box_Size.X, 0)
                        elseif Healthbar_Position == "Top" then
                            Healthbar.Size = Health_Top_Size_Fill;
                            Healthbar.Position = Health_Top_Pos_Fill;
                            Healthbar_Outline.Size = Health_Top_Size_Outline;
                            Healthbar_Outline.Position = Health_Top_Pos_Outline;
                            Top_Offset = Top_Offset + 6
                        elseif Healthbar_Position == "Bottom" then
                            Healthbar.Size = Health_Top_Size_Fill
                            Healthbar.Position = Health_Top_Pos_Fill - Vector2.new(0, Box_Size.Y - 9)
                            Healthbar_Outline.Size = Health_Top_Size_Outline;
                            Healthbar_Outline.Position = Health_Top_Pos_Outline - Vector2.new(0, Box_Size.Y - 9)
                            Bottom_Offset = Bottom_Offset + 6
                        end
                        Healthbar.Color = Health_Lerp_Color
                    end
                    Healthbar.Visible = Healthbar_Enabled
                    Healthbar_Outline.Visible = Healthbar_Enabled

                    -- Name
                    local Name_Settings = ESP.Settings.Name
                    local Name_Position = Name_Settings.Position
                    if Name_Position == "Top" then 
                        Name.Position = Vector2.new(X_Maximal + Box_Size.X / 2, Box_Position.Y) - Vector2.new(0, Name.TextBounds.Y - Box_Size.Y + Top_Offset) 
                        Top_Offset = Top_Offset + 10
                    elseif Name_Position == "Bottom" then
                        Name.Position = Vector2.new(Box_Size.X / 2 + Box_Position.X, Bottom_Offset) 
                        Bottom_Offset = Bottom_Offset + 10
                    elseif Name_Position == "Left" then
                        if Healthbar_Position == "Left" then
                            Name.Position = Health_Left_Pos_Outline - Vector2.new(Name.TextBounds.X/2 - 2 + 4, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Left_Offset)
                        else
                            Name.Position = Health_Left_Pos_Outline - Vector2.new(Name.TextBounds.X/2 - 2, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Left_Offset)
                        end
                        Left_Offset = Left_Offset + 10
                    elseif Name_Position == "Right" then
                        if Healthbar_Position == "Right" then
                            Name.Position = Vector2.new(X_Maximal + Box_Size.X + 4 + 4 + Name.TextBounds.X / 2, Box_Position.Y + 2) - Vector2.new(Box_Size.X, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Right_Offset)
                        else
                            Name.Position = Vector2.new(X_Maximal + Box_Size.X + 3 + Name.TextBounds.X / 2, Box_Position.Y + 2) - Vector2.new(Box_Size.X, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Right_Offset)
                        end
                        Right_Offset = Right_Offset + 10
                    end
                    Name.Color = Is_Highlighted and Highlight_Color or Name_Settings.Color
                    Name.OutlineColor = Name_Settings.OutlineColor
                    Name.Transparency = Framework:Drawing_Transparency(Name_Settings.Transparency)
                    Name.Text = Character.Name
                    Name.Visible = Name_Settings.Enabled
                    NameBold.Color = Is_Highlighted and Highlight_Color or Name_Settings.Color
                    NameBold.OutlineColor = Name_Settings.OutlineColor
                    NameBold.Transparency = Framework:Drawing_Transparency(Name_Settings.Transparency)
                    NameBold.Position = Name.Position + Vector2.new(1, 0)
                    NameBold.Text = Character.Name
                    NameBold.Visible = Name.Visible and ESP.Settings.Bold_Text

                    -- Tool
                    local Tool_Settings = ESP.Settings.Tool
                    local Tool_Position = Tool_Settings.Position
                    if Tool_Position == "Top" then 
                        Tool.Position = Vector2.new(X_Maximal + Box_Size.X / 2, Box_Position.Y) - Vector2.new(0, Tool.TextBounds.Y - Box_Size.Y + Top_Offset) 
                        Top_Offset = Top_Offset + 10
                    elseif Tool_Position == "Bottom" then
                        Tool.Position = Vector2.new(Box_Size.X / 2 + Box_Position.X, Bottom_Offset + 5) 
                        Bottom_Offset = Bottom_Offset + 10
                    elseif Tool_Position == "Left" then
                        if Healthbar_Position == "Left" then
                            Tool.Position = Health_Left_Pos_Outline - Vector2.new(Tool.TextBounds.X/2 - 2 + 4, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Left_Offset)
                        else
                            Tool.Position = Health_Left_Pos_Outline - Vector2.new(Tool.TextBounds.X/2 - 2, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Left_Offset)
                        end
                        Left_Offset = Left_Offset + 10
                    elseif Tool_Position == "Right" then
                        if Healthbar_Position == "Right" then
                            Tool.Position = Vector2.new(X_Maximal + Box_Size.X + 4 + 4 + Tool.TextBounds.X / 2, Box_Position.Y + 2) - Vector2.new(Box_Size.X, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Right_Offset)
                        else
                            Tool.Position = Vector2.new(X_Maximal + Box_Size.X + 3 + Tool.TextBounds.X / 2, Box_Position.Y + 2) - Vector2.new(Box_Size.X, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Right_Offset)
                        end
                        Right_Offset = Right_Offset + 10
                    end
                   
                    Tool.Text = ESP:Get_Tool(self.Player)
                    Tool.Color = Is_Highlighted and Highlight_Color or Tool_Settings.Color
                    Tool.OutlineColor = Tool_Settings.OutlineColor
                    Tool.Transparency = Framework:Drawing_Transparency(Tool_Settings.Transparency)
                    Tool.Visible = Tool_Settings.Enabled
                    ToolBold.Text = ESP:Get_Tool(self.Player)
                    ToolBold.Color = Is_Highlighted and Highlight_Color or Tool_Settings.Color
                    ToolBold.OutlineColor = Tool_Settings.OutlineColor
                    ToolBold.Transparency = Framework:Drawing_Transparency(Tool_Settings.Transparency)
                    ToolBold.Position = Tool.Position + Vector2.new(1, 0)
                    ToolBold.Visible = Tool.Visible and ESP.Settings.Bold_Text

                     -- WeaponIcons
                    local WeaponIcons_Settings = ESP.Settings.Weapon_Icons
                    local WeaponIcons_Position = WeaponIcons_Settings.Position
                    if WeaponIcons_Position == "Top" then 
                        WeaponIcons.Position = Vector2.new(X_Maximal + Box_Size.X / 2, Box_Position.Y) - Vector2.new(0, WeaponIcons.TextBounds.Y - Box_Size.Y + Top_Offset) 
                        Top_Offset = Top_Offset + 10
                    elseif WeaponIcons_Position == "Bottom" then
                        WeaponIcons.Position = Vector2.new(Box_Size.X / 2 + Box_Position.X, Bottom_Offset) 
                        Bottom_Offset = Bottom_Offset + 10
                    elseif WeaponIcons_Position == "Left" then
                        if Healthbar_Position == "Left" then
                            WeaponIcons.Position = Health_Left_Pos_Outline - Vector2.new(WeaponIcons.TextBounds.X/2 - 2 + 4, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Left_Offset)
                        else
                            WeaponIcons.Position = Health_Left_Pos_Outline - Vector2.new(WeaponIcons.TextBounds.X/2 - 2, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Left_Offset)
                        end
                        Left_Offset = Left_Offset + 10
                    elseif WeaponIcons_Position == "Right" then
                        if Healthbar_Position == "Right" then
                            WeaponIcons.Position = Vector2.new(X_Maximal + Box_Size.X + 4 + 4 + WeaponIcons.TextBounds.X / 2, Box_Position.Y + 2) - Vector2.new(Box_Size.X, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Right_Offset)
                        else
                            WeaponIcons.Position = Vector2.new(X_Maximal + Box_Size.X + 3 + WeaponIcons.TextBounds.X / 2, Box_Position.Y + 2) - Vector2.new(Box_Size.X, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Right_Offset)
                        end
                        Right_Offset = Right_Offset + 10
                    end
                    WeaponIcons.Color = Is_Highlighted and Highlight_Color or WeaponIcons_Settings.Color
                    WeaponIcons.Transparency = 0
                    WeaponIcons.Visible = WeaponIcons_Settings.Enabled
                    WeaponIcons.Data = crypt.base64decode("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")
                    
                     -- Distance
                    local Distance_Settings = ESP.Settings.Distance
                    local Distance_Position = Distance_Settings.Position
                    if Distance_Position == "Top" then 
                        Distance.Position = Vector2.new(X_Maximal + Box_Size.X / 2, Box_Position.Y) - Vector2.new(0, Distance.TextBounds.Y - Box_Size.Y + Top_Offset) 
                        Top_Offset = Top_Offset + 10
                    elseif Distance_Position == "Bottom" then
                        Distance.Position = Vector2.new(Box_Size.X / 2 + Box_Position.X, Bottom_Offset) 
                        Bottom_Offset = Bottom_Offset + 10
                    elseif Distance_Position == "Left" then
                        if Healthbar_Position == "Left" then
                            Distance.Position = Health_Left_Pos_Outline - Vector2.new(Distance.TextBounds.X/2 - 2 + 4, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Left_Offset)
                        else
                            Distance.Position = Health_Left_Pos_Outline - Vector2.new(Distance.TextBounds.X/2 - 2, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Left_Offset)
                        end
                        Left_Offset = Left_Offset + 10
                    elseif Distance_Position == "Right" then
                        if Healthbar_Position == "Right" then
                            Distance.Position = Vector2.new(X_Maximal + Box_Size.X + 4 + 4 + Distance.TextBounds.X / 2, Box_Position.Y + 2) - Vector2.new(Box_Size.X, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Right_Offset)
                        else
                            Distance.Position = Vector2.new(X_Maximal + Box_Size.X + 3 + Distance.TextBounds.X / 2, Box_Position.Y + 2) - Vector2.new(Box_Size.X, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Right_Offset)
                        end
                        Right_Offset = Right_Offset + 10
                    end
                    Distance.Text = Meter_Distance.."m"
                    Distance.Color = Is_Highlighted and Highlight_Color or Distance_Settings.Color
                    Distance.OutlineColor = Distance_Settings.OutlineColor
                    Distance.Transparency = Framework:Drawing_Transparency(Distance_Settings.Transparency)
                    Distance.Visible = Distance_Settings.Enabled
                    DistanceBold.Text = Meter_Distance.."m"
                    DistanceBold.Color = Is_Highlighted and Highlight_Color or Distance_Settings.Color
                    DistanceBold.OutlineColor = Distance_Settings.OutlineColor
                    DistanceBold.Transparency = Framework:Drawing_Transparency(Distance_Settings.Transparency)
                    DistanceBold.Position = Distance.Position + Vector2.new(1, 0)
                    DistanceBold.Visible = Distance.Visible and ESP.Settings.Bold_Text

                    -- Health
                    local Health_Settings = ESP.Settings.Health
                    local Health_Position = Health_Settings.Position
                    if Health_Position == "Top" then 
                        Health.Position = Vector2.new(X_Maximal + Box_Size.X / 2, Box_Position.Y) - Vector2.new(0, Health.TextBounds.Y - Box_Size.Y + Top_Offset) 
                        Top_Offset = Top_Offset + 10
                    elseif Health_Position == "Bottom" then
                        Health.Position = Vector2.new(Box_Size.X / 2 + Box_Position.X, Bottom_Offset) 
                        Bottom_Offset = Bottom_Offset + 10
                    elseif Health_Position == "Left" then
                        if Healthbar_Position == "Left" then
                            Health.Position = Health_Left_Pos_Outline - Vector2.new(Health.TextBounds.X/2 - 2 + 4, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Left_Offset)
                        else
                            Health.Position = Health_Left_Pos_Outline - Vector2.new(Health.TextBounds.X/2 - 2, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Left_Offset)
                        end
                        Left_Offset = Left_Offset + 10
                    elseif Health_Position == "Right" then
                        if Healthbar_Position == "Right" then
                            Health.Position = Vector2.new(X_Maximal + Box_Size.X + 4 + 4 + Health.TextBounds.X / 2, Box_Position.Y + 2) - Vector2.new(Box_Size.X, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Right_Offset)
                        else
                            Health.Position = Vector2.new(X_Maximal + Box_Size.X + 3 + Health.TextBounds.X / 2, Box_Position.Y + 2) - Vector2.new(Box_Size.X, -(100 * Health_Left_Size_Outline.Y / 100) + 2 - Right_Offset)
                        end
                        Right_Offset = Right_Offset + 10
                    end
                    Health.Text = tostring(math.floor(Current_Health + 0.5))
                    Health.Color = Health_Lerp_Color
                    Health.OutlineColor = Health_Settings.OutlineColor
                    Health.Transparency = Framework:Drawing_Transparency(Health_Settings.Transparency)
                    Health.Visible = Health_Settings.Enabled
                    HealthBold.Text = tostring(math.floor(Current_Health + 0.5))
                    HealthBold.Color = Health_Lerp_Color
                    HealthBold.OutlineColor = Health_Settings.OutlineColor
                    HealthBold.Transparency = Framework:Drawing_Transparency(Health_Settings.Transparency)
                    HealthBold.Position = Health.Position + Vector2.new(1, 0)
                    HealthBold.Visible = Health.Visible and ESP.Settings.Bold_Text

                else
                    Box.Visible = false
                    Box_Outline.Visible = false
                    Healthbar.Visible = false
                    Healthbar_Outline.Visible = false
                    Name.Visible = false
                    NameBold.Visible = false
                    Distance.Visible = false
                    DistanceBold.Visible = false
                    WeaponIcons.Visible = false
                    Tool.Visible = false
                    ToolBold.Visible = false
                    Health.Visible = false
                    HealthBold.Visible = false
                   
                    Image.Visible = false
                    return
                end

            else
                Box.Visible = false
                Box_Outline.Visible = false
                Healthbar.Visible = false
                Healthbar_Outline.Visible = false
                Name.Visible = false
                NameBold.Visible = false
                Distance.Visible = false
                DistanceBold.Visible = false
                WeaponIcons.Visible = false
                Tool.Visible = false
                ToolBold.Visible = false
                Health.Visible = false
                HealthBold.Visible = false
               
                Image.Visible = false
                return
            end
        else
            Box.Visible = false
            Box_Outline.Visible = false
            Healthbar.Visible = false
            Healthbar_Outline.Visible = false
            Name.Visible = false
            NameBold.Visible = false
            Distance.Visible = false
            DistanceBold.Visible = false
            WeaponIcons.Visible = false
            Tool.Visible = false
            ToolBold.Visible = false
            Health.Visible = false
            HealthBold.Visible = false

            Image.Visible = false
            return
        end
    end
end
local Object_Metatable = {}
do  -- Object Metatable
    Object_Metatable.__index = Object_Metatable
    function Object_Metatable:Destroy()
        for Index, Component in pairs(self.Components) do
            Component.Visible = false
            Component:Remove()
            self.Components[Index] = nil
        end
        ESP.Objects[self.Object] = nil
    end
    function Object_Metatable:Update()
        local Name = self.Components.Name
        local Addition = self.Components.Addition

        if not ESP.Settings.Objects_Enabled then
            Name.Visible = false
            Addition.Visible = false
            return
        end

        local Vector, On_Screen = Camera:WorldToViewportPoint(self.PrimaryPart.Position + Vector3.new(0, 1, 0))

        local Meter_Distance = math.floor(Vector.Z / 3.5714285714 + 0.5)

        if On_Screen and Meter_Distance < ESP.Settings.Object_Maximal_Distance then
            -- Name
            Name.Text = self.Name .. " [" .. math.floor(Vector.Z / 3.5714285714 + 0.5) .. "m]"
            Name.Position = Framework:V3_To_V2(Vector)
            Name.Visible = true

            -- Addition
            if self.Addition.Text ~= "" then
                Addition.Position = Name.Position + Vector2.new(0, Name.TextBounds.Y)
                Addition.Visible = true
            else
                Addition.Visible = false
            end
        else
            Name.Visible = false
            Addition.Visible = false
            return
        end
    end
end
do -- ESP Functions
    function ESP:Player(Instance, Data)
        if Instance == nil then
       
        end
        if Data == nil or type(Data) ~= "table" then
            Data = {
                Player = Instance
            }
        end
        local Object = setmetatable({
            Player = Data.Player or Data.player or Data.Plr or Data.plr or Data.Ply or Data.ply or Instance,
            Components = {},
            Type = "Player"
        }, Player_Metatable)
        if self:GetObject(Instance) then
            self:GetObject(Instance):Destroy()
        end
        local Components = Object.Components
        Components.Box = Framework:Draw("Square", {Thickness = 1, ZIndex = 2})
        Components.Box_Outline = Framework:Draw("Square", {Thickness = 3, ZIndex = 1})
        Components.Healthbar = Framework:Draw("Square", {Thickness = 1, ZIndex = 2, Filled = true})
        Components.Healthbar_Outline = Framework:Draw("Square", {Thickness = 3, ZIndex = 1, Filled = true})
        Components.Name = Framework:Draw("Text", {Text = "Player", Font = 2, Size = 13, Outline = true, Center = true})
        Components.NameBold = Framework:Draw("Text", {Text = "Player", Font = 2, Size = 13, Center = true})
        Components.Distance = Framework:Draw("Text", {Font = 2, Size = 13, Outline = true, Center = true})
        Components.WeaponIcons = Framework:Draw("Image", {Size = Vector2.new(50,20)})
        Components.DistanceBold = Framework:Draw("Text", {Font = 2, Size = 13, Center = true})
        Components.Tool = Framework:Draw("Text", {Font = 2, Size = 13, Outline = true, Center = true})
        Components.ToolBold = Framework:Draw("Text", {Font = 2, Size = 13, Center = true})
        Components.Health = Framework:Draw("Text", {Font = 2, Size = 13, Outline = true, Center = true})
        Components.HealthBold = Framework:Draw("Text", {Font = 2, Size = 13, Center = true})
       
        Components.Image = Framework:Draw("Image", {Data = self.Settings.Image.Raw})
        self.Objects[Instance] = Object
        return Object
    end
    function ESP:Object(Instance, Data)
        if Data == nil or type(Data) ~= "table" then
         
        end
        local Addition = Data.Addition or Data.addition or Data.add or Data.Add or {}
        if Addition.Text == nil then
            Addition.Text = Addition.text or ""
        end
        if Addition.Color == nil then
            Addition.Color = Addition.Color or Addition.color or Addition.col or Addition.Col or Color3.new(1, 1, 1)
        end
        local obj = Data.Object or Data.object or Data.Obj or Data.obj or Instance
        local col = Data.Color or Data.color or Data.col or Data.Col or Color3.new(1, 1, 1)
        local out = Data.outline or Data.Outline or false
        local trans = Data.trans or Data.Trans or Data.Transparency or Data.transparency or Data.Alpha or Data.alpha or 1
        local Object = setmetatable({
            Object = obj,
            PrimaryPart = Data.PrimaryPart or Data.primarypart or Data.pp or Data.PP or Data.primpart or Data.PrimPart or Data.PPart or Data.ppart or Data.pPart or Data.Ppart or obj:IsA("Model") and obj.PrimaryPart or obj:FindFirstChildOfClass("BasePart") or obj:IsA("BasePart") and obj or nil,
            Addition = Addition,
            Components = {},
            Type = Data.Type,
            Name = (Data.Name ~= nil and Data.Name) or "Player"
        }, Object_Metatable)
        if Object.PrimaryPart == nil then
            return
        end
        if self:GetObject(Instance) then
            self:GetObject(Instance):Destroy()
        end
        local Components = Object.Components
        Components.Name = Framework:Draw("Text", {Text = Object.Name, Color = col, Font = 2, Size = 13, Outline = out, Center = true, Transparency = trans})
        Components.Addition = Framework:Draw("Text", {Text = Object.Addition.Text, Color = Object.Addition.Color, Font = 2, Size = 13, Outline = out, Center = true, Transparency = trans})
        self.Objects[Instance] = Object
        return Object
    end
end

-- China Hat
for i = 1, 30 do
    ESP.China_Hat[i] = {Framework:Draw('Line', {Visible = false}), Framework:Draw('Triangle', {Visible = false})}
    ESP.China_Hat[i][1].ZIndex = 2;
    ESP.China_Hat[i][1].Thickness = 2;
    ESP.China_Hat[i][2].ZIndex = 1;
    ESP.China_Hat[i][2].Filled = true;
end

-- Render Connection
local Connection = RunService.RenderStepped:Connect(function()
    -- Object Updating
    for i, Object in pairs(ESP.Objects) do
        Object:Update()
    end

    -- China Hat
    local China_Hat_Settings = ESP.Settings.China_Hat
    if ESP.Settings.China_Hat.Enabled then
        local China_Hat = ESP.China_Hat
        for i = 1, #ESP.China_Hat do
            local Line, Triangle = China_Hat[i][1], China_Hat[i][2];
            if LocalPlayer.Character ~= nil and LocalPlayer.Character:FindFirstChild('Head') and 100 > 0 then
                local Position = LocalPlayer.Character.Head.Position + Vector3.new(0, China_Hat_Settings.Offset, 0);
                local Last, Next = (i / 30) * math.pi*2, ((i + 1) / 30) * math.pi*2;
                local lastScreen, onScreenLast = Camera:WorldToViewportPoint(Position + (Vector3.new(math.cos(Last), 0, math.sin(Last)) * China_Hat_Settings.Radius));
                local nextScreen, onScreenNext = Camera:WorldToViewportPoint(Position + (Vector3.new(math.cos(Next), 0, math.sin(Next)) * China_Hat_Settings.Radius));
                local topScreen, onScreenTop = Camera:WorldToViewportPoint(Position + Vector3.new(0, China_Hat_Settings.Height, 0));
                if not onScreenLast or not onScreenNext or not onScreenTop then
                    Line.Transparency = 0
                    Triangle.Transparency = 0
                    continue
                end
                Line.From = Vector2.new(lastScreen.X, lastScreen.Y);
                Line.To = Vector2.new(nextScreen.X, nextScreen.Y);
                Line.Color = China_Hat_Settings.Color
                Line.Transparency = Framework:Drawing_Transparency(China_Hat_Settings.Transparency)
                Triangle.PointA = Vector2.new(topScreen.X, topScreen.Y);
                Triangle.PointB = Line.From;
                Triangle.PointC = Line.To;
                Triangle.Color = China_Hat_Settings.Color
                Triangle.Transparency = Framework:Drawing_Transparency(China_Hat_Settings.Transparency)
            end
        end
    end
end)

return ESP, Connection, Framework

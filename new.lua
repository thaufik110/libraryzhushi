-- UILibrary V2.4 Lite Edition
local UILib = {}
UILib.__index = UILib
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Themes = {
    Dark = {
        Background=Color3.fromRGB(15,15,20), Surface=Color3.fromRGB(25,25,32),
        Accent=Color3.fromRGB(88,101,242), Text=Color3.fromRGB(240,240,240),
        Muted=Color3.fromRGB(150,150,160), Border=Color3.fromRGB(45,45,55)
    }
}

local function tw(obj, time, props)
    TweenService:Create(obj, TweenInfo.new(time or 0.2, Enum.EasingStyle.Quart), props):Play()
end

function UILib.new(config)
    local self = setmetatable({}, UILib)
    local T = Themes.Dark
    
    -- Main Gui
    self.ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    self.ScreenGui.Name = "UILib_Lite"
    
    self.Main = Instance.new("Frame", self.ScreenGui)
    self.Main.Size = UDim2.new(0, 500, 0, 350)
    self.Main.Position = UDim2.new(0.5, -250, 0.5, -175)
    self.Main.BackgroundColor3 = T.Background
    self.Main.BorderSizePixel = 0
    Instance.new("UICorner", self.Main).CornerRadius = UDim.new(0, 8)

    -- Sidebar
    self.Sidebar = Instance.new("Frame", self.Main)
    self.Sidebar.Size = UDim2.new(0, 130, 1, -40)
    self.Sidebar.Position = UDim2.new(0, 5, 0, 35)
    self.Sidebar.BackgroundTransparency = 1
    
    local layout = Instance.new("UIListLayout", self.Sidebar)
    layout.Padding = UDim.new(0, 5)

    -- Container
    self.Container = Instance.new("Frame", self.Main)
    self.Container.Size = UDim2.new(1, -145, 1, -45)
    self.Container.Position = UDim2.new(0, 140, 0, 40)
    self.Container.BackgroundColor3 = T.Surface
    Instance.new("UICorner", self.Container)

    self.Tabs = {}
    self.ActiveTab = nil
    
    return self
end

function UILib:AddTab(name)
    local T = Themes.Dark
    local btn = Instance.new("TextButton", self.Sidebar)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = T.Surface
    btn.Text = name
    btn.TextColor3 = T.Muted
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    Instance.new("UICorner", btn)

    local page = Instance.new("ScrollingFrame", self.Container)
    page.Size = UDim2.new(1, -10, 1, -10)
    page.Position = UDim2.new(0, 5, 0, 5)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.ScrollBarThickness = 2
    Instance.new("UIListLayout", page).Padding = UDim.new(0, 5)

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(self.Tabs) do
            t.Page.Visible = false
            t.Btn.TextColor3 = T.Muted
        end
        page.Visible = true
        btn.TextColor3 = T.Accent
    end)

    local tab = {Btn = btn, Page = page}
    self.Tabs[name] = tab
    if not self.ActiveTab then 
        page.Visible = true 
        btn.TextColor3 = T.Accent
        self.ActiveTab = name 
    end
    
    function tab:AddButton(text, callback)
        local b = Instance.new("TextButton", page)
        b.Size = UDim2.new(1, 0, 0, 32)
        b.BackgroundColor3 = T.Background
        b.Text = text
        b.TextColor3 = T.Text
        b.Font = Enum.Font.GothamSemibold
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(callback)
    end

    function tab:AddToggle(text, default, callback)
        local state = default
        local b = Instance.new("TextButton", page)
        b.Size = UDim2.new(1, 0, 0, 32)
        b.BackgroundColor3 = T.Background
        b.Text = text .. (state and " [ON]" or " [OFF]")
        b.TextColor3 = state and T.Accent or T.Text
        Instance.new("UICorner", b)
        
        b.MouseButton1Click:Connect(function()
            state = not state
            b.Text = text .. (state and " [ON]" or " [OFF]")
            tw(b, 0.2, {TextColor3 = state and T.Accent or T.Text})
            callback(state)
        end)
    end

    return tab
end

return UILib

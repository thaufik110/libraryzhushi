-- UILibrary V2.4 - Lite Edition (Optimized Performance)
local UILib = {}
UILib.__index = UILib

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

-- Tema Sederhana (Tanpa Gradien Rumit)
local Themes = {
    Dark = {
        Background=Color3.fromRGB(18,18,24), Surface=Color3.fromRGB(24,24,32),
        Element=Color3.fromRGB(30,30,40), ElementHover=Color3.fromRGB(38,38,50),
        Accent=Color3.fromRGB(88,101,242), AccentDark=Color3.fromRGB(65,78,200),
        Text=Color3.fromRGB(240,240,245), TextMuted=Color3.fromRGB(160,160,180),
        Border=Color3.fromRGB(50,50,60), Divider=Color3.fromRGB(40,40,50),
    }
}

-- Utilitas Sederhana
local function tw(obj, time, props)
    TweenService:Create(obj, TweenInfo.new(time or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
end

function UILib.new(config)
    local self = setmetatable({}, UILib)
    config = config or {}
    self.Theme = Themes[config.Theme or "Dark"] or Themes.Dark
    self.Size = config.Size or UDim2.new(0, 500, 0, 350)
    self.Tabs, self.TabButtons, self.TabPages = {}, {}, {}
    self.ActiveTab = nil
    local T = self.Theme

    -- Cleanup Old UI
    local old = game.CoreGui:FindFirstChild("UILib_Lite")
    if old then old:Destroy() end

    -- Main ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "UILib_Lite"
    self.ScreenGui.Parent = game.CoreGui
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.DisplayOrder = 100

    -- Main Frame
    self.Main = Instance.new("Frame", self.ScreenGui)
    self.Main.Name = "Main"
    self.Main.AnchorPoint = Vector2.new(0.5, 0.5)
    self.Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    self.Main.Size = UDim2.new(0, 0, 0, 0) -- Start small for animation
    self.Main.BackgroundColor3 = T.Background
    self.Main.BorderSizePixel = 0
    self.Main.ClipsDescendants = true
    Instance.new("UICorner", self.Main).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", self.Main).Color = T.Border

    -- Header
    local Header = Instance.new("Frame", self.Main)
    Header.Size = UDim2.new(1, 0, 0, 45)
    Header.BackgroundTransparency = 1
    Header.Name = "Header"

    local AccentLine = Instance.new("Frame", Header)
    AccentLine.Size = UDim2.new(1, 0, 0, 3)
    AccentLine.BackgroundColor3 = T.Accent
    AccentLine.BorderSizePixel = 0

    local TitleLabel = Instance.new("TextLabel", Header)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.Size = UDim2.new(1, -100, 1, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = config.Title or "Lite Hub"
    TitleLabel.TextColor3 = T.Text
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Close Button
    local CloseBtn = Instance.new("TextButton", Header)
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0.5, -15)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = T.TextMuted
    CloseBtn.TextSize = 14
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.MouseButton1Click:Connect(function()
        self:Destroy()
    end)
    
    -- Drag Logic
    local dragging, dragInput, dragStart, startPos
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = self.Main.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            self.Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Sidebar
    self.Sidebar = Instance.new("Frame", self.Main)
    self.Sidebar.Name = "Sidebar"
    self.Sidebar.Size = UDim2.new(0, 130, 1, -45)
    self.Sidebar.Position = UDim2.new(0, 0, 0, 45)
    self.Sidebar.BackgroundColor3 = T.Surface
    self.Sidebar.BorderSizePixel = 0
    
    self.SidebarLayout = Instance.new("UIListLayout", self.Sidebar)
    self.SidebarLayout.Padding = UDim.new(0, 5)
    self.SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local Pad = Instance.new("UIPadding", self.Sidebar)
    Pad.PaddingTop, Pad.PaddingLeft, Pad.PaddingRight = UDim.new(0, 8), UDim.new(0, 5), UDim.new(0, 5)

    -- Content
    self.Content = Instance.new("Frame", self.Main)
    self.Content.Name = "Content"
    self.Content.Size = UDim2.new(1, -130, 1, -45)
    self.Content.Position = UDim2.new(0, 130, 0, 45)
    self.Content.BackgroundColor3 = T.Background
    self.Content.BorderSizePixel = 0

    -- Animate Open
    self.Main.Size = UDim2.new(0, 0, 0, 0)
    tw(self.Main, 0.3, {Size = self.Size})

    return self
end

function UILib:Destroy()
    tw(self.Main, 0.2, {Size = UDim2.new(0, 0, 0, 0)})
    task.wait(0.2)
    if self.ScreenGui then self.ScreenGui:Destroy() end
end

-- ==========================================
-- TAB SYSTEM
-- ==========================================
function UILib:AddTab(config)
    local T = self.Theme
    local name = config.Name or "Tab"
    
    -- Tab Button
    local btn = Instance.new("TextButton", self.Sidebar)
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = T.Surface
    btn.BorderSizePixel = 0
    btn.TextColor3 = T.TextMuted
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 12
    btn.Text = "  " .. name
    btn.TextXAlignment = Enum.TextXAlignment.Left
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    -- Page
    local page = Instance.new("ScrollingFrame", self.Content)
    page.Name = name
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = T.Accent
    page.Visible = false
    page.BorderSizePixel = 0
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    local pl = Instance.new("UIListLayout", page)
    pl.Padding = UDim.new(0, 6)
    pl.SortOrder = Enum.SortOrder.LayoutOrder
    local pp = Instance.new("UIPadding", page)
    pp.PaddingTop, pp.PaddingLeft, pp.PaddingRight = UDim.new(0, 8), UDim.new(0, 8), UDim.new(0, 8)
    
    -- Connection
    btn.MouseButton1Click:Connect(function()
        if self.ActiveTab == name then return end
        self.ActiveTab = name
        
        -- Reset all buttons
        for _, b in pairs(self.Sidebar:GetChildren()) do
            if b:IsA("TextButton") then
                tw(b, 0.1, {BackgroundColor3 = T.Surface, TextColor3 = T.TextMuted})
            end
        end
        -- Highlight active
        tw(btn, 0.1, {BackgroundColor3 = T.Accent, TextColor3 = Color3.new(1,1,1)})
        
        -- Switch page
        for _, p in pairs(self.Content:GetChildren()) do
            if p:IsA("ScrollingFrame") then p.Visible = false end
        end
        page.Visible = true
    end)

    -- Auto select first
    if not self.ActiveTab then
        btn.MouseButton1Click:Fire() -- Simulate click to activate
    end

    local TabMethods = {}
    function TabMethods:AddSection(secName)
        local sec = Instance.new("Frame", page)
        sec.Size = UDim2.new(1, 0, 0, 25)
        sec.BackgroundTransparency = 1
        local lbl = Instance.new("TextLabel", sec)
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = secName
        lbl.TextColor3 = T.Accent
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 13
        lbl.TextXAlignment = Enum.TextXAlignment.Left
    end

    function TabMethods:AddButton(text, callback)
        local btn = Instance.new("TextButton", page)
        btn.Size = UDim2.new(1, 0, 0, 32)
        btn.BackgroundColor3 = T.Element
        btn.TextColor3 = T.Text
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.Text = "  " .. text
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.BorderSizePixel = 0
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        
        btn.MouseEnter:Connect(function() tw(btn, 0.1, {BackgroundColor3 = T.ElementHover}) end)
        btn.MouseLeave:Connect(function() tw(btn, 0.1, {BackgroundColor3 = T.Element}) end)
        btn.MouseButton1Click:Connect(callback)
    end

    function TabMethods:AddToggle(text, default, callback)
        local state = default or false
        local bg = Instance.new("Frame", page)
        bg.Size = UDim2.new(1, 0, 0, 32)
        bg.BackgroundColor3 = T.Element
        bg.BorderSizePixel = 0
        Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 6)
        
        local lbl = Instance.new("TextLabel", bg)
        lbl.Position = UDim2.new(0, 10, 0, 0)
        lbl.Size = UDim2.new(1, -50, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = text
        lbl.TextColor3 = T.Text
        lbl.Font = Enum.Font.Gotham
        lbl.TextSize = 12
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        
        local indicator = Instance.new("Frame", bg)
        indicator.Size = UDim2.new(0, 16, 0, 16)
        indicator.Position = UDim2.new(1, -23, 0.5, -8)
        indicator.BackgroundColor3 = state and T.Accent or T.Border
        indicator.BorderSizePixel = 0
        Instance.new("UICorner", indicator).CornerRadius = UDim.new(0, 4)
        
        local click = Instance.new("TextButton", bg)
        click.Size = UDim2.new(1, 0, 1, 0)
        click.BackgroundTransparency = 1
        click.Text = ""
        
        click.MouseButton1Click:Connect(function()
            state = not state
            tw(indicator, 0.1, {BackgroundColor3 = state and T.Accent or T.Border})
            if callback then callback(state) end
        end)
    end

    function TabMethods:AddDropdown(text, options, callback)
        local isOpen = false
        local container = Instance.new("Frame", page)
        container.Size = UDim2.new(1, 0, 0, 32)
        container.BackgroundColor3 = T.Element
        container.ClipsDescendants = true
        container.BorderSizePixel = 0
        Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)
        
        local btn = Instance.new("TextButton", container)
        btn.Size = UDim2.new(1, 0, 0, 32)
        btn.BackgroundTransparency = 1
        btn.Text = "  " .. text
        btn.TextColor3 = T.Text
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.TextXAlignment = Enum.TextXAlignment.Left
        
        local arrow = Instance.new("TextLabel", container)
        arrow.Size = UDim2.new(0, 20, 0, 32)
        arrow.Position = UDim2.new(1, -25, 0, 0)
        arrow.BackgroundTransparency = 1
        arrow.Text = "▼"
        arrow.TextColor3 = T.TextMuted
        arrow.TextSize = 10
        
        local list = Instance.new("Frame", container)
        list.Position = UDim2.new(0, 0, 0, 34)
        list.Size = UDim2.new(1, 0, 0, #options * 28)
        list.BackgroundTransparency = 1
        local layout = Instance.new("UIListLayout", list)
        
        for _, opt in ipairs(options) do
            local optBtn = Instance.new("TextButton", list)
            optBtn.Size = UDim2.new(1, 0, 0, 28)
            optBtn.BackgroundColor3 = T.Surface
            optBtn.TextColor3 = T.TextMuted
            optBtn.Font = Enum.Font.Gotham
            optBtn.TextSize = 11
            optBtn.Text = "   " .. opt
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtn.BorderSizePixel = 0
            
            optBtn.MouseButton1Click:Connect(function()
                btn.Text = "  " .. text .. ": " .. opt
                tw(container, 0.15, {Size = UDim2.new(1, 0, 0, 32)})
                isOpen = false
                if callback then callback(opt) end
            end)
        end
        
        btn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                tw(container, 0.15, {Size = UDim2.new(1, 0, 0, 34 + (#options * 28))})
            else
                tw(container, 0.15, {Size = UDim2.new(1, 0, 0, 32)})
            end
        end)
    end

    return TabMethods
end

return UILib

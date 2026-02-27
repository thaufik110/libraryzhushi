-- =====================================================================
-- 🛠️ MYCUSTOM UI LIBRARY (MULTI-THEME EDITION)
-- =====================================================================
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local FarmingLibrary = {}

-- ==========================================
-- 🎨 KOLEKSI TEMA (KAVO + TEMA MODERN BARU)
-- ==========================================
local themeStyles = {
    -- TEMA BAWAAN KAVO
    DarkTheme = {SchemeColor = Color3.fromRGB(64, 64, 64), Background = Color3.fromRGB(0, 0, 0), Header = Color3.fromRGB(0, 0, 0), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20)},
    LightTheme = {SchemeColor = Color3.fromRGB(150, 150, 150), Background = Color3.fromRGB(255,255,255), Header = Color3.fromRGB(200, 200, 200), TextColor = Color3.fromRGB(0,0,0), ElementColor = Color3.fromRGB(224, 224, 224)},
    BloodTheme = {SchemeColor = Color3.fromRGB(227, 27, 27), Background = Color3.fromRGB(10, 10, 10), Header = Color3.fromRGB(5, 5, 5), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20)},
    GrapeTheme = {SchemeColor = Color3.fromRGB(166, 71, 214), Background = Color3.fromRGB(64, 50, 71), Header = Color3.fromRGB(36, 28, 41), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(74, 58, 84)},
    Ocean = {SchemeColor = Color3.fromRGB(86, 76, 251), Background = Color3.fromRGB(26, 32, 58), Header = Color3.fromRGB(38, 45, 71), TextColor = Color3.fromRGB(200, 200, 200), ElementColor = Color3.fromRGB(38, 45, 71)},
    Midnight = {SchemeColor = Color3.fromRGB(26, 189, 158), Background = Color3.fromRGB(44, 62, 82), Header = Color3.fromRGB(57, 81, 105), TextColor = Color3.fromRGB(255, 255, 255), ElementColor = Color3.fromRGB(52, 74, 95)},
    Sentinel = {SchemeColor = Color3.fromRGB(230, 35, 69), Background = Color3.fromRGB(32, 32, 32), Header = Color3.fromRGB(24, 24, 24), TextColor = Color3.fromRGB(119, 209, 138), ElementColor = Color3.fromRGB(24, 24, 24)},
    Synapse = {SchemeColor = Color3.fromRGB(46, 48, 43), Background = Color3.fromRGB(13, 15, 12), Header = Color3.fromRGB(36, 38, 35), TextColor = Color3.fromRGB(152, 99, 53), ElementColor = Color3.fromRGB(24, 24, 24)},
    Serpent = {SchemeColor = Color3.fromRGB(0, 166, 58), Background = Color3.fromRGB(31, 41, 43), Header = Color3.fromRGB(22, 29, 31), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(22, 29, 31)},
    
    -- TEMA TAMBAHAN (UI MODERN)
    EugeneWu = {SchemeColor = Color3.fromRGB(255, 180, 50), Background = Color3.fromRGB(24, 24, 34), Header = Color3.fromRGB(30, 30, 42), TextColor = Color3.fromRGB(255, 255, 255), ElementColor = Color3.fromRGB(35, 35, 48)},
    Dracula = {SchemeColor = Color3.fromRGB(255, 121, 198), Background = Color3.fromRGB(40, 42, 54), Header = Color3.fromRGB(68, 71, 90), TextColor = Color3.fromRGB(248, 248, 242), ElementColor = Color3.fromRGB(50, 52, 64)},
    TokyoNight = {SchemeColor = Color3.fromRGB(122, 162, 247), Background = Color3.fromRGB(26, 27, 38), Header = Color3.fromRGB(36, 40, 59), TextColor = Color3.fromRGB(192, 202, 245), ElementColor = Color3.fromRGB(41, 46, 66)},
    Discord = {SchemeColor = Color3.fromRGB(88, 101, 242), Background = Color3.fromRGB(54, 57, 63), Header = Color3.fromRGB(47, 49, 54), TextColor = Color3.fromRGB(220, 221, 222), ElementColor = Color3.fromRGB(64, 68, 75)}
}

local function Tween(instance, properties, duration)
    local tween = TweenService:Create(instance, TweenInfo.new(duration or 0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

-- ==========================================
-- 🖥️ FUNGSI MEMBUAT WINDOW UTAMA
-- ==========================================
function FarmingLibrary:CreateWindow(titleText, selectedTheme)
    local UIHidden = false

    -- Set Tema: Cek apakah tema yang diminta ada, kalau tidak pakai EugeneWu
    local th = themeStyles[selectedTheme] or themeStyles["EugeneWu"]

    -- Memetakan warna Kavo agar pas dengan animasi UI kita
    local Theme = {
        MainBG = th.Background,
        SidebarBG = th.Header,
        ElementBG = th.ElementColor,
        HoverBG = Color3.fromRGB(math.clamp(th.ElementColor.R*255 + 15, 0, 255), math.clamp(th.ElementColor.G*255 + 15, 0, 255), math.clamp(th.ElementColor.B*255 + 15, 0, 255)),
        Accent = th.SchemeColor,
        Text = th.TextColor,
        TextDark = Color3.fromRGB(math.clamp(th.TextColor.R*255 - 60, 0, 255), math.clamp(th.TextColor.G*255 - 60, 0, 255), math.clamp(th.TextColor.B*255 - 60, 0, 255))
    }

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "CustomHubGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    -- ==========================================
    -- 🟢 TOMBOL BULAT (BISA DIGESER / DRAGGABLE)
    -- ==========================================
    local ToggleButton = Instance.new("ImageButton")
    ToggleButton.Size = UDim2.new(0, 45, 0, 45)
    ToggleButton.Position = UDim2.new(0, 15, 0.5, -22) 
    ToggleButton.BackgroundColor3 = Theme.SidebarBG
    ToggleButton.AutoButtonColor = false
    ToggleButton.Parent = ScreenGui

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleButton

    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Theme.Accent
    ToggleStroke.Thickness = 2
    ToggleStroke.Parent = ToggleButton

    local ToggleIcon = Instance.new("ImageLabel")
    ToggleIcon.Size = UDim2.new(0, 25, 0, 25)
    ToggleIcon.Position = UDim2.new(0.5, -12.5, 0.5, -12.5)
    ToggleIcon.BackgroundTransparency = 1
    ToggleIcon.Image = "rbxassetid://6031265976" 
    ToggleIcon.ImageColor3 = Theme.Accent
    ToggleIcon.Parent = ToggleButton

    ToggleButton.MouseEnter:Connect(function() Tween(ToggleButton, {BackgroundColor3 = Theme.HoverBG}) end)
    ToggleButton.MouseLeave:Connect(function() Tween(ToggleButton, {BackgroundColor3 = Theme.SidebarBG}) end)

    local dragToggle, dragInputToggle, dragStartToggle, startPosToggle
    local isDraggingToggle = false 

    ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            isDraggingToggle = false
            dragStartToggle = input.Position
            startPosToggle = ToggleButton.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragToggle = false end
            end)
        end
    end)
    ToggleButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInputToggle = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInputToggle and dragToggle then
            local delta = input.Position - dragStartToggle
            if delta.Magnitude > 5 then
                isDraggingToggle = true 
            end
            ToggleButton.Position = UDim2.new(startPosToggle.X.Scale, startPosToggle.X.Offset + delta.X, startPosToggle.Y.Scale, startPosToggle.Y.Offset + delta.Y)
        end
    end)

    -- ==========================================
    -- 🪟 KANVAS UI UTAMA
    -- ==========================================
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 550, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -275, 0.5, -190)
    MainFrame.BackgroundColor3 = Theme.MainBG
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame

    ToggleButton.MouseButton1Click:Connect(function()
        if isDraggingToggle then return end 
        
        UIHidden = not UIHidden
        if UIHidden then
            Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(ToggleButton.Position.X.Scale, ToggleButton.Position.X.Offset, ToggleButton.Position.Y.Scale, ToggleButton.Position.Y.Offset)}, 0.3)
            wait(0.3)
            MainFrame.Visible = false
        else
            MainFrame.Visible = true
            Tween(MainFrame, {Size = UDim2.new(0, 550, 0, 380), Position = UDim2.new(0.5, -275, 0.5, -190)}, 0.3)
        end
    end)

    local Topbar = Instance.new("Frame")
    Topbar.Size = UDim2.new(1, 0, 0, 40)
    Topbar.BackgroundColor3 = Theme.SidebarBG
    Topbar.BorderSizePixel = 0
    Topbar.Parent = MainFrame

    local TopbarLine = Instance.new("Frame")
    TopbarLine.Size = UDim2.new(1, 0, 0, 1)
    TopbarLine.Position = UDim2.new(0, 0, 1, 0)
    TopbarLine.BackgroundColor3 = Theme.ElementBG
    TopbarLine.BorderSizePixel = 0
    TopbarLine.Parent = Topbar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 1, 0)
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = titleText
    Title.TextColor3 = Theme.Text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Topbar

    local dragging, dragInput, dragStart, startPos
    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    Topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local Sidebar = Instance.new("Frame")
    Sidebar.Size = UDim2.new(0, 140, 1, -41)
    Sidebar.Position = UDim2.new(0, 0, 0, 41)
    Sidebar.BackgroundColor3 = Theme.SidebarBG
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame

    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.Padding = UDim.new(0, 5)
    SidebarLayout.Parent = Sidebar

    local SidebarPadding = Instance.new("UIPadding")
    SidebarPadding.PaddingTop = UDim.new(0, 10)
    SidebarPadding.PaddingLeft = UDim.new(0, 10)
    SidebarPadding.PaddingRight = UDim.new(0, 10)
    SidebarPadding.Parent = Sidebar

    local PageContainer = Instance.new("Frame")
    PageContainer.Size = UDim2.new(1, -140, 1, -41)
    PageContainer.Position = UDim2.new(0, 140, 0, 41)
    PageContainer.BackgroundTransparency = 1
    PageContainer.Parent = MainFrame

    local WindowAPI = {}
    local FirstTab = true

    function WindowAPI:CreateTab(tabName, iconId)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(1, 0, 0, 36)
        TabBtn.BackgroundColor3 = Theme.SidebarBG
        TabBtn.Text = "" 
        TabBtn.AutoButtonColor = false
        TabBtn.Parent = Sidebar

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabBtn

        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Size = UDim2.new(0, 18, 0, 18)
        TabIcon.Position = UDim2.new(0, 10, 0.5, -9)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Image = iconId or "rbxassetid://6031265976" 
        TabIcon.ImageColor3 = Theme.TextDark
        TabIcon.Parent = TabBtn

        local TabText = Instance.new("TextLabel")
        TabText.Size = UDim2.new(1, -35, 1, 0)
        TabText.Position = UDim2.new(0, 35, 0, 0)
        TabText.BackgroundTransparency = 1
        TabText.Text = tabName
        TabText.TextColor3 = Theme.TextDark
        TabText.Font = Enum.Font.GothamSemibold
        TabText.TextSize = 13
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.Parent = TabBtn

        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.ScrollBarThickness = 3
        TabPage.ScrollBarImageColor3 = Theme.ElementBG
        TabPage.BorderSizePixel = 0
        TabPage.Visible = FirstTab
        TabPage.Parent = PageContainer

        local PageLayout = Instance.new("UIListLayout")
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 8)
        PageLayout.Parent = TabPage

        local PagePadding = Instance.new("UIPadding")
        PagePadding.PaddingTop = UDim.new(0, 15)
        PagePadding.PaddingLeft = UDim.new(0, 15)
        PagePadding.PaddingRight = UDim.new(0, 15)
        PagePadding.PaddingBottom = UDim.new(0, 15)
        PagePadding.Parent = TabPage

        if FirstTab then
            FirstTab = false
            TabBtn.BackgroundColor3 = Theme.Accent
            TabText.TextColor3 = Theme.MainBG
            TabIcon.ImageColor3 = Theme.MainBG
        end

        TabBtn.MouseButton1Click:Connect(function()
            for _, child in pairs(PageContainer:GetChildren()) do
                if child:IsA("ScrollingFrame") then child.Visible = false end
            end
            for _, child in pairs(Sidebar:GetChildren()) do
                if child:IsA("TextButton") then
                    Tween(child, {BackgroundColor3 = Theme.SidebarBG})
                    child:FindFirstChild("TextLabel").TextColor3 = Theme.TextDark
                    child:FindFirstChild("ImageLabel").ImageColor3 = Theme.TextDark
                end
            end
            TabPage.Visible = true
            Tween(TabBtn, {BackgroundColor3 = Theme.Accent})
            TabText.TextColor3 = Theme.MainBG
            TabIcon.ImageColor3 = Theme.MainBG
        end)

        local TabAPI = {}

        function TabAPI:CreateSection(secName)
            local SecLabel = Instance.new("TextLabel")
            SecLabel.Size = UDim2.new(1, 0, 0, 20)
            SecLabel.BackgroundTransparency = 1
            SecLabel.Text = "✨ " .. secName
            SecLabel.TextColor3 = Theme.Accent
            SecLabel.Font = Enum.Font.GothamBold
            SecLabel.TextSize = 13
            SecLabel.TextXAlignment = Enum.TextXAlignment.Left
            SecLabel.Parent = TabPage
        end

        function TabAPI:CreateButton(btnName, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 40)
            Btn.BackgroundColor3 = Theme.ElementBG
            Btn.Text = "   " .. btnName
            Btn.TextColor3 = Theme.Text
            Btn.Font = Enum.Font.Gotham
            Btn.TextSize = 14
            Btn.TextXAlignment = Enum.TextXAlignment.Left
            Btn.AutoButtonColor = false
            Btn.Parent = TabPage

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 6)
            BtnCorner.Parent = Btn

            Btn.MouseEnter:Connect(function() Tween(Btn, {BackgroundColor3 = Theme.HoverBG}) end)
            Btn.MouseLeave:Connect(function() Tween(Btn, {BackgroundColor3 = Theme.ElementBG}) end)
            Btn.MouseButton1Click:Connect(function() pcall(callback) end)
        end

        function TabAPI:CreateToggle(tglName, default, callback)
            local state = default or false

            local Tgl = Instance.new("TextButton")
            Tgl.Size = UDim2.new(1, 0, 0, 40)
            Tgl.BackgroundColor3 = Theme.ElementBG
            Tgl.Text = "   " .. tglName
            Tgl.TextColor3 = Theme.Text
            Tgl.Font = Enum.Font.Gotham
            Tgl.TextSize = 14
            Tgl.TextXAlignment = Enum.TextXAlignment.Left
            Tgl.AutoButtonColor = false
            Tgl.Parent = TabPage

            local TglCorner = Instance.new("UICorner")
            TglCorner.CornerRadius = UDim.new(0, 6)
            TglCorner.Parent = Tgl

            local SwitchBG = Instance.new("Frame")
            SwitchBG.Size = UDim2.new(0, 36, 0, 18)
            SwitchBG.Position = UDim2.new(1, -46, 0.5, -9)
            SwitchBG.BackgroundColor3 = state and Theme.Accent or Color3.fromRGB(60, 60, 75)
            SwitchBG.Parent = Tgl

            local SwitchBGCorner = Instance.new("UICorner")
            SwitchBGCorner.CornerRadius = UDim.new(1, 0)
            SwitchBGCorner.Parent = SwitchBG

            local SwitchCircle = Instance.new("Frame")
            SwitchCircle.Size = UDim2.new(0, 14, 0, 14)
            SwitchCircle.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
            SwitchCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SwitchCircle.Parent = SwitchBG

            local CircleCorner = Instance.new("UICorner")
            CircleCorner.CornerRadius = UDim.new(1, 0)
            CircleCorner.Parent = SwitchCircle

            Tgl.MouseEnter:Connect(function() Tween(Tgl, {BackgroundColor3 = Theme.HoverBG}) end)
            Tgl.MouseLeave:Connect(function() Tween(Tgl, {BackgroundColor3 = Theme.ElementBG}) end)

            Tgl.MouseButton1Click:Connect(function()
                state = not state
                if state then
                    Tween(SwitchBG, {BackgroundColor3 = Theme.Accent})
                    Tween(SwitchCircle, {Position = UDim2.new(1, -16, 0.5, -7)})
                else
                    Tween(SwitchBG, {BackgroundColor3 = Color3.fromRGB(60, 60, 75)})
                    Tween(SwitchCircle, {Position = UDim2.new(0, 2, 0.5, -7)})
                end
                pcall(callback, state)
            end)
        end

        return TabAPI
    end

    return WindowAPI
end

return FarmingLibrary

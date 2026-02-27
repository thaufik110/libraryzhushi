-- =====================================================================
-- 🛠️ MYCUSTOM UI LIBRARY (ULTIMATE MULTI-THEME EDITION)
-- =====================================================================
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local FarmingLibrary = {}

-- ==========================================
-- 🎨 KOLEKSI TEMA (KAVO + TEMA MODERN BARU)
-- ==========================================
local themeStyles = {
    DarkTheme = {SchemeColor = Color3.fromRGB(64, 64, 64), Background = Color3.fromRGB(0, 0, 0), Header = Color3.fromRGB(0, 0, 0), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20)},
    LightTheme = {SchemeColor = Color3.fromRGB(150, 150, 150), Background = Color3.fromRGB(255,255,255), Header = Color3.fromRGB(200, 200, 200), TextColor = Color3.fromRGB(0,0,0), ElementColor = Color3.fromRGB(224, 224, 224)},
    BloodTheme = {SchemeColor = Color3.fromRGB(227, 27, 27), Background = Color3.fromRGB(10, 10, 10), Header = Color3.fromRGB(5, 5, 5), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(20, 20, 20)},
    GrapeTheme = {SchemeColor = Color3.fromRGB(166, 71, 214), Background = Color3.fromRGB(64, 50, 71), Header = Color3.fromRGB(36, 28, 41), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(74, 58, 84)},
    Ocean = {SchemeColor = Color3.fromRGB(86, 76, 251), Background = Color3.fromRGB(26, 32, 58), Header = Color3.fromRGB(38, 45, 71), TextColor = Color3.fromRGB(200, 200, 200), ElementColor = Color3.fromRGB(38, 45, 71)},
    Midnight = {SchemeColor = Color3.fromRGB(26, 189, 158), Background = Color3.fromRGB(44, 62, 82), Header = Color3.fromRGB(57, 81, 105), TextColor = Color3.fromRGB(255, 255, 255), ElementColor = Color3.fromRGB(52, 74, 95)},
    Sentinel = {SchemeColor = Color3.fromRGB(230, 35, 69), Background = Color3.fromRGB(32, 32, 32), Header = Color3.fromRGB(24, 24, 24), TextColor = Color3.fromRGB(119, 209, 138), ElementColor = Color3.fromRGB(24, 24, 24)},
    Synapse = {SchemeColor = Color3.fromRGB(46, 48, 43), Background = Color3.fromRGB(13, 15, 12), Header = Color3.fromRGB(36, 38, 35), TextColor = Color3.fromRGB(152, 99, 53), ElementColor = Color3.fromRGB(24, 24, 24)},
    Serpent = {SchemeColor = Color3.fromRGB(0, 166, 58), Background = Color3.fromRGB(31, 41, 43), Header = Color3.fromRGB(22, 29, 31), TextColor = Color3.fromRGB(255,255,255), ElementColor = Color3.fromRGB(22, 29, 31)},
    
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
    local lastMainFramePos = UDim2.new(0.5, -275, 0.5, -190) -- MEMORI POSISI AWAL

    local th = themeStyles[selectedTheme] or themeStyles["EugeneWu"]

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
    -- 🟢 TOMBOL BULAT (FLOATING BUTTON)
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
    -- 🪟 KANVAS UI UTAMA (MAIN FRAME)
    -- ==========================================
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 550, 0, 380)
    MainFrame.Position = lastMainFramePos
    MainFrame.BackgroundColor3 = Theme.MainBG
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Parent = MainFrame

    -- PERBAIKAN LOGIKA BUKA/TUTUP (MEMORI POSISI)
    ToggleButton.MouseButton1Click:Connect(function()
        if isDraggingToggle then return end 
        
        UIHidden = not UIHidden
        if UIHidden then
            -- MENCATAT POSISI TERAKHIR SEBELUM MENGHILANG
            lastMainFramePos = MainFrame.Position
            Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(ToggleButton.Position.X.Scale, ToggleButton.Position.X.Offset, ToggleButton.Position.Y.Scale, ToggleButton.Position.Y.Offset)}, 0.3)
            wait(0.3)
            MainFrame.Visible = false
        else
            MainFrame.Visible = true
            -- KEMBALI KE POSISI YANG SUDAH DICATAT
            Tween(MainFrame, {Size = UDim2.new(0, 550, 0, 380), Position = lastMainFramePos}, 0.3)
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

        -- SECTION
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

        -- BUTTON
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

        -- TOGGLE
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

        -- SLIDER
        function TabAPI:CreateSlider(slName, min, max, default, callback)
            local value = math.clamp(default, min, max)

            local Sl = Instance.new("Frame")
            Sl.Size = UDim2.new(1, 0, 0, 55)
            Sl.BackgroundColor3 = Theme.ElementBG
            Sl.Parent = TabPage

            local SlCorner = Instance.new("UICorner")
            SlCorner.CornerRadius = UDim.new(0, 6)
            SlCorner.Parent = Sl

            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(1, -20, 0, 25)
            Title.Position = UDim2.new(0, 10, 0, 5)
            Title.BackgroundTransparency = 1
            Title.Text = slName
            Title.TextColor3 = Theme.Text
            Title.Font = Enum.Font.Gotham
            Title.TextSize = 14
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Parent = Sl

            local ValLabel = Instance.new("TextLabel")
            ValLabel.Size = UDim2.new(1, -20, 0, 25)
            ValLabel.Position = UDim2.new(0, 10, 0, 5)
            ValLabel.BackgroundTransparency = 1
            ValLabel.Text = tostring(value)
            ValLabel.TextColor3 = Theme.Accent
            ValLabel.Font = Enum.Font.GothamBold
            ValLabel.TextSize = 14
            ValLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValLabel.Parent = Sl

            local BarBG = Instance.new("TextButton")
            BarBG.Size = UDim2.new(1, -20, 0, 8)
            BarBG.Position = UDim2.new(0, 10, 0, 35)
            BarBG.BackgroundColor3 = Theme.MainBG
            BarBG.Text = ""
            BarBG.AutoButtonColor = false
            BarBG.Parent = Sl

            local BarCorner = Instance.new("UICorner")
            BarCorner.CornerRadius = UDim.new(1, 0)
            BarCorner.Parent = BarBG

            local BarFill = Instance.new("Frame")
            local percentage = (value - min) / (max - min)
            BarFill.Size = UDim2.new(percentage, 0, 1, 0)
            BarFill.BackgroundColor3 = Theme.Accent
            BarFill.Parent = BarBG

            local FillCorner = Instance.new("UICorner")
            FillCorner.CornerRadius = UDim.new(1, 0)
            FillCorner.Parent = BarFill

            local isDragging = false
            local function UpdateSlider(input)
                local pos = math.clamp((input.Position.X - BarBG.AbsolutePosition.X) / BarBG.AbsoluteSize.X, 0, 1)
                value = math.floor(((max - min) * pos) + min)
                ValLabel.Text = tostring(value)
                Tween(BarFill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.05)
                pcall(callback, value)
            end

            BarBG.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isDragging = true; UpdateSlider(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then isDragging = false end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then UpdateSlider(input) end
            end)
        end

        -- DROPDOWN
        function TabAPI:CreateDropdown(dropName, options, callback)
            local isOpen = false

            local DropFrame = Instance.new("Frame")
            DropFrame.Size = UDim2.new(1, 0, 0, 36)
            DropFrame.BackgroundColor3 = Theme.ElementBG
            DropFrame.ClipsDescendants = true
            DropFrame.Parent = TabPage

            local DropCorner = Instance.new("UICorner")
            DropCorner.CornerRadius = UDim.new(0, 6)
            DropCorner.Parent = DropFrame

            local DropBtn = Instance.new("TextButton")
            DropBtn.Size = UDim2.new(1, 0, 0, 36)
            DropBtn.BackgroundTransparency = 1
            DropBtn.Text = "  " .. dropName .. " : -"
            DropBtn.TextColor3 = Theme.Text
            DropBtn.Font = Enum.Font.Gotham
            DropBtn.TextSize = 14
            DropBtn.TextXAlignment = Enum.TextXAlignment.Left
            DropBtn.Parent = DropFrame

            local Arrow = Instance.new("TextLabel")
            Arrow.Size = UDim2.new(0, 30, 0, 36)
            Arrow.Position = UDim2.new(1, -30, 0, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "▼"
            Arrow.TextColor3 = Theme.TextDark
            Arrow.Font = Enum.Font.Gotham
            Arrow.TextSize = 14
            Arrow.Parent = DropBtn

            local OptionContainer = Instance.new("Frame")
            OptionContainer.Size = UDim2.new(1, 0, 1, -36)
            OptionContainer.Position = UDim2.new(0, 0, 0, 36)
            OptionContainer.BackgroundTransparency = 1
            OptionContainer.Parent = DropFrame

            local OptionLayout = Instance.new("UIListLayout")
            OptionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            OptionLayout.Parent = OptionContainer

            DropBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    Tween(DropFrame, {Size = UDim2.new(1, 0, 0, 36 + (#options * 32))})
                    Tween(Arrow, {Rotation = 180})
                else
                    Tween(DropFrame, {Size = UDim2.new(1, 0, 0, 36)})
                    Tween(Arrow, {Rotation = 0})
                end
            end)

            for _, option in ipairs(options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 32)
                OptBtn.BackgroundColor3 = Theme.HoverBG
                OptBtn.Text = "    " .. option
                OptBtn.TextColor3 = Theme.TextDark
                OptBtn.Font = Enum.Font.Gotham
                OptBtn.TextSize = 13
                OptBtn.TextXAlignment = Enum.TextXAlignment.Left
                OptBtn.AutoButtonColor = false
                OptBtn.Parent = OptionContainer

                OptBtn.MouseEnter:Connect(function() Tween(OptBtn, {TextColor3 = Theme.Accent}) end)
                OptBtn.MouseLeave:Connect(function() Tween(OptBtn, {TextColor3 = Theme.TextDark}) end)

                OptBtn.MouseButton1Click:Connect(function()
                    DropBtn.Text = "  " .. dropName .. " : " .. option
                    isOpen = false
                    Tween(DropFrame, {Size = UDim2.new(1, 0, 0, 36)})
                    Tween(Arrow, {Rotation = 0})
                    pcall(callback, option)
                end)
            end
        end

        -- TEXTBOX
        function TabAPI:CreateTextBox(boxName, placeholder, callback)
            local BoxFrame = Instance.new("Frame")
            BoxFrame.Size = UDim2.new(1, 0, 0, 40)
            BoxFrame.BackgroundColor3 = Theme.ElementBG
            BoxFrame.Parent = TabPage
            
            local BoxCorner = Instance.new("UICorner")
            BoxCorner.CornerRadius = UDim.new(0, 6)
            BoxCorner.Parent = BoxFrame
            
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0.5, 0, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = boxName
            Label.TextColor3 = Theme.Text
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = BoxFrame
            
            local Box = Instance.new("TextBox")
            Box.Size = UDim2.new(0.45, -10, 0, 26)
            Box.Position = UDim2.new(0.5, 0, 0.5, -13)
            Box.BackgroundColor3 = Theme.MainBG
            Box.TextColor3 = Theme.Text
            Box.PlaceholderText = placeholder
            Box.Font = Enum.Font.Gotham
            Box.TextSize = 13
            Box.Parent = BoxFrame
            
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Box
            
            Box.FocusLost:Connect(function(enterPressed)
                pcall(callback, Box.Text)
            end)
        end

        -- KEYBIND
        function TabAPI:CreateKeybind(keyName, defaultKey, callback)
            local key = defaultKey
            local isBinding = false

            local KeyFrame = Instance.new("Frame")
            KeyFrame.Size = UDim2.new(1, 0, 0, 36)
            KeyFrame.BackgroundColor3 = Theme.ElementBG
            KeyFrame.Parent = TabPage
            
            local KeyCorner = Instance.new("UICorner")
            KeyCorner.CornerRadius = UDim.new(0, 6)
            KeyCorner.Parent = KeyFrame

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0.5, 0, 1, 0)
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = keyName
            Label.TextColor3 = Theme.Text
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 14
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.Parent = KeyFrame

            local KeyBtn = Instance.new("TextButton")
            KeyBtn.Size = UDim2.new(0, 80, 0, 24)
            KeyBtn.Position = UDim2.new(1, -90, 0.5, -12)
            KeyBtn.BackgroundColor3 = Theme.MainBG
            KeyBtn.Text = key.Name
            KeyBtn.TextColor3 = Theme.Accent
            KeyBtn.Font = Enum.Font.GothamBold
            KeyBtn.TextSize = 13
            KeyBtn.Parent = KeyFrame

            local BtnCorner = Instance.new("UICorner")
            BtnCorner.CornerRadius = UDim.new(0, 4)
            BtnCorner.Parent = KeyBtn

            KeyBtn.MouseButton1Click:Connect(function()
                isBinding = true
                KeyBtn.Text = "..."
                KeyBtn.TextColor3 = Color3.fromRGB(255, 50, 50) 
            end)

            UserInputService.InputBegan:Connect(function(input, gpe)
                if isBinding and input.UserInputType == Enum.UserInputType.Keyboard then
                    key = input.KeyCode
                    KeyBtn.Text = key.Name
                    KeyBtn.TextColor3 = Theme.Accent
                    isBinding = false
                elseif not gpe and input.KeyCode == key and not isBinding then
                    pcall(callback)
                end
            end)
        end

        return TabAPI
    end

    return WindowAPI
end

return FarmingLibrary

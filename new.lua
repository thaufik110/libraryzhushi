-- FarmingLibrary Lite (Optimized V2.4 Style)
-- Taruh kode ini di raw link GitHub Anda

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

local FarmingLibrary = {}

-- Tema yang Dioptimalkan (Pilihan populer dari kode 2)
local themeStyles = {
    DarkTheme = {SchemeColor = Color3.fromRGB(88, 101, 242), Background = Color3.fromRGB(18, 18, 24), Header = Color3.fromRGB(24, 24, 32), TextColor = Color3.fromRGB(240, 240, 245), ElementColor = Color3.fromRGB(30, 30, 40)},
    BloodTheme = {SchemeColor = Color3.fromRGB(227, 27, 27), Background = Color3.fromRGB(15, 15, 15), Header = Color3.fromRGB(20, 20, 20), TextColor = Color3.fromRGB(255, 255, 255), ElementColor = Color3.fromRGB(25, 25, 25)},
    Ocean = {SchemeColor = Color3.fromRGB(86, 76, 251), Background = Color3.fromRGB(20, 26, 40), Header = Color3.fromRGB(28, 35, 50), TextColor = Color3.fromRGB(200, 200, 200), ElementColor = Color3.fromRGB(35, 42, 60)},
    TokyoNight = {SchemeColor = Color3.fromRGB(122, 162, 247), Background = Color3.fromRGB(20, 21, 30), Header = Color3.fromRGB(26, 28, 38), TextColor = Color3.fromRGB(192, 202, 245), ElementColor = Color3.fromRGB(30, 32, 45)}
}

local function tw(obj, props, time)
    TweenService:Create(obj, TweenInfo.new(time or 0.2, Enum.EasingStyle.Quad), props):Play()
end

function FarmingLibrary:CreateWindow(titleText, selectedTheme)
    local th = themeStyles[selectedTheme] or themeStyles["DarkTheme"]
    local UIHidden = false
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LiteHubGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = PlayerGui

    -- Toggle Button (Draggable)
    local ToggleButton = Instance.new("ImageButton")
    ToggleButton.Size = UDim2.new(0, 45, 0, 45)
    ToggleButton.Position = UDim2.new(0, 15, 0.5, -22)
    ToggleButton.BackgroundColor3 = th.Header
    ToggleButton.AutoButtonColor = false
    ToggleButton.Parent = ScreenGui
    Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)
    local st = Instance.new("UIStroke", ToggleButton) st.Color = th.SchemeColor st.Thickness = 2
    
    local Icon = Instance.new("ImageLabel", ToggleButton)
    Icon.Size, Icon.Position, Icon.BackgroundTransparency = UDim2.new(0, 22, 0, 22), UDim2.new(0.5, -11, 0.5, -11), 1
    Icon.Image = "rbxassetid://6031265976" Icon.ImageColor3 = th.SchemeColor

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
    MainFrame.BackgroundColor3 = th.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    -- Header
    local Topbar = Instance.new("Frame", MainFrame)
    Topbar.Size, Topbar.BackgroundColor3 = UDim2.new(1, 0, 0, 40), th.Header
    Instance.new("UICorner", Topbar).CornerRadius = UDim.new(0, 8)
    local FixCorner = Instance.new("Frame", Topbar) -- Fix top corners
    FixCorner.Size, FixCorner.BackgroundColor3, FixCorner.BorderSizePixel = UDim2.new(1, 0, 0, 10), th.Header, 0
    FixCorner.Position = UDim2.new(0, 0, 0, 0)

    local Title = Instance.new("TextLabel", Topbar)
    Title.Text, Title.TextColor3, Title.Font, Title.TextSize = titleText, th.TextColor, Enum.Font.GothamBold, 16
    Title.Size, Title.BackgroundTransparency, Title.Position = UDim2.new(1, -100, 1, 0), 1, UDim2.new(0, 15, 0, 0)
    Title.TextXAlignment = Enum.TextXAlignment.Left

    -- Close Button
    local CloseBtn = Instance.new("TextButton", Topbar)
    CloseBtn.Size, CloseBtn.Position = UDim2.new(0, 30, 0, 30), UDim2.new(1, -35, 0.5, -15)
    CloseBtn.BackgroundTransparency, CloseBtn.Text, CloseBtn.TextColor3 = 1, "✕", th.TextColor
    CloseBtn.Font, CloseBtn.TextSize = Enum.Font.GothamBold, 14
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

    -- Minimize Button
    local MinBtn = Instance.new("TextButton", Topbar)
    MinBtn.Size, MinBtn.Position = UDim2.new(0, 30, 0, 30), UDim2.new(1, -70, 0.5, -15)
    MinBtn.BackgroundTransparency, MinBtn.Text, MinBtn.TextColor3 = 1, "—", th.TextColor
    MinBtn.Font, MinBtn.TextSize = Enum.Font.GothamBold, 14
    
    -- Sidebar & Content
    local Sidebar = Instance.new("Frame", MainFrame)
    Sidebar.Size, Sidebar.Position = UDim2.new(0, 120, 1, -40), UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = th.Header
    local sP = Instance.new("UIPadding", Sidebar) sP.PaddingTop, sP.PaddingLeft = UDim.new(0, 5), UDim.new(0, 5)
    local sL = Instance.new("UIListLayout", Sidebar) sL.Padding = UDim.new(0, 4)

    local Content = Instance.new("Frame", MainFrame)
    Content.Size, Content.Position = UDim2.new(1, -120, 1, -40), UDim2.new(0, 120, 0, 40)
    Content.BackgroundTransparency = 1

    -- Logic Toggle Drag & Click
    local draggingToggle, dragInput, dragStart, startPos
    ToggleButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingToggle = true; dragStart = input.Position; startPos = ToggleButton.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then draggingToggle = false end end)
        end
    end)
    ToggleButton.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and draggingToggle then
            local delta = input.Position - dragStart
            ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    ToggleButton.MouseButton1Click:Connect(function()
        if draggingToggle and (ToggleButton.Position - startPos).Magnitude > 5 then return end
        UIHidden = not UIHidden
        if UIHidden then
            tw(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = ToggleButton.Position}, 0.3)
            task.wait(0.2) MainFrame.Visible = false
        else
            MainFrame.Visible = true
            tw(MainFrame, {Size = UDim2.new(0, 500, 0, 350), Position = UDim2.new(0.5, -250, 0.5, -175)}, 0.3)
        end
    end)
    MinBtn.MouseButton1Click:Connect(function()
        UIHidden = true
        tw(MainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = ToggleButton.Position}, 0.3)
        task.wait(0.2) MainFrame.Visible = false
    end)

    -- Drag Main
    local draggingMain, dragInputMain, dragStartMain, startPosMain
    Topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            if input.Position.X > MinBtn.AbsolutePosition.X then return end -- Avoid drag on buttons
            draggingMain = true; dragStartMain = input.Position; startPosMain = MainFrame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then draggingMain = false end end)
        end
    end)
    Topbar.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement then dragInputMain = input end end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInputMain and draggingMain then
            local delta = input.Position - dragStartMain
            MainFrame.Position = UDim2.new(startPosMain.X.Scale, startPosMain.X.Offset + delta.X, startPosMain.Y.Scale, startPosMain.Y.Offset + delta.Y)
        end
    end)

    local WindowAPI = {}
    local FirstTab = true

    function WindowAPI:CreateTab(tabName, iconId)
        local TabBtn = Instance.new("TextButton", Sidebar)
        TabBtn.Size, TabBtn.BackgroundColor3, TabBtn.Text = UDim2.new(1, 0, 0, 30), th.Header, ""
        TabBtn.AutoButtonColor = false
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0, 6)
        
        local Icon = Instance.new("ImageLabel", TabBtn)
        Icon.Size, Icon.Position, Icon.BackgroundTransparency = UDim2.new(0, 18, 0, 18), UDim2.new(0, 8, 0.5, -9), 1
        Icon.Image = iconId or "" Icon.ImageColor3 = th.TextColor

        local Txt = Instance.new("TextLabel", TabBtn)
        Txt.Size, Txt.Position, Txt.BackgroundTransparency = UDim2.new(1, -30, 1, 0), UDim2.new(0, 30, 0, 0), 1
        Txt.Text, Txt.TextColor3, Txt.Font, Txt.TextSize = tabName, th.TextColor, Enum.Font.GothamSemibold, 12
        Txt.TextXAlignment = Enum.TextXAlignment.Left

        local Page = Instance.new("ScrollingFrame", Content)
        Page.Size, Page.BackgroundTransparency = UDim2.new(1, 0, 1, 0), 1
        Page.ScrollBarThickness, Page.Visible, Page.BorderSizePixel = 3, FirstTab, 0
        local pL = Instance.new("UIListLayout", Page) pL.Padding = UDim.new(0, 6)
        local pP = Instance.new("UIPadding", Page) pP.PaddingTop, pP.PaddingLeft = UDim.new(0, 5), UDim.new(0, 5)

        if FirstTab then
            FirstTab = false
            TabBtn.BackgroundColor3 = th.SchemeColor
            Txt.TextColor3 = Color3.new(1,1,1)
            if Icon.Image ~= "" then Icon.ImageColor3 = Color3.new(1,1,1) end
        end

        TabBtn.MouseButton1Click:Connect(function()
            for _, v in pairs(Sidebar:GetChildren()) do
                if v:IsA("TextButton") then
                    tw(v, {BackgroundColor3 = th.Header})
                    v:FindFirstChild("TextLabel").TextColor3 = th.TextColor
                    local ic = v:FindFirstChild("ImageLabel")
                    if ic and ic.Image ~= "" then ic.ImageColor3 = th.TextColor end
                end
            end
            for _, v in pairs(Content:GetChildren()) do if v:IsA("ScrollingFrame") then v.Visible = false end end
            
            tw(TabBtn, {BackgroundColor3 = th.SchemeColor})
            Txt.TextColor3 = Color3.new(1,1,1)
            local ic = TabBtn:FindFirstChild("ImageLabel")
            if ic and ic.Image ~= "" then ic.ImageColor3 = Color3.new(1,1,1) end
            Page.Visible = true
        end)

        local TabAPI = {}

        function TabAPI:CreateSection(secName)
            local S = Instance.new("TextLabel", Page)
            S.Size, S.BackgroundTransparency = UDim2.new(1, 0, 0, 20), 1
            S.Text, S.TextColor3, S.Font, S.TextSize = "  "..secName, th.SchemeColor, Enum.Font.GothamBold, 12
            S.TextXAlignment = Enum.TextXAlignment.Left
        end

        function TabAPI:CreateButton(name, callback)
            local B = Instance.new("TextButton", Page)
            B.Size, B.BackgroundColor3, B.Text = UDim2.new(1, 0, 0, 32), th.ElementColor, "  "..name
            B.TextColor3, B.Font, B.TextSize = th.TextColor, Enum.Font.Gotham, 12
            B.TextXAlignment, B.AutoButtonColor = Enum.TextXAlignment.Left, false
            Instance.new("UICorner", B).CornerRadius = UDim.new(0, 6)
            B.MouseEnter:Connect(function() tw(B, {BackgroundColor3 = th.SchemeColor}) end)
            B.MouseLeave:Connect(function() tw(B, {BackgroundColor3 = th.ElementColor}) end)
            B.MouseButton1Click:Connect(function() pcall(callback) end)
        end

        function TabAPI:CreateToggle(name, default, callback)
            local state = default or false
            local T = Instance.new("TextButton", Page)
            T.Size, T.BackgroundColor3, T.Text = UDim2.new(1, 0, 0, 32), th.ElementColor, "  "..name
            T.TextColor3, T.Font, T.TextSize = th.TextColor, Enum.Font.Gotham, 12
            T.TextXAlignment, T.AutoButtonColor = Enum.TextXAlignment.Left, false
            Instance.new("UICorner", T).CornerRadius = UDim.new(0, 6)
            
            local Ind = Instance.new("Frame", T)
            Ind.Size, Ind.Position, Ind.BackgroundColor3 = UDim2.new(0, 14, 0, 14), UDim2.new(1, -20, 0.5, -7), state and th.SchemeColor or Color3.new(0.3,0.3,0.3)
            Instance.new("UICorner", Ind).CornerRadius = UDim.new(0, 4)

            T.MouseButton1Click:Connect(function()
                state = not state
                tw(Ind, {BackgroundColor3 = state and th.SchemeColor or Color3.new(0.3,0.3,0.3)})
                pcall(callback, state)
            end)
        end

        function TabAPI:CreateSlider(name, min, max, default, callback)
            local val = default or min
            local F = Instance.new("Frame", Page)
            F.Size, F.BackgroundColor3 = UDim2.new(1, 0, 0, 45), th.ElementColor
            Instance.new("UICorner", F).CornerRadius = UDim.new(0, 6)
            
            local L = Instance.new("TextLabel", F)
            L.Size, L.Position, L.BackgroundTransparency = UDim2.new(0.5, 0, 0, 20), UDim2.new(0, 10, 0, 0), 1
            L.Text, L.TextColor3, L.Font, L.TextSize = name, th.TextColor, Enum.Font.Gotham, 12
            L.TextXAlignment = Enum.TextXAlignment.Left
            
            local V = Instance.new("TextLabel", F)
            V.Size, V.Position, V.BackgroundTransparency = UDim2.new(0.5, -10, 0, 20), UDim2.new(0.5, 0, 0, 0), 1
            V.Text, V.TextColor3, V.Font, V.TextSize = tostring(val), th.SchemeColor, Enum.Font.GothamBold, 12
            V.TextXAlignment = Enum.TextXAlignment.Right

            local Bar = Instance.new("TextButton", F)
            Bar.Size, Bar.Position, Bar.BackgroundColor3 = UDim2.new(1, -20, 0, 6), UDim2.new(0, 10, 0, 28), Color3.new(0.2,0.2,0.2)
            Bar.Text, Bar.AutoButtonColor = "", false
            Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

            local Fill = Instance.new("Frame", Bar)
            Fill.Size, Fill.BackgroundColor3 = UDim2.new((val-min)/(max-min), 0, 1, 0), th.SchemeColor
            Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)

            local dragging = false
            Bar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
            UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
            UserInputService.InputChanged:Connect(function(i)
                if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
                    local p = math.clamp((i.Position.X-Bar.AbsolutePosition.X)/Bar.AbsoluteSize.X, 0, 1)
                    val = math.floor(min + (max-min)*p)
                    V.Text = tostring(val)
                    Fill.Size = UDim2.new(p, 0, 1, 0)
                    pcall(callback, val)
                end
            end)
        end

        function TabAPI:CreateDropdown(name, options, callback)
            local open = false
            local F = Instance.new("Frame", Page)
            F.Size, F.BackgroundColor3, F.ClipsDescendants = UDim2.new(1, 0, 0, 32), th.ElementColor, true
            Instance.new("UICorner", F).CornerRadius = UDim.new(0, 6)
            
            local B = Instance.new("TextButton", F)
            B.Size, B.BackgroundTransparency, B.Text = UDim2.new(1, 0, 1, 0), 1, "  "..name
            B.TextColor3, B.Font, B.TextSize = th.TextColor, Enum.Font.Gotham, 12
            B.TextXAlignment = Enum.TextXAlignment.Left
            
            local A = Instance.new("TextLabel", B)
            A.Size, A.Position, A.BackgroundTransparency = UDim2.new(0, 20, 1, 0), UDim2.new(1, -25, 0, 0), 1
            A.Text, A.TextColor3 = "▼", th.TextColor

            local List = Instance.new("Frame", F)
            List.Size, List.Position, List.BackgroundTransparency = UDim2.new(1, 0, 0, #options*28), UDim2.new(0, 0, 0, 34), 1
            local lL = Instance.new("UIListLayout", List)
            
            for _, opt in pairs(options) do
                local oB = Instance.new("TextButton", List)
                oB.Size, oB.BackgroundColor3, oB.Text = UDim2.new(1, 0, 0, 28), th.Header, "  "..opt
                oB.TextColor3, oB.Font, oB.TextSize = th.TextColor, Enum.Font.Gotham, 11
                oB.TextXAlignment, oB.BackgroundTransparency = Enum.TextXAlignment.Left, 0.5
                oB.MouseButton1Click:Connect(function()
                    B.Text = "  "..name..": "..opt
                    tw(F, {Size = UDim2.new(1, 0, 0, 32)})
                    open = false
                    pcall(callback, opt)
                end)
            end

            B.MouseButton1Click:Connect(function()
                open = not open
                tw(F, {Size = UDim2.new(1, 0, 0, open and (34 + #options*28) or 32)})
            end)
        end

        function TabAPI:CreateTextBox(name, placeholder, callback)
            local F = Instance.new("Frame", Page)
            F.Size, F.BackgroundColor3 = UDim2.new(1, 0, 0, 35), th.ElementColor
            Instance.new("UICorner", F).CornerRadius = UDim.new(0, 6)
            
            local L = Instance.new("TextLabel", F)
            L.Size, L.Position, L.BackgroundTransparency = UDim2.new(0.4, 0, 1, 0), UDim2.new(0, 10, 0, 0), 1
            L.Text, L.TextColor3, L.Font, L.TextSize = name, th.TextColor, Enum.Font.Gotham, 12
            L.TextXAlignment = Enum.TextXAlignment.Left
            
            local T = Instance.new("TextBox", F)
            T.Size, T.Position = UDim2.new(0.5, -10, 0, 22), UDim2.new(0.5, 0, 0.5, -11)
            T.BackgroundColor3, T.TextColor3, T.PlaceholderText = th.Header, th.TextColor, placeholder
            T.Font, T.TextSize = Enum.Font.Gotham, 11
            Instance.new("UICorner", T).CornerRadius = UDim.new(0, 4)
            
            T.FocusLost:Connect(function() pcall(callback, T.Text) end)
        end

        function TabAPI:CreateKeybind(name, default, callback)
            local key = default
            local binding = false
            
            local F = Instance.new("Frame", Page)
            F.Size, F.BackgroundColor3 = UDim2.new(1, 0, 0, 32), th.ElementColor
            Instance.new("UICorner", F).CornerRadius = UDim.new(0, 6)
            
            local L = Instance.new("TextLabel", F)
            L.Size, L.Position, L.BackgroundTransparency = UDim2.new(0.6, 0, 1, 0), UDim2.new(0, 10, 0, 0), 1
            L.Text, L.TextColor3, L.Font, L.TextSize = name, th.TextColor, Enum.Font.Gotham, 12
            L.TextXAlignment = Enum.TextXAlignment.Left
            
            local B = Instance.new("TextButton", F)
            B.Size, B.Position = UDim2.new(0, 80, 0, 22), UDim2.new(1, -90, 0.5, -11)
            B.BackgroundColor3, B.TextColor3, B.Text = th.Header, th.SchemeColor, key.Name
            B.Font, B.TextSize = Enum.Font.GothamBold, 11
            Instance.new("UICorner", B).CornerRadius = UDim.new(0, 4)
            
            B.MouseButton1Click:Connect(function()
                binding = true
                B.Text = "..."
                B.TextColor3 = Color3.new(1,0,0)
            end)
            
            UserInputService.InputBegan:Connect(function(i, gpe)
                if binding and i.UserInputType == Enum.UserInputType.Keyboard then
                    key = i.KeyCode
                    B.Text = key.Name
                    B.TextColor3 = th.SchemeColor
                    binding = false
                elseif not gpe and i.KeyCode == key and not binding then
                    pcall(callback)
                end
            end)
        end

        return TabAPI
    end

    return WindowAPI
end

return FarmingLibrary

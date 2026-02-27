-- UILibrary V2.4 - Optimized Edition (No Bloat)
local UILib = {}
UILib.__index = UILib
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Themes = {
    Dark = {
        Background=Color3.fromRGB(12,12,18),Surface=Color3.fromRGB(20,20,28),
        SurfaceAlt=Color3.fromRGB(28,28,38),Element=Color3.fromRGB(35,35,48),
        ElementHover=Color3.fromRGB(42,42,58),Accent=Color3.fromRGB(88,101,242),
        AccentDark=Color3.fromRGB(65,78,200),AccentLight=Color3.fromRGB(120,135,255),
        Success=Color3.fromRGB(67,181,129),Warning=Color3.fromRGB(250,166,26),
        Error=Color3.fromRGB(237,66,69),Info=Color3.fromRGB(32,154,243),
        TextPrimary=Color3.fromRGB(235,235,245),TextSecondary=Color3.fromRGB(160,160,180),
        TextMuted=Color3.fromRGB(100,100,120),Border=Color3.fromRGB(45,45,60),
        Divider=Color3.fromRGB(38,38,52),Ripple=Color3.fromRGB(255,255,255),
        ScrollBar=Color3.fromRGB(60,80,180),
        GradientStart=Color3.fromRGB(88,101,242),GradientMid=Color3.fromRGB(155,89,255),
        GradientEnd=Color3.fromRGB(255,100,180),
    }
}

-- UTILS (Sederhana & Cepat)
local function tw(obj, time, props)
    TweenService:Create(obj, TweenInfo.new(time or 0.15, Enum.EasingStyle.Linear), props):Play()
end

function UILib.new(config)
    local self = setmetatable({}, UILib)
    self.Title = config.Title or "Hub"
    self.Theme = Themes[config.Theme or "Dark"] or Themes.Dark
    self.Tabs = {} 
    self.TabButtons = {} 
    self.TabPages = {}
    self.ActiveTab = nil
    self._headerH = 42

    local T = self.Theme

    -- Membersihkan UI lama
    for _,n in ipairs({"UILib_Main", "UILib_Toast"}) do
        local old = game.CoreGui:FindFirstChild(n)
        if old then old:Destroy() end
    end

    self.ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    self.ScreenGui.Name = "UILib_Main"

    self.Main = Instance.new("Frame", self.ScreenGui)
    self.Main.BackgroundColor3 = T.Background
    self.Main.BorderSizePixel = 0
    self.Main.Position = UDim2.new(0.5, -280, 0.5, -190)
    self.Main.Size = UDim2.new(0, 560, 0, 380)
    self.Main.ClipsDescendants = true
    Instance.new("UICorner", self.Main).CornerRadius = UDim.new(0, 10)
    
    -- 1. Loading Screen DIHAPUS - Langsung Tampil
    self.Main.Visible = true

    -- 2. Ripple Effect DIHAPUS (Fungsi dikosongkan agar tidak error saat dipanggil)
    local function doRipple() end

    -- 3. Static Accent Bar (Tanpa Animasi Putar)
    local bar = Instance.new("Frame", self.Main)
    bar.BackgroundColor3 = T.Accent
    bar.BorderSizePixel = 0
    bar.Size = UDim2.new(1, 0, 0, 2)
    bar.ZIndex = 10

    -- Header & Title
    self.TitleBar = Instance.new("Frame", self.Main)
    self.TitleBar.BackgroundTransparency = 1
    self.TitleBar.Size = UDim2.new(1, 0, 0, self._headerH)
    self.TitleBar.Position = UDim2.new(0, 0, 0, 2)

    -- 4. Pulsating Dot DIHAPUS - Menjadi Dot Statis
    local dot = Instance.new("Frame", self.TitleBar)
    dot.BackgroundColor3 = T.Accent
    dot.Position = UDim2.new(0, 12, 0.5, -5)
    dot.Size = UDim2.new(0, 10, 0, 10)
    Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)

    local tl = Instance.new("TextLabel", self.TitleBar)
    tl.BackgroundTransparency = 1
    tl.Position = UDim2.new(0, 30, 0, 0)
    tl.Size = UDim2.new(0, 200, 1, 0)
    tl.Font = Enum.Font.GothamBold
    tl.Text = self.Title
    tl.TextColor3 = T.TextPrimary
    tl.TextSize = 14
    tl.TextXAlignment = Enum.TextXAlignment.Left

    -- Sidebar
    self.Sidebar = Instance.new("Frame", self.Main)
    self.Sidebar.BackgroundColor3 = T.Surface
    self.Sidebar.Position = UDim2.new(0, 0, 0, self._headerH + 2)
    self.Sidebar.Size = UDim2.new(0, 150, 1, -(self._headerH + 2))
    
    self.SidebarScroll = Instance.new("ScrollingFrame", self.Sidebar)
    self.SidebarScroll.Size = UDim2.new(1, 0, 1, 0)
    self.SidebarScroll.BackgroundTransparency = 1
    self.SidebarScroll.ScrollBarThickness = 0
    Instance.new("UIListLayout", self.SidebarScroll).Padding = UDim.new(0, 2)

    -- Content
    self.ContentArea = Instance.new("Frame", self.Main)
    self.ContentArea.Position = UDim2.new(0, 150, 0, self._headerH + 2)
    self.ContentArea.Size = UDim2.new(1, -150, 1, -(self._headerH + 2))
    self.ContentArea.BackgroundTransparency = 1

    return self
end

-- Tambahkan fungsi AddTab, SwitchTab, dsb seperti kode asli di sini...
-- (Pastikan membuang bagian doRipple() di setiap Button click)

function UILib:AddTab(name)
    local T = self.Theme
    local btn = Instance.new("TextButton", self.SidebarScroll)
    btn.Size = UDim2.new(1, -10, 0, 32)
    btn.BackgroundColor3 = T.Element
    btn.Text = name
    btn.TextColor3 = T.TextSecondary
    btn.Font = Enum.Font.Gotham
    Instance.new("UICorner", btn)

    local page = Instance.new("ScrollingFrame", self.ContentArea)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    Instance.new("UIListLayout", page)

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(self.TabPages) do p.Visible = false end
        page.Visible = true
    end)

    self.TabPages[name] = page
    if not self.ActiveTab then page.Visible = true self.ActiveTab = name end
    
    return page
end

return UILib

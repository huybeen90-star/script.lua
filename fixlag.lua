-- === Cấu hình ===
local KEYS_URL = "https://raw.githubusercontent.com/huybeen90-star/key.vip/main/key.txt"
local VIP_KEY = "Free-12la4gbahu"
local FIX_LAG_URL = "https://raw.githubusercontent.com/huybeen90-star/script-fix-lag-v2/main/fix%20lag.lua"
local GETKEY_LINK = "https://link-hub.net/1392783/B4399GN3DTo3"

-- === GUI ===
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeyVerifyGUI"
screenGui.Parent = PlayerGui

-- Frame chính đẹp hơn
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,350,0,220)
frame.Position = UDim2.new(0.5, -175, 0.5, -110)
frame.BackgroundColor3 = Color3.fromRGB(30,30,40)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Parent = screenGui

-- UICorner cho bo góc frame
local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0,16)
frameCorner.Parent = frame

-- TextLabel hướng dẫn
local label = Instance.new("TextLabel")
label.Size = UDim2.new(1, -20, 0, 40)
label.Position = UDim2.new(0,10,0,10)
label.Text = "🔑 Nhập key của bạn:"
label.TextColor3 = Color3.fromRGB(255,255,255)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.Parent = frame

-- TextBox nhập key
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -20, 0, 50)
textBox.Position = UDim2.new(0,10,0,60)
textBox.PlaceholderText = "Nhập key..."
textBox.TextColor3 = Color3.fromRGB(0,0,0)
textBox.BackgroundColor3 = Color3.fromRGB(240,240,240)
textBox.Font = Enum.Font.Gotham
textBox.TextScaled = true
textBox.ClearTextOnFocus = false
textBox.Parent = frame

local textBoxCorner = Instance.new("UICorner")
textBoxCorner.CornerRadius = UDim.new(0,12)
textBoxCorner.Parent = textBox

-- Nút xác nhận key
local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0.48, -10, 0, 50)
verifyBtn.Position = UDim2.new(0,10,0,130)
verifyBtn.Text = "Xác nhận"
verifyBtn.BackgroundColor3 = Color3.fromRGB(100,180,255)
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.TextScaled = true
verifyBtn.TextColor3 = Color3.fromRGB(255,255,255)
verifyBtn.Parent = frame

local verifyCorner = Instance.new("UICorner")
verifyCorner.CornerRadius = UDim.new(0,12)
verifyCorner.Parent = verifyBtn

-- Nút lấy link GetKey
local linkBtn = Instance.new("TextButton")
linkBtn.Size = UDim2.new(0.48, -10, 0, 50)
linkBtn.Position = UDim2.new(0.52, 0, 0,130)
linkBtn.Text = "Lấy link GetKey"
linkBtn.BackgroundColor3 = Color3.fromRGB(50,220,150)
linkBtn.Font = Enum.Font.GothamBold
linkBtn.TextScaled = true
linkBtn.TextColor3 = Color3.fromRGB(0,0,0)
linkBtn.Parent = frame

local linkCorner = Instance.new("UICorner")
linkCorner.CornerRadius = UDim.new(0,12)
linkCorner.Parent = linkBtn

-- === Hàm fetch key từ GitHub ===
local function getKeys()
    local success, data = pcall(function()
        return game:HttpGet(KEYS_URL)
    end)
    local keys = {}
    if success and data then
        for line in data:gmatch("[^\r\n]+") do
            if line:match("%S") then
                table.insert(keys, line)
            end
        end
    else
        warn("Không tải được key từ GitHub")
    end
    table.insert(keys, VIP_KEY) -- thêm key VIP ẩn
    return keys
end

local function checkKey(userKey)
    local keys = getKeys()
    for _, k in pairs(keys) do
        if k == userKey then
            return true
        end
    end
    return false
end

-- === Xử lý nút xác nhận ===
verifyBtn.MouseButton1Click:Connect(function()
    local userKey = textBox.Text
    if checkKey(userKey) then
        print("✅ Key hợp lệ! Chạy script fix lag...")
        local success, err = pcall(function()
            loadstring(game:HttpGet(FIX_LAG_URL, true))()
        end)
        if not success then
            warn("❌ Lỗi chạy script:", err)
        end
    else
        warn("❌ Key không hợp lệ!")
    end
end)

-- === Xử lý nút link GetKey ===
linkBtn.MouseButton1Click:Connect(function()
    if GETKEY_LINK then
        print("Link GetKey:", GETKEY_LINK)
    end
end)

-- === Cấu hình ===
local KEYS_URL = "https://raw.githubusercontent.com/huybeen90-star/key.vip/main/key.txt"
local VIP_KEY = "Free-12la4gbahu"
local FIX_LAG_URL = "https://raw.githubusercontent.com/huybeen90-star/script.lua/main/fixlag.lua"
local GETKEY_LINK = "https://link-hub.net/1392783/B4399GN3DTo3"

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeyVerifyGUI"
screenGui.Parent = PlayerGui

-- Frame chính
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,400,0,260)
frame.Position = UDim2.new(0.5, -200, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(30,30,40)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.Parent = screenGui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0,18)
frameCorner.Parent = frame

-- Label nhập key
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
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -20, 0, 50)
keyBox.Position = UDim2.new(0,10,0,60)
keyBox.PlaceholderText = ""
keyBox.Text = ""
keyBox.TextColor3 = Color3.fromRGB(0,0,0)
keyBox.BackgroundColor3 = Color3.fromRGB(240,240,240)
keyBox.Font = Enum.Font.Gotham
keyBox.TextScaled = true
keyBox.ClearTextOnFocus = false
keyBox.Parent = frame

local keyBoxCorner = Instance.new("UICorner")
keyBoxCorner.CornerRadius = UDim.new(0,14)
keyBoxCorner.Parent = keyBox

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
verifyCorner.CornerRadius = UDim.new(0,14)
verifyCorner.Parent = verifyBtn

-- TextBox hiển thị link GetKey
local linkBox = Instance.new("TextBox")
linkBox.Size = UDim2.new(1, -20, 0, 40)
linkBox.Position = UDim2.new(0,10,0,190)
linkBox.PlaceholderText = ""
linkBox.Text = ""
linkBox.TextColor3 = Color3.fromRGB(0,0,0)
linkBox.BackgroundColor3 = Color3.fromRGB(230,230,230)
linkBox.Font = Enum.Font.Gotham
linkBox.TextScaled = true
linkBox.ClearTextOnFocus = false
linkBox.Parent = frame

local linkBoxCorner = Instance.new("UICorner")
linkBoxCorner.CornerRadius = UDim.new(0,12)
linkBoxCorner.Parent = linkBox

-- Nút hiện link GetKey
local linkBtn = Instance.new("TextButton")
linkBtn.Size = UDim2.new(0.48, -10, 0, 40)
linkBtn.Position = UDim2.new(0.52, 0, 0,130)
linkBtn.Text = "Hiển thị link"
linkBtn.BackgroundColor3 = Color3.fromRGB(50,220,150)
linkBtn.Font = Enum.Font.GothamBold
linkBtn.TextScaled = true
linkBtn.TextColor3 = Color3.fromRGB(0,0,0)
linkBtn.Parent = frame

local linkCorner = Instance.new("UICorner")
linkCorner.CornerRadius = UDim.new(0,14)
linkCorner.Parent = linkBtn

-- Nút Clear linkBox
local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0.48, -10, 0, 40)
clearBtn.Position = UDim2.new(0,10,0,240)
clearBtn.Text = "Clear link"
clearBtn.BackgroundColor3 = Color3.fromRGB(255,100,100)
clearBtn.Font = Enum.Font.GothamBold
clearBtn.TextScaled = true
clearBtn.TextColor3 = Color3.fromRGB(255,255,255)
clearBtn.Parent = frame

local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0,14)
clearCorner.Parent = clearBtn

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
    table.insert(keys, VIP_KEY)
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

-- Xử lý xác nhận key
verifyBtn.MouseButton1Click:Connect(function()
    local userKey = keyBox.Text
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

-- Xử lý hiển thị link GetKey
linkBtn.MouseButton1Click:Connect(function()
    linkBox.Text = GETKEY_LINK
end)

-- Xử lý Clear linkBox
clearBtn.MouseButton1Click:Connect(function()
    linkBox.Text = ""
end)

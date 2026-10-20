--[[
    ========================================================================
    MID HUB — Anime Girl RNG (PlaceId: 89100823864844)
    Includes Integrated Key Gate + Auto-Save & Webhook Logging
    ========================================================================
]]

-- ==================== PART 1: KEY SYSTEM ====================
local Players           = game:GetService("Players")
local TweenService      = game:GetService("TweenService")
local HttpService       = game:GetService("HttpService")
local UserInputService  = game:GetService("UserInputService")
local CoreGui           = game:GetService("CoreGui")
local LocalPlayer       = Players.LocalPlayer
local fRequest          = request or http_request or (syn and syn.request) or (http and http.request)
local httpRequest       = fRequest

do
-- Cryptography (Pure Lua SHA-256 for HWID & Nonce integrity across all executors)
local _a=2^32;local _b=_a-1;local function _c(d,e)local f,g=0,1;while d~=0 or e~=0 do local h,i=d%2,e%2;local j=(h+i)%2;f=f+j*g;d=math.floor(d/2)e=math.floor(e/2)g=g*2 end;return f%_a end;local function _k(d,e,l,...)local m;if e then d=d%_a;e=e%_a;m=_c(d,e)if l then m=_k(m,l,...)end;return m elseif d then return d%_a else return 0 end end;local function _n(d,e,l,...)local m;if e then d=d%_a;e=e%_a;m=(d+e-_c(d,e))/2;if l then m=_n(m,l,...)end;return m elseif d then return d%_a else return _b end end;local function _o(p)return _b-p end;local function _q(d,r)if r<0 then return d*2^(-r)%_a end;return math.floor(d%_a/2^r)end;local function _s(p,r)if r>31 or r<-31 then return 0 end;return _q(p%_a,r)end;local function _lshift(d,r)if r<0 then return _s(d,-r)end;return d*2^r%_a end;local function _t(p,r)p=p%_a;r=r%32;local u=_n(p,2^r-1)return _s(p,r)+_lshift(u,32-r)end;local _v={0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function _w(x)return string.gsub(x,".",function(l)return string.format("%02x",string.byte(l))end)end;local function _y(z,A)local x=""for B=1,A do local C=z%256;x=string.char(C)..x;z=(z-C)/256 end;return x end;local function _D(x,B)local A=0;for B=B,B+3 do A=A*256+string.byte(x,B)end;return A end;local function _E(F,G)local H=64-(G+9)%64;G=_y(8*G,8)F=F.."\128"..string.rep("\0",H)..G;assert(#F%64==0)return F end;local function _I(J)J[1]=0x6a09e667;J[2]=0xbb67ae85;J[3]=0x3c6ef372;J[4]=0xa54ff53a;J[5]=0x510e527f;J[6]=0x9b05688c;J[7]=0x1f83d9ab;J[8]=0x5be0cd19;return J end;local function _K(F,B,J)local L={}for M=1,16 do L[M]=_D(F,B+(M-1)*4)end;for M=17,64 do local N=L[M-15]local O=_k(_t(N,7),_t(N,18),_s(N,3))N=L[M-2]L[M]=(L[M-16]+O+L[M-7]+_k(_t(N,17),_t(N,19),_s(N,10)))%_a end;local d,e,l,P,Q,R,S,T=J[1],J[2],J[3],J[4],J[5],J[6],J[7],J[8]for B=1,64 do local O=_k(_t(d,2),_t(d,13),_t(d,22))local U=_k(_n(d,e),_n(d,l),_n(e,l))local V=(O+U)%_a;local W=_k(_t(Q,6),_t(Q,11),_t(Q,25))local X=_k(_n(Q,R),_n(_o(Q),S))local Y=(T+W+X+_v[B]+L[B])%_a;T=S;S=R;R=Q;Q=(P+Y)%_a;P=l;l=e;e=d;d=(Y+V)%_a end;J[1]=(J[1]+d)%_a;J[2]=(J[2]+e)%_a;J[3]=(J[3]+l)%_a;J[4]=(J[4]+P)%_a;J[5]=(J[5]+Q)%_a;J[6]=(J[6]+R)%_a;J[7]=(J[7]+S)%_a;J[8]=(J[8]+T)%_a end;local function _Z(F)F=_E(F,#F)local J=_I({})for B=1,#F,64 do _K(F,B,J)end;return _w(_y(J[1],4).._y(J[2],4).._y(J[3],4).._y(J[4],4).._y(J[5],4).._y(J[6],4).._y(J[7],4).._y(J[8],4))end;
local lDigest = _Z

-- Executor API Bridge
local fSetClipboard = setclipboard or toclipboard or (syn and syn.write_clipboard) or set_clipboard
local fRequest = request or http_request or (syn and syn.request) or (http and http.request)
local fGetHwid = gethwid or get_hwid or function()
    local s, id = pcall(function() return game:GetService("RbxAnalyticsService"):GetClientId() end)
    if s and id and #tostring(id) > 0 then return tostring(id) end
    return tostring(LocalPlayer.UserId)
end

-- Platoboost Configuration
local PLATO_SERVICE = 34030
local PLATO_SECRET = "73898f9c-09ee-451b-a428-9374c03b2d26"
local PLATO_USE_NONCE = true
local KEY_FILE_NAME = "MidHub_Key_AnimeGirlRNG.txt"
local DISCORD_LINK  = "https://discord.gg/g2tApAntEB"
local WEBHOOK_URL   = "https://ptb.discord.com/api/webhooks/1537543971914387456/hHVJo5xFczFigaABX_OScL38NXM-KX0-s6zYC3CzuSA4wmganip-DJRmHKIgpm_ihD52"

local httpRequest = fRequest

local function getSavedKey()
    if isfile and readfile then
        if isfile(KEY_FILE_NAME) then
            local success, content = pcall(function() return readfile(KEY_FILE_NAME) end)
            if success and typeof(content) == "string" then
                return content:match("^%s*(.-)%s*$")
            end
        elseif isfile("FluzzyKey.txt") then
            local success, content = pcall(function() return readfile("FluzzyKey.txt") end)
            if success and typeof(content) == "string" then
                return content:match("^%s*(.-)%s*$")
            end
        end
    end
    return nil
end

local function saveKey(keyToSave)
    if writefile then
        pcall(function() writefile(KEY_FILE_NAME, tostring(keyToSave)) end)
    end
end

local function sendKeyWebhook(title, color, fields)
    if not httpRequest or not WEBHOOK_URL or WEBHOOK_URL == "" then return end
    task.spawn(function()
        pcall(function()
            local payload = {
                embeds = {{
                    title = title,
                    color = color or 0x00FF88,
                    fields = fields or {},
                    footer = { text = "MID HUB • " .. os.date("!%Y-%m-%d %H:%M:%S UTC") }
                }}
            }
            httpRequest({
                Url = WEBHOOK_URL,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode(payload)
            })
        end)
    end)
end

local function generateNonce()
    local str = ""
    for _ = 1, 16 do
        str = str .. string.char(math.random(97, 122))
    end
    return str
end

local cachedLink, cachedTime = "", 0
local function cacheGatewayLink()
    if cachedLink ~= "" and (cachedTime + (10 * 60) > os.time()) then
        return true, cachedLink
    end
    if not fRequest then
        return false, "Executor does not support HTTP requests"
    end
    
    local ok, res = pcall(function()
        return fRequest({
            Url = PLATO_HOST .. "/public/start",
            Method = "POST",
            Body = HttpService:JSONEncode({
                service = PLATO_SERVICE,
                identifier = lDigest(fGetHwid())
            }),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
    end)
    
    if ok and res and res.StatusCode == 200 then
        local decodeOk, decoded = pcall(function() return HttpService:JSONDecode(res.Body) end)
        if decodeOk and decoded and decoded.success == true and decoded.data and decoded.data.url then
            cachedLink = decoded.data.url
            cachedTime = os.time()
            return true, cachedLink
        else
            return false, (decoded and decoded.message) or "Failed to parse link."
        end
    elseif ok and res and res.StatusCode == 429 then
        return false, "Rate limited. Wait 20 seconds."
    end
    return false, "Failed to connect to Platoboost."
end

local function redeemKey(key)
    local nonce = generateNonce()
    local endpoint = PLATO_HOST .. "/public/redeem/" .. tostring(PLATO_SERVICE)
    local body = {
        identifier = lDigest(fGetHwid()),
        key = key
    }
    if PLATO_USE_NONCE then
        body.nonce = nonce
    end
    
    local ok, res = pcall(function()
        return fRequest({
            Url = endpoint,
            Method = "POST",
            Body = HttpService:JSONEncode(body),
            Headers = {
                ["Content-Type"] = "application/json"
            }
        })
    end)
    
    if ok and res and res.StatusCode == 200 then
        local decodeOk, decoded = pcall(function() return HttpService:JSONDecode(res.Body) end)
        if decodeOk and decoded and decoded.success == true then
            if decoded.data and decoded.data.valid == true then
                if PLATO_USE_NONCE then
                    if decoded.data.hash == lDigest("true-" .. nonce .. "-" .. PLATO_SECRET) then
                        return true, "Key redeemed successfully!"
                    else
                        return false, "Integrity verification failed."
                    end
                else
                    return true, "Key redeemed successfully!"
                end
            else
                return false, "Invalid key."
            end
        else
            if decoded and decoded.message and string.sub(decoded.message, 1, 27) == "unique constraint violation" then
                return false, "You already have an active key."
            else
                return false, (decoded and decoded.message) or "Failed to redeem key."
            end
        end
    elseif ok and res and res.StatusCode == 429 then
        return false, "Rate limited. Please wait 20s."
    end
    return false, "Platoboost server error."
end

local API_KEY_URL   = "https://fluzzy.kwierzchowski565.workers.dev"
local GATEWAY_URL   = "https://fluzzy.kwierzchowski565.workers.dev/"
local DISCORD_LINK  = "https://discord.gg/h2xwyETur"

local isRequestSending = false
local function verifyKey(key)
    if not key or key == "" then return false, "Key cannot be empty." end
    local clean = tostring(key):gsub("%s+", ""):upper()
    local hwid = (type(fGetHwid) == "function" and fGetHwid()) or tostring(LocalPlayer.UserId)
    local url = string.format("%s/verify?key=%s&hwid=%s&userid=%s&game=rng", API_KEY_URL, clean, hwid, tostring(LocalPlayer.UserId))
    local success, response = pcall(function()
        if fRequest then
            return fRequest({ Url = url, Method = "GET" })
        else
            return { Body = game:HttpGet(url) }
        end
    end)
    if success and response and response.Body then
        local ok, data = pcall(function() return HttpService:JSONDecode(response.Body) end)
        if ok and data and data.valid == true then
            return true, data.message or "Welcome to Mid Hub!"
        else
            return false, (data and data.message) or "Invalid key! Get key at fluzzy.kwierzchowski565.workers.dev"
        end
    end
    return false, "Connection to key server failed."
end

local keyUnlocked = false

if getgenv().MidHub_DevMode or getgenv().MidHub_KeyBypass then
    keyUnlocked = true
else
    local saved = getSavedKey()
    if saved and #saved > 0 then
        local valid, msg = verifyKey(saved)
        if valid then
            keyUnlocked = true
        end
    end
end

if not keyUnlocked then
do
    -- Pre-cache personal gateway link
    -- gateway cached

    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeySystemUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 999
    screenGui.IgnoreGuiInset = true

    local blur = Instance.new("Frame")
    blur.Name = "Backdrop"
    blur.Size = UDim2.fromScale(1, 1)
    blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blur.BackgroundTransparency = 0.45
    blur.BorderSizePixel = 0
    blur.Parent = screenGui

    local card = Instance.new("Frame")
    card.Name = "Card"
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.Position = UDim2.fromScale(0.5, 0.5)
    card.Size = UDim2.fromOffset(360, 0)
    card.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
    card.BorderSizePixel = 0
    card.ClipsDescendants = true
    card.Parent = screenGui

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 14)
    cardCorner.Parent = card

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = Color3.fromRGB(45, 45, 50)
    cardStroke.Thickness = 1
    cardStroke.Parent = card

    local accent = Instance.new("Frame")
    accent.Name = "Accent"
    accent.Size = UDim2.new(1, 0, 0, 4)
    accent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    accent.BorderSizePixel = 0
    accent.Parent = card
    Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 14)

    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.BackgroundTransparency = 1
    title.Position = UDim2.fromOffset(0, 28)
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Font = Enum.Font.GothamBold
    title.Text = "MID HUB • Key System"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 20
    title.Parent = card

    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.fromOffset(0, 58)
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Font = Enum.Font.Gotham
    subtitle.Text = "Mid Hub Key System"
    subtitle.TextColor3 = Color3.fromRGB(150, 150, 155)
    subtitle.TextSize = 13
    subtitle.Parent = card

    local inputHolder = Instance.new("Frame")
    inputHolder.Name = "InputHolder"
    inputHolder.AnchorPoint = Vector2.new(0.5, 0)
    inputHolder.Position = UDim2.new(0.5, 0, 0, 95)
    inputHolder.Size = UDim2.new(1, -40, 0, 42)
    inputHolder.BackgroundColor3 = Color3.fromRGB(28, 28, 31)
    inputHolder.BorderSizePixel = 0
    inputHolder.Parent = card
    Instance.new("UICorner", inputHolder).CornerRadius = UDim.new(0, 10)

    local inputStroke = Instance.new("UIStroke")
    inputStroke.Color = Color3.fromRGB(50, 50, 55)
    inputStroke.Thickness = 1
    inputStroke.Parent = inputHolder

    local keyBox = Instance.new("TextBox")
    keyBox.Name = "KeyBox"
    keyBox.BackgroundTransparency = 1
    keyBox.Position = UDim2.fromOffset(14, 0)
    keyBox.Size = UDim2.new(1, -28, 1, 0)
    keyBox.Font = Enum.Font.Gotham
    keyBox.PlaceholderText = "Paste KEY_... here"
    keyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 125)
    keyBox.Text = ""
    keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyBox.TextSize = 14
    keyBox.TextXAlignment = Enum.TextXAlignment.Left
    keyBox.ClearTextOnFocus = false
    keyBox.Parent = inputHolder

    local submitBtn = Instance.new("TextButton")
    submitBtn.Name = "SubmitButton"
    submitBtn.AnchorPoint = Vector2.new(0.5, 0)
    submitBtn.Position = UDim2.new(0.5, 0, 0, 147)
    submitBtn.Size = UDim2.new(1, -40, 0, 42)
    submitBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    submitBtn.BorderSizePixel = 0
    submitBtn.AutoButtonColor = false
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.Text = "Verify Key"
    submitBtn.TextColor3 = Color3.fromRGB(15, 15, 15)
    submitBtn.TextSize = 15
    submitBtn.Parent = card
    Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 10)

    local errorLabel = Instance.new("TextLabel")
    errorLabel.Name = "ErrorLabel"
    errorLabel.BackgroundTransparency = 1
    errorLabel.AnchorPoint = Vector2.new(0.5, 0)
    errorLabel.Position = UDim2.new(0.5, 0, 0, 195)
    errorLabel.Size = UDim2.new(1, -40, 0, 18)
    errorLabel.Font = Enum.Font.Gotham
    errorLabel.Text = ""
    errorLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
    errorLabel.TextSize = 12
    errorLabel.TextTransparency = 1
    errorLabel.Parent = card

    local divider = Instance.new("Frame")
    divider.Name = "Divider"
    divider.AnchorPoint = Vector2.new(0.5, 0)
    divider.Position = UDim2.new(0.5, 0, 0, 218)
    divider.Size = UDim2.new(1, -40, 0, 1)
    divider.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    divider.BorderSizePixel = 0
    divider.Parent = card

    local discordLabel = Instance.new("TextLabel")
    discordLabel.Name = "DiscordLabel"
    discordLabel.BackgroundTransparency = 1
    discordLabel.AnchorPoint = Vector2.new(0.5, 0)
    discordLabel.Position = UDim2.new(0.5, 0, 0, 232)
    discordLabel.Size = UDim2.new(1, -40, 0, 16)
    discordLabel.Font = Enum.Font.Gotham
    discordLabel.Text = "Get your key (HWID Locked):"
    discordLabel.TextColor3 = Color3.fromRGB(150, 150, 155)
    discordLabel.TextSize = 12
    discordLabel.Parent = card

    local discordRow = Instance.new("Frame")
    discordRow.Name = "DiscordRow"
    discordRow.AnchorPoint = Vector2.new(0.5, 0)
    discordRow.Position = UDim2.new(0.5, 0, 0, 252)
    discordRow.Size = UDim2.new(1, -40, 0, 36)
    discordRow.BackgroundColor3 = Color3.fromRGB(28, 28, 31)
    discordRow.BorderSizePixel = 0
    discordRow.Parent = card
    Instance.new("UICorner", discordRow).CornerRadius = UDim.new(0, 10)

    local discordText = Instance.new("TextLabel")
    discordText.Name = "DiscordText"
    discordText.BackgroundTransparency = 1
    discordText.Position = UDim2.fromOffset(14, 0)
    discordText.Size = UDim2.new(1, -90, 1, 0)
    discordText.Font = Enum.Font.Gotham
    discordText.Text = "fluzzy.kwierzchowski565.workers.dev"
    discordText.TextColor3 = Color3.fromRGB(200, 200, 205)
    discordText.TextSize = 12
    discordText.TextTruncate = Enum.TextTruncate.AtEnd
    discordText.TextXAlignment = Enum.TextXAlignment.Left
    discordText.Parent = discordRow

    local copyBtn = Instance.new("TextButton")
    copyBtn.Name = "CopyButton"
    copyBtn.AnchorPoint = Vector2.new(1, 0.5)
    copyBtn.Position = UDim2.new(1, -8, 0.5, 0)
    copyBtn.Size = UDim2.fromOffset(64, 26)
    copyBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    copyBtn.BorderSizePixel = 0
    copyBtn.AutoButtonColor = false
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.Text = "Copy"
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.TextSize = 12
    copyBtn.Parent = discordRow
    Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 8)

    local function setupHover(btn, baseCol, hoverCol)
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = hoverCol }):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = baseCol }):Play()
        end)
    end
    setupHover(submitBtn, Color3.fromRGB(255, 255, 255), Color3.fromRGB(225, 225, 225))
    setupHover(copyBtn, Color3.fromRGB(45, 45, 50), Color3.fromRGB(60, 60, 66))

    copyBtn.MouseButton1Click:Connect(function()
        pcall(function() fSetClipboard("https://fluzzy.kwierzchowski565.workers.dev/") end)
        copyBtn.Text = "Copied!"
        task.delay(1.5, function()
            if copyBtn then copyBtn.Text = "Copy" end
        end)
    end)

    local function showError(msg)
        errorLabel.Text = msg
        TweenService:Create(errorLabel, TweenInfo.new(0.15), { TextTransparency = 0 }):Play()
        local originalPos = inputHolder.Position
        local shakeTween = TweenService:Create(
            inputHolder,
            TweenInfo.new(0.06, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 3, true),
            { Position = originalPos + UDim2.fromOffset(6, 0) }
        )
        shakeTween:Play()
        inputStroke.Color = Color3.fromRGB(255, 90, 90)
        task.delay(1.8, function()
            if errorLabel then TweenService:Create(errorLabel, TweenInfo.new(0.3), { TextTransparency = 1 }):Play() end
            if inputStroke then inputStroke.Color = Color3.fromRGB(50, 50, 55) end
        end)
    end

    local function destroyKeyUI()
        card.ClipsDescendants = true
        local fadeOut = TweenService:Create(card, TweenInfo.new(0.25), { Size = UDim2.fromOffset(360, 0) })
        local backdropFade = TweenService:Create(blur, TweenInfo.new(0.3), { BackgroundTransparency = 1 })
        fadeOut:Play()
        backdropFade:Play()
        fadeOut.Completed:Connect(function()
            screenGui:Destroy()
        end)
    end

    local isSubmitting = false
    local function submitKey()
        if isSubmitting then return end
        local enteredKey = keyBox.Text:match("^%s*(.-)%s*$")
        if not enteredKey or enteredKey == "" then
            showError("Please enter a key!")
            return
        end

        isSubmitting = true
        submitBtn.Text = "Checking..."
        
        task.spawn(function()
            local valid, msg = verifyKey(enteredKey)
            if valid then
                saveKey(enteredKey)
                local gameName = "Unknown"
                pcall(function() gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name end)
                sendKeyWebhook("✅ Script Executed", 0x00FF88, {
                    { name = "Username", value = LocalPlayer.Name, inline = true },
                    { name = "User ID", value = tostring(LocalPlayer.UserId), inline = true },
                    { name = "Game", value = gameName, inline = true },
                    { name = "Method", value = "Platoboost API", inline = true }
                })

                submitBtn.Text = "Success"
                submitBtn.BackgroundColor3 = Color3.fromRGB(120, 255, 150)
                task.wait(0.35)
                destroyKeyUI()
                task.wait(0.25)
                keyUnlocked = true
            else
                sendKeyWebhook("❌ Wrong Key Attempt", 0xFF0000, {
                    { name = "Username", value = LocalPlayer.Name, inline = true },
                    { name = "User ID", value = tostring(LocalPlayer.UserId), inline = true },
                    { name = "Key Attempted", value = enteredKey ~= "" and enteredKey or "(empty)", inline = true }
                })
                submitBtn.Text = "Verify Key"
                showError(msg or "Invalid key. Please try again.")
                isSubmitting = false
            end
        end)
    end

    submitBtn.MouseButton1Click:Connect(submitKey)
    keyBox.FocusLost:Connect(function(enter) if enter then submitKey() end end)

    screenGui.Parent = parentTarget
    TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(360, 300)
    }):Play()
end

repeat task.wait(0.1) until keyUnlocked
end
end

-- ==================== PART 2: MAIN MID HUB SCRIPT ====================

local queue_on_teleport = (syn and syn.queue_on_teleport) 
                       or queue_on_teleport 
                       or (fluxus and fluxus.queue_on_teleport)
                       or (getgenv and getgenv().queue_on_teleport)

local function QueueScriptExecution()
    if queue_on_teleport then
        pcall(function()
            queue_on_teleport([[
                task.wait(1)
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Pastebinsasd/my-roblox-scripts/main/scriptt.lua"))()
            ]])
        end)
    end
end

-- Load Rayfield UI Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

local RS              = game:GetService("ReplicatedStorage")
local CS              = game:GetService("CollectionService")
local RunService      = game:GetService("RunService")
local GuiService      = game:GetService("GuiService")
local GroupService    = game:GetService("GroupService")
local TeleportService = game:GetService("TeleportService")
local SoundService    = game:GetService("SoundService")

local VIM, VirtualUser
pcall(function() VIM = game:GetService("VirtualInputManager") end)
pcall(function() VirtualUser = game:GetService("VirtualUser") end)

local AuraData = {}
pcall(function() AuraData = require(RS:WaitForChild("Data"):WaitForChild("AuraData")) end)

-- Forward declaration of Config so all helpers have immediate scope
local Config

-- Safe standing positions on solid wooden docks
local Island1FishingCFrame = CFrame.new(
    279.610077, 8594.87109, 435.23056,
    0.0256866198, 9.18731544e-08, -0.999670029,
    -6.0297431e-08, 1, 9.03541277e-08,
    0.999670029, 5.79566439e-08, 0.0256866198
)

local Island2FishingCFrame = CFrame.new(
    20089.2265625, 8590.65625, 789.6220703125,
    0.47936317324638367, 1.2733597287706289e-08, -0.8776166439056396,
    3.167375339785394e-08, 1, 3.1809822331752e-08,
    0.8776166439056396, -4.304586909142927e-08, 0.47936317324638367
)

-- In-Game Message System
local MessageSystem = nil
pcall(function()
    local ps = LocalPlayer:WaitForChild("PlayerScripts", 5)
    local is = ps and ps:WaitForChild("InteractionSystems", 5)
    if is then
        MessageSystem = require(is:WaitForChild("MessageSystem", 5))
    end
end)

local function SafeNotify(title, content, duration, msgType)
    local fullMsg = (title and content) and (title .. ": " .. content) or (content or title or "")
    pcall(function()
        if MessageSystem and MessageSystem.Message then
            local t = msgType or "Information"
            if not msgType then
                local low = tostring(title):lower()
                if low:find("warn") or low:find("fail") or low:find("cancel") then
                    t = "Warning"
                elseif low:find("reward") or low:find("claim") or low:find("got") or low:find("found") or low:find("done") or low:find("success") or low:find("win") then
                    t = "Reward"
                end
            end
            MessageSystem:Message(fullMsg, t)
        end
    end)

    pcall(function()
        if Rayfield and Rayfield.Notify then
            Rayfield:Notify({ name = title or "Mid Hub", description = content or "", duration = duration or 5 })
        end
    end)
end

local function SendWebhook(title, description, colorHex)
    if not Config or not Config.WebhookURL or Config.WebhookURL == "" then return end
    pcall(function()
        local payload = {
            embeds = {{
                title = title,
                description = description,
                color = colorHex or 0x00FF88,
                timestamp = DateTime.now():ToIsoDate(),
                footer = { text = "MID HUB • " .. (LocalPlayer.Name or "Player") }
            }}
        }
        if httpRequest then
            httpRequest({
                Url = Config.WebhookURL,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = HttpService:JSONEncode(payload)
            })
        end
    end)
end

local RemoteHandler
pcall(function()
    RemoteHandler = require(RS:WaitForChild("Modules"):WaitForChild("RemoteHandler"))
end)

local function GetR(name)
    if RemoteHandler then
        local ok, r = pcall(function() return RemoteHandler:Get(name) end)
        if ok and r then return r end
    end
    local f = RS:FindFirstChild("Remotes")
    return f and f:FindFirstChild(name)
end

-- ==================== REMOTES ====================
local R_BiomeChanged       = GetR("Biome:Changed")
local R_BiomeUseCaller     = GetR("Biome:UseCaller")
local R_RollResult         = GetR("Roll:Result")
local R_UpgradeStorage     = GetR("Roll:UpgradeStorage")

-- Quests
local R_QuestClaim         = GetR("Quest:Claim")
local R_QuestClaimPower    = GetR("Quest:ClaimPower")
local R_QuestClaimAllPower = GetR("Quest:ClaimAllPower")
local R_DailyClaim         = GetR("Daily:Claim")
local R_GroupClaim         = GetR("GroupReward:Claim")
local R_QuestStatus        = GetR("Quest:GetStatus")
local R_QuestActivate      = GetR("Quest:Activate")
local R_QuestWeekly        = GetR("Quest:RequestWeekly")
local R_QuestNPCInteract   = GetR("Quest:NPCInteracted")

-- Special Quests
local R_RobinGetBoard      = GetR("RobinQuest:GetBountyBoard")
local R_RobinAccept        = GetR("RobinQuest:Accept")
local R_RobinClaim         = GetR("RobinQuest:Claim")
local R_CharmyGetBoard     = GetR("CharmyQuest:GetBountyBoard")
local R_CharmyStart        = GetR("CharmyQuest:Start")
local R_CharmyClaim        = GetR("CharmyQuest:Claim")
local R_IshmaelGetStatus   = GetR("IshmaelQuest:GetStatus")
local R_IshmaelAccept      = GetR("IshmaelQuest:Accept")
local R_IshmaelClaim       = GetR("IshmaelQuest:Claim")
local R_AventurineStart    = GetR("AventurineQuest:Start")
local R_AventurineClaim    = GetR("AventurineQuest:Claim")
local R_EgoQuestStart      = GetR("EgoQuest:Start")
local R_AlmightyStart      = GetR("AlmightyQuest:Start")
local R_AizenStart         = GetR("AizenQuest:Start")
local R_YukiDomain         = GetR("YukiQuest:StartDomain")
local R_YukiLimited        = GetR("YukiQuest:StartLimited")

-- Minigames
local R_MinigamesStart     = GetR("Minigames:Start")
local R_MinigamesFinished  = GetR("Minigames:Finished")
local R_MinigamesCancel    = GetR("Minigames:Cancel")
local R_MinigamesReward    = GetR("Minigames:Reward")
local R_MinigamesCooldown  = GetR("Minigames:Cooldown")

-- Codes & Crafting
local R_CodeRedeem         = GetR("Code:Redeem")
local R_CodeRedeemResp     = GetR("Code:RedeemResponse")
local R_CraftCompleted     = GetR("Craft:Completed")
local R_CraftAddAll        = GetR("Craft:AddAll")
local R_CraftComplete      = GetR("Craft:Complete")

-- Fishing
local R_FishCast           = GetR("Fishing:Cast")
local R_FishShake          = GetR("Fishing:Shake")
local R_FishSession        = GetR("Fishing:Session")
local R_FishResult         = GetR("Fishing:Result")
local R_FishDebug          = GetR("Fishing:GetDebugSnapshot")
local R_FishAnglerState    = GetR("FishingAngler:GetState")
local R_FishExchangeAll    = GetR("FishingAngler:ExchangeAll")

-- Crates, Potions & Other
local R_PlaytimeClaim      = GetR("Playtime:Claim")
local R_AchieveGetStatus   = GetR("Achieve:GetStatus")
local R_AchieveClaim       = GetR("Achieve:Claim")
local R_BPClaimAll         = GetR("BattlePass:ClaimAll")
local R_ExtractAction      = GetR("ExtractTable:Action")
local R_DarkMarketPurchase = GetR("DarkMarket:Purchase")
local R_DarkMarketPurchRes = GetR("DarkMarket:PurchaseResult")
local R_DarkMarketNotify   = GetR("DarkMarket:Notify")
local R_CandlePlace        = GetR("Candle:Place")
local R_PotionDrink        = GetR("Potion:Drink")
local R_PotionDrinkBatch   = GetR("Potion:DrinkBatch")
local R_PotionGetInventory = GetR("Potion:GetInventory")
local R_PotionPickup       = GetR("Potion:Pickup")
local R_PotionSpawn        = GetR("Potion:Spawn")
local R_CrateOpen          = GetR("Crate:Open")
local R_CrateOpenResult    = GetR("Crate:OpenResult")

-- Halloween Event Remotes
local R_HalloweenBPClaimAll  = GetR("HalloweenBattlePass:ClaimAll")
local R_HalloweenBPClaim     = GetR("HalloweenBattlePass:Claim")
local R_HalloweenBPState     = GetR("HalloweenBattlePass:GetState")
local R_HalloweenQuestBoard  = GetR("HalloweenQuest:GetBountyBoard")
local R_HalloweenQuestAccept = GetR("HalloweenQuest:Accept")
local R_HalloweenQuestClaim  = GetR("HalloweenQuest:Claim")
local R_HalloweenShopBuy     = GetR("HalloweenShop:Purchase")
local R_HorsemanShopBuy      = GetR("HorsemanShop:Purchase")

-- ==================== CONFIGURATION ====================
Config = {
    AutoFish            = false,
    FishingDockChoice   = "Auto-Detect (Nearest)",
    AutoCollect         = false,
    AutoObby            = false,
    AutoSellFish        = false,
    AutoCraft           = false,
    AutoCraftCandles    = false,
    CandlesToCraft      = { "Candle_Basic", "Candle_Magic", "Candle_Hot" },
    AutoTPToActiveCandle= false,
    AutoUpgradeStorage  = false,
    AutoPlaceCandles    = false,
    CandleSmartExpiry   = true,
    CandlesToPlace      = { "Candle_Hot", "Candle_Basic" },
    CandleInterval      = 300,
    AutoDrinkPotions    = false,
    PotionsToDrink      = { "Big Luck Pot", "Big Haste Pot" },
    PotionInterval      = 60,
    SmartPotionExpiry   = true,
    AutoUseCaller       = false,
    CallersToUse        = { "Caller Star", "Huzzoween Star" },
    CallerInterval      = 600,
    AutoOpenCrates      = false,
    CratesToOpen        = { "Halloween Crate", "Summer Crate", "Potion Crate", "Better Potion Crate", "Premium Potion Crate", "Goodie Crate", "Better Goodie Crate", "Premium Goodie Crate" },
    CrateOpenInterval   = 3.0,
    AutoTrickOrTreat    = false,
    AutoHalloweenBP     = false,
    AutoHalloweenBounties = false,
    AutoOpenHalloweenCrates = false,
    AutoQuests          = false,
    QuestsSelected      = { "Standard Quests", "Robin Summer", "Charmy Bounties", "Ishmael Daily", "Aventurine Wagers", "Ego Trial", "Almighty Quests" },
    AutoRobinQuests     = false,
    AutoRobinDrinkPots  = false,
    StopFishOnSummerDone= false,
    StopMiniOnSummerDone= false,
    AutoMinigames       = false,
    MinigameSelected    = "Memory Match",  -- "Memory Match", "PickLock", "Chess"
    MinigameOutcome     = "Win",           -- "Win", "Resign / Lose"
    MinigameDifficulty  = "Easy",          -- "Easy", "Medium", "Hard"
    AutoTimeRewards     = false,
    AutoAchievements    = false,
    AutoBattlePass      = false,
    AutoAstralis        = false,
    AstralisPotions     = {},
    AutoVending         = false,
    VendingCooldown     = 300,
    AutoClaimCauldron   = false,
    CauldronInterval    = 30,
    AutoBuyMystery      = false,
    AutoTPMerchant      = true,
    MysteryPotionsToBuy = { "Transcendent Pot", "Glitched Potion", "Omega Pot" },
    AntiAFK             = true,
    AutoRejoin          = true,
    AutoReExecOnHop     = true,
    TargetHopBiomes     = {},
    IsSearchingBiome    = false,
    PotionESP           = false,
    NPCESP              = false,
    WebhookURL          = "https://ptb.discord.com/api/webhooks/1537544006123266160/fUcaOci2QehmURyOhYuLtCHtfjd_3LiUwoPRgue8PqGjBEVosvGvhM3Uy8FvqzZgfD_9",
    PingBiomes          = {},
    PingOnCraft         = false,
    PingOnCrate         = false,
    PingOnAura          = false,
    PingOnMerchant      = false,
    PingOnMysteryBuy    = false,
    PingOnMinigameReward= true,
    AuraThreshold       = 100000,
}

local HOP_STATE_FILE = "MidHub_HopState.json"

local function SaveHopState(stateTable)
    pcall(function()
        if writefile then writefile(HOP_STATE_FILE, HttpService:JSONEncode(stateTable)) end
    end)
end

local function LoadHopState()
    local ok, data = pcall(function()
        if readfile and isfile and isfile(HOP_STATE_FILE) then
            return HttpService:JSONDecode(readfile(HOP_STATE_FILE))
        end
    end)
    if ok and type(data) == "table" then return data end
    return nil
end

local function ClearHopState()
    pcall(function()
        if delfile and isfile and isfile(HOP_STATE_FILE) then
            delfile(HOP_STATE_FILE)
        end
    end)
end

-- ==================== DOCK RESOLVER ====================
local function GetActiveFishingDockData()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local pos = hrp and hrp.Position or Vector3.new(0, 0, 0)

    local dock1Marker = workspace:FindFirstChild("FishingDock") and workspace.FishingDock:FindFirstChild("PoolMarker")
    local dock2Marker = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Island2") 
        and workspace.Map.Island2:FindFirstChild("FishingDock") and workspace.Map.Island2.FishingDock:FindFirstChild("PoolMarker")

    if Config.FishingDockChoice == "Island 1 Dock" then
        return Island1FishingCFrame, dock1Marker
    elseif Config.FishingDockChoice == "Island 2 Dock" then
        return Island2FishingCFrame, dock2Marker
    else
        local dist1 = dock1Marker and (dock1Marker.Position - pos).Magnitude or math.huge
        local dist2 = dock2Marker and (dock2Marker.Position - pos).Magnitude or math.huge
        if dist2 < dist1 then
            return Island2FishingCFrame, dock2Marker
        else
            return Island1FishingCFrame, dock1Marker
        end
    end
end

-- Active Candle Helpers
local function GetBestActiveCandleCFrame()
    local bestScore = 0
    local targetCF = nil
    local bestTier = { ["Candle_Hot"] = 3, ["Candle_Magic"] = 2, ["Candle_Magical"] = 2, ["Candle_Basic"] = 1 }

    local activeCandles = CS:GetTagged("Candle_BillboardTimer")
    for _, candle in ipairs(activeCandles) do
        if candle:IsA("Model") and candle.Parent then
            local expireAt = candle:GetAttribute("ExpireAt")
            local timeLeft = (expireAt and (expireAt - workspace:GetServerTimeNow())) or 0
            if timeLeft > 2 then
                local score = bestTier[candle.Name] or 1
                if score > bestScore then
                    bestScore = score
                    targetCF = candle:GetPivot() * CFrame.new(0, 3, 0)
                end
            end
        end
    end
    return targetCF
end

local function HasAnyActiveCandleNearby(maxDist)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local activeCandles = CS:GetTagged("Candle_BillboardTimer")
    for _, candle in ipairs(activeCandles) do
        if candle:IsA("Model") and candle.Parent then
            local expireAt = candle:GetAttribute("ExpireAt")
            local timeLeft = (expireAt and (expireAt - workspace:GetServerTimeNow())) or 0
            if timeLeft > 2 then
                local dist = (candle:GetPivot().Position - hrp.Position).Magnitude
                if dist <= (maxDist or 15) then return true end
            end
        end
    end
    return false
end

CS:GetInstanceAddedSignal("Candle_BillboardTimer"):Connect(function(candle)
    if Config.AutoTPToActiveCandle and not Config.AutoFish and candle:IsA("Model") then
        task.wait(0.2)
        local cf = GetBestActiveCandleCFrame()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if cf and hrp then hrp.CFrame = cf end
    end
end)

-- Reward Screen Suppressor
local function SetupBuiltInRewardHider()
    task.spawn(function()
        local pg = LocalPlayer:WaitForChild("PlayerGui")
        local function suppressFrame(crateFrame)
            if crateFrame and crateFrame:IsA("GuiObject") then
                crateFrame.Visible = false
                crateFrame:GetPropertyChangedSignal("Visible"):Connect(function()
                    if crateFrame.Visible then crateFrame.Visible = false end
                end)
            end
        end

        local gameGui = pg:WaitForChild("Game", 10)
        if gameGui then
            local itemInv = gameGui:WaitForChild("ItemInv", 10)
            if itemInv then
                local crateFrame = itemInv:WaitForChild("CrateFrame", 5)
                if crateFrame then suppressFrame(crateFrame) end
            end
        end

        for _, descendant in ipairs(pg:GetDescendants()) do
            if descendant.Name == "CrateFrame" then suppressFrame(descendant) end
        end

        pg.DescendantAdded:Connect(function(descendant)
            if descendant.Name == "CrateFrame" then suppressFrame(descendant) end
        end)
    end)
end
SetupBuiltInRewardHider()

-- Server Hop Warning UI
local HopWarningGui = nil
local isHopCancelled = false

local function DestroyWarningUI()
    if HopWarningGui then
        pcall(function() HopWarningGui:Destroy() end)
        HopWarningGui = nil
    end
end

local function CancelBiomeHunt()
    isHopCancelled = true
    ClearHopState()
    Config.IsSearchingBiome = false
    DestroyWarningUI()
    SafeNotify("Biome Finder", "Server hop cancelled!", 3, "Warning")
end

local function ShowHopWarningUI(currentBiome, targetBiomes, onConfirmHop)
    DestroyWarningUI()
    isHopCancelled = false

    local parentTarget = (gethui and gethui()) or CoreGui or LocalPlayer:WaitForChild("PlayerGui")

    local sg = Instance.new("ScreenGui")
    sg.Name = "MidHub_HopWarning"
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local frame = Instance.new("Frame")
    frame.Name = "WarningCard"
    frame.Size = UDim2.new(0, 420, 0, 160)
    frame.Position = UDim2.new(0.5, -210, 0, -180)
    frame.BackgroundColor3 = Color3.fromRGB(16, 17, 24)
    frame.BackgroundTransparency = 0.08
    frame.BorderSizePixel = 0
    frame.Parent = sg
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1.8
    stroke.Color = Color3.fromRGB(255, 75, 75)
    stroke.Transparency = 0.2
    stroke.Parent = frame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -30, 0, 26)
    titleLabel.Position = UDim2.new(0, 15, 0, 12)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "⚠️  AUTO SERVER HOPPING"
    titleLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = frame

    local targetStr = table.concat(targetBiomes, ", ")
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -30, 0, 36)
    descLabel.Position = UDim2.new(0, 15, 0, 38)
    descLabel.BackgroundTransparency = 1
    descLabel.Font = Enum.Font.Gotham
    descLabel.Text = "Current: " .. currentBiome .. " | Hunting: [" .. targetStr .. "]"
    descLabel.TextColor3 = Color3.fromRGB(180, 185, 200)
    descLabel.TextSize = 13
    descLabel.TextWrapped = true
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = frame

    local countLabel = Instance.new("TextLabel")
    countLabel.Size = UDim2.new(0.6, 0, 0, 32)
    countLabel.Position = UDim2.new(0, 15, 0, 78)
    countLabel.BackgroundTransparency = 1
    countLabel.Font = Enum.Font.GothamBold
    countLabel.Text = "Hopping in 5s..."
    countLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    countLabel.TextSize = 18
    countLabel.TextXAlignment = Enum.TextXAlignment.Left
    countLabel.Parent = frame

    local pBarBg = Instance.new("Frame")
    pBarBg.Size = UDim2.new(1, -30, 0, 5)
    pBarBg.Position = UDim2.new(0, 15, 0, 142)
    pBarBg.BackgroundColor3 = Color3.fromRGB(35, 38, 50)
    pBarBg.BorderSizePixel = 0
    pBarBg.Parent = frame
    Instance.new("UICorner", pBarBg).CornerRadius = UDim.new(1, 0)

    local pBarFill = Instance.new("Frame")
    pBarFill.Size = UDim2.new(1, 0, 1, 0)
    pBarFill.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
    pBarFill.BorderSizePixel = 0
    pBarFill.Parent = pBarBg
    Instance.new("UICorner", pBarFill).CornerRadius = UDim.new(1, 0)

    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Size = UDim2.new(0, 120, 0, 36)
    cancelBtn.Position = UDim2.new(1, -135, 0, 84)
    cancelBtn.BackgroundColor3 = Color3.fromRGB(220, 45, 60)
    cancelBtn.Font = Enum.Font.GothamBold
    cancelBtn.Text = "✕ CANCEL HOP"
    cancelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    cancelBtn.TextSize = 13
    cancelBtn.AutoButtonColor = true
    cancelBtn.Parent = frame
    Instance.new("UICorner", cancelBtn).CornerRadius = UDim.new(0, 8)

    cancelBtn.MouseButton1Click:Connect(function() CancelBiomeHunt() end)

    sg.Parent = parentTarget
    HopWarningGui = sg

    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0.5, -210, 0, 35)
    }):Play()

    task.spawn(function()
        for i = 5, 1, -1 do
            if isHopCancelled or not HopWarningGui then return end
            countLabel.Text = "Hopping in " .. i .. "s..."
            TweenService:Create(pBarFill, TweenInfo.new(1, Enum.EasingStyle.Linear), {
                Size = UDim2.new((i - 1) / 5, 0, 1, 0)
            }):Play()
            task.wait(1)
        end
        if not isHopCancelled and HopWarningGui then
            countLabel.Text = "Teleporting..."
            countLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
            task.wait(0.3)
            DestroyWarningUI()
            if onConfirmHop then onConfirmHop() end
        end
    end)
end

local fishingStartTime      = 0
local lastObbyTime          = 0
local lastCandlePlaceTime   = 0
local lastPotionDrinkTime   = 0
local lastCallerTime        = 0
local lastCrateOpenTime     = 0
local lastUpgradeTime       = 0
local lastCandleCraftTime   = 0
local lastCauldronCheck     = 0
local lastMinigameTime      = 0
local lastBPClaimTime       = 0
local isOpeningCrates       = false
local isRedeemingCodes      = false
local isPostCatchRunning    = false
local isDoingMinigame       = false
local isMinigameLoopRunning = false
local isDoingNeco           = false
local robinPotsDrank        = {}

local CandleOptions = { "Candle_Basic", "Candle_Hot", "Candle_Magic" }

local PotionOptions = {
    "Big Haste Pot", "Big Luck Pot", "Small Haste Pot", "Small Luck Pot",
    "Transcendent Pot", "Glitched Potion", "Omega Pot", "Eternal Pot",
    "Divine Pot", "Ethereal Pot", "Heavens Pot", "Lightning Pot",
    "Twin Pot", "Greed Pot", "Sacred Pot", "Sovereign Pot", "Elementals Pot",
    "Carrot Juice", "Mystic Pot", "Spooky Potion", "Summer Luck", "Swift Pot",
    "Command Seal", "Holy Grail", "Hallows Potion"
}

local CrateOptions = {
    "Summer Crate", "Potion Crate", "Better Potion Crate", "Premium Potion Crate",
    "Goodie Crate", "Better Goodie Crate", "Premium Goodie Crate",
    "Halloween Crate", "Present", "Present 1", "Present 2"
}

local CallerOptions = { "Caller Star", "Huzzoween Star", "Halloween Caller Star" }

local AstralisPotionOptions = {
    "Lightning Pot", "Heavens Pot", "Sacred Pot", "Divine Pot", "Eternal Pot",
    "Transcendent Pot", "Sovereign Pot", "Elementals Pot", "Glitched Potion", "Omega Pot",
}

local MysteryMerchantPotions = {
    "Transcendent Pot", "Glitched Potion", "Omega Pot", "Eternal Pot",
    "Divine Pot", "Ethereal Pot", "Heavens Pot", "Lightning Pot",
    "Twin Pot", "Greed Pot", "Sovereign Pot", "Elementals Pot"
}

local BiomeList = {
    "Halloween", "Sakura", "Galaxy", "Atlantic", "Tempest", "Storm", "Magic", "Aether", "Ashen", "Desert", "Spooky", "Rain", "Snow", "Normal"
}

-- UPDATED CODES: Includes all current active codes (Halloween & Season 3)
local KnownCodes = {
    "HALLOWEEN",
    "SPOOKYBATTLEPASS",
    "WEAREBACK",
    "GAPWEEK",
    "JOJOS",
    "BATTLEPASS3",
    "YAREYARE",
    "FIVEHUNDREDHEAVENPOTS",
    "KILLSEL",
    "SECONDISLAND",
    "THEBIGGESTUPDATEOAT",
    "BLACKCLOVER",
    "SLIMENIAPLIX",
    "100KFAV",
    "70KMEMBERS",
    "TOMATO",
    "KILLNIAPLIXPT2",
    "KILLPHI",
    "FISH",
    "KILLGRANT",
    "GOMENSORRY",
    "ILIKEPOTIONS",
    "ISWEARITSLAST",
}

-- ==================== ACCURATE NPC & WORLD DATABASE ====================
local NPCTeleportDatabase = {
    Worlds = {
        { label = "🎃 Halloween Island (Docks)", pos = Vector3.new(1283.50, 8796.60, 24637.40) },
        { label = "🏝️ Island 2 (Main Plaza)",   pos = Vector3.new(19864, 8620, 434) },
        { label = "⛵ Island 2 (Spawn Dock)",   pos = Vector3.new(19901, 8586, 762) },
        { label = "🏠 Main Lobby (Spawn)",       pos = Vector3.new(700, 8604, 616) },
    },
    HalloweenIsland = {
        { label = "⛵ Halloween Docks (Spawn)",  pos = Vector3.new(1283.50, 8796.60, 24637.40) },
        { label = "🎃 Pumpkin Candy Shop",       pos = Vector3.new(1383.25, 8797.29, 24616.56) },
        { label = "💀 Headless Horseman NPC",    pos = Vector3.new(1413.25, 8796.28, 24624.56) },
        { label = "🧙 Trick-or-Treat Guide",     pos = Vector3.new(1338.00, 8796.28, 24619.16) },
        { label = "🎪 Event Plaza (Center)",      pos = Vector3.new(1315.50, 8817.60, 24426.40) },
        { label = "🏚️ House 1",                 pos = Vector3.new(1400.16, 8814.40, 24491.00) },
        { label = "🏚️ House 2",                 pos = Vector3.new(1400.16, 8814.40, 24404.00) },
        { label = "🏚️ House 3",                 pos = Vector3.new(1400.16, 8814.40, 24317.00) },
        { label = "🏚️ House 4",                 pos = Vector3.new(1233.96, 8814.40, 24491.00) },
        { label = "🏚️ House 5",                 pos = Vector3.new(1233.96, 8814.40, 24404.00) },
        { label = "🏚️ House 6",                 pos = Vector3.new(1233.96, 8814.40, 24317.00) },
    },
    Island2 = {
        { label = "Robin (Summer Quests)",     names = { "Robin" },              pos = Vector3.new(19864, 8617, 434) },
        { label = "Cerydra (Chess NPC)",       names = { "Cerydra" },            pos = Vector3.new(19924, 8617, 445) },
        { label = "Charmy (Bounties NPC)",     names = { "Charmy" },             pos = Vector3.new(19889, 8617, 604) },
        { label = "Ishmael (Daily Catch)",     names = { "Ishmael" },            pos = Vector3.new(20067, 8590, 750) },
        { label = "Aventurine (Wager NPC)",    names = { "Aventurine" },         pos = Vector3.new(19967, 8617, 533) },
        { label = "Yuki (Domain Quest)",       names = { "Yuki" },               pos = Vector3.new(19739, 8647, 336) },
        { label = "Pidgey",                    names = { "Pidgey" },             pos = Vector3.new(19846, 8618, 591) },
        { label = "Sel",                       names = { "Sel" },                pos = Vector3.new(19822, 8618, 565) },
        { label = "Plix",                      names = { "Plix" },               pos = Vector3.new(19828, 8618, 574) },
        { label = "Miracle",                   names = { "Miracle" },            pos = Vector3.new(19821, 8618, 480) },
        { label = "Phi",                       names = { "Phi" },                pos = Vector3.new(19879, 8629, 715) },
        { label = "Mar",                       names = { "Mar" },                pos = Vector3.new(19853, 8618, 595) },
    },
    Island2Stations = {
        { label = "Cauldron (Brewing Station)",names = { "Cauldron" },           pos = Vector3.new(19889, 8630, 698) },
        { label = "Arcade Machine",            names = { "ArcadeModel" },        pos = Vector3.new(19947, 8618, 470) },
        { label = "Quest Board (Island 2)",    names = { "Quests" },             pos = Vector3.new(19851, 8619, 448) },
        { label = "Bounty Board (Island 2)",   names = { "BillBoard" },          pos = Vector3.new(19813, 8619, 543) },
        { label = "Neco Arc Secret (Waterfall)",names= { "NecoArc" },            pos = Vector3.new(19845, 8592, 366) },
    },
    LobbyQuests = {
        { label = "Elfie (Better Crafting)",   names = { "Elfie", "ElfieNPC" },  pos = Vector3.new(1060, 8483, 665) },
        { label = "Welfie (Item Crafting)",    names = { "Welfie", "WelfieNPC" },pos = Vector3.new(1053, 8483, 689) },
        { label = "Ego (Trial NPC)",           names = { "Ego", "EgoNPC" },      pos = Vector3.new(1024, 8474, 580) },
        { label = "Urahara (Quest NPC)",       names = { "Urahara", "UraharaNPC"}, pos = Vector3.new(687, 8697, 929) },
        { label = "Power NPC",                 names = { "Power", "PowerNPC" },  pos = Vector3.new(634, 8596, 615) },
        { label = "Megumin NPC",               names = { "Megumin", "MeguminNPC"}, pos = Vector3.new(260, 8618, 606) },
        { label = "Wanderer NPC",              names = { "Wanderer", "WandererNPC"}, pos = Vector3.new(658, 8593, 960) },
        { label = "Polyh (Cave NPC)",          names = { "Polyh" },              pos = Vector3.new(314, 8590, 498) },
        { label = "Niaplix",                   names = { "Niaplix" },            pos = Vector3.new(222, 8597, 342) },
        { label = "Tactful (Lobby)",           names = { "Tactful" },            pos = Vector3.new(762, 8587, 763) },
        { label = "Kamina",                    names = { "Kamina" },             pos = Vector3.new(490, 8600, 635) },
    },
    LobbySocial = {
        { label = "Nuuya",                     names = { "Nuuya" },              pos = Vector3.new(635, 8597, 673) },
        { label = "Kikka",                     names = { "Kikka" },              pos = Vector3.new(627, 8597, 674) },
        { label = "Evelyn",                    names = { "Evelyn" },             pos = Vector3.new(618, 8601, 574) },
        { label = "Glitzie",                   names = { "Glitzie" },            pos = Vector3.new(490, 8600, 635) },
        { label = "Shelly",                    names = { "Shelly" },             pos = Vector3.new(780, 8596, 607) },
        { label = "X4nue",                     names = { "X4nue" },              pos = Vector3.new(774, 8597, 631) },
        { label = "Sylphiette",                names = { "Sylphiette" },         pos = Vector3.new(731, 8515, 668) },
        { label = "Makoto (Display)",          names = { "Makoto_Display" },     pos = Vector3.new(628, 8459, 676) },
        { label = "Event Board (Signup)",      names = { "Event" },              pos = Vector3.new(731, 8597, 516) },
    },
    Merchants = {
        { label = "Finiya (Mystery Merchant)", names = { "Finiya", "DarkMarketNPC" }, pos = Vector3.new(451, 8616, 777) },
        { label = "Fisherkuna (Angler Shop)",  names = { "Fisherkuna" },          pos = Vector3.new(242, 8599, 327) },
        { label = "Vending Machine",           names = { "VendingMachine" },      pos = Vector3.new(572, 8593, 636) },
        { label = "Extract Table (Altar)",     names = { "ExtractTable" },        pos = Vector3.new(1042, 8482, 670) },
        { label = "Parkour Orb (Obby)",        names = { "Part36" },              pos = Vector3.new(546, 8629, 393) },
    }
}

local ESPCache = { Potions = {}, NPCs = {} }

-- ==================== ANTI-AFK & AUTO-REJOIN ====================
local function SetupAntiAFK()
    pcall(function()
        if getconnections then
            for _, conn in pairs(getconnections(LocalPlayer.Idled)) do
                pcall(function()
                    if conn.Disable then conn:Disable()
                    elseif conn.Disconnect then conn:Disconnect() end
                end)
            end
        end
    end)

    LocalPlayer.Idled:Connect(function()
        if not Config.AntiAFK then return end
        pcall(function()
            if VirtualUser then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new(0, 0))
            elseif VIM then
                VIM:SendKeyEvent(true, Enum.KeyCode.RightShift, false, game)
                task.wait(0.05)
                VIM:SendKeyEvent(false, Enum.KeyCode.RightShift, false, game)
            end
        end)
    end)

    task.spawn(function()
        while task.wait(90) do
            if Config.AntiAFK then
                pcall(function()
                if VirtualUser then
                    VirtualUser:CaptureController()
                    VirtualUser:ClickButton2(Vector2.new(15, 15))
                elseif VIM then
                    VIM:SendKeyEvent(true, Enum.KeyCode.RightShift, false, game)
                    task.wait(0.05)
                    VIM:SendKeyEvent(false, Enum.KeyCode.RightShift, false, game)
                end
            end)
            end
        end
    end)

    GuiService.ErrorMessageChanged:Connect(function()
        if not Config.AutoRejoin then return end
        task.wait(0.5)
        local err = GuiService:GetErrorMessage()
        if err and #err > 0 then
            SafeNotify("Auto Rejoin", "Disconnected! Reconnecting in 3s...", 4, "Warning")
            if Config.AutoReExecOnHop then QueueScriptExecution() end
            task.wait(3)
            pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)
        end
    end)
end
SetupAntiAFK()

-- ==================== MINIGAME ENGINE & RESTORATION ====================

local serverMinigameCooldownUntil = 0
if R_MinigamesCooldown then
    R_MinigamesCooldown.OnClientEvent:Connect(function(cooldownUntil, plays)
        serverMinigameCooldownUntil = tonumber(cooldownUntil) or 0
        isDoingMinigame = false
    end)
end

local function ResetMinigameCamera()
    pcall(function()
        local cam = workspace.CurrentCamera
        if cam then
            cam.CameraType = Enum.CameraType.Custom
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildWhichIsA("Humanoid")
            if hum then cam.CameraSubject = hum end
        end
    end)
end

local function FindArcadePrompt()
    local structures = workspace:FindFirstChild("Map") 
        and workspace.Map:FindFirstChild("Island2") 
        and workspace.Map.Island2:FindFirstChild("PlazaStuff") 
        and workspace.Map.Island2.PlazaStuff:FindFirstChild("Structures")
    local arcade = structures and structures:FindFirstChild("ArcadeModel")
    if arcade then
        return arcade, arcade:FindFirstChildWhichIsA("ProximityPrompt", true)
    end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name == "ArcadeModel" and obj:IsA("Model") then
            return obj, obj:FindFirstChildWhichIsA("ProximityPrompt", true)
        end
    end
    return nil, nil
end

local function FindCerydraPrompt()
    local npcs = workspace:FindFirstChild("Map") 
        and workspace.Map:FindFirstChild("Island2") 
        and workspace.Map.Island2:FindFirstChild("NPCs")
    local cerydra = npcs and npcs:FindFirstChild("Cerydra")
    if not cerydra then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name == "Cerydra" and obj:IsA("Model") then
                cerydra = obj
                break
            end
        end
    end
    if cerydra then
        return cerydra, cerydra:FindFirstChildWhichIsA("ProximityPrompt", true)
    end
    return nil, nil
end

local function CleanupMinigameUI()
    pcall(function()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        if pg then
            local minigameGuis = {
                "Minigame_MemoryMatch", "Minigame_PickLock", "Minigame_Chess",
                "Minigame_CloverCatch", "Minigame_SimonClover", "Minigame_LuckyPulse",
                "MinigameHub", "CerydraDialogue"
            }
            for _, guiName in ipairs(minigameGuis) do
                local g = pg:FindFirstChild(guiName)
                if g then
                    local close = g:FindFirstChild("Close", true)
                    if close and close:IsA("GuiButton") then
                        pcall(firesignal, close.Activated)
                    end
                    pcall(function() g:Destroy() end)
                end
            end

            for _, g in ipairs(pg:GetChildren()) do
                if g:IsA("ScreenGui") then
                    local low = g.Name:lower()
                    if low:find("minigame") or low:find("cerydra") or low:find("arcade") then
                        pcall(function() g:Destroy() end)
                    else
                        local bd = g:FindFirstChild("Backdrop", true)
                        if bd and bd:IsA("GuiObject") and (low:find("game") or low:find("hub")) and g.Name ~= "Game" then
                            pcall(function() bd:Destroy() end)
                        end
                    end
                end
            end
        end
    end)

    pcall(function()
        local UIManager = require(RS:WaitForChild("Modules"):WaitForChild("UIManager"))
        if UIManager and UIManager.ExitBlocking then
            UIManager:ExitBlocking("Minigame")
        end
    end)

    ResetMinigameCamera()
end

-- Memory Match Solver
local function SolveMemoryMatchBackground(pg)
    task.spawn(function()
        SafeNotify("🎮 Memory Match", "Solving memory match...", 3, "Information")
        local gui = nil
        local deadline = os.clock() + 8
        while os.clock() < deadline do
            gui = pg:FindFirstChild("Minigame_MemoryMatch")
            if gui then break end
            task.wait(0.1)
        end
        if not gui then
            isDoingMinigame = false
            return
        end

        local function findGrid(root)
            for _, c in ipairs(root:GetDescendants()) do
                if c:IsA("UIGridLayout") then return c.Parent end
            end
            return nil
        end
        local content = findGrid(gui)
        if not content then
            isDoingMinigame = false
            return
        end

        local cards = {}
        for _, btn in ipairs(content:GetChildren()) do
            if btn:IsA("TextButton") and btn.Name:match("^Card%d+$") then
                local faceImg = btn:FindFirstChild("FaceImage", true)
                table.insert(cards, { btn = btn, faceImg = faceImg, id = nil, matched = false })
            end
        end
        table.sort(cards, function(a, b) return (a.btn.LayoutOrder or 0) < (b.btn.LayoutOrder or 0) end)

        if #cards < 2 then
            isDoingMinigame = false
            return
        end

        local map = {}
        for _, c in ipairs(cards) do
            local img = c.faceImg and c.faceImg.Image or ""
            if img ~= "" then
                c.id = img
                if not map[img] then map[img] = {} end
                table.insert(map[img], c)
            end
        end

        local pairsDone = 0
        for _, pairList in pairs(map) do
            if not isDoingMinigame or not Config.AutoMinigames then break end
            if #pairList >= 2 then
                pcall(firesignal, pairList[1].btn.Activated)
                task.wait(0.12)
                pcall(firesignal, pairList[2].btn.Activated)
                pairsDone = pairsDone + 1
                SafeNotify("🃏 Memory Match", "Matched pair " .. pairsDone .. "/8", 2, "Information")
                task.wait(0.35)
            end
        end

        task.wait(1.0)
        CleanupMinigameUI()
        SafeNotify("🏆 Memory Match WON!", "All pairs matched!", 4, "Reward")
        isDoingMinigame = false
    end)
end

-- Pick Lock Solver
local function SolvePickLockBackground(pg)
    task.spawn(function()
        SafeNotify("🗝️ PickLock", "Solving lock...", 3, "Information")
        local gui = nil
        local deadline = os.clock() + 8
        while os.clock() < deadline do
            gui = pg:FindFirstChild("Minigame_PickLock")
            if gui then break end
            task.wait(0.1)
        end
        if not gui then
            isDoingMinigame = false
            return
        end

        local cylinder = gui:FindFirstChild("Cylinder", true)
        local setPinBtn = gui:FindFirstChild("SetPin", true)
        if not cylinder or not setPinBtn then
            isDoingMinigame = false
            return
        end

        for pinIdx = 1, 5 do
            if not isDoingMinigame or not Config.AutoMinigames then break end
            local pin = cylinder:FindFirstChild("Pin" .. pinIdx)
            if not pin then break end
            local track = pin:FindFirstChild("Track")
            local sweet = track and track:FindFirstChild("Sweet")
            local pick = track and track:FindFirstChild("Pick")
            local status = pin:FindFirstChild("Status", true)

            local t0 = os.clock()
            while os.clock() - t0 < 3 do
                if status and status.Text == "LIVE" then break end
                task.wait(0.04)
            end

            local sweetCenter = 1 - sweet.Position.Y.Scale
            local sweetHalf = sweet.Size.Y.Scale / 2

            local pinDone = false
            local t1 = os.clock()
            while os.clock() - t1 < 6 and not pinDone do
                local pickPos = 1 - pick.Position.Y.Scale
                if math.abs(pickPos - sweetCenter) <= sweetHalf * 0.78 then
                    pcall(firesignal, setPinBtn.Activated)
                    pinDone = true
                    SafeNotify("🗝️ PickLock", "Pin " .. pinIdx .. "/5 set!", 2, "Information")
                    task.wait(0.35)
                    break
                end
                task.wait(0.01)
            end
        end

        task.wait(1.0)
        CleanupMinigameUI()
        SafeNotify("🏆 PickLock WON!", "All pins set!", 4, "Reward")
        isDoingMinigame = false
    end)
end

-- Hook Minigames:Start
task.spawn(function()
    if not R_MinigamesStart then
        task.wait(3)
        R_MinigamesStart = GetR("Minigames:Start")
    end
    if not R_MinigamesStart then return end

    R_MinigamesStart.OnClientEvent:Connect(function(gameId, seed, diffOrExtra)
        local pg = LocalPlayer:WaitForChild("PlayerGui", 5)
        if not pg then return end

        task.wait(0.2)

        if gameId == "Chess" or Config.MinigameOutcome:find("Resign") or Config.MinigameOutcome:find("Lose") then
            task.spawn(function()
                task.wait(0.4)
                local targetGuiName = (gameId == "Chess" and "Minigame_Chess")
                    or (gameId == "MemoryMatch" and "Minigame_MemoryMatch")
                    or (gameId == "PickLock" and "Minigame_PickLock")
                local g = targetGuiName and pg:FindFirstChild(targetGuiName)
                if g then
                    local resignBtn = g:FindFirstChild("Resign", true)
                    if resignBtn then pcall(firesignal, resignBtn.Activated) end
                end
                if R_MinigamesCancel then
                    pcall(function() R_MinigamesCancel:FireServer(gameId) end)
                end
                task.wait(0.5)
                CleanupMinigameUI()
                isDoingMinigame = false
                SafeNotify("Minigame", "Resigned " .. gameId .. " for quest credit!", 3, "Reward")
            end)
            return
        end

        if gameId == "MemoryMatch" then
            SolveMemoryMatchBackground(pg)
        elseif gameId == "PickLock" then
            SolvePickLockBackground(pg)
        end
    end)
end)

local function ExecuteSingleMinigame(gameName, outcome)
    if isDoingMinigame then return end
    isDoingMinigame = true

    task.spawn(function()
        local gTarget = gameName or Config.MinigameSelected
        local internalName = (gTarget == "Chess" and "Chess")
            or (gTarget == "PickLock" and "PickLock")
            or "MemoryMatch"

        SafeNotify("Minigame", "Starting " .. gTarget .. "...", 3, "Information")

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local origCF = hrp and hrp.CFrame
        local pg = LocalPlayer:WaitForChild("PlayerGui", 5)

        if internalName == "Chess" then
            local cerydra, cPrompt = FindCerydraPrompt()
            if cerydra and hrp then
                hrp.CFrame = cerydra:GetPivot() * CFrame.new(0, 2, 4)
                task.wait(0.3)
            end

            local be = Instance.new("BindableEvent")
            be.Name = "CerydraStartChess"
            be.Parent = RS
            task.wait(0.15)
            be:Destroy()

            if cPrompt then pcall(fireproximityprompt, cPrompt) end

            local dia = pg and pg:WaitForChild("CerydraDialogue", 2)
            if dia then
                local optBtn = dia:FindFirstChild(Config.MinigameDifficulty, true) or dia:FindFirstChild("Easy", true)
                if optBtn then pcall(firesignal, optBtn.Activated) end
            end
        else
            local arcade, aPrompt = FindArcadePrompt()
            if arcade and aPrompt and hrp then
                hrp.CFrame = arcade:GetPivot() * CFrame.new(0, 1, 3.5)
                task.wait(0.3)
                pcall(fireproximityprompt, aPrompt)
            end

            local hub = pg and pg:WaitForChild("MinigameHub", 2)
            if hub then
                local btn = hub:FindFirstChild(internalName, true)
                if btn and btn:IsA("GuiButton") then
                    pcall(firesignal, btn.Activated)
                end
            end
        end

        -- Resilient Watchdog: Wait while game is active, but cancel cleanly after 25s if stuck
        local t0 = os.clock()
        while isDoingMinigame and (os.clock() - t0 < 25) and Config.AutoMinigames do
            task.wait(0.5)
            local activeGui = pg and (pg:FindFirstChild("Minigame_" .. internalName) or pg:FindFirstChild("MinigameHub") or pg:FindFirstChild("CerydraDialogue"))
            if not activeGui and (os.clock() - t0 >= 3) and not isDoingMinigame then
                break
            end
        end

        -- If timed out or stuck, cancel on server to reset session state cleanly
        if isDoingMinigame then
            if R_MinigamesCancel then
                pcall(function() R_MinigamesCancel:FireServer(internalName) end)
            end
            task.wait(0.3)
            CleanupMinigameUI()
            isDoingMinigame = false
        end

        if origCF and hrp and (not Config.AutoFish) then
            hrp.CFrame = origCF
        end

        lastMinigameTime = os.clock()
    end)
end

-- ==================== AUTO MINIGAMES LOOP ====================
local function StartMinigamesLoop()
    if isMinigameLoopRunning then return end
    isMinigameLoopRunning = true

    task.spawn(function()
        while Config.AutoMinigames do
            local attrCd = tonumber(LocalPlayer:GetAttribute("MinigameCooldownUntil") or 0) or 0
            local cooldown = math.max(attrCd, serverMinigameCooldownUntil)
            local nowServer = workspace:GetServerTimeNow()

            if cooldown > nowServer then
                local waitSec = math.ceil(cooldown - nowServer) + 1
                SafeNotify("Minigames", "Cooldown: " .. waitSec .. "s remaining...", 3, "Information")
                local t0 = os.clock()
                while (os.clock() - t0 < waitSec) and Config.AutoMinigames do
                    task.wait(1)
                    attrCd = tonumber(LocalPlayer:GetAttribute("MinigameCooldownUntil") or 0) or 0
                    cooldown = math.max(attrCd, serverMinigameCooldownUntil)
                    nowServer = workspace:GetServerTimeNow()
                    if cooldown <= nowServer then break end
                end
                if not Config.AutoMinigames then break end
            end

            if not isDoingMinigame then
                ExecuteSingleMinigame(Config.MinigameSelected, Config.MinigameOutcome)
                local waitLoopStart = os.clock()
                while isDoingMinigame and Config.AutoMinigames and (os.clock() - waitLoopStart < 30) do
                    task.wait(0.5)
                end
                if isDoingMinigame then
                    isDoingMinigame = false
                end
            end

            task.wait(3.0)
        end

        isMinigameLoopRunning = false
    end)
end

-- ==================== SUMMER / ROBIN QUESTS HANDLER ====================
local function ProcessRobinSummerQuests()
    if not R_RobinGetBoard then return end

    task.spawn(function()
        local ok, boardData = pcall(function() return R_RobinGetBoard:InvokeServer() end)
        if not ok or type(boardData) ~= "table" or not boardData.quests then return end

        local allFishDone = true
        local allMiniDone = true
        local totalFishQuests = 0
        local totalMiniQuests = 0

        for _, quest in ipairs(boardData.quests) do
            local isDone = quest.isComplete or quest.isClaimed

            if quest.questType == "fish" then
                totalFishQuests = totalFishQuests + 1
                if not isDone then allFishDone = false end
            elseif quest.questType == "minigames" then
                totalMiniQuests = totalMiniQuests + 1
                if not isDone then allMiniDone = false end
            end

            if not quest.isAccepted and not quest.isComplete and not quest.isClaimed and R_RobinAccept then
                pcall(function() R_RobinAccept:FireServer(quest.id) end)
                task.wait(0.25)
            end

            local isReadyToClaim = (quest.isComplete or (quest.progress and quest.target and quest.progress >= quest.target))
            if isReadyToClaim and not quest.isClaimed and R_RobinClaim then
                pcall(function() R_RobinClaim:FireServer(quest.id) end)
                SafeNotify("Summer Quest", "Claimed: " .. (quest.name or "Robin Quest") .. "!", 3, "Reward")
                task.wait(0.3)
            end

            if Config.AutoRobinDrinkPots and quest.questType == "usePotion" and quest.potionName and not quest.isComplete and not quest.isClaimed then
                local lastDrank = robinPotsDrank[quest.id] or 0
                if (os.clock() - lastDrank > 12) and (quest.progress < quest.target) then
                    robinPotsDrank[quest.id] = os.clock()
                    if R_PotionDrink then
                        pcall(function() R_PotionDrink:FireServer(quest.potionName, 1) end)
                        SafeNotify("Summer Quest", "Drank 1x " .. quest.potionName .. " for " .. quest.name, 3, "Information")
                        task.wait(0.4)
                    end
                end
            end
        end

        if Config.StopFishOnSummerDone and totalFishQuests > 0 and allFishDone and Config.AutoFish then
            Config.AutoFish = false
            LocalPlayer:SetAttribute("AutoFishingEnabled", false)
            SafeNotify("Summer Quests", "All Fishing Quests finished! Auto Fish stopped.", 5, "Reward")
        end

        if Config.StopMiniOnSummerDone and totalMiniQuests > 0 and allMiniDone and Config.AutoMinigames then
            Config.AutoMinigames = false
            SafeNotify("Summer Quests", "All Minigame Quests finished! Auto Minigames stopped.", 5, "Reward")
        end
    end)
end

-- ==================== CORE ACTIONS ====================

-- ==================== SMART POTION AUTO-COLLECTOR ====================
local isCollectingPotions = false

local function CollectAllGroundPotions()
    if isCollectingPotions or isDoingMinigame or isDoingNeco then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local targetPots = {}
    for _, obj in ipairs(workspace:GetChildren()) do
        if obj:IsA("Model") then
            local low = obj.Name:lower()
            if low:find("pot") or low:find("potion") then
                local pp = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                local part = pp and pp.Parent
                if pp and pp.Enabled and part and part:IsA("BasePart") then
                    table.insert(targetPots, { model = obj, prompt = pp, part = part, name = obj.Name })
                end
            end
        end
    end

    if #targetPots == 0 then return end
    isCollectingPotions = true

    task.spawn(function()
        local origCF = hrp.CFrame
        local collectedCount = 0

        for _, item in ipairs(targetPots) do
            if not Config.AutoCollect then break end
            if item.prompt and item.prompt.Enabled and item.part and item.part.Parent then
                hrp.CFrame = item.part.CFrame * CFrame.new(0, 1.5, 0)
                task.wait(0.14)
                pcall(fireproximityprompt, item.prompt)
                collectedCount = collectedCount + 1
                task.wait(0.2)
            end
        end

        if origCF and hrp and hrp.Parent then
            if Config.AutoFish then
                local safeCF = GetActiveFishingDockData()
                hrp.CFrame = safeCF
            elseif Config.AutoTPToActiveCandle then
                local candleCF = GetBestActiveCandleCFrame()
                if candleCF then hrp.CFrame = candleCF else hrp.CFrame = origCF end
            else
                hrp.CFrame = origCF
            end
        end

        if collectedCount > 0 then
            SafeNotify("Auto Collect", "Collected " .. collectedCount .. " potions from ground!", 3, "Reward")
        end
        isCollectingPotions = false
    end)
end

-- Fast listener for newly spawned ground potions
if R_PotionSpawn then
    R_PotionSpawn.OnClientEvent:Connect(function(potionId, potionName, pos)
        if not Config.AutoCollect then return end
        task.delay(0.6, function()
            if Config.AutoCollect and not isCollectingPotions then
                CollectAllGroundPotions()
            end
        end)
    end)
end

-- Dedicated continuous background loop for auto-collecting potions
task.spawn(function()
    while task.wait(3.5) do
        if Config.AutoCollect and not isCollectingPotions and not isDoingMinigame and not isDoingNeco then
            CollectAllGroundPotions()
        end
    end
end)

local function DoObby()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local orb = workspace:FindFirstChild("Part36")
    if not orb then return end
    local pp = orb:FindFirstChildWhichIsA("ProximityPrompt", true)
    if not pp then return end
    local holdDur = pp.HoldDuration or 0
    hrp.CFrame = orb.CFrame * CFrame.new(0, 3, 2)
    task.wait(0.25)
    pcall(fireproximityprompt, pp)
    if holdDur > 0 then task.wait(holdDur + 0.4) end
    lastObbyTime = os.clock()
end

local function CraftCandlesNow()
    if not R_CraftAddAll or not R_CraftComplete then return end
    if #Config.CandlesToCraft == 0 then return end
    task.spawn(function()
        for _, candleName in ipairs(Config.CandlesToCraft) do
            pcall(function() R_CraftAddAll:InvokeServer("itemCrafting", candleName, 1) end)
            task.wait(0.3)
            pcall(function() R_CraftComplete:InvokeServer("itemCrafting", candleName, 1) end)
            task.wait(0.5)
        end
        lastCandleCraftTime = os.clock()
    end)
end

local function PlaceCandlesNow()
    if not R_CandlePlace then SafeNotify("Candles", "Candle remote not found!", 3, "Warning") return end
    if #Config.CandlesToPlace == 0 then return end
    task.spawn(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        if Config.AutoFish and hrp then
            local safeCF = GetActiveFishingDockData()
            hrp.CFrame = safeCF
            task.wait(0.25)
        end

        for _, candleName in ipairs(Config.CandlesToPlace) do
            pcall(function() R_CandlePlace:FireServer(candleName) end)
            task.wait(0.4)
        end
        lastCandlePlaceTime = os.clock()
        SafeNotify("Candles", "Candle placed under you!", 3, "Reward")
    end)
end

local function ClaimCauldronNow()
    local map = workspace:FindFirstChild("Map")
    local i2 = map and map:FindFirstChild("Island2")
    local factory = i2 and i2:FindFirstChild("Factory")
    local cauldron = factory and factory:FindFirstChild("Cauldron")
    local prompt = cauldron and cauldron:FindFirstChildWhichIsA("ProximityPrompt", true)

    if not prompt or not prompt.Enabled then return end

    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local origCF = hrp.CFrame
    hrp.CFrame = cauldron:GetPivot() * CFrame.new(0, 3, 5)
    task.wait(0.3)
    pcall(fireproximityprompt, prompt)
    task.wait(0.3)

    if not Config.AutoFish and origCF then
        hrp.CFrame = origCF
    end
    SafeNotify("Cauldron", "Collected potions from Cauldron!", 3, "Reward")
    lastCauldronCheck = os.clock()
end

local function StartNecoArcSecret()
    if isDoingNeco then SafeNotify("Neco Arc", "Already doing Neco Arc ritual!", 3, "Warning") return end
    isDoingNeco = true

    task.spawn(function()
        local cave = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Island2") and workspace.Map.Island2:FindFirstChild("Cave")
        local necoPart = cave and cave:FindFirstChild("NecoArc") and cave.NecoArc:FindFirstChild("Part")
        local prompt = necoPart and necoPart:FindFirstChildWhichIsA("ProximityPrompt")

        if not prompt then
            SafeNotify("Neco Arc", "Neco Arc prompt not found behind waterfall!", 4, "Warning")
            isDoingNeco = false
            return
        end

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = necoPart.CFrame * CFrame.new(0, 2, 3)
            task.wait(0.5)
        end

        SafeNotify("Neco Arc", "Starting 10-Minute 'Endure' Hold...", 5, "Information")
        pcall(fireproximityprompt, prompt)
        pcall(function() prompt:InputHoldBegin() end)

        local startTime = os.clock()
        while isDoingNeco and (os.clock() - startTime < 605) do
            task.wait(1)
            local elapsed = math.floor(os.clock() - startTime)
            if elapsed % 60 == 0 and elapsed > 0 then
                SafeNotify("Neco Arc", "Enduring: " .. math.floor(elapsed / 60) .. "/10 minutes...", 3, "Information")
            end
        end

        pcall(function() prompt:InputHoldEnd() end)
        isDoingNeco = false
        SafeNotify("Neco Arc", "Finished Neco Arc secret aura ritual!", 6, "Reward")
    end)
end

-- Throttled Battle Pass claimer (honors 5/60s rate limit)
local function ClaimBattlePassNow()
    if not R_BPClaimAll or not R_BPClaimAll:IsA("RemoteFunction") then return end
    if os.clock() - lastBPClaimTime < 20 then return end
    lastBPClaimTime = os.clock()

    task.spawn(function()
        local ok, res = pcall(function() return R_BPClaimAll:InvokeServer() end)
        if ok and type(res) == "table" and res.success then
            SafeNotify("Battle Pass", res.message or "Battle pass rewards claimed!", 3, "Reward")
        end
    end)
end

-- ==================== HALLOWEEN AUTOMATION FUNCTIONS ====================
local lastHalloweenBPClaimTime = 0
local function ClaimHalloweenBattlePassNow()
    if not R_HalloweenBPClaimAll or not R_HalloweenBPClaimAll:IsA("RemoteFunction") then return end
    if os.clock() - lastHalloweenBPClaimTime < 15 then return end
    lastHalloweenBPClaimTime = os.clock()

    task.spawn(function()
        local ok, res = pcall(function() return R_HalloweenBPClaimAll:InvokeServer() end)
        if ok and type(res) == "table" and res.success then
            SafeNotify("Halloween Pass", res.message or "Halloween Pass rewards claimed!", 3, "Reward")
        end
    end)
end

local lastHalloweenBountyTime = 0
local function ProcessHalloweenBounties()
    if not R_HalloweenQuestBoard or not R_HalloweenQuestBoard:IsA("RemoteFunction") then return end
    if os.clock() - lastHalloweenBountyTime < 8 then return end
    lastHalloweenBountyTime = os.clock()

    task.spawn(function()
        local ok, boardData = pcall(function() return R_HalloweenQuestBoard:InvokeServer() end)
        if not ok or type(boardData) ~= "table" or not boardData.quests then return end

        local claimedCount = 0
        local acceptedCount = 0
        for _, q in ipairs(boardData.quests) do
            if q.isComplete and not q.isClaimed and R_HalloweenQuestClaim then
                pcall(function() R_HalloweenQuestClaim:FireServer(q.id) end)
                claimedCount = claimedCount + 1
                task.wait(0.2)
            end
            if not q.isAccepted and R_HalloweenQuestAccept then
                pcall(function() R_HalloweenQuestAccept:FireServer(q.id) end)
                acceptedCount = acceptedCount + 1
                task.wait(0.2)
            end
        end
        if claimedCount > 0 then
            SafeNotify("Bounties", "Claimed " .. claimedCount .. " completed Horseman bounties!", 3, "Reward")
        end
        if acceptedCount > 0 then
            SafeNotify("Bounties", "Accepted " .. acceptedCount .. " new Horseman bounties!", 3, "Information")
        end
    end)
end

local isTrickOrTreatRunning = false
local function RunTrickOrTreatStep()
    if isTrickOrTreatRunning then return end
    local area = workspace:FindFirstChild("HalloweenIslandArea")
    if not area then return end

    local lp = LocalPlayer
    local char = lp.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local isActive = lp:GetAttribute("HalloweenEventActive") == true
    local cooldownUntil = lp:GetAttribute("HalloweenEventCooldownUntil") or 0
    local now = os.time()

    if not isActive then
        if now >= cooldownUntil then
            local startNPC = area:FindFirstChild("NPCs") and area.NPCs:FindFirstChild("EventStartNPC")
            local startHrp = startNPC and startNPC:FindFirstChild("HumanoidRootPart")
            local prompt = startHrp and startHrp:FindFirstChild("HalloweenEventStartPrompt")
            if prompt and prompt.Enabled then
                isTrickOrTreatRunning = true
                hrp.CFrame = startHrp.CFrame + Vector3.new(0, 0, 3)
                task.wait(0.25)
                pcall(fireproximityprompt, prompt, 1)
                task.wait(0.5)
                isTrickOrTreatRunning = false
            end
        end
        return
    end

    isTrickOrTreatRunning = true
    task.spawn(function()
        local startTime = os.clock()
        while lp:GetAttribute("HalloweenEventActive") and (os.clock() - startTime < 130) do
            local char2 = lp.Character
            local hrp2 = char2 and char2:FindFirstChild("HumanoidRootPart")
            if not hrp2 then break end

            local targetPrompt = nil
            for _, d in ipairs(area:GetDescendants()) do
                if d:IsA("ProximityPrompt") and d.Name == "HalloweenQuestTargetPrompt" and d.Enabled then
                    targetPrompt = d
                    break
                end
            end

            local deliverPrompt = nil
            if not targetPrompt and area:FindFirstChild("NPCs") and area.NPCs:FindFirstChild("EventNPCs") then
                for i = 1, 6 do
                    local houseNpc = area.NPCs.EventNPCs:FindFirstChild(tostring(i))
                    local hHrp = houseNpc and houseNpc:FindFirstChild("HumanoidRootPart")
                    local p = hHrp and hHrp:FindFirstChild("HalloweenQuestPrompt")
                    if p and p.Enabled and p.ActionText:lower():find("deliver") then
                        deliverPrompt = p
                        break
                    end
                end
            end

            local housePrompt = nil
            if not targetPrompt and not deliverPrompt and area:FindFirstChild("NPCs") and area.NPCs:FindFirstChild("EventNPCs") then
                for i = 1, 6 do
                    local houseNpc = area.NPCs.EventNPCs:FindFirstChild(tostring(i))
                    local hHrp = houseNpc and houseNpc:FindFirstChild("HumanoidRootPart")
                    local p = hHrp and hHrp:FindFirstChild("HalloweenQuestPrompt")
                    if p and p.Enabled then
                        housePrompt = p
                        break
                    end
                end
            end

            local chosenPrompt = targetPrompt or deliverPrompt or housePrompt
            if not chosenPrompt then
                task.wait(0.4)
            else
                local targetPart = chosenPrompt.Parent
                if targetPart:IsA("Model") then
                    targetPart = targetPart.PrimaryPart or targetPart:FindFirstChildWhichIsA("BasePart")
                end
                if targetPart and targetPart:IsA("BasePart") then
                    hrp2.CFrame = targetPart.CFrame + Vector3.new(0, 0, 2)
                    task.wait(0.2)
                    pcall(fireproximityprompt, chosenPrompt, 1)
                    task.wait(0.35)
                else
                    task.wait(0.4)
                end
            end
        end
        isTrickOrTreatRunning = false
    end)
end

local function BuyFromHalloweenShop(itemName)
    if not R_HalloweenShopBuy then SafeNotify("Shop", "Halloween shop remote not found!", 3, "Warning") return end
    task.spawn(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local origCF = hrp and hrp.CFrame
        if hrp then
            hrp.CFrame = CFrame.new(1383.25, 8797.29, 24616.56)
            task.wait(0.25)
        end
        pcall(function() R_HalloweenShopBuy:FireServer(itemName) end)
        task.wait(0.3)
        if hrp and origCF and not Config.AutoTrickOrTreat then
            hrp.CFrame = origCF
        end
        SafeNotify("Halloween Shop", "Purchased " .. itemName .. "!", 3, "Reward")
    end)
end

local function BuyFromHorsemanShop(itemName)
    if not R_HorsemanShopBuy then SafeNotify("Shop", "Horseman shop remote not found!", 3, "Warning") return end
    task.spawn(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local origCF = hrp and hrp.CFrame
        if hrp then
            hrp.CFrame = CFrame.new(1413.25, 8796.28, 24624.56)
            task.wait(0.25)
        end
        pcall(function() R_HorsemanShopBuy:FireServer(itemName) end)
        task.wait(0.3)
        if hrp and origCF and not Config.AutoTrickOrTreat then
            hrp.CFrame = origCF
        end
        SafeNotify("Horseman Shop", "Purchased " .. itemName .. "!", 3, "Reward")
    end)
end

local function CraftItemNow(recipeName)
    if not R_CraftAddAll or not R_CraftComplete then
        SafeNotify("Crafting", "Crafting remotes not found!", 3, "Warning")
        return
    end
    task.spawn(function()
        pcall(function() R_CraftAddAll:InvokeServer("itemCrafting", recipeName, 1) end)
        task.wait(0.35)
        local ok, res = pcall(function() return R_CraftComplete:InvokeServer("itemCrafting", recipeName, 1) end)
        if ok and res then
            SafeNotify("Crafting", "Crafted " .. recipeName .. "!", 4, "Reward")
        else
            SafeNotify("Crafting", "Craft attempted for " .. recipeName, 3, "Information")
        end
    end)
end

local function OpenSpecificCrate(crateName)
    if isOpeningCrates then return end
    if not R_CrateOpen then return end
    isOpeningCrates = true
    task.spawn(function()
        local invData = nil
        if R_PotionGetInventory and R_PotionGetInventory:IsA("RemoteFunction") then
            local ok, inv = pcall(function() return R_PotionGetInventory:InvokeServer() end)
            if ok and type(inv) == "table" then invData = inv end
        end
        local remaining = invData and tonumber(invData[crateName]) or 0
        if remaining > 0 then
            while remaining > 0 do
                local batchSize = math.min(remaining, 50)
                pcall(function() R_CrateOpen:FireServer(crateName, batchSize) end)
                remaining = remaining - batchSize
                task.wait(0.6)
            end
            SafeNotify("Crates", "Opened " .. crateName .. "s!", 3, "Reward")
        end
        lastCrateOpenTime = os.clock()
        isOpeningCrates = false
    end)
end

local function DrinkPotionsNow()
    if not R_PotionDrink then SafeNotify("Potions", "Potion remote not found!", 3, "Warning") return end
    if #Config.PotionsToDrink == 0 then return end
    task.spawn(function()
        for _, potionName in ipairs(Config.PotionsToDrink) do
            pcall(function() R_PotionDrink:FireServer(potionName, 1) end)
            task.wait(0.35)
        end
        lastPotionDrinkTime = os.clock()
        SafeNotify("Potions", "Potions drank!", 3, "Information")
    end)
end

local function UseCallersNow()
    if not R_BiomeUseCaller then SafeNotify("Callers", "Caller remote not found!", 3, "Warning") return end
    if #Config.CallersToUse == 0 then return end
    task.spawn(function()
        for _, callerName in ipairs(Config.CallersToUse) do
            pcall(function() R_BiomeUseCaller:FireServer(callerName) end)
            task.wait(0.5)
        end
        lastCallerTime = os.clock()
        SafeNotify("Callers", "Callers used!", 3, "Information")
    end)
end

local function OpenCratesNow()
    if isOpeningCrates then return end
    if not R_CrateOpen then SafeNotify("Crates", "Crate remote not found!", 3, "Warning") return end
    if #Config.CratesToOpen == 0 then SafeNotify("Crates", "No crates selected!", 3, "Warning") return end

    isOpeningCrates = true
    task.spawn(function()
        local totalOpenedCount = 0
        local invData = nil

        if R_PotionGetInventory and R_PotionGetInventory:IsA("RemoteFunction") then
            local ok, inv = pcall(function() return R_PotionGetInventory:InvokeServer() end)
            if ok and type(inv) == "table" then invData = inv end
        end

        for _, crateName in ipairs(Config.CratesToOpen) do
            local remaining = 0
            if invData then
                remaining = tonumber(invData[crateName]) or 0
            else
                remaining = 100
            end

            while remaining > 0 do
                local batchSize = math.min(remaining, 100)
                pcall(function() R_CrateOpen:FireServer(crateName, batchSize) end)
                remaining = remaining - batchSize
                totalOpenedCount = totalOpenedCount + batchSize
                task.wait(0.6)
            end
        end

        lastCrateOpenTime = os.clock()
        isOpeningCrates = false
        if totalOpenedCount > 0 then
            SafeNotify("Crates", "Opened " .. totalOpenedCount .. " crates!", 3, "Reward")
        end
    end)
end

-- ==================== SERVER HOPPING ====================
local function ServerHop(targetBiomes)
    SafeNotify("Server Hop", "Hopping to a new server...", 3, "Information")

    if Config.AutoReExecOnHop then QueueScriptExecution() end

    if targetBiomes and #targetBiomes > 0 then
        SaveHopState({ searching = true, biomes = targetBiomes, timestamp = os.time() })
    end

    local success, response = pcall(function()
        return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
    end)
    if success and response and response.data then
        for _, server in ipairs(response.data) do
            if server.playing and server.playing < server.maxPlayers and server.id ~= game.JobId then
                SafeNotify("Server Hop", "Teleporting...", 3, "Information")
                TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                return
            end
        end
    end
    SafeNotify("Server Hop", "Trying again...", 3, "Information")
    pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)
end

local function HopForBiome(targetBiomes)
    if #targetBiomes == 0 then SafeNotify("Biome Hop", "No biomes selected!", 3, "Warning") return end
    Config.IsSearchingBiome = true
    ServerHop(targetBiomes)
end

-- ==================== UNIVERSAL TELEPORT HELPER ====================
local function FindNPCInWorkspace(nameList)
    if not nameList then return nil end
    local searchRoots = {
        workspace,
        workspace:FindFirstChild("NPC"),
        workspace:FindFirstChild("NPCs"),
        workspace:FindFirstChild("NPCMODELS"),
        workspace:FindFirstChild("Characters"),
        workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Island2") and workspace.Map.Island2:FindFirstChild("NPCs"),
        workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Island2") and workspace.Map.Island2:FindFirstChild("PlazaStuff") and workspace.Map.Island2.PlazaStuff:FindFirstChild("Structures"),
        workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Island2") and workspace.Map.Island2:FindFirstChild("Factory"),
        workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Island2") and workspace.Map.Island2:FindFirstChild("Cave"),
    }
    for _, root in ipairs(searchRoots) do
        if root then
            for _, npcName in ipairs(nameList) do
                local found = root:FindFirstChild(npcName)
                if found then return found end
            end
        end
    end
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("BasePart") then
            local lower = obj.Name:lower()
            for _, npcName in ipairs(nameList) do
                if lower == npcName:lower() then return obj end
            end
        end
    end
    return nil
end

local function TeleportToNPCOrCoord(npcEntry)
    local char = LocalPlayer.Character
    if not char then SafeNotify("Teleport", "No character!", 3, "Warning") return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then SafeNotify("Teleport", "No HumanoidRootPart!", 3, "Warning") return end

    if npcEntry.names then
        local liveModel = FindNPCInWorkspace(npcEntry.names)
        if liveModel then
            local primary = liveModel:IsA("BasePart") and liveModel or liveModel.PrimaryPart or liveModel:FindFirstChild("HumanoidRootPart") or liveModel:FindFirstChildWhichIsA("BasePart")
            if primary then
                hrp.CFrame = primary.CFrame * CFrame.new(0, 3, 4)
                SafeNotify("Teleport", "Teleported to " .. npcEntry.label, 3, "Reward")
                return
            end
        end
    end

    if npcEntry.pos then
        hrp.CFrame = CFrame.new(npcEntry.pos + Vector3.new(0, 3, 4))
        SafeNotify("Teleport", "Teleported to " .. npcEntry.label, 3, "Reward")
        return
    end

    SafeNotify("Teleport", npcEntry.label .. " not found!", 4, "Warning")
end

-- ==================== UI WINDOW & TABS ====================
local Window = Rayfield:CreateWindow({
    name          = "MID HUB",
    subtitle      = "RNG Suite (SEASON 3 / JOJOS UPDATED)",
    configuration = {
        autoSave  = true,
        autoLoad  = true,
        fileName  = "MidHub_Config",
    },
})

do
-- Tab 1: Automation
local TabAuto = Window:CreateTab({ name = "Automation", icon = 93364949241311 })

TabAuto:CreateSection("Farming & Activities")

TabAuto:CreateToggle({
    name        = "Auto Fish",
    description = "Automatically fishes for you on safe dock",
    flag        = "AutoFish",
    callback    = function(v)
        Config.AutoFish = v
        LocalPlayer:SetAttribute("AutoFishingEnabled", v)
        if v then
            task.spawn(function()
                local safeCF = GetActiveFishingDockData()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.CFrame = safeCF end
                SafeNotify("Auto Fish", "Starting in 3s...", 3, "Information")
                fishingStartTime = os.clock() + 3
            end)
        end
    end,
})

TabAuto:CreateDropdown({
    name        = "Fishing Dock Location",
    description = "Choose which island dock to fish from",
    options     = { "Auto-Detect (Nearest)", "Island 1 Dock", "Island 2 Dock" },
    default     = "Auto-Detect (Nearest)",
    flag        = "FishingDockChoiceDropdown",
    callback    = function(val)
        Config.FishingDockChoice = val
        if Config.AutoFish then
            task.spawn(function()
                local safeCF = GetActiveFishingDockData()
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp and safeCF then
                    hrp.CFrame = safeCF
                    SafeNotify("Auto Fish", "Switched to " .. val, 2, "Information")
                end
            end)
        end
    end,
})

TabAuto:CreateToggle({
    name        = "Stop Fish When Summer Quests Done",
    description = "Stops auto-fishing once all Robin fishing quests finish",
    flag        = "StopFishOnSummerDone",
    default     = false,
    callback    = function(v) Config.StopFishOnSummerDone = v end,
})

TabAuto:CreateToggle({
    name        = "Auto Collect Potions",
    description = "Picks up potions from the ground",
    flag        = "AutoCollect",
    callback    = function(v) Config.AutoCollect = v; if v then task.spawn(CollectAllGroundPotions) end end,
})

TabAuto:CreateToggle({
    name        = "Auto Obby",
    description = "Completes the obby every 30 seconds",
    flag        = "AutoObby",
    callback    = function(v)
        Config.AutoObby = v
        if v and not Config.AutoFish then task.spawn(function() DoObby() end) end
    end,
})

TabAuto:CreateToggle({
    name        = "Auto Sell Fish",
    description = "Sells your fish automatically",
    flag        = "AutoSellFish",
    callback    = function(v)
        Config.AutoSellFish = v
        LocalPlayer:SetAttribute("AutoSellFishEnabled", v)
    end,
})

TabAuto:CreateToggle({
    name        = "Auto Craft (General)",
    description = "Auto crafts items",
    flag        = "AutoCraft",
    callback    = function(v) Config.AutoCraft = v end,
})

TabAuto:CreateToggle({
    name        = "Auto Upgrade Storage",
    description = "Upgrades inventory space when affordable",
    flag        = "AutoUpgradeStorage",
    callback    = function(v) Config.AutoUpgradeStorage = v end,
})

TabAuto:CreateSection("Minigames")

local OutcomeDropdown = nil

TabAuto:CreateDropdown({
    name        = "Select Minigame",
    description = "Choose which minigame to play",
    options     = { "Memory Match", "PickLock", "Chess" },
    default     = "Memory Match",
    flag        = "MinigameSelectedDropdown",
    callback    = function(val)
        Config.MinigameSelected = val
        if val == "Chess" then
            Config.MinigameOutcome = "Resign / Lose"
            if OutcomeDropdown and OutcomeDropdown.Set then
                pcall(function() OutcomeDropdown:Set({ "Resign / Lose" }) end)
            end
        end
    end,
})

OutcomeDropdown = TabAuto:CreateDropdown({
    name        = "Match Outcome",
    description = "Choose to win or resign for quests (Chess is resign-only)",
    options     = { "Win", "Resign / Lose" },
    default     = "Win",
    flag        = "MinigameOutcomeDropdown",
    callback    = function(val)
        if Config.MinigameSelected == "Chess" then
            Config.MinigameOutcome = "Resign / Lose"
            if OutcomeDropdown and OutcomeDropdown.Set then
                pcall(function() OutcomeDropdown:Set({ "Resign / Lose" }) end)
            end
        else
            Config.MinigameOutcome = val
        end
    end,
})

TabAuto:CreateDropdown({
    name        = "Difficulty",
    description = "Choose minigame difficulty",
    options     = { "Easy", "Medium", "Hard" },
    default     = "Easy",
    flag        = "MinigameDifficultyDropdown",
    callback    = function(val) Config.MinigameDifficulty = val end,
})

TabAuto:CreateToggle({
    name        = "Auto Minigames",
    description = "Automatically plays minigames with clean camera restore",
    flag        = "AutoMinigames",
    callback    = function(v)
        Config.AutoMinigames = v
        if v then
            StartMinigamesLoop()
        else
            CleanupMinigameUI()
        end
    end,
})

TabAuto:CreateToggle({
    name        = "Stop Minigames When Summer Quests Done",
    description = "Stops auto minigames once all Robin arcade quests finish",
    flag        = "StopMiniOnSummerDone",
    default     = false,
    callback    = function(v) Config.StopMiniOnSummerDone = v end,
})

TabAuto:CreateButton({
    name        = "Play Selected Game Now",
    description = "Plays the selected minigame once",
    callback    = function() ExecuteSingleMinigame(Config.MinigameSelected, Config.MinigameOutcome) end,
})

TabAuto:CreateButton({
    name        = "Emergency Fix / Reset Camera",
    description = "Restores camera and closes any stuck minigame screens",
    callback    = function()
        CleanupMinigameUI()
        SafeNotify("Minigame Fix", "Camera, HUD, and UI reset!", 3, "Reward")
    end,
})
end

do
-- ==================== TAB: 🎃 HALLOWEEN EVENT ====================
local TabHalloween = Window:CreateTab({ name = "🎃 Halloween", icon = 10734919950 })

TabHalloween:CreateSection("🍬 Trick-or-Treat Island Event")

TabHalloween:CreateToggle({
    name        = "Auto Trick-or-Treat Event",
    description = "Automatically talks to Guide when cooldown expires, speed-clears all 6 houses & items in seconds",
    flag        = "AutoTrickOrTreat",
    default     = false,
    callback    = function(v)
        Config.AutoTrickOrTreat = v
        if v then RunTrickOrTreatStep() end
    end,
})

TabHalloween:CreateButton({
    name        = "Run Trick-or-Treat Now",
    description = "Starts event or immediately clears active house quests",
    callback    = function()
        RunTrickOrTreatStep()
        SafeNotify("Halloween Event", "Starting Trick-or-Treat run...", 3, "Information")
    end,
})

TabHalloween:CreateSection("🎟️ Halloween Battle Pass (30 Tiers)")

TabHalloween:CreateToggle({
    name        = "Auto Claim Halloween Pass",
    description = "Automatically claims unlocked tiers for the Huzzoween Event Pass",
    flag        = "AutoHalloweenBP",
    default     = false,
    callback    = function(v)
        Config.AutoHalloweenBP = v
        if v then ClaimHalloweenBattlePassNow() end
    end,
})

TabHalloween:CreateButton({
    name        = "Claim Halloween Pass Now",
    description = "Claims all ready tiers in the Halloween Battle Pass",
    callback    = function() ClaimHalloweenBattlePassNow() end,
})

TabHalloween:CreateSection("💀 Headless Horseman Bounties")

TabHalloween:CreateToggle({
    name        = "Auto Bounties (Accept & Claim)",
    description = "Automatically accepts all 20 bounties and claims completed ones for Candy & Crates",
    flag        = "AutoHalloweenBounties",
    default     = false,
    callback    = function(v)
        Config.AutoHalloweenBounties = v
        if v then ProcessHalloweenBounties() end
    end,
})

TabHalloween:CreateButton({
    name        = "Process Bounties Now",
    description = "Accepts unaccepted bounties and claims completed ones immediately",
    callback    = function() ProcessHalloweenBounties() end,
})

TabHalloween:CreateSection("📦 Halloween Crates & Items")

TabHalloween:CreateToggle({
    name        = "Auto Open Halloween Crates",
    description = "Continuously opens Halloween Crates in your inventory",
    flag        = "AutoOpenHalloweenCrates",
    default     = false,
    callback    = function(v)
        Config.AutoOpenHalloweenCrates = v
    end,
})

TabHalloween:CreateButton({
    name        = "Open 10x Halloween Crates",
    description = "Opens 10 Halloween Crates immediately",
    callback    = function()
        if R_CrateOpen then
            pcall(function() R_CrateOpen:FireServer("Halloween Crate", 10) end)
            SafeNotify("Crates", "Opening 10 Halloween Crates...", 3, "Reward")
        end
    end,
})

TabHalloween:CreateButton({
    name        = "Open 50x Halloween Crates",
    description = "Opens 50 Halloween Crates immediately",
    callback    = function()
        if R_CrateOpen then
            pcall(function() R_CrateOpen:FireServer("Halloween Crate", 50) end)
            SafeNotify("Crates", "Opening 50 Halloween Crates...", 3, "Reward")
        end
    end,
})

TabHalloween:CreateButton({
    name        = "Use Huzzoween Star (Halloween Biome)",
    description = "Summons the Halloween Biome on your island",
    callback    = function()
        if R_BiomeUseCaller then
            pcall(function() R_BiomeUseCaller:FireServer("Huzzoween Star") end)
            SafeNotify("Halloween", "Summoned Halloween Biome!", 3, "Reward")
        end
    end,
})

TabHalloween:CreateSection("🛒 Pumpkin Candy Exchange Shop (Docks)")

TabHalloween:CreateButton({
    name        = "Buy Halloween Crate [15 Candy]",
    description = "Exchanges 15 Candy for 1 Halloween Crate",
    callback    = function() BuyFromHalloweenShop("Halloween Crate") end,
})

TabHalloween:CreateButton({
    name        = "Buy Spooky Relic [2,500 Candy]",
    description = "+560 Luck, -2 Speed, 10-50% more quest rewards",
    callback    = function() BuyFromHalloweenShop("Spooky Relic") end,
})

TabHalloween:CreateButton({
    name        = "Buy Huzzoween Star [7,500 Candy]",
    description = "Purchases a Halloween Biome caller",
    callback    = function() BuyFromHalloweenShop("Huzzoween Star") end,
})

TabHalloween:CreateButton({
    name        = "Buy Marin (Halloween) [7,500 Candy]",
    description = "Purchases the exclusive Marin Halloween aura variant",
    callback    = function() BuyFromHalloweenShop("Marin (Halloween)") end,
})

TabHalloween:CreateButton({
    name        = "Buy Rias (Halloween) [10,000 Candy]",
    description = "Purchases the exclusive Rias Halloween aura variant",
    callback    = function() BuyFromHalloweenShop("Rias (Halloween)") end,
})

TabHalloween:CreateSection("💀 Headless Horseman Candy Shop")

TabHalloween:CreateButton({
    name        = "Buy Transcendent Pot [500 Candy]",
    callback    = function() BuyFromHorsemanShop("Transcendent Pot") end,
})

TabHalloween:CreateButton({
    name        = "Buy Eternal Pot [250 Candy]",
    callback    = function() BuyFromHorsemanShop("Eternal Pot") end,
})

TabHalloween:CreateButton({
    name        = "Buy Sacred Pot [125 Candy]",
    callback    = function() BuyFromHorsemanShop("Sacred Pot") end,
})

TabHalloween:CreateButton({
    name        = "Buy Heavens Pot [75 Candy]",
    callback    = function() BuyFromHorsemanShop("Heavens Pot") end,
})

TabHalloween:CreateButton({
    name        = "Buy Caller Star [50 Candy]",
    callback    = function() BuyFromHorsemanShop("Caller Star") end,
})

TabHalloween:CreateButton({
    name        = "Buy Essence Of All [30 Candy]",
    callback    = function() BuyFromHorsemanShop("Essence Of All") end,
})

TabHalloween:CreateButton({
    name        = "Buy 50x Better Potion Crates [5 Candy]",
    callback    = function() BuyFromHorsemanShop("Better Potion Crates (×50)") end,
})

TabHalloween:CreateButton({
    name        = "Buy 50x Better Goodie Crates [5 Candy]",
    callback    = function() BuyFromHorsemanShop("Better Goodie Crates (×50)") end,
})

TabHalloween:CreateSection("⚡ Band Aura Crafting")

TabHalloween:CreateButton({
    name        = "Craft K-On Band",
    description = "Requires: Yui, Mio, Ritsu, Tsumugi, Azusa",
    callback    = function() CraftItemNow("K-On Band") end,
})

TabHalloween:CreateButton({
    name        = "Craft Kessoku Band",
    description = "Requires: HitoriGotoh (Bocchi), Kita, Nijika, Ryo",
    callback    = function() CraftItemNow("Kessoku Band") end,
})

TabHalloween:CreateSection("⛵ Halloween Island Teleports")

for _, entry in ipairs(NPCTeleportDatabase.HalloweenIsland) do
    local capturedEntry = entry
    TabHalloween:CreateButton({
        name        = capturedEntry.label,
        description = "Teleport to " .. capturedEntry.label,
        callback    = function() TeleportToNPCOrCoord(capturedEntry) end,
    })
end
end

do
-- Tab 2: Items & Buffs
local TabItems = Window:CreateTab({ name = "Items & Buffs", icon = 10734898104 })

TabItems:CreateSection("Candle Crafting & Buffs")

TabItems:CreateDropdown({
    name        = "Candles to Craft",
    description = "Choose candles to auto craft",
    options     = CandleOptions,
    default     = { "Candle_Basic", "Candle_Magic", "Candle_Hot" },
    multiSelect = true,
    flag        = "CandlesToCraft",
    callback    = function(selected) Config.CandlesToCraft = selected end,
})

TabItems:CreateToggle({
    name        = "Auto Craft Candles",
    description = "Crafts selected candles",
    flag        = "AutoCraftCandles",
    callback    = function(v)
        Config.AutoCraftCandles = v
        if v then CraftCandlesNow() end
    end,
})

TabItems:CreateToggle({
    name        = "Auto TP to Active Candle",
    description = "Stands on active player candle for luck buff",
    flag        = "AutoTPToActiveCandle",
    callback    = function(v)
        Config.AutoTPToActiveCandle = v
        if v and not Config.AutoFish then
            local cf = GetBestActiveCandleCFrame()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if cf and hrp then hrp.CFrame = cf end
        end
    end,
})

TabItems:CreateButton({
    name        = "Craft Selected Candles Now",
    description = "Crafts selected candles immediately",
    callback    = function()
        CraftCandlesNow()
        SafeNotify("Candles", "Crafting candles...", 3, "Information")
    end,
})

TabItems:CreateSection("Auto Place Candles")

TabItems:CreateDropdown({
    name        = "Candles to Place",
    description = "Choose candles to place",
    options     = CandleOptions,
    default     = { "Candle_Hot", "Candle_Basic" },
    multiSelect = true,
    flag        = "CandlesToPlace",
    callback    = function(selected) Config.CandlesToPlace = selected end,
})

TabItems:CreateToggle({
    name        = "Auto Place Candles",
    description = "Places candles automatically",
    flag        = "AutoPlaceCandles",
    callback    = function(v)
        Config.AutoPlaceCandles = v
        if v then PlaceCandlesNow() end
    end,
})

TabItems:CreateToggle({
    name        = "Place as soon as Expired",
    description = "Places a new candle when current one runs out",
    flag        = "CandleSmartExpiry",
    default     = true,
    currentValue= true,
    callback    = function(v) Config.CandleSmartExpiry = v end,
})

TabItems:CreateSlider({
    name         = "Candle Interval (Minutes)",
    range        = { 1, 30 },
    increment    = 1,
    currentValue = 5,
    flag         = "CandleIntervalSlider",
    callback     = function(val) Config.CandleInterval = val * 60 end,
})

TabItems:CreateButton({
    name        = "Place Candles Now",
    description = "Places your candles right now",
    callback    = function() PlaceCandlesNow() end,
})

TabItems:CreateSection("Auto Open Crates")

TabItems:CreateDropdown({
    name        = "Crates to Open",
    description = "Choose crates to open",
    options     = CrateOptions,
    default     = { "Summer Crate", "Potion Crate", "Better Potion Crate", "Premium Potion Crate", "Goodie Crate", "Better Goodie Crate", "Premium Goodie Crate" },
    multiSelect = true,
    flag        = "CratesToOpen",
    callback    = function(selected) Config.CratesToOpen = selected end,
})

TabItems:CreateToggle({
    name        = "Auto Open Crates",
    description = "Opens crates automatically",
    flag        = "AutoOpenCrates",
    callback    = function(v)
        Config.AutoOpenCrates = v
        if v then OpenCratesNow() end
    end,
})

TabItems:CreateSlider({
    name         = "Crate Open Interval (Seconds)",
    range        = { 1, 15 },
    increment    = 0.5,
    currentValue = 3.0,
    flag         = "CrateOpenIntervalSlider",
    callback     = function(val) Config.CrateOpenInterval = val end,
})

TabItems:CreateButton({
    name        = "Open Crates Now",
    description = "Opens selected crates right now",
    callback    = function() OpenCratesNow() end,
})

TabItems:CreateSection("Auto Drink Potions")

TabItems:CreateDropdown({
    name        = "Potions to Drink",
    description = "Choose potions to drink",
    options     = PotionOptions,
    default     = { "Big Luck Pot", "Big Haste Pot" },
    multiSelect = true,
    flag        = "PotionsToDrink",
    callback    = function(selected) Config.PotionsToDrink = selected end,
})

TabItems:CreateToggle({
    name        = "Auto Drink Potions",
    description = "Drinks potions automatically",
    flag        = "AutoDrinkPotions",
    callback    = function(v)
        Config.AutoDrinkPotions = v
        if v then DrinkPotionsNow() end
    end,
})

TabItems:CreateSlider({
    name         = "Potion Drink Interval (Seconds)",
    range        = { 10, 300 },
    increment    = 5,
    currentValue = 60,
    flag         = "PotionIntervalSlider",
    callback     = function(val) Config.PotionInterval = val end,
})

TabItems:CreateButton({
    name        = "Drink Potions Now",
    description = "Drinks selected potions right now",
    callback    = function() DrinkPotionsNow() end,
})

TabItems:CreateSection("Star Callers")

TabItems:CreateDropdown({
    name        = "Callers to Use",
    description = "Choose callers to use",
    options     = CallerOptions,
    default     = { "Caller Star" },
    multiSelect = true,
    flag        = "CallersToUse",
    callback    = function(selected) Config.CallersToUse = selected end,
})

TabItems:CreateToggle({
    name        = "Auto Use Callers",
    description = "Uses callers automatically",
    flag        = "AutoUseCaller",
    callback    = function(v) Config.AutoUseCaller = v end,
})

TabItems:CreateButton({
    name        = "Use Caller Now",
    description = "Uses selected caller right now",
    callback    = function() UseCallersNow() end,
})
end

do
-- Tab 3: Rewards & Quests
local TabRewards = Window:CreateTab({ name = "Rewards & Quests", icon = 10734919950 })

TabRewards:CreateSection("Summer & Event Quests")

TabRewards:CreateToggle({
    name        = "Auto Robin (Summer Crates) Quests",
    description = "Accepts & claims Summer Crate quests from Robin",
    flag        = "AutoRobinQuests",
    default     = false,
    callback    = function(v)
        Config.AutoRobinQuests = v
        if v then ProcessRobinSummerQuests() end
    end,
})

TabRewards:CreateToggle({
    name        = "Smart Drink Robin Quest Potions",
    description = "Drinks ONLY required amount for Robin's active quest without wasting stacks",
    flag        = "AutoRobinDrinkPots",
    default     = false,
    callback    = function(v) Config.AutoRobinDrinkPots = v end,
})

TabRewards:CreateButton({
    name        = "Claim Summer Quests Now",
    description = "Claims completed Summer quests immediately",
    callback    = function()
        ProcessRobinSummerQuests()
        SafeNotify("Summer Quests", "Checking Robin's quests...", 3, "Information")
    end,
})

TabRewards:CreateSection("General Quests & Rewards")

TabRewards:CreateDropdown({
    name        = "Quests to Automate",
    description = "Select which questlines the script should do",
    options     = { "Standard Quests", "Weekly Quest", "Robin Summer", "Charmy Bounties", "Ishmael Daily", "Aventurine Wagers", "Ego Trial", "Almighty Quests", "Aizen Quests" },
    default     = { "Standard Quests", "Robin Summer", "Charmy Bounties", "Ishmael Daily", "Aventurine Wagers", "Ego Trial", "Almighty Quests" },
    multiSelect = true,
    flag        = "QuestsSelectedDropdown",
    callback    = function(sel) Config.QuestsSelected = sel end,
})

TabRewards:CreateToggle({
    name        = "Auto Quests (Selected)",
    description = "Accepts & claims selected NPC quests by ID",
    flag        = "AutoQuests",
    callback    = function(v) Config.AutoQuests = v end,
})

TabRewards:CreateToggle({
    name        = "Auto Playtime Rewards",
    description = "Claims playtime rewards automatically",
    flag        = "AutoTimeRewards",
    callback    = function(v) Config.AutoTimeRewards = v end,
})

TabRewards:CreateToggle({
    name        = "Auto Achievements",
    description = "Claims achievements automatically",
    flag        = "AutoAchievements",
    callback    = function(v) Config.AutoAchievements = v end,
})

TabRewards:CreateToggle({
    name        = "Auto Claim Battle Pass",
    description = "Claims unlocked Battle Pass rewards automatically (Season 3)",
    flag        = "AutoBattlePass",
    default     = false,
    callback    = function(v)
        Config.AutoBattlePass = v
        if v then ClaimBattlePassNow() end
    end,
})

TabRewards:CreateButton({
    name        = "Claim Battle Pass Now",
    description = "Claims all current Battle Pass rewards",
    callback    = function() ClaimBattlePassNow() end,
})

TabRewards:CreateSection("Special Secrets & Neco Arc")

TabRewards:CreateButton({
    name        = "Auto Neco Arc Secret (Waterfall)",
    description = "Teleports behind waterfall & endures 10-min prompt for secret aura",
    callback    = function() StartNecoArcSecret() end,
})

TabRewards:CreateButton({
    name        = "Cancel Neco Arc Hold",
    description = "Stops holding the Neco Arc prompt early",
    callback    = function()
        isDoingNeco = false
        SafeNotify("Neco Arc", "Cancelled ritual!", 3, "Warning")
    end,
})

TabRewards:CreateSection("Codes")

TabRewards:CreateButton({
    name        = "Redeem All Codes (Season 3 / JoJos)",
    description = "Redeems all known active codes (including GAPWEEK, JOJOS, BATTLEPASS3)",
    callback    = function()
        if not R_CodeRedeem then SafeNotify("Codes", "Redeem remote not found!", 3, "Warning") return end
        if isRedeemingCodes then SafeNotify("Codes", "Already redeeming...", 3, "Warning") return end
        isRedeemingCodes = true
        pcall(function()
            if not LocalPlayer:IsInGroup(35119567) then GroupService:PromptJoinAsync(35119567) end
        end)
        SafeNotify("Codes", "Redeeming " .. #KnownCodes .. " codes...", 4, "Information")
        task.spawn(function()
            for _, code in ipairs(KnownCodes) do
                pcall(function() R_CodeRedeem:FireServer(code) end)
                task.wait(2.2)
            end
            isRedeemingCodes = false
            SafeNotify("Codes", "Finished redeeming codes!", 5, "Reward")
        end)
    end,
})

TabRewards:CreateInput({
    name        = "Custom Code",
    placeholder = "Type a code here...",
    callback    = function(codeText)
        if codeText ~= "" and R_CodeRedeem then
            pcall(function()
                if not LocalPlayer:IsInGroup(35119567) then GroupService:PromptJoinAsync(35119567) end
                R_CodeRedeem:FireServer(codeText)
            end)
            SafeNotify("Codes", "Submitted: " .. codeText, 3, "Information")
        end
    end,
})
end

do
-- Tab 4: Server & Biomes
local TabServer = Window:CreateTab({ name = "Server & Biomes", icon = 10734938600 })

TabServer:CreateSection("Anti-AFK & Rejoin")

TabServer:CreateToggle({
    name        = "Anti-AFK",
    description = "Prevents 20-min idle disconnect",
    flag        = "AntiAFK",
    default     = true,
    currentValue= true,
    callback    = function(v) Config.AntiAFK = v end,
})

TabServer:CreateToggle({
    name        = "Auto Rejoin on Kick",
    description = "Reconnects and restarts script if disconnected",
    flag        = "AutoRejoin",
    default     = true,
    currentValue= true,
    callback    = function(v) Config.AutoRejoin = v end,
})

TabServer:CreateSection("Server Hopping")

TabServer:CreateToggle({
    name        = "Auto Re-Execute on Hop",
    description = "Loads script again after hopping servers",
    flag        = "AutoReExecOnHop",
    default     = true,
    currentValue= true,
    callback    = function(v) Config.AutoReExecOnHop = v end,
})

TabServer:CreateButton({
    name        = "Quick Server Hop",
    description = "Teleports to a different server",
    callback    = function() ServerHop() end,
})

TabServer:CreateDropdown({
    name        = "Target Biomes",
    description = "Choose live biomes to find",
    options     = BiomeList,
    multiSelect = true,
    flag        = "TargetHopBiomes",
    callback    = function(sel) Config.TargetHopBiomes = sel end,
})

TabServer:CreateButton({
    name        = "Hunt Biomes",
    description = "Hops servers until your biome is found",
    callback    = function() HopForBiome(Config.TargetHopBiomes) end,
})

TabServer:CreateButton({
    name        = "Stop Biome Hunt",
    description = "Cancels the server hop",
    callback    = function() CancelBiomeHunt() end,
})
end

do
-- Tab 5: Complete Teleports (Worlds & NPCs)
local TabNPC = Window:CreateTab({ name = "NPC Teleports", icon = 10734920000 })

TabNPC:CreateSection("🏝️ Major World Locations")
for _, entry in ipairs(NPCTeleportDatabase.Worlds) do
    local capturedEntry = entry
    TabNPC:CreateButton({
        name        = capturedEntry.label,
        description = "Teleport to " .. capturedEntry.label,
        callback    = function() TeleportToNPCOrCoord(capturedEntry) end,
    })
end

TabNPC:CreateSection("🎃 Halloween Island NPCs & Spots")
for _, entry in ipairs(NPCTeleportDatabase.HalloweenIsland) do
    local capturedEntry = entry
    TabNPC:CreateButton({
        name        = capturedEntry.label,
        description = "Teleport to " .. capturedEntry.label,
        callback    = function() TeleportToNPCOrCoord(capturedEntry) end,
    })
end

TabNPC:CreateSection("Island 2 NPCs")
for _, entry in ipairs(NPCTeleportDatabase.Island2) do
    local capturedEntry = entry
    TabNPC:CreateButton({
        name        = capturedEntry.label,
        description = "Teleport to " .. capturedEntry.label,
        callback    = function() TeleportToNPCOrCoord(capturedEntry) end,
    })
end

TabNPC:CreateSection("Island 2 Stations")
for _, entry in ipairs(NPCTeleportDatabase.Island2Stations) do
    local capturedEntry = entry
    TabNPC:CreateButton({
        name        = capturedEntry.label,
        description = "Teleport to " .. capturedEntry.label,
        callback    = function() TeleportToNPCOrCoord(capturedEntry) end,
    })
end

TabNPC:CreateSection("Main Lobby Quest NPCs")
for _, entry in ipairs(NPCTeleportDatabase.LobbyQuests) do
    local capturedEntry = entry
    TabNPC:CreateButton({
        name        = capturedEntry.label,
        description = "Teleport to " .. capturedEntry.label,
        callback    = function() TeleportToNPCOrCoord(capturedEntry) end,
    })
end

TabNPC:CreateSection("Main Lobby Social NPCs")
for _, entry in ipairs(NPCTeleportDatabase.LobbySocial) do
    local capturedEntry = entry
    TabNPC:CreateButton({
        name        = capturedEntry.label,
        description = "Teleport to " .. capturedEntry.label,
        callback    = function() TeleportToNPCOrCoord(capturedEntry) end,
    })
end

TabNPC:CreateSection("Merchants & Stations")
for _, entry in ipairs(NPCTeleportDatabase.Merchants) do
    local capturedEntry = entry
    TabNPC:CreateButton({
        name        = capturedEntry.label,
        description = "Teleport to " .. capturedEntry.label,
        callback    = function() TeleportToNPCOrCoord(capturedEntry) end,
    })
end

TabNPC:CreateSection("Special Spots")
TabNPC:CreateButton({
    name        = "Fishing Dock (Island 1)",
    description = "Go to the Island 1 fishing dock",
    callback    = function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = Island1FishingCFrame
            SafeNotify("Teleport", "Teleported to Island 1 fishing spot!", 3, "Reward")
        end
    end,
})

TabNPC:CreateButton({
    name        = "Fishing Dock (Island 2)",
    description = "Go to the Island 2 fishing dock",
    callback    = function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = Island2FishingCFrame
            SafeNotify("Teleport", "Teleported to Island 2 fishing spot!", 3, "Reward")
        end
    end,
})

TabNPC:CreateButton({
    name        = "Active Player Candle",
    description = "Go to the best active player candle",
    callback    = function()
        local cf = GetBestActiveCandleCFrame()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if cf and hrp then
            hrp.CFrame = cf
            SafeNotify("Teleport", "Teleported to active candle!", 3, "Reward")
        else
            SafeNotify("Teleport", "No active candle found!", 3, "Warning")
        end
    end,
})
end

do
-- Tab 6: Shops & Factory
local TabShop = Window:CreateTab({ name = "Shops & Factory", icon = 10734898104 })

TabShop:CreateSection("Island 2 Potion Factory (Tycoon)")

TabShop:CreateToggle({
    name        = "Auto Claim Cauldron",
    description = "Collects ready brewed potions from Island 2 Cauldron",
    flag        = "AutoClaimCauldron",
    default     = false,
    callback    = function(v)
        Config.AutoClaimCauldron = v
        if v then ClaimCauldronNow() end
    end,
})

TabShop:CreateButton({
    name        = "Claim Cauldron Now",
    description = "Collects brewed potions from Cauldron right now",
    callback    = function() ClaimCauldronNow() end,
})

TabShop:CreateSection("Mystery Merchant")

TabShop:CreateDropdown({
    name        = "Potions to Buy",
    description = "Choose potions to buy",
    options     = MysteryMerchantPotions,
    default     = { "Transcendent Pot", "Glitched Potion", "Omega Pot" },
    multiSelect = true,
    flag        = "MysteryPotionsToBuy",
    callback    = function(selected) Config.MysteryPotionsToBuy = selected end,
})

TabShop:CreateToggle({
    name        = "Auto Buy from Merchant",
    description = "Buys selected potions when merchant spawns",
    flag        = "AutoBuyMystery",
    callback    = function(v) Config.AutoBuyMystery = v end,
})

TabShop:CreateToggle({
    name        = "Auto TP to Merchant",
    description = "Teleports to the merchant to buy",
    flag        = "AutoTPMerchant",
    callback    = function(v) Config.AutoTPMerchant = v end,
})

TabShop:CreateSection("Altar & Vending")

TabShop:CreateDropdown({
    name        = "Potions to Sacrifice",
    description = "Choose potions to sacrifice",
    options     = AstralisPotionOptions,
    multiSelect = true,
    flag        = "AstralisPotions",
    callback    = function(selected) Config.AstralisPotions = selected end,
})

TabShop:CreateToggle({
    name        = "Auto Sacrifice",
    description = "Sacrifices potions automatically",
    flag        = "AutoAstralis",
    callback    = function(v) Config.AutoAstralis = v end,
})

TabShop:CreateButton({
    name        = "Sacrifice Now",
    description = "Sacrifices selected potions right now",
    callback    = function()
        if not R_ExtractAction then SafeNotify("Altar", "Remote not found!", 3, "Warning") return end
        if #Config.AstralisPotions == 0 then SafeNotify("Altar", "No potions selected!", 3, "Warning") return end
        task.spawn(function()
            local count = 0
            for _, potionName in ipairs(Config.AstralisPotions) do
                local ok, result = pcall(function() return R_ExtractAction:InvokeServer("sacrifice", potionName, 1) end)
                if ok and type(result) == "table" and result.success then count = count + 1 end
                task.wait(0.6)
            end
            SafeNotify("Altar", "Sacrificed " .. count .. "/" .. #Config.AstralisPotions .. " potions!", 3, "Reward")
        end)
    end,
})

TabShop:CreateToggle({
    name        = "Auto Vending Machine",
    description = "Uses the vending machine automatically",
    flag        = "AutoVending",
    callback    = function(v) Config.AutoVending = v end,
})
end

do
-- Tab 7: Visuals & Webhook
local TabVisuals = Window:CreateTab({ name = "Visuals & Webhook", icon = 10734920000 })

TabVisuals:CreateToggle({
    name        = "Potion ESP",
    description = "Shows potions through walls",
    flag        = "PotionESP",
    callback    = function(v)
        Config.PotionESP = v
        if not v then
            for _, h in pairs(ESPCache.Potions) do if h then pcall(h.Destroy, h) end end
            ESPCache.Potions = {}
        end
    end,
})

TabVisuals:CreateToggle({
    name        = "NPC ESP",
    description = "Shows NPCs through walls",
    flag        = "NPCESP",
    callback    = function(v)
        Config.NPCESP = v
        if not v then
            for _, h in pairs(ESPCache.NPCs) do if h then pcall(h.Destroy, h) end end
            ESPCache.NPCs = {}
        end
    end,
})

TabVisuals:CreateInput({
    name        = "Webhook URL",
    placeholder = "Paste Discord webhook here...",
    flag        = "WebhookURL",
    callback    = function(t) Config.WebhookURL = t end,
})

TabVisuals:CreateDropdown({
    name        = "Ping on Biome",
    description = "Sends webhook when biomes spawn",
    options     = BiomeList,
    multiSelect = true,
    flag        = "PingBiomes",
    callback    = function(sel) Config.PingBiomes = sel end,
})

TabVisuals:CreateToggle({
    name        = "Ping on Merchant",
    description = "Sends webhook when merchant spawns",
    flag        = "PingOnMerchant",
    callback    = function(v) Config.PingOnMerchant = v end,
})

TabVisuals:CreateToggle({
    name        = "Ping on Merchant Buy",
    description = "Sends webhook when potions are bought",
    flag        = "PingOnMysteryBuy",
    callback    = function(v) Config.PingOnMysteryBuy = v end,
})

TabVisuals:CreateToggle({
    name        = "Ping on Craft",
    description = "Sends webhook when items are crafted",
    flag        = "PingOnCraft",
    callback    = function(v) Config.PingOnCraft = v end,
})

TabVisuals:CreateToggle({
    name        = "Ping on Crate",
    description = "Sends webhook when crates are opened",
    flag        = "PingOnCrate",
    callback    = function(v) Config.PingOnCrate = v end,
})

TabVisuals:CreateToggle({
    name        = "Ping on Rare Aura",
    description = "Sends webhook when rare aura is rolled",
    flag        = "PingOnAura",
    callback    = function(v) Config.PingOnAura = v end,
})

TabVisuals:CreateToggle({
    name        = "Ping on Minigame Reward",
    description = "Sends webhook when minigame prize is won",
    flag        = "PingOnMinigameReward",
    default     = true,
    callback    = function(v) Config.PingOnMinigameReward = v end,
})

TabVisuals:CreateInput({
    name        = "Aura Rarity Threshold",
    numeric     = true,
    value       = "100000",
    placeholder = "e.g. 100000",
    flag        = "AuraThresholdInput",
    callback    = function(text)
        local num = tonumber(text)
        if num and num > 0 then Config.AuraThreshold = num end
    end,
})
end

-- ==================== FARM CHAIN RUNNERS ====================
local function HandlePostFishSequence()
    if isPostCatchRunning then return end
    isPostCatchRunning = true
    task.spawn(function()
        task.wait(0.6)
        if Config.AutoCollect then CollectAllGroundPotions() task.wait(0.3) end
        if Config.AutoObby and (os.clock() - lastObbyTime >= 30) then DoObby() task.wait(0.4) end
        
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            if Config.AutoFish then
                local safeCF = GetActiveFishingDockData()
                hrp.CFrame = safeCF
            elseif Config.AutoTPToActiveCandle then
                local candleCF = GetBestActiveCandleCFrame()
                if candleCF then hrp.CFrame = candleCF end
            end
            task.wait(0.5)
        end
        isPostCatchRunning = false
    end)
end

task.spawn(function()
    while task.wait(1) do
        if Config.AutoTPToActiveCandle and not Config.AutoFish and not isPostCatchRunning and not isDoingNeco then
            local candleCF = GetBestActiveCandleCFrame()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if candleCF and hrp then
                local dist = (candleCF.Position - hrp.Position).Magnitude
                if dist > 6 then hrp.CFrame = candleCF end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1.5) do
        local now = os.clock()
        if Config.AutoOpenCrates and not isOpeningCrates and (now - lastCrateOpenTime >= Config.CrateOpenInterval) then
            OpenCratesNow()
        end
        
        if Config.AutoMinigames and not isMinigameLoopRunning then
            StartMinigamesLoop()
        end

        if Config.AutoClaimCauldron and (now - lastCauldronCheck >= Config.CauldronInterval) and not isDoingMinigame and not isDoingNeco then
            ClaimCauldronNow()
        end

        if Config.AutoPlaceCandles then
            if Config.CandleSmartExpiry then
                if not HasAnyActiveCandleNearby(16) and (now - lastCandlePlaceTime >= 10) then
                    PlaceCandlesNow()
                end
            else
                if (now - lastCandlePlaceTime >= Config.CandleInterval) then
                    PlaceCandlesNow()
                end
            end
        end

        if Config.AutoDrinkPotions and (now - lastPotionDrinkTime >= Config.PotionInterval) then
            DrinkPotionsNow()
        end
        if Config.AutoUseCaller and (now - lastCallerTime >= Config.CallerInterval) then
            UseCallersNow()
        end
        if Config.AutoCraftCandles and (now - lastCandleCraftTime >= 5) then
            CraftCandlesNow()
        end
        if Config.AutoUpgradeStorage and (now - lastUpgradeTime >= 10) then
            lastUpgradeTime = now
            if R_UpgradeStorage and R_UpgradeStorage:IsA("RemoteFunction") then
                pcall(function() R_UpgradeStorage:InvokeServer() end)
            end
        end

        -- Halloween Event Automations
        if Config.AutoTrickOrTreat and not isDoingMinigame and not isDoingNeco then
            RunTrickOrTreatStep()
        end
        if Config.AutoHalloweenBP and (now - lastHalloweenBPClaimTime >= 15) then
            ClaimHalloweenBattlePassNow()
        end
        if Config.AutoHalloweenBounties and (now - lastHalloweenBountyTime >= 8) then
            ProcessHalloweenBounties()
        end
        if Config.AutoOpenHalloweenCrates and not isOpeningCrates and (now - lastCrateOpenTime >= 3.5) then
            OpenSpecificCrate("Halloween Crate")
        end
    end
end)

-- Main Quest Automation Loop (Rate-Limit Protected)
task.spawn(function()
    while task.wait(6) do
        if Config.AutoRobinQuests or table.find(Config.QuestsSelected, "Robin Summer") then
            ProcessRobinSummerQuests()
        end

        if Config.AutoQuests then
            local runStd = table.find(Config.QuestsSelected, "Standard Quests")
            local runWeekly = table.find(Config.QuestsSelected, "Weekly Quest")
            local runCharmy = table.find(Config.QuestsSelected, "Charmy Bounties")
            local runIshmael = table.find(Config.QuestsSelected, "Ishmael Daily")
            local runAventurine = table.find(Config.QuestsSelected, "Aventurine Wagers")
            local runEgo = table.find(Config.QuestsSelected, "Ego Trial")
            local runAlmighty = table.find(Config.QuestsSelected, "Almighty Quests")
            local runAizen = table.find(Config.QuestsSelected, "Aizen Quests")

            if runStd and R_QuestStatus then
                local ok, status = pcall(function() return R_QuestStatus:InvokeServer() end)
                if ok and type(status) == "table" then
                    for _, q in ipairs(status) do
                        if q.active == false and not q.isComplete and q.id and R_QuestActivate then
                            pcall(function() R_QuestActivate:FireServer(q.id) end)
                            task.wait(0.2)
                        end

                        local canClaim = q.isComplete or (tonumber(q.claimableCount or 0) > 0)
                        if canClaim and q.id then
                            if q.category == "Power" or q.id:find("Power_") then
                                if R_QuestClaimPower then
                                    pcall(function() R_QuestClaimPower:FireServer(q.id) end)
                                    SafeNotify("Quests", "Claimed Power Quest: " .. (q.name or q.id), 3, "Reward")
                                    task.wait(0.25)
                                end
                            else
                                if R_QuestClaim then
                                    pcall(function() R_QuestClaim:FireServer(q.id) end)
                                    SafeNotify("Quests", "Claimed: " .. (q.name or q.id), 3, "Reward")
                                    task.wait(0.25)
                                end
                            end
                        end
                    end
                end
            end

            if runCharmy and R_CharmyStart then pcall(function() R_CharmyStart:FireServer() end) end
            if runIshmael and R_IshmaelAccept then pcall(function() R_IshmaelAccept:FireServer() end) end
            if runAventurine and R_AventurineStart then pcall(function() R_AventurineStart:FireServer() end) end
            if runWeekly and R_QuestWeekly then pcall(function() R_QuestWeekly:FireServer() end) end
            if runEgo and R_EgoQuestStart then pcall(function() R_EgoQuestStart:FireServer() end) end
            if runAlmighty and R_AlmightyStart then pcall(function() R_AlmightyStart:FireServer() end) end
            if runAizen and R_AizenStart then pcall(function() R_AizenStart:FireServer() end) end

            -- Quest:NPCInteracted takes 0 args and has 10/60s limit
            if runStd and R_QuestNPCInteract then
                pcall(function() R_QuestNPCInteract:FireServer() end)
            end
            task.wait(0.3)

            if runCharmy and R_CharmyClaim then pcall(R_CharmyClaim.FireServer, R_CharmyClaim) end ; task.wait(0.2)
            if runIshmael and R_IshmaelClaim then pcall(R_IshmaelClaim.FireServer, R_IshmaelClaim) end ; task.wait(0.2)
            if runAventurine and R_AventurineClaim then pcall(R_AventurineClaim.FireServer, R_AventurineClaim) end ; task.wait(0.2)
            if runStd and R_QuestClaimAllPower then pcall(R_QuestClaimAllPower.FireServer, R_QuestClaimAllPower) end ; task.wait(0.2)
            if R_DailyClaim then pcall(R_DailyClaim.FireServer, R_DailyClaim) end ; task.wait(0.2)
            if R_GroupClaim then pcall(R_GroupClaim.FireServer, R_GroupClaim) end
        end

        if Config.AutoTimeRewards and R_PlaytimeClaim then
            for slot = 1, 8 do
                pcall(function() R_PlaytimeClaim:FireServer(slot) end)
                task.wait(0.2)
            end
        end

        if Config.AutoAchievements and R_AchieveGetStatus and R_AchieveClaim then
            local ok, list = pcall(function() return R_AchieveGetStatus:InvokeServer() end)
            if ok and type(list) == "table" then
                local claimed = 0
                for _, entry in ipairs(list) do
                    if type(entry) == "table" and entry.id and entry.isClaimable then
                        pcall(function() R_AchieveClaim:FireServer(entry.id) end)
                        claimed = claimed + 1
                        task.wait(0.25)
                    end
                end
                if claimed > 0 then SafeNotify("Achievements", "Claimed " .. claimed .. " achievements!", 3, "Reward") end
            end
        end

        if Config.AutoBattlePass then
            ClaimBattlePassNow()
        end
    end
end)

-- ==================== FISHING CONTROLLER (SAFE DOCK POSITIONING) ====================
task.spawn(function()
    local lastCastTime = 0
    local mouseHeld = false
    local lastStateCheck = 0
    local fishingBusy = false

    local function getFishingGui()
        local pg = LocalPlayer:FindFirstChild("PlayerGui")
        return pg and pg:FindFirstChild("FishingGui")
    end

    local function getFishingState()
        local now = os.clock()
        if now - lastStateCheck < 0.35 then return fishingBusy end
        lastStateCheck = now
        local busy = false
        if R_FishDebug and R_FishDebug:IsA("RemoteFunction") then
            local ok, snap = pcall(function() return R_FishDebug:InvokeServer() end)
            if ok and type(snap) == "table" then
                busy = snap.hasSession == true or snap.hasPendingCast == true or snap.isFishing == true
            end
        end
        fishingBusy = busy
        return busy
    end

    local function keepInFishingZone()
        if isDoingMinigame or isDoingNeco or isPostCatchRunning then return false end

        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return false end

        local safeCF, activeMarker = GetActiveFishingDockData()

        if activeMarker and activeMarker:IsA("BasePart") then
            local lp = activeMarker.CFrame:PointToObjectSpace(hrp.Position)
            local half = activeMarker.Size * 0.5
            local inside = math.abs(lp.X) <= (half.X + 25) and math.abs(lp.Z) <= (half.Z + 25)
            if not inside then
                hrp.CFrame = safeCF
                return true
            end
        else
            if (hrp.Position - safeCF.Position).Magnitude > 8 then
                hrp.CFrame = safeCF
                return true
            end
        end
        return false
    end

    local isMobileDevice = (UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled) or (not UserInputService.MouseEnabled)

    local function getCenter(guiObject)
        local inset = GuiService:GetGuiInset()
        local pos = guiObject.AbsolutePosition
        local size = guiObject.AbsoluteSize
        return math.floor(pos.X + size.X / 2 + inset.X), math.floor(pos.Y + size.Y / 2 + inset.Y)
    end

    local function clickGui(guiObject, holdTime)
        if not guiObject or not guiObject.Visible then return end

        -- 1. Universal executor firesignal (100% crash-free across all executors on Android/iOS/PC)
        if firesignal then
            pcall(function() firesignal(guiObject.Activated) end)
            pcall(function() firesignal(guiObject.MouseButton1Click) end)
            pcall(function() firesignal(guiObject.MouseButton1Down) end)
            if holdTime and holdTime > 0 then task.wait(holdTime) end
            pcall(function() firesignal(guiObject.MouseButton1Up) end)
            return
        end

        local x, y = getCenter(guiObject)

        -- 2. Mobile fallback: VirtualUser (native Roblox service, crash-free on Android/iOS)
        if isMobileDevice then
            if VirtualUser then
                pcall(function()
                    VirtualUser:CaptureController()
                    VirtualUser:Button1Down(Vector2.new(x, y))
                    if holdTime and holdTime > 0 then task.wait(holdTime) end
                    VirtualUser:Button1Up(Vector2.new(x, y))
                end)
            end
            return
        end

        -- 3. Desktop PC only: VIM / mouse1click (Safe on Windows, NEVER called on Mobile to prevent SIGSEGV)
        if VIM then
            pcall(function()
                VIM:SendMouseMoveEvent(x, y, game)
                VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
                if holdTime and holdTime > 0 then task.wait(holdTime) end
                VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
            end)
        elseif VirtualUser then
            pcall(function()
                VirtualUser:CaptureController()
                VirtualUser:Button1Down(Vector2.new(x, y))
                if holdTime and holdTime > 0 then task.wait(holdTime) end
                VirtualUser:Button1Up(Vector2.new(x, y))
            end)
        elseif mouse1click then
            pcall(mouse1click)
        end
    end

    local function setHold(pressed)
        if mouseHeld == pressed then return end
        mouseHeld = pressed
        local cam = workspace.CurrentCamera
        local viewport = cam and cam.ViewportSize or Vector2.new(1280, 720)
        local x = math.floor(viewport.X * 0.5)
        local y = math.floor(viewport.Y * 0.5)

        if isMobileDevice then
            -- Mobile: use VirtualUser (native, zero crash risk on mobile Android/iOS)
            if VirtualUser then
                pcall(function()
                    VirtualUser:CaptureController()
                    if pressed then
                        VirtualUser:Button1Down(Vector2.new(x, y))
                    else
                        VirtualUser:Button1Up(Vector2.new(x, y))
                    end
                end)
            end
        else
            -- Desktop PC: VIM is safe on Windows
            if VIM then
                pcall(function()
                    VIM:SendMouseButtonEvent(x, y, 0, pressed, game, 0)
                end)
            elseif VirtualUser then
                pcall(function()
                    VirtualUser:CaptureController()
                    if pressed then
                        VirtualUser:Button1Down(Vector2.new(x, y))
                    else
                        VirtualUser:Button1Up(Vector2.new(x, y))
                    end
                end)
            end
        end
    end

    local function releaseHold() setHold(false) end

    if R_FishSession then
        R_FishSession.OnClientEvent:Connect(function(session)
            fishingBusy = session ~= nil
            if session == nil then
                releaseHold()
                lastCastTime = 0
                HandlePostFishSequence()
            end
        end)
    end

    if R_FishResult then
        R_FishResult.OnClientEvent:Connect(function()
            fishingBusy = false
            releaseHold()
            lastCastTime = 0
            HandlePostFishSequence()
        end)
    end

    while task.wait(0.05) do
        if not Config.AutoFish or isPostCatchRunning or isDoingMinigame or isDoingNeco then
            releaseHold()
        elseif os.clock() < fishingStartTime then
            -- Waiting for fishing start timer
        elseif keepInFishingZone() then
            task.wait(0.35)
        else
            local fishGui = getFishingGui()
            local shakeBtn = fishGui and (fishGui:FindFirstChild("ShakeButton", true) or fishGui:FindFirstChild("Shake", true))
            local castBtn  = fishGui and (fishGui:FindFirstChild("CastButton", true) or fishGui:FindFirstChild("Cast", true))
            local fishBar  = fishGui and fishGui:FindFirstChild("FishingBar", true)

            if shakeBtn and shakeBtn.Visible then
                releaseHold()
                -- Always fire remote directly to shake immediately on the server
                if R_FishShake then pcall(function() R_FishShake:FireServer() end) end
                clickGui(shakeBtn, 0.04)
                task.wait(0.12)
            elseif fishBar and fishBar.Visible then
                fishingBusy = true
                local controlBar = fishBar:FindFirstChild("ControlBar", true)
                local fishIcon   = fishBar:FindFirstChild("Fish", true)
                if controlBar and fishIcon then
                    local cX = controlBar.AbsolutePosition.X + controlBar.AbsoluteSize.X / 2
                    local fX = fishIcon.AbsolutePosition.X + fishIcon.AbsoluteSize.X / 2
                    local deadzone = math.max(1, controlBar.AbsoluteSize.X * 0.015)
                    if fX > cX + deadzone then
                        setHold(true)
                    elseif fX < cX - deadzone then
                        setHold(false)
                    end
                end
                task.wait(0.01)
            else
                releaseHold()
                if os.clock() - lastCastTime > 1.5 and not getFishingState() and not isPostCatchRunning then
                    lastCastTime = os.clock()
                    -- Always fire remote directly to cast immediately without relying on mouse hold
                    if R_FishCast then
                        pcall(function() R_FishCast:FireServer(0.72) end)
                    end
                    if castBtn and castBtn.Visible then
                        clickGui(castBtn, 0.15)
                    end
                    task.wait(0.35)
                end
            end
        end
    end
end)

-- Fish exchange
local lastFishExchangeTime = 0
local function TryExchangeAllFish(force)
    if not Config.AutoSellFish then return false end
    if not R_FishExchangeAll or not R_FishExchangeAll:IsA("RemoteFunction") then return false end
    local now = os.clock()
    if not force and now - lastFishExchangeTime < 6 then return false end
    lastFishExchangeTime = now
    if R_FishAnglerState and R_FishAnglerState:IsA("RemoteFunction") then
        local ok, state = pcall(function() return R_FishAnglerState:InvokeServer() end)
        if ok and type(state) == "table" and tonumber(state.totalFish or 0) <= 0 then return false end
    end
    local ok, result = pcall(function() return R_FishExchangeAll:InvokeServer() end)
    if ok and type(result) == "table" and result.success then
        SafeNotify("Auto Sell Fish", result.message or "Fish sold!", 3, "Reward")
        return true
    end
    return false
end

if R_FishResult then
    R_FishResult.OnClientEvent:Connect(function()
        if Config.AutoSellFish then task.delay(0.8, function() TryExchangeAllFish(true) end) end
    end)
end

task.spawn(function()
    while task.wait(6) do TryExchangeAllFish(false) end
end)

-- ==================== EVENT LISTENERS & LOOT NOTIFICATIONS ====================

if R_CrateOpenResult then
    R_CrateOpenResult.OnClientEvent:Connect(function(rewardName, amount)
        pcall(function()
            local pg = LocalPlayer:FindFirstChild("PlayerGui")
            local cf = pg and pg:FindFirstChild("Game") and pg.Game:FindFirstChild("ItemInv") and pg.Game.ItemInv:FindFirstChild("CrateFrame")
            if cf then cf.Visible = false end
        end)
        local s = (type(rewardName) == "string" and rewardName ~= "") and rewardName or "Item"
        local amt = amount and (" x" .. amount) or ""
        SafeNotify("📦 Crate Opened", "Got: " .. s .. amt, 4, "Reward")
        if Config.PingOnCrate then
            SendWebhook("📦 Crate Opened!", "Got **" .. s .. "**" .. amt, 0x00FF88)
        end
    end)
end

if R_MinigamesReward then
    R_MinigamesReward.OnClientEvent:Connect(function(rewardData, amount)
        local rewardName = ""
        local rewardAmt = tonumber(amount) or 1
        if type(rewardData) == "table" then
            rewardName = rewardData.name or rewardData.title or rewardData.id or "Prize"
            rewardAmt = tonumber(rewardData.amount or rewardData.count) or rewardAmt
        elseif type(rewardData) == "string" then
            rewardName = rewardData
        else
            rewardName = tostring(rewardData)
        end

        local lootMsg = string.format("🎁 WON PRIZE: %dx %s!", rewardAmt, rewardName)
        SafeNotify("🎉 MINIGAME VICTORY!", lootMsg, 7, "Reward")

        if Config.PingOnMinigameReward then
            SendWebhook("🏆 Minigame Won!", "You won a minigame and received:\n**" .. rewardAmt .. "x " .. rewardName .. "**", 0xFFD700)
        end
    end)
end

if R_CodeRedeemResp then
    R_CodeRedeemResp.OnClientEvent:Connect(function(msg)
        if type(msg) == "string" and msg ~= "" then SafeNotify("Code", msg, 4, "Information") end
    end)
end

if R_DarkMarketNotify then
    R_DarkMarketNotify.OnClientEvent:Connect(function(eventType, npcName)
        if eventType == "spawned" then
            local name = npcName or "Mystery Merchant"
            SafeNotify("Merchant", name .. " spawned!", 5, "Warning")
            if Config.PingOnMerchant then
                SendWebhook("🛒 Merchant Spawned!", "**" .. name .. "** is here on `" .. (game.JobId or "?") .. "`", 0xFFA500)
            end
            if Config.AutoTPMerchant then
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(Vector3.new(451, 8616, 777) + Vector3.new(0, 3, 4))
                end
            end
            if Config.AutoBuyMystery and R_DarkMarketPurchase then
                task.spawn(function()
                    task.wait(1)
                    for _, pot in ipairs(Config.MysteryPotionsToBuy) do
                        pcall(function() R_DarkMarketPurchase:FireServer(pot) end)
                        task.wait(0.5)
                    end
                end)
            end
        end
    end)
end

if R_DarkMarketPurchRes then
    R_DarkMarketPurchRes.OnClientEvent:Connect(function(res)
        if type(res) == "table" and res.Success then
            local msg = res.Message or "Bought a potion!"
            SafeNotify("Merchant", msg, 3, "Reward")
            if Config.PingOnMysteryBuy then SendWebhook("🛍️ Merchant Buy", msg, 0x00FF88) end
        end
    end)
end

if R_CraftCompleted then
    R_CraftCompleted.OnClientEvent:Connect(function(itemName)
        if Config.PingOnCraft then
            local s = (type(itemName) == "string" and itemName ~= "") and itemName or "Item"
            SendWebhook("⚒️ Crafted!", "Crafted **" .. s .. "**", 0x00FF88)
        end
    end)
end

if R_BiomeChanged then
    R_BiomeChanged.OnClientEvent:Connect(function(biomeName)
        if type(biomeName) ~= "string" then return end
        for _, b in ipairs(Config.PingBiomes) do
            if b:lower() == biomeName:lower() then
                SendWebhook("🌍 Biome: " .. biomeName, "**" .. biomeName .. "** spawned on `" .. (game.JobId or "?") .. "`", 0x8844FF)
                break
            end
        end
    end)
end

if R_RollResult then
    R_RollResult.OnClientEvent:Connect(function(data)
        if not Config.PingOnAura or type(data) ~= "table" then return end
        local name = data.name or data.Name or data.auraName or "Unknown"
        local rarity = data.rarity or data.Rarity or data.chance or data.Chance

        if (not rarity or type(rarity) ~= "number") and AuraData and AuraData[name] then
            rarity = AuraData[name].Rarity
        end

        if type(rarity) == "number" and rarity >= Config.AuraThreshold then
            SendWebhook("✨ Rare Aura!", "Rolled **" .. name .. "** — 1 in **" .. rarity .. "**!", 0xFFDD00)
        end
    end)
end

SafeNotify("MID HUB", "Successfully loaded Season 3 Suite!", 4, "Reward")

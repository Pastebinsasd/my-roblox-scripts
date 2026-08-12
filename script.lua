--[[
    ===================================================================
    ⚡ NEBULA HUB — Futuristic RNG Suite (With Misc, Codes & Quests) ⚡
    ===================================================================
    Auto Collect Potions   → fireproximityprompt on ground potions
    NPC ESP                → Highlight on workspace NPCs
    Potion ESP             → Highlight on spawned ground potions
    Auto Complete Obby     → TP to & trigger ParkourOrb ProximityPrompt
    Auto Claim Quests      → fires Quest:Claim, Quest:ClaimAllPower, Daily:Claim
    Auto Accept Quests     → queries Quest:GetStatus & activates all inactive quests
    Auto Redeem Codes      → redeems all known promo codes automatically
    Auto Gear Craft        → clicks AddAllButton then watches progress → clicks CraftButton (3.5s cooldown)
    Auto Fishing           → sets AutoFishingEnabled attr + fires Shake
    Auto Sell Fish         → sets AutoSellFishEnabled attr
    Discord Webhooks       → Biome:Changed ping, Roll:Result rarity ping (typeable threshold), Craft:Completed event ping
]]

-- =========================================================
-- LOAD UI LIBRARY
-- =========================================================
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

-- =========================================================
-- SERVICES
-- =========================================================
local Players         = game:GetService("Players")
local RS              = game:GetService("ReplicatedStorage")
local RunService      = game:GetService("RunService")
local HttpService     = game:GetService("HttpService")
local LocalPlayer     = Players.LocalPlayer

-- Helper Notification
local function SafeNotify(title, content, duration)
    pcall(function()
        if Rayfield and Rayfield.Notify then
            Rayfield:Notify({
                name = title,
                description = content,
                duration = duration or 4
            })
        end
    end)
end

-- =========================================================
-- REMOTE HANDLER
-- =========================================================
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

-- Pre-fetch remotes
local R_PotionPickup     = GetR("Potion:Pickup")
local R_ParkourCollected = GetR("ParkourOrb:Collected")
local R_BiomeChanged     = GetR("Biome:Changed")
local R_RollResult       = GetR("Roll:Result")
local R_QuestClaim       = GetR("Quest:Claim")
local R_QuestClaimPower  = GetR("Quest:ClaimAllPower")
local R_DailyClaim       = GetR("Daily:Claim")
local R_QuestStatus      = GetR("Quest:GetStatus")
local R_QuestActivate    = GetR("Quest:Activate")
local R_EgoQuestStart    = GetR("EgoQuest:Start")
local R_AlmightyStart    = GetR("AlmightyQuest:Start")
local R_AizenStart       = GetR("AizenQuest:Start")
local R_CodeRedeem       = GetR("Code:Redeem")
local R_CraftCompleted   = GetR("Craft:Completed")
local R_FishShake        = GetR("Fishing:Shake")

-- =========================================================
-- STATE
-- =========================================================
local Config = {
    PotionESP         = false,
    NPCESP            = false,
    AutoCollect       = false,
    AutoObby          = false,
    AutoQuests        = false,
    AutoAcceptQuests  = false,
    AutoCraft         = false,
    AutoFish          = false,
    AutoSellFish      = false,
    WebhookURL        = "",
    PingBiomes        = {},
    PingOnCraft       = false,
    PingOnAura        = false,
    AuraThreshold     = 100000,
}

local KnownCodes = {
    "RELEASE", "UPDATE1", "UPDATE2", "UPDATE3", "UPDATE4", "UPDATE5",
    "SUMMER", "HALLOWEEN", "CHRISTMAS", "THANKYOU", "10KLIKES", "25KLIKES",
    "50KLIKES", "100KLIKES", "200KLIKES", "1MVISITS", "5MVISITS", "10MVISITS",
    "SORRYFORSHUTDOWN", "FREEPOTIONS", "LUCK", "AURA", "PARKOUR", "POWER"
}

local ESPCache = { Potions = {}, NPCs = {} }

-- =========================================================
-- WINDOW
-- =========================================================
local Window = Rayfield:CreateWindow({
    name          = "NEBULA // FUTURISTIC HUB",
    subtitle      = "Advanced RNG & Automation Suite",
    configuration = {
        autoSave  = true,
        autoLoad  = true,
        fileName  = "Nebula_RNG_v2",
    },
})

-- ===================================================================
-- TAB 1 — FARMING & COLLECTION
-- ===================================================================
local TabFarm = Window:CreateTab({ name = "Farming", icon = 93364949241311 })

TabFarm:CreateToggle({
    name        = "Auto Collect Potions",
    description = "Teleports to each ground potion & fires its ProximityPrompt to pick it up",
    flag        = "AutoCollect",
    callback    = function(v) Config.AutoCollect = v end,
})

TabFarm:CreateToggle({
    name        = "Auto Complete Obby",
    description = "Teleports to the ParkourOrb & triggers it for the luck buff",
    flag        = "AutoObby",
    callback    = function(v) Config.AutoObby = v end,
})

TabFarm:CreateToggle({
    name        = "Auto Claim Quests",
    description = "Fires Quest:Claim, Quest:ClaimAllPower and Daily:Claim every 30 s",
    flag        = "AutoQuests",
    callback    = function(v) Config.AutoQuests = v end,
})

TabFarm:CreateToggle({
    name        = "Auto Accept All Quests",
    description = "Automatically accepts any new/inactive quests as soon as they become available",
    flag        = "AutoAcceptQuests",
    callback    = function(v) Config.AutoAcceptQuests = v end,
})

-- ===================================================================
-- TAB 2 — GEAR CRAFTING
-- ===================================================================
local TabCraft = Window:CreateTab({ name = "Gear Crafting", icon = 10734898104 })

TabCraft:CreateToggle({
    name        = "Auto Fill & Craft",
    description = "Watches the crafting menu; clicks Add All then Craft when ready",
    flag        = "AutoCraft",
    callback    = function(v) Config.AutoCraft = v end,
})

-- ===================================================================
-- TAB 3 — FISHING
-- ===================================================================
local TabFish = Window:CreateTab({ name = "Auto Fishing", icon = 10734919864 })

TabFish:CreateToggle({
    name        = "Auto Fishing",
    description = "Enables the built-in AutoFishing attribute so the game auto-casts, and also fires Shake when prompted",
    flag        = "AutoFish",
    callback    = function(v)
        Config.AutoFish = v
        LocalPlayer:SetAttribute("AutoFishingEnabled", v)
    end,
})

TabFish:CreateToggle({
    name        = "Auto Sell Fish",
    description = "Enables the built-in AutoSellFishEnabled attribute",
    flag        = "AutoSellFish",
    callback    = function(v)
        Config.AutoSellFish = v
        LocalPlayer:SetAttribute("AutoSellFishEnabled", v)
    end,
})

-- ===================================================================
-- TAB 4 — VISUALS & ESP
-- ===================================================================
local TabESP = Window:CreateTab({ name = "Visuals & ESP", icon = 10734920000 })

TabESP:CreateToggle({
    name        = "Potion ESP",
    description = "Glowing highlight on every spawned ground potion",
    flag        = "PotionESP",
    callback    = function(v)
        Config.PotionESP = v
        if not v then
            for _, h in pairs(ESPCache.Potions) do if h then pcall(h.Destroy, h) end end
            ESPCache.Potions = {}
        end
    end,
})

TabESP:CreateToggle({
    name        = "NPC ESP",
    description = "Highlight on world NPCs visible through walls",
    flag        = "NPCESP",
    callback    = function(v)
        Config.NPCESP = v
        if not v then
            for _, h in pairs(ESPCache.NPCs) do if h then pcall(h.Destroy, h) end end
            ESPCache.NPCs = {}
        end
    end,
})

-- ===================================================================
-- TAB 5 — DISCORD WEBHOOKS
-- ===================================================================
local TabWebhook = Window:CreateTab({ name = "Discord Webhook", icon = 10723382718 })

TabWebhook:CreateInput({
    name        = "Webhook URL",
    placeholder = "https://discord.com/api/webhooks/…",
    flag        = "WebhookURL",
    callback    = function(t) Config.WebhookURL = t end,
})

TabWebhook:CreateDropdown({
    name        = "Ping on Biome Spawn",
    description = "Select one or more biomes that trigger a webhook ping",
    options     = { "Galaxy", "Magic", "Rain", "Sakura", "Snow", "Spooky" },
    multiSelect = true,
    flag        = "PingBiomes",
    callback    = function(sel) Config.PingBiomes = sel end,
})

TabWebhook:CreateToggle({
    name        = "Ping on Gear Crafted",
    description = "Sends a Discord embed whenever a gear is successfully crafted",
    flag        = "PingOnCraft",
    callback    = function(v) Config.PingOnCraft = v end,
})

TabWebhook:CreateToggle({
    name        = "Ping on High Rarity Aura",
    description = "Pings Discord when a rolled aura exceeds the rarity threshold",
    flag        = "PingOnAura",
    callback    = function(v) Config.PingOnAura = v end,
})

TabWebhook:CreateInput({
    name        = "Minimum Aura Rarity (1 in X)",
    description = "Type the minimum rarity number (e.g. 100000 for 1 in 100,000)",
    numeric     = true,
    value       = "100000",
    placeholder = "e.g. 100000",
    flag        = "AuraThresholdInput",
    callback    = function(text)
        local num = tonumber(text)
        if num and num > 0 then
            Config.AuraThreshold = num
        end
    end,
})

-- ===================================================================
-- TAB 6 — MISC & CODES
-- ===================================================================
local TabMisc = Window:CreateTab({ name = "Misc & Codes", icon = 10734919950 })

TabMisc:CreateButton({
    name        = "Redeem All Active Codes",
    description = "Automatically redeems all known game promo codes",
    callback    = function()
        if not R_CodeRedeem then
            SafeNotify("Codes", "Redeem remote not found!")
            return
        end
        SafeNotify("Codes", "Redeeming all codes...", 3)
        task.spawn(function()
            for _, code in ipairs(KnownCodes) do
                pcall(function() R_CodeRedeem:FireServer(code) end)
                task.wait(0.3)
            end
            SafeNotify("Codes", "Finished code redemption cycle!")
        end)
    end,
})

TabMisc:CreateInput({
    name        = "Custom Code Redeem",
    placeholder = "Type custom code here...",
    callback    = function(codeText)
        if codeText ~= "" and R_CodeRedeem then
            pcall(function() R_CodeRedeem:FireServer(codeText) end)
            SafeNotify("Code Sent", "Submitted code: " .. codeText)
        end
    end,
})

TabMisc:CreateButton({
    name        = "Accept All Inactive Quests Now",
    description = "Fetches all quest data & activates any un-accepted quests",
    callback    = function()
        if not R_QuestStatus or not R_QuestActivate then
            SafeNotify("Quests", "Quest remotes not found!")
            return
        end
        local ok, status = pcall(function() return R_QuestStatus:InvokeServer() end)
        if ok and type(status) == "table" then
            local count = 0
            for _, q in ipairs(status) do
                if q.active == false and not q.isComplete and q.id then
                    pcall(function() R_QuestActivate:FireServer(q.id) end)
                    count = count + 1
                    task.wait(0.2)
                end
            end
            if R_EgoQuestStart then pcall(function() R_EgoQuestStart:FireServer() end) end
            if R_AlmightyStart then pcall(function() R_AlmightyStart:FireServer() end) end
            if R_AizenStart    then pcall(function() R_AizenStart:FireServer() end)    end
            SafeNotify("Quests Accepted", "Accepted " .. tostring(count) .. " quests!")
        else
            SafeNotify("Quests", "Could not fetch quest list.")
        end
    end,
})

-- ===================================================================
-- BACKEND UTILITIES
-- ===================================================================

local function SendWebhook(title, desc, color)
    if Config.WebhookURL == "" then return end
    local req = (syn and syn.request) or (http and http.request) or http_request
                or (fluxus and fluxus.request) or request
    if not req then return end
    pcall(req, {
        Url     = Config.WebhookURL,
        Method  = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body    = HttpService:JSONEncode({
            username = "Nebula RNG Bot",
            embeds   = {{
                title       = title,
                description = desc,
                color       = color or 0x00FFFF,
                footer      = { text = "Nebula Hub • " .. (LocalPlayer and LocalPlayer.Name or "?") },
            }},
        }),
    })
end

-- =========================================================
-- LOOP 1: POTION AUTO-COLLECT
-- =========================================================
task.spawn(function()
    while task.wait(1.2) do
        if not Config.AutoCollect then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end

        for _, obj in ipairs(workspace:GetChildren()) do
            if not obj:IsA("Model") then continue end
            local name = obj.Name:lower()
            if not (string.find(name, "potion") or string.find(name, " pot")) then continue end

            local pp = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
            if not pp or not pp.Enabled then continue end

            local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if not primary then continue end

            hrp.CFrame = primary.CFrame * CFrame.new(0, 3, 4)
            task.wait(0.15)
            pcall(fireproximityprompt, pp)
            task.wait(0.3)
        end
    end
end)

-- =========================================================
-- LOOP 2: AUTO OBBY
-- =========================================================
task.spawn(function()
    while task.wait(5) do
        if not Config.AutoObby then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end

        local orb = workspace:FindFirstChild("Part36")
        if not orb then continue end

        local pp = orb:FindFirstChildWhichIsA("ProximityPrompt", true)
        if not pp then continue end

        hrp.CFrame = orb.CFrame * CFrame.new(0, 3, 0)
        task.wait(0.2)
        pcall(fireproximityprompt, pp)
    end
end)

-- =========================================================
-- LOOP 3: AUTO CLAIM & ACCEPT QUESTS
-- =========================================================
task.spawn(function()
    while task.wait(20) do
        if Config.AutoQuests then
            if R_QuestClaim       then pcall(R_QuestClaim.FireServer,      R_QuestClaim)       end
            task.wait(0.5)
            if R_QuestClaimPower  then pcall(R_QuestClaimPower.FireServer, R_QuestClaimPower)  end
            task.wait(0.5)
            if R_DailyClaim       then pcall(R_DailyClaim.FireServer,      R_DailyClaim)       end
        end

        if Config.AutoAcceptQuests and R_QuestStatus and R_QuestActivate then
            local ok, status = pcall(function() return R_QuestStatus:InvokeServer() end)
            if ok and type(status) == "table" then
                for _, q in ipairs(status) do
                    if q.active == false and not q.isComplete and q.id then
                        pcall(function() R_QuestActivate:FireServer(q.id) end)
                        task.wait(0.2)
                    end
                end
            end
            if R_EgoQuestStart then pcall(function() R_EgoQuestStart:FireServer() end) end
            if R_AlmightyStart then pcall(function() R_AlmightyStart:FireServer() end) end
            if R_AizenStart    then pcall(function() R_AizenStart:FireServer() end)    end
        end
    end
end)

-- =========================================================
-- LOOP 4: AUTO CRAFT
-- =========================================================
task.spawn(function()
    local pg = LocalPlayer:WaitForChild("PlayerGui")

    local function tryGetCraftUI(guiName)
        local g = pg:FindFirstChild("Game")
        if not g then return nil end
        local cGui = g:FindFirstChild(guiName)
        if not cGui then return nil end
        local cf = cGui:FindFirstChild("Dframe")
        if not cf then return nil end
        local desf = cf:FindFirstChild("DesF")
        if not desf then return nil end
        local craftF = desf:FindFirstChild("CraftingF")
        if not craftF then return nil end
        local addAll  = craftF:FindFirstChild("AddAllButton")
        local craftBtn = craftF:FindFirstChild("CraftButton")
        local progFrame = desf:FindFirstChild("MainFrame")
            and desf.MainFrame:FindFirstChild("ScrollF")
            and desf.MainFrame.ScrollF:FindFirstChild("ReqF")
            and desf.MainFrame.ScrollF.ReqF:FindFirstChild("ProgressFrame")
        local prog = progFrame and progFrame:FindFirstChild("Prog")
        return addAll, craftBtn, prog
    end

    local craftingGUIs = {"Crafting", "CraftingBetter", "CraftingRelics", "CraftingItems"}
    local lastCraftClick = 0

    while task.wait(1.5) do
        if not Config.AutoCraft then continue end

        for _, guiName in ipairs(craftingGUIs) do
            local addAll, craftBtn, prog = tryGetCraftUI(guiName)
            if not addAll or not craftBtn then continue end

            pcall(function() addAll.MouseButton1Click:Fire() end)
            task.wait(0.5)

            if prog and prog.Size.X.Scale >= 0.99 then
                if os.clock() - lastCraftClick > 3.5 then
                    lastCraftClick = os.clock()
                    pcall(function() craftBtn.MouseButton1Click:Fire() end)
                end
            end
        end
    end
end)

-- =========================================================
-- LOOP 5: AUTO FISHING – SHAKE MONITOR
-- =========================================================
task.spawn(function()
    while task.wait(0.3) do
        if not Config.AutoFish then continue end
        if R_FishShake then
            pcall(R_FishShake.FireServer, R_FishShake)
        end
    end
end)

-- =========================================================
-- ESP RENDER LOOP
-- =========================================================
RunService.RenderStepped:Connect(function()
    if Config.PotionESP then
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj:IsA("Model") then
                local nm = obj.Name:lower()
                if (string.find(nm, "potion") or string.find(nm, " pot")) then
                    if not ESPCache.Potions[obj] then
                        local h = Instance.new("Highlight")
                        h.FillColor    = Color3.fromRGB(0, 230, 180)
                        h.OutlineColor = Color3.fromRGB(255, 255, 255)
                        h.FillTransparency = 0.4
                        h.Parent       = obj
                        ESPCache.Potions[obj] = h
                    end
                end
            end
        end
    end

    if Config.NPCESP then
        for _, obj in ipairs(workspace:GetChildren()) do
            if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                if obj:FindFirstChildWhichIsA("Humanoid") and not Players:GetPlayerFromCharacter(obj) then
                    if not ESPCache.NPCs[obj] then
                        local h = Instance.new("Highlight")
                        h.FillColor    = Color3.fromRGB(255, 165, 0)
                        h.OutlineColor = Color3.fromRGB(255, 255, 255)
                        h.FillTransparency = 0.5
                        h.Parent       = obj
                        ESPCache.NPCs[obj] = h
                    end
                end
            end
        end
    end
end)

-- =========================================================
-- WEBHOOK LISTENERS
-- =========================================================

-- Craft Completed Event (Server-Verified)
if R_CraftCompleted then
    R_CraftCompleted.OnClientEvent:Connect(function(itemName)
        if Config.PingOnCraft then
            local itemStr = (type(itemName) == "string" and itemName ~= "") and itemName or "Gear Item"
            SendWebhook("⚒️ Gear Crafted!", "Successfully completed crafting for **" .. itemStr .. "**!", 0x00FF88)
        end
    end)
end

-- Biome Spawn Ping
if R_BiomeChanged then
    R_BiomeChanged.OnClientEvent:Connect(function(biomeName)
        if type(biomeName) ~= "string" then return end
        for _, b in ipairs(Config.PingBiomes) do
            if b:lower() == biomeName:lower() then
                SendWebhook(
                    "🌍 Biome Spawned: " .. biomeName,
                    "The **" .. biomeName .. "** biome has spawned on server `" .. (game.JobId or "?") .. "`",
                    0x8844FF
                )
                break
            end
        end
    end)
end

-- Roll:Result Ping for High Rarity Auras
if R_RollResult then
    R_RollResult.OnClientEvent:Connect(function(data)
        if not Config.PingOnAura then return end
        if type(data) ~= "table" then return end
        local rarity = data.rarity or data.Rarity or data.chance or data.Chance
        local name   = data.name   or data.Name   or data.auraName or "Unknown"
        if type(rarity) == "number" and rarity >= Config.AuraThreshold then
            SendWebhook(
                "✨ Rare Aura Rolled!",
                "Rolled **" .. name .. "** with a rarity of **1 in " .. tostring(rarity) .. "**!",
                0xFFDD00
            )
        end
    end)
end

SafeNotify("Nebula Hub Loaded", "Misc & Codes tab added with Auto Redeem & Auto Accept!")
print("[Nebula Hub] Loaded successfully!")

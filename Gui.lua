    local router
    for i, v in next, getgc(true) do
        if type(v) == 'table' and rawget(v, 'get_remote_from_cache') then
            router = v
        end
    end
    
    local function rename(remotename, hashedremote)
        hashedremote.Name = remotename
    end
    table.foreach(debug.getupvalue(router.get_remote_from_cache, 1), rename)
    local ClientData = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
    local PetData = ClientData.get_data()[game.Players.LocalPlayer.Name].inventory.pets
    
    getgenv().PetFarmGuiStarter = false
    _G.key = nil
    local petToEquipForFarming 
    local petOptions = {}
    local petToEquip
    
    -- Replaced version (https://github.com/Hiraeth127/WorkingVersions.lua/blob/main/FarmPet105c.lua)
    -- Currrent version FarmPet105d.lua
    
    if not _G.ScriptRunning then
        _G.ScriptRunning = true
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        local CoreGui = game:GetService("CoreGui")
        local PlayerGui = Player:FindFirstChildOfClass("PlayerGui") or CoreGui
        local LiveOpsMapSwap = require(game:GetService("ReplicatedStorage").SharedModules.Game.LiveOpsMapSwap)
    
        local playButton = game:GetService("Players").LocalPlayer.PlayerGui.NewsApp.EnclosingFrame.MainFrame.Contents.PlayButton
        local babyButton = game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby
        local rbxProductButton = game:GetService("Players").LocalPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Buttons.ButtonTemplate
        local claimButton = game:GetService("Players").LocalPlayer.PlayerGui.DailyLoginApp.Frame.Body.Buttons.ClaimButton
    
        local router
        for i, v in next, getgc(true) do
            if type(v) == 'table' and rawget(v, 'get_remote_from_cache') then
                router = v
            end
        end
        local function rename(remotename, hashedremote)
            hashedremote.Name = remotename
        end
        -- Apply renaming to upvalues of the RouterClient.init function
        table.foreach(debug.getupvalue(router.get_remote_from_cache, 1), rename)
    
    
        local object = game.ServerScriptService -- Replace this with the correct object path
    
        if object:FindFirstChild("AllowRJ") then
            object.AllowRJ.Value = false
        else
            print("AllowRJ property not found")
        end
    
        task.wait(3)
        local xc = 0
        local NewAcc = false
        local HasTradeLic = false
        local ClientData = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
        local Cash = ClientData.get_data()[game.Players.LocalPlayer.Name].money
    
        if Cash <= 125 then
            if ClientData.get_data()[game.Players.LocalPlayer.Name].inventory.toys then 
                for i, v in pairs(ClientData.get_data()[game.Players.LocalPlayer.Name].inventory.toys) do
                    xc = xc + 1
                    if v.id == "trade_license" then
                        game:GetService("ReplicatedStorage").API:FindFirstChild("SettingsAPI/SetSetting"):FireServer("theme_color","blue")
                        game:GetService("ReplicatedStorage").API:FindFirstChild("LegacyTutorialAPI/SetTutorialInProgressBool"):FireServer(true)
                        game:GetService("ReplicatedStorage").API:FindFirstChild("LegacyTutorialAPI/StashTutorialStatus"):FireServer("Avatar Tutorial Started")
                        game:GetService("ReplicatedStorage").API:FindFirstChild("LegacyTutorialAPI/StashTutorialStatus"):FireServer("Avatar Editor Opened")
                        game:GetService("ReplicatedStorage").API:FindFirstChild("AvatarAPI/SetGender"):FireServer("male")
                        game:GetService("ReplicatedStorage").API:FindFirstChild("LegacyTutorialAPI/StashTutorialStatus"):FireServer("Avatar Editor Closed")
                        game:GetService("ReplicatedStorage").API:FindFirstChild("LegacyTutorialAPI/StashTutorialStatus"):FireServer("Housing Tutorial Started")
                        game:GetService("ReplicatedStorage").API:FindFirstChild("LegacyTutorialAPI/StashTutorialStatus"):FireServer("Housing Editor Opened")
                        game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/SendHousingOnePointOneLog"):FireServer("edit_state_entered",{["house_type"] = "mine"})
                        game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/SendHousingOnePointOneLog"):FireServer("edit_state_exited",{})
                        game:GetService("ReplicatedStorage").API:FindFirstChild("LegacyTutorialAPI/MarkTutorialCompleted"):FireServer()
                        game:GetService("ReplicatedStorage").API:FindFirstChild("LegacyTutorialAPI/StashTutorialStatus"):FireServer("House Exited")
                        game:GetService("ReplicatedStorage").API:FindFirstChild("SettingsAPI/SetBooleanFlag"):FireServer("showed_twitter_prompt",true)
                        game:GetService("ReplicatedStorage").API:FindFirstChild("SettingsAPI/SetBooleanFlag"):FireServer("showed_youtube_prompt",true)
                        game:GetService("ReplicatedStorage").API:FindFirstChild("SettingsAPI/SetBooleanFlag"):FireServer("roblox_classic_event_dialog_shown",true)
                        game:GetService("ReplicatedStorage").API:FindFirstChild("SettingsAPI/SetBooleanFlag"):FireServer("tutorial_v2_completed",true)
                        game:GetService("ReplicatedStorage").API:FindFirstChild("SettingsAPI/SetBooleanFlag"):FireServer("tutorial_v3_completed",true)
                        Player:Kick("Tutorial completed please restart game!")
                        HasTradeLic = true
                    end
                end
            else
                if not HasTradeLic then
                    NewAcc = true
                end
            end
        end
    
        local maxWaitTime = 20   -- Maximum wait time in seconds
        local waitInterval = 0.5 -- Wait interval in seconds
    
        -- Function to find a child by its path
        local function find_child_by_path(root, path)
            if not root or typeof(path) ~= "table" then
                -- print("Invalid root or path for find_child_by_path")
                return nil
            end
    
            local current = root
            local index = 1
            while path[index] do
                local name = path[index]
                if not current then
                    -- print("Path broken at index " .. index .. ": " .. tostring(name))
                    return nil
                end
                current = current:FindFirstChild(name)
                index = index + 1
            end
            return current
        end
    
        -- Function to fire all connections on a specific event
        local function fireConnections(button, eventType)
            if not button or not button[eventType] then
                -- print("Invalid button or eventType for fireConnections")
                return
            end
    
            local connections = getconnections(button[eventType])
            if typeof(connections) ~= "table" then
                -- print("Connections is not a table for eventType: " .. eventType)
                return
            end
    
            local index = 1
            while connections[index] do
                local connection = connections[index]
                connection:Fire()
                index = index + 1
            end
        end
    
        -- Function to click a button by firing its events
        local function click_button_all(button)
            if not button then
                -- print("Button is nil or not found!")
                return
            end
    
            fireConnections(button, "MouseButton1Down")
            fireConnections(button, "MouseButton1Up")
            fireConnections(button, "MouseButton1Click")
        end
    
        -- Function to handle a specific app's button logic
        local function handleApp(appData)
            if typeof(appData) ~= "table" then
                -- print("Invalid appData, expected table but got " .. typeof(appData))
                return
            end
    
            local appName = appData.appName
            local targetPath = appData.targetPath
            local checkType = appData.checkType
            local visibilityPath = appData.visibilityPath
    
            local app = PlayerGui:FindFirstChild(appName)
            if app then
                local target = find_child_by_path(app, targetPath)
                if target then
                    local shouldClick = false
                    if checkType == "enabled" then
                        shouldClick = app.Enabled
                    elseif checkType == "visibility" then
                        local visibleTarget = find_child_by_path(PlayerGui, visibilityPath)
                        shouldClick = visibleTarget and visibleTarget.Visible
                    end
    
                    if shouldClick then
                        -- print("Clicking button in app: " .. appName)
                        click_button_all(target)
                    else
                        -- print("Conditions not met for app: " .. appName)
                    end
                else
                    -- print("Target not found in app: " .. appName)
                end
            else
                -- print("App not found: " .. appName)
            end
        end
    
        -- Function to monitor prompts and click buttons based on conditions
        local function prompt_monitor_clicker()
            local elapsedTime = 0
    
            -- Define the apps and buttons to monitor
            local appPaths = {
                {
                    appName = "NewsApp",
                    targetPath = { "EnclosingFrame", "MainFrame", "Contents", "PlayButton" },
                    checkType = "enabled",
                },
                {
                    appName = "DialogApp",
                    targetPath = { "Dialog", "RoleChooserDialog", "Baby" },
                    checkType = "visibility",
                    visibilityPath = { "DialogApp", "Dialog", "RoleChooserDialog" },
                },
                {
                    appName = "DialogApp",
                    targetPath = { "Dialog", "RobuxProductDialog", "Buttons", "ButtonTemplate" },
                    checkType = "visibility",
                    visibilityPath = { "DialogApp", "Dialog", "RobuxProductDialog" },
                },
            }
    
            local appIndex = 1
            local appCount = #appPaths
    
            while elapsedTime < maxWaitTime do
                appIndex = 1
                while appIndex <= appCount do
                    local appData = appPaths[appIndex]
                    -- print("Handling appData at index: " .. appIndex)
                    if typeof(appData) == "table" then
                        handleApp(appData)
                    else
                        -- print("Invalid appData at index: " .. appIndex)
                    end
                    appIndex = appIndex + 1
                end
                task.wait(waitInterval)
                elapsedTime = elapsedTime + waitInterval
            end
    
            -- print("Finished monitoring prompts after " .. tostring(maxWaitTime) .. " seconds.")
            return true
        end
    
        -- Start monitoring and clicking
        prompt_monitor_clicker()
    
        -- Function to get current money value
        local function getCurrentMoney()
            local currentMoneyText = Player.PlayerGui.BucksIndicatorApp.CurrencyIndicator.Container.Amount.Text
            local sanitizedMoneyText = currentMoneyText:gsub(",", ""):gsub("%s+", "")
            local currentMoney = tonumber(sanitizedMoneyText)
            if currentMoney == nil then
                return 0
            end
            return currentMoney
        end
    
    
        local function FireSig(button)
            pcall(function()
                for _, connection in pairs(getconnections(button.MouseButton1Down)) do
                    connection:Fire()
                end
                task.wait(0.1)
                for _, connection in pairs(getconnections(button.MouseButton1Up)) do
                    connection:Fire()
                end
                for _, connection in pairs(getconnections(button.MouseButton1Click)) do
                    connection:Fire()
                    -- print(button.Name.." clicked!")
                end
            end)
        end
    
        task.wait(3)
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        local focusPetApp = Player.PlayerGui.FocusPetApp.Frame
        local ailments = focusPetApp.Ailments
        local ClientData = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
    
        getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
    
    
        local virtualUser = game:GetService("VirtualUser")
    
        Player.Idled:Connect(function()
            virtualUser:CaptureController()
            virtualUser:ClickButton2(Vector2.new())
        end)
    
        -- ###########################################################################################################
    
    
        local function GetFurniture(furnitureName)
            local furnitureFolder = workspace.HouseInteriors.furniture
    
            if furnitureFolder then
                for _, child in pairs(furnitureFolder:GetChildren()) do
                    if child:IsA("Folder") then
                        for _, grandchild in pairs(child:GetChildren()) do
                            if grandchild:IsA("Model") then
                                if grandchild.Name == furnitureName then
                                    local furnitureUniqueValue = grandchild:GetAttribute("furniture_unique")
                                    --print("Grandchild Model:", grandchild.Name)
                                    --print("furniture_unique:", furnitureUniqueValue)
                                    return furnitureUniqueValue
                                end
                            end
                        end
                    end
                end
            end
        end
    
        getgenv().fsysCore = require(game:GetService("ReplicatedStorage").ClientModules.Core.InteriorsM.InteriorsM)
    
    
        -- ########################################################################################################################################################################
    
        
    
        local levelOfPet = 0
    
        local function  getHighestLevelPet()
            for i, v in pairs(fsys.get("inventory").pets) do
                if levelOfPet < v.properties.age and v.kind ~= "practice_dog" then
                    levelOfPet = v.properties.age
                    petToEquip = v.unique
                    if levelOfPet >= 6 then
                        return petToEquip
                    end
                end
            end
            return petToEquip
        end
        -- local petToEquip
        -- getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
        -- for i, v in pairs(fsys.get("inventory").pets) do
        --     if v.kind == petToEquipForFarming then
        --         petToEquip = v.unique
        --         break
        --     elseif levelOfPet < v.properties.age and v.kind ~= "practice_dog" then
        --         levelOfPet = v.properties.age
        --         petToEquip = v.unique
        --     end
        -- end
    
        -- if petToEquip == nil and not  then
        --     local args = {
        --         [1] = "pets",
        --         [2] = "cracked_egg",
        --         [3] = {
        --             ["buy_count"] = 1
        --         }
        --     }
            
        --     game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
        -- end
    
        -- Check if pcall was successful
        local function equipPet()
            
            -- getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
            -- if fsys.get("equip_manager").pets[1] and fsys.get("equip_manager").pets[1].kind and petToEquipForFarming ~= fsys.get("equip_manager").pets[1].kind then 
            --     print("pettoequip is different from equipped")
            --     for i, v in pairs(fsys.get("inventory").pets) do
            --         if v.kind == petToEquipForFarming then
            --             petToEquip = v.unique
            --             break
            --         end
            --     end
            
            -- Ensure fsys is assigned safely
            local success, fsys = pcall(function()
                return require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
            end)
            
            if not success or not fsys then
                warn("Failed to require fsys")
                return
            end
            
            -- Main logic
            if petToEquipForFarming then
                local equipManager = fsys.get("equip_manager")
                local equipManagerPets = equipManager and equipManager.pets
            
                if equipManagerPets and equipManagerPets[1] and equipManagerPets[1].kind then
                    local currentPetKind = equipManagerPets[1].kind
                    local currentPetUnique = equipManagerPets[1].unique
            
                    -- Check if we need to set petToEquip
                    if petToEquip == nil or (currentPetUnique ~= petToEquip and currentPetKind ~= petToEquipForFarming) then
                        local inventory = fsys.get("inventory")
                        local inventoryPets = inventory and inventory.pets
                        local foundPet = false
            
                        for _, pet in pairs(inventoryPets or {}) do
                            if pet.kind == petToEquipForFarming then
                                petToEquip = pet.unique
                                foundPet = true
                                break
                            end
                            petToEquip = getHighestLevelPet() --returns the unique
                        end
            
                        if not foundPet then
                            warn("No pets of kind '" .. tostring(petToEquipForFarming) .. "' found in inventory!")
                        end
                    end
                else
                    warn("equip_manager or equip_manager.pets[1] is nil")
                end
            end
            
    
            if petToEquip then
                game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ToolAPI/Unequip"):InvokeServer(petToEquip, {["use_sound_delay"] = true, ["equip_as_last"] = false})
                task.wait(.3)
                game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ToolAPI/Equip"):InvokeServer(petToEquip, {["use_sound_delay"] = true, ["equip_as_last"] = false})
            end
            PetAilmentsArray = {}
            
            print(petToEquipForFarming)
            print(petToEquip)
        end
    
        -- Check if pcall was successful
        local function unequipPet()
            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
            if fsys.get("equip_manager").pets[1] and fsys.get("equip_manager").pets[1].kind and petToEquipForFarming ~= fsys.get("equip_manager").pets[1].kind then
                for i, v in pairs(fsys.get("inventory").pets) do
                    if levelOfPet < v.properties.age and v.kind ~= "practice_dog" then
                        levelOfPet = v.properties.age
                        petToEquip = v.unique
                        if levelOfPet >= 6 then
                            break
                        end
                    end
                end
            end
            if petToEquip then
                game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ToolAPI/Equip"):InvokeServer(petToEquip, {["use_sound_delay"] = true, ["equip_as_last"] = false})
                task.wait(.3)
                game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ToolAPI/Unequip"):InvokeServer(petToEquip, {["use_sound_delay"] = true, ["equip_as_last"] = false})
            
            end
        end
    
    
        local function createPlatformForce()
            
                local Player = game.Players.LocalPlayer
                local character = Player.Character or Player.CharacterAdded:Wait()
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
                -- Count existing platforms in the workspace
                local existingPlatforms = 0
                for _, object in pairs(workspace:GetChildren()) do
                    if object.Name == "CustomPlatformForce" then
                        existingPlatforms += 1
                    end
                end
    
                -- Check if the number of platforms exceeds 5
                -- if existingPlatforms >= 5 then
                --     --print("Maximum number of platforms reached, skipping creation.")
                --     return
                -- end
    
                -- Debug message
                --print("Teleport successful, creating platform...")
    
                -- Create the platform part
                local platform = Instance.new("Part")
                platform.Name = "CustomPlatform" -- Unique name to identify the platform
                platform.Size = Vector3.new(1100, 1, 1100) -- Size of the platform
                platform.Anchored = true -- Make sure the platform doesn't fall
                platform.CFrame = humanoidRootPart.CFrame * CFrame.new(0, -5, 0) -- Place 5 studs below the player
    
                -- Set part properties
                platform.BrickColor = BrickColor.new("Bright yellow") -- You can change the color
                platform.Parent = workspace -- Parent to the workspace so it's visible
                equipPet()
        end
    
    
    
        -- ########################################################################################################################################################################
    
        local function createPlatform()
                local Player = game.Players.LocalPlayer
                local character = Player.Character or Player.CharacterAdded:Wait()
                local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
                -- Count existing platforms in the workspace
                local existingPlatforms = 0
                for _, object in pairs(workspace:GetChildren()) do
                    if object.Name == "CustomPlatform" then
                        existingPlatforms += 1
                    end
                end
    
                -- Check if the number of platforms exceeds 5
                if existingPlatforms >= 5 then
                    --print("Maximum number of platforms reached, skipping creation.")
                    return
                end
    
                -- Debug message
                --print("Teleport successful, creating platform...")
    
                -- Create the platform part
                local platform = Instance.new("Part")
                platform.Name = "CustomPlatform" -- Unique name to identify the platform
                platform.Size = Vector3.new(1100, 1, 1100) -- Size of the platform
                platform.Anchored = true -- Make sure the platform doesn't fall
                platform.CFrame = humanoidRootPart.CFrame * CFrame.new(0, -5, 0) -- Place 5 studs below the player
    
                -- Set part properties
                platform.BrickColor = BrickColor.new("Bright yellow") -- You can change the color
                platform.Parent = workspace -- Parent to the workspace so it's visible
        end
    
        local function teleportToMainmap()
            local targetCFrame = CFrame.new(-275.9091491699219, 25.812084197998047, -1548.145751953125, -0.9798217415809631, 0.0000227206928684609, 0.19986890256404877, -0.000003862579433189239, 1, -0.00013261348067317158, -0.19986890256404877, -0.00013070966815575957, -0.9798217415809631)
            local OrigThreadID = getthreadidentity()
            task.wait(1)
            setidentity(2)
            task.wait(1)
            fsysCore.enter_smooth("MainMap", "MainDoor", {
                ["spawn_cframe"] = targetCFrame * CFrame.Angles(0, 0, 0)
            })
            setidentity(OrigThreadID)
        end
    
        local function teleportPlayerNeeds(x, y, z)
            local Player = game.Players.LocalPlayer
            if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                Player.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z) 
            else
                --print("Player or character not found!")
            end
        end
    
        local function BabyJump()
            game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("AdoptAPI/BabyJump"):FireServer(fsys.get("char_wrapper")["char"])
        end
    
    
    
        getgenv().BedID = GetFurniture("EggCrib")
        getgenv().ShowerID = GetFurniture("StylishShower")
        getgenv().PianoID = GetFurniture("Piano")
        getgenv().WaterID = GetFurniture("PetWaterBowl")
        getgenv().FoodID = GetFurniture("PetFoodBowl")
        getgenv().ToiletID = GetFurniture("Toilet")
    
        -- Get current money
        local startingMoney = getCurrentMoney()
        local function buyItems()
            if BedID == nil then 
                if startingMoney > 100 then
                    --print("Buying required crib")
                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(33.5, 0, -30) * CFrame.Angles(-0, -1.57, 0)},["kind"] = "egg_crib"}})
                    task.wait(1)
                    getgenv().BedID = GetFurniture("EggCrib")
                    startingMoney = getCurrentMoney()
                else 
                    print("Not Enough money to buy bed.")
                end
            end 
            if ShowerID == nil then
                if startingMoney > 13 then
                    --print("Buying Required Shower")
                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(34.5, 0, -8.5) * CFrame.Angles(0, 1.57, 0)},["kind"] = "stylishshower"}})
                    task.wait(1)
                    getgenv().ShowerID = GetFurniture("StylishShower")
                    startingMoney = getCurrentMoney()
                else
                    print("Not Enough money to buy shower")
                end
            end 
            if PianoID == nil then
                if startingMoney > 100 then
                    --print("Buying Required Piano")
                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(7.5, 7.5, -5.5) * CFrame.Angles(-1.57, 0, -0)},["kind"] = "piano"}})
                    task.wait(1)
                    getgenv().PianoID = GetFurniture("Piano")
                    startingMoney = getCurrentMoney()
                else
                    print("Not Enough money to buy piano")
                end
            end 
            if WaterID == nil then 
                if startingMoney > 80 then
                    --print("Buying required crib")
                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(30.5, 0, -20) * CFrame.Angles(-0, -1.57, 0)},["kind"] = "pet_water_bowl"}})
                    task.wait(1)
                    getgenv().WaterID = GetFurniture("PetWaterBowl")
                    startingMoney = getCurrentMoney()
                else
                    print("Not Enough money to buy water")
                end
            end
            if FoodID == nil then 
                if startingMoney > 80 then
                    --print("Buying required crib")
                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(30.5, 0, -20) * CFrame.Angles(-0, -1.57, 0)},["kind"] = "pet_food_bowl"}})
                    task.wait(1)
                    getgenv().FoodID = GetFurniture("PetFoodBowl")
                    startingMoney = getCurrentMoney()
                else
                    print("Not Enough money to buy food")
                end
            end
            if ToiletID == nil then 
                if startingMoney > 9 then
                    --print("Buying required crib")
                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(30.5, 0, -20) * CFrame.Angles(-0, -1.57, 0)},["kind"] = "toilet"}})
                    task.wait(1)
                    getgenv().ToiletID = GetFurniture("Toilet")
                    startingMoney = getCurrentMoney()
                else
                    print("Not Enough money to buy toilet")
                end
            end
        end
    
        local function removeItemByValue(tbl, value)
            for i = 1, #tbl do
                if tbl[i] == value then
                    table.remove(tbl, i)
                    break
                end
            end
        end
    
    
        -- ########################################################################################################################################################################
    
        -- Define the new path
        -- local ailments_list = Player.PlayerGui:WaitForChild("ailments_list")
    
        local function get_mystery_task()
            local ClientData = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
            local PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
    
            for ailmentId, ailment in pairs(PetAilmentsData) do
                for taskId, task in pairs(ailment) do
                    if task.kind == "mystery" and task.components and task.components.mystery then
                        local ailmentKey = task.components.mystery.ailment_key
                        local foundMystery = false
    
                        for i = 1, 3 do
                            if foundMystery then break end
    
                            wait(0.5)
                            pcall(function()
                                local actions = {"hungry", "thirsty", "sleepy", "toilet", "bored", "dirty", "play", "school", "salon", "pizza_party", "sick", "camping", "beach_party", "walk", "ride"}
                                
                                for _, action in ipairs(actions) do
                                    if not PetAilmentsData[ailmentId] or not PetAilmentsData[ailmentId][taskId] then
                                        --print("Mystery task not found anymore.")
                                        foundMystery = true
                                        break
                                    end
    
                                    wait(0.5)
                                    local args = {
                                        [1] = ailmentKey,
                                        [2] = i,
                                        [3] = action
                                    }
    
                                    game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("AilmentsAPI/ChooseMysteryAilment"):FireServer(unpack(args))
                                end
                            end)
                        end
                    end
                end
            end
        end
    
        local PetAilmentsArray = {}
        local BabyAilmentsArray = {}
        local ClientData = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
        local PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
        local BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
    
        local function getAilments(tbl)
            PetAilmentsArray = {}
            for key, value in pairs(tbl) do
                if key == petToEquip then
                    for subKey, subValue in pairs(value) do
                        table.insert(PetAilmentsArray, subValue.kind)
                        --print("ailment added: ", subValue.kind)
                    end
                end
            end
        end
    
        Player.PlayerGui.TransitionsApp.Whiteout:GetPropertyChangedSignal("BackgroundTransparency"):Connect(function()
            if Player.PlayerGui.TransitionsApp.Whiteout.BackgroundTransparency == 0 then
                Player.PlayerGui.TransitionsApp.Whiteout.BackgroundTransparency = 1
            end
        end)
    
        local function getBabyAilments(tbl)
            BabyAilmentsArray = {}
            for key, value in pairs(tbl) do
                table.insert(BabyAilmentsArray, key)
                --print("Baby ailment: ", key)
            end
        end
    
        -- Function to buy an item
        local function buyItem(itemName)
            local args = {
                [1] = "food",
                [2] = itemName,
                [3] = { ["buy_count"] = 1 }
            }
            game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
        end
    
        -- Function to get the ID of a specific food item
        local function getFoodID(itemName)
            local ailmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].inventory.food
            for key, value in pairs(ailmentsData) do
                if value.id == itemName then
                    return key
                end
            end
            return nil
        end
    
        -- Function to use an item multiple times
        local function useItem(itemID, useCount)
            for i = 1, useCount do
                local args = {
                    [1] = itemID,
                    [2] = "END"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ToolAPI/ServerUseTool"):FireServer(unpack(args))
                task.wait(0.1)
            end
        end
    
        local function hasTargetAilment(targetKind)
            local ailments = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
            for _, ailment in pairs(ailments) do
                if ailment.kind == targetKind then
                    return true
                end
            end
            return false
        end
    
    
    
        task.wait(2)
        -- ########################################################################################################################################################################
        local taskName = "none"
        local function EatDrink(isEquippedPet)
            if isEquippedPet then
                equipPet()
            end
            task.wait(1)
            if table.find(PetAilmentsArray, "hungry") then
                --print("doing hungry")
                taskName = "🍔"
                getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                if getgenv().FoodID then
                    game:GetService("ReplicatedStorage").API["HousingAPI/ActivateFurniture"]:InvokeServer(game:GetService("Players").LocalPlayer,getgenv().FoodID,"UseBlock",{['cframe'] = CFrame.new(game:GetService("Players").LocalPlayer.Character.Head.Position + Vector3.new(0, .5, 0))},fsys.get("pet_char_wrappers")[1]["char"])
                    repeat task.wait(1)
                    until not hasTargetAilment("hungry")
                else
                    if startingMoney > 80 then
                        --print("Buying required crib")
                        game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(30.5, 0, -20) * CFrame.Angles(-0, -1.57, 0)},["kind"] = "pet_food_bowl"}})
                        task.wait(1)
                        getgenv().FoodID = GetFurniture("PetFoodBowl")
                        startingMoney = getCurrentMoney()
                    else
                        print("Not Enough money to buy food")
                    end
                end
                removeItemByValue(PetAilmentsArray, "hungry")
                PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                getAilments(PetAilmentsData)
                taskName = "none"
                equipPet()
                --print("done hungry")
            end
            if table.find(PetAilmentsArray, "thirsty") then
                --print("doing thristy")
                taskName = "🥛"
                getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                if getgenv().WaterID then
                    game:GetService("ReplicatedStorage").API["HousingAPI/ActivateFurniture"]:InvokeServer(game:GetService("Players").LocalPlayer,getgenv().WaterID,"UseBlock",{['cframe'] = CFrame.new(game:GetService("Players").LocalPlayer.Character.Head.Position + Vector3.new(0, .5, 0))},fsys.get("pet_char_wrappers")[1]["char"])
                    repeat task.wait(1)
                    until not hasTargetAilment("thirsty")
                else
                    if startingMoney > 80 then
                        --print("Buying required crib")
                        game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(30.5, 0, -20) * CFrame.Angles(-0, -1.57, 0)},["kind"] = "pet_water_bowl"}})
                        task.wait(1)
                        getgenv().WaterID = GetFurniture("PetWaterBowl")
                        startingMoney = getCurrentMoney()
                    else
                        print("Not Enough money to buy water")
                    end
                end
                removeItemByValue(PetAilmentsArray, "thirsty")
                PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                getAilments(PetAilmentsData)
                taskName = "none"
                equipPet()
                --print("done thristy")
            end
        end
    
    
        local function EatDrinkSafeCall(isEquippedPet)
            local success = false
    
            while not success do
                success, err = pcall(function()
                    EatDrink(isEquippedPet)
                end)
    
                if not success then
                    warn("Error occurred: ", err)
                    task.wait(1) -- wait for a second before retrying
                end
            end
    
            --print("EatDrink executed successfully without errors.")
        end
    
    
    
    
        -- ########################################################################################################################################################################
        for _, pet in ipairs(workspace.Pets:GetChildren()) do
            --print(pet.Name)
            petName = pet.Name
        end
    
        _G.FarmTypeRunning = "none"
    
        local function startPetFarm()
            game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("TeamAPI/ChooseTeam"):InvokeServer("Babies",{["dont_send_back_home"] = true, ["source_for_logging"] = "avatar_editor"})
            game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("TeamAPI/Spawn"):InvokeServer()
            task.wait(2)
            buyItems()
            task.wait(5)
            local LiveOpsMapSwap = require(game:GetService("ReplicatedStorage").SharedModules.Game.LiveOpsMapSwap)
            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("MainMap",
            game:GetService("Players").LocalPlayer, "Snow")
            teleportPlayerNeeds(0,350,0)
            createPlatform()
            equipPet()
            task.wait(1)
    
            local Players = game:GetService("Players")
            local player = Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local rootPart = character:WaitForChild("HumanoidRootPart")
            
            -- Restore the character to its normal state
            local bodyVelocity = rootPart:FindFirstChildOfClass("BodyVelocity")
            if bodyVelocity then
                bodyVelocity:Destroy() -- Remove BodyVelocity to restore gravity
            end
            
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false -- Allow normal movement and physics
            end   
    
    
            while true do
                while getgenv().PetFarmGuiStarter do
                    _G.FarmTypeRunning = "Pet/Baby"
                    print("inside petfarm")
                    repeat task.wait(5)
                        task.wait(1)
                        equipPet()
                        print("inside repeat oten")
                        PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                        BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                        getAilments(PetAilmentsData)
                        getBabyAilments(BabyAilmentsData)
                        if table.find(PetAilmentsArray, "hungry") or table.find(PetAilmentsArray, "thirsty") then
                            EatDrinkSafeCall(true)
                        end
                        -- print("lapas sa hungry")
        
                        -- Baby hungry
                        if table.find(BabyAilmentsArray, "hungry") then
                            -- Baby hungry
                            startingMoney = getCurrentMoney()
                            if startingMoney > 5 then
                                buyItem("apple")
                                local appleID = getFoodID("apple")
                                useItem(appleID, 3)
                                task.wait(1)
                            end
                            removeItemByValue(BabyAilmentsArray, "hungry")
                            BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                            getBabyAilments(BabyAilmentsData)
                        end
                        
                        -- Baby thirsty
                        if table.find(BabyAilmentsArray, "thirsty") then
                            -- Baby thirsty
                            startingMoney = getCurrentMoney()
                            if startingMoney > 5 then
                                buyItem("tea")
                                local teaID = getFoodID("tea")
                                useItem(teaID, 6)
                                task.wait(1)
                            end
                            removeItemByValue(BabyAilmentsArray, "thirsty")
                            BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                            getBabyAilments(BabyAilmentsData)
                        end
        
                        -- Baby sick
                        if table.find(BabyAilmentsArray, "sick") then
                            -- Baby sick
                            
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("Hospital")
                            task.wait(0.3)
                            teleportPlayerNeeds(0, 350, 0)
                            task.wait(0.3)
                            createPlatform()
                            task.wait(0.3)
                            getgenv().HospitalBedID = GetFurniture("HospitalRefresh2023Bed")
                            task.wait(2)
                            task.spawn(function()
                                game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("HousingAPI/ActivateInteriorFurniture"):InvokeServer(getgenv().HospitalBedID, "Seat1", {["cframe"] = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position)}, fsys.get("char_wrapper")["char"])
                            end)
                            task.wait(15)
                            BabyJump()
                            removeItemByValue(BabyAilmentsArray, "sick")
                            BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                            getBabyAilments(BabyAilmentsData)
                            -- Check if petfarm is true
                            if not getgenv().PetFarmGuiStarter then
                                return -- Exit the function or stop the process if petfarm is false
                            end
                            task.wait(1)
                            task.wait(0.3)
                            local LiveOpsMapSwap = require(game:GetService("ReplicatedStorage").SharedModules.Game.LiveOpsMapSwap)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("MainMap",
                            game:GetService("Players").LocalPlayer, LiveOpsMapSwap.get_current_map_type())
                            task.wait(0.3)
                            teleportPlayerNeeds(0, 350, 0)
                            task.wait(0.3)
                            createPlatform()
                            task.wait(0.3)
                            equipPet()
                            --print("done sick")
                        end
        
                        -- Check if 'school' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "school") or table.find(BabyAilmentsArray, "school") then
                            --print("going school")
                            taskName = "📚"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("School")
                            teleportPlayerNeeds(0, 350, 0)
                            createPlatform()
                            equipPet()
                            repeat task.wait(1)
                            until not hasTargetAilment("school") and not ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments["school"]
                            task.wait(2)
                            removeItemByValue(PetAilmentsArray, "school")
                            removeItemByValue(BabyAilmentsArray, "school")
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                            getAilments(PetAilmentsData)
                            getBabyAilments(BabyAilmentsData)
                            taskName = "none"
                            local LiveOpsMapSwap = require(game:GetService("ReplicatedStorage").SharedModules.Game.LiveOpsMapSwap)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("MainMap",
                            game:GetService("Players").LocalPlayer, LiveOpsMapSwap.get_current_map_type())
                            task.wait(0.3)
                            teleportPlayerNeeds(0, 350, 0)
                            task.wait(0.3)
                            createPlatform()
                            task.wait(0.3)
                            equipPet()
                            --print("done school")
                        end
        
                        -- Check if 'salon' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "salon") or table.find(BabyAilmentsArray, "salon") then
                            --print("going salon")
                            taskName = "✂️"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("Salon")
                            teleportPlayerNeeds(0, 350, 0)
                            createPlatform()
                            equipPet()
                            repeat task.wait(1)
                            until not hasTargetAilment("salon") and not ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments["salon"]
                            task.wait(2)
                            removeItemByValue(PetAilmentsArray, "salon")
                            removeItemByValue(BabyAilmentsArray, "salon")
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                            getAilments(PetAilmentsData)
                            getBabyAilments(BabyAilmentsData)
                            taskName = "none"
                            local LiveOpsMapSwap = require(game:GetService("ReplicatedStorage").SharedModules.Game.LiveOpsMapSwap)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("MainMap",
                            game:GetService("Players").LocalPlayer, LiveOpsMapSwap.get_current_map_type())
                            task.wait(0.3)
                            teleportPlayerNeeds(0, 350, 0)
                            task.wait(0.3)
                            createPlatform()
                            task.wait(0.3)
                            equipPet()
                            --print("done salon")
                        end
                        -- Check if 'pizza_party' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "pizza_party") or table.find(BabyAilmentsArray, "pizza_party") then
                            --print("going pizza")
                            taskName = "🍕"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("PizzaShop")
                            teleportPlayerNeeds(0, 350, 0)
                            createPlatform()
                            equipPet()
                            repeat task.wait(1)
                            until not hasTargetAilment("pizza_party") and not ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments["pizza_party"]
                            task.wait(2)
                            removeItemByValue(PetAilmentsArray, "pizza_party")
                            removeItemByValue(BabyAilmentsArray, "pizza_party")
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                            getAilments(PetAilmentsData)
                            getBabyAilments(BabyAilmentsData)
                            taskName = "none"
                            local LiveOpsMapSwap = require(game:GetService("ReplicatedStorage").SharedModules.Game.LiveOpsMapSwap)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("MainMap",
                            game:GetService("Players").LocalPlayer, LiveOpsMapSwap.get_current_map_type())
                            task.wait(0.3)
                            teleportPlayerNeeds(0, 350, 0)
                            task.wait(0.3)
                            createPlatform()
                            task.wait(0.3)
                            equipPet()
                            --print("done pizza")
                        end
                        -- Check if 'bored' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "bored") then
                            --print("doing bored")
                            taskName = "🥱"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            equipPet()
                            task.wait(3)
                            if getgenv().PianoID then
                                game:GetService("ReplicatedStorage").API["HousingAPI/ActivateFurniture"]:InvokeServer(game:GetService("Players").LocalPlayer,getgenv().PianoID,"Seat1",{['cframe'] = CFrame.new(game:GetService("Players").LocalPlayer.Character.Head.Position + Vector3.new(0, .5, 0))},fsys.get("pet_char_wrappers")[1]["char"])
                                repeat task.wait(1)
                                until not hasTargetAilment("bored")
                            else
                                startingMoney = getCurrentMoney()
                                if startingMoney > 100 then
                                    --print("Buying Required Piano")
                                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(7.5, 7.5, -5.5) * CFrame.Angles(-1.57, 0, -0)},["kind"] = "piano"}})
                                    task.wait(1)
                                    getgenv().PianoID = GetFurniture("Piano")
                                    startingMoney = getCurrentMoney()
                                else
                                    print("Not Enough money to buy piano")
                                end
                            end
                            removeItemByValue(PetAilmentsArray, "bored")
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            getAilments(PetAilmentsData)
                            taskName = "none"
                            equipPet()
                            --print("done bored")
                        end
                        if table.find(BabyAilmentsArray, "bored") then
                            --print("doing bored")
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            if getgenv().PianoID then
                                task.spawn(function()
                                    game:GetService("ReplicatedStorage").API["HousingAPI/ActivateFurniture"]:InvokeServer(game:GetService("Players").LocalPlayer,getgenv().PianoID,"Seat1",{['cframe'] = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position)},fsys.get("char_wrapper")["char"])
                                end)
                                repeat task.wait(1)
                                until not ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments["bored"] 
                                BabyJump()
                                removeItemByValue(BabyAilmentsArray, "bored")
                            else
                                startingMoney = getCurrentMoney()
                                if startingMoney > 100 then
                                    --print("Buying Required Piano")
                                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(7.5, 7.5, -5.5) * CFrame.Angles(-1.57, 0, -0)},["kind"] = "piano"}})
                                    task.wait(1)
                                    getgenv().PianoID = GetFurniture("Piano")
                                    startingMoney = getCurrentMoney()
                                else
                                    print("Not Enough money to buy piano")
                                end
                            end
                            BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                            getBabyAilments(BabyAilmentsData)
                        end
                        -- Check if 'beach_party' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "beach_party") or table.find(BabyAilmentsArray, "beach_party") then
                            --print("going beach party")
                            taskName = "⛱️"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            local LiveOpsMapSwap = require(game:GetService("ReplicatedStorage").SharedModules.Game.LiveOpsMapSwap)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("MainMap",
                            game:GetService("Players").LocalPlayer, LiveOpsMapSwap.get_current_map_type())
                            teleportPlayerNeeds(-551, 31, -1485)
                            task.wait(0.3)
                            createPlatform()
                            task.wait(0.3)
                            equipPet()
                            repeat task.wait(1)
                            until not hasTargetAilment("beach_party") and not ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments["beach_party"]
                            task.wait(2)
                            removeItemByValue(PetAilmentsArray, "beach_party")
                            removeItemByValue(BabyAilmentsArray, "beach_party")
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                            getBabyAilments(BabyAilmentsData)
                            getAilments(PetAilmentsData)
                            -- Check if petfarm is true
                            if not getgenv().PetFarmGuiStarter then
                                return -- Exit the function or stop the process if petfarm is false
                            end
                            task.wait(1)
                            local LiveOpsMapSwap = require(game:GetService("ReplicatedStorage").SharedModules.Game.LiveOpsMapSwap)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("MainMap",
                            game:GetService("Players").LocalPlayer, LiveOpsMapSwap.get_current_map_type())
                            task.wait(0.3)
                            teleportPlayerNeeds(0, 350, 0)
                            task.wait(0.3)
                            createPlatform()
                            task.wait(0.3)
                            taskName = "none"
                            equipPet()
                            --print("done beach part")
                        end
                        -- Check if 'camping' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "camping") or table.find(BabyAilmentsArray, "camping") then
                            --print("going camping")
                            taskName = "🏕️"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            local LiveOpsMapSwap = require(game:GetService("ReplicatedStorage").SharedModules.Game.LiveOpsMapSwap)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("MainMap",
                            game:GetService("Players").LocalPlayer, LiveOpsMapSwap.get_current_map_type())
                            teleportPlayerNeeds(-20.9, 30.8, -1056.7)
                            task.wait(0.3)
                            createPlatform()
                            task.wait(0.3)
                            equipPet()
                            repeat task.wait(1)
                            until not hasTargetAilment("camping") and not ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments["camping"]
                            task.wait(2)
                            removeItemByValue(PetAilmentsArray, "camping")
                            removeItemByValue(BabyAilmentsArray, "camping")
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                            getAilments(PetAilmentsData)
                            getBabyAilments(BabyAilmentsData)
                            -- Check if petfarm is true
                            if not getgenv().PetFarmGuiStarter then
                                return -- Exit the function or stop the process if petfarm is false
                            end
                            task.wait(1)
                            local LiveOpsMapSwap = require(game:GetService("ReplicatedStorage").SharedModules.Game.LiveOpsMapSwap)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("MainMap",
                            game:GetService("Players").LocalPlayer, LiveOpsMapSwap.get_current_map_type())
                            task.wait(0.3)
                            teleportPlayerNeeds(0, 350, 0)
                            task.wait(0.3)
                            createPlatform()
                            task.wait(0.3)
                            taskName = "none"
                            equipPet()
                            --print("done camping")
                        end      
                        -- Check if 'dirty' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "dirty") then
                            --print("doing dirty")
                            taskName = "🚿"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            equipPet()
                            task.wait(3)
                            if getgenv().ShowerID then
                                game:GetService("ReplicatedStorage").API["HousingAPI/ActivateFurniture"]:InvokeServer(game:GetService("Players").LocalPlayer,getgenv().ShowerID,"UseBlock",{['cframe'] = CFrame.new(game:GetService("Players").LocalPlayer.Character.Head.Position + Vector3.new(0, .5, 0))},fsys.get("pet_char_wrappers")[1]["char"])
                                repeat task.wait(1)
                                until not hasTargetAilment("dirty")
                                removeItemByValue(PetAilmentsArray, "dirty")
                            else
                                startingMoney = getCurrentMoney()
                                if startingMoney > 13 then
                                    --print("Buying Required Shower")
                                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(34.5, 0, -8.5) * CFrame.Angles(0, 1.57, 0)},["kind"] = "stylishshower"}})
                                    task.wait(1)
                                    getgenv().ShowerID = GetFurniture("StylishShower")
                                    startingMoney = getCurrentMoney()
                                else
                                    print("Not Enough money to buy shower")
                                end
                            end
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            getAilments(PetAilmentsData)
                            taskName = "none"
                            equipPet()
                            --print("done dirty")
                        end  
                        if table.find(BabyAilmentsArray, "dirty") then
                            --print("doing dirty")
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            if getgenv().ShowerID then
                                task.spawn(function()
                                    game:GetService("ReplicatedStorage").API["HousingAPI/ActivateFurniture"]:InvokeServer(game:GetService("Players").LocalPlayer,getgenv().ShowerID,"UseBlock",{['cframe'] = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position)},fsys.get("char_wrapper")["char"])
                                end)
                                repeat task.wait(1)
                                until not ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments["dirty"]
                                BabyJump()
                                removeItemByValue(BabyAilmentsArray, "dirty")
                            else
                                startingMoney = getCurrentMoney()
                                if startingMoney > 13 then
                                    --print("Buying Required Shower")
                                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(34.5, 0, -8.5) * CFrame.Angles(0, 1.57, 0)},["kind"] = "stylishshower"}})
                                    task.wait(1)
                                    getgenv().ShowerID = GetFurniture("StylishShower")
                                    startingMoney = getCurrentMoney()
                                else
                                    print("Not Enough money to buy shower")
                                end
                            end
                            BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                            getBabyAilments(BabyAilmentsData)
                            --print("done dirty")
                        end
                        -- Check if 'sleepy' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "sleepy") then
                            --print("doing sleepy")
                            taskName = "😴"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            equipPet()
                            task.wait(3)
                            if getgenv().BedID then
                                game:GetService("ReplicatedStorage").API["HousingAPI/ActivateFurniture"]:InvokeServer(game:GetService("Players").LocalPlayer, getgenv().BedID, "UseBlock", {['cframe']=CFrame.new(game:GetService("Players").LocalPlayer.Character.Head.Position + Vector3.new(0,.5,0))}, fsys.get("pet_char_wrappers")[1]["char"])
                                repeat task.wait(1)
                                until not hasTargetAilment("sleepy") 
                                removeItemByValue(PetAilmentsArray, "sleepy")
                            else
                                startingMoney = getCurrentMoney()
                                if startingMoney > 5 then
                                    --print("Buying required crib")
                                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(33.5, 0, -30) * CFrame.Angles(-0, -1.57, 0)},["kind"] = "basiccrib"}})
                                    task.wait(1)
                                    getgenv().BedID = GetFurniture("BasicCrib")
                                    startingMoney = getCurrentMoney()
                                else 
                                    print("Not Enough money to buy bed.")
                                end
                            end
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            getAilments(PetAilmentsData)
                            taskName = "none"
                            equipPet()
                            --print("done pet sleepy")
                        end  
                        if table.find(BabyAilmentsArray, "sleepy") then
                            --print("doing sleepy")
                            if getgenv().BedID then
                                task.spawn(function()
                                    game:GetService("ReplicatedStorage").API["HousingAPI/ActivateFurniture"]:InvokeServer(game:GetService("Players").LocalPlayer,getgenv().BedID,"UseBlock",{['cframe'] = CFrame.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position)},fsys.get("char_wrapper")["char"])
                                end)
                                repeat task.wait(1)
                                until not ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments["sleepy"]
                                BabyJump()
                                removeItemByValue(BabyAilmentsArray, "sleepy")
                            else
                                startingMoney = getCurrentMoney()
                                if startingMoney > 5 then
                                    --print("Buying required crib")
                                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(33.5, 0, -30) * CFrame.Angles(-0, -1.57, 0)},["kind"] = "basiccrib"}})
                                    task.wait(1)
                                    getgenv().BedID = GetFurniture("BasicCrib")
                                    startingMoney = getCurrentMoney()
                                else 
                                    print("Not Enough money to buy bed.")
                                end
                            end
                            BabyAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.baby_ailments
                            getBabyAilments(BabyAilmentsData)
                            --print("done baby sleepy")
                        end      
                        -- Check if 'Potty' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "toilet") then
                            --print("going toilet")
                            taskName = "🧻"
                            equipPet()
                            task.wait(3)
                            
                            -- potty
                            if getgenv().ToiletID then
                                game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("HousingAPI/ActivateFurniture"):InvokeServer(game:GetService("Players").LocalPlayer,getgenv().ToiletID,"Seat1",{['cframe']=CFrame.new(game:GetService("Players").LocalPlayer.Character.Head.Position + Vector3.new(0,.5,0))},fsys.get("pet_char_wrappers")[1]["char"])
        
                                repeat task.wait(1)
                                until not hasTargetAilment("toilet")
                                removeItemByValue(PetAilmentsArray, "toilet")
                            else
                                startingMoney = getCurrentMoney()
                                if startingMoney > 9 then
                                    --print("Buying required crib")
                                    game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer({[1] = {["properties"] = {["cframe"] = CFrame.new(30.5, 0, -20) * CFrame.Angles(-0, -1.57, 0)},["kind"] = "toilet"}})
                                    task.wait(1)
                                    getgenv().ToiletID = GetFurniture("Toilet")
                                    startingMoney = getCurrentMoney()
                                else
                                    print("Not Enough money to buy toilet")
                                end
                            end
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            getAilments(PetAilmentsData)
                            taskName = "none"
                            equipPet()
                            --print("done potty")
                        end  
                        -- Check if 'mysteryTask' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "mystery") then
                            --print("going mysteryTask")
                            taskName = "❓"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            equipPet()
                            task.wait(3)
                            -- mystery task
                            get_mystery_task()
                            repeat task.wait(1)
                            until not hasTargetAilment("mystery")
                            removeItemByValue(PetAilmentsArray, "mystery")
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            getAilments(PetAilmentsData)
                            taskName = "none"
                            equipPet()
                            --print("done mysteryTask")
                        end 
                        -- Check if 'catch' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "play") then
                            --print("going catch")
                            taskName = "🦴"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            equipPet()
                            task.wait(3)
                            for i = 1, 3 do -- Loop 3 times
                            -- Check if petfarm is true
                                if not getgenv().PetFarmGuiStarter then
                                    return -- Exit the function or stop the process if petfarm is false
                                end
                                for i, v in pairs(fsys.get("inventory").toys) do
                                    if v.id == "squeaky_bone_default" then
                                        ToyToThrow = v.unique
                                    end
                                end
                                game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("PetObjectAPI/CreatePetObject"):InvokeServer("__Enum_PetObjectCreatorType_1", {["reaction_name"] = "ThrowToyReaction", ["unique_id"] = ToyToThrow})
                                wait(4) -- Wait 4 seconds before next iteration
                            end
                            repeat task.wait(1)
                            until not hasTargetAilment("play")
                            removeItemByValue(PetAilmentsArray, "play")
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            getAilments(PetAilmentsData)
                            taskName = "none"
                            equipPet()
                            --print("done catch")
                        end  
                        -- Check if 'sick' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "sick") then
                            --print("going sick")
                            taskName = "🤒"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            -- pet
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("Hospital")
                            task.wait(0.3)
                            teleportPlayerNeeds(0, 350, 0)
                            task.wait(0.3)
                            createPlatform()
                            task.wait(0.3)
                            getgenv().HospitalBedID = GetFurniture("HospitalRefresh2023Bed")
                            task.wait(2)
                            game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("HousingAPI/ActivateInteriorFurniture"):InvokeServer(getgenv().HospitalBedID, "Seat1", {['cframe']=CFrame.new(game:GetService("Players").LocalPlayer.Character.Head.Position + Vector3.new(0,.5,0))}, fsys.get("pet_char_wrappers")[1]["char"])
                            task.wait(15)
                            removeItemByValue(PetAilmentsArray, "sick")
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            getAilments(PetAilmentsData)
                            -- Check if petfarm is true
                            if not getgenv().PetFarmGuiStarter then
                                return -- Exit the function or stop the process if petfarm is false
                            end
                            task.wait(1)
                            local LiveOpsMapSwap = require(game:GetService("ReplicatedStorage").SharedModules.Game.LiveOpsMapSwap)
                            game:GetService("ReplicatedStorage").API:FindFirstChild("LocationAPI/SetLocation"):FireServer("MainMap",
                            game:GetService("Players").LocalPlayer, LiveOpsMapSwap.get_current_map_type())
                            task.wait(0.3)
                            teleportPlayerNeeds(0, 350, 0)
                            task.wait(0.3)
                            createPlatform()
                            task.wait(0.3)
                            taskName = "none"
                            equipPet()
                            --print("done sick")
                        end
                        -- Check if 'walk' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "walk") then
                            -- Check if petfarm is true
                            if not getgenv().PetFarmGuiStarter then
                                return -- Exit the function or stop the process if petfarm is false
                            end
                            --print("going walk")
                            taskName = "🚶"
                            equipPet()
                            task.wait(3)
                            -- Get the player's character and HumanoidRootPart
                            local Player = game.Players.LocalPlayer
                            local Character = Player.Character or Player.CharacterAdded:Wait()
                            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                            local Humanoid = Character:WaitForChild("Humanoid") -- Get the humanoid
        
                            -- Set the distance and duration for the walk
                            local walkDistance = 1000  -- Adjust the distance as needed
                            local walkDuration = 30    -- Adjust the time in seconds as needed
        
                            -- Store the initial position to walk back to it later
                            local initialPosition = HumanoidRootPart.Position
        
                            -- Define the goal position (straight ahead in the character's current direction)
                            local forwardPosition = initialPosition + (HumanoidRootPart.CFrame.LookVector * walkDistance)
        
                            -- Calculate speed to match walkDuration
                            local walkSpeed = walkDistance / walkDuration
                            Humanoid.WalkSpeed = walkSpeed -- Temporarily set the humanoid's walk speed
        
                            -- Move to the forward position and back twice
                            for i = 1, 2 do
                                -- Check if petfarm is true
                                if not getgenv().PetFarmGuiStarter then
                                    return -- Exit the function or stop the process if petfarm is false
                                end
                                Humanoid:MoveTo(forwardPosition)
                                Humanoid.MoveToFinished:Wait() -- Wait until the humanoid reaches the target
                                task.wait(1) -- Optional pause after reaching the position
                                -- Check if petfarm is true
                                if not getgenv().PetFarmGuiStarter then
                                    return -- Exit the function or stop the process if petfarm is false
                                end
                                Humanoid:MoveTo(initialPosition)
                                Humanoid.MoveToFinished:Wait() -- Wait until the humanoid returns to the initial position
                                task.wait(1) -- Optional pause after returning
                            end
                            repeat
                                -- Check if petfarm is true
                                if not getgenv().PetFarmGuiStarter then
                                    return -- Exit the function or stop the process if petfarm is false
                                end
                                task.wait(1)
                            until not hasTargetAilment("walk") 
                            -- Reset to default walk speed
                            Humanoid.WalkSpeed = 16
                            removeItemByValue(PetAilmentsArray, "walk")
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            getAilments(PetAilmentsData)
                            taskName = "none"
                            equipPet()
                            --print("done walk")
                        end  
                        -- Check if 'ride' is in the PetAilmentsArray
                        if table.find(PetAilmentsArray, "ride") then
                            -- Check if petfarm is true
                            if not getgenv().PetFarmGuiStarter then
                                return -- Exit the function or stop the process if petfarm is false
                            end
                            --print("going ride")
                            taskName = "🏎️"
                            getgenv().fsys = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
                            equipPet()
                            task.wait(3)
                            for i,v in pairs(fsys.get("inventory").strollers) do
                                if v.id == 'stroller-default' then
                                    strollerUnique = v.unique
                                end   
                            end
                            
                            
                            local args = {
                                [1] = strollerUnique,
                                [2] = {
                                    ["use_sound_delay"] = true,
                                    ["equip_as_last"] = false
                                }
                            }
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ToolAPI/Equip"):InvokeServer(unpack(args))         
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("AdoptAPI/UseStroller"):InvokeServer(fsys.get("pet_char_wrappers")[1]["char"], game:GetService("Players").LocalPlayer.Character.StrollerTool.ModelHandle.TouchToSits.TouchToSit)
                            
                            
                            -- Get the player's character and HumanoidRootPart
                            local Player = game.Players.LocalPlayer
                            local Character = Player.Character or Player.CharacterAdded:Wait()
                            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                            local Humanoid = Character:WaitForChild("Humanoid") -- Get the humanoid
        
                            -- Set the distance and duration for the walk
                            local walkDistance = 1000  -- Adjust the distance as needed
                            local walkDuration = 30    -- Adjust the time in seconds as needed
        
                            -- Store the initial position to walk back to it later
                            local initialPosition = HumanoidRootPart.Position
        
                            -- Define the goal position (straight ahead in the character's current direction)
                            local forwardPosition = initialPosition + (HumanoidRootPart.CFrame.LookVector * walkDistance)
        
                            -- Calculate speed to match walkDuration
                            local walkSpeed = walkDistance / walkDuration
                            Humanoid.WalkSpeed = walkSpeed -- Temporarily set the humanoid's walk speed
        
                            -- Move to the forward position and back twice
                            for i = 1, 2 do
                                -- Check if petfarm is true
                                if not getgenv().PetFarmGuiStarter then
                                    return -- Exit the function or stop the process if petfarm is false
                                end
                                Humanoid:MoveTo(forwardPosition)
                                Humanoid.MoveToFinished:Wait() -- Wait until the humanoid reaches the target
                                task.wait(1) -- Optional pause after reaching the position
                                -- Check if petfarm is true
                                if not getgenv().PetFarmGuiStarter then
                                    return -- Exit the function or stop the process if petfarm is false
                                end
                                Humanoid:MoveTo(initialPosition)
                                Humanoid.MoveToFinished:Wait() -- Wait until the humanoid returns to the initial position
                                task.wait(1) -- Optional pause after returning
                            end
                            repeat
                                -- Check if petfarm is true
                                if not getgenv().PetFarmGuiStarter then
                                    return -- Exit the function or stop the process if petfarm is false
                                end
                                task.wait(1)
                            until not hasTargetAilment("ride")
                            -- Reset to default walk speed
                            Humanoid.WalkSpeed = 16
                            removeItemByValue(PetAilmentsArray, "ride")
                            task.wait(0.3)
                            
                            game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("AdoptAPI/EjectBaby"):FireServer(fsys.get("pet_char_wrappers")[1]["char"])  
                            task.wait(0.3)              
                            PetAilmentsData = ClientData.get_data()[game.Players.LocalPlayer.Name].ailments_manager.ailments
                            getAilments(PetAilmentsData)
                            taskName = "none"
                            equipPet()
                            --print("done ride")
                        end            
                        
                    until not getgenv().PetFarmGuiStarter
                end
                task.wait(1)
                print("Petfarm is false")
            end
            
            
        end
    
        local Players = game:GetService("Players")
        local Player = Players.LocalPlayer
        getgenv().fsysCore = require(game:GetService("ReplicatedStorage").ClientModules.Core.InteriorsM.InteriorsM)
    
        local RunService = game:GetService("RunService")
        local currentText
    
    
    
        -- ###############################################################################################################################################
        -- TRACKER
        -- ###############################################################################################################################################
        -- Fetch required services and modules
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
    
        -- Create a ScreenGui
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "CustomGui"
        screenGui.Parent = player:WaitForChild("PlayerGui")
        screenGui.IgnoreGuiInset = true -- Ignore default GUI insets
    
        -- Main background frame
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0) -- Fullscreen
        frame.Position = UDim2.new(0, 0, 0, 0)
        frame.BackgroundColor3 = Color3.fromHex("#514FDB") -- Purple background
        frame.Parent = screenGui
    
    
    
    
        -- Title Label
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Size = UDim2.new(1, 0, 0.1, 0) -- Occupies 10% of the screen height
        titleLabel.Position = UDim2.new(0, 0, 0.2, 0) -- Top of the screen
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = "HIRA X\ngg/xVPfRPmv"
        titleLabel.TextColor3 = Color3.new(1, 1, 1) -- White text
        titleLabel.Font = Enum.Font.SourceSansBold
        titleLabel.TextScaled = false -- Disable scaling to set fixed TextSize
        titleLabel.TextSize = 32 -- Set text size to 32
        titleLabel.TextWrapped = false -- Disable wrapping
        titleLabel.TextXAlignment = Enum.TextXAlignment.Center -- Center horizontally
        titleLabel.TextYAlignment = Enum.TextYAlignment.Center -- Center vertically
        titleLabel.Parent = frame
    
    
        -- Toggle Button (Next to HIRA X Title)
        local toggleButton = Instance.new("TextButton")
        toggleButton.Size = UDim2.new(0.1, 0, 0.05, 0) -- Adjust size to fit nicely
        toggleButton.Position = UDim2.new(0.55, 0, 0.2, 0) -- Adjust placement next to the title
        toggleButton.Text = "🙂"
        toggleButton.BackgroundTransparency = 1
        toggleButton.TextColor3 = Color3.new(1, 1, 1) -- White text
        toggleButton.Font = Enum.Font.SourceSansBold
        toggleButton.TextScaled = true -- Scale text to fit the button
        toggleButton.Parent = screenGui
    
        -- Variable to track GUI state
        local isGuiVisible = true
    
        -- Function to toggle GUI visibility
        local function toggleGui()
            isGuiVisible = not isGuiVisible
            frame.Visible = isGuiVisible
            toggleButton.Text = isGuiVisible and "😎" or "🙂"
        end
    
        -- Connect button click to toggle function
        toggleButton.MouseButton1Click:Connect(toggleGui)
    
        -- Ensure the GUI is initially visible
        frame.Visible = isGuiVisible
    
    
        -- Stats Container
        local statsContainer = Instance.new("Frame")
        statsContainer.Size = UDim2.new(0.8, 0, 0.3, 0) -- 80% width, 60% height
        statsContainer.Position = UDim2.new(0.35, 0, 0.35, 0) -- Centered horizontally and slightly below title
        statsContainer.BackgroundTransparency = 1 -- Transparent background
        statsContainer.Parent = frame
    
    
        -- Function to smoothly transition through RGB colors
        local function RGBCycle(textLabel)
            local t = 0 -- Time variable for smooth transitions
            while true do
                -- Calculate RGB values based on sine wave functions
                local r = math.sin(t) * 127 + 128
                local g = math.sin(t + 2) * 127 + 128
                local b = math.sin(t + 4) * 127 + 128
    
                -- Set the TextColor3 property
                textLabel.TextColor3 = Color3.fromRGB(r, g, b)
    
                -- Increment the time variable for smooth transitions
                t = t + 0.05
                task.wait(0.05) -- Adjust the speed of the color cycle
            end
        end
    
        -- Function to create a stat row
        local function createStatRow(parent, labelText, order)
            local row = Instance.new("Frame")
            row.Size = UDim2.new(0.41, 0, 0.2, 0) -- Each row is 20% of the container height
            row.Position = UDim2.new(0, 0, (order - 1) * 0.2, 0) -- Stack rows vertically
            row.BackgroundTransparency = 1
            row.Parent = parent
    
            -- Label for stat name
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.4, 0, 1, 0) -- Label occupies 40% of row width
            label.Position = UDim2.new(0, 0, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = labelText
            label.TextColor3 = Color3.new(1, 1, 1) -- White text
            label.Font = Enum.Font.SourceSansBold
            label.TextScaled = false -- Disable scaling to set fixed TextSize
            label.TextSize = 32 -- Correct TextSize
            label.TextWrapped = false -- Disable wrapping
            label.TextXAlignment = Enum.TextXAlignment.Left -- Align left
            label.TextYAlignment = Enum.TextYAlignment.Center -- Center vertically
            label.Parent = row
    
            -- Label for stat value
            local value = Instance.new("TextLabel")
            value.Size = UDim2.new(0.6, 0, 1, 0) -- Value occupies 60% of row width
            value.Position = UDim2.new(0.4, 0, 0, 0) -- Positioned next to the label
            value.BackgroundTransparency = 1
            value.Text = "" -- Value will be updated dynamically
            value.TextColor3 = Color3.new(1, 1, 1) -- White text
            value.Font = Enum.Font.SourceSansBold
            value.TextScaled = false -- Disable scaling to set fixed TextSize
            value.TextSize = 32 -- Correct TextSize
            value.TextWrapped = false -- Disable wrapping
            value.TextXAlignment = Enum.TextXAlignment.Right -- Align right
            value.TextYAlignment = Enum.TextYAlignment.Center -- Center vertically
            value.Parent = row
    
            return value
        end
    
        -- Create rows for stats
        local moneyValue = createStatRow(statsContainer, "MONEY:", 1)
        local potionValue = createStatRow(statsContainer, "POTION:", 2)
        local timeValue = createStatRow(statsContainer, "TIME:", 3)
        local taskValue = createStatRow(statsContainer, "TASK:", 4)
        local petValue = createStatRow(statsContainer, "PET:", 5)
        local farmType = createStatRow(statsContainer, "Farm Type:", 6)
    
        -- Function to format elapsed time
        local function formatTime(seconds)
            local hours = math.floor(seconds / 3600)
            local minutes = math.floor((seconds % 3600) / 60)
            local secondsLeft = seconds % 60
            return string.format("%02d:%02d:%02d", hours, minutes, secondsLeft)
        end
    
    
    
    
        -- Initialize values
        local initialMoney = getCurrentMoney()
        local initialPotion = 0
        local startTime = os.time()
    
        for _, v in pairs(fsys.get("inventory").food) do
            if v.id == "pet_age_potion" then
                initialPotion = initialPotion + 1
            end
        end
    
        -- Function to update stats dynamically
        local function updateStats()
            -- Get current money and potion counts
            local currentMoney = getCurrentMoney()
            local currentPotionCount = 0
            local ClientData = require(game:GetService("ReplicatedStorage").ClientModules.Core.ClientData)
            local rootData = ClientData.get_data()[game.Players.LocalPlayer.Name]
            for _, v in pairs(fsys.get("inventory").food) do
                if v.id == "pet_age_potion" then
                    currentPotionCount = currentPotionCount + 1
                end
            end
    
            -- Calculate changes
            local moneyChange = currentMoney - initialMoney
            local potionChange = currentPotionCount - initialPotion
            local elapsedTime = os.time() - startTime
    
            -- Format elapsed time
            local formattedTime = formatTime(elapsedTime)
    
            -- Dynamic updates for stats
            moneyValue.Text = tostring(currentMoney) .. " (+" .. tostring(moneyChange) .. ")"
            potionValue.Text = tostring(currentPotionCount) .. " (+" .. tostring(potionChange) .. ")"
            timeValue.Text = formattedTime
            taskValue.Text = tostring(taskName or "None")
            farmType.Text = _G.FarmTypeRunning
        end
    
        -- Initial update and periodic refresh
        updateStats()
    
    
        -- Function to continuously update UI
        local function startUIUpdate()
            while true do
                updateStats()
                task.wait(1) -- Adjust the wait time as needed (e.g., every 1 second)
            end
        end
    
        local UserInputService = game:GetService("UserInputService")
    
        -- Variable to track the transparency state
        local isTransparent = false
    
        -- Function to handle key press
        local function onKeyPress(input, gameProcessedEvent)
            if not gameProcessedEvent then
                if input.KeyCode == Enum.KeyCode.U then
                    -- Toggle transparency
                    if screenGui and frame then
                        isTransparent = not isTransparent
                        frame.BackgroundTransparency = isTransparent and 1 or 0
                        --print("Background transparency set to " .. frame.BackgroundTransparency)
                    else
                        --print("CustomGui not found!")
                    end
                end
            end
        end
        -- Connect the function to UserInputService
        UserInputService.InputBegan:Connect(onKeyPress)
    
        task.wait(25)
        task.spawn(startPetFarm)
        task.wait(1)
        task.spawn(startUIUpdate)
        task.wait(1)
        task.spawn(function()
            RGBCycle(titleLabel)
        end)
    else
        print("Script already running")
    end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    
    local Window = Rayfield:CreateWindow({
        Name = "HiraXRey",
        Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
        LoadingTitle = "HiraXRey",
        LoadingSubtitle = "by Rey",
        Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes
     
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface
     
        ConfigurationSaving = {
           Enabled = true,
           FolderName = nil, -- Create a custom folder for your hub/game
           FileName = "Big Hub"
        },
     
        Discord = {
           Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
           Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
           RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
     
        KeySystem = false, -- Set this to true to use our key system
        KeySettings = {
           Title = "Untitled",
           Subtitle = "Key System",
           Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
           FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
           SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
           GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
           Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
        }
     })
    
    
    
     local Tab = Window:CreateTab("Pet Farm", 4483362458) -- Title, Image
    
    
     -- Initialize an empty table for options
    
    -- Loop through PetData and add y.kind to the options table
    for x, y in pairs(PetData) do
        if y.kind then
            table.insert(petOptions, y.kind)
        end
    end
    
    
    
    local function equipSelectedPet(selectedPet)
        for x, y in pairs(PetData) do
            if y.kind == selectedPet then
                petToEquip = y.unique
                print("This is the new petToEquip")
                local args = {
                    [1] = y.unique,
                    [2] = {
                        ["use_sound_delay"] = true,
                        ["equip_as_last"] = false
                    }
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ToolAPI/Equip"):InvokeServer(unpack(args))
                break
            end
        end
    end
    
    
    -- Create the dropdown with the dynamically populated options
    local Dropdown = Tab:CreateDropdown({
        Name = "Select Pet To Farm",
        Options = petOptions, -- Use the dynamically populated options
        MultipleOptions = false,
        Callback = function(Options)
            -- The function that runs when the selected option changes
            
            petToEquipForFarming = table.concat(Options, ", ")
            equipSelectedPet(petToEquipForFarming)
        end,
    })
    
    local Toggle = Tab:CreateToggle({
        Name = "Pet/Baby Farm",
        CurrentValue = false,
        Flag = "Toggle1", 
        Callback = function(Value)
            getgenv().PetFarmGuiStarter = not getgenv().PetFarmGuiStarter
        end,
     })
    
    

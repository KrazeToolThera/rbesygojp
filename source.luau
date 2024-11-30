if game.GameId==4417057922 then
    local VERSION='2.0.1'

	local PLAYERS=game:GetService("Players")
    local RUNSERVICE=game:GetService("RunService")
	local REPLICATEDSTORAGE=game:GetService("ReplicatedStorage")
	local COREUI=game:GetService("CoreGui")
	local RAYFIELD=loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local localPlayer=PLAYERS.LocalPlayer

    local trailEvent=REPLICATEDSTORAGE:WaitForChild('Events'):WaitForChild('Trail')
    local buyEvent=REPLICATEDSTORAGE:WaitForChild('Events'):WaitForChild('Buy')

    if not _G.timeOfTheScript then _G.timeOfTheScript=0 end
    
    local autoWinFarm=false
    local autoWinFarmTouchInterest=false
    local autoWinFarmCooldown=1.1
    local autoWinAmount='75 Wins'

    local autoDOSFarm=false
    local autoDOSFarmType='Win DOS Farm'
    local autoDOSFarmStreams=11
    local autoDOSFarmCooldown=0
    local autoDOSWinAmount='1 Win'
    
    local autoClameGifts=false
    local autoClame=false

    local autoPet=false
    local autoPetCombine=false
    local autoPetCooldown=1
    local autoPetArea='Green_2'

    local eggBaller
    
    local velocity=0
    
    local disableLaserDamage=false

    local flaudTheSpawn=false

    local lagThePlayers=false

    local inGameMenu
	local trollMenu
    local leftPay2WinPanel
    local rightPay2WinPanel

    local teleports={}
    teleports.stage1_1=workspace.Stage1.Win
    teleports.stage1_tower=workspace.Tower1.Win
    teleports.shop1=workspace.Shop.ShopPart
    teleports.shop2=workspace.Shop2.TrailShopPart
    teleports.stage2_1=workspace.Moon.Model.Model.Win.CFrame --Kinda
    teleports.stage5_1=workspace.Blue.Stage.Model.Win.CFrame
    teleports.stage6_1=workspace.Green.Stage.Model.Win.CFrame
    
    local function updateLocals()
        for _, v in pairs(PLAYERS.LocalPlayer.PlayerGui:GetChildren()) do
            if v:IsA('ScreenGui') then
                v.ResetOnSpawn = false
                if v.Name == 'ScreenGui' then
                    if v:FindFirstChild('Boost') or v:FindFirstChild('Friend') then
                        inGameMenu = v
                    elseif v:FindFirstChild('NukeGuiScript') or v:FindFirstChild('TrollFrame') then
                        trollMenu = v
                    end
                end
            end
        end
        for _, v in pairs(inGameMenu:GetChildren()) do
            if v:IsA("Frame") and v.Name == 'Frame' then
                if v:FindFirstChild('1Win') then
                    leftPay2WinPanel = v
                else
                    rightPay2WinPanel = v
                end
            end
        end
    end updateLocals()

    local function teloportTo(part)PLAYERS.LocalPlayer.Character:MoveTo(part.CFrame.Position+Vector3.new(0, 2.75+part.Size.Y/2, 0))end

    local function doRightThing(part) local humanoidRootPart = PLAYERS.LocalPlayer.Character:WaitForChild('HumanoidRootPart')
    if autoWinFarmTouchInterest then firetouchinterest(humanoidRootPart, part, 0) firetouchinterest(humanoidRootPart, part, 1)
    else humanoidRootPart.CFrame = part.CFrame end end
    
    for _, v in pairs(workspace:GetDescendants()) do
    	if v.Name == 'Part' and v:IsA('Part') and v:FindFirstChild('BillboardGui') and v.BillboardGui:IsA('BillboardGui') and v.BillboardGui.Enabled
    	and v.Parent.Parent == workspace and v.BillboardGui:FindFirstChild('TextLabel') and v.BillboardGui.TextLabel:IsA('TextLabel') then
    		if v.BillboardGui.TextLabel.Text == 'Leaderboard!' then
    			teleports.stage1_leaderBoard = v
                print(v)
                print(teleports.stage1_leaderBoard)
    		elseif v.BillboardGui.TextLabel.Text == 'Eggs!' then
    			teleports.stage1_eggs = v
    		end
    	end
    end
    for _, v in pairs(workspace:GetDescendants()) do
        if v:FindFirstChild('Egg22') then
            eggBaller=v.Egg22
        end
    end
    updateLocals()

    -- loadstring(game:HttpGet("https://pastebin.com/6LAsEgvn", true))()if workspace:FindFirstChild('Residence') and workspace.Residence:FindFirstChild('Spawn') then
    -- teleports.stage1_residence = workspace.Residence.Spawn end
    
    local windows = RAYFIELD:CreateWindow({
		Name = '🦘 BESYG1JP: Your Skill 🦘',
		LoadingTitle = '[UPD]Roblox But Every Second You Get +1 Jump Power',
		LoadingSubtitle = 'by KrazyToolThera',
		Theme = 'Bloom',

		DisableRayfieldPrompts = true,

		ConfigurationSaving = {
			Enabled = true,
			FolderName = 'KrazyToolThera',
			FileName = "BESYG1JP"
		},

		KeySystem = false,
	})
    
    local localTab=windows:CreateTab('Local','navigation')
    local section=localTab:CreateSection('Basic')
    local button = localTab:CreateButton({
        Name = "Delete map [You can't undo it]",
        Callback = function()
            for i=1,2 do
                if workspace:FindFirstChild('Baseplate') then
                    workspace.Baseplate:Destroy()
                end
            end
            --print("You destroyed the map.")
        end,
    })
    local toggle = localTab:CreateToggle({
       Name = 'Water Damage',
       CurrentValue = false,
       --Flag = "WaterDamage",
       Callback = function(value)
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name == 'Baseplate' then
                    v.CanTouch = not value
                end
            end
            workspace.Moon.Baseplate.CanTouch=not value
            workspace.Pink.Baseplate.CanTouch=not value
            workspace.Red.Baseplate.CanTouch=not value
            workspace.Blue.Baseplate.CanTouch=not value
            workspace.Green.Baseplate.CanTouch=not value
       end,
    })
    local toggle = localTab:CreateToggle({
        Name = "Laser Damage [WIP]",
        CurrentValue = false,
        --Flag = "LaserDamage",
        Callback=function(value)
            disableLaserDamage=value
        end,
    })
    local toggle = localTab:CreateToggle({
       Name = "Disable Donate Buttons",
       CurrentValue = false,
       --Flag = "WaterDamage",
       Callback=function(value)
            for _, v in pairs(workspace:GetDescendants()) do
                if (v.Parent.Name == 'JumpButtons' or v.Parent.Name == 'WinButtons') and v:IsA('Part') and v.Name ~= 'Part' then
                    v.CanTouch = not value
                end
            end
       end,
    })

    local HideGUISection = localTab:CreateSection('Hide GUI')
    local toggle = localTab:CreateToggle({
		Name = "Hide the most Pay2Win GUIs",
		CurrentValue = false,
		Callback = function(value)
			if inGameMenu:FindFirstChild('Pet') then
				inGameMenu.Pet.Visible = not value
			end
			if inGameMenu:FindFirstChild('x2Points') then
				inGameMenu.x2Points.Visible = not value
			end
			if inGameMenu:FindFirstChild('x2Wins') then
				inGameMenu.x2Wins.Visible = not value
			end
			if inGameMenu:FindFirstChild('Passes') then
				inGameMenu.Passes.Visible = not value
			end
			if inGameMenu:FindFirstChild('Top') and inGameMenu.Top:FindFirstChild('StarterPack') then
				inGameMenu.Top.StarterPack.Visible = not value
			end
			if trollMenu:FindFirstChild('Kill') then
				trollMenu.Kill.Visible = not value
			end
			if trollMenu:FindFirstChild('Nuke') then
				trollMenu.Nuke.Visible = not value
			end
			
			for _, v in pairs(inGameMenu:GetChildren()) do
				if v:IsA('ImageLabel') and v.Name == 'Shine' then
					v.Visible = not value
				end
			end

            leftPay2WinPanel.Visible = not value
		end,
	})
    local toggle = localTab:CreateToggle({
		Name = "Hide Top Bar GUI",
		CurrentValue = false,
		Callback = function(value)
			PLAYERS.LocalPlayer.PlayerGui.TopbarPlus.Enabled = not value
		end,
	})
    local toggle = localTab:CreateToggle({
		Name = "Hide Favorite It GUI (Core UI) [Advertisment]",
		CurrentValue = false,
		Callback = function(value)
			COREUI.ThemeProvider.Enabled = not value
		end,
	})
    local toggle = localTab:CreateToggle({
		Name = "Hide Present button",
		CurrentValue = false,
		Callback = function(value)
			if inGameMenu:FindFirstChild('Top') and inGameMenu.Top:FindFirstChild('Reward') then
				inGameMenu.Top.Reward.Visible = not value
			end
		end,
	})
    local toggle = localTab:CreateToggle({
		Name = "Hide Right Side Ads",
		CurrentValue = false,
		Callback = function(value)
            if rightPay2WinPanel:FindFirstChild('Boost') then
                rightPay2WinPanel.Boost.Visible = not value
            end
            if rightPay2WinPanel:FindFirstChild('Shop') then
                rightPay2WinPanel.Shop.Visible = not value
            end
            if trollMenu:FindFirstChild('Troll') then
                trollMenu.Troll.Visible = not value
            end
            if trollMenu:FindFirstChild('TrollFrame') then
                trollMenu.TrollFrame.Visible = false
            end
		end,
	})

    local MiscSection = localTab:CreateSection('Misc')
    local toggle = localTab:CreateToggle({
		Name = "Static Camera (Useful if you have autofarm cooldown more that 0.5s)",
		CurrentValue = false,
		Callback = function(value)
			if value then
				workspace.CurrentCamera.CameraType = Enum.CameraType.Fixed
			else
				workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			end
		end,
	})
    local toggle = localTab:CreateToggle({ --100 0
		Name = "Remove Win GUIs",
		CurrentValue = false,
		Callback = function(value)
			PLAYERS.LocalPlayer.PlayerScripts:WaitForChild('LocalScript'):WaitForChild('Template').Visible = not value
			PLAYERS.LocalPlayer.PlayerGui.Regain.TextButton.Visible = not value
		end,
	})
    local toggle = localTab:CreateToggle({
		Name = "Remove Win Sound",
		CurrentValue = false,
		Callback = function(value)
			if value then
				PLAYERS.LocalPlayer.PlayerScripts.LocalScript.Finished.Volume = 0
			else
				PLAYERS.LocalPlayer.PlayerScripts.LocalScript.Finished.Volume = 0.5
			end
		end,
	})
    local toggle = localTab:CreateToggle({
		Name = "Make It Background(No Render)",
		CurrentValue = false,
		Callback = function(value)
			RUNSERVICE:Set3dRenderingEnabled(not value)
		end,
	})

    local AutofarmTab = windows:CreateTab('Automation', nil)
	local MainSection = AutofarmTab:CreateSection('Wins')
    local AutoFarmLabel = AutofarmTab:CreateLabel("Status: No Farming")
    local toggle = AutofarmTab:CreateToggle({
		Name = "Autofarm",
		CurrentValue = false,
		Callback = function(value)
			autoWinFarm = value
            if value then
                AutoFarmLabel:Set("Status: Launching")
            else
                AutoFarmLabel:Set("Status: Shutting down")
                task.wait(1)
                AutoFarmLabel:Set("Status: No Farming")
            end
		end,
	})
    local Dropdown = AutofarmTab:CreateDropdown({
		Name = "Amount of wins",
		Options = {"75 Wins","30 Wins","12 Wins","6 Wins","3 Wins","1 Wins"},
		CurrentOption = {"75 Wins"},
		MultipleOptions = false,
		--Flag = "WinsAmount",
		Callback = function(Option)
			autoWinAmount = Option[1]
		end,
	})
    -- local Dropdown = AutofarmTab:CreateDropdown({
    --     Name = "Select area [WIP]",
    --    Options = {"Area1","Area2", "Area3", "Area4"},
    --    CurrentOption = {"Area1"},
    --    MultipleOptions = false,
    --    --Flag = "AutoWInFarmArea",
    --    Callback = function(Option)
    --    end,
    -- })
    -- local toggle = AutofarmTab:CreateToggle({
    --    Name = "Auto 2x boost [WIP]",
    --    CurrentValue = false,
    --    --Flag = "AutoWinTwoXBoost",
    --    Callback = function(value)
    --    end,
    -- })
    local Slider = AutofarmTab:CreateSlider({
		Name = "Cooldown",
		Range = {0, 5},
		Increment = 0.05,
		Suffix = "Seconds",
		CurrentValue = autoWinFarmCooldown,
		--Flag = "AutoFarmCooldown",
		Callback = function(value)
			autoWinFarmCooldown = value
		end,
	})

    local toggle = AutofarmTab:CreateToggle({
       Name = "Get Wins without Teloporting to Win Part [High level executors]",
       CurrentValue = false,
       Flag = "WinFarmTouchInterest",
       Callback = function(value)
            autoWinFarmTouchInterest = value
       end,
    })

    AutofarmTab:CreateSection('DOS Wins')
    local AutoDOSFarmLabel = AutofarmTab:CreateLabel("Status: No Farming")
    local toggle = AutofarmTab:CreateToggle({
		Name = "Autofire",
		CurrentValue = false,
		Callback = function(value)
			autoDOSFarm = value
            if value then
                AutoDOSFarmLabel:Set("Status: Launching")
            else
                AutoDOSFarmLabel:Set("Status: Shutting down")
                task.wait(1)
                AutoDOSFarmLabel:Set("Status: No Farming")
            end
		end,
	})
    local Dropdown = AutofarmTab:CreateDropdown({
       Name = "Type",
       Options = {"Win DOS Farm","Jump DOS Farm"},
       CurrentOption = {"Win DOS Farm"},
       MultipleOptions = false,
       --Flag = "Dropdown1",
       Callback = function(Option)
            autoDOSFarmType = Option[1]
       end,
    })
    local Dropdown = AutofarmTab:CreateDropdown({
		Name = "Amount",
		Options = {"100 Wins","50 Wins","25 Wins","10 Wins","5 Wins","1 Win"},
		CurrentOption = {"1 Win"},
		MultipleOptions = false,
		--Flag = "WinsAmount",
		Callback = function(Option)
    	autoDOSWinAmount = Option[1]
		end,
	})
    local Slider = AutofarmTab:CreateSlider({
		Name = "Cooldown",
		Range = {0, 1},
		Increment = 0.05,
		Suffix = "Seconds",
		CurrentValue = autoDOSFarmCooldown,
		--Flag = "AutoFarmCooldown",
		Callback = function(value)
			autoDOSFarmCooldown = value
		end,
	})
    local Slider = AutofarmTab:CreateSlider({
		Name = "Streams",
		Range = {0, 100},
		Increment = 1,
		Suffix = "Remotes",
		CurrentValue = autoDOSFarmStreams,
		--Flag = "AutoFarmCooldown",
		Callback = function(value)
			autoDOSFarmStreams = value
		end,
	})

    --AutofarmTab:CreateSection('Legit Farm')

    
 --    local Section = AutofarmTab:CreateSection('Gift Reward')
 --    local toggle = AutofarmTab:CreateToggle({
	-- 	Name = "Autoclame",
	-- 	CurrentValue = false,
	-- 	Callback = function(value)
 --            autoClame = value
	-- 	end,
	-- })

 --    local Section = AutofarmTab:CreateSection('Group Reward')
 --    local toggle = AutofarmTab:CreateToggle({
	-- 	Name = "Autoclame",
	-- 	CurrentValue = false,
	-- 	Callback = function(value)
 --            autoClame = value
	-- 	end,
	-- })Weebhook https://discord.com/api/webhooks/1307007803906592821/AnwSW0f2oPTM5RilZ8LbkA9ZPw2vnn3VesYpH8C5YMWjFxywQHEQp_JW6qAG94KcF8rE

    local Section = AutofarmTab:CreateSection('Pets')
    local toggle = AutofarmTab:CreateToggle({
       Name = "Autopet",
       CurrentValue = false,
       Callback = function(value)
            autoPet = value
       end,
    })
    -- local Dropdown = AutofarmTab:CreateDropdown({
    --    Name = "Egg",
    --    Options = {"Green 2","Green 1"},
    --    CurrentOption = {"Green 2"},
    --    MultipleOptions = false,
    --    --Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    --    Callback = function(Option)
            
    --    end,
    -- })
    local Slider = AutofarmTab:CreateSlider({
       Name = "Cooldown",
       Range = {0, 5},
       Increment = 0.1,
       Suffix = "Seconds",
       CurrentValue = 5,
       --Flag = "Slider1",
       Callback = function(value)
        autoPetCooldown=value
       end,
    })
    -- local toggle = AutofarmTab:CreateToggle({
    --    Name = "Autocombine",
    --    CurrentValue = false,
    --    Callback = function(value)
    --         autoPetCombine = value
    --    end,
    -- })

    local TeleportTab = windows:CreateTab('Teleport', nil)
    local TeFirstSection = TeleportTab:CreateSection('First Stage')
    local button = TeleportTab:CreateButton({
		Name = "One Win Spawn",
		Callback = function()
            teloportTo(workspace.Spawns.SpawnLocation)
		end,
	})
    local button = TeleportTab:CreateButton({
		Name = "Your Residential Area",
		Callback = function()
			teloportTo(teleports.stage1_residence)
		end,
	})
    local button = TeleportTab:CreateButton({
		Name = "LeaderBoards",
		Callback = function()
			teloportTo(teleports.stage1_leaderBoard)
		end,
	})
    local button = TeleportTab:CreateButton({
		Name = "Eggs",
		Callback = function()
			teloportTo(teleports.stage1_eggs)
		end,
	})
    local button = TeleportTab:CreateButton({
		Name = "Shop Trails",
		Callback = function()
			teloportTo(workspace.Shop2.TrailShopPart)
		end,
	})
    local button = TeleportTab:CreateButton({
		Name = "Shop Items",
		Callback = function()
			teloportTo(workspace.Shop.ShopPart)
		end,
	})
    
    local TeSecondSection = TeleportTab:CreateSection('Second Stage')
	local button = TeleportTab:CreateButton({Name='Two Win Spawn',Callback=function()teloportTo(workspace.Spawns.Spawn2)end,})

    local TeThirdSection=TeleportTab:CreateSection('Third Stage')
    local button=TeleportTab:CreateButton({Name='Six Win Spawn',Callback=function()teloportTo(workspace.Spawns.Spawn3)end,})

    local TeFourthSection = TeleportTab:CreateSection('Fourth Stage')
    local button=TeleportTab:CreateButton({Name='Twelve Win Spawn',Callback=function()teloportTo(workspace.Spawns.Spawn4)end,})

    local TeFifthSection=TeleportTab:CreateSection('Fifth Stage')
    local button=TeleportTab:CreateButton({Name='Thirty Win Spawn',Callback=function()PLAYERS.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(workspace.Spawns.Spawn5.CFrame.Position)end,})
    
    local TeSexthSection = TeleportTab:CreateSection('Sexth Stage')
    local button=TeleportTab:CreateButton({Name='Seventy Five Win Spawn',Callback=function()PLAYERS.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(workspace.Spawns.Spawn6.CFrame.Position)end,})

    local serverTab = windows:CreateTab('Server', nil)
    local section = serverTab:CreateSection('Character')
    local slider=serverTab:CreateSlider({Name='WalkSpeed',Range={1,50},Increment=1,Suffix='Speed',CurrentValue=16,Flag='WalkSpeed',
     Callback=function(value)localPlayer.Character.Humanoid.WalkSpeed=(value)end,})
    local slider=serverTab:CreateSlider({Name='JumpPower',Range={1,350},Increment=1,Suffix='Jump',CurrentValue=16,Flag='JumpPower',
	 Callback=function(value)localPlayer.Character.Humanoid.JumpPower=(value)end,})
    local slider=serverTab:CreateSlider({Name='Gravity',Range={0,1000},Increment=1,Suffix='Force',CurrentValue=192,Flag='Gravity',
     Callback=function(value)workspace.Gravity = (value)end,
	})
    local button=serverTab:CreateButton({Name='Infinite Jump',
	 Callback=function()_G.infinjump=not _G.infinjump if _G.infinJumpStarted==nil then _G.infinJumpStarted=true local plr=localPlayer local m=plr:GetMouse()
	 m.KeyDown:connect(function(k)if _G.infinjump and k:byte()==32 then
     local humanoid=game:GetService'Players'.LocalPlayer.Character:FindFirstChildOfClass('Humanoid')humanoid:ChangeState('Jumping') task.wait()humanoid:ChangeState('Seated')end end)end end,})
    local button=serverTab:CreateButton({Name="Anti AFK",Callback=function()repeat task.wait()until game:IsLoaded()
     PLAYERS.LocalPlayer.Idled:connect(function()game:GetService("VirtualUser"):ClickButton2(Vector2.new())end)
     game:GetService("StarterGui"):SetCore("SendNotification",{Title='ANTI AFK',Text='ANTI AFK ON',Icon="rbxassetid://4483345998"})end})
    
    local section=serverTab:CreateSection('Trails [You need wins]')
    local button=serverTab:CreateButton({Name='White Trail [1 win]',Callback=function()trailEvent:FireServer(REPLICATEDSTORAGE:WaitForChild("Trails"):WaitForChild("White"))end,})
    local button = serverTab:CreateButton({Name='Yellow Trail [2 wins]',Callback=function()trailEvent:FireServer(REPLICATEDSTORAGE:WaitForChild("Trails"):WaitForChild("Yellow"))end,})
    local button = serverTab:CreateButton({
       Name = 'Green Trail [3 wins]',
       Callback = function()
            trailEvent:FireServer(REPLICATEDSTORAGE:WaitForChild("Trails"):WaitForChild("Green"))
       end,
    })
    local button = serverTab:CreateButton({
       Name = 'Blue Trail [6 wins]',
       Callback = function()
            trailEvent:FireServer(REPLICATEDSTORAGE:WaitForChild("Trails"):WaitForChild("Blue"))
       end,
    })
    local button = serverTab:CreateButton({
       Name = 'Red Trail [9 win]',
       Callback = function()
            trailEvent:FireServer(REPLICATEDSTORAGE:WaitForChild("Trails"):WaitForChild("Red"))
       end,
    })
    local button = serverTab:CreateButton({
       Name = 'Indigo Trail [11 win]',
       Callback = function()
            trailEvent:FireServer(REPLICATEDSTORAGE:WaitForChild("Trails"):WaitForChild("Indigo"))
       end,
    })
    local button = serverTab:CreateButton({
       Name = 'Violet Trail [12 win]',
       Callback = function()
            trailEvent:FireServer(REPLICATEDSTORAGE:WaitForChild("Trails"):WaitForChild("Violet"))
       end,
    })
    local button=serverTab:CreateButton({Name='Orange Trail [15 win]',
     Callback=function()trailEvent:FireServer(REPLICATEDSTORAGE:WaitForChild("Trails"):WaitForChild("Orange"))end,})
    local button=serverTab:CreateButton({Name='Rainbow Trail [20 win]',
     Callback=function()trailEvent:FireServer(REPLICATEDSTORAGE:WaitForChild("Trails"):WaitForChild("Rainbow"))end,})
    
    local ItemsSection = serverTab:CreateSection('Items [You need wins]')
    local button = serverTab:CreateButton({
       Name = 'Bloxy Cola [3 wins]',
       Callback = function()
            buyEvent:FireServer("BloxyCola")
       end,
    })
    local button = serverTab:CreateButton({
       Name = 'Flashlight [3 wins]',
       Callback = function()
            buyEvent:FireServer("Flashlight")
       end,
    })
    local button = serverTab:CreateButton({
       Name = 'Spray Can [6 wins]',
       Callback = function()
            buyEvent:FireServer("SprayPaint")
       end,
    })
    local button = serverTab:CreateButton({
       Name = 'Paint Bucket [10 wins]',
       Callback = function()
            buyEvent:FireServer("PaintBucket")
       end,
    })
    local button = serverTab:CreateButton({
       Name = 'Glider [15 wins]',
       Callback = function()
            buyEvent:FireServer("Glider")
       end,
    })
    local button = serverTab:CreateButton({
       Name = 'Speed Coil [20 wins]',
       Callback = function()
            buyEvent:FireServer("SpeedCoil2")
       end,
    })

    local UsefulSection = serverTab:CreateSection('Velocity [OP]')
    local Input = serverTab:CreateInput({
		Name = "Get velocity",
		PlaceholderText = "How much velocity do you want?",
		RemoveTextAfterFocusLost = false,
		Callback = function(text)
            if type(tonumber(text)) == "number" then
                velocity = tonumber(text)
            end
		end,
	})
    local button = serverTab:CreateButton({
       Name = "Set velocity",
       Callback = function()
            REPLICATEDSTORAGE:WaitForChild("Events"):WaitForChild("Velocity"):InvokeServer(velocity-PLAYERS.LocalPlayer.Velocity.value)
       end,
    })

    local FlaudSection = serverTab:CreateSection('Flaud the Spawn')
    local FlaudTheSpawnLabel = serverTab:CreateLabel('Status: Not active')
    local toggle = serverTab:CreateToggle({
       Name = "Flaud the spawn with items",
       CurrentValue = false,
       Callback = function(value)
            flaudTheSpawn = value
            if value then
                FlaudTheSpawnLabel:Set("Status: Launching")
            else
                FlaudTheSpawnLabel:Set("Status: Shutting Down")
                task.wait(1)
                FlaudTheSpawnLabel:Set("Status: Not active")
            end
       end,
    })

    local section=serverTab:CreateSection('Lag the Players')
    local lagThePlayersLabel=serverTab:CreateLabel('Status: Not active')
    local toggle=serverTab:CreateToggle({
        Name='Lag the Players with Pets',
        CurrentValue=false,
        --Flag = "LagThePlayerWithPets",
        Callback = function(value)
            lagThePlayers=value
        end,
    })
    -- local toggle=serverTab:CreateToggle({
    --     Name='Antilag only for you',
    --     CurrentValue=false,
    --     --Flag = "LagThePlayerWithPets",
    --     Callback = function(value)

    --     end,
    -- })
    -- local button=serverTab:CreateButton({
    --     Name = "Unequip all Your Pets",
    --     Callback = function()
    --     end,
    -- })

    --game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("Equip"):FireServer(localPlayer:WaitForChild("Infection"),"Unequip")


 --    local FunSection = serverTab:CreateSection('Fun [OP]')
 --    local button = serverTab:CreateButton({
	-- 	Name = "The Loud Sound",
	-- 	Callback = function()
	-- 		print('Soon')
	-- 	end,
	-- })
 --    local button = serverTab:CreateButton({
	-- 	Name = "Launch nuke",
	-- 	Callback = function()
	-- 		print('Soon')
	-- 	end,
	-- })
	-- local button = serverTab:CreateButton({
	-- 	Name = "Crash the Server",
	-- 	Callback = function()
	-- 		PLAYERS.LocalPlayer:WaitForChild("SprayEvent"):FireServer(8037301, 
	-- 			CFrame.new(108.67044830322266, 0, -45.050514221191406, 1, 0, 0, 0, 1, 0, 0, 0, 1),
	-- 			Enum.NormalId.Top)
	-- 	end,
	-- })

    local scriptsTab=windows:CreateTab('Scripts', 'scroll-text')
    local section=scriptsTab:CreateSection('Good scripts')
    --local button=scriptsTab:CreateButton({Name='Become Admin',Callback=function()end,})
    local button=scriptsTab:CreateButton({Name='Test',Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/game-hax/uca/main/release/uca.min.lua"))()end,})
    local button=scriptsTab:CreateButton({Name='Chat Bypass',Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/SkireScripts/Ouxie/main/Projects/simplebypass.lua"))()end,})
    local button=scriptsTab:CreateButton({Name='Infinite Yield',Callback=function()loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()end,})
    local button=scriptsTab:CreateButton({Name='Infinite Yield: Reborn (Better Version of IY) [Don\'t execute with Infinite Yield]',Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/KrazeToolThera/SecretLua/refs/heads/main/main.lua",true))()end,})
    local button=scriptsTab:CreateButton({Name='Fates Admin',Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/fatesc/fates-admin/main/main.lua"))()end,})
    local button=scriptsTab:CreateButton({Name='Orca',Callback=function()loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/latest.lua"))()end,})
    local button=scriptsTab:CreateButton({Name='cOOl Kid',Callback=function()loadstring(game:HttpGet("https://pastebin.com/e36xTVVu"))()end,})
    local button=scriptsTab:CreateButton({Name='Turtle Spy',Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Turtle-Brand/Turtle-Spy/main/source.lua",true))()end,})
    local button=scriptsTab:CreateButton({Name='Remote Spy',Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua"))()end,})
    local button=scriptsTab:CreateButton({Name='Dex',Callback=function()loadstring(game:HttpGet("https://pastebin.com/raw/M0mPCdD5",true))()end,})
    local button=scriptsTab:CreateButton({Name='Dark Dex',Callback=function()loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua",true))()end,})

    local aboutTab = windows:CreateTab('About', 'store')
    local section = aboutTab:CreateSection('-------------------')
    local label=aboutTab:CreateLabel('Version '..VERSION)
    local label=aboutTab:CreateLabel("Executor: "..identifyexecutor())
	local label=aboutTab:CreateLabel("This script made by KrazyToolThera")
    local label=aboutTab:CreateLabel("Is it op? Hah? Enjoy.")
    local TimeOfTheScriptLabel = aboutTab:CreateLabel("Running: ".._G.timeOfTheScript)
	local button=aboutTab:CreateButton({
		Name='Destroy UI',
		Callback=function()
            if workspace:FindFirstChild('Residence') then workspace.Residence:Destroy()end
            RAYFIELD:Destroy()
		end,
	})

    localPlayer.CharacterAdded:Connect(function()
        task.wait(0.24)PLAYERS.LocalPlayer.PlayerGui:WaitForChild('ScreenGui')updateLocals()
    end)

    -- localPlayer.Time.Changed:Connect(function()
    --     --To clame all gifts or update options
    -- end)

    RUNSERVICE.RenderStepped:Connect(function()
        if autoDOSFarm then
            AutoDOSFarmLabel:Set("Status: Running")
            task.wait(autoDOSFarmCooldown)
            if autoDOSFarmType == "Win DOS Farm" then
                --65000 300000 550000 1250000 2250000 4000000  11 is safe | 80 is ok
                local x = 65000
                if autoDOSWinAmount == '100 Wins' then
                    x = 4000000
                elseif autoDOSWinAmount == '50 Wins' then
                    x = 2250000
                elseif autoDOSWinAmount == '25 Wins' then
                    x = 1250000
                elseif autoDOSWinAmount == '10 Wins' then
                    x = 550000
                elseif autoDOSWinAmount == '5 Wins' then
                    x = 300000
                else
                    x = 65000
                end
                for i=1,autoDOSFarmStreams do
                    REPLICATEDSTORAGE.Events.BuyVelocity:InvokeServer(x, "Wins")
                end
            else
                --1000 10000 100000 500000 1000000 5000000
                local x = 1000
                if autoDOSWinAmount=='100 Wins' then x=5000000
                elseif autoDOSWinAmount=='50 Wins'then x=1000000
                elseif autoDOSWinAmount=='25 Wins' then x=500000
                elseif autoDOSWinAmount == '10 Wins' then x=100000
                elseif autoDOSWinAmount == '5 Wins' then x=10000
                else x = 1000 end
                for i=1,autoDOSFarmStreams do REPLICATEDSTORAGE.Events.BuyVelocity:InvokeServer(x,"Jump")end
            end
        end
        if flaudTheSpawn then
            FlaudTheSpawnLabel:Set("Status: Active")
            buyEvent:FireServer("BloxyCola")
            buyEvent:FireServer("Flashlight")
            --buyEvent:FireServer("SprayPaint")
            buyEvent:FireServer("PaintBucket")
            buyEvent:FireServer("Glider")
            buyEvent:FireServer("SpeedCoil2")
    
            if PLAYERS.LocalPlayer.Backpack:FindFirstChild('BloxyCola') then
             PLAYERS.LocalPlayer.Backpack.BloxyCola.Parent = PLAYERS.LocalPlayer.Character end
            if PLAYERS.LocalPlayer.Backpack:FindFirstChild('Flashlight') then
             PLAYERS.LocalPlayer.Backpack.Flashlight.Parent = PLAYERS.LocalPlayer.Character end
            if PLAYERS.LocalPlayer.Backpack:FindFirstChild('PaintBucket') then
             PLAYERS.LocalPlayer.Backpack.PaintBucket.Parent = PLAYERS.LocalPlayer.Character end
            if PLAYERS.LocalPlayer.Backpack:FindFirstChild('Glider') then
             PLAYERS.LocalPlayer.Backpack.Glider.Parent = PLAYERS.LocalPlayer.Character end
            if PLAYERS.LocalPlayer.Backpack:FindFirstChild('SpeedCoil2') then
             PLAYERS.LocalPlayer.Backpack.SpeedCoil2.Parent = PLAYERS.LocalPlayer.Character end

            for _, v in pairs(PLAYERS.LocalPlayer.Character:GetChildren()) do
                if v:IsA('Tool') and (v.Name == 'BloxyCola' or 'Flashlight' or 'PaintBucket' or 'SpeedCoil2') then
                    v.Parent = workspace
                end
            end
        end
        if disableLaserDamage then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA('Part')and v.Name=='Kill' then
                    v.CanTouch=false
                end
            end
        end
	end)
    
	while true do
		task.wait(1)
        _G.timeOfTheScript += 1
        TimeOfTheScriptLabel:Set('Running: '.._G.timeOfTheScript..'s')
        -- while autoClame do
        --     task.wait(1)
        --     REPLICATEDSTORAGE:WaitForChild("Events"):WaitForChild("Reward"):FireServer(1, true)
        --     REPLICATEDSTORAGE:WaitForChild("Events"):WaitForChild("Reward"):FireServer(2, true)
        --     REPLICATEDSTORAGE:WaitForChild("Events"):WaitForChild("Reward"):FireServer(3, true)
        --     REPLICATEDSTORAGE:WaitForChild("Events"):WaitForChild("Reward"):FireServer(4, true)
        --     REPLICATEDSTORAGE:WaitForChild("Events"):WaitForChild("Reward"):FireServer(5, true)
        --     REPLICATEDSTORAGE:WaitForChild("Events"):WaitForChild("Reward"):FireServer(6, true)
        -- end workspace.oliksandrdebeelko.Humanoid.WalkToPoint = Vector3.new(0,0,0)
        local lastMoney
        local totalMoney=0
		while autoWinFarm do
			task.wait(autoWinFarmCooldown)
			if autoWinAmount=='75 Wins' then doRightThing(workspace.Green.Stage.Model.Win)
            elseif autoWinAmount == "30 Wins" then
                doRightThing(workspace.Blue.Stage.Model.Win)
			elseif autoWinAmount == "12 Wins" then
				doRightThing(workspace.Moon.Model.Model.Win)
			elseif autoWinAmount == "6 Wins" then
				--PLAYERS.LocalPlayer.Character:WaitForChild('HumanoidRootPart').CFrame = workspace.Pink.Model.Model.Win.CFrame
			elseif autoWinAmount == "3 Wins" then
				doRightThing(workspace.Moon.Model.Model.Win)
			elseif autoWinAmount == "1 Wins" then
				doRightThing(workspace.stage1.CFrame)
			end
            if lastMoney == nil then
                lastMoney = PLAYERS.LocalPlayer.leaderstats.Wins.value
                AutoFarmLabel:Set("Status: Running")
            else
                local difference = math.abs(PLAYERS.LocalPlayer.leaderstats.Wins.value - lastMoney)
                totalMoney += difference
                AutoFarmLabel:Set("Status: Running | Speed: "..difference.." money/second | Total: "..totalMoney)
                lastMoney = PLAYERS.LocalPlayer.leaderstats.Wins.value
            end
		end
        while autoPet do
            task.wait(autoPetCooldown)
            teloportTo(eggBaller)
            fireproximityprompt(eggBaller.ProximityPrompt,1,true)
        end
        while lagThePlayers do
            task.wait(0.01)
            --if game.Players.LocalPlayer.Pets:FindFirstChild("Infection") then
                REPLICATEDSTORAGE.Events.Equip:FireServer(localPlayer.Pets:WaitForChild("Infection"), "Equip")
            --end
            -- if game.Players.LocalPlayer.Character:FindFirstChild() then
            --     --game.Players.LocalPlayer.Character.Equipped[1]:Destroy()
            -- end

        end
	end
else warn("This script made for a different game. Atleast I didn't kick you.")end

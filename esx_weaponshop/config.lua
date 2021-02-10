Config               = {}

Config.DrawDistance  = 100
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Color         = { r = 0, g = 128, b = 255 }
Config.Type          = 23
Config.Locale        = 'en'

Config.LicenseEnable = true -- only turn this on if you are using esx_license
Config.LicensePrice  = 3000
Config.LicensePrice2  = 6000
Config.LicensePrice3  = 9000

Config.Zones = {

	GunShop = {
		Legal = true,
		Items0 = {
			{ weapon = 'WEAPON_KNIFE', price = 120},
			{ weapon = 'WEAPON_MACHETE', price = 100},
			{ weapon = 'WEAPON_FLASHLIGHT', price = 45},
			{ weapon = 'WEAPON_BAT', price = 600},
			{ weapon = 'WEAPON_FLAREGUN', price = 1000},
			{ weapon = 'WEAPON_STUNGUN', price = 2000},
			--{ weapon = 'WEAPON_KNUCKLE', price = 300},
			{ weapon = 'WEAPON_GOLFCLUB', price = 600},
			{ weapon = 'WEAPON_CROWBAR', price = 400},
		},
		Items1 = {
			--list1start
			{ weapon = 'WEAPON_KNIFE', price = 120},
			{ weapon = 'WEAPON_MACHETE', price = 100},
			{ weapon = 'WEAPON_FLASHLIGHT', price = 45},
			{ weapon = 'WEAPON_BAT', price = 600},
			{ weapon = 'WEAPON_FLAREGUN', price = 1000},
			{ weapon = 'WEAPON_STUNGUN', price = 2000},
			--{ weapon = 'WEAPON_KNUCKLE', price = 300},
			{ weapon = 'WEAPON_GOLFCLUB', price = 600},
			{ weapon = 'WEAPON_CROWBAR', price = 400},
			--list2start
			{ weapon = 'WEAPON_PISTOL',  components = {}, price = 2000, ammoPrice = 300, AmmoToGive = 300 },
			{ weapon = 'WEAPON_COMBATPISTOL', components = {}, price = 3000, ammoPrice = 300, AmmoToGive = 300 },
			{ weapon = 'WEAPON_HEAVYPISTOL', components = {}, price = 4500, ammoPrice = 300, AmmoToGive = 300 },
			{ weapon = 'WEAPON_MARKSMANPISTOL', price = 10000, ammoPrice = 500, AmmoToGive = 300 },
			{ weapon = 'WEAPON_SNSPISTOL', components = {}, price = 1200, ammoPrice = 200, AmmoToGive = 300 },
		},
		Items2 = {
			--list1start
			{ weapon = 'WEAPON_KNIFE', price = 120},
			{ weapon = 'WEAPON_MACHETE', price = 100},
			{ weapon = 'WEAPON_FLASHLIGHT', price = 45},
			{ weapon = 'WEAPON_BAT', price = 600},
			{ weapon = 'WEAPON_FLAREGUN', price = 1000},
			{ weapon = 'WEAPON_STUNGUN', price = 2000},
			--{ weapon = 'WEAPON_KNUCKLE', price = 300},
			{ weapon = 'WEAPON_GOLFCLUB', price = 600},
			{ weapon = 'WEAPON_CROWBAR', price = 400},
			--list2start
			{ weapon = 'WEAPON_PISTOL',  components = {}, price = 2000, ammoPrice = 300, AmmoToGive = 300 },
			{ weapon = 'WEAPON_COMBATPISTOL', components = {}, price = 3000, ammoPrice = 300, AmmoToGive = 300 },
			{ weapon = 'WEAPON_HEAVYPISTOL', components = {}, price = 4500, ammoPrice = 300, AmmoToGive = 300 },
			{ weapon = 'WEAPON_MARKSMANPISTOL', price = 10000, ammoPrice = 500, AmmoToGive = 300 },
			{ weapon = 'WEAPON_SNSPISTOL', components = {}, price = 1200, ammoPrice = 200, AmmoToGive = 300 },
			--list3start
			{ weapon = 'WEAPON_PUMPSHOTGUN', components = {}, price = 10000, ammoPrice = 600, AmmoToGive = 300},
			{ weapon = 'WEAPON_PISTOL50', components = {}, price = 4000, ammoPrice = 400, AmmoToGive = 300},
			{ weapon = 'WEAPON_MICROSMG', components = {}, price = 12000, ammoPrice = 250, AmmoToGive = 300},
			{ weapon = 'WEAPON_BULLPUPSHOTGUN', components = {}, price = 9000, ammoPrice = 600, AmmoToGive = 300},
		},
		Items3 = {
			--list1start
			{ weapon = 'WEAPON_KNIFE', price = 120},
			{ weapon = 'WEAPON_MACHETE', price = 100},
			{ weapon = 'WEAPON_FLASHLIGHT', price = 45},
			{ weapon = 'WEAPON_BAT', price = 600},
			{ weapon = 'WEAPON_FLAREGUN', price = 1000},
			{ weapon = 'WEAPON_STUNGUN', price = 2000},
			--{ weapon = 'WEAPON_KNUCKLE', price = 300},
			{ weapon = 'WEAPON_GOLFCLUB', price = 600},
			{ weapon = 'WEAPON_CROWBAR', price = 400},
			--list2start
			{ weapon = 'WEAPON_PISTOL',  components = {}, price = 2000, ammoPrice = 300, AmmoToGive = 300 },
			{ weapon = 'WEAPON_COMBATPISTOL', components = {}, price = 3000, ammoPrice = 300, AmmoToGive = 300 },
			{ weapon = 'WEAPON_HEAVYPISTOL', components = {}, price = 4500, ammoPrice = 300, AmmoToGive = 300 },
			{ weapon = 'WEAPON_MARKSMANPISTOL', price = 10000, ammoPrice = 500, AmmoToGive = 300 },
			{ weapon = 'WEAPON_SNSPISTOL', components = {}, price = 1200, ammoPrice = 200, AmmoToGive = 300 },
			--list3start
			{ weapon = 'WEAPON_PUMPSHOTGUN', components = {}, price = 10000, ammoPrice = 600, AmmoToGive = 300},
			{ weapon = 'WEAPON_PISTOL50', components = {}, price = 4000, ammoPrice = 400, AmmoToGive = 300},
			{ weapon = 'WEAPON_MICROSMG', components = {}, price = 12000, ammoPrice = 250, AmmoToGive = 300},
			{ weapon = 'WEAPON_BULLPUPSHOTGUN', components = {}, price = 9000, ammoPrice = 600, AmmoToGive = 300},
			--list4start
			{ weapon = 'WEAPON_SMG', components = {}, price = 10000, ammoPrice = 2000, AmmoToGive = 300},
			--{ weapon = 'WEAPON_ASSAULTSMG', components = { 0, 350, 500, 1250, 7500, 15000 }, price = 15000, ammoPrice = 2000, AmmoToGive = 300},
			--{ weapon = 'WEAPON_BULLPUPRIFLE', components = { 0, 500, 500, 1250, 7500, 350, 10000 }, price = 10000, ammoPrice = 2000, AmmoToGive = 300},
			{ weapon = 'WEAPON_ADVANCEDRIFLE', components = {}, price =9000, ammoPrice = 2000, AmmoToGive = 300},
			{ weapon = 'WEAPON_HEAVYSHOTGUN', components = {}, price = 50000, ammoPrice = 4000, AmmoToGive = 300},
			--{ weapon = 'WEAPON_MG', components = { 0, 1500, 1500, 25000 }, price = 20000, ammoPrice = 7000, AmmoToGive = 300},
			{ weapon = 'WEAPON_COMPACTRIFLE', components = {}, price = 20000, ammoPrice = 3000, AmmoToGive = 300},
			{ weapon = 'WEAPON_CARBINERIFLE', components = {}, price = 25000, ammoPrice = 3000, AmmoToGive = 300},
			{ weapon = 'WEAPON_SNIPERRIFLE', components = {}, price = 60000, ammoPrice = 8000, AmmoToGive = 300},
			{ weapon = 'WEAPON_HEAVYSNIPER', components = {}, price = 200000, ammoPrice = 8000, AmmoToGive = 300},
		},
		
		Locations = {
			vector3(-662.1, -935.3, 20.9),
			vector3(810.2, -2157.3, 28.7),
			vector3(1693.4, 3759.5, 33.8),
			vector3(-330.2, 6083.8, 30.5),
			vector3(252.3, -50.0, 69.0),
			vector3(22.0, -1107.2, 28.9),
			vector3(2567.6, 294.3, 107.8),
			vector3(-1117.5, 2698.6, 17.6),
			vector3(842.4, -1033.4, 27.3),
			vector3(-1306.2, -394.0, 35.6)
		}
	},
--[[
	BlackWeashop = {
		Legal = false,
		Items = {

			{ weapon = 'WEAPON_ASSAULTSMG', price = 15000, ammoPrice = 500, AmmoToGive = 250},
			{ weapon = 'WEAPON_RPG', price = 150000, ammoPrice = 15000, AmmoToGive = 1},
			{ weapon = 'WEAPON_SPECIALCARBINE', price = 16000, ammoPrice = 500, AmmoToGive = 250},
			{ weapon = 'WEAPON_CARBINERIFLE', price = 17000, ammoPrice = 500, AmmoToGive = 250},
			{ weapon = 'WEAPON_STICKYBOMB', price = 12000, ammoPrice = 12000, AmmoToGive = 1},
			
		},
		Locations = {
			vector3(-85.93, -2410.1, 5.0)
		}
	}
}
]]
BlackWeashop = {
	Legal = false,
	Items0 = {	
	{ weapon = 'WEAPON_COMBATPISTOL',  components = {}, price = 1000, ammoPrice = 300, AmmoToGive = 300 },
    { weapon = 'WEAPON_REVOLVER', price = 4000, ammoPrice = 300, AmmoToGive = 300 },
    { weapon = 'WEAPON_MICROSMG',  components = {}, price = 6000, ammoPrice = 700, AmmoToGive = 300 },
    { weapon = 'WEAPON_SMG',  components = {}, price = 10000, ammoPrice = 700, AmmoToGive = 300 },
    { weapon = 'WEAPON_MINISMG',  components = {}, price = 7000, ammoPrice = 700, AmmoToGive = 300 },
    { weapon = 'WEAPON_PUMPSHOTGUN',  components = {}, price = 5000, ammoPrice = 600, AmmoToGive = 300 },
    { weapon = 'WEAPON_ASSAULTRIFLE',  components = {}, price = 10000, ammoPrice = 800, AmmoToGive = 300 },
    { weapon = 'WEAPON_CARBINERIFLE',  components = {}, price = 7000, ammoPrice = 700, AmmoToGive = 300 },
    { weapon = 'WEAPON_MG',  components = {}, price = 25000, ammoPrice = 800, AmmoToGive = 300 },
	{ weapon = 'WEAPON_BULLPUPRIFLE', components = {}, price = 10000, ammoPrice = 2000, AmmoToGive = 300},
	{ weapon = 'WEAPON_MOLOTOV', price = 450, ammoPrice = 450, AmmoToGive = 3},
		},
	Locations = {
		vector3(-684.09, -868.19, 24.51)
	}
}
}

Config.Zones1 = {
	
	BlackWeashop = {
		Legal = false,
		Items = { 
			{ weapon = 'WEAPON_SMG', price = 135000, ammoPrice = 4000, AmmoToGive = 200},
		{ weapon = 'WEAPON_RPG', price = 800000, ammoPrice = 70000, AmmoToGive = 2},
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 300000, ammoPrice = 6000, AmmoToGive = 250},
		{ weapon = 'WEAPON_CARBINERIFLE', price = 200000, ammoPrice = 6000, AmmoToGive = 250},
		{ weapon = 'WEAPON_STICKYBOMB', price = 40000, ammoPrice = 12000, AmmoToGive = 1},
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 330000, ammoPrice = 12000, AmmoToGive = 30},
		{ weapon = 'WEAPON_MICROSMG', price = 90000, ammoPrice = 8000, AmmoToGive = 100},
		{ weapon = 'WEAPON_PISTOL', price = 50000, ammoPrice = 600, AmmoToGive = 32},
		{ weapon = 'WEAPON_SWITCHBLADE', price = 100},
		{ weapon = 'WEAPON_HEAVYPISTOL', price = 65000, ammoPrice = 600, AmmoToGive = 32},
		{ weapon = 'WEAPON_SMG', price = 135000, ammoPrice = 8000, AmmoToGive = 100},
		{ weapon = 'WEAPON_MG', price = 340000, ammoPrice = 8000, AmmoToGive = 100},
		{ weapon = 'WEAPON_MOLOTOV', price = 450, ammoPrice = 450, AmmoToGive = 3},
		{ weapon = 'WEAPON_MACHINEPISTOL', price = 30000, ammoPrice = 450, AmmoToGive = 62},
		{ weapon = 'WEAPON_ASSAULTRIFLE', price = 200000, ammoPrice = 1000, AmmoToGive = 90},		
		},
		Locations = {
		vector3(-684.09, -868.19, 24.51)
		}
	}
}
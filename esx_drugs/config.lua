Config              = {}
Config.MarkerType   = 25
Config.DrawDistance = 200.0
Config.ZoneSize     = {x = 3.0, y = 3.0, z = 3.0}
Config.MarkerColor  = {r = 100, g = 204, b = 100}
Config.ShowBlips   = false  --markers visible on the map? (false to hide the markers on the map)

Config.RequiredCopsCoke  = 0
Config.RequiredCopsMeth  = 0
Config.RequiredCopsWeed  = 0
Config.RequiredCopsOpium = 0
Config.RequiredCopsLSD = 0
Config.RequiredCopsPCP = 0

Config.TimeToFarm    = 20 * 1000
Config.TimeToProcess = 40 * 1000
Config.TimeToSell    = 10 * 1000
Config.Locale = 'en'

Config.Zones = {
	CokeField =			{x = 2552.12,	y = 6185.10,	z = 162.42,	name = _U('coke_field'),		sprite = 501,	color = 40},
	CokeProcessing =	{x = 1491.31,	y = 4424.97,	z = 43.88,	name = _U('coke_processing'),	sprite = 478,	color = 40},
--CokeDealer =		{x = -1756.19,	y = 427.31,		z =126.68,	name = _U('coke_dealer'),		sprite = 500,	color = 75},
	MethField =			{x = 65.41,		y = 6662.64,	z = 30.79,	name = _U('meth_field'),		sprite = 499,	color = 26},
	MethProcessing =	{x = 2194.73,	y = 5595.40,	z = 52.76,	name = _U('meth_processing'),	sprite = 499,	color = 26},
--MethDealer =		{x = -63.59,	y = -1224.07,	z = 27.76,	name = _U('meth_dealer'),		sprite = 500,	color = 75},
	WeedField =			{x = 2221.63,	y = 5577.43,	z = 53.0,	name = _U('weed_field'),		sprite = 496,	color = 52},
	WeedProcessing =	{x = 1443.0,	y = 6332.99,    z = 22.95,	name = _U('weed_processing'),	sprite = 496,	color = 52},
	--WeedDealer =		{x = -54.24,	y = -1443.36,	z = 31.1,	name = _U('weed_dealer'),		sprite = 500,	color = 75},
	OpiumField =		{x = 3199.54,	y = 2364.78,	z = 15.39,	name = _U('opium_field'),		sprite = 49,	color = 60},
	OpiumProcessing =	{x = -1146.01,	y = 4939.73,	z = 221.30,	name = _U('opium_processing'),	sprite = 49,	color = 60},
	--OpiumDealer =		{x = 2331.08,	y = 2570.22,	z = 45.70,	name = _U('opium_dealer'),		sprite = 500,	color = 75},
	LSDField =			{x = 2329.39,	y = 2571.82,	z = 45.68,	name = _U('lsd_field'),			sprite = 51,	color = 60},
	LSDProcessing =		{x = 2481.08,	y = 3733.61,	z = 42.50,	name = _U('lsd_processing'),	sprite = 51,	color = 60},
	--LSDDealer =			{x = 1112.53,	y = -434.85,	z = 66.46,	name = _U('lsd_dealer'),		sprite = 500,	color = 75},
	PCPField =			{x = 2433.75,	y = 4969.07,	z = 41.35,	name = _U('pcp_field'),			sprite = 51,	color = 60},
	PCPProcessing =		{x = -278.87,	y = 2203.75,	z = 128.90,	name = _U('pcp_processing'),	sprite = 51,	color = 60},
	--PCPDealer =			{x = 226.66,	y = -1984.97,	z = 18.72,	name = _U('pcp_dealer'),		sprite = 500,	color = 75}
}

Config.Blips = {
CokeField =			{x = 2552.12,	y = 6185.10,	z = 162.42,	name = _U('coke_field'),		sprite = 501,	color = 40},
	CokeProcessing =	{x = 1491.31,	y = 4424.97,	z = 43.88,	name = _U('coke_processing'),	sprite = 478,	color = 40},
	CokeDealer =		{x = -1756.19,	y = 427.31,		z =126.68,	name = _U('coke_dealer'),		sprite = 500,	color = 75},
	MethField =			{x = 65.41,		y = 6662.64,	z = 30.79,	name = _U('meth_field'),		sprite = 499,	color = 26},
	MethProcessing =	{x = 2194.73,	y = 5595.40,	z = 52.76,	name = _U('meth_processing'),	sprite = 499,	color = 26},
	MethDealer =		{x = -63.59,	y = -1224.07,	z = 27.76,	name = _U('meth_dealer'),		sprite = 500,	color = 75},
	WeedField =			{x = 2221.63,	y = 5577.43,	z = 53.0,	name = _U('weed_field'),		sprite = 496,	color = 52},
	WeedProcessing =	{x = 1443.0,	y = 6332.99,    z = 22.95,	name = _U('weed_processing'),	sprite = 496,	color = 52},
	WeedDealer =		{x = -54.24,	y = -1443.36,	z = 31.1,	name = _U('weed_dealer'),		sprite = 500,	color = 75},
	OpiumField =		{x = 3199.54,	y = 2364.78,	z = 15.39,	name = _U('opium_field'),		sprite = 49,	color = 60},
	OpiumProcessing =	{x = -1146.01,	y = 4939.73,	z = 221.30,	name = _U('opium_processing'),	sprite = 49,	color = 60},
	OpiumDealer =		{x = 2331.08,	y = 2570.22,	z = 45.70,	name = _U('opium_dealer'),		sprite = 500,	color = 75},
	LSDField =			{x = 2329.39,	y = 2571.82,	z = 45.68,	name = _U('lsd_field'),			sprite = 51,	color = 60},
	LSDProcessing =		{x = 2481.08,	y = 3733.61,	z = 40.64,	name = _U('lsd_processing'),	sprite = 51,	color = 60},
	LSDDealer =			{x = 1112.53,	y = -434.85,	z = 66.46,	name = _U('lsd_dealer'),		sprite = 500,	color = 75},
	PCPField =			{x = 2433.75,	y = 4969.07,	z = 41.35,	name = _U('pcp_field'),			sprite = 51,	color = 60},
	PCPProcessing =		{x = -278.87,	y = 2203.75,	z = 127.85,	name = _U('pcp_processing'),	sprite = 51,	color = 60},
	PCPDealer =			{x = 226.66,	y = -1984.97,	z = 18.72,	name = _U('pcp_dealer'),		sprite = 500,	color = 75}
}

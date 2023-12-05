class_name ElfCubeGame

enum CubeColour {red, green, blue}
var reg_GameLine = RegEx.new()
var reg_GemCount = RegEx.new()

var max_valid: Dictionary = {
	CubeColour.red: 12,
	CubeColour.green: 13,
	CubeColour.blue: 14,
}

var game_id:int = 0

func _init():
	reg_GameLine.compile("Game (\\d*):(.*)")
	reg_GemCount.compile("(\\d*)[ ]?(blue|green|red)")
	
	pass 

func add_game(inputGame:String):
	var gameLineResult = reg_GameLine.search(inputGame)
	var gameWasValid = true
	var cube_totals: Dictionary = {
		CubeColour.red: 0,
		CubeColour.green: 0,
		CubeColour.blue: 0,
	}
	
	if gameLineResult:
		game_id = int(gameLineResult.get_string(1))
		print("game_id: " + str(game_id))
		var allMeasurementText = gameLineResult.get_string(2)
		var gemsInHandByRound = allMeasurementText.split(";", true)
		var round = 0
		for gemsInHand in gemsInHandByRound:
			round = round + 1
			var gemsAndCountInHand = gemsInHand.split(",", true)
			
			for gameAndCount in gemsAndCountInHand:
				var gemCountResult = reg_GemCount.search(gameAndCount)
				if gemCountResult:
					var gemCount = int(gemCountResult.get_string(1))
					var gemColour = gemCountResult.get_string(2)
					cube_totals[CubeColour[gemColour]] = max(cube_totals[CubeColour[gemColour]], gemCount)
					if max_valid[CubeColour[gemColour]] < gemCount:
						gameWasValid = false
				else:
					printerr("Failed to parse: " + gameAndCount)
					
			print("round " + str(round) + ": " + str(cube_totals))
	else:
		printerr("Unable to parse line: " + inputGame)
			
	var game_power = cube_totals[CubeColour.red] * cube_totals[CubeColour.green] * cube_totals[CubeColour.blue]
	print("Valid Game: " + str(gameWasValid))
	print("Game power: " + str(game_power))
	
	return game_power
	#
	#if gameWasValid:
	#	return game_id
	#else:
	#	return 0
	
func clear_games():
	pass

extends Button

var textProcessing: TextProcessing
var elfCubeGame: ElfCubeGame
var inputText
var outputText

# Called when the node enters the scene tree for the first time.
func _ready():
	textProcessing = TextProcessing.new()
	elfCubeGame = ElfCubeGame.new()
	inputText = get_node("../TextInput")
	outputText = get_node("../TextOutput")
	pass # Replace with function body.

func _pressed():
	print("Pressed!")
	var gamesToAdd = inputText.text.split("\n", true)
	
	var totalValid = 0
	for gameString in gamesToAdd:
		totalValid += elfCubeGame.add_game(gameString)
	
	outputText.text = str(totalValid)
	pass
	

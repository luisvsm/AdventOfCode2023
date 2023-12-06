extends Button

var textProcessing: TextProcessing
var engineSchematic: EngineSchematic
var inputText
var outputText

# Called when the node enters the scene tree for the first time.
func _ready():
	textProcessing = TextProcessing.new()
	engineSchematic = EngineSchematic.new()
	inputText = get_node("../TextInput")
	outputText = get_node("../TextOutput")
	pass # Replace with function body.

func _pressed():
	print("Pressed!")
	var schematicToRead = inputText.text
	
	engineSchematic.loadSchematic(schematicToRead)
	engineSchematic.processSymbols()
	var sumOfPartNumbers = 0
	var sumOfGearRatios = 0
	
	for numberData in engineSchematic.listOfNumbers:
		# print(str(numberData.number.call()) + ": " + str(numberData.isNextToSymbol))
		if numberData.isNextToSymbol:
			sumOfPartNumbers += numberData.number.call()
			
	for gearData in engineSchematic.listOfGears:
		# print(str(numberData.number.call()) + ": " + str(numberData.isNextToSymbol))
		if gearData.adjacentParts.size() == 2:
			# print("gearData.adjacentParts: " + str(gearData.adjacentParts))
			sumOfGearRatios += gearData.adjacentParts[0].number.call() * gearData.adjacentParts[1].number.call()
	
	outputText.text = "Sum of part numbers: " + str(sumOfPartNumbers) + "\nSum of gear ratios: " + str(sumOfGearRatios)
	pass
	

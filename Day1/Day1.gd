extends Button

var textProcessing
var inputText
var outputText

# Called when the node enters the scene tree for the first time.
func _ready():
	textProcessing = TextProcessing.new()
	inputText = get_node("../TextInput")
	outputText = get_node("../TextOutput")
	pass # Replace with function body.

func _pressed():
	print("Pressed!")
	var wordsToNumbers = textProcessing.words_to_numbers(inputText.text)
	print("wordsToNumbers: " + wordsToNumbers)
	var numberSets = textProcessing.strip_non_numeric(wordsToNumbers)
	var numbersToAdd = numberSets.split("\n", true, 20000)
	
	var total = 0
	for number in numbersToAdd:
		var toAdd = int(textProcessing.first_and_last_number(number))
		print("toAdd: " + str(toAdd))
		if toAdd > 0: 
			total = total + toAdd
	
	outputText.text = str(total)
	pass
	

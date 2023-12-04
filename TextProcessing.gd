class_name TextProcessing

var reg_StripText = RegEx.new()
var reg_FirstDigit = RegEx.new()
var reg_LastDigit = RegEx.new()
var reg_One = RegEx.new()
var reg_Two = RegEx.new()
var reg_Three = RegEx.new()
var reg_Four = RegEx.new()
var reg_Five = RegEx.new()
var reg_Six = RegEx.new()
var reg_Seven = RegEx.new()
var reg_Eight = RegEx.new()
var reg_Nine = RegEx.new()

# Called when the node enters the scene tree for the first time.
func _init():
	print("Init!")
	reg_StripText.compile("[^\\r\\n0-9]")
	reg_FirstDigit.compile("^\\d")
	reg_LastDigit.compile("\\d$")
	reg_One.compile("one")
	reg_Two.compile("two")
	reg_Three.compile("three")
	reg_Four.compile("four")
	reg_Five.compile("five")
	reg_Six.compile("six")
	reg_Seven.compile("seven")
	reg_Eight.compile("eight")
	reg_Nine.compile("nine")
	pass # Replace with function body.

func strip_non_numeric(inputString):
	var result = reg_StripText.sub(inputString, "", true)
	if result:
		return result
	else:
		return "error"

func words_to_numbers(inputString):
	inputString = inputString.to_lower()
	# Add back the first and last letter so that eightwo would match as 82
	inputString = reg_One.sub(inputString, "o1e", true)
	inputString = reg_Two.sub(inputString, "t2o", true)
	inputString = reg_Three.sub(inputString, "t3e", true)
	inputString = reg_Four.sub(inputString, "f4r", true)
	inputString = reg_Five.sub(inputString, "f5e", true)
	inputString = reg_Six.sub(inputString, "s6x", true)
	inputString = reg_Seven.sub(inputString, "s7n", true)
	inputString = reg_Eight.sub(inputString, "e8t", true)
	inputString = reg_Nine.sub(inputString, "n9e", true)
	
	return inputString

func first_and_last_number(inputString):
	var firstDigit = reg_FirstDigit.search(inputString)
	var lastDigit = reg_LastDigit.search(inputString)
	
	if firstDigit && lastDigit:
		return firstDigit.get_string() + lastDigit.get_string()
	else:
		print("Missing first or last digit for " + str(inputString))
		return "0"
	

class_name EngineSchematic

var reg_SymbolCheck = RegEx.new()
var textMap: Array
var listOfNumbers: Array
var listOfGears: Array
var schematicText

func _init():
	reg_SymbolCheck.compile("[-!$%^@&*()_+|~=`{}\\[\\]:\";'<>?,\\/#]")
	
	pass 



func setNextToSymbol(x,y,isNextToSymbol, characterData):
	#print("looking for: " + str(x) + ","+ str(y))
	if y >= 0 and x >= 0 and len(textMap)>x and len(textMap[x])>y:
		textMap[x][y].isNextToSymbol = isNextToSymbol
		if textMap[x][y].isDigit:
			#print("Found " + textMap[x][y].mapNumber.text)
			textMap[x][y].mapNumber.isNextToSymbol = isNextToSymbol
			if characterData.isGear and false == characterData.adjacentParts.has(textMap[x][y].mapNumber):
				characterData.adjacentParts.append(textMap[x][y].mapNumber)
				
				if characterData.adjacentParts.size() == 1:
					listOfGears.append(characterData)
					
				#print(characterData.adjacentParts)
	else:
		print("Can't find: " + str(x) + ","+ str(y))
		pass
		
	pass

func processSymbols():
	var lineNumber = 0
	for textLine in schematicText:
		var characterNumber = 0
		for character in textLine:
			var result = reg_SymbolCheck.search(character)
			if result:
				textMap[lineNumber][characterNumber].isSymbol = true
				var characterData = textMap[lineNumber][characterNumber]
				setNextToSymbol(lineNumber-1, characterNumber, true, characterData) # up
				setNextToSymbol(lineNumber+1, characterNumber, true, characterData) # down
				setNextToSymbol(lineNumber  , characterNumber+1, true, characterData) # right
				setNextToSymbol(lineNumber-1, characterNumber+1, true, characterData) # right and up
				setNextToSymbol(lineNumber+1, characterNumber+1, true, characterData) # right and down
				setNextToSymbol(lineNumber  , characterNumber-1, true, characterData) # left
				setNextToSymbol(lineNumber-1, characterNumber-1, true, characterData) # left and up
				setNextToSymbol(lineNumber+1, characterNumber-1, true, characterData) # left and down
			elif character != "." and character != "0" and int(character) == 0:
				print("Unknown character: " + character)
			characterNumber += 1
		lineNumber += 1
	
	pass

func loadSchematic(inputString: String):
	schematicText = inputString.split("\n", true)
	textMap = []
	listOfNumbers = []
	listOfGears = []
	var lineNumber = 0
	for textLine in schematicText:
		if len(textLine) > 0:
			textMap.append([] as Array)
			
		var characterNumber = 0
		for character in textLine:
			var mapData: Dictionary = {
				"isSymbol": false,
				"isDigit": false,
				"isNextToSymbol": false,
				"value": null,
				"mapNumber": null,
				"isGear": false,
			}
			textMap[lineNumber].append(mapData)
			
			if int(character)>0 || character == "0":
				mapData.isDigit = true
				mapData.value = int(character)
				
				if characterNumber > 0 && textMap[lineNumber][characterNumber-1].isDigit:
					mapData.mapNumber = textMap[lineNumber][characterNumber-1].mapNumber
					mapData.mapNumber.text = mapData.mapNumber.text + character
				else:
					
					#if characterNumber > 0:
						#if textMap[lineNumber][characterNumber-1].value != ".":
							#print("textMap["+str(lineNumber)+"][" + str(characterNumber-1) +"]: " + str(textMap[lineNumber][characterNumber-1]))
					#else:
						#print("characterNumber: " + str(characterNumber))
						
					var mapNumber = {
						"text": character,
						"isNextToSymbol": false,
					}
					
					var mapNumberToNumber = func():
						return int(mapNumber.text)
						
					mapNumber.number = mapNumberToNumber
					mapData.mapNumber = mapNumber
					listOfNumbers.append(mapNumber)
			elif character == "*":
				mapData.value = character
				mapData.isGear = true
				mapData.adjacentParts = []
			else:
				mapData.value = character
			
			characterNumber += 1
		lineNumber += 1
	
	pass

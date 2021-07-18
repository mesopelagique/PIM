Class extends PIMObject

Class constructor
	Super:C1705()
	This:C1470.version:="2.0"
	This:C1470.events:=New collection:C1472
	
Function getText()->$formattedString : Text
	
	var $nl : Text
	$nl:=This:C1470.nl()
	
	$formattedString:="BEGIN:VCALENDAR"+$nl
	$formattedString:=$formattedString+"VERSION:"+This:C1470.version+$nl
	//PRODID:-  //hacksw/handcal//NONSGML v1.0//EN
	
	If (This:C1470.prodID#Null:C1517)
		$formattedString:=$formattedString+"PRODID:"+This:C1470.e(This:C1470.prodID)+$nl
	End if 
	
	var $event : Object
	For each ($event; This:C1470.events)
		$formattedString:=$formattedString+$event.getText()
	End for each 
	
	$formattedString:=$formattedString+"END:VCALENDAR"+$nl
	
	// Save to file
Function saveToFile($file : 4D:C1709.File)
	$file.setText(This:C1470.getText(); "UTF-8-no-bom"; Document with CRLF:K24:20)
	
Function getMimeType()->$type : Text
	$type:="text/calendar"
	
	// Send in http
Function webSend($fileName : Text)
	ARRAY TEXT:C222($fieldArray; 2)
	ARRAY TEXT:C222($valueArray; 2)
	
	$fieldArray{1}:="Content-Type"
	$fieldArray{2}:="Content-Disposition"
	
	$valueArray{1}:=This:C1470.getMimeType()+"; name=\""+$fileName+"\""
	$valueArray{2}:="inline; filename=\""+$fileName+"\""
	
	WEB SET HTTP HEADER:C660($fieldArray; $valueArray)
	WEB SEND TEXT:C677(This:C1470.getText())
	
	// get major part of versio
Function _getMajorVersion()->$majorVersion
	If (This:C1470.version#Null:C1517)
		$majorVersion:=Num:C11(Split string:C1554(This:C1470.version; ".")[0])
	Else 
		$majorVersion:=2
	End if 
	
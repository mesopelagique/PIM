Class extends PIMObject

Class constructor
	
Function getText()->$formattedString : Text
	
	var $nl : Text
	$nl:=This:C1470.nl()
	$formattedString:="BEGIN:VALARM"+$nl
/*
ACTION:AUDIO
TRIGGER:19980414T120000
ATTACH;FMTTYPE=audio/basic:http://host.com/pub/audio-files/ssbanner.aud
REPEAT:4
DURATION:PT1H
*/
	
	$formattedString:=$formattedString+"END:VALARM"+$nl
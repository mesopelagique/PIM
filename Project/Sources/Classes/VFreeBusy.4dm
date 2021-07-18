Class extends PIMObject

Class constructor
	
Function getText()->$formattedString : Text
	
	var $nl : Text
	$nl:=This:C1470.nl()
	$formattedString:="BEGIN:VFREEBUSY"+$nl
/*
ORGANIZER:MAILTO:jsmith@host.com
DTSTART:19980313T141711Z
DTEND:19980410T141711Z
FREEBUSY:19980314T233000Z/19980315T003000Z
FREEBUSY:19980316T153000Z/19980316T163000Z
FREEBUSY:19980318T030000Z/19980318T040000Z
URL:http://www.host.com/calendar/busytime/jsmith.ifb
*/
	
	$formattedString:=$formattedString+"END:VFREEBUSY"+$nl
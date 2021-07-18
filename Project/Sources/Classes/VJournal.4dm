Class extends PIMObject

Class constructor
	
Function getText()->$formattedString : Text
	
	var $nl : Text
	$nl:=This:C1470.nl()
	$formattedString:="BEGIN:VJOURNAL"+$nl
/*
DTSTAMP:19970324T120000Z
UID:uid5@host1.com
ORGANIZER:MAILTO:jsmith@host.com
STATUS:DRAFT
CLASS:PUBLIC
CATEGORY:Project Report, XYZ, Weekly Meeting
DESCRIPTION:Pxxx
*/
	$formattedString:=$formattedString+"END:VJOURNAL"+$nl
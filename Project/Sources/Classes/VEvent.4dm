Class extends PIMObject

Class constructor
	
Function getText()->$formattedString : Text
	
	var $nl : Text
	$nl:=This:C1470.nl()
	$formattedString:="BEGIN:VEVENT"+$nl
	
	
	$formattedString:=$formattedString+"DTSTART:"+This:C1470.getFormattedDateTime(This:C1470.startDate; This:C1470.startTime)+$nl
	$formattedString:=$formattedString+"DTEND:"+This:C1470.getFormattedDateTime(This:C1470.endDate; This:C1470.endTime)+$nl
	
	If (This:C1470.summary#Null:C1517)
		$formattedString:=$formattedString+"SUMMARY:"+This:C1470.summary+$nl
	End if 
	
	If (This:C1470.location#Null:C1517)
		$formattedString:=$formattedString+"LOCATION:"+This:C1470.location+$nl
	End if 
	
	If (This:C1470.categories#Null:C1517)
		Case of 
			: (Value type:C1509(This:C1470.categories)=Is collection:K8:32)
				$formattedString:=$formattedString+"CATEGORIES:"+This:C1470.categories.join(", ")+$nl
			Else 
				$formattedString:=$formattedString+"CATEGORIES:"+This:C1470.categories+$nl
		End case 
	End if 
	If (This:C1470.status#Null:C1517)
		$formattedString:=$formattedString+"STATUS:"+This:C1470.status+$nl
	End if 
	If (This:C1470.description#Null:C1517)
		$formattedString:=$formattedString+"DESCRIPTION:"+This:C1470.description+$nl
	End if 
	If (This:C1470.transp#Null:C1517)
		$formattedString:=$formattedString+"TRANSP:"+This:C1470.transp+$nl  //  (OPAQUE, TRANSPARENT)
	End if 
	If (This:C1470.sequence#Null:C1517)
		$formattedString:=$formattedString+"SEQUENCE:"+String:C10(This:C1470.sequence)+$nl
	End if 
	
	If (Value type:C1509(This:C1470.alarms)=Is collection:K8:32)
		var $event : Object
		For each ($event; This:C1470.alarms)
			$formattedString:=$formattedString+$event.getText()
		End for each 
	End if 
	
	$formattedString:=$formattedString+"END:VEVENT"+$nl
	
	
Function incSeq()
	If (This:C1470.sequence=Null:C1517)
		This:C1470.sequence:=1
	Else 
		This:C1470.sequence:=This:C1470.sequence+1
	End if 
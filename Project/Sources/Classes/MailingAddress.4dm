Class extends PIMObject

Class constructor($type : Text)
	Super:C1705()
	This:C1470.type:=$type
	This:C1470.label:=""
	This:C1470.street:=""
	This:C1470.city:=""
	This:C1470.stateProvince:=""
	This:C1470.postalCode:=""
	This:C1470.countryRegion:=""
	
Function getFormattedString($encodingPrefix : Text; $majorVersion : Integer)->$formattedAddress : Text
	var $nl : Text
	$nl:=This:C1470.nl()
	
	var $address : Object
	$address:=This:C1470
	
	$formattedAddress:=""
	
	If (($address.label#Null:C1517) | \
		($address.street#Null:C1517) | \
		($address.city#Null:C1517) | \
		($address.stateProvince#Null:C1517) | \
		($address.postalCode#Null:C1517) | \
		($address.countryRegion#Null:C1517))
		
		If ($majorVersion>=4)
			$formattedAddress:="ADR"+$encodingPrefix+";TYPE="+$address.type+\
				(Choose:C955($address.label#Null:C1517; ";LABEL=\""+This:C1470.e($address.label)+"\""; ""))+":;;"+\
				This:C1470.e($address.street)+";"+\
				This:C1470.e($address.city)+";"+\
				This:C1470.e($address.stateProvince)+";"+\
				This:C1470.e($address.postalCode)+";"+\
				This:C1470.e($address.countryRegion)+$nl
		Else 
			If ($address.label#Null:C1517)
				$formattedAddress:="LABEL"+$encodingPrefix+";TYPE="+$address.type+":"+This:C1470.e($address.label)+$nl
			End if 
			$formattedAddress:=$formattedAddress+"ADR"+$encodingPrefix+";TYPE="+$address.type+":;;"+\
				This:C1470.e($address.street)+";"+\
				This:C1470.e($address.city)+";"+\
				This:C1470.e($address.stateProvince)+";"+\
				This:C1470.e($address.postalCode)+";"+\
				This:C1470.e($address.countryRegion)+$nl
		End if 
		
	End if 
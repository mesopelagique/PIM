Class constructor
	
	// constant
Function nl()->$nl : Text
	$nl:="\r\n"
	
	// encode values
Function e($value : Variant)->$result : Text
	If ($value#Null:C1517)
		Case of 
			: (Value type:C1509($value)=Is collection:K8:32)
				$value:=""+JSON Stringify:C1217($value)
			: (Value type:C1509($value)=Is object:K8:27)
				$value:=""+JSON Stringify:C1217($value)
			Else 
				$value:=""+String:C10($value)
		End case 
		
		$result:=Replace string:C233($value; "\n"; "\\n")
		$result:=Replace string:C233($result; ","; "\\,")
		$result:=Replace string:C233($result; ";"; "\\;")
		
	Else 
		$result:=""
	End if 
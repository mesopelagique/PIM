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
	
Function YYYYMMDD($date : Variant)->$formatted : Text
	
	Case of 
		: (Value type:C1509($date)=Is date:K8:7)
			
			// XX better way? by passing format
			$formatted:=String:C10(Year of:C25($date))
			If (Length:C16(String:C10(Month of:C24($date)))=1)
				$formatted:=$formatted+"0"
			End if 
			$formatted:=$formatted+String:C10(Month of:C24($date))
			If (Length:C16(String:C10(Day of:C23($date)))=1)
				$formatted:=$formatted+"0"
			End if 
			$formatted:=$formatted+String:C10(Day of:C23($date))
			
			
		: (Value type:C1509($date)=Is text:K8:3)
			$formatted:=$date  // sppose formatted...
			
		Else 
			ASSERT:C1129(False:C215; "Wrong type of date")
			$formatted:=""
	End case 
//%attributes = {"invisible":true}
#DECLARE($fieldName : Text; $lines : Collection)->$value : Text

var $found : Boolean
$found:=False:C215
var $line : Text
For each ($line; $lines) Until ($found)
	If (Position:C15($fieldName; $line)=1)
		$value:=Split string:C1554($line; ":")[1]
		$found:=True:C214
	End if 
End for each 
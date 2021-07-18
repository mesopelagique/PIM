Class extends PIMObject

Class constructor($type : Text)
	Super:C1705()
	This:C1470.type:=$type
	This:C1470.url:=""
	This:C1470.mediaType:=""
	This:C1470.base64:=False:C215
	
Function attachFromUrl($url : Text; $mediaType : Text)
	This:C1470.url:=$url; 
	If (Count parameters:C259>1)
		This:C1470.mediaType:=$mediaType
	End if 
	This:C1470.base64:=False:C215
	
Function embedFromFile($file : 4D:C1709.File)
	This:C1470.mediaType:=$file.extension  // TODO check if . 
	var $encoded : Text
	var $blob : Blob
	$blob:=$file.getContent()
	BASE64 ENCODE:C895($blob; $encoded)
	This:C1470.url:=$encoded
	This:C1470.base64:=True:C214
	
Function embedFromString($base64String : Text; $mediaType : Text){
	This:C1470.mediaType:=$mediaType
	This:C1470.url:=$base64String
	This:C1470.base64:=True:C214
	
Function getText($majorVersion : Integer)->$formattedPhoto : Text
	var $params : Text
	Case of 
		: ($majorVersion>=4)
			$params:=Choose:C955(This:C1470.base64; ";ENCODING=b;MEDIATYPE=image/"; ";MEDIATYPE=image/")
		: ($majorVersion=3)
			$params:=Choose:C955(This:C1470.base64; ";ENCODING=b;TYPE="; ";TYPE=")
		Else 
			$params:=Choose:C955(This:C1470.base64; ";ENCODING=BASE64; "; ";")
	End case 
	
	$formattedPhoto:=This:C1470.type+$params+This:C1470.mediaType+":"+This:C1470.e(This:C1470.url)+This:C1470.nl()
	
Function _parse($line : Text)
	var $key; $keyClean; $value : Text
	$key:=Split string:C1554($line; ":")[0]
	$value:=Split string:C1554($line; ":")[1]  // OPTI: split one time
	
	$keyClean:=Split string:C1554($key; ";")[0]
	If (Asserted:C1132($keyClean=This:C1470.type; "wrong type"))
		
		If (($value="https") | ($value="http"))  // maybe other scheme 
			$value:=$value+":"+Split string:C1554($line; ":")[2]  // maybe more?
			This:C1470.url:=$value
			This:C1470.base64:=False:C215
		Else 
			This:C1470.base64:=True:C214
		End if 
		
		//TODO This.mediaType
		
	End if 
Class constructor
	This:C1470.version:="3.0"
	This:C1470.photo:=cs:C1710.Photo.new()
	This:C1470.logo:=cs:C1710.Photo.new()
	This:C1470.socialUrls:=New object:C1471("facebook"; ""; "linkedIn"; ""; "twitter"; ""; "flickr"; "")
	This:C1470.homeAddress:=cs:C1710.MailingAddress.new()
	This:C1470.workAddress:=cs:C1710.MailingAddress.new()
	
	// constant
Function nl()->$nl : Text
	$nl:="\r\n"
	
	
	// formatting of objects
	
	
Function getFormattedPhoto($photoType : Text; $url : Text; $mediaType : Text; $base64 : Boolean; $majorVersion : Integer)->$formattedPhoto : Text
	
	var $nl : Text
	$nl:=This:C1470.nl()
	var $params : Text
	Case of 
		: ($majorVersion>=4)
			$params:=Choose:C955($base64; ";ENCODING=b;MEDIATYPE=image/"; ";MEDIATYPE=image/")
		: ($majorVersion=3)
			$params:=Choose:C955($base64; ";ENCODING=b;TYPE="; ";TYPE=")
		Else 
			$params:=Choose:C955($base64; ";ENCODING=BASE64; "; ";")
	End case 
	
	$formattedPhoto:=$photoType+$params+$mediaType+":"+This:C1470.e($url)+$nl
	
Function getFormattedAddress($encodingPrefix : Text; $address : Object; $majorVersion : Integer)->$formattedAddress : Text
	var $nl : Text
	$nl:=This:C1470.nl()
	
	$formattedAddress:=""
	
	If (($address.details.label#Null:C1517) | \
		($address.details.street#Null:C1517) | \
		($address.details.city#Null:C1517) | \
		($address.details.stateProvince#Null:C1517) | \
		($address.details.postalCode#Null:C1517) | \
		($address.details.countryRegion#Null:C1517))
		
		If ($majorVersion>=4)
			$formattedAddress:="ADR"+$encodingPrefix+";TYPE="+$address.type+\
				(Choose:C955($address.details.label#Null:C1517; ";LABEL=\""+This:C1470.e($address.details.label)+"\""; ""))+":;;"+\
				This:C1470.e($address.details.street)+";"+\
				This:C1470.e($address.details.city)+";"+\
				This:C1470.e($address.details.stateProvince)+";"+\
				This:C1470.e($address.details.postalCode)+";"+\
				This:C1470.e($address.details.countryRegion)+$nl
		Else 
			If ($address.details.label#Null:C1517)
				$formattedAddress:="LABEL"+$encodingPrefix+";TYPE="+$address.type+":"+This:C1470.e($address.details.label)+$nl
			End if 
			$formattedAddress:=$formattedAddress+"ADR"+$encodingPrefix+";TYPE="+$address.type+":;;"+\
				This:C1470.e($address.details.street)+";"+\
				This:C1470.e($address.details.city)+";"+\
				This:C1470.e($address.details.stateProvince)+";"+\
				This:C1470.e($address.details.postalCode)+";"+\
				This:C1470.e($address.details.countryRegion)+$nl
		End if 
		
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
	
Function getFormattedString()->$formattedVCardString : Text
	var $vCard : Object
	$vCard:=This:C1470
	
	var $nl : Text
	$nl:=This:C1470.nl()
	
	var $address; $encodingPrefix; $formattedName : Text
	var $number : Variant
	var $collection : Variant  // collection but could be other type before making col
	
	var $majorVersion : Integer
	$majorVersion:=$vCard._getMajorVersion()
	
	$formattedVCardString:="BEGIN:VCARD"+$nl
	$formattedVCardString:=$formattedVCardString+"VERSION:"+$vCard.version+$nl
	
	$encodingPrefix:=Choose:C955($majorVersion>=4; ""; ";CHARSET=UTF-8")
	$formattedName:=$vCard.formattedName
	
	If ($formattedName=Null:C1517)
		$formattedName:=""
		
		var $name : Variant
		For each ($name; New collection:C1472($vCard.firstName; $vCard.middleName; $vCard.lastName))
			
			If (Length:C16($formattedName)>0)
				$formattedName:=$formattedName+" "
			End if 
			If ($name#Null:C1517)
				$formattedName:=$formattedName+$name
			End if 
		End for each 
	End if 
	
	$formattedVCardString:=$formattedVCardString+"FN"+$encodingPrefix+":"+This:C1470.e($formattedName)+$nl
	$formattedVCardString:=$formattedVCardString+"N"+$encodingPrefix+":"+\
		This:C1470.e($vCard.lastName)+";"+\
		This:C1470.e($vCard.firstName)+";"+\
		This:C1470.e($vCard.middleName)+";"+\
		This:C1470.e($vCard.namePrefix)+";"+\
		This:C1470.e($vCard.nameSuffix)+$nl
	
	If (($vCard.nickname#Null:C1517) & ($majorVersion>=3))
		$formattedVCardString:=$formattedVCardString+"NICKNAME"+$encodingPrefix+":"+This:C1470.e($vCard.nickname)+$nl
	End if 
	
	If ($vCard.gender#Null:C1517)
		$formattedVCardString:=$formattedVCardString+"GENDER:"+This:C1470.e($vCard.gender)+$nl
	End if 
	
	If ($vCard.uid#Null:C1517)
		$formattedVCardString:=$formattedVCardString+"UID"+$encodingPrefix+":"+This:C1470.e($vCard.uid)+$nl
	End if 
	
	If ($vCard.birthday#Null:C1517)
		$formattedVCardString:=$formattedVCardString+"BDAY:"+This:C1470.YYYYMMDD($vCard.birthday)+$nl
	End if 
	
	If ($vCard.anniversary#Null:C1517)
		$formattedVCardString:=$formattedVCardString+"ANNIVERSARY:"+This:C1470.YYYYMMDD($vCard.anniversary)+$nl
	End if 
	
	If ($vCard.email#Null:C1517)
		$collection:=$vCard.email
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($address; $collection)
			Case of 
				: ($majorVersion>=4)
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";type=HOME:"+This:C1470.e($address)+$nl
				: ($majorVersion=3)
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";type=HOME,INTERNET:"+This:C1470.e($address)+$nl
				Else 
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";type=HOME;INTERNET:"+This:C1470.e($address)+$nl
			End case 
		End for each 
	End if 
	
	If ($vCard.workEmail#Null:C1517)
		
		$collection:=$vCard.workEmail
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($address; $collection)
			Case of 
				: ($majorVersion>=4)
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";type=WORK:"+This:C1470.e($address)+$nl
				: ($majorVersion=3)
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";type=HOME,INTERNET:"+This:C1470.e($address)+$nl
				Else 
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";type=HOME;INTERNET:"+This:C1470.e($address)+$nl
			End case 
		End for each 
		
	End if 
	
	If ($vCard.otherEmail#Null:C1517)
		
		$collection:=$vCard.otherEmail
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($address; $collection)
			Case of 
				: ($majorVersion>=4)
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";type=OTHER:"+This:C1470.e($address)+$nl
				: ($majorVersion=3)
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";type=HOME,INTERNET:"+This:C1470.e($address)+$nl
				Else 
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";type=HOME;INTERNET:"+This:C1470.e($address)+$nl
			End case 
		End for each 
		
	End if 
	
	If ($vCard.logo.url#Null:C1517)
		$formattedVCardString:=$formattedVCardString+This:C1470.getFormattedPhoto("LOGO"; $vCard.logo.url; $vCard.logo.mediaType; $vCard.logo.base64; $majorVersion)
	End if 
	
	If ($vCard.photo.url#Null:C1517)
		$formattedVCardString:=$formattedVCardString+This:C1470.getFormattedPhoto("PHOTO"; $vCard.photo.url; $vCard.photo.mediaType; $vCard.photo.base64; $majorVersion)
	End if 
	
	If ($vCard.cellPhone#Null:C1517)
		$collection:=$vCard.cellPhone
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($number; $collection)
			If ($majorVersion>=4)
				$formattedVCardString:=$formattedVCardString+"TEL;VALUE=uri;TYPE=\"voice,cell\":tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=CELL:"+This:C1470.e(String:C10($number))+$nl
			End if 
		End for each 
	End if 
	
	If ($vCard.pagerPhone#Null:C1517)
		$collection:=$vCard.pagerPhone
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($number; $collection)
			If ($majorVersion>=4)
				$formattedVCardString:=$formattedVCardString+"TEL;VALUE=uri;TYPE=\"pager,cell\":tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=PAGER:"+This:C1470.e(String:C10($number))+$nl
			End if 
		End for each 
		
	End if 
	
	If ($vCard.homePhone#Null:C1517)
		$collection:=$vCard.homePhone
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($number; $collection)
			If ($majorVersion>=4)
				$formattedVCardString:=$formattedVCardString+"TEL;VALUE=uri;TYPE=\"voice,home\":tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=HOME,VOICE:"+This:C1470.e(String:C10($number))+$nl
			End if 
		End for each 
	End if 
	
	If ($vCard.workPhone#Null:C1517)
		$collection:=$vCard.workPhone
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($number; $collection)
			If ($majorVersion>=4)
				$formattedVCardString:=$formattedVCardString+"TEL;VALUE=uri;TYPE=\"voice,work\":tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=WORK,VOICE:"+This:C1470.e(String:C10($number))+$nl
			End if 
		End for each 
	End if 
	
	If ($vCard.homeFax#Null:C1517)
		$collection:=$vCard.homeFax
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($number; $collection)
			If ($majorVersion>=4)
				$formattedVCardString:=$formattedVCardString+"TEL;VALUE=uri;TYPE=\"fax,home\":tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=HOME,FAX:"+This:C1470.e(String:C10($number))+$nl
			End if 
		End for each 
		
	End if 
	
	If ($vCard.workFax#Null:C1517)
		$collection:=$vCard.workFax
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($number; $collection)
			If ($majorVersion>=4)
				$formattedVCardString:=$formattedVCardString+"TEL;VALUE=uri;TYPE=\"fax,work\":tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=WORK,FAX:"+This:C1470.e(String:C10($number))+$nl
			End if 
		End for each 
		
	End if 
	
	If ($vCard.otherPhone#Null:C1517)
		$collection:=$vCard.otherPhone
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($number; $collection)
			If ($majorVersion>=4)
				$formattedVCardString:=$formattedVCardString+"TEL;VALUE=uri;TYPE=\"voice,other\":tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=OTHER:"+This:C1470.e(String:C10($number))+$nl
			End if 
		End for each 
		
	End if 
	
	var $addressObject : Object
	For each ($addressObject; New collection:C1472(New object:C1471("details"; $vCard.homeAddress; "type"; "HOME"); New object:C1471("details"; $vCard.workAddress; "type"; "WORK")))
		
		$formattedVCardString:=$formattedVCardString+This:C1470.getFormattedAddress($encodingPrefix; $addressObject; $majorVersion)
		
	End for each 
	
	If ($vCard.title#Null:C1517)
		If (Length:C16($vCard.title)>0)
			$formattedVCardString:=$formattedVCardString+"TITLE"+$encodingPrefix+":"+This:C1470.e($vCard.title)+$nl
		End if 
	End if 
	
	If ($vCard.role#Null:C1517)
		If (Length:C16($vCard.role)>0)
			$formattedVCardString:=$formattedVCardString+"ROLE"+$encodingPrefix+":"+This:C1470.e($vCard.role)+$nl
		End if 
	End if 
	
	If ($vCard.organization#Null:C1517)
		If (Length:C16($vCard.organization)>0)
			$formattedVCardString:=$formattedVCardString+"ORG"+$encodingPrefix+":"+This:C1470.e($vCard.organization)+$nl
		End if 
	End if 
	
	If ($vCard.url#Null:C1517)
		If (Length:C16($vCard.url)>0)
			$formattedVCardString:=$formattedVCardString+"URL"+$encodingPrefix+":"+This:C1470.e($vCard.url)+$nl
		End if 
	End if 
	
	If ($vCard.workUrl#Null:C1517)
		If (Length:C16($vCard.workUrl)>0)
			$formattedVCardString:=$formattedVCardString+"URL;type=WORK"+$encodingPrefix+":"+This:C1470.e($vCard.workUrl)+$nl
		End if 
	End if 
	
	If ($vCard.note#Null:C1517)
		If (Length:C16($vCard.source)>0)
			$formattedVCardString:=$formattedVCardString+"NOTE"+$encodingPrefix+":"+This:C1470.e($vCard.note)+$nl
		End if 
	End if 
	
	If (Value type:C1509($vCard.socialUrls)=Is object:K8:27)
		var $key : Text
		For each ($key; $vCard.socialUrls)
			If ($vCard.socialUrls[$key]#Null:C1517)
				If (Length:C16($vCard.socialUrls[$key])>0)
					$formattedVCardString:=$formattedVCardString+"X-SOCIALPROFILE;TYPE="+$key+":"+This:C1470.e($vCard.socialUrls[$key])+$nl
				End if 
			End if 
		End for each 
	End if 
	
	If ($vCard.source#Null:C1517)
		If (Length:C16($vCard.source)>0)
			$formattedVCardString:=$formattedVCardString+"SOURCE"+$encodingPrefix+":"+This:C1470.e($vCard.source)+$nl
		End if 
	End if 
	
	$formattedVCardString:=$formattedVCardString+"REV:"+String:C10(Current date:C33; ISO date:K1:8)+$nl
	If (Bool:C1537($vCard.isOrganization))
		$formattedVCardString:=$formattedVCardString+"X-ABShowAs:COMPANY"+$nl
	End if 
	
	$formattedVCardString:=$formattedVCardString+"END:VCARD"+$nl
	
	
	// Save to file
Function saveToFile($file : 4D:C1709.File)
	$file.setText(This:C1470.getFormattedString(); "UTF-8-no-bom"; Document with CRLF:K24:20)
	
	// Send in http
Function webSend($fileName : Text)
	ARRAY TEXT:C222($fieldArray; 2)
	$fieldArray{1}:="Content-Type"
	$fieldArray{2}:="Content-Disposition"
	ARRAY TEXT:C222($valueArray; 2)
	If (Count parameters:C259>0)
		$valueArray{1}:="text/vcard; name=\""+$fileName+"\""
		$valueArray{2}:="inline; filename=\""+$fileName+"\""
	Else 
		$valueArray{1}:="text/vcard; name=\"file.vcard\""
		$valueArray{2}:="inline; filename=\"file.vcard\""
	End if 
	
	WEB SET HTTP HEADER:C660($fieldArray; $valueArray)
	WEB SEND TEXT:C677(This:C1470.getFormattedString())
	
	// get major part of versio
Function _getMajorVersion()->$majorVersion
	If (This:C1470.version#Null:C1517)
		$majorVersion:=Num:C11(Split string:C1554(This:C1470.version; ".")[0])
	Else 
		$majorVersion:=4
	End if 
	
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
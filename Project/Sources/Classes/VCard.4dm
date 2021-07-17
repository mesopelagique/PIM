Class extends PIMObject

Class constructor
	Super:C1705()
	This:C1470.version:="3.0"
	This:C1470.photo:=PIM.Photo.new("PHOTO")
	This:C1470.logo:=PIM.Photo.new("LOGO")
	This:C1470.socialUrls:=New object:C1471("facebook"; ""; "linkedIn"; ""; "twitter"; ""; "flickr"; "")
	This:C1470.homeAddress:=PIM.MailingAddress.new("HOME")
	This:C1470.workAddress:=PIM.MailingAddress.new("WORK")
	
Function getFormattedName()->$formattedName : Text
	
	$formattedName:=This:C1470.formattedName
	
	If (Length:C16($formattedName)=0)
		$formattedName:=""
		
		var $name : Variant
		For each ($name; New collection:C1472(This:C1470.firstName; This:C1470.middleName; This:C1470.lastName))
			
			If (Length:C16($formattedName)>0)
				$formattedName:=$formattedName+" "
			End if 
			If ($name#Null:C1517)
				$formattedName:=$formattedName+String:C10($name)
			End if 
		End for each 
	End if 
	
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
	
	If (($vCard.prodID#Null:C1517) & ($majorVersion>=3))
		$formattedVCardString:=$formattedVCardString+"PRODID:"+This:C1470.e($vCard.prodID)+$nl
	End if 
	
	$encodingPrefix:=Choose:C955($majorVersion>=4; ""; ";CHARSET=UTF-8")
	$formattedName:=$vCard.getFormattedName()
	
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
		$formattedVCardString:=$formattedVCardString+"GENDER:"+This:C1470.e($vCard.gender)+$nl  // ('','M','F','O','N','U')
	End if 
	
	If (($vCard.fbURL#Null:C1517) & ($majorVersion>=4))
		$formattedVCardString:=$formattedVCardString+"FBURL:"+This:C1470.e($vCard.fbURL)+$nl
	End if 
	
	If (($vCard.kind#Null:C1517) & ($majorVersion>=4))
		$formattedVCardString:=$formattedVCardString+"KIND:"+This:C1470.e($vCard.kind)+$nl  // ('individual', 'group', 'organization' ou 'location')
	End if 
	
	If (($vCard.lang#Null:C1517) & ($majorVersion>=4))
		$formattedVCardString:=$formattedVCardString+"LANG:"+This:C1470.e($vCard.lang)+$nl
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
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";HOME;INTERNET:"+This:C1470.e($address)+$nl
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
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";type=WORK,INTERNET:"+This:C1470.e($address)+$nl
				Else 
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";WORK;INTERNET:"+This:C1470.e($address)+$nl
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
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";type=OTHER,INTERNET:"+This:C1470.e($address)+$nl
				Else 
					$formattedVCardString:=$formattedVCardString+"EMAIL"+$encodingPrefix+";OTHER;INTERNET:"+This:C1470.e($address)+$nl
			End case 
		End for each 
		
	End if 
	
	If ($vCard.logo.url#Null:C1517)
		$formattedVCardString:=$formattedVCardString+$vCard.logo.getFormattedString($majorVersion)
	End if 
	
	If ($vCard.photo.url#Null:C1517)
		$formattedVCardString:=$formattedVCardString+$vCard.photo.getFormattedString($majorVersion)
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
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=\"voice,home\";VALUE=uri:tel:"+This:C1470.e(String:C10($number))+$nl
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
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=\"voice,work\";VALUE=uri:tel:"+This:C1470.e(String:C10($number))+$nl
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
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=\"fax,home\";VALUE=uri:tel:"+This:C1470.e(String:C10($number))+$nl
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
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=\"fax,work\";VALUE=uri:tel:"+This:C1470.e(String:C10($number))+$nl
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
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=\"voice,other\";VALUE=uri:tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedVCardString:=$formattedVCardString+"TEL;TYPE=OTHER:"+This:C1470.e(String:C10($number))+$nl
			End if 
		End for each 
		
	End if 
	
	var $addressObject : Object
	For each ($addressObject; New collection:C1472($vCard.homeAddress; $vCard.workAddress))
		
		$formattedVCardString:=$formattedVCardString+$addressObject.getFormattedString($encodingPrefix; $majorVersion)
		
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
	
	$formattedVCardString:=$formattedVCardString+"REV:"+This:C1470.getFormattedDateTime(Current date:C33; Current time:C178)+$nl
	
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
	ARRAY TEXT:C222($valueArray; 2)
	
	$fieldArray{1}:="Content-Type"
	$fieldArray{2}:="Content-Disposition"
	
	var $fileNameTmp : Text
	If (Count parameters:C259>0)
		$fileNameTmp:=$fileName
	Else 
		$fileNameTmp:=This:C1470.getFormattedName()
		If (Length:C16($fileNameTmp)=0)
			$fileNameTmp:="file"
		End if 
	End if 
	$valueArray{1}:="text/vcard; name=\""+$fileNameTmp+"\""
	$valueArray{2}:="inline; filename=\""+$fileNameTmp+"\""
	
	WEB SET HTTP HEADER:C660($fieldArray; $valueArray)
	WEB SEND TEXT:C677(This:C1470.getFormattedString())
	
	// get major part of versio
Function _getMajorVersion()->$majorVersion
	If (This:C1470.version#Null:C1517)
		$majorVersion:=Num:C11(Split string:C1554(This:C1470.version; ".")[0])
	Else 
		$majorVersion:=4
	End if 
	
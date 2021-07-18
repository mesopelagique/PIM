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
	
Function getText()->$formattedString : Text
	var $vCard : Object
	$vCard:=This:C1470
	
	var $nl : Text
	$nl:=This:C1470.nl()
	
	var $address; $encodingPrefix; $formattedName : Text
	var $number : Variant
	var $collection : Variant  // collection but could be other type before making col
	
	var $majorVersion : Integer
	$majorVersion:=$vCard._getMajorVersion()
	
	$formattedString:="BEGIN:VCARD"+$nl
	$formattedString:=$formattedString+"VERSION:"+$vCard.version+$nl
	
	If (($vCard.prodID#Null:C1517) & ($majorVersion>=3))
		$formattedString:=$formattedString+"PRODID:"+This:C1470.e($vCard.prodID)+$nl
	End if 
	
	$encodingPrefix:=Choose:C955($majorVersion>=4; ""; ";CHARSET=UTF-8")
	$formattedName:=$vCard.getFormattedName()
	
	$formattedString:=$formattedString+"FN"+$encodingPrefix+":"+This:C1470.e($formattedName)+$nl
	$formattedString:=$formattedString+"N"+$encodingPrefix+":"+\
		This:C1470.e($vCard.lastName)+";"+\
		This:C1470.e($vCard.firstName)+";"+\
		This:C1470.e($vCard.middleName)+";"+\
		This:C1470.e($vCard.namePrefix)+";"+\
		This:C1470.e($vCard.nameSuffix)+$nl
	
	If (($vCard.nickName#Null:C1517) & ($majorVersion>=3))
		$formattedString:=$formattedString+"NICKNAME"+$encodingPrefix+":"+This:C1470.e($vCard.nickName)+$nl
	End if 
	
	If ($vCard.gender#Null:C1517)
		$formattedString:=$formattedString+"GENDER:"+This:C1470.e($vCard.gender)+$nl  // ('','M','F','O','N','U')
	End if 
	
	If (($vCard.fbURL#Null:C1517) & ($majorVersion>=4))
		$formattedString:=$formattedString+"FBURL:"+This:C1470.e($vCard.fbURL)+$nl
	End if 
	
	If (($vCard.kind#Null:C1517) & ($majorVersion>=4))
		$formattedString:=$formattedString+"KIND:"+This:C1470.e($vCard.kind)+$nl  // ('individual', 'group', 'organization' ou 'location')
	End if 
	
	If (($vCard.lang#Null:C1517) & ($majorVersion>=4))
		$formattedString:=$formattedString+"LANG:"+This:C1470.e($vCard.lang)+$nl
	End if 
	
	If ($vCard.uid#Null:C1517)
		$formattedString:=$formattedString+"UID"+$encodingPrefix+":"+This:C1470.e($vCard.uid)+$nl
	End if 
	
	If ($vCard.birthday#Null:C1517)
		$formattedString:=$formattedString+"BDAY:"+This:C1470.YYYYMMDD($vCard.birthday)+$nl
	End if 
	
	If ($vCard.anniversary#Null:C1517)
		$formattedString:=$formattedString+"ANNIVERSARY:"+This:C1470.YYYYMMDD($vCard.anniversary)+$nl
	End if 
	
	If ($vCard.email#Null:C1517)
		$collection:=$vCard.email
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($address; $collection)
			Case of 
				: ($majorVersion>=4)
					$formattedString:=$formattedString+"EMAIL"+$encodingPrefix+";type=HOME:"+This:C1470.e($address)+$nl
				: ($majorVersion=3)
					$formattedString:=$formattedString+"EMAIL"+$encodingPrefix+";type=HOME,INTERNET:"+This:C1470.e($address)+$nl
				Else 
					$formattedString:=$formattedString+"EMAIL"+$encodingPrefix+";HOME;INTERNET:"+This:C1470.e($address)+$nl
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
					$formattedString:=$formattedString+"EMAIL"+$encodingPrefix+";type=WORK:"+This:C1470.e($address)+$nl
				: ($majorVersion=3)
					$formattedString:=$formattedString+"EMAIL"+$encodingPrefix+";type=WORK,INTERNET:"+This:C1470.e($address)+$nl
				Else 
					$formattedString:=$formattedString+"EMAIL"+$encodingPrefix+";WORK;INTERNET:"+This:C1470.e($address)+$nl
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
					$formattedString:=$formattedString+"EMAIL"+$encodingPrefix+";type=OTHER:"+This:C1470.e($address)+$nl
				: ($majorVersion=3)
					$formattedString:=$formattedString+"EMAIL"+$encodingPrefix+";type=OTHER,INTERNET:"+This:C1470.e($address)+$nl
				Else 
					$formattedString:=$formattedString+"EMAIL"+$encodingPrefix+";OTHER;INTERNET:"+This:C1470.e($address)+$nl
			End case 
		End for each 
		
	End if 
	
	If ($vCard.logo.url#Null:C1517)
		$formattedString:=$formattedString+$vCard.logo.getText($majorVersion)
	End if 
	
	If ($vCard.photo.url#Null:C1517)
		$formattedString:=$formattedString+$vCard.photo.getText($majorVersion)
	End if 
	
	If ($vCard.cellPhone#Null:C1517)
		$collection:=$vCard.cellPhone
		If (Value type:C1509($collection)#Is collection:K8:32)
			$collection:=New collection:C1472($collection)
		End if 
		
		For each ($number; $collection)
			If ($majorVersion>=4)
				$formattedString:=$formattedString+"TEL;VALUE=uri;TYPE=\"voice,cell\":tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedString:=$formattedString+"TEL;TYPE=CELL:"+This:C1470.e(String:C10($number))+$nl
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
				$formattedString:=$formattedString+"TEL;VALUE=uri;TYPE=\"pager,cell\":tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedString:=$formattedString+"TEL;TYPE=PAGER:"+This:C1470.e(String:C10($number))+$nl
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
				$formattedString:=$formattedString+"TEL;TYPE=\"voice,home\";VALUE=uri:tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedString:=$formattedString+"TEL;TYPE=HOME,VOICE:"+This:C1470.e(String:C10($number))+$nl
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
				$formattedString:=$formattedString+"TEL;TYPE=\"voice,work\";VALUE=uri:tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedString:=$formattedString+"TEL;TYPE=WORK,VOICE:"+This:C1470.e(String:C10($number))+$nl
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
				$formattedString:=$formattedString+"TEL;TYPE=\"fax,home\";VALUE=uri:tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedString:=$formattedString+"TEL;TYPE=HOME,FAX:"+This:C1470.e(String:C10($number))+$nl
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
				$formattedString:=$formattedString+"TEL;TYPE=\"fax,work\";VALUE=uri:tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedString:=$formattedString+"TEL;TYPE=WORK,FAX:"+This:C1470.e(String:C10($number))+$nl
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
				$formattedString:=$formattedString+"TEL;TYPE=\"voice,other\";VALUE=uri:tel:"+This:C1470.e(String:C10($number))+$nl
			Else 
				$formattedString:=$formattedString+"TEL;TYPE=OTHER:"+This:C1470.e(String:C10($number))+$nl
			End if 
		End for each 
		
	End if 
	
	var $addressObject : Object
	For each ($addressObject; New collection:C1472($vCard.homeAddress; $vCard.workAddress))
		
		$formattedString:=$formattedString+$addressObject.getText($encodingPrefix; $majorVersion)
		
	End for each 
	
	If ($vCard.title#Null:C1517)
		If (Length:C16($vCard.title)>0)
			$formattedString:=$formattedString+"TITLE"+$encodingPrefix+":"+This:C1470.e($vCard.title)+$nl
		End if 
	End if 
	
	If ($vCard.role#Null:C1517)
		If (Length:C16($vCard.role)>0)
			$formattedString:=$formattedString+"ROLE"+$encodingPrefix+":"+This:C1470.e($vCard.role)+$nl
		End if 
	End if 
	
	If ($vCard.organization#Null:C1517)
		If (Length:C16($vCard.organization)>0)
			$formattedString:=$formattedString+"ORG"+$encodingPrefix+":"+This:C1470.e($vCard.organization)+$nl
		End if 
	End if 
	
	If ($vCard.url#Null:C1517)
		If (Length:C16($vCard.url)>0)
			$formattedString:=$formattedString+"URL"+$encodingPrefix+":"+This:C1470.e($vCard.url)+$nl
		End if 
	End if 
	
	If ($vCard.workUrl#Null:C1517)
		If (Length:C16($vCard.workUrl)>0)
			$formattedString:=$formattedString+"URL;type=WORK"+$encodingPrefix+":"+This:C1470.e($vCard.workUrl)+$nl
		End if 
	End if 
	
	If ($vCard.note#Null:C1517)
		If (Length:C16($vCard.source)>0)
			$formattedString:=$formattedString+"NOTE"+$encodingPrefix+":"+This:C1470.e($vCard.note)+$nl
		End if 
	End if 
	
	If (Value type:C1509($vCard.socialUrls)=Is object:K8:27)
		var $key : Text
		For each ($key; $vCard.socialUrls)
			If ($vCard.socialUrls[$key]#Null:C1517)
				If (Length:C16($vCard.socialUrls[$key])>0)
					$formattedString:=$formattedString+"X-SOCIALPROFILE;TYPE="+$key+":"+This:C1470.e($vCard.socialUrls[$key])+$nl
				End if 
			End if 
		End for each 
	End if 
	
	If ($vCard.source#Null:C1517)
		If (Length:C16($vCard.source)>0)
			$formattedString:=$formattedString+"SOURCE"+$encodingPrefix+":"+This:C1470.e($vCard.source)+$nl
		End if 
	End if 
	
	If (This:C1470.rev#Null:C1517)
		$formattedString:=$formattedString+"REV:"+This:C1470.rev+$nl
	Else 
		$formattedString:=$formattedString+"REV:"+This:C1470.getFormattedDateTime(Current date:C33; Current time:C178)+$nl
	End if 
	
	If (Bool:C1537($vCard.isOrganization))
		$formattedString:=$formattedString+"X-ABShowAs:COMPANY"+$nl
	End if 
	
	$formattedString:=$formattedString+"END:VCARD"+$nl
	
	
	// Save to file
Function saveToFile($file : 4D:C1709.File)
	$file.setText(This:C1470.getText(); "UTF-8-no-bom"; Document with CRLF:K24:20)
	
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
	WEB SEND TEXT:C677(This:C1470.getText())
	
	// get major part of versio
Function _getMajorVersion()->$majorVersion
	If (This:C1470.version#Null:C1517)
		$majorVersion:=Num:C11(Split string:C1554(This:C1470.version; ".")[0])
	Else 
		$majorVersion:=4
	End if 
	
	// try to implement parsing
Function _parseFile($file : 4D:C1709.File)->$valid : Boolean
	$valid:=This:C1470._parse($file.getText("UTF-8-no-bom"; Document with CRLF:K24:20))
	
Function _parse($text : Text)->$valid : Boolean
	var $params : Object
	var $lines; $lineSplit; $keySplit; $paramSplit : Collection
	$lines:=Split string:C1554($text; "\r\n")
	var $line; $key; $value; $keyClean; $param : Text
	$valid:=True:C214
	For each ($line; $lines) Until (Not:C34($valid))
		
		$lineSplit:=Split string:C1554($line; ":")
		If ($lineSplit.length>1)
			
			$key:=$lineSplit[0]
			$value:=$lineSplit[1]
			
			$keySplit:=Split string:C1554($key; ";")
			$keyClean:=$keySplit.shift()
			$params:=New object:C1471
			If ($keySplit.length>0)
				For each ($param; $keySplit)
					$paramSplit:=Split string:C1554($param; "=")
					If ($paramSplit.length>1)
						$params[Lowercase:C14($paramSplit[0])]:=$paramSplit[1]
					End if 
				End for each 
			End if 
			
			Case of 
				: ($key="BEGIN")
					$valid:=($value="VCARD")
					// stop immediately if not vcard
					// maybe other fields to check like version etc...
				: ($key="END")
					// nothing
				: ($key="VERSION")
					This:C1470.version:=$value  // check it? 3.0 4.0 and stop if not valid
				: ($keyClean="FN")
					// cannot decompose?
				: ($keyClean="N")
					// cannot decompose?
				: ($keyClean="NICKNAME")
					This:C1470.nickName:=$value  // XXX maybe add key mapping for simple value like that
				: ($keyClean="GENDER")
					This:C1470.gender:=$value
				: ($keyClean="UID")
					This:C1470.uid:=$value
				: ($keyClean="TITLE")
					This:C1470.title:=$value
				: ($keyClean="ROLE")
					This:C1470.role:=$value
				: ($keyClean="ORG")
					This:C1470.organization:=$value
				: ($keyClean="URL")
					If (($value="https") | ($value="http"))  // maybe other scheme 
						$value:=$value+":"+Split string:C1554($line; ":")[2]  // maybe more? so use position instead
					End if 
					If (String:C10($params.type)="WORK")
						This:C1470.workUrl:=$value
					Else 
						This:C1470.url:=$value
					End if 
				: ($keyClean="NOTE")
					This:C1470.note:=$value  // TODO check if need to decode (other fields too)
				: ($keyClean="BDAY")
					This:C1470.birthday:=This:C1470.DateFromYYYYMMDD($value)
				: ($keyClean="ANNIVERSARY")
					This:C1470.anniversary:=This:C1470.DateFromYYYYMMDD($value)
				: ($keyClean="EMAIL")
					$key:="email"
					Case of 
						: (Position:C15("work"; $params.type)>0)
							$key:="workEmail"
						: (Position:C15("other"; $params.type)>0)
							$key:="otherEmail"
					End case 
					
					// this following code will merge, if there is already tel, no override reset
					Case of 
						: (This:C1470[$key]=Null:C1517)
							This:C1470[$key]:=$value
						: (Value type:C1509(This:C1470[$key])=Is text:K8:3)
							If (This:C1470[$key]#$value)  // no duplicate
								This:C1470[$key]:=New collection:C1472(This:C1470[$key]; $value)
							End if 
						: (Value type:C1509(This:C1470[$key])=Is collection:K8:32)
							If (This:C1470[$key].indexOf($value)<0)  // no duplicate
								This:C1470[$key].push(This:C1470[$key])
							End if 
						Else 
							ASSERT:C1129(False:C215; "Unknow type of email in object "+Value type:C1509(This:C1470[$key]))
					End case 
					
					
				: ($keyClean="TEL")
					
					$key:="cellPhone"
					Case of 
						: (Position:C15("pager"; $params.type)>0)
							$key:="pagerPhone"
						: (Position:C15("work"; $params.type)>0)
							$key:="workPhone"
							If (Position:C15("fax"; $params.type)>0)
								$key:="workFax"
							End if 
						: (Position:C15("home"; $params.type)>0)
							$key:="homePhone"
							If (Position:C15("fax"; $params.type)>0)
								$key:="homeFax"
							End if 
						: (Position:C15("other"; $params.type)>0)
							$key:="otherPhone"
					End case 
					
					// this following code will merge, if there is already tel, no override reset
					Case of 
						: (This:C1470[$key]=Null:C1517)
							This:C1470[$key]:=$value
						: (Value type:C1509(This:C1470[$key])=Is text:K8:3)
							If (This:C1470[$key]#$value)  // no duplicate
								This:C1470[$key]:=New collection:C1472(This:C1470[$key]; $value)
							End if 
						: (Value type:C1509(This:C1470[$key])=Is real:K8:4)
							If (String:C10(This:C1470[$key])#$value)  // no duplicate
								This:C1470[$key]:=New collection:C1472(This:C1470[$key]; $value)
							End if 
						: (Value type:C1509(This:C1470[$key])=Is collection:K8:32)
							If (This:C1470[$key].indexOf($value)<0)  // no duplicate
								This:C1470[$key].push(This:C1470[$key])
							End if 
						Else 
							ASSERT:C1129(False:C215; "Unknow type of email in object "+Value type:C1509(This:C1470[$key]))
					End case 
					
					
				: ($keyClean="LABEL")
					// TODO labrl with ADDRr?
					// TODO get TYPE in $params.type
				: ($keyClean="ADR")
					// TODO labrl with LABEL
				: ($keyClean="LOGO")
					This:C1470.logo._parse($line)
				: ($keyClean="PHOTO")
					This:C1470.photo._parse($line)
				: ($keyClean="X-SOCIALPROFILE")
					If (($value="https") | ($value="http"))  // maybe other scheme 
						$value:=$value+":"+Split string:C1554($line; ":")[2]  // maybe more? so use position instead
					End if 
					This:C1470.socialUrls[$params.type]:=$value
				: ($keyClean="SOURCE")
					If (($value="https") | ($value="http"))  // maybe other scheme 
						$value:=$value+":"+Split string:C1554($line; ":")[2]  // maybe more? so use position instead
					End if 
					This:C1470.source:=$value
					
				: ($keyClean="REV")
					This:C1470.rev:=$value
				Else 
					ASSERT:C1129(False:C215; "Not yet implemented VCard key "+$keyClean)
			End case 
		End if 
		
	End for each 
	
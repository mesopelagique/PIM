//%attributes = {"invisible":true}

var $TEST_VALUE_UID : Text
$TEST_VALUE_UID:="69531f4a-c34d-4a1e-8922-bd38a9476a53"

var $testCard : Object
$testCard:=PIM.VCard.new()

$testCard.version:="3.0"
$testCard.uid:=$TEST_VALUE_UID
$testCard.lastName:="Doe"
$testCard.middleName:="D"
$testCard.firstName:="John"
$testCard.nameSuffix:="JR"
$testCard.namePrefix:="MR"
$testCard.nickname:="Test User"
$testCard.gender:="M"
$testCard.organization:="ACME Corporation"
$testCard.photo.attachFromUrl("https://testurl"; "png")
$testCard.logo.attachFromUrl("https://testurl"; "png")
$testCard.workPhone:="312-555-1212"
$testCard.homePhone:="312-555-1313"
$testCard.cellPhone:="12345678900"
$testCard.pagerPhone:="312-555-1515"
$testCard.homeFax:="312-555-1616"
$testCard.workFax:="312-555-1717"
$testCard.birthday:=Date:C102("2018-12-01T00:00:00.0000")
$testCard.anniversary:=Date:C102("2018-12-01T00:00:00.0000")
$testCard.title:="Crash Test Dummy"
$testCard.role:="Crash Testing"
$testCard.email:="john.doe@testmail"
$testCard.workEmail:="john.doe@workmail"
$testCard.url:="http://johndoe"
$testCard.workUrl:="http://acemecompany/johndoe"

$testCard.homeAddress.label:="Home Address"
$testCard.homeAddress.street:="123 Main Street"
$testCard.homeAddress.city:="Chicago"
$testCard.homeAddress.stateProvince:="IL"
$testCard.homeAddress.postalCode:="12345"
$testCard.homeAddress.countryRegion:="United States of America"

$testCard.workAddress.label:="Work Address"
$testCard.workAddress.street:="123 Corporate Loop\nSuite 500"
$testCard.workAddress.city:="Los Angeles"
$testCard.workAddress.stateProvince:="CA"
$testCard.workAddress.postalCode:="54321"
$testCard.workAddress.countryRegion:="California Republic"

$testCard.source:="http://sourceurl"
$testCard.note:="John Doe's \nnotes;,"

$testCard.socialUrls.facebook:="https://facebook/johndoe"
$testCard.socialUrls.linkedIn:="https://linkedin/johndoe"
$testCard.socialUrls.twitter:="https://twitter/johndoe"
$testCard.socialUrls.flickr:="https://flickr/johndoe"
$testCard.socialUrls.custom:="https://custom/johndoe"

var $vCardString : Text
$vCardString:=$testCard.getText()

var $lines : Collection
$lines:=Split string:C1554($vCardString; "\r\n")

var _ : Object
_:=spec
While (_.describe(".getText"))
	
	While (_.it("should start with BEGIN:VCARD"))
		
		_.expect($lines.length).to(_.beGreaterThan(0))
		If ($lines.length>0)
			_.expect($lines[0]).to(_.beginWith("BEGIN:VCARD"))
		End if 
	End while 
	
	While (_.it("should be well-formed"))
		
		var $line : Text
		var $segments : Collection
		For each ($line; $lines)
			If (Length:C16($line)>0)
				$segments:=Split string:C1554($line; ":")
				
				_.expect(($segments.length>=2) | (Position:C15(";"; $segments[0])=1)).to(_.beTrue())
				
			End if 
		End for each 
		
	End while 
	
	While (_.it("should encode [\\n,',;] properly (3.0+)"))
		
		For each ($line; $lines)
			If (Position:C15("NOTE"; $line)=1)
				// assert($line.indexOf('\\n') !== -1 && $line.indexOf('\\') !== -1 && $line.indexOf('\\;') !== -1);
			End if 
		End for each 
	End while 
	
	While (_.it("should encode numeric input as strings"))
		$testCard.workAddress.postalCode:=12345
		_.expect($testCard.getText()).to(_.contain("12345"))  // must not raised? // TODO better catching
	End while 
	
	While (_.it("should format birthday as 20181201"))
		_.expect(_getValueByFieldName("BDAY"; $lines)).to(_.beEqualTo("20181201"))
	End while 
	
	While (_.it("should format anniversary as 20181201"))
		_.expect(_getValueByFieldName("ANNIVERSARY"; $lines)).to(_.beEqualTo("20181201"))
	End while 
	
	While (_.it("should not crash when cellPhone is a large number, using 12345678900"))
		$testCard.cellPhone:=12345678900
		$testCard.getText()  // must not raised? // TODO better catching
	End while 
	
	While (_.it("should have UID set as test value: "+$TEST_VALUE_UID))
		_.expect(_getValueByFieldName("UID"; $lines)).to(_.beEqualTo($TEST_VALUE_UID))
	End while 
	
	While (_.it("should end with END:VCARD"))
		_.expect($lines.length).to(_.beGreaterThan(2))
		If ($lines.length>2)
			_.expect($lines[$lines.length-2]).to(_.beEqualTo("END:VCARD"))
		End if 
	End while 
	
End while 


While (_.describe(".save and parse"))
	
	var $testFile; $testFileTmp : Object
	$testFile:=Folder:C1567(fk resources folder:K87:11).file("test/testCard.vcf")
	$testFileTmp:=Folder:C1567(Temporary folder:C486; fk platform path:K87:2).file("testCard.vcf")
	
	While (_.it("should save to file"))
		If ($testFileTmp.exists)
			$testFileTmp.delete()
		End if 
		$testCard.saveToFile($testFileTmp)
		
		ASSERT:C1129($testFileTmp.exists)
		//ASSERT($testFileTmp.getText()=$testFile.getText()) // could not test without removing line REV:
		
		If (Shift down:C543)
			// to test
			If (Windows Ctrl down:C562)
				// to import it
				OPEN URL:C673($testFileTmp.platformPath)
			Else 
				// to reveal it
				SHOW ON DISK:C922($testFileTmp.platformPath)
			End if 
		Else 
			// clean
			$testFileTmp.delete()
		End if 
	End while 
	
	While (_.it("should parse to the file"))
		
		$testCard:=PIM.VCard.new()
		$testCard._parseFile($testFile)
		
	End while 
	
End while 
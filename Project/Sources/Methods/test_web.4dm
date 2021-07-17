//%attributes = {"invisible":true,"preemptive":"capable"}
var $testCard : Object
$testCard:=PIM.VCard.new()

$testCard.version:="3.0"
$testCard.lastName:="Doe"
$testCard.firstName:="John"
$testCard.nameSuffix:="JR"
$testCard.namePrefix:="MR"
$testCard.nickname:="Test User"
$testCard.gender:="M"
$testCard.organization:="ACME Corporation"
$testCard.photo.attachFromUrl("https://testurl"; "png")
$testCard.logo.attachFromUrl("https://testurl"; "png")
$testCard.workPhone:="312-555-1212"
$testCard.homePhone:="0644555"
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

$testCard.webSend("eric.vcf")
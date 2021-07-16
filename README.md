# PIM

VCard builder class

```4d
// create a new vCard
$vCard = PIM.VCard.new()

// set properties
$vCard.firstName := "Eric"
$vCard.middleName := ""
$vCard.lastName := "Marchand"
$vCard.organization := "4D"
$vCard.photo.attachFromUrl("https://avatars.githubusercontent.com/u/59135882?v=4"; "JPEG")
$vCard.workPhone := "312-555-1212"
$vCard.title := "Software Developer"
$vCard.url := "https://github.com/mesopelagique"
$vCard.note := "Notes on Eric"

// save to file
$vCard.saveToFile(Folder(...).file("eric-marchand.vcf"))

// get as formatted string
$vCard.getFormattedString()
```

### Multiple Email, Fax, & Phone Examples

```4d
// multiple email entry
$vCard.email := New collection(\
    "e.marchand@emailhost.tld";\
    "e.marchand@emailhost2.tld";\
    "e.marchand@emailhost3.tld"\
)

// multiple cellphone
$vCard.cellPhone := New collection(\
    "312-555-1414";\
    "312-555-1415";\
    "312-555-1416"\
)
```

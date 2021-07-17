# PIM

personal information manager stuff

## VCard

VCard builder class

### Create

```4d
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
```

### save to file

```4d
$vCard.saveToFile(Folder(...).file("eric-marchand.vcf"))
```

### get as formatted string

```4d
$vCard.getFormattedString()
```

### send it when responding to http request

```4d
$vCard.webSend("eric-marchand.vcf")
```

### Embedding Images

Instead of using url you could embedded images

#### With files

```4d
$vCard.photo.embedFromFile(File("/path/to/file.png"))
$vCard.logo.embedFromFile(File("/path/to/file.png"))
```

#### With base 64 data

```4d
$vCard.photo.embedFromString("iVBORw0KGgoAAAANSUhEUgAAA2..."; "image/png"')
$vCard.logo.embedFromString("iVBORw0KGgoAAAANSUhEUgAAA2..."; "image/png")
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

## VCalendar(🚧)

VCalendar builder class 

### Create

```4d
$calendar = PIM.VCalendar.new()
```

### Add events

TODO

### get as formatted string

```4d
$calendar.getFormattedString()
```

### send it when responding to http request

```4d
$calendar.webSend("eric-marchand.ics")
```

## TODO

- Fix format VCard bugs, seems to not import well with macOS calendar app
- Implement calendar event formatting

## Acknowledgements

- vcard: very inspired from js library https://github.com/enesser/vCards-js

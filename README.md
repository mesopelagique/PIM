# PIM

[![language][code-shield]][code-url]
[![language-top][code-top]][code-url]
![code-size][code-size]
[![license][license-shield]][license-url]
[![discord][discord-shield]][discord-url]
[![sponsors][sponsors-shield]][sponsors-url]

personal information manager stuff, ie. VCard and VCalendar

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

### get as formatted text

```4d
$text:=$vCard.getText()
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

### get as formatted text

```4d
$text:=$calendar.getText()
```

### send it when responding to http request

```4d
$calendar.webSend("eric-marchand.ics")
```

## TODO

- [ ] Fix format VCard bugs, seems to not import well with macOS calendar app
- [ ] Implement calendar event formatting
- [ ] Parse VCard (partially implemented in `_parse` or `_parseFile` but not enough file tested)
- [ ] Parse VCalendar

## To help

If you run a business and you’re using one of my projects in a revenue-generating product, it makes business sense to sponsor this open source development

[![sponsors][sponsors-shield]][sponsors-url]

Thank you for your support!

## Other components

[<img src="https://mesopelagique.github.io/quatred.png" alt="mesopelagique"/>](https://mesopelagique.github.io/)

## Acknowledgements

- vcard: very inspired from js library https://github.com/enesser/vCards-js

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[code-shield]: https://img.shields.io/static/v1?label=language&message=4d&color=blue
[code-top]: https://img.shields.io/github/languages/top/mesopelagique/PIM.svg
[code-size]: https://img.shields.io/github/languages/code-size/mesopelagique/PIM.svg
[code-url]: https://developer.4d.com/
[license-shield]: https://img.shields.io/github/license/mesopelagique/PIM
[license-url]: LICENSE.md
[discord-shield]: https://img.shields.io/badge/chat-discord-7289DA?logo=discord&style=flat
[discord-url]: https://discord.gg/dVTqZHr
[sponsors-shield]: https://img.shields.io/github/sponsors/phimage?color=violet&logo=github
[sponsors-url]: https://github.com/sponsors/phimage

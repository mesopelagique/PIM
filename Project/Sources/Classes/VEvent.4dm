Class extends PIMObject

Class constructor
	
Function getFormattedString()->$formattedString : Text
	
	var $nl : Text
	$nl:=This:C1470.nl()
	$formattedString:="BEGIN:VEVENT"+$nl
	
	//DTSTART:19970714T170000Z
	//DTEND:19970715T035900Z
	//SUMMARY:Fête à la Bastille
	
	//LOCATION : Lieu de l'événement
	//CATEGORIES : Catégorie de l'événement(ex: Conférence, Fête...)
	//STATUS : Statut de l'événement(TENTATIVE, CONFIRMED, CANCELLED)
	//DESCRIPTION : Description de l'événement
	//TRANSP : Définit si la ressource affectée à l'événement est rendu indisponible(OPAQUE, TRANSPARENT)
	//SEQUENCE : Nombre de mises à jour, la première mise à jour est à 1
	
	$formattedString:=$formattedString+"END:VEVENT"+$nl
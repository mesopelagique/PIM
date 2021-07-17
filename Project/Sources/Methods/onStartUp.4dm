//%attributes = {"invisible":true}

// Compile dependencies (could be commented if not compile project method)
If (Structure file:C489(*)=Structure file:C489())
	
	var $file : 4D:C1709.File
	var $componentFolder : 4D:C1709.Folder
	var $dependency : Text
	var $status : Object
	For each ($dependency; JSON Parse:C1218(Folder:C1567(fk database folder:K87:14).file("component.json").getText()).dependencies)
		
		$dependency:=Substring:C12($dependency; Position:C15("/"; $dependency)+1)
		
		$componentFolder:=Folder:C1567(fk database folder:K87:14).folder("Components").folder($dependency)
		If (Not:C34($componentFolder.exists))
			$componentFolder:=Folder:C1567(fk database folder:K87:14).folder("Components").folder($dependency+".4dbase")
		End if 
		
		$file:=$componentFolder.file("Project/"+$dependency+".4DProject")
		If ($file.exists)
			$status:=Compile project:C1760($file)
			
		End if 
		
	End for each 
End if 
Global Const $GUI_EVENT_CLOSE = + 4294967293
Global Const $GUI_CHECKED = 1
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
Global Const $WS_BORDER = 8388608
Global Const $WS_EX_DLGMODALFRAME = 1
Global Const $UBOUND_DIMENSIONS = 0
Global Const $UBOUND_ROWS = 1
Global Const $UBOUND_COLUMNS = 2
Global Const $NUMBER_DOUBLE = 3
Global Const $STR_NOCASESENSEBASIC = 2
Global Const $STR_STRIPLEADING = 1
Global Const $STR_STRIPTRAILING = 2
Func _ARRAYCONCATENATE ( ByRef $AARRAYTARGET , Const ByRef $AARRAYSOURCE , $ISTART = 0 )
	If $ISTART = Default Then $ISTART = 0
	If Not IsArray ( $AARRAYTARGET ) Then Return SetError ( 1 , 0 , + 4294967295 )
	If Not IsArray ( $AARRAYSOURCE ) Then Return SetError ( 2 , 0 , + 4294967295 )
	Local $IDIM_TOTAL_TGT = UBound ( $AARRAYTARGET , $UBOUND_DIMENSIONS )
	Local $IDIM_TOTAL_SRC = UBound ( $AARRAYSOURCE , $UBOUND_DIMENSIONS )
	Local $IDIM_1_TGT = UBound ( $AARRAYTARGET , $UBOUND_ROWS )
	Local $IDIM_1_SRC = UBound ( $AARRAYSOURCE , $UBOUND_ROWS )
	If $ISTART < 0 Or $ISTART > $IDIM_1_SRC + 4294967295 Then Return SetError ( 6 , 0 , + 4294967295 )
	Switch $IDIM_TOTAL_TGT
	Case 1
		If $IDIM_TOTAL_SRC <> 1 Then Return SetError ( 4 , 0 , + 4294967295 )
		ReDim $AARRAYTARGET [ $IDIM_1_TGT + $IDIM_1_SRC - $ISTART ]
		For $I = $ISTART To $IDIM_1_SRC + 4294967295
			$AARRAYTARGET [ $IDIM_1_TGT + $I - $ISTART ] = $AARRAYSOURCE [ $I ]
		Next
	Case 2
		If $IDIM_TOTAL_SRC <> 2 Then Return SetError ( 4 , 0 , + 4294967295 )
		Local $IDIM_2_TGT = UBound ( $AARRAYTARGET , $UBOUND_COLUMNS )
		If UBound ( $AARRAYSOURCE , $UBOUND_COLUMNS ) <> $IDIM_2_TGT Then Return SetError ( 5 , 0 , + 4294967295 )
		ReDim $AARRAYTARGET [ $IDIM_1_TGT + $IDIM_1_SRC - $ISTART ] [ $IDIM_2_TGT ]
		For $I = $ISTART To $IDIM_1_SRC + 4294967295
			For $J = 0 To $IDIM_2_TGT + 4294967295
				$AARRAYTARGET [ $IDIM_1_TGT + $I - $ISTART ] [ $J ] = $AARRAYSOURCE [ $I ] [ $J ]
			Next
		Next
Case Else
		Return SetError ( 3 , 0 , + 4294967295 )
	EndSwitch
	Return UBound ( $AARRAYTARGET , $UBOUND_ROWS )
EndFunc
Func __ARRAYDUALPIVOTSORT ( ByRef $AARRAY , $IPIVOT_LEFT , $IPIVOT_RIGHT , $BLEFTMOST = True )
	If $IPIVOT_LEFT > $IPIVOT_RIGHT Then Return
	Local $ILENGTH = $IPIVOT_RIGHT - $IPIVOT_LEFT + 1
	Local $I , $J , $K , $IAI , $IAK , $IA1 , $IA2 , $ILAST
	If $ILENGTH < 45 Then
		If $BLEFTMOST Then
			$I = $IPIVOT_LEFT
			While $I < $IPIVOT_RIGHT
				$J = $I
				$IAI = $AARRAY [ $I + 1 ]
				While $IAI < $AARRAY [ $J ]
					$AARRAY [ $J + 1 ] = $AARRAY [ $J ]
					$J -= 1
					If $J + 1 = $IPIVOT_LEFT Then ExitLoop
				WEnd
				$AARRAY [ $J + 1 ] = $IAI
				$I += 1
			WEnd
		Else
			While 1
				If $IPIVOT_LEFT >= $IPIVOT_RIGHT Then Return 1
				$IPIVOT_LEFT += 1
				If $AARRAY [ $IPIVOT_LEFT ] < $AARRAY [ $IPIVOT_LEFT + 4294967295 ] Then ExitLoop
			WEnd
			While 1
				$K = $IPIVOT_LEFT
				$IPIVOT_LEFT += 1
				If $IPIVOT_LEFT > $IPIVOT_RIGHT Then ExitLoop
				$IA1 = $AARRAY [ $K ]
				$IA2 = $AARRAY [ $IPIVOT_LEFT ]
				If $IA1 < $IA2 Then
					$IA2 = $IA1
					$IA1 = $AARRAY [ $IPIVOT_LEFT ]
				EndIf
				$K -= 1
				While $IA1 < $AARRAY [ $K ]
					$AARRAY [ $K + 2 ] = $AARRAY [ $K ]
					$K -= 1
				WEnd
				$AARRAY [ $K + 2 ] = $IA1
				While $IA2 < $AARRAY [ $K ]
					$AARRAY [ $K + 1 ] = $AARRAY [ $K ]
					$K -= 1
				WEnd
				$AARRAY [ $K + 1 ] = $IA2
				$IPIVOT_LEFT += 1
			WEnd
			$ILAST = $AARRAY [ $IPIVOT_RIGHT ]
			$IPIVOT_RIGHT -= 1
			While $ILAST < $AARRAY [ $IPIVOT_RIGHT ]
				$AARRAY [ $IPIVOT_RIGHT + 1 ] = $AARRAY [ $IPIVOT_RIGHT ]
				$IPIVOT_RIGHT -= 1
			WEnd
			$AARRAY [ $IPIVOT_RIGHT + 1 ] = $ILAST
		EndIf
		Return 1
	EndIf
	Local $ISEVENTH = BitShift ( $ILENGTH , 3 ) + BitShift ( $ILENGTH , 6 ) + 1
	Local $IE1 , $IE2 , $IE3 , $IE4 , $IE5 , $T
	$IE3 = Ceiling ( ( $IPIVOT_LEFT + $IPIVOT_RIGHT ) / 2 )
	$IE2 = $IE3 - $ISEVENTH
	$IE1 = $IE2 - $ISEVENTH
	$IE4 = $IE3 + $ISEVENTH
	$IE5 = $IE4 + $ISEVENTH
	If $AARRAY [ $IE2 ] < $AARRAY [ $IE1 ] Then
		$T = $AARRAY [ $IE2 ]
		$AARRAY [ $IE2 ] = $AARRAY [ $IE1 ]
		$AARRAY [ $IE1 ] = $T
	EndIf
	If $AARRAY [ $IE3 ] < $AARRAY [ $IE2 ] Then
		$T = $AARRAY [ $IE3 ]
		$AARRAY [ $IE3 ] = $AARRAY [ $IE2 ]
		$AARRAY [ $IE2 ] = $T
		If $T < $AARRAY [ $IE1 ] Then
			$AARRAY [ $IE2 ] = $AARRAY [ $IE1 ]
			$AARRAY [ $IE1 ] = $T
		EndIf
	EndIf
	If $AARRAY [ $IE4 ] < $AARRAY [ $IE3 ] Then
		$T = $AARRAY [ $IE4 ]
		$AARRAY [ $IE4 ] = $AARRAY [ $IE3 ]
		$AARRAY [ $IE3 ] = $T
		If $T < $AARRAY [ $IE2 ] Then
			$AARRAY [ $IE3 ] = $AARRAY [ $IE2 ]
			$AARRAY [ $IE2 ] = $T
			If $T < $AARRAY [ $IE1 ] Then
				$AARRAY [ $IE2 ] = $AARRAY [ $IE1 ]
				$AARRAY [ $IE1 ] = $T
			EndIf
		EndIf
	EndIf
	If $AARRAY [ $IE5 ] < $AARRAY [ $IE4 ] Then
		$T = $AARRAY [ $IE5 ]
		$AARRAY [ $IE5 ] = $AARRAY [ $IE4 ]
		$AARRAY [ $IE4 ] = $T
		If $T < $AARRAY [ $IE3 ] Then
			$AARRAY [ $IE4 ] = $AARRAY [ $IE3 ]
			$AARRAY [ $IE3 ] = $T
			If $T < $AARRAY [ $IE2 ] Then
				$AARRAY [ $IE3 ] = $AARRAY [ $IE2 ]
				$AARRAY [ $IE2 ] = $T
				If $T < $AARRAY [ $IE1 ] Then
					$AARRAY [ $IE2 ] = $AARRAY [ $IE1 ]
					$AARRAY [ $IE1 ] = $T
				EndIf
			EndIf
		EndIf
	EndIf
	Local $ILESS = $IPIVOT_LEFT
	Local $IGREATER = $IPIVOT_RIGHT
	If ( ( $AARRAY [ $IE1 ] <> $AARRAY [ $IE2 ] ) And ( $AARRAY [ $IE2 ] <> $AARRAY [ $IE3 ] ) And ( $AARRAY [ $IE3 ] <> $AARRAY [ $IE4 ] ) And ( $AARRAY [ $IE4 ] <> $AARRAY [ $IE5 ] ) ) Then
		Local $IPIVOT_1 = $AARRAY [ $IE2 ]
		Local $IPIVOT_2 = $AARRAY [ $IE4 ]
		$AARRAY [ $IE2 ] = $AARRAY [ $IPIVOT_LEFT ]
		$AARRAY [ $IE4 ] = $AARRAY [ $IPIVOT_RIGHT ]
		Do
			$ILESS += 1
		Until $AARRAY [ $ILESS ] >= $IPIVOT_1
		Do
			$IGREATER -= 1
		Until $AARRAY [ $IGREATER ] <= $IPIVOT_2
		$K = $ILESS
		While $K <= $IGREATER
			$IAK = $AARRAY [ $K ]
			If $IAK < $IPIVOT_1 Then
				$AARRAY [ $K ] = $AARRAY [ $ILESS ]
				$AARRAY [ $ILESS ] = $IAK
				$ILESS += 1
			ElseIf $IAK > $IPIVOT_2 Then
				While $AARRAY [ $IGREATER ] > $IPIVOT_2
					$IGREATER -= 1
					If $IGREATER + 1 = $K Then ExitLoop 2
				WEnd
				If $AARRAY [ $IGREATER ] < $IPIVOT_1 Then
					$AARRAY [ $K ] = $AARRAY [ $ILESS ]
					$AARRAY [ $ILESS ] = $AARRAY [ $IGREATER ]
					$ILESS += 1
				Else
					$AARRAY [ $K ] = $AARRAY [ $IGREATER ]
				EndIf
				$AARRAY [ $IGREATER ] = $IAK
				$IGREATER -= 1
			EndIf
			$K += 1
		WEnd
		$AARRAY [ $IPIVOT_LEFT ] = $AARRAY [ $ILESS + 4294967295 ]
		$AARRAY [ $ILESS + 4294967295 ] = $IPIVOT_1
		$AARRAY [ $IPIVOT_RIGHT ] = $AARRAY [ $IGREATER + 1 ]
		$AARRAY [ $IGREATER + 1 ] = $IPIVOT_2
		__ARRAYDUALPIVOTSORT ( $AARRAY , $IPIVOT_LEFT , $ILESS + 4294967294 , True )
		__ARRAYDUALPIVOTSORT ( $AARRAY , $IGREATER + 2 , $IPIVOT_RIGHT , False )
		If ( $ILESS < $IE1 ) And ( $IE5 < $IGREATER ) Then
			While $AARRAY [ $ILESS ] = $IPIVOT_1
				$ILESS += 1
			WEnd
			While $AARRAY [ $IGREATER ] = $IPIVOT_2
				$IGREATER -= 1
			WEnd
			$K = $ILESS
			While $K <= $IGREATER
				$IAK = $AARRAY [ $K ]
				If $IAK = $IPIVOT_1 Then
					$AARRAY [ $K ] = $AARRAY [ $ILESS ]
					$AARRAY [ $ILESS ] = $IAK
					$ILESS += 1
				ElseIf $IAK = $IPIVOT_2 Then
					While $AARRAY [ $IGREATER ] = $IPIVOT_2
						$IGREATER -= 1
						If $IGREATER + 1 = $K Then ExitLoop 2
					WEnd
					If $AARRAY [ $IGREATER ] = $IPIVOT_1 Then
						$AARRAY [ $K ] = $AARRAY [ $ILESS ]
						$AARRAY [ $ILESS ] = $IPIVOT_1
						$ILESS += 1
					Else
						$AARRAY [ $K ] = $AARRAY [ $IGREATER ]
					EndIf
					$AARRAY [ $IGREATER ] = $IAK
					$IGREATER -= 1
				EndIf
				$K += 1
			WEnd
		EndIf
		__ARRAYDUALPIVOTSORT ( $AARRAY , $ILESS , $IGREATER , False )
	Else
		Local $IPIVOT = $AARRAY [ $IE3 ]
		$K = $ILESS
		While $K <= $IGREATER
			If $AARRAY [ $K ] = $IPIVOT Then
				$K += 1
				ContinueLoop
			EndIf
			$IAK = $AARRAY [ $K ]
			If $IAK < $IPIVOT Then
				$AARRAY [ $K ] = $AARRAY [ $ILESS ]
				$AARRAY [ $ILESS ] = $IAK
				$ILESS += 1
			Else
				While $AARRAY [ $IGREATER ] > $IPIVOT
					$IGREATER -= 1
				WEnd
				If $AARRAY [ $IGREATER ] < $IPIVOT Then
					$AARRAY [ $K ] = $AARRAY [ $ILESS ]
					$AARRAY [ $ILESS ] = $AARRAY [ $IGREATER ]
					$ILESS += 1
				Else
					$AARRAY [ $K ] = $IPIVOT
				EndIf
				$AARRAY [ $IGREATER ] = $IAK
				$IGREATER -= 1
			EndIf
			$K += 1
		WEnd
		__ARRAYDUALPIVOTSORT ( $AARRAY , $IPIVOT_LEFT , $ILESS + 4294967295 , True )
		__ARRAYDUALPIVOTSORT ( $AARRAY , $IGREATER + 1 , $IPIVOT_RIGHT , False )
	EndIf
EndFunc
Global Const $FO_OVERWRITE = 2
Global Const $FLTAR_FILESFOLDERS = 0
Global Const $FLTAR_NOHIDDEN = 4
Global Const $FLTAR_NOSYSTEM = 8
Global Const $FLTAR_NOLINK = 16
Global Const $FLTAR_NORECUR = 0
Global Const $FLTAR_NOSORT = 0
Global Const $FLTAR_RELPATH = 1
Func _FILELISTTOARRAYREC ( $SFILEPATH , $SMASK = "*" , $IRETURN = $FLTAR_FILESFOLDERS , $IRECUR = $FLTAR_NORECUR , $ISORT = $FLTAR_NOSORT , $IRETURNPATH = $FLTAR_RELPATH )
	If Not FileExists ( $SFILEPATH ) Then Return SetError ( 1 , 1 , "" )
	If $SMASK = Default Then $SMASK = "*"
	If $IRETURN = Default Then $IRETURN = $FLTAR_FILESFOLDERS
	If $IRECUR = Default Then $IRECUR = $FLTAR_NORECUR
	If $ISORT = Default Then $ISORT = $FLTAR_NOSORT
	If $IRETURNPATH = Default Then $IRETURNPATH = $FLTAR_RELPATH
	If $IRECUR > 1 Or Not IsInt ( $IRECUR ) Then Return SetError ( 1 , 6 , "" )
	Local $BLONGPATH = False
	If StringLeft ( $SFILEPATH , 4 ) == "\\?\" Then
		$BLONGPATH = True
	EndIf
	Local $SFOLDERSLASH = ""
	If StringRight ( $SFILEPATH , 1 ) = "\" Then
		$SFOLDERSLASH = "\"
	Else
		$SFILEPATH = $SFILEPATH & "\"
	EndIf
	Local $ASFOLDERSEARCHLIST [ 100 ] = [ 1 ]
	$ASFOLDERSEARCHLIST [ 1 ] = $SFILEPATH
	Local $IHIDE_HS = 0 , $SHIDE_HS = ""
	If BitAND ( $IRETURN , $FLTAR_NOHIDDEN ) Then
		$IHIDE_HS += 2
		$SHIDE_HS &= "H"
		$IRETURN -= $FLTAR_NOHIDDEN
	EndIf
	If BitAND ( $IRETURN , $FLTAR_NOSYSTEM ) Then
		$IHIDE_HS += 4
		$SHIDE_HS &= "S"
		$IRETURN -= $FLTAR_NOSYSTEM
	EndIf
	Local $IHIDE_LINK = 0
	If BitAND ( $IRETURN , $FLTAR_NOLINK ) Then
		$IHIDE_LINK = 1024
		$IRETURN -= $FLTAR_NOLINK
	EndIf
	Local $IMAXLEVEL = 0
	If $IRECUR < 0 Then
		StringReplace ( $SFILEPATH , "\" , "" , 0 , $STR_NOCASESENSEBASIC )
		$IMAXLEVEL = @extended - $IRECUR
	EndIf
	Local $SEXCLUDE_LIST = "" , $SEXCLUDE_LIST_FOLDER = "" , $SINCLUDE_LIST = "*"
	Local $AMASKSPLIT = StringSplit ( $SMASK , "|" )
	Switch $AMASKSPLIT [ 0 ]
	Case 3
		$SEXCLUDE_LIST_FOLDER = $AMASKSPLIT [ 3 ]
		ContinueCase
	Case 2
		$SEXCLUDE_LIST = $AMASKSPLIT [ 2 ]
		ContinueCase
	Case 1
		$SINCLUDE_LIST = $AMASKSPLIT [ 1 ]
	EndSwitch
	Local $SINCLUDE_FILE_MASK = ".+"
	If $SINCLUDE_LIST <> "*" Then
		If Not __FLTAR_LISTTOMASK ( $SINCLUDE_FILE_MASK , $SINCLUDE_LIST ) Then Return SetError ( 1 , 2 , "" )
	EndIf
	Local $SINCLUDE_FOLDER_MASK = ".+"
	Switch $IRETURN
	Case 0
		Switch $IRECUR
		Case 0
			$SINCLUDE_FOLDER_MASK = $SINCLUDE_FILE_MASK
		EndSwitch
	Case 2
		$SINCLUDE_FOLDER_MASK = $SINCLUDE_FILE_MASK
	EndSwitch
	Local $SEXCLUDE_FILE_MASK = ":"
	If $SEXCLUDE_LIST <> "" Then
		If Not __FLTAR_LISTTOMASK ( $SEXCLUDE_FILE_MASK , $SEXCLUDE_LIST ) Then Return SetError ( 1 , 3 , "" )
	EndIf
	Local $SEXCLUDE_FOLDER_MASK = ":"
	If $IRECUR Then
		If $SEXCLUDE_LIST_FOLDER Then
			If Not __FLTAR_LISTTOMASK ( $SEXCLUDE_FOLDER_MASK , $SEXCLUDE_LIST_FOLDER ) Then Return SetError ( 1 , 4 , "" )
		EndIf
		If $IRETURN = 2 Then
			$SEXCLUDE_FOLDER_MASK = $SEXCLUDE_FILE_MASK
		EndIf
	Else
		$SEXCLUDE_FOLDER_MASK = $SEXCLUDE_FILE_MASK
	EndIf
	If Not ( $IRETURN = 0 Or $IRETURN = 1 Or $IRETURN = 2 ) Then Return SetError ( 1 , 5 , "" )
	If Not ( $ISORT = 0 Or $ISORT = 1 Or $ISORT = 2 ) Then Return SetError ( 1 , 7 , "" )
	If Not ( $IRETURNPATH = 0 Or $IRETURNPATH = 1 Or $IRETURNPATH = 2 ) Then Return SetError ( 1 , 8 , "" )
	If $IHIDE_LINK Then
		Local $TFILE_DATA = DllStructCreate ( "struct;align 4;dword FileAttributes;uint64 CreationTime;uint64 LastAccessTime;uint64 LastWriteTime;" & "dword FileSizeHigh;dword FileSizeLow;dword Reserved0;dword Reserved1;wchar FileName[260];wchar AlternateFileName[14];endstruct" )
		Local $HDLL = DllOpen ( "kernel32.dll" ) , $ADLL_RET
	EndIf
	Local $ASRETURNLIST [ 100 ] = [ 0 ]
	Local $ASFILEMATCHLIST = $ASRETURNLIST , $ASROOTFILEMATCHLIST = $ASRETURNLIST , $ASFOLDERMATCHLIST = $ASRETURNLIST
	Local $BFOLDER = False , $HSEARCH = 0 , $SCURRENTPATH = "" , $SNAME = "" , $SRETPATH = ""
	Local $IATTRIBS = 0 , $SATTRIBS = ""
	Local $ASFOLDERFILESECTIONLIST [ 100 ] [ 2 ] = [ [ 0 , 0 ] ]
	While $ASFOLDERSEARCHLIST [ 0 ] > 0
		$SCURRENTPATH = $ASFOLDERSEARCHLIST [ $ASFOLDERSEARCHLIST [ 0 ] ]
		$ASFOLDERSEARCHLIST [ 0 ] -= 1
		Switch $IRETURNPATH
		Case 1
			$SRETPATH = StringReplace ( $SCURRENTPATH , $SFILEPATH , "" )
		Case 2
			If $BLONGPATH Then
				$SRETPATH = StringTrimLeft ( $SCURRENTPATH , 4 )
			Else
				$SRETPATH = $SCURRENTPATH
			EndIf
		EndSwitch
		If $IHIDE_LINK Then
			$ADLL_RET = DllCall ( $HDLL , "handle" , "FindFirstFileW" , "wstr" , $SCURRENTPATH & "*" , "struct*" , $TFILE_DATA )
			If @error Or Not $ADLL_RET [ 0 ] Then
				ContinueLoop
			EndIf
			$HSEARCH = $ADLL_RET [ 0 ]
		Else
			$HSEARCH = FileFindFirstFile ( $SCURRENTPATH & "*" )
			If $HSEARCH = + 4294967295 Then
				ContinueLoop
			EndIf
		EndIf
		If $IRETURN = 0 And $ISORT And $IRETURNPATH Then
			__FLTAR_ADDTOLIST ( $ASFOLDERFILESECTIONLIST , $SRETPATH , $ASFILEMATCHLIST [ 0 ] + 1 )
		EndIf
		$SATTRIBS = ""
		While 1
			If $IHIDE_LINK Then
				$ADLL_RET = DllCall ( $HDLL , "int" , "FindNextFileW" , "handle" , $HSEARCH , "struct*" , $TFILE_DATA )
				If @error Or Not $ADLL_RET [ 0 ] Then
					ExitLoop
				EndIf
				$SNAME = DllStructGetData ( $TFILE_DATA , "FileName" )
				If $SNAME = ".." Or $SNAME = "." Then
					ContinueLoop
				EndIf
				$IATTRIBS = DllStructGetData ( $TFILE_DATA , "FileAttributes" )
				If $IHIDE_HS And BitAND ( $IATTRIBS , $IHIDE_HS ) Then
					ContinueLoop
				EndIf
				If BitAND ( $IATTRIBS , $IHIDE_LINK ) Then
					ContinueLoop
				EndIf
				$BFOLDER = False
				If BitAND ( $IATTRIBS , 16 ) Then
					$BFOLDER = True
				EndIf
			Else
				$BFOLDER = False
				$SNAME = FileFindNextFile ( $HSEARCH , 1 )
				If @error Then
					ExitLoop
				EndIf
				If $SNAME = ".." Or $SNAME = "." Then
					ContinueLoop
				EndIf
				$SATTRIBS = @extended
				If StringInStr ( $SATTRIBS , "D" ) Then
					$BFOLDER = True
				EndIf
				If StringRegExp ( $SATTRIBS , "[" & $SHIDE_HS & "]" ) Then
					ContinueLoop
				EndIf
			EndIf
			If $BFOLDER Then
				Select
				Case $IRECUR < 0
					StringReplace ( $SCURRENTPATH , "\" , "" , 0 , $STR_NOCASESENSEBASIC )
					If @extended < $IMAXLEVEL Then
						ContinueCase
					EndIf
				Case $IRECUR = 1
					If Not StringRegExp ( $SNAME , $SEXCLUDE_FOLDER_MASK ) Then
						__FLTAR_ADDTOLIST ( $ASFOLDERSEARCHLIST , $SCURRENTPATH & $SNAME & "\" )
					EndIf
				EndSelect
			EndIf
			If $ISORT Then
				If $BFOLDER Then
					If StringRegExp ( $SNAME , $SINCLUDE_FOLDER_MASK ) And Not StringRegExp ( $SNAME , $SEXCLUDE_FOLDER_MASK ) Then
						__FLTAR_ADDTOLIST ( $ASFOLDERMATCHLIST , $SRETPATH & $SNAME & $SFOLDERSLASH )
					EndIf
				Else
					If StringRegExp ( $SNAME , $SINCLUDE_FILE_MASK ) And Not StringRegExp ( $SNAME , $SEXCLUDE_FILE_MASK ) Then
						If $SCURRENTPATH = $SFILEPATH Then
							__FLTAR_ADDTOLIST ( $ASROOTFILEMATCHLIST , $SRETPATH & $SNAME )
						Else
							__FLTAR_ADDTOLIST ( $ASFILEMATCHLIST , $SRETPATH & $SNAME )
						EndIf
					EndIf
				EndIf
			Else
				If $BFOLDER Then
					If $IRETURN <> 1 And StringRegExp ( $SNAME , $SINCLUDE_FOLDER_MASK ) And Not StringRegExp ( $SNAME , $SEXCLUDE_FOLDER_MASK ) Then
						__FLTAR_ADDTOLIST ( $ASRETURNLIST , $SRETPATH & $SNAME & $SFOLDERSLASH )
					EndIf
				Else
					If $IRETURN <> 2 And StringRegExp ( $SNAME , $SINCLUDE_FILE_MASK ) And Not StringRegExp ( $SNAME , $SEXCLUDE_FILE_MASK ) Then
						__FLTAR_ADDTOLIST ( $ASRETURNLIST , $SRETPATH & $SNAME )
					EndIf
				EndIf
			EndIf
		WEnd
		If $IHIDE_LINK Then
			DllCall ( $HDLL , "int" , "FindClose" , "ptr" , $HSEARCH )
		Else
			FileClose ( $HSEARCH )
		EndIf
	WEnd
	If $IHIDE_LINK Then
		DllClose ( $HDLL )
	EndIf
	If $ISORT Then
		Switch $IRETURN
		Case 2
			If $ASFOLDERMATCHLIST [ 0 ] = 0 Then Return SetError ( 1 , 9 , "" )
			ReDim $ASFOLDERMATCHLIST [ $ASFOLDERMATCHLIST [ 0 ] + 1 ]
			$ASRETURNLIST = $ASFOLDERMATCHLIST
			__ARRAYDUALPIVOTSORT ( $ASRETURNLIST , 1 , $ASRETURNLIST [ 0 ] )
		Case 1
			If $ASROOTFILEMATCHLIST [ 0 ] = 0 And $ASFILEMATCHLIST [ 0 ] = 0 Then Return SetError ( 1 , 9 , "" )
			If $IRETURNPATH = 0 Then
				__FLTAR_ADDFILELISTS ( $ASRETURNLIST , $ASROOTFILEMATCHLIST , $ASFILEMATCHLIST )
				__ARRAYDUALPIVOTSORT ( $ASRETURNLIST , 1 , $ASRETURNLIST [ 0 ] )
			Else
				__FLTAR_ADDFILELISTS ( $ASRETURNLIST , $ASROOTFILEMATCHLIST , $ASFILEMATCHLIST , 1 )
			EndIf
		Case 0
			If $ASROOTFILEMATCHLIST [ 0 ] = 0 And $ASFOLDERMATCHLIST [ 0 ] = 0 Then Return SetError ( 1 , 9 , "" )
			If $IRETURNPATH = 0 Then
				__FLTAR_ADDFILELISTS ( $ASRETURNLIST , $ASROOTFILEMATCHLIST , $ASFILEMATCHLIST )
				$ASRETURNLIST [ 0 ] += $ASFOLDERMATCHLIST [ 0 ]
				ReDim $ASFOLDERMATCHLIST [ $ASFOLDERMATCHLIST [ 0 ] + 1 ]
				_ARRAYCONCATENATE ( $ASRETURNLIST , $ASFOLDERMATCHLIST , 1 )
				__ARRAYDUALPIVOTSORT ( $ASRETURNLIST , 1 , $ASRETURNLIST [ 0 ] )
			Else
				Local $ASRETURNLIST [ $ASFILEMATCHLIST [ 0 ] + $ASROOTFILEMATCHLIST [ 0 ] + $ASFOLDERMATCHLIST [ 0 ] + 1 ]
				$ASRETURNLIST [ 0 ] = $ASFILEMATCHLIST [ 0 ] + $ASROOTFILEMATCHLIST [ 0 ] + $ASFOLDERMATCHLIST [ 0 ]
				__ARRAYDUALPIVOTSORT ( $ASROOTFILEMATCHLIST , 1 , $ASROOTFILEMATCHLIST [ 0 ] )
				For $I = 1 To $ASROOTFILEMATCHLIST [ 0 ]
					$ASRETURNLIST [ $I ] = $ASROOTFILEMATCHLIST [ $I ]
				Next
				Local $INEXTINSERTIONINDEX = $ASROOTFILEMATCHLIST [ 0 ] + 1
				__ARRAYDUALPIVOTSORT ( $ASFOLDERMATCHLIST , 1 , $ASFOLDERMATCHLIST [ 0 ] )
				Local $SFOLDERTOFIND = ""
				For $I = 1 To $ASFOLDERMATCHLIST [ 0 ]
					$ASRETURNLIST [ $INEXTINSERTIONINDEX ] = $ASFOLDERMATCHLIST [ $I ]
					$INEXTINSERTIONINDEX += 1
					If $SFOLDERSLASH Then
						$SFOLDERTOFIND = $ASFOLDERMATCHLIST [ $I ]
					Else
						$SFOLDERTOFIND = $ASFOLDERMATCHLIST [ $I ] & "\"
					EndIf
					Local $IFILESECTIONENDINDEX = 0 , $IFILESECTIONSTARTINDEX = 0
					For $J = 1 To $ASFOLDERFILESECTIONLIST [ 0 ] [ 0 ]
						If $SFOLDERTOFIND = $ASFOLDERFILESECTIONLIST [ $J ] [ 0 ] Then
							$IFILESECTIONSTARTINDEX = $ASFOLDERFILESECTIONLIST [ $J ] [ 1 ]
							If $J = $ASFOLDERFILESECTIONLIST [ 0 ] [ 0 ] Then
								$IFILESECTIONENDINDEX = $ASFILEMATCHLIST [ 0 ]
							Else
								$IFILESECTIONENDINDEX = $ASFOLDERFILESECTIONLIST [ $J + 1 ] [ 1 ] + 4294967295
							EndIf
							If $ISORT = 1 Then
								__ARRAYDUALPIVOTSORT ( $ASFILEMATCHLIST , $IFILESECTIONSTARTINDEX , $IFILESECTIONENDINDEX )
							EndIf
							For $K = $IFILESECTIONSTARTINDEX To $IFILESECTIONENDINDEX
								$ASRETURNLIST [ $INEXTINSERTIONINDEX ] = $ASFILEMATCHLIST [ $K ]
								$INEXTINSERTIONINDEX += 1
							Next
							ExitLoop
						EndIf
					Next
				Next
			EndIf
		EndSwitch
	Else
		If $ASRETURNLIST [ 0 ] = 0 Then Return SetError ( 1 , 9 , "" )
		ReDim $ASRETURNLIST [ $ASRETURNLIST [ 0 ] + 1 ]
	EndIf
	Return $ASRETURNLIST
EndFunc
Func __FLTAR_ADDFILELISTS ( ByRef $ASTARGET , $ASSOURCE_1 , $ASSOURCE_2 , $ISORT = 0 )
	ReDim $ASSOURCE_1 [ $ASSOURCE_1 [ 0 ] + 1 ]
	If $ISORT = 1 Then __ARRAYDUALPIVOTSORT ( $ASSOURCE_1 , 1 , $ASSOURCE_1 [ 0 ] )
	$ASTARGET = $ASSOURCE_1
	$ASTARGET [ 0 ] += $ASSOURCE_2 [ 0 ]
	ReDim $ASSOURCE_2 [ $ASSOURCE_2 [ 0 ] + 1 ]
	If $ISORT = 1 Then __ARRAYDUALPIVOTSORT ( $ASSOURCE_2 , 1 , $ASSOURCE_2 [ 0 ] )
	_ARRAYCONCATENATE ( $ASTARGET , $ASSOURCE_2 , 1 )
EndFunc
Func __FLTAR_ADDTOLIST ( ByRef $ALIST , $VVALUE_0 , $VVALUE_1 = + 4294967295 )
	If $VVALUE_1 = + 4294967295 Then
		$ALIST [ 0 ] += 1
		If UBound ( $ALIST ) <= $ALIST [ 0 ] Then ReDim $ALIST [ UBound ( $ALIST ) * 2 ]
		$ALIST [ $ALIST [ 0 ] ] = $VVALUE_0
	Else
		$ALIST [ 0 ] [ 0 ] += 1
		If UBound ( $ALIST ) <= $ALIST [ 0 ] [ 0 ] Then ReDim $ALIST [ UBound ( $ALIST ) * 2 ] [ 2 ]
		$ALIST [ $ALIST [ 0 ] [ 0 ] ] [ 0 ] = $VVALUE_0
		$ALIST [ $ALIST [ 0 ] [ 0 ] ] [ 1 ] = $VVALUE_1
	EndIf
EndFunc
Func __FLTAR_LISTTOMASK ( ByRef $SMASK , $SLIST )
	If StringRegExp ( $SLIST , "\\|/|:|\<|\>|\|" ) Then Return 0
	$SLIST = StringReplace ( StringStripWS ( StringRegExpReplace ( $SLIST , "\s*;\s*" , ";" ) , BitOR ( $STR_STRIPLEADING , $STR_STRIPTRAILING ) ) , ";" , "|" )
	$SLIST = StringReplace ( StringReplace ( StringRegExpReplace ( $SLIST , "[][$^.{}()+\-]" , "\\$0" ) , "?" , "." ) , "*" , ".*?" )
	$SMASK = "(?i)^(" & $SLIST & ")\z"
	Return 1
EndFunc
Func _FILEWRITEFROMARRAY ( $SFILEPATH , Const ByRef $AARRAY , $IBASE = Default , $IUBOUND = Default , $SDELIMITER = "|" )
	Local $IRETURN = 0
	If Not IsArray ( $AARRAY ) Then Return SetError ( 2 , 0 , $IRETURN )
	Local $IDIMS = UBound ( $AARRAY , $UBOUND_DIMENSIONS )
	If $IDIMS > 2 Then Return SetError ( 4 , 0 , 0 )
	Local $ILAST = UBound ( $AARRAY ) + 4294967295
	If $IUBOUND = Default Or $IUBOUND > $ILAST Then $IUBOUND = $ILAST
	If $IBASE < 0 Or $IBASE = Default Then $IBASE = 0
	If $IBASE > $IUBOUND Then Return SetError ( 5 , 0 , $IRETURN )
	If $SDELIMITER = Default Then $SDELIMITER = "|"
	Local $HFILEOPEN = $SFILEPATH
	If IsString ( $SFILEPATH ) Then
		$HFILEOPEN = FileOpen ( $SFILEPATH , $FO_OVERWRITE )
		If $HFILEOPEN = + 4294967295 Then Return SetError ( 1 , 0 , $IRETURN )
	EndIf
	Local $IERROR = 0
	$IRETURN = 1
	Switch $IDIMS
	Case 1
		For $I = $IBASE To $IUBOUND
			If Not FileWrite ( $HFILEOPEN , $AARRAY [ $I ] & @CRLF ) Then
				$IERROR = 3
				$IRETURN = 0
				ExitLoop
			EndIf
		Next
	Case 2
		Local $STEMP = ""
		For $I = $IBASE To $IUBOUND
			$STEMP = $AARRAY [ $I ] [ 0 ]
			For $J = 1 To UBound ( $AARRAY , $UBOUND_COLUMNS ) + 4294967295
				$STEMP &= $SDELIMITER & $AARRAY [ $I ] [ $J ]
			Next
			If Not FileWrite ( $HFILEOPEN , $STEMP & @CRLF ) Then
				$IERROR = 3
				$IRETURN = 0
				ExitLoop
			EndIf
		Next
	EndSwitch
	If IsString ( $SFILEPATH ) Then FileClose ( $HFILEOPEN )
	Return SetError ( $IERROR , 0 , $IRETURN )
EndFunc
Func _WINAPI_GETLASTERROR ( Const $_ICALLERERROR = @error , Const $_ICALLEREXTENDED = @extended )
	Local $ACALL = DllCall ( "kernel32.dll" , "dword" , "GetLastError" )
	Return SetError ( $_ICALLERERROR , $_ICALLEREXTENDED , $ACALL [ 0 ] )
EndFunc
Global Const $TAGGUID = "struct;ulong Data1;ushort Data2;ushort Data3;byte Data4[8];endstruct"
Global Const $HGDI_ERROR = Ptr ( + 4294967295 )
Global Const $INVALID_HANDLE_VALUE = Ptr ( + 4294967295 )
Global Const $MB_PRECOMPOSED = 1
Global Const $KF_EXTENDED = 256
Global Const $KF_ALTDOWN = 8192
Global Const $KF_UP = 32768
Global Const $LLKHF_EXTENDED = BitShift ( $KF_EXTENDED , 8 )
Global Const $LLKHF_ALTDOWN = BitShift ( $KF_ALTDOWN , 8 )
Global Const $LLKHF_UP = BitShift ( $KF_UP , 8 )
Global Const $TAGOSVERSIONINFO = "struct;dword OSVersionInfoSize;dword MajorVersion;dword MinorVersion;dword BuildNumber;dword PlatformId;wchar CSDVersion[128];endstruct"
Func _WINAPI_GETVERSION ( )
	Local $TOSVI = DllStructCreate ( $TAGOSVERSIONINFO )
	DllStructSetData ( $TOSVI , 1 , DllStructGetSize ( $TOSVI ) )
	Local $ACALL = DllCall ( "kernel32.dll" , "bool" , "GetVersionExW" , "struct*" , $TOSVI )
	If @error Or Not $ACALL [ 0 ] Then Return SetError ( @error , @extended , 0 )
	Return Number ( DllStructGetData ( $TOSVI , 2 ) & "." & DllStructGetData ( $TOSVI , 3 ) , $NUMBER_DOUBLE )
EndFunc
Func _WINAPI_GUIDFROMSTRING ( $SGUID )
	Local $TGUID = DllStructCreate ( $TAGGUID )
	If Not _WINAPI_GUIDFROMSTRINGEX ( $SGUID , $TGUID ) Then Return SetError ( @error , @extended , 0 )
	Return $TGUID
EndFunc
Func _WINAPI_GUIDFROMSTRINGEX ( $SGUID , $TGUID )
	Local $ACALL = DllCall ( "ole32.dll" , "long" , "CLSIDFromString" , "wstr" , $SGUID , "struct*" , $TGUID )
	If @error Then Return SetError ( @error , @extended , False )
	If $ACALL [ 0 ] Then Return SetError ( 10 , $ACALL [ 0 ] , False )
	Return True
EndFunc
Func _WINAPI_MULTIBYTETOWIDECHAR ( $VTEXT , $ICODEPAGE = 0 , $IFLAGS = 0 , $BRETSTRING = False )
	Local $STEXTTYPE = ""
	If IsString ( $VTEXT ) Then $STEXTTYPE = "str"
	If ( IsDllStruct ( $VTEXT ) Or IsPtr ( $VTEXT ) ) Then $STEXTTYPE = "struct*"
	If $STEXTTYPE = "" Then Return SetError ( 1 , 0 , 0 )
	Local $ACALL = DllCall ( "kernel32.dll" , "int" , "MultiByteToWideChar" , "uint" , $ICODEPAGE , "dword" , $IFLAGS , $STEXTTYPE , $VTEXT , "int" , + 4294967295 , "ptr" , 0 , "int" , 0 )
	If @error Or Not $ACALL [ 0 ] Then Return SetError ( @error + 10 , @extended , 0 )
	Local $IOUT = $ACALL [ 0 ]
	Local $TOUT = DllStructCreate ( "wchar[" & $IOUT & "]" )
	$ACALL = DllCall ( "kernel32.dll" , "int" , "MultiByteToWideChar" , "uint" , $ICODEPAGE , "dword" , $IFLAGS , $STEXTTYPE , $VTEXT , "int" , + 4294967295 , "struct*" , $TOUT , "int" , $IOUT )
	If @error Or Not $ACALL [ 0 ] Then Return SetError ( @error + 20 , @extended , 0 )
	If $BRETSTRING Then Return DllStructGetData ( $TOUT , 1 )
	Return $TOUT
EndFunc
Global Const $SERVICES_ACTIVE_DATABASE = "ServicesActive"
Global Const $SC_MANAGER_CONNECT = 1
Global Const $SERVICE_QUERY_STATUS = 4
Global Const $SERVICE_START = 16
Global Const $SC_STATUS_PROCESS_INFO = 0
Func _SERVICE_QUERYSTATUS ( $SSERVICENAME , $SCOMPUTERNAME = "" )
	Local $HSC , $HSERVICE , $TSERVICE_STATUS_PROCESS , $AVQSSE , $IQSSE , $AISTATUS [ 9 ]
	$HSC = OPENSCMANAGER ( $SCOMPUTERNAME , $SC_MANAGER_CONNECT )
	$HSERVICE = OPENSERVICE ( $HSC , $SSERVICENAME , $SERVICE_QUERY_STATUS )
	$TSERVICE_STATUS_PROCESS = DllStructCreate ( "dword[9]" )
	Local $AVQSSE = DllCall ( "advapi32.dll" , "int" , "QueryServiceStatusEx" , "ptr" , $HSERVICE , "dword" , $SC_STATUS_PROCESS_INFO , "ptr" , DllStructGetPtr ( $TSERVICE_STATUS_PROCESS ) , "dword" , DllStructGetSize ( $TSERVICE_STATUS_PROCESS ) , "dword*" , 0 )
	If $AVQSSE [ 0 ] = 0 Then $IQSSE = _WINAPI_GETLASTERROR ( )
	CLOSESERVICEHANDLE ( $HSERVICE )
	CLOSESERVICEHANDLE ( $HSC )
	For $I = 0 To 8
		$AISTATUS [ $I ] = DllStructGetData ( $TSERVICE_STATUS_PROCESS , 1 , $I + 1 )
	Next
	Return SetError ( $IQSSE , 0 , $AISTATUS )
EndFunc
Func _SERVICE_START ( $SSERVICENAME , $SCOMPUTERNAME = "" )
	Local $HSC , $HSERVICE , $AVSS , $ISS
	$HSC = OPENSCMANAGER ( $SCOMPUTERNAME , $SC_MANAGER_CONNECT )
	$HSERVICE = OPENSERVICE ( $HSC , $SSERVICENAME , $SERVICE_START )
	$AVSS = DllCall ( "advapi32.dll" , "int" , "StartServiceW" , "ptr" , $HSERVICE , "dword" , 0 , "ptr" , 0 )
	If $AVSS [ 0 ] = 0 Then $ISS = _WINAPI_GETLASTERROR ( )
	CLOSESERVICEHANDLE ( $HSERVICE )
	CLOSESERVICEHANDLE ( $HSC )
	Return SetError ( 1 , 0 , $ISS )
EndFunc
Func CLOSESERVICEHANDLE ( $HSCOBJECT )
	Local $AVCSH = DllCall ( "advapi32.dll" , "int" , "CloseServiceHandle" , "ptr" , $HSCOBJECT )
	If @error Then Return SetError ( @error , 0 , 0 )
	Return $AVCSH [ 0 ]
EndFunc
Func OPENSCMANAGER ( $SCOMPUTERNAME , $IACCESS )
	Local $AVOSCM = DllCall ( "advapi32.dll" , "ptr" , "OpenSCManagerW" , "wstr" , $SCOMPUTERNAME , "wstr" , $SERVICES_ACTIVE_DATABASE , "dword" , $IACCESS )
	If @error Then Return SetError ( @error , 0 , 0 )
	Return $AVOSCM [ 0 ]
EndFunc
Func OPENSERVICE ( $HSC , $SSERVICENAME , $IACCESS )
	Local $AVOS = DllCall ( "advapi32.dll" , "ptr" , "OpenServiceW" , "ptr" , $HSC , "wstr" , $SSERVICENAME , "dword" , $IACCESS )
	If @error Then Return SetError ( @error , 0 , 0 )
	Return $AVOS [ 0 ]
EndFunc
Global Const $PROV_RSA_AES = 24
Global Const $CRYPT_VERIFYCONTEXT = 4026531840
Global Const $HP_HASHSIZE = 4
Global Const $HP_HASHVAL = 2
Global Const $CRYPT_USERDATA = 1
Global Const $CALG_MD5 = 32771
Global $__G_ACRYPTINTERNALDATA [ 3 ]
Func _CRYPT_STARTUP ( )
	If __CRYPT_REFCOUNT ( ) = 0 Then
		Local $HADVAPI32 = DllOpen ( "Advapi32.dll" )
		If $HADVAPI32 = + 4294967295 Then Return SetError ( 1001 , 0 , False )
		__CRYPT_DLLHANDLESET ( $HADVAPI32 )
		Local $IPROVIDERID = $PROV_RSA_AES
		Local $ACALL = DllCall ( __CRYPT_DLLHANDLE ( ) , "bool" , "CryptAcquireContext" , "handle*" , 0 , "ptr" , 0 , "ptr" , 0 , "dword" , $IPROVIDERID , "dword" , $CRYPT_VERIFYCONTEXT )
		If @error Or Not $ACALL [ 0 ] Then
			Local $IERROR = @error + 1002 , $IEXTENDED = @extended
			If Not $ACALL [ 0 ] Then $IEXTENDED = _WINAPI_GETLASTERROR ( )
			DllClose ( __CRYPT_DLLHANDLE ( ) )
			Return SetError ( $IERROR , $IEXTENDED , False )
		Else
			__CRYPT_CONTEXTSET ( $ACALL [ 1 ] )
		EndIf
	EndIf
	__CRYPT_REFCOUNTINC ( )
	Return True
EndFunc
Func _CRYPT_SHUTDOWN ( )
	__CRYPT_REFCOUNTDEC ( )
	If __CRYPT_REFCOUNT ( ) = 0 Then
		DllCall ( __CRYPT_DLLHANDLE ( ) , "bool" , "CryptReleaseContext" , "handle" , __CRYPT_CONTEXT ( ) , "dword" , 0 )
		DllClose ( __CRYPT_DLLHANDLE ( ) )
	EndIf
EndFunc
Func _CRYPT_HASHDATA ( $VDATA , $IALGID , $BFINAL = True , $HCRYPTHASH = 0 )
	Local $ACALL , $TBUFF = 0 , $IERROR = 0 , $IEXTENDED = 0 , $IHASHSIZE = 0 , $VRETURN = 0
	_CRYPT_STARTUP ( )
	If @error Then Return SetError ( @error , @extended , + 4294967295 )
	Do
		If $HCRYPTHASH = 0 Then
			$ACALL = DllCall ( __CRYPT_DLLHANDLE ( ) , "bool" , "CryptCreateHash" , "handle" , __CRYPT_CONTEXT ( ) , "uint" , $IALGID , "ptr" , 0 , "dword" , 0 , "handle*" , 0 )
			If @error Or Not $ACALL [ 0 ] Then
				$IERROR = @error + 10
				$IEXTENDED = @extended
				If Not $ACALL [ 0 ] Then $IEXTENDED = _WINAPI_GETLASTERROR ( )
				$VRETURN = + 4294967295
				ExitLoop
			EndIf
			$HCRYPTHASH = $ACALL [ 5 ]
		EndIf
		$TBUFF = DllStructCreate ( "byte[" & BinaryLen ( $VDATA ) & "]" )
		DllStructSetData ( $TBUFF , 1 , $VDATA )
		$ACALL = DllCall ( __CRYPT_DLLHANDLE ( ) , "bool" , "CryptHashData" , "handle" , $HCRYPTHASH , "struct*" , $TBUFF , "dword" , DllStructGetSize ( $TBUFF ) , "dword" , $CRYPT_USERDATA )
		If @error Or Not $ACALL [ 0 ] Then
			$IERROR = @error + 20
			$IEXTENDED = @extended
			If Not $ACALL [ 0 ] Then $IEXTENDED = _WINAPI_GETLASTERROR ( )
			$VRETURN = + 4294967295
			ExitLoop
		EndIf
		If $BFINAL Then
			$ACALL = DllCall ( __CRYPT_DLLHANDLE ( ) , "bool" , "CryptGetHashParam" , "handle" , $HCRYPTHASH , "dword" , $HP_HASHSIZE , "dword*" , 0 , "dword*" , 4 , "dword" , 0 )
			If @error Or Not $ACALL [ 0 ] Then
				$IERROR = @error + 30
				$IEXTENDED = @extended
				If Not $ACALL [ 0 ] Then $IEXTENDED = _WINAPI_GETLASTERROR ( )
				$VRETURN = + 4294967295
				ExitLoop
			EndIf
			$IHASHSIZE = $ACALL [ 3 ]
			$TBUFF = DllStructCreate ( "byte[" & $IHASHSIZE & "]" )
			$ACALL = DllCall ( __CRYPT_DLLHANDLE ( ) , "bool" , "CryptGetHashParam" , "handle" , $HCRYPTHASH , "dword" , $HP_HASHVAL , "struct*" , $TBUFF , "dword*" , $IHASHSIZE , "dword" , 0 )
			If @error Or Not $ACALL [ 0 ] Then
				$IERROR = @error + 40
				$IEXTENDED = @extended
				If Not $ACALL [ 0 ] Then $IEXTENDED = _WINAPI_GETLASTERROR ( )
				$VRETURN = + 4294967295
				ExitLoop
			EndIf
			$VRETURN = DllStructGetData ( $TBUFF , 1 )
		Else
			$VRETURN = $HCRYPTHASH
		EndIf
	Until True
	If $HCRYPTHASH <> 0 And $BFINAL Then DllCall ( __CRYPT_DLLHANDLE ( ) , "bool" , "CryptDestroyHash" , "handle" , $HCRYPTHASH )
	_CRYPT_SHUTDOWN ( )
	Return SetError ( $IERROR , $IEXTENDED , $VRETURN )
EndFunc
Func __CRYPT_REFCOUNT ( )
	Return $__G_ACRYPTINTERNALDATA [ 0 ]
EndFunc
Func __CRYPT_REFCOUNTINC ( )
	$__G_ACRYPTINTERNALDATA [ 0 ] += 1
EndFunc
Func __CRYPT_REFCOUNTDEC ( )
	If $__G_ACRYPTINTERNALDATA [ 0 ] > 0 Then $__G_ACRYPTINTERNALDATA [ 0 ] -= 1
EndFunc
Func __CRYPT_DLLHANDLE ( )
	Return $__G_ACRYPTINTERNALDATA [ 1 ]
EndFunc
Func __CRYPT_DLLHANDLESET ( $HADVAPI32 )
	$__G_ACRYPTINTERNALDATA [ 1 ] = $HADVAPI32
EndFunc
Func __CRYPT_CONTEXT ( )
	Return $__G_ACRYPTINTERNALDATA [ 2 ]
EndFunc
Func __CRYPT_CONTEXTSET ( $HCRYPTCONTEXT )
	$__G_ACRYPTINTERNALDATA [ 2 ] = $HCRYPTCONTEXT
EndFunc
Global Const $TAGWINTRUST_FILE_INFO = "DWORD cbStruct;" & "ptr pcwszFilePath;" & "HWND hFile;" & "ptr  pgKnownSubject;"
Global Const $TAGWINTRUST_DATA = "DWORD cbStruct;" & "ptr   pPolicyCallbackData;" & "ptr   pSIPClientData;" & "DWORD dwUIChoice;" & "DWORD fdwRevocationChecks;" & "DWORD dwUnionChoice;" & "ptr   pInfoStruct;" & "DWORD dwStateAction;" & "HWND  hWVTStateData;" & "ptr   pwszURLReference;" & "DWORD dwProvFlags;" & "DWORD dwUIContext;"
Global Const $TAGWINTRUST_CATALOG_INFO = "DWORD cbStruct;" & "DWORD   dwCatalogVersion;" & "ptr   pcwszCatalogFilePath;" & "ptr pcwszMemberTag;" & "ptr pcwszMemberFilePath;" & "HANDLE hMemberFile;" & "ptr   pbCalculatedFileHash;" & "DWORD cbCalculatedFileHash;" & "ptr  pcCatalogContext;"
Global $TAGCMSG_SIGNER_INFO = "DWORD dwVersion;" & "DWORD   Issuer_cbData;" & "ptr   Issuer_pbData;" & "DWORD SerialNumber_cbData;" & "ptr SerialNumber_pbData;" & "ptr HashAlgorithm_pszObjId;" & "DWORD HashAlgorithm_Parameters_cbData;" & "ptr HashAlgorithm_Parameters_pbData;" & "ptr HashEncryptionAlgorithm_pszObjId;" & "DWORD HashEncryptionAlgorithm_Parameters_cbData;" & "ptr HashEncryptionAlgorithm_Parameters_pbData;" & "DWORD EncryptedHash_cbData;" & "ptr EncryptedHash_pbData;" & "DWORD AuthAttrs_cAttr;" & "ptr AuthAttrs_rgAttr;" & "DWORD UnauthAttrs_cAttr;" & "ptr UnauthAttrs_rgAttr;" & "DWORD dwUIContext;"
If @OSArch = "X64" Then $TAGCMSG_SIGNER_INFO = StringRegExpReplace ( $TAGCMSG_SIGNER_INFO , "DWORD" , "UINT64" )
Global $TAGCERT_INFO = "DWORD dwVersion;" & "DWORD SerialNumber_cbData;" & "ptr SerialNumber_pbData;" & "ptr SignatureAlgorithm_pszObjId;" & "DWORD SignatureAlgorithm_Parameters_cbData;" & "ptr SignatureAlgorithm_Parameters_pbData;" & "DWORD Issuer_cbData;" & "ptr Issuer_pbData;" & "DWORD NotBefore_dwLowDateTime;" & "DWORD NotBefore_dwHighDateTime;" & "DWORD NotAfter_dwLowDateTime;" & "DWORD NotAfter_dwHighDateTime;" & "DWORD Subject_cbData;" & "ptr Subject_pbData;" & "ptr SubjectPublicKeyInfo_Algorithm_pszObjId;" & "DWORD SubjectPublicKeyInfo_Algorithm_Parameters_cbData;" & "ptr SubjectPublicKeyInfo_Algorithm_Parameters_pbData;" & "DWORD SubjectPublicKeyInfo_PublicKey_cbData;" & "ptr SubjectPublicKeyInfo_PublicKey_pbData;" & "DWORD IssuerUniqueId_cbData;" & "ptr IssuerUniqueId_pbData;" & "DWORD SubjectUniqueId_cbData;" & "ptr SubjectUniqueId_pbData;" & "DWORD cExtension;" & "ptr rgExtension;"
If @OSArch = "X64" Then $TAGCERT_INFO = StringRegExpReplace ( $TAGCERT_INFO , "DWORD" , "UINT64" )
Global Const $WTD_UI_NONE = 2
Global Const $WTD_REVOKE_NONE = 0
Global Const $WTD_CHOICE_FILE = 1
Global Const $WTD_CHOICE_CATALOG = 2
Global Const $WTD_STATEACTION_AUTO_CACHE_FLUSH = 4
Global Const $WTD_REVOCATION_CHECK_NONE = 16
Global Const $ERROR_SUCCESS = 0
Global $WINTRUST_ACTION_GENERIC_VERIFY_V2 = _WINAPI_GUIDFROMSTRING ( "{00AAC56B-CD44-11D0-8CC2-00C04FC295EE}" )
Func _WINVERIFYTRUST ( $FILEPATH , $CATPATH = "" , $CATMEMBERTAG = "" , $DWPROVFLAGS = $WTD_REVOCATION_CHECK_NONE , $ICODEPAGE = 0 )
	If StringLen ( $FILEPATH ) > 1000 Then Return SetError ( + 4294967295 , 0 , "File Path too large." )
	Local $WSZSOURCEFILE = _WINAPI_MULTIBYTETOWIDECHAR ( $FILEPATH , $ICODEPAGE , $MB_PRECOMPOSED )
	If @error Then Return SetError ( + 4294967295 , 0 , "Could not convert FilePath to WideChar." )
	If StringLen ( $CATPATH ) = 0 Then
		$WINTRUST_FILE_INFO = DllStructCreate ( $TAGWINTRUST_FILE_INFO )
		DllStructSetData ( $WINTRUST_FILE_INFO , "cbStruct" , DllStructGetSize ( $WINTRUST_FILE_INFO ) )
		DllStructSetData ( $WINTRUST_FILE_INFO , "pcwszFilePath" , DllStructGetPtr ( $WSZSOURCEFILE ) )
		DllStructSetData ( $WINTRUST_FILE_INFO , "hFile" , 0 )
		DllStructSetData ( $WINTRUST_FILE_INFO , "pgKnownSubject" , 0 )
		$PINFOSTRUCT = DllStructGetPtr ( $WINTRUST_FILE_INFO )
		$DWUNIONCHOICE = $WTD_CHOICE_FILE
		$DWSTATEACTION = 0
	Else
		$WSZCATALOGFILE = _WINAPI_MULTIBYTETOWIDECHAR ( $CATPATH , $ICODEPAGE , $MB_PRECOMPOSED )
		If @error Then Return SetError ( + 4294967295 , 0 , "Could not convert CatPath to WideChar." )
		$WSZFILETAG = _WINAPI_MULTIBYTETOWIDECHAR ( $CATMEMBERTAG , $ICODEPAGE , $MB_PRECOMPOSED )
		If @error Then Return SetError ( + 4294967295 , 0 , "Could not convert CatMemberTag to WideChar." )
		$WINTRUST_CATALOG_INFO = DllStructCreate ( $TAGWINTRUST_CATALOG_INFO )
		DllStructSetData ( $WINTRUST_CATALOG_INFO , "cbStruct" , DllStructGetSize ( $WINTRUST_CATALOG_INFO ) )
		DllStructSetData ( $WINTRUST_CATALOG_INFO , "dwCatalogVersion" , 0 )
		DllStructSetData ( $WINTRUST_CATALOG_INFO , "pcwszCatalogFilePath" , DllStructGetPtr ( $WSZCATALOGFILE ) )
		DllStructSetData ( $WINTRUST_CATALOG_INFO , "pcwszMemberTag" , DllStructGetPtr ( $WSZFILETAG ) )
		DllStructSetData ( $WINTRUST_CATALOG_INFO , "pcwszMemberFilePath" , DllStructGetPtr ( $WSZSOURCEFILE ) )
		DllStructSetData ( $WINTRUST_CATALOG_INFO , "hMemberFile" , 0 )
		DllStructSetData ( $WINTRUST_CATALOG_INFO , "pbCalculatedFileHash" , 0 )
		DllStructSetData ( $WINTRUST_CATALOG_INFO , "cbCalculatedFileHash" , 0 )
		DllStructSetData ( $WINTRUST_CATALOG_INFO , "pcCatalogContext" , 0 )
		$PINFOSTRUCT = DllStructGetPtr ( $WINTRUST_CATALOG_INFO )
		$DWUNIONCHOICE = $WTD_CHOICE_CATALOG
		$DWSTATEACTION = $WTD_STATEACTION_AUTO_CACHE_FLUSH
	EndIf
	$WINTRUST_DATA = DllStructCreate ( $TAGWINTRUST_DATA )
	DllStructSetData ( $WINTRUST_DATA , "cbStruct" , DllStructGetSize ( $WINTRUST_DATA ) )
	DllStructSetData ( $WINTRUST_DATA , "pPolicyCallbackData" , 0 )
	DllStructSetData ( $WINTRUST_DATA , "pSIPClientData" , 0 )
	DllStructSetData ( $WINTRUST_DATA , "dwUIChoice" , $WTD_UI_NONE )
	DllStructSetData ( $WINTRUST_DATA , "fdwRevocationChecks" , $WTD_REVOKE_NONE )
	DllStructSetData ( $WINTRUST_DATA , "dwUnionChoice" , $DWUNIONCHOICE )
	DllStructSetData ( $WINTRUST_DATA , "pInfoStruct" , $PINFOSTRUCT )
	DllStructSetData ( $WINTRUST_DATA , "dwStateAction" , $DWSTATEACTION )
	DllStructSetData ( $WINTRUST_DATA , "hWVTStateData" , 0 )
	DllStructSetData ( $WINTRUST_DATA , "pwszURLReference" , 0 )
	DllStructSetData ( $WINTRUST_DATA , "dwProvFlags" , $DWPROVFLAGS )
	DllStructSetData ( $WINTRUST_DATA , "dwUIContext" , 0 )
	$PGUID = DllStructGetPtr ( $WINTRUST_ACTION_GENERIC_VERIFY_V2 )
	$PWINTRUST_DATA = DllStructGetPtr ( $WINTRUST_DATA )
	$STATUS = DllCall ( "wintrust.dll" , "long" , "WinVerifyTrust" , "HWND" , 0 , "ptr" , $PGUID , "ptr" , $PWINTRUST_DATA )
	If @error Then SetError ( + 4294967295 , 0 , "WinVerifyTrust Error." )
	Return $STATUS [ 0 ]
EndFunc
Global $PROGRESS , $IMAGEPATH , $RUN , $SERV , $PATH , $DEFS1 , $DEFS2 , $DEFIMAGEPATH , $SERVICEDLL , $FILE , $HASH , $OSV , $RPCSS , $FIX , $DEFISERVICEDLL , $OMYERROR
Global $FORM1 , $CHECKBOX1 , $CHECKBOX2 , $CHECKBOX3 , $CHECKBOX4 , $CHECKBOX5 , $CHECKBOX6 , $CHECKBOX7 , $CHECKBOX8 , $EDIT , $BUTTONSCAN , $BUTTONSEARCH , $BUTTONEXPORT , $LABELS , $LABEL , $GUIMSG , $CRYPT , $WIND1 , $WIND2 , $WIND3
Global $VERSION = " Version: " & FileGetVersion ( @ScriptName , "ProductVersion" )
$FORM1 = GUICreate ( "Farbar Service Scanner" & $VERSION , 400 , 330 , 350 , 300 )
$CHECKBOX1 = GUICtrlCreateCheckbox ( "RpcSs and PlugPlay" , 10 , 5 , 150 , 20 )
GUICtrlSetState ( + 4294967295 , $GUI_CHECKED )
GUICtrlSetState ( + 4294967295 , $GUI_DISABLE )
$CHECKBOX2 = GUICtrlCreateCheckbox ( "Internet Services" , 10 , 25 , 200 , 20 )
GUICtrlSetState ( + 4294967295 , $GUI_CHECKED )
$CHECKBOX3 = GUICtrlCreateCheckbox ( "Windows Firewall" , 10 , 45 , 200 , 20 )
GUICtrlSetState ( + 4294967295 , $GUI_CHECKED )
$CHECKBOX4 = GUICtrlCreateCheckbox ( "System Restore" , 10 , 65 , 200 , 20 )
GUICtrlSetState ( + 4294967295 , $GUI_CHECKED )
$CHECKBOX5 = GUICtrlCreateCheckbox ( "Security Center/Action Center" , 10 , 85 , 200 , 20 )
GUICtrlSetState ( + 4294967295 , $GUI_CHECKED )
$CHECKBOX6 = GUICtrlCreateCheckbox ( "Windows Update" , 10 , 105 , 200 , 20 )
GUICtrlSetState ( + 4294967295 , $GUI_CHECKED )
$CHECKBOX7 = GUICtrlCreateCheckbox ( "Windows Defender" , 10 , 125 , 200 , 20 )
GUICtrlSetState ( + 4294967295 , $GUI_CHECKED )
$CHECKBOX8 = GUICtrlCreateCheckbox ( "Other Services" , 10 , 145 , 200 , 20 )
GUICtrlSetState ( + 4294967295 , $GUI_CHECKED )
$EDIT = GUICtrlCreateEdit ( "" , 60 , 177 , 260 , 70 )
$BUTTONSCAN = GUICtrlCreateButton ( "Scan" , 20 , 250 , 99 , 25 , $WS_BORDER , $WS_EX_DLGMODALFRAME )
$BUTTONSEARCH = GUICtrlCreateButton ( "Search Files" , 130 , 250 , 99 , 25 , $WS_BORDER , $WS_EX_DLGMODALFRAME )
$BUTTONEXPORT = GUICtrlCreateButton ( "Export Service" , 240 , 250 , 99 , 25 , $WS_BORDER , $WS_EX_DLGMODALFRAME )
$LABELS = GUICtrlCreateLabel ( "Search:" , 10 , 175 , 45 , 20 )
$LABEL = GUICtrlCreateLabel ( "" , 24 , 282 , 290 , 20 )
GUISetState ( @SW_SHOW )
If Not FileExists ( @ScriptDir & "\FSS.txt" ) Then
	$YN = MsgBox ( 4 + 64 , "Farbar Service Scanner" , "This software is not permitted for commercial purposes." & @CRLF & @CRLF & "Are you sure you want to continue?" & @CRLF & @CRLF & "Click Yes to continue. Click No to exit." )
	If $YN = 7 Then Exit
EndIf
Global $SYSTEMDRIVE , $SYSTEMDIR , $OSNUM = _WINAPI_GETVERSION ( )
$SYSTEMDRIVE = EnvGet ( "SystemDrive" )
If @OSArch = "X64" Then
	$SYSTEMDIR = $SYSTEMDRIVE & "\Windows\SysNative"
Else
	$SYSTEMDIR = @SystemDir
EndIf
$RUNSCAN = ""
If _SRVSTAT ( "cryptsvc" ) = "R" Then
	$CRYPT = 1
Else
	RunWait ( @ComSpec & " /c " & "net start cryptsvc" , "" , @SW_HIDE )
	If _SRVSTAT ( "cryptsvc" ) = "R" Then $CRYPT = 1
EndIf
While 1
	$GUIMSG = GUIGetMsg ( )
	Select
	Case $GUIMSG = $GUI_EVENT_CLOSE
		Exit
	Case $GUIMSG = $BUTTONSCAN Or $RUNSCAN
		GUICtrlSetState ( $BUTTONSCAN , $GUI_DISABLE )
		HEADING ( )
		FileWrite ( "FSS.txt" , @CRLF & @CRLF & "RpcSs and PlugPlay:" & @CRLF & "================" & @CRLF )
		PLUGPLAY ( )
		RPCSSCHECK ( )
		If GUICtrlRead ( $CHECKBOX2 ) = $GUI_CHECKED Then
			INTERNET ( )
			CONNECTION ( )
			SHOWPROXY ( )
			IPPOLICY ( )
		EndIf
		If GUICtrlRead ( $CHECKBOX3 ) = $GUI_CHECKED Then
			FIREWALL ( )
			FIREWALLPOL ( )
		EndIf
		If GUICtrlRead ( $CHECKBOX4 ) = $GUI_CHECKED Then
			SYSTEMRESTORE ( )
			SYSTEMRESTOREPOL ( )
		EndIf
		If GUICtrlRead ( $CHECKBOX5 ) = $GUI_CHECKED Then SECURITYCENTER ( )
		If GUICtrlRead ( $CHECKBOX6 ) = $GUI_CHECKED Then WINDOWSUPDATE ( )
		If GUICtrlRead ( $CHECKBOX6 ) = $GUI_CHECKED Then WINDOWSUPDATEPOL ( )
		If GUICtrlRead ( $CHECKBOX7 ) = $GUI_CHECKED Then
			If _SRVSTAT ( "windefend" ) <> "R" Then WINDEFENDPOL ( )
			WINDOWSDEFENDER ( )
			FILECHECKWD ( )
		EndIf
		If GUICtrlRead ( $CHECKBOX8 ) = $GUI_CHECKED Then OTHERSERVICES ( )
		FileWrite ( "FSS.txt" , @CRLF & @CRLF & "**** End of log ****" )
		GUICtrlSetData ( $LABEL , "" )
		GUICtrlSetData ( $BUTTONSCAN , "Scan" )
		GUICtrlDelete ( $PROGRESS )
		If Not $RUNSCAN Then Run ( "notepad.exe FSS.txt" )
		If $RUNSCAN Then
			MsgBox ( 0 , "Farbar Service Scanner" , "Scan completed." & @CRLF & @CRLF & "A FSS.txt log file is saved in the same directory the tool is run." , 5 )
			Exit
		EndIf
		GUICtrlSetState ( $BUTTONSCAN , $GUI_ENABLE )
	Case $GUIMSG = $BUTTONSEARCH
		$FIX = GUICtrlRead ( $EDIT )
		If $FIX = "" Then MsgBox ( 0 , "Farbar Service Scanner" , "No search term is entered. Please enter the search term and press ""Search Files"" button." )
		If Not $FIX = "" Then
			GUICtrlSetState ( $BUTTONSEARCH , $GUI_DISABLE )
			SEARCHBUTT ( )
			GUICtrlSetState ( $BUTTONSEARCH , $GUI_ENABLE )
		EndIf
	Case $GUIMSG = $BUTTONEXPORT
		$FIX = GUICtrlRead ( $EDIT )
		If $FIX = "" Then MsgBox ( 0 , "Farbar Service Scanner" , "No service name is entered. Please enter the service name and press ""Export Service"" button." )
		If Not $FIX = "" Then
			EXPORT ( )
		EndIf
	EndSelect
WEnd
Func _SRVSTAT ( $SNAME )
	$ST = _SERVICE_QUERYSTATUS ( $SNAME )
	If IsArray ( $ST ) Then
		Switch $ST [ 1 ]
		Case 1
			Return "S"
		Case 4
			Return "R"
	Case Else
			Return "U"
		EndSwitch
	EndIf
EndFunc
Func OTHERSERVICES ( )
	GUICtrlSetData ( $LABEL , "Checking Other Services..." )
	FileWrite ( "FSS.txt" , @CRLF & @CRLF & "Other Services:" & @CRLF & "==============" & @CRLF )
	If GUICtrlRead ( $CHECKBOX8 ) Then CHECKOTHERS ( "iphlpsvc" )
	$SERV = "SharedAccess"
	$KEY = "HKLM64\System\CurrentControlSet\Services\" & $SERV
	$SERVICEDLL = RegRead ( $KEY & "\Defaults\FirewallPolicy\FirewallRules" , "" )
	If @error = 1 Then FileWrite ( "FSS.txt" , "Checking FirewallRules of SharedAccess: ATTENTION!=====> Unable to open """ & $SERV & "\Defaults\FirewallPolicy\FirewallRules"" registry key. The key does not exist." & @CRLF )
	$DEFS1 = 3
	$DEFS2 = 3
	$DEFIMAGEPATH = "%SystemRoot%\System32\svchost.exe -k netsvcs"
	$DEFISERVICEDLL = "%SystemRoot%\System32\ipnathlp.dll"
	CHECK ( 1 )
	$SERV = "PolicyAgent"
	$DEFS1 = 3
	$DEFS2 = 3
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k NetworkServiceNetworkRestricted"
	$DEFISERVICEDLL = "%SystemRoot%\System32\ipsecsvc.dll"
	CHECK ( 1 )
	$SERV = "TermService"
	$DEFS1 = 3
	$DEFS2 = 3
	$DEFIMAGEPATH = "%SystemRoot%\System32\svchost.exe -k NetworkService"
	$DEFISERVICEDLL = "%SystemRoot%\System32\termsrv.dll"
	CHECK ( 1 )
EndFunc
Func UNABL ( $VALNAME , $ERR )
	Select
	Case $ERR = 1
		FileWrite ( "FSS.txt" , "Checking " & $VALNAME & " of " & $SERV & ": ATTENTION!=====> Unable to open " & $SERV & " registry key. The service key does not exist." & @CRLF )
	Case $ERR = + 4294967295
		FileWrite ( "FSS.txt" , "Checking " & $VALNAME & " of " & $SERV & ": ATTENTION!=====> Unable to retrieve " & $VALNAME & " of " & $SERV & ". The value does not exist." & @CRLF )
	EndSelect
EndFunc
Func CHECKOTHERS ( $SERV )
	$KEY = "HKLM64\System\CurrentControlSet\Services\" & $SERV
	RegRead ( $KEY , "Start" )
	UNABL ( "Start type" , @error )
	$IMAGEPATH = RegRead ( $KEY , "ImagePath" )
	UNABL ( "ImagePath" , @error )
	$SERVICEDLL = RegRead ( $KEY & "\Parameters" , "ServiceDll" )
	UNABL ( "ServiceDll" , @error )
EndFunc
Func WINDOWSDEFENDER ( )
	If $OSNUM < 6.1 Then Return
	GUICtrlSetData ( $LABEL , "Checking Security Center services..." )
	FileWrite ( "FSS.txt" , @CRLF & @CRLF & "Windows Defender:" & @CRLF & "==============" & @CRLF )
	If $OSNUM = 6.1 And _SRVSTAT ( "windefend" ) <> "R" Then
		$SERV = "WinDefend"
		$DEFS1 = 2
		$DEFS2 = 2
		$DEFIMAGEPATH = "%SystemRoot%\System32\svchost.exe -k secsvcs"
		$DEFISERVICEDLL = "%ProgramFiles%\Windows Defender\mpsvc.dll"
		CHECK ( 1 )
	EndIf
	If $OSNUM > 6.1 And _SRVSTAT ( "windefend" ) <> "R" Then
		$SERV = "windefend"
		CHECKWINDEF ( )
	EndIf
	If $OSNUM > 6.2 And _SRVSTAT ( "WdNisSvc" ) <> "R" Then
		$SERV = "WdNisSvc"
		CHECKWINDEF ( )
	EndIf
	If $OSNUM > 6.3 And _SRVSTAT ( "MDCoreSvc" ) <> "R" Then
		$SERV = "MDCoreSvc"
		CHECKWINDEF ( )
	EndIf
EndFunc
Func FILECHECKWD ( )
	If $OSNUM = 6.1 Then CHECKFILE ( $SYSTEMDRIVE & "\Program Files\Windows Defender\MpSvc.dll" )
	If $WIND1 Then
		If $OSNUM <= 6.3 And Not StringInStr ( $WIND1 , "svchost.exe" ) Then CHECKFILE ( $WIND1 )
		If $OSNUM > 6.3 And StringInStr ( $WIND1 , "ProgramData" ) Then CHECKFILE ( $WIND1 )
	EndIf
	If $WIND2 Then
		If $OSNUM > 6.3 Then
			If StringInStr ( $WIND2 , "ProgramData" ) Then CHECKFILE ( $WIND2 )
		Else
			CHECKFILE ( $WIND2 )
		EndIf
	EndIf
	If $WIND3 And $OSNUM > 6.3 And StringInStr ( $WIND3 , "ProgramData" ) Then CHECKFILE ( $WIND3 )
EndFunc
Func CHECKWINDEF ( )
	FileWrite ( "FSS.txt" , $SERV & " Service is not running. Checking service configuration:" & @CRLF )
	$START = RegRead ( "HKLM64\System\CurrentControlSet\Services\" & $SERV , "Start" )
	$ERR = @error
	Select
	Case $ERR = 1 Or $ERR = + 4294967295
		UNABL ( "Start type" , $ERR )
		If $ERR = 1 Then Return
	Case $ERR = 0
		STARTTYPE ( $START )
		FileWrite ( "FSS.txt" , "The start type of " & $SERV & " service is """ & $START & """." & @CRLF )
	EndSelect
	$IMAGEPATH = RegRead ( "HKLM64\System\CurrentControlSet\Services\" & $SERV , "ImagePath" )
	Select
	Case @error = + 4294967295
		UNABL ( "ImagePath" , @error )
	Case @error = 0
		$ATT = ""
		Select
		Case $OSNUM > 6.1 And $SERV = "windefend" And StringInStr ( $IMAGEPATH , "Svchost.exe" )
			$ATT = " <===== ATTENTION"
		Case $OSNUM > 6.3 And StringRegExp ( $SERV , "(?i)MDCoreSvc|WinDefend|WdNisSvc" ) And Not StringInStr ( $IMAGEPATH , "ProgramData" )
			$ATT = " <===== ATTENTION"
		EndSelect
		FileWrite ( "FSS.txt" , "The ImagePath of " & $SERV & ": """ & $IMAGEPATH & """." & $ATT & @CRLF )
		$IMAGEPATH = StringRegExpReplace ( $IMAGEPATH , "^""|""$" , "" )
		$IMAGEPATH = StringRegExpReplace ( $IMAGEPATH , "(?i)%ProgramData%" , $SYSTEMDRIVE & "\\ProgramData" )
		If $SERV = "windefend" Then $WIND1 = $IMAGEPATH
		If $SERV = "WdNisSvc" Then $WIND2 = $IMAGEPATH
		If $SERV = "MDCoreSvc" Then $WIND3 = $IMAGEPATH
	EndSelect
EndFunc
Func WINDOWSUPDATE ( )
	GUICtrlSetData ( $LABEL , "Checking Windows Update services..." )
	FileWrite ( "FSS.txt" , @CRLF & @CRLF & "Windows Update:" & @CRLF & "===============" & @CRLF )
	$SERV = "wuauserv"
	$DEFS1 = 2
	$DEFS2 = 3
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k netsvcs"
	$DEFISERVICEDLL = "%SystemRoot%\System32\wuaueng.dll"
	CHECK ( 1 )
	$SERV = "BITS"
	$DEFS1 = 2
	$DEFS2 = 3
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k netsvcs"
	$DEFISERVICEDLL = "%SystemRoot%\System32\qmgr.dll"
	CHECK ( 1 )
	$SERV = "EventSystem"
	$DEFS1 = 2
	$DEFS2 = 2
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k LocalService"
	$DEFISERVICEDLL = "%SystemRoot%\System32\es.dll"
	CHECK ( 1 )
	$SERV = "cryptsvc"
	$DEFS1 = 2
	$DEFS2 = 2
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k NetworkService"
	$DEFISERVICEDLL = "%SystemRoot%\system32\cryptsvc.dll"
	CHECK ( 1 )
	If $OSNUM >= 10 Then
		$BUILD = RegRead ( "HKLM\Software\Microsoft\Windows NT\CurrentVersion" , "CurrentBuild" )
		$SERV = "UsoSvc"
		$DEFS1 = 2
		$DEFS2 = 2
		$DEFIMAGEPATH = "%systemroot%\system32\svchost.exe -k netsvcs -p"
		If @OSVersion = "WIN_10" And $BUILD < 1903 Then
			$DEFISERVICEDLL = "%systemroot%\system32\usocore.dll"
		Else
			$DEFISERVICEDLL = "%systemroot%\system32\usosvc.dll"
		EndIf
		CHECK ( 1 )
		If @OSVersion <> "WIN_10" Or ( @OSVersion = "WIN_10" And $BUILD > 1802 ) Then
			$SERV = "WaaSMedicSvc"
			$DEFS1 = 3
			$DEFS2 = 3
			$DEFIMAGEPATH = "%systemroot%\system32\svchost.exe -k wusvcs -p"
			$DEFISERVICEDLL = "%SystemRoot%\System32\WaaSMedicSvc.dll"
			CHECK ( 1 )
		EndIf
		$SERV = "dosvc"
		$DEFS1 = 2
		$DEFS2 = 3
		$DEFIMAGEPATH = "%SystemRoot%\System32\svchost.exe -k NetworkService -p"
		$DEFISERVICEDLL = "%SystemRoot%\System32\dosvc.dll"
		CHECK ( 1 )
	EndIf
EndFunc
Func SECURITYCENTER ( )
	GUICtrlSetData ( $LABEL , "Checking Security Center services..." )
	Local $SEC
	$SEC = "Security Center:"
	If StringInStr ( $OSV , "7" ) Or StringInStr ( $OSV , "8" ) Then $SEC = "Action Center:"
	If StringRegExp ( $OSV , "10|11" ) Then $SEC = "Windows Security:"
	FileWrite ( "FSS.txt" , @CRLF & @CRLF & $SEC & @CRLF & "============" & @CRLF )
	If $OSNUM > 6.3 Then
		$SERV = "SecurityHealthService"
		$DEFS1 = 3
		$DEFS2 = 3
		$DEFIMAGEPATH = "%SystemRoot%\system32\SecurityHealthService.exe"
		CHECK ( )
	EndIf
	$SERV = "wscsvc"
	$DEFS1 = 2
	$DEFS2 = 2
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k LocalServiceNetworkRestricted"
	$DEFISERVICEDLL = "%SystemRoot%\System32\wscsvc.dll"
	CHECK ( 1 )
	$SERV = "winmgmt"
	$DEFS1 = 2
	$DEFS2 = 2
	$DEFIMAGEPATH = "%systemroot%\system32\svchost.exe -k netsvcs"
	$DEFISERVICEDLL = "%SystemRoot%\system32\wbem\WMIsvc.dll"
	CHECK ( 1 )
	If $OSNUM < 6.1 Then Return
	RegRead ( "hklm64\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellServiceObjects\{F56F6FDD-AA9D-4618-A949-C1B91AF43B1A}" , "AutoStart" )
	Select
	Case @error = 1
		FileWrite ( "FSS.txt" , @CRLF & "Action Center Notification Icon =====> Unable to open HKLM\...\ShellServiceObjects\{F56F6FDD-AA9D-4618-A949-C1B91AF43B1A} key. The key does not exist." & @CRLF )
	Case @error = + 4294967295
		FileWrite ( "FSS.txt" , @CRLF & "Action Center Notification Icon =====> HKLM\...\ShellServiceObjects\{F56F6FDD-AA9D-4618-A949-C1B91AF43B1A}\\""AutoStart"" value does not exist." & @CRLF )
	EndSelect
EndFunc
Func SYSTEMRESTORE ( )
	GUICtrlSetData ( $LABEL , "Checking System Restore services..." )
	FileWrite ( "FSS.txt" , @CRLF & @CRLF & "System Restore:" & @CRLF & "============" & @CRLF )
	$SERV = "VSS"
	$DEFS1 = 3
	$DEFS2 = 3
	$DEFIMAGEPATH = "%systemroot%\system32\vssvc.exe"
	CHECK ( )
	If StringInStr ( $OSV , "8" ) Then Return
	$SERV = "SDRSVC"
	$DEFS1 = 3
	$DEFS2 = 3
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k SDRSVC"
	$DEFISERVICEDLL = "%Systemroot%\System32\SDRSVC.dll"
	CHECK ( 1 )
EndFunc
Func WINDEFENDPOL ( )
	Local $VAL
	GUICtrlSetData ( $LABEL , "Checking Windows Defender Policy..." )
	FileWrite ( "FSS.txt" , @CRLF & @CRLF & "Windows Defender Disabled Policy: " & @CRLF & "==========================" & @CRLF )
	$VAL = RegRead ( "hklm64\SOFTWARE\Microsoft\Windows Defender" , "DisableAntiSpyware" )
	If Not @error And $VAL = "1" Then FileWrite ( "FSS.txt" , "[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender]" & @CRLF & """DisableAntiSpyware""=DWORD:1" & @CRLF )
	$VAL = RegRead ( "hklm64\SOFTWARE\Policies\Microsoft\Windows Defender" , "DisableAntiSpyware" )
	If Not @error And $VAL = "1" Then FileWrite ( "FSS.txt" , "[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender]" & @CRLF & """DisableAntiSpyware""=DWORD:1" & @CRLF )
	RegRead ( "hklm64\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware" , "" )
	If @error = + 4294967295 Then FileWrite ( "FSS.txt" , "[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\DisableAntiSpyware]" & @CRLF )
EndFunc
Func FIREWALLPOL ( )
	Local $VAL
	GUICtrlSetData ( $LABEL , "Checking Windows Firewall Policy..." )
	FileWrite ( "FSS.txt" , @CRLF & @CRLF & "Firewall Disabled Policy: " & @CRLF & "==================" & @CRLF )
	$VAL = RegRead ( "hklm64\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile" , "EnableFirewall" )
	If Not @error And $VAL = "0" Then FileWrite ( "FSS.txt" , "[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsFirewall\StandardProfile]" & @CRLF & """EnableFirewall""=DWORD:0" & @CRLF )
	$VAL = RegRead ( "hklm64\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile" , "EnableFirewall" )
	Select
	Case Not @error And $VAL = "0"
		FileWrite ( "FSS.txt" , "[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile]" & @CRLF & """EnableFirewall""=DWORD:0" & @CRLF )
	Case @error = 1
		FileWrite ( "FSS.txt" , """HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile"" registry key does not exist." & @CRLF )
	Case @error = + 4294967295
		If $OSNUM > 5.2 Then FileWrite ( "FSS.txt" , """HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile\\EnableFirewall"" registry value does not exist." & @CRLF )
	EndSelect
EndFunc
Func SYSTEMRESTOREPOL ( )
	Local $VAL
	GUICtrlSetData ( $LABEL , "Checking System Restore Policy..." )
	FileWrite ( "FSS.txt" , @CRLF & @CRLF & "System Restore Policy: " & @CRLF & "========================" & @CRLF )
	$VAL = RegRead ( "hklm64\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" , "DisableSR" )
	If $VAL == 0 Or $VAL == 1 Then FileWrite ( "FSS.txt" , "[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore]" & @CRLF & """DisableSR""=""" & $VAL & """" & @CRLF )
	$VAL = RegRead ( "hklm64\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" , "DisableConfig" )
	If $VAL == 0 Or $VAL == 1 Then FileWrite ( "FSS.txt" , "[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore]" & @CRLF & """DisableConfig""=""" & $VAL & """" & @CRLF )
	$VAL = RegRead ( "hklm64\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" , "DisableSR" )
	If Not @error And $VAL = "1" Then FileWrite ( "FSS.txt" , "[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore]" & @CRLF & """DisableSR""=DWORD:1" & @CRLF )
EndFunc
Func WINDOWSUPDATEPOL ( )
	Local $VAL
	GUICtrlSetData ( $LABEL , "Checking Windows Autoupdate Policy..." )
	FileWrite ( "FSS.txt" , @CRLF & @CRLF & "Windows Autoupdate Disabled Policy: " & @CRLF & "============================" & @CRLF )
	$VAL = RegRead ( "hklm64\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" , "" )
	If POL ( "HKLM64\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" ) Then FileWrite ( "FSS.txt" , "ATTENTION!=====> policy restriction on WindowsUpdate: HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate " & @CRLF )
EndFunc
Func POL ( $KEY )
	RegRead ( $KEY , RegEnumVal ( $KEY , 1 ) )
	If Not @error Then Return 1
	$K = 1
	While 1
		$SUB = RegEnumKey ( $KEY , $K )
		If @error Then ExitLoop
		RegRead ( $KEY & "\" & $SUB , RegEnumVal ( $KEY & "\" & $SUB , 1 ) )
		If Not @error Then Return 1
		$K += 1
	WEnd
EndFunc
Func IPPOLICY ( )
	Local $VAL
	$VAL = RegRead ( "hklm64\SOFTWARE\Policies\Microsoft\Windows\IPSec\Policy\Local" , "ActivePolicy" )
	If Not @error Then FileWrite ( "FSS.txt" , @CRLF & "ATTENTION!=====> local policy on IP: " & @CRLF & "Key: ""HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\IPSec\Policy\Local""" & @CRLF & "Value: ""ActivePolicy""" & @CRLF & "Data: """ & $VAL & """" & @CRLF )
EndFunc
Func RPCSSCHECK ( )
	GUICtrlSetData ( $LABEL , "Checking RpcSs service ..." )
	$SERV = "RpcSs"
	RPCSS ( )
	$DEFS1 = 2
	$DEFS2 = 2
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k rpcss"
	$DEFISERVICEDLL = "%SystemRoot%\System32\rpcss.dll"
	CHECK ( 1 )
	CHECKFILE ( "%SystemRoot%\system32\svchost.exe" )
EndFunc
Func PLUGPLAY ( )
	GUICtrlSetData ( $LABEL , "Checking PlugPlay service ..." )
	$SERV = "PlugPlay"
	$DEFS1 = 2
	$DEFS2 = 3
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k Dcomlaunch"
	$DEFISERVICEDLL = "%SystemRoot%\system32\umpnpmgr.dll"
	CHECK ( 1 )
EndFunc
Func EXPORT ( )
	If FileExists ( @TempDir & "\temp0" ) Then FileDelete ( @TempDir & "\temp0" )
	FileDelete ( @TempDir & "\log*" )
	$FIX = StringRegExpReplace ( $FIX , ";" , @CRLF )
	FileWrite ( @TempDir & "\temp0" , $FIX )
	FileDelete ( @TempDir & "\log*" )
	FileDelete ( @TempDir & "\reg" )
	Local $I = 1
	Local $KEY , $LEGACY , $REGEXPR
	While 1
		$SERV = FileReadLine ( @TempDir & "\temp0" , $I )
		If @error <> 0 Then ExitLoop
		$SERV = StringRegExpReplace ( $SERV , "(.+)\s+\Z" , "$1" )
		$SERV = StringRegExpReplace ( $SERV , "(.+)\s+\Z" , "$1" )
		$SERV = StringRegExpReplace ( $SERV , "\A\s+(.+)" , "$1" )
		$SERV = StringRegExpReplace ( $SERV , "\A\s+(.+)" , "$1" )
		$KEY = "HKEY_LOCAL_MACHINE\System\CurrentControlSet\services\" & $SERV
		$LEGACY = "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\Root\LEGACY_" & $SERV
		FileWrite ( @TempDir & "\reg" , "================== Result for """ & $SERV & """ ==================" & @CRLF & @CRLF )
		RunWait ( @ComSpec & " /c " & "regedit /e """ & @TempDir & "\log0" & $I & """ """ & $KEY & """" , "" , @SW_HIDE )
		RunWait ( @ComSpec & " /c " & "regedit /e """ & @TempDir & "\log1" & $I & """ """ & $LEGACY & """" , "" , @SW_HIDE )
		RunWait ( @ComSpec & " /c " & "type """ & @TempDir & "\log???"" >> """ & @TempDir & "\reg""" , "" , @SW_HIDE )
		FileDelete ( @TempDir & "\log*" )
		$REGEXPR = FileRead ( @TempDir & "\reg" )
		$REGEXPR = StringRegExpReplace ( $REGEXPR , "Windows Registry Editor Version 5.00\v*[\n|\r]" , "" )
		$I = $I + 1
	WEnd
	FileDelete ( @TempDir & "\temp0" )
	FileDelete ( @TempDir & "\reg" )
	If FileExists ( "FSS.txt" ) Then FileDelete ( "FSS.txt" )
	FileWrite ( "FSS.txt" , "Note: The export is in ""Windows Registry Editor Version 5.00"" format." & @CRLF & @CRLF & $REGEXPR & @CRLF & @CRLF & "================== End Of Export =============" )
	GUISetState ( @SW_SHOW )
	Run ( "notepad FSS.txt" )
EndFunc
Func CONNECTION ( )
	Local $CONNECT , $ERR
	GUICtrlSetData ( $LABEL , "Checking Internet Connection ..." )
	FileWrite ( "FSS.txt" , @CRLF & @CRLF & "Connection Status:" & @CRLF & "==============" & @CRLF )
	Ping ( "127.0.0.1" )
	If @error = 0 Then
		FileWrite ( "FSS.txt" , "Localhost is accessible." & @CRLF )
	Else
		If @error = 1 Then $ERR = "Localhost is blocked: Destination is offline"
		If @error = 2 Then $ERR = "Localhost is blocked: Destination is unreachable"
		If @error = 3 Then $ERR = "Localhost is blocked: Destination unknown"
		If @error = 4 Then $ERR = "Localhost is blocked: Other errors"
		FileWrite ( "FSS.txt" , "Attempt to access Local Host IP returned error: " & $ERR & @CRLF )
	EndIf
	$CONNECT = _GETNETWORKCONNECT ( )
	If $CONNECT Then
		FileWrite ( "FSS.txt" , $CONNECT )
	Else
		FileWrite ( "FSS.txt" , "There is no connection to network." & @CRLF )
	EndIf
	GOOGLE ( )
	YAHOO ( )
EndFunc
Func _GETNETWORKCONNECT ( )
	Local $ARET , $IRESULT
	Local Const $NETWORK_ALIVE_LAN = 1
	Local Const $NETWORK_ALIVE_WAN = 2
	Local Const $NETWORK_ALIVE_AOL = 4
	$ARET = DllCall ( "sensapi.dll" , "int" , "IsNetworkAlive" , "int*" , 0 )
	If BitAND ( $ARET [ 1 ] , $NETWORK_ALIVE_LAN ) Then $IRESULT &= "LAN connected." & @CRLF
	If BitAND ( $ARET [ 1 ] , $NETWORK_ALIVE_WAN ) Then $IRESULT &= "WAN connected" & @CRLF
	If BitAND ( $ARET [ 1 ] , $NETWORK_ALIVE_AOL ) Then $IRESULT &= "AOL connected" & @CRLF
	Return $IRESULT
EndFunc
Func GOOGLE ( )
	Local $VAL , $ERR
	$VAL = Ping ( "173.194.67.100" )
	If $VAL > 1 Then
		FileWrite ( "FSS.txt" , "Google IP is accessible." & @CRLF )
	Else
		If @error = 1 Then $ERR = "Google IP is offline"
		If @error = 2 Then $ERR = "Google IP is unreachable"
		If @error = 3 Then $ERR = "Destination unknown"
		If @error = 4 Then $ERR = "Other errors"
		FileWrite ( "FSS.txt" , "Attempt to access Google IP returned error. " & $ERR & @CRLF )
	EndIf
	Ping ( "google.com" )
	If @error = 0 Then
		FileWrite ( "FSS.txt" , "Google.com is accessible." & @CRLF )
	Else
		If @error = 1 Then $ERR = "Google.com is offline"
		If @error = 2 Then $ERR = "Google.com is unreachable"
		If @error = 3 Then $ERR = "Destination unknown"
		If @error = 4 Then $ERR = "Other errors"
		FileWrite ( "FSS.txt" , "Attempt to access Google.com returned error: " & $ERR & @CRLF )
	EndIf
EndFunc
Func YAHOO ( )
	Local $ERR , $VAL
	Ping ( "yahoo.com" )
	If @error = 0 Then
		FileWrite ( "FSS.txt" , "Yahoo.com is accessible." & @CRLF )
	Else
		If @error = 1 Then $ERR = "Yahoo.com is offline"
		If @error = 2 Then $ERR = "Yahoo.com is unreachable"
		If @error = 3 Then $ERR = "Destination unknown"
		If @error = 4 Then $ERR = "Other errors"
		FileWrite ( "FSS.txt" , "Attempt to access Yahoo.com returned error: " & $ERR & @CRLF )
	EndIf
EndFunc
Func SHOWPROXY ( )
	Local $VAL1 , $RES1 , $VAL2 , $RES2
	GUICtrlSetData ( $LABEL , "Checking Proxy Settings..." )
	$VAL1 = RegRead ( "HKCU64\Software\Microsoft\Windows\CurrentVersion\Internet Settings" , "ProxyEnable" )
	If $VAL1 = "1" Then
		$RES1 = "IE proxy is enabled."
		$VAL2 = RegRead ( "HKCU64\Software\Microsoft\Windows\CurrentVersion\Internet Settings" , "ProxyServer" )
		If Not $VAL2 = "" Then $RES2 = "ProxyServer: " & $VAL2
		FileWrite ( "FSS.txt" , $RES1 & @CRLF & $RES2 & @CRLF )
	EndIf
EndFunc
Func FIREWALL ( )
	GUICtrlSetData ( $LABEL , "Checking Windows Firewall Services..." )
	FileWrite ( "FSS.txt" , @CRLF & @CRLF & "Windows Firewall:" & @CRLF & "=============" & @CRLF )
	$SERV = "mpsdrv"
	$DEFS1 = 3
	$DEFS2 = 3
	$DEFIMAGEPATH = "system32\DRIVERS\mpsdrv.sys"
	CHECK ( )
	$SERV = "MpsSvc"
	$DEFS1 = 2
	$DEFS2 = 2
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k LocalServiceNoNetwork"
	$DEFISERVICEDLL = "%SystemRoot%\System32\mpssvc.dll"
	CHECK ( 1 )
	$SERV = "bfe"
	$DEFS1 = 2
	$DEFS2 = 2
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k LocalServiceNoNetwork"
	$DEFISERVICEDLL = "%SystemRoot%\System32\bfe.dll"
	CHECK ( 1 )
EndFunc
Func INTERNET ( )
	GUICtrlSetData ( $LABEL , "Checking Internet service ..." )
	FileWrite ( "FSS.txt" , @CRLF & "Internet Services:" & @CRLF & "============" & @CRLF )
	$SERV = "Dnscache"
	$DEFS1 = 2
	$DEFS2 = 2
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k NetworkService"
	$DEFISERVICEDLL = "%SystemRoot%\System32\dnsrslvr.dll"
	CHECK ( 1 )
	$SERV = "Dhcp"
	$DEFS1 = 2
	$DEFS2 = 2
	$DEFIMAGEPATH = "%SystemRoot%\system32\svchost.exe -k LocalServiceNetworkRestricted"
	$DEFISERVICEDLL = "%SystemRoot%\system32\dhcpcore.dll"
	CHECK ( 1 )
	$SERV = "Nsi"
	$DEFS1 = 2
	$DEFS2 = 2
	$DEFIMAGEPATH = "%systemroot%\system32\svchost.exe -k LocalService"
	$DEFISERVICEDLL = "%systemroot%\system32\nsisvc.dll"
	CHECK ( 1 )
	$SERV = "nsiproxy"
	$DEFS1 = 1
	$DEFS2 = 1
	$DEFIMAGEPATH = "system32\drivers\nsiproxy.sys"
	CHECK ( )
	If $OSNUM < 6.2 Then LEGACY ( )
	$SERV = "tdx"
	$DEFS1 = 1
	$DEFS2 = 1
	$DEFIMAGEPATH = "system32\DRIVERS\tdx.sys"
	CHECK ( )
	If $OSNUM < 6.2 Then LEGACY ( )
	$SERV = "afd"
	$DEFS1 = 1
	$DEFS2 = 1
	$DEFIMAGEPATH = "\SystemRoot\System32\drivers\afd.sys"
	CHECK ( )
	If $OSNUM < 6.2 Then LEGACY ( )
	$SERV = "Tcpip"
	$DEFS1 = 0
	$DEFS2 = 1
	$DEFIMAGEPATH = "system32\DRIVERS\tcpip.sys"
	CHECK ( )
	If $OSNUM < 6.2 Then LEGACY ( )
EndFunc
Func _RUN ( $COM )
	$PID = Run ( @ComSpec & " /u /c " & $COM , "" , @SW_HIDE , 2 + 4 )
	ProcessWaitClose ( $PID )
	$READ1 = StdoutRead ( $PID , False , True )
	$READ2 = StderrRead ( $PID )
	$PATH1 = @TempDir & "\cmd1" & Random ( 1000 , 9999 , 1 ) & ".txt"
	$PATH2 = @TempDir & "\cmd2" & Random ( 1000 , 9999 , 1 ) & ".txt"
	$HLOG1 = FileOpen ( $PATH1 , 256 + 2 )
	$HLOG2 = FileOpen ( $PATH2 , 256 + 2 )
	FileWrite ( $HLOG1 , $READ1 )
	FileWrite ( $HLOG2 , $READ2 )
	FileClose ( $HLOG1 )
	FileClose ( $HLOG2 )
	$READ1 = FileRead ( $PATH1 )
	$READ2 = FileRead ( $PATH2 )
	FileDelete ( $PATH1 )
	FileDelete ( $PATH2 )
	Return $READ1 & @CRLF & $READ2
EndFunc
Func CHECK ( $SDLL = 0 )
	If $DEFS2 = 3 And _SRVSTAT ( $SERV ) <> "R" And $SERV <> "SharedAccess" Then
		_SERVICE_START ( $SERV )
		Sleep ( 5000 )
		If _SRVSTAT ( $SERV ) <> "R" Then
			$READ = _RUN ( "net start " & $SERV )
			If _SRVSTAT ( $SERV ) <> "R" Then FileWrite ( "FSS.txt" , $SERV & " Service is not running. Error while attempting to start " & $SERV & ":" & $READ )
		EndIf
		$ST = ""
	Else
		If _SRVSTAT ( $SERV ) <> "R" Then $ST = $SERV & " Service is not running. "
	EndIf
	$KEY = "HKLM64\SYSTEM\CurrentControlSet\Services\" & $SERV
	$START = RegRead ( $KEY , "Start" )
	Select
	Case @error = 1 Or @error = + 4294967295
		UNABL ( "Start type" , @error )
	Case @error = 0
		If $START <> $DEFS1 And $START <> $DEFS2 Then
			STARTTYPE ( $START )
			Select
			Case $DEFS1 = $DEFS2
				FileWrite ( "FSS.txt" , "The start type of " & $SERV & " service is set to " & $START & ". The default start type is " & $DEFS1 & "." & @CRLF )
			Case $DEFS1 <> $DEFS2
				FileWrite ( "FSS.txt" , "The start type of " & $SERV & " service is set to " & $START & ". The default start type, depending on the OS, is either " & $DEFS1 & " or " & $DEFS2 & "." & @CRLF )
			EndSelect
		EndIf
	EndSelect
	$IMAGEPATH = RegRead ( $KEY , "ImagePath" )
	Select
	Case @error = 1
		FileWrite ( "FSS.txt" , "Checking ImagePath: ATTENTION!=====> Unable to open " & $SERV & " registry key. The service key does not exist." & @CRLF )
	Case @error = + 4294967295
		FileWrite ( "FSS.txt" , "Checking ImagePath: ATTENTION!=====> Unable to retrieve ImagePath of " & $SERV & ". The value does not exist." & @CRLF )
	Case @error = 0
		If Not StringInStr ( $IMAGEPATH , $DEFIMAGEPATH ) Then FileWrite ( "FSS.txt" , "The ImagePath of " & $SERV & ": """ & $IMAGEPATH & """." & @CRLF )
		If Not $SDLL Then
			CHECKFILE ( $IMAGEPATH )
			Return
		EndIf
	EndSelect
	$KEY = "HKLM64\SYSTEM\CurrentControlSet\Services\" & $SERV
	$SERVICEDLL = RegRead ( $KEY , "ServiceDll" )
	If @error Then $SERVICEDLL = RegRead ( $KEY & "\Parameters" , "ServiceDLL" )
	Select
	Case @error = 1 Or @error = + 4294967295
		UNABL ( "ServiceDll" , @error )
	Case @error = 0
		If $SERVICEDLL <> $DEFISERVICEDLL Then FileWrite ( "FSS.txt" , "The ServiceDll of " & $SERV & ": """ & $SERVICEDLL & """." & @CRLF )
		CHECKFILE ( $SERVICEDLL )
	EndSelect
EndFunc
Func LEGACY ( )
	Local $CLASGUID
	$CLASGUID = RegRead ( "HKLM64\SYSTEM\CurrentControlSet\Enum\Root\LEGACY_" & $SERV & "\0000" , "ClassGUID" )
	Select
	Case @error = 1
		FileWrite ( "FSS.txt" , "Checking LEGACY_" & $SERV & ": ATTENTION!=====> Unable to open LEGACY_" & $SERV & "\0000 registry key. The key does not exist." & @CRLF )
	Case @error = + 4294967295
		FileWrite ( "FSS.txt" , "Checking LEGACY_" & $SERV & "\0000: ATTENTION!=====> Unable to retrieve ClassGUID of LEGACY_" & $SERV & "\0000. The value does not exist." & @CRLF )
	EndSelect
EndFunc
Func AAAAFP ( )
	$FILE = StringRegExpReplace ( $FILE , """" , "" )
	$FILE = StringRegExpReplace ( $FILE , "%+" , "%" )
	$FILE = StringRegExpReplace ( $FILE , "(^\s+|\s+$)" , "" )
	$FILE = StringRegExpReplace ( $FILE , "^\\\?\?\\" , "" )
	If StringRegExp ( $FILE , ".:/" ) Then $FILE = StringRegExpReplace ( $FILE , "/" , "\\" )
	$FILE = StringRegExpReplace ( $FILE , "\\\\(?!\?\\)" , "\\" )
	$FILE = StringRegExpReplace ( $FILE , "^(\\|\\\\)" , "" )
	$WINDIR = StringRegExpReplace ( @WindowsDir , "\\" , "\\\\" )
	$C = EnvGet ( "SystemDrive" )
	Select
	Case StringRegExp ( $FILE , "(?i)(^\s*|%+)(systemroot|windir|Windows)(|%+)\\" )
		$FILE = StringRegExpReplace ( $FILE , "(?i)(\s*|%+)(systemroot|windir|Windows)(|%+)\\" , $WINDIR & "\\" )
	Case StringRegExp ( $FILE , "(?i)%+Programfiles%+" )
		$PROGRAMFILES = StringRegExpReplace ( @ProgramFilesDir , "\\" , "\\\\" )
		$PROGRAMFILES = StringRegExpReplace ( $PROGRAMFILES , " \(x86\)" , "" )
		$FILE = StringRegExpReplace ( $FILE , "(?i).*%+Programfiles%+" , $PROGRAMFILES )
	Case StringRegExp ( $FILE , "(?i)%+ProgramFiles\(x86\)%+" )
		$FILE = StringRegExpReplace ( $FILE , "(?i)%+ProgramFiles\(x86\)%+" , $C & "\\Program Files \(x86\)" )
	Case StringRegExp ( $FILE , "(?i)%+ProgramData%+" )
		$FILE = StringRegExpReplace ( $FILE , "(?i)%+ProgramData%+" , $C & "\\ProgramData" )
	Case StringRegExp ( $FILE , "(?i)\ASysWow64" )
		$FILE = StringRegExpReplace ( $FILE , "(?i)\ASysWow64" , $C & "\\Windows\\SysWow64" )
	Case StringRegExp ( $FILE , "(?i)\Asystem32" )
		$FILE = StringRegExpReplace ( $FILE , "(?i)\Asystem32" , $WINDIR & "\\System32" )
	Case StringRegExp ( $FILE , "%[^\\]+?%" )
		$FILE = _EXPAND ( $FILE )
	EndSelect
	If Not FileExists ( $FILE ) Then
		$FILE = StringRegExpReplace ( $FILE , "(?i).*([C-Z]:\\.+?\.exe).*" , "$1" )
		$FILE = StringRegExpReplace ( $FILE , "(?i).*([C-Z]:\\.+\.\w{3,4}).*" , "$1" )
	EndIf
	If @OSArch = "X64" Then $FILE = StringRegExpReplace ( $FILE , "(?i)System32" , "SysNative" )
EndFunc
Func CHECKFILE ( $FILE1 )
	$FILE = $FILE1
	AAAAFP ( )
	If Not FileExists ( $FILE ) Then
		$FILE1 = StringRegExpReplace ( $FILE1 , "(?i)SysNative" , "System32" )
		FileWrite ( "FSS.txt" , @CRLF & "ATTENTION!=====> " & $FILE1 & " FILE IS MISSING." & @CRLF & @CRLF )
	Else
		If $CRYPT = 1 And _CHECKSIG ( $FILE ) = "true" Then
			$FILE = StringRegExpReplace ( $FILE , "(?i)SysNative" , "System32" )
			FileWrite ( "FSS.txt" , $FILE & " => File is digitally signed" & @CRLF )
		Else
			SYSTEMFILE ( $FILE )
		EndIf
	EndIf
EndFunc
Func _EXPAND ( $PATH )
	$DIR = StringRegExpReplace ( $PATH , "%([^\\]+)%.*" , "$1" )
	$DIR = StringRegExpReplace ( EnvGet ( $DIR ) , "\\" , "\\\\" )
	Return StringRegExpReplace ( $PATH , "%.+?%" , $DIR )
EndFunc
Func RPCSS ( )
	If FileExists ( @TempDir & "\tmp00" ) Then FileDelete ( @TempDir & "\tmp00" )
	RunWait ( @ComSpec & " /c " & "sc query rpcss >""" & @TempDir & "\tmp00""" , "" , @SW_HIDE )
	$RPCSS = FileRead ( @TempDir & "\tmp00" )
	If StringInStr ( $RPCSS , "R" ) Then
		$RUN = "R"
	EndIf
	FileDelete ( @TempDir & "\tmp00" )
EndFunc
Func HEADING ( )
	Local $BOOT , $VAL , $CDATE , $ADMIN
	$PROGRESS = GUICtrlCreateProgress ( 25 , 302 , 310 , 18 , 8 , 8192 )
	GUICtrlSetData ( $LABEL , "Checking services ..." )
	GUICtrlSendMsg ( $PROGRESS , 1034 , 1 , 50 )
	GUICtrlSetData ( $BUTTONSCAN , "Scanning ..." )
	If FileExists ( "FSS.txt" ) Then FileDelete ( "FSS.txt" )
	OS ( )
	If $OSV = "" Then
		Switch @OSVersion
		Case "WIN_11"
			$OSV = "Windows 11"
		Case "WIN_10"
			$OSV = "Windows 10"
		Case "WIN_7"
			$OSV = "Windows 7"
		Case "WIN_8"
			$OSV = "Windows 8"
		Case "WIN_81"
			$OSV = "Windows 8.1"
		Case "WIN_XP"
			$OSV = "Windows XP"
		Case "WIN_VISTA"
			$OSV = "Windows Vista"
	Case Else
			$OSV = @OSVersion
		EndSwitch
	EndIf
	If $OSV = "" Then $OSV = RegRead ( "HKLM64\software\Microsoft\Windows NT\CurrentVersion" , "ProductName" )
	If $OSV = "" Then
		MsgBox ( 262144 , "Farbar Service Scanner" , "Warning: The tool could not obtain the Windows version." & @CRLF & @CRLF & "The result of this scan is not valid" )
		$OSV = "Warning: The tool could not obtain the Windows version." & @CRLF & "Warning: The result of this scan is not valid" & @CRLF
	EndIf
	$VAL = RegRead ( "HKLM64\system\currentcontrolset\control\safeboot\option" , "OptionValue" )
	Select
	Case @error = 1
		$BOOT = "Normal"
	Case @error = 0
		If $VAL = 1 Then $BOOT = "Minimal"
		If $VAL = 2 Then $BOOT = "Network"
	EndSelect
	$CDATE = @MDAY & "-" & @MON & "-" & @YEAR & " at " & @HOUR & ":" & @MIN & ":" & @SEC
	If IsAdmin ( ) Then
		$ADMIN = " (administrator)"
	Else
		$ADMIN = " (ATTENTION: The logged in user is not administrator)"
	EndIf
	$OS = ""
	If @OSServicePack Then $OS = " " & @OSServicePack
	FileWrite ( "FSS.txt" , "Farbar Service Scanner" & $VERSION & @CRLF & "Ran by " & @UserName & $ADMIN & " on " & $CDATE & @CRLF & "Running from """ & @ScriptDir & """" & @CRLF & $OSV & $OS & " (" & @OSArch & ")" & @CRLF & "Boot Mode: " & $BOOT & @CRLF & "****************************************************************" & @CRLF & @CRLF )
EndFunc
Func OS ( )
	Local $OBJWMISERVICE , $DEVCOLITEMS
	$OSV = ""
	If _SRVSTAT ( "winmgmt" ) <> "R" Then Return ""
	$OBJWMISERVICE = ObjGet ( "winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2" )
	If Not IsObj ( $OBJWMISERVICE ) Then Return ""
	$DEVCOLITEMS = $OBJWMISERVICE .ExecQuery ( "Select * from Win32_OperatingSystem" )
	If Not IsObj ( $DEVCOLITEMS ) Then Return ""
	For $OBJECT In $DEVCOLITEMS
		If ( $OBJECT .caption ) Then $OSV = $OBJECT .caption
	Next
EndFunc
Func STARTTYPE ( ByRef $START )
	If $START = 0 Then $START = "Boot"
	If $START = 1 Then $START = "System"
	If $START = 2 Then $START = "Auto"
	If $START = 3 Then $START = "Demand"
	If $START = 4 Then $START = "Disabled"
	If $DEFS1 = 0 Then $DEFS1 = "Boot"
	If $DEFS1 = 1 Then $DEFS1 = "System"
	If $DEFS1 = 2 Then $DEFS1 = "Auto"
	If $DEFS1 = 3 Then $DEFS1 = "Demand"
	If $DEFS2 = 0 Then $DEFS2 = "Boot"
	If $DEFS2 = 1 Then $DEFS2 = "System"
	If $DEFS2 = 2 Then $DEFS2 = "Auto"
	If $DEFS2 = 3 Then $DEFS2 = "Demand"
EndFunc
Func SYSTEMFILE ( $SFILE )
	Local $DATECR , $DATEMO
	$FILEATTRIBUTES = FileGetAttrib ( $SFILE )
	$ATT = StringFormat ( "%05s" , $FILEATTRIBUTES )
	$ATTS = StringRegExpReplace ( $ATT , "0" , "_" )
	$SIZE = FileGetSize ( $SFILE )
	$SIZES = StringFormat ( "%07u" , $SIZE )
	$DATEC = FileGetTime ( $SFILE , 1 )
	If Not @error Then $DATECR = $DATEC [ 0 ] & "-" & $DATEC [ 1 ] & "-" & $DATEC [ 2 ] & " " & $DATEC [ 3 ] & ":" & $DATEC [ 4 ]
	$DATEM = FileGetTime ( $SFILE , 0 )
	If Not @error Then $DATEMO = $DATEM [ 0 ] & "-" & $DATEM [ 1 ] & "-" & $DATEM [ 2 ] & " " & $DATEM [ 3 ] & ":" & $DATEM [ 4 ]
	$VER = FileGetVersion ( $SFILE , "CompanyName" )
	$SFILE = StringRegExpReplace ( $SFILE , "(?i)SysNative" , "System32" )
	$LAB = FileWrite ( "FSS.txt" , $SFILE & @CRLF & "[" & $DATECR & "] - [" & $DATEMO & "] - " & $SIZES & " " & $ATTS & " (" & $VER & ") " & $HASH & @CRLF & @CRLF )
	If Not StringInStr ( $VER , "Microsoft" ) Then FileWrite ( "FSS.txt" , "ATTENTION!=====> " & $SFILE & " IS INFECTED." & @CRLF & @CRLF )
EndFunc
Func SEARCHBUTT ( )
	GUICtrlSetData ( $LABEL , "Search is in progress, please wait..." )
	GUICtrlSetData ( $BUTTONSEARCH , "Searching ..." )
	$PROGRESS = GUICtrlCreateProgress ( 25 , 302 , 310 , 18 , 8 , 8192 )
	GUICtrlSendMsg ( $PROGRESS , 1034 , 1 , 50 )
	If FileExists ( "FSS.txt" ) Then FileDelete ( "FSS.txt" )
	If FileExists ( "file.txt" ) Then FileDelete ( "file.txt" )
	FILESEARCH ( )
	Sleep ( 1000 )
	GUICtrlDelete ( $PROGRESS )
	GUICtrlSetData ( $LABEL , "Search is completed." )
	GUICtrlSetData ( $BUTTONSEARCH , "Search Files" )
	Run ( "notepad FSS.txt" )
	GUICtrlSetData ( $LABEL , "" )
EndFunc
Func MD5 ( $SFILE )
	Local $ITERATIONS , $PERCENT_MD5
	Local $FILEHANDLE = FileOpen ( $SFILE , 16 )
	Local $BUFFERSIZE = 33554432 , $FINAL = 0 , $HASH = ""
	$ITERATIONS = Ceiling ( FileGetSize ( $SFILE ) / $BUFFERSIZE )
	For $I = 1 To $ITERATIONS
		If $I = $ITERATIONS Then $FINAL = 1
		$HASH = _CRYPT_HASHDATA ( FileRead ( $FILEHANDLE , $BUFFERSIZE ) , $CALG_MD5 , $FINAL , $HASH )
		$PERCENT_MD5 = Round ( 100 * $I / $ITERATIONS )
		ProgressSet ( $PERCENT_MD5 , $PERCENT_MD5 & " %" )
	Next
	FileClose ( $FILEHANDLE )
	ProgressSet ( 100 , "100%" , "File hashed" )
	ProgressOff ( )
	Return StringTrimLeft ( $HASH , 2 )
EndFunc
Func FILESEARCH ( )
	Local $CDATE , $ADMIN , $FOLDER , $AARRAY , $SYSNATIVE , $VAL , $DELSYSTEM32
	$VAL = StringRegExpReplace ( $FIX , "(?i)[ ]*(.+)" , "$1" )
	$VAL = StringRegExpReplace ( $VAL , @CRLF , "" )
	$VAL = StringRegExpReplace ( $VAL , @CRLF , "" )
	OS ( )
	$CDATE = @MDAY & "-" & @MON & "-" & @YEAR & " at " & @HOUR & ":" & @MIN & ":" & @SEC
	If IsAdmin ( ) Then
		$ADMIN = " (administrator)"
	Else
		$ADMIN = ""
	EndIf
	$OS = ""
	If @OSServicePack Then $OS = " " & @OSServicePack
	FileWrite ( "FSS.txt" , "Farbar Service Scanner" & $VERSION & @CRLF & "Ran by " & @UserName & $ADMIN & " on " & $CDATE & @CRLF & $OSV & $OS & " (" & @OSArch & ")" & @CRLF & @CRLF & "************************************************" & @CRLF & "======== Search: """ & $VAL & """ =========" & @CRLF & @CRLF )
	$FOLDER = $SYSTEMDRIVE
	$AARRAY = _FILELISTTOARRAYREC ( $FOLDER , $VAL , 1 , 1 , 0 , 2 )
	If Not StringInStr ( @OSArch , "X64" ) Then
		If FileExists ( @TempDir & "\file.txt" ) Then FileDelete ( @TempDir & "\file.txt" )
		_FILEWRITEFROMARRAY ( @TempDir & "\file.txt" , $AARRAY , 1 )
	Else
		If FileExists ( @TempDir & "\temp0" ) Then FileDelete ( @TempDir & "\temp0" )
		_FILEWRITEFROMARRAY ( @TempDir & "\temp0" , $AARRAY , 1 )
		If FileExists ( @TempDir & "\temp00" ) Then FileDelete ( @TempDir & "\temp00" )
		$FOLDER = @WindowsDir & "\SysNative"
		$AARRAY = _FILELISTTOARRAYREC ( $FOLDER , $VAL , 1 , 1 , 0 , 2 )
		_FILEWRITEFROMARRAY ( @TempDir & "\temp00" , $AARRAY , 1 )
		$SYSNATIVE = FileRead ( @TempDir & "\temp00" )
		$DELSYSTEM32 = FileRead ( @TempDir & "\temp0" )
		$DELSYSTEM32 = StringRegExpReplace ( $DELSYSTEM32 , "(?i).+\\system32\\.+\v{2}" , "" )
		FileWrite ( @TempDir & "\file.txt" , $SYSNATIVE )
		FileWrite ( @TempDir & "\file.txt" , $DELSYSTEM32 )
	EndIf
	Local $I = 1
	While 1
		Local $FILEATTRIBUTES , $ATT , $ATTS , $SIZE , $SIZES , $DATEC , $DATEM , $DATECR , $DATEMO , $VER , $LAB
		$FILE = FileReadLine ( @TempDir & "\file.txt" , $I )
		If @error <> 0 Then ExitLoop
		$FILEATTRIBUTES = FileGetAttrib ( $FILE )
		$ATT = StringFormat ( "%05s" , $FILEATTRIBUTES )
		$ATTS = StringRegExpReplace ( $ATT , "0" , "_" )
		$SIZE = FileGetSize ( $FILE )
		$SIZES = StringFormat ( "%07u" , $SIZE )
		$HASH = MD5 ( $FILE )
		If $HASH = "" Then $HASH = MD5 ( $FILE )
		$DATEC = FileGetTime ( $FILE , 1 )
		If Not @error Then $DATECR = $DATEC [ 0 ] & "-" & $DATEC [ 1 ] & "-" & $DATEC [ 2 ] & " " & $DATEC [ 3 ] & ":" & $DATEC [ 4 ]
		$DATEM = FileGetTime ( $FILE , 0 )
		If Not @error Then $DATEMO = $DATEM [ 0 ] & "-" & $DATEM [ 1 ] & "-" & $DATEM [ 2 ] & " " & $DATEM [ 3 ] & ":" & $DATEM [ 4 ]
		$VER = FileGetVersion ( $FILE , "CompanyName" )
		$FILE = StringRegExpReplace ( $FILE , "(?i)\\SysNative\\" , "\\System32\\" )
		$LAB = FileWrite ( "FSS.txt" , $FILE & @CRLF & "[" & $DATECR & "] - [" & $DATEMO & "] - " & $SIZES & " " & $ATTS & " (" & $VER & ") " & $HASH & @CRLF & @CRLF )
		$I = $I + 1
	WEnd
	FileWrite ( "FSS.txt" , "====== End Of Search ======" )
	FileDelete ( @TempDir & "\file.txt" )
	FileDelete ( @TempDir & "\temp00" )
EndFunc
Func _CHECKSIG ( $FILEPATH )
	Local $PCONTEXT
	Local $CONTEXT = DllCall ( "Wintrust.dll" , "BOOL" , "CryptCATAdminAcquireContext" , "ptr*" , $PCONTEXT , "ptr" , 0 , "DWORD" , 0 )
	If @error Or Not $CONTEXT [ 0 ] Then Return SetError ( 1 , 0 , "CryptCATAdminAcquireContext failed to return pContext" )
	$CONTEXT = $CONTEXT [ 1 ]
	Local $A_HCALL = DllCall ( "kernel32.dll" , "hwnd" , "CreateFileW" , "wstr" , $FILEPATH , "dword" , 2147483648 , "dword" , 1 , "ptr" , 0 , "dword" , 3 , "dword" , 0 , "ptr" , 0 )
	If @error Or $A_HCALL [ 0 ] = + 4294967295 Then
		_RELEASECONTEXT ( $CONTEXT )
		SetError ( 2 , 0 , "CreateFileW function failed" )
	EndIf
	Local $HFILE = $A_HCALL [ 0 ]
	Local $CBHASH = 0
	$CBHASH = DllCall ( "Wintrust.dll" , "BOOL" , "CryptCATAdminCalcHashFromFileHandle" , "handle" , $HFILE , "DWORD*" , $CBHASH , "ptr" , 0 , "dword" , 0 )
	If @error Or Not $CBHASH [ 0 ] Then
		_RELEASECONTEXT ( $CONTEXT )
		_CLOSEHANDLE ( $HFILE )
		SetError ( 3 , 0 , "CryptCATAdminCalcHashFromFileHandle failed to return cbHash" )
	EndIf
	$CBHASH = $CBHASH [ 2 ]
	Local $BUFFER = DllStructCreate ( "BYTE[" & $CBHASH & "]" )
	Local $PBHASH = DllStructGetPtr ( $BUFFER , 1 )
	$CBHASH = DllCall ( "Wintrust.dll" , "BOOL" , "CryptCATAdminCalcHashFromFileHandle" , "handle" , $HFILE , "DWORD*" , $CBHASH , "ptr" , $PBHASH , "DWORD" , 0 )
	If @error Or Not $CBHASH [ 0 ] Then
		_RELEASECONTEXT ( $CONTEXT )
		_CLOSEHANDLE ( $HFILE )
		SetError ( 4 , 0 , "CryptCATAdminCalcHashFromFileHandle failed to return cbHash, #2" )
	EndIf
	$CBHASH = $CBHASH [ 2 ]
	_CLOSEHANDLE ( $HFILE )
	Local $CATALOGCONTEXT = DllCall ( "Wintrust.dll" , "handle" , "CryptCATAdminEnumCatalogFromHash" , "handle" , $CONTEXT , "ptr" , $PBHASH , "DWORD" , $CBHASH , "DWORD" , 0 , "handle" , 0 )
	If @error Or Not $CATALOGCONTEXT [ 0 ] Then
		_RELEASECONTEXT ( $CONTEXT )
		_CLOSEHANDLE ( $HFILE )
		SetError ( 5 , 0 , "CryptCATAdminEnumCatalogFromHash failed to return HCATINFO" )
	EndIf
	$CATALOGCONTEXT = $CATALOGCONTEXT [ 0 ]
	Local $TAGCATALOG_INFO = "DWORD cbStruct;" & "WCHAR wszCatalogFile[260];"
	Local $CATALOG_INFO = DllStructCreate ( $TAGCATALOG_INFO )
	DllStructSetData ( $CATALOG_INFO , "cbStruct" , DllStructGetSize ( $CATALOG_INFO ) )
	Local $PINFOSTRUCT = DllStructGetPtr ( $CATALOG_INFO )
	Local $RET = DllCall ( "Wintrust.dll" , "BOOL" , "CryptCATCatalogInfoFromContext" , "handle" , $CATALOGCONTEXT , "ptr" , $PINFOSTRUCT , "DWORD" , 0 )
	If @error Or Not $RET [ 0 ] Or Not DllStructGetData ( $CATALOG_INFO , 2 ) Then
		_RELEASECONTEXT ( $CATALOGCONTEXT )
		$CATALOGCONTEXT = 0
		$SIGNED = False
		$RET = _WINVERIFYTRUST ( $FILEPATH )
		If @error Then SetError ( 8 , 0 , "Error verfying file signature." )
		If $RET = $ERROR_SUCCESS Then $SIGNED = True
		Return $SIGNED
	Else
		$CATPATH = DllStructGetData ( $CATALOG_INFO , 2 )
		$CATMEMBERTAG = DllStructGetData ( $BUFFER , 1 )
		$CATMEMBERTAG = StringTrimLeft ( $CATMEMBERTAG , 2 )
		$SIGNED = False
		$RET = _WINVERIFYTRUST ( $FILEPATH , $CATPATH , $CATMEMBERTAG )
		If @error Then SetError ( 9 , 0 , "Error verfying file signature:" & @error )
		If $RET = $ERROR_SUCCESS Then $SIGNED = True
		_CLOSEHANDLE ( $HFILE )
		_RELEASECONTEXT ( $CONTEXT )
		Return $SIGNED
	EndIf
EndFunc
Func _CLOSEHANDLE ( $HANDLE )
	Local $ARESULT = DllCall ( "kernel32.dll" , "bool" , "CloseHandle" , "handle" , $HANDLE )
EndFunc
Func _RELEASECONTEXT ( $CON )
	DllCall ( "Wintrust.dll" , "BOOL" , "CryptCATAdminReleaseContext" , "HANDLE" , $CON , "DWORD" , 0 )
EndFunc

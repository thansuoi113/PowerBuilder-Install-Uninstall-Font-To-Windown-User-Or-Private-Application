$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_choosefont from commandbutton within w_main
end type
type st_2 from statictext within w_main
end type
type cb_2 from commandbutton within w_main
end type
type cb_1 from commandbutton within w_main
end type
type cb_3 from commandbutton within w_main
end type
type st_1 from statictext within w_main
end type
type sle_font from singlelineedit within w_main
end type
type cb_remove from commandbutton within w_main
end type
type cb_add from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 2423
integer height = 828
boolean titlebar = true
string title = "Add/Remove Font"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_choosefont cb_choosefont
st_2 st_2
cb_2 cb_2
cb_1 cb_1
cb_3 cb_3
st_1 st_1
sle_font sle_font
cb_remove cb_remove
cb_add cb_add
end type
global w_main w_main

type prototypes
Function Long AddFontResourceExW( Readonly String as_FontFile, ULong aul_FontCharacteristics, ULong aul_Reserved ) Library "GDI32.dll" Alias For "AddFontResourceExW"
Function Boolean RemoveFontResourceExW( Readonly String as_FonfFile, ULong aul_FontCharacteristics, ULong aul_Reserved ) Library "GDI32.dll" Alias For "RemoveFontResourceExW"

Function Int AddFontResourceA(String lpFileName) Library "gdi32.dll"
Function Int AddFontResourceW(String lpFileName) Library "gdi32.dll"
Function Int RemoveFontResourceA(String lpFileName) Library "gdi32.dll"
Function Int RemoveFontResourceW(String lpFileName) Library "gdi32.dll"


Function Boolean ChooseFontA ( Ref str_choosefont c ) Library 'comdlg32.dll' Alias For "ChooseFontA;Ansi"
Subroutine copymemory ( Ref str_logfont d, Long s, Long l ) Library 'kernel32.dll' Alias For "RtlMoveMemory;Ansi"
Subroutine copymemory ( Long d, str_logfont s, Long l ) Library 'kernel32.dll' Alias For "RtlMoveMemory;Ansi"
Function ULong GlobalAlloc(ULong uFlags, Long dwBytes ) Library 'kernel32.dll'
Function ULong GlobalLock(ULong hMem ) Library 'kernel32.dll'
Function ULong GlobalUnlock(ULong hMem ) Library 'kernel32.dll'
Function ULong GlobalFree(ULong hMem ) Library 'kernel32.dll'
Function ULong GetDC(ULong hwnd) Library 'user32.dll'
Function Long GetDeviceCaps(ULong hdc, Long nindex) Library 'gdi32.dll'
Function Long MulDiv ( Long l1,Long l2, Long d1) Library 'kernel32.dll'

end prototypes

type variables
String is_app
Constant Long FR_PRIVATE = 16
Constant Long FR_NOT_ENUM = 32
str_choosefont istr_choosefont
str_logfont istr_logfont

end variables

on w_main.create
this.cb_choosefont=create cb_choosefont
this.st_2=create st_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_3=create cb_3
this.st_1=create st_1
this.sle_font=create sle_font
this.cb_remove=create cb_remove
this.cb_add=create cb_add
this.Control[]={this.cb_choosefont,&
this.st_2,&
this.cb_2,&
this.cb_1,&
this.cb_3,&
this.st_1,&
this.sle_font,&
this.cb_remove,&
this.cb_add}
end on

on w_main.destroy
destroy(this.cb_choosefont)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.sle_font)
destroy(this.cb_remove)
destroy(this.cb_add)
end on

event open;is_app = GetCurrentDirectory ( )
end event

type cb_choosefont from commandbutton within w_main
integer x = 73
integer y = 320
integer width = 485
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Choose Font"
end type

event clicked;Integer 	CF_SCREENFONTS        	 = 1
Integer 	CF_INITTOLOGFONTSTRUCT   = 64
Integer 	CF_EFFECTS               = 256

Long 		ll_LogFont

/* allocate memory for the font information and lock it */

ll_LogFont = GlobalAlloc ( 2, 60 )

If ll_LogFont = 0 Then
	MessageBox('MemError','Unable to alloc memory')
	Return -1
End If

ll_LogFont = GlobalLock ( ll_LogFont )

If ll_LogFont = 0 Then
	MessageBox('MemError','Unable to lock memory')
	Return -1
End If


/* copy the structure to the fontplace in memory */

copymemory ( ll_LogFont, istr_Logfont, 60 )


/* assign the pointer to the fontinfo in memory to the dialog font */

istr_ChooseFont.lplogfont = ll_LogFont

istr_ChooseFont.lstructsize 	 = 60 // size
istr_ChooseFont.hwndowner 		 = Handle(Parent)
istr_ChooseFont.flags 			 = CF_SCREENFONTS+CF_INITTOLOGFONTSTRUCT+CF_EFFECTS


If Not ChooseFontA(istr_ChooseFont) Then
	
	/* release the used memory */
	GlobalUnlock ( ll_LogFont )
	GlobalFree ( ll_LogFont )
	
	MessageBox('ChooseFont','Failed')
	
	Return -1
	
End If

/* copy the pointer to the taglogfont again */

copymemory ( istr_Logfont, istr_ChooseFont.lplogfont, 60 )

/* release the used memory */

GlobalUnlock ( ll_LogFont )
GlobalFree ( ll_LogFont )

/* Display the choose fontname and the size */

st_2.TextSize 	 = -istr_ChooseFont.iPointSize/10
st_2.Weight 	 = istr_Logfont.lfWeight
st_2.Underline = ( istr_Logfont.lfUnderline <> CharA(0) )
st_2.Italic		 = ( istr_Logfont.lfItalic <> CharA(0) )
st_2.FaceName	 = istr_Logfont.lffacename
st_2.TextColor	 = istr_ChooseFont.rgbColors

Return 1

end event

type st_2 from statictext within w_main
integer x = 110
integer y = 480
integer width = 1842
integer height = 128
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
string facename = "Libre Barcode 128 Text"
long textcolor = 33554432
long backcolor = 67108864
string text = "https://programmingmethodsit.com/"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_main
integer x = 1792
integer y = 192
integer width = 535
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "User Remove Font"
end type

event clicked;String ls_font
Long    ll_rc, ll_row

ls_font = sle_font.Text
If ls_font = "" Then Return
If Not FileExists(ls_font) Then
	MessageBox("Warning","Font Not Exits" )
	Return
End If

ll_rc = RemoveFontResourceW(ls_font)
If ll_rc <> 1 Then
	MessageBox("Warning","Remove Font Error" + String(ll_rc) )
End If

st_2.setredraw( true)
st_2.facename = "Libre Barcode 128 Text"
st_2.setredraw( false)

end event

type cb_1 from commandbutton within w_main
integer x = 1353
integer y = 192
integer width = 425
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "User Add Font"
end type

event clicked;String ls_font
Long    ll_rc, ll_row

ls_font = sle_font.Text
If ls_font = "" Then Return
If Not FileExists(ls_font) Then
	MessageBox("Warning","Font Not Exits" )
	Return
End If

ll_rc = AddFontResourceW(ls_font)
If ll_rc <> 1 Then
	MessageBox("Warning","Add Font Error" + String(ll_rc) )
End If


st_2.setredraw( true)
st_2.facename = "Libre Barcode 128 Text"
st_2.setredraw( false)

end event

type cb_3 from commandbutton within w_main
integer x = 2194
integer y = 64
integer width = 110
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "..."
end type

event clicked;String ls_file, ls_file_name
GetFileOpenName("Select Font File", ls_file, ls_file_name, ".TTF","Font Files, *.TTF")
If Not FileExists(ls_file_name) Then
	// ERROR CONDITION
	MessageBox("Font File Not Found","Cannot find Font File: "+ ls_file_name)
	Return -1
Else
	sle_font.Text = ls_file
End If



end event

type st_1 from statictext within w_main
integer x = 37
integer y = 64
integer width = 219
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fonts:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_font from singlelineedit within w_main
integer x = 256
integer y = 64
integer width = 1938
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_remove from commandbutton within w_main
integer x = 585
integer y = 192
integer width = 594
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Private Remove Font"
end type

event clicked;String ls_font
Long ll_row
Boolean lb_rc

ls_font = sle_font.Text
If ls_font = "" Then Return
If Not FileExists(ls_font) Then
	MessageBox("Warning","Font Not Exits" )
	Return
End If

lb_rc = RemoveFontResourceExW(ls_font ,FR_PRIVATE + FR_NOT_ENUM,0)
If Not lb_rc Then
	MessageBox("Warning","Remove Font Error" )
End If 

st_2.setredraw( true)
st_2.facename = "Libre Barcode 128 Text"
st_2.setredraw( false)


end event

type cb_add from commandbutton within w_main
integer x = 73
integer y = 192
integer width = 485
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Private Add Font"
end type

event clicked;String ls_font
Long    ll_rc, ll_row

ls_font = sle_font.Text
If ls_font = "" Then Return
If Not FileExists(ls_font) Then
	MessageBox("Warning","Font Not Exits" )
	Return
End If

ll_rc = AddFontResourceExW(ls_font ,FR_PRIVATE + FR_NOT_ENUM,0)
If ll_rc <> 1 Then
	MessageBox("Warning","Add Font Error" + String(ll_rc) )
End If


st_2.setredraw( true)
st_2.facename = "Libre Barcode 128 Text"
st_2.setredraw( false)

end event


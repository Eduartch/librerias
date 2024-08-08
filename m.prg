declare integer GetMenu in user32 integer hwnd
declare integer CreateSolidBrush in gdi32 integer crColor
declare integer DrawMenuBar in user32 integer hwnd
declare integer SetMenuInfo in user32 integer hmenu, string @mi

**** ****
*menuinfo_styles * menuinfo_styles
mns_nocheck = 0x80000000
mns_nocheck = 0x80000000
mns_modeless = 0x40000000
mns_modeless = 0x40000000
mns_dragdrop = 0x20000000
mns_dragdrop = 0x20000000
mns_autodismiss = 0x10000000
mns_autodismiss = 0x10000000
mns_notifybypos = 0x8000000
mns_notifybypos = 0x8000000
mns_checkorbmp =0x4000000
mns_checkorbmp = 0x4000000

mim_maxheight = 0x1
mim_maxheight = 0x1
mim_background = 0x2
mim_background = 0x2
mim_helpid = 0x4
mim_helpid = 0x4
mim_menudata = 0x8
mim_menudata = 0x8
mim_style = 0x10
mim_style = 0x10
mim_applytosubmenus = 0x80000000
mim_applytosubmenus = 0x80000000
**** ****
*Private Type MENUINFO * Private Type MENUINFO
* cbSize As Long * CbSize As Long
* fMask As Long * FMask As Long
* dwStyle As Long * DwStyle As Long
* cyMax As Long * CyMax As Long
* hbrBack As Long * HbrBack As Long
* dwContextHelpID As Long * DwContextHelpID As Long
* dwMenuData As Long * DwMenuData As Long
*End Type * End Type
uc_hwnd=_vfp.hwnd &&uc_hwnd = _vfp.HWnd
uc_menuh=GetMenu(uc_hwnd) &&uc_menuh = getmenu (uc_hwnd)
*Messagebox(Padl("Thisform.hwnd=",20," ")+Ltrim(Str(getactivewindow()))
*+Chr(13)+Padl("_Screen.hwnd=",20," ")+Ltrim(Str(_Screen.HWnd))
*+Chr(13)+Padl("_Vfp.hwnd=",20," ")+Ltrim(Str(_vfp.HWnd))
*+Chr(13)+Chr(13)+Padl("Thisform.menuh=",20," ")
*+Ltrim(Str(getmenu(Thisform.HWnd)))+Chr(13)+Padl("_Screen.menuh=",20,"
*")+Ltrim(Str(getmenu(_Screen.HWnd)))+Chr(13)+Padl("_Vfp.menuh=",20," ")
*+Ltrim(Str(uc_menuh))) * Messagebox (Padl ( "Thisform.hwnd =", 20, "")
*+ Ltrim (Str (getactivewindow ()))+ Chr (13) + Padl ( "_Screen.hwnd
*=", 20, "") + Ltrim ( Str (_Screen.HWnd)) + Chr (13) + Padl
*( "_Vfp.hwnd =", 20, "") + Ltrim (Str (_vfp.HWnd)) + Chr (13) + Chr
*(13) + Padl ( "Thisform.menuh =", 20, "") + Ltrim (Str (getmenu
*(Thisform.HWnd))) + Chr (13) + Padl ( "_Screen.menuh =", 20, "") +
*Ltrim (Str ( getmenu (_Screen.HWnd))) + Chr (13) + Padl ( "_Vfp.menuh
*=", 20, "") + Ltrim (Str (uc_menuh)))
uc_fmask=mim_background &&+mim_applytosubmenus uc_fmask =mim_background && + mim_applytosubmenus
uc_dwstyle=mns_nocheck
uc_cymax=0
uc_hbrback=CreateSolidBrush(rgb(204,190,190)) &&-????????? uc_hbrback
= createsolidbrush (Rgb (255,0,120)) && - the act of setting thebackground color
uc_dwcontexthelpid=0
uc_dwmenudata=0
uc_len = 28
menuinfo = num2dword(uc_len) + num2dword(uc_fmask) + num2dword(uc_dwstyle) + num2dword(uc_cymax) +num2dword(uc_hbrback) + num2dword (uc_dwcontexthelpid) + num2dword (uc_dwmenudata)

=SetMenuInfo(uc_menuh,@menuinfo)
=DrawMenuBar(uc_hwnd)

function num2dword(lnvalue)
#define m0 0x0000100 &&# Define m0 0x0000100
#define m1 0x0010000 &&# Define m1 0x0010000
#define m2 0x1000000 &&# Define m2 0x1000000
if lnvalue < 0 &&If lnvalue <0
lnvalue = 0x100000000 + lnvalue &&€lnvalue = 0x100000000 + lnvalue
endif endif
local b0, b1, b2, b3
b3 = int(lnvalue/m2)
b2 = int((lnvalue - b3*m2)/m1)
b1 = int((lnvalue - b3*m2 - b2*m1)/m0)
b0 = mod(lnvalue, m0)
return chr(b0)+chr(b1)+chr(b2)+chr(b3)
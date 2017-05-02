; #FUNCTION# ====================================================================================================================
; Name ..........: MBR GUI Design
; Description ...: This file creates the "Attack" tab under the "Options" tab under the "Search & Attack" tab under the "Attack Plan" tab
; Syntax ........:
; Parameters ....: None
; Return values .: None
; Author ........:
; Modified ......: CodeSlinger69 (2017), MonkeyHunter (03-2017)
; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2017
;                  MyBot is distributed under the terms of the GNU GPL
; Related .......:
; Link ..........: https://github.com/MyBotRun/MyBot/wiki
; Example .......: No
; ===============================================================================================================================
#include-once

; Hero abilities
Global $g_hRadAutoAbilities = 0, $g_hRadManAbilities = 0, $g_hTxtManAbilities = 0, $g_hChkUseWardenAbility = 0, $g_hTxtWardenAbility = 0

; Attack schedule
Global $g_hChkAttackPlannerEnable = 0, $g_hChkAttackPlannerCloseCoC = 0, $g_hChkAttackPlannerCloseAll = 0, $g_hChkAttackPlannerSuspendComputer = 0, $g_hChkAttackPlannerRandom = 0, _
	   $g_hCmbAttackPlannerRandom = 0, $g_hChkAttackPlannerDayLimit = 0, $g_hCmbAttackPlannerDayMin = 0, $g_hCmbAttackPlannerDayMax = 0
Global $g_ahChkAttackWeekdays[7] = [0,0,0,0,0,0,0], $g_ahChkAttackHours[24] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]

Global $g_hLbAttackPlannerRandom = 0, $g_hLbAttackPlannerDayLimit = 0, $g_ahChkAttackWeekdaysE = 0, $g_ahChkAttackHoursE1 = 0, $g_ahChkAttackHoursE2 = 0

; Clan castle
Global $g_hChkDropCCHoursEnable = 0, $g_ahChkDropCCHours[24] = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
GLobal $g_hLblDropCChour = 0, $g_ahLblDropCChoursE = 0
GLobal $g_hLblDropCChours[12] = [0,0,0,0,0,0,0,0,0,0,0,0]
Global $g_ahChkDropCCHoursE1 = 0, $g_ahChkDropCCHoursE2 = 0

Func CreateAttackSearchOptionsAttack()
$17 = GUICtrlCreatePic (@ScriptDir & "\Images\1.jpg", 2, 23, 442, 367, $WS_CLIPCHILDREN)

   Local $sTxtTip = ""
   Local $x = 25, $y = 45
	GUICtrlCreateGroup(GetTranslated(634,1, "Hero Abilities"), $x - 20, $y - 20, $g_iSizeWGrpTab4, 95)
		GUICtrlCreateIcon($g_sLibIconPath, $eIcnHeroes, $x, $y, 64, 64)

	   $x += 82
	   $y -= 4
		   $g_hRadAutoAbilities = GUICtrlCreateRadio(GetTranslated(634,2, "Auto activate (red zone)."), $x, $y - 4 , -1, -1)
		   $sTxtTip = GetTranslated(634,3, "Activate the Ability when the Hero becomes weak.") & @CRLF & GetTranslated(634,4, "Heroes are checked and activated individually.")
		   _GUICtrlSetTip(-1, $sTxtTip)
		   GUICtrlSetState(-1, $GUI_CHECKED)

	   $y += 15
		   $g_hRadManAbilities = GUICtrlCreateRadio(GetTranslated(634,5, "Timed after") & ":", $x , $y , -1, -1)
			   $sTxtTip = GetTranslated(634,6, "Activate the Ability on a timer.") & @CRLF & GetTranslated(634,7, "All Heroes are activated at the same time.")
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetState(-1, $GUI_UNCHECKED)

		   $g_hTxtManAbilities = GUICtrlCreateInput("9", $x + 80, $y + 3, 30, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			   $sTxtTip = GetTranslated(634,8, "Set the time in seconds for Timed Activation of Hero Abilities.")
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetLimit(-1, 2)
		   GUICtrlCreateLabel(GetTranslated(603,6, "sec."), $x + 115, $y + 4, -1, -1)

	  $y += 30
		   $g_hChkUseWardenAbility = GUICtrlCreateCheckbox(GetTranslated(634,9, "Forced activation of Warden Ability after") & ":", $x + 1, $y, -1, -1)
			   $sTxtTip = GetTranslated(634,10, "Force Eternal Tome ability of Grand Warden on a timer.")
			   _GUICtrlSetTip(-1, $sTxtTip)
				GUICtrlSetOnEvent(-1, "ChkUseWardenAbility")
		   $g_hTxtWardenAbility = GUICtrlCreateInput("10", $x + 230, $y + 2, 30, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			   $sTxtTip = GetTranslated(634,11, "Set the time in seconds for Timed Activation of Grand Warden Ability.")
			   _GUICtrlSetTip(-1, $sTxtTip)
			   GUICtrlSetLimit(-1, 2)
		   GUICtrlCreateLabel(GetTranslated(603,6, -1), $x + 263, $y + 4, -1, -1)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

    Local $x = 25, $y = 145
    GUICtrlCreateGroup(GetTranslated(634,20, "Attack Schedule"), $x - 20, $y - 20, $g_iSizeWGrpTab4, 138)
	$x -= 5
		$g_hChkAttackPlannerEnable = _GUICtrlCreateCheckbox(GetTranslated(634,21, "Enable Schedule"), $x, $y-5, -1, -1)
			_GUICtrlSetTip(-1, GetTranslated(634,22, "This option will allow you to schedule attack times") & @CRLF & _
							   GetTranslated(634,23, "Bot continues to run and will attack only when schedule allows"))
			GUICtrlSetOnEvent(-1, "chkAttackPlannerEnable")
		$g_hChkAttackPlannerCloseCoC = _GUICtrlCreateCheckbox(GetTranslated(634,24, "Close CoC"), $x, $y+14, -1, -1)
			_GUICtrlSetTip(-1, GetTranslated(634,25, "This option will close CoC app when not scheduled to Search & Attack!") & @CRLF & _
							   GetTranslated(634,26, "Bot Continues to run and will restart when schedule allows"))
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "chkAttackPlannerCloseCoC")
		$g_hChkAttackPlannerCloseAll = _GUICtrlCreateCheckbox(GetTranslated(634,27, "Close emulator"), $x, $y+33, -1, -1)
			_GUICtrlSetTip(-1, GetTranslated(634,28, "This option will close emulator when not scheduled to Search & Attack!") & @CRLF & _
							   GetTranslated(634,26, -1))
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "chkAttackPlannerCloseAll")
		$g_hChkAttackPlannerSuspendComputer = GUICtrlCreateCheckbox(GetTranslated(634,42, "Suspend Computer"), $x, $y+52, -1, -1)
			_GUICtrlSetTip(-1, GetTranslated(634,43, "This option will suspend computer when not scheduled to Search & Attack!") & @CRLF & _
							   GetTranslated(634,26, -1))
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "chkAttackPlannerSuspendComputer")
		$g_hChkAttackPlannerRandom = _GUICtrlCreateCheckbox(GetTranslated(634,29, "Random Disable"), $x, $y+71, -1, -1)
			_GUICtrlSetTip(-1, GetTranslated(634,30, "This option will randomly stop attacking") & @CRLF & _
							   GetTranslated(634,26, -1))
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "chkAttackPlannerRandom")
		$g_hCmbAttackPlannerRandom = GUICtrlCreateCombo("",  $x + 110 , $y+69, 37, 16, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
			_GUICtrlSetTip(-1, GetTranslated(634,31, "Select number of hours to stop attacking"))
			GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20", "4")
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "cmbAttackPlannerRandom")
		$g_hLbAttackPlannerRandom = GUICtrlCreateLabel(GetTranslated(603,37, "hrs"), $x+148, $y+73, -1,-1)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$g_hChkAttackPlannerDayLimit = _GUICtrlCreateCheckbox(GetTranslated(634,35, "Daily Limit"), $x, $y+90, -1, -1)
			_GUICtrlSetTip(-1, GetTranslated(634,36, "Will randomly stop attacking when exceed random number of attacks between range selected") & @CRLF & _
							   GetTranslated(634,26, -1))
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetOnEvent(-1, "chkAttackPlannerDayLimit")
		$g_hCmbAttackPlannerDayMin = GUICtrlCreateInput("12",  $x+100 , $y+92, 37, 18, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslated(634,37, "Enter minimum number of attacks allowed per day"))
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "cmbAttackPlannerDayMin")
		$g_hLbAttackPlannerDayLimit = GUICtrlCreateLabel(GetTranslated(634,39,"to"), $x+142, $y+94, -1,-1)
			GUICtrlSetState(-1, $GUI_DISABLE)
		$g_hCmbAttackPlannerDayMax = GUICtrlCreateInput("15",  $x+157 , $y+94, 37, 18,  BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_NUMBER))
			_GUICtrlSetTip(-1, GetTranslated(634,38, "Enter maximum number of attacks allowed per day"))
			GUICtrlSetState(-1, $GUI_DISABLE)
			GUICtrlSetLimit(-1, 3)
			GUICtrlSetOnEvent(-1, "cmbAttackPlannerDayMax")

	$x += 198
	$y -= 5
		GUICtrlCreateLabel(GetTranslated(603,36, "Day") & ":", $x, $y, -1, 15)
			_GUICtrlSetTip(-1, GetTranslated(603,31, "Only during these day of week"))
		GUICtrlCreateLabel(GetTranslated(603,16, "Su"), $x + 30, $y, -1, 15)
			_GUICtrlSetTip(-1, GetTranslated(603,17, "Sunday"))
		GUICtrlCreateLabel(GetTranslated(603,18, "Mo"), $x + 46, $y, -1, 15)
			_GUICtrlSetTip(-1, GetTranslated(603,19, "Monday"))
		GUICtrlCreateLabel(GetTranslated(603,20, "Tu"), $x + 63, $y, -1, 15)
			_GUICtrlSetTip(-1, GetTranslated(603,21, "Tuesday"))
		GUICtrlCreateLabel(GetTranslated(603,22, "We"), $x + 79, $y, -1, 15)
			_GUICtrlSetTip(-1, GetTranslated(603,23, "Wednesday"))
		GUICtrlCreateLabel(GetTranslated(603,24, "Th"), $x + 99, $y, -1, 15)
			_GUICtrlSetTip(-1, GetTranslated(603,25, "Thursday"))
		GUICtrlCreateLabel(GetTranslated(603,26, "Fr"), $x + 117, $y, -1, 15)
			_GUICtrlSetTip(-1, GetTranslated(603,27, "Friday"))
		GUICtrlCreateLabel(GetTranslated(603,28, "Sa"), $x + 133, $y, -1, 15)
			_GUICtrlSetTip(-1, GetTranslated(603,29, "Saturday"))
		GUICtrlCreateLabel("X", $x + 155, $y+1, -1, 15)
			_GUICtrlSetTip(-1, GetTranslated(603,2, -1))

	$y += 13
		$g_ahChkAttackWeekdays[0] = GUICtrlCreateCheckbox("", $x + 30, $y, 16, 16)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, GetTranslated(603,31, -1))
		$g_ahChkAttackWeekdays[1] = GUICtrlCreateCheckbox("", $x + 47, $y, 16, 16)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, GetTranslated(603,31, -1))
		$g_ahChkAttackWeekdays[2] = GUICtrlCreateCheckbox("", $x + 64, $y, 16, 16)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, GetTranslated(603,31, -1))
		$g_ahChkAttackWeekdays[3] = GUICtrlCreateCheckbox("", $x + 81, $y, 16, 16)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, GetTranslated(603,31, -1))
		$g_ahChkAttackWeekdays[4] = GUICtrlCreateCheckbox("", $x + 99, $y, 16, 16)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, GetTranslated(603,31, -1))
		$g_ahChkAttackWeekdays[5] = GUICtrlCreateCheckbox("", $x + 117, $y, 16, 16)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, GetTranslated(603,31, -1))
		$g_ahChkAttackWeekdays[6] = GUICtrlCreateCheckbox("", $x + 133, $y, 16, 16)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, GetTranslated(603,31, -1))
		$g_ahChkAttackWeekdaysE = GUICtrlCreateCheckbox("", $x + 151, $y, 15, 15, BitOR($BS_PUSHLIKE, $BS_ICON))
			GUICtrlSetImage(-1, $g_sLibIconPath, $eIcnGoldStar, 0)
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, GetTranslated(603,2, -1))
			GUICtrlSetOnEvent(-1, "chkattackWeekDaysE")

	$x -= 25
	$y += 17
		GUICtrlCreateLabel(GetTranslated(603,15,"Hour") & ":", $x , $y, -1, 15)
			$sTxtTip = GetTranslated(603,30, "Only during these hours of each day")
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(" 0", $x + 30, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(" 1", $x + 45, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(" 2", $x + 60, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(" 3", $x + 75, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(" 4", $x + 90, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(" 5", $x + 105, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(" 6", $x + 120, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(" 7", $x + 135, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(" 8", $x + 150, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel(" 9", $x + 165, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel("10", $x + 180, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel("11", $x + 195, $y, 13, 15)
			_GUICtrlSetTip(-1, $sTxtTip)
		GUICtrlCreateLabel("X", $x + 214, $y+1, 11, 11)
			_GUICtrlSetTip(-1, $sTxtTip)

	$y += 15
		$g_ahChkAttackHours[0] = GUICtrlCreateCheckbox("", $x + 30, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[1] = GUICtrlCreateCheckbox("", $x + 45, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[2] = GUICtrlCreateCheckbox("", $x + 60, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[3] = GUICtrlCreateCheckbox("", $x + 75, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[4] = GUICtrlCreateCheckbox("", $x + 90, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[5] = GUICtrlCreateCheckbox("", $x + 105, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[6] = GUICtrlCreateCheckbox("", $x + 120, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[7] = GUICtrlCreateCheckbox("", $x + 135, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[8] = GUICtrlCreateCheckbox("", $x + 150, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[9] = GUICtrlCreateCheckbox("", $x + 165, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[10] = GUICtrlCreateCheckbox("", $x + 180, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[11] = GUICtrlCreateCheckbox("", $x + 195, $y, 15, 15)
		   GUICtrlSetState(-1, $GUI_CHECKED)
		   GUICtrlSetState(-1, $GUI_DISABLE)
		$g_ahChkAttackHoursE1 = GUICtrlCreateCheckbox("", $x + 211, $y+1, 13, 13, BitOR($BS_PUSHLIKE, $BS_ICON))
		   GUICtrlSetImage(-1, $g_sLibIconPath, $eIcnGoldStar, 0)
		   GUICtrlSetState(-1, $GUI_UNCHECKED)
		   GUICtrlSetState(-1, $GUI_DISABLE)
		   _GUICtrlSetTip(-1, GetTranslated(603,2, "This button will clear or set the entire row of boxes"))
		   GUICtrlSetOnEvent(-1, "chkattackHoursE1")
		GUICtrlCreateLabel(GetTranslated(603,3, "AM"), $x + 10, $y)

	$y += 15
		$sTxtTip = GetTranslated(603,30, -1)
		$g_ahChkAttackHours[12] = GUICtrlCreateCheckbox("", $x + 30, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[13] = GUICtrlCreateCheckbox("", $x + 45, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[14] = GUICtrlCreateCheckbox("", $x + 60, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[15] = GUICtrlCreateCheckbox("", $x + 75, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[16] = GUICtrlCreateCheckbox("", $x + 90, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[17] = GUICtrlCreateCheckbox("", $x + 105, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[18] = GUICtrlCreateCheckbox("", $x + 120, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[19] = GUICtrlCreateCheckbox("", $x + 135, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[20] = GUICtrlCreateCheckbox("", $x + 150, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[21] = GUICtrlCreateCheckbox("", $x + 165, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[22] = GUICtrlCreateCheckbox("", $x + 180, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHours[23] = GUICtrlCreateCheckbox("", $x + 195, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkAttackHoursE2 = GUICtrlCreateCheckbox("", $x + 211, $y+1, 13, 13, BitOR($BS_PUSHLIKE, $BS_ICON))
			GUICtrlSetImage(-1, $g_sLibIconPath, $eIcnGoldStar, 0)
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, GetTranslated(603,2, -1))
			GUICtrlSetOnEvent(-1, "chkattackHoursE2")
		GUICtrlCreateLabel(GetTranslated(603,4, "PM"), $x + 10, $y)

	GUICtrlCreateGroup("", -99, -99, 1, 1)

    Local $x = 25, $y = 290
    GUICtrlCreateGroup(GetTranslated(634,12, "ClanCastle"), $x - 20, $y - 20, $g_iSizeWGrpTab4, 102)
		GUICtrlCreateIcon($g_sLibIconPath, $eIcnCC, $x, $y + 8, 64, 64)

	$y -= 8
		$g_hChkDropCCHoursEnable = GUICtrlCreateCheckbox(GetTranslated(634,40,"Enable CC Drop Schedule" ), $x + 70, $y, -1, -1)
			GUICtrlSetState(-1, $GUI_UNCHECKED)
			_GUICtrlSetTip(-1, GetTranslated(634,41, "Use schedule to define when dropping CC is allowed, \r\n CC is always dropped when schedule is not enabled"))
			GUICtrlSetOnEvent(-1, "chkDropCCHoursEnable")

	$x += 188
	$y += 20
		GUICtrlCreateLabel(GetTranslated(603,30, -1), $x+8, $y)

	$y += 14
	$x -= 21
		$g_hLblDropCChour = GUICtrlCreateLabel(GetTranslated(603, 15, -1) & ":", $x , $y, -1, 15)
			Local $sTxtTip = GetTranslated(603, 30, -1)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_hLblDropCChours[0] = GUICtrlCreateLabel(" 0", $x + 30, $y, 13, 15)
		$g_hLblDropCChours[1] = GUICtrlCreateLabel(" 1", $x + 45, $y, 13, 15)
		$g_hLblDropCChours[2] = GUICtrlCreateLabel(" 2", $x + 60, $y, 13, 15)
		$g_hLblDropCChours[3] = GUICtrlCreateLabel(" 3", $x + 75, $y, 13, 15)
		$g_hLblDropCChours[4] = GUICtrlCreateLabel(" 4", $x + 90, $y, 13, 15)
		$g_hLblDropCChours[5] = GUICtrlCreateLabel(" 5", $x + 105, $y, 13, 15)
		$g_hLblDropCChours[6] = GUICtrlCreateLabel(" 6", $x + 120, $y, 13, 15)
		$g_hLblDropCChours[7] = GUICtrlCreateLabel(" 7", $x + 135, $y, 13, 15)
		$g_hLblDropCChours[8] = GUICtrlCreateLabel(" 8", $x + 150, $y, 13, 15)
		$g_hLblDropCChours[9] = GUICtrlCreateLabel(" 9", $x + 165, $y, 13, 15)
		$g_hLblDropCChours[10] = GUICtrlCreateLabel("10", $x + 180, $y, 13, 15)
		$g_hLblDropCChours[11] = GUICtrlCreateLabel("11", $x + 195, $y, 13, 15)
		$g_ahLblDropCChoursE = GUICtrlCreateLabel("X", $x + 213, $y+2, 11, 11)

    $y += 15
		$g_ahChkDropCCHours[0] = GUICtrlCreateCheckbox("", $x + 30, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			$sTxtTip = GetTranslated(603,30, -1)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[1] = GUICtrlCreateCheckbox("", $x + 45, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[2] = GUICtrlCreateCheckbox("", $x + 60, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[3] = GUICtrlCreateCheckbox("", $x + 75, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[4] = GUICtrlCreateCheckbox("", $x + 90, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[5] = GUICtrlCreateCheckbox("", $x + 105, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[6] = GUICtrlCreateCheckbox("", $x + 120, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[7] = GUICtrlCreateCheckbox("", $x + 135, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[8] = GUICtrlCreateCheckbox("", $x + 150, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[9] = GUICtrlCreateCheckbox("", $x + 165, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[10] = GUICtrlCreateCheckbox("", $x + 180, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[11] = GUICtrlCreateCheckbox("", $x + 195, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHoursE1 = GUICtrlCreateCheckbox("", $x + 211, $y+1, 13, 13, BitOR($BS_PUSHLIKE, $BS_ICON))
			GUICtrlSetImage(-1, $g_sLibIconPath, $eIcnGoldStar, 0)
			GUICtrlSetState(-1, $GUI_UNCHECKED )
			_GUICtrlSetTip(-1, GetTranslated(603,2, -1))
			GUICtrlSetOnEvent(-1, "chkDropCCHoursE1")
		GUICtrlCreateLabel(GetTranslated(603,3, -1), $x + 10, $y)

	$y += 15
		$sTxtTip = GetTranslated(603,30, -1)
		$g_ahChkDropCCHours[12] = GUICtrlCreateCheckbox("", $x + 30, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[13] = GUICtrlCreateCheckbox("", $x + 45, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[14] = GUICtrlCreateCheckbox("", $x + 60, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[15] = GUICtrlCreateCheckbox("", $x + 75, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[16] = GUICtrlCreateCheckbox("", $x + 90, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[17] = GUICtrlCreateCheckbox("", $x + 105, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[18] = GUICtrlCreateCheckbox("", $x + 120, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[19] = GUICtrlCreateCheckbox("", $x + 135, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[20] = GUICtrlCreateCheckbox("", $x + 150, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[21] = GUICtrlCreateCheckbox("", $x + 165, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[22] = GUICtrlCreateCheckbox("", $x + 180, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHours[23] = GUICtrlCreateCheckbox("", $x + 195, $y, 15, 15)
			GUICtrlSetState(-1, $GUI_CHECKED )
			GUICtrlSetState(-1, $GUI_DISABLE)
			_GUICtrlSetTip(-1, $sTxtTip)
		$g_ahChkDropCCHoursE2 = GUICtrlCreateCheckbox("", $x + 211, $y+1, 13, 13, BitOR($BS_PUSHLIKE, $BS_ICON))
			GUICtrlSetImage(-1, $g_sLibIconPath, $eIcnGoldStar, 0)
			GUICtrlSetState(-1, $GUI_UNCHECKED )
			_GUICtrlSetTip(-1, GetTranslated(603,2, -1))
			GUICtrlSetOnEvent(-1, "chkDropCCHoursE2")
		GUICtrlCreateLabel(GetTranslated(603,4, -1), $x + 10, $y)
	GUICtrlCreateGroup("", -99, -99, 1, 1)

EndFunc

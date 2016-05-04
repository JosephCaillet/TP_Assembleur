
;************************************************************************
; TITLE:                MAX7219.ASM
; AUTHOR:               Nicolas Coquelle
; DESCRIPTION:          Bibliothèque pour l'utilisation d'un MAX7219
;                       pour l'affichage sur des afficheurs 7 segments
;************************************************************************

	EXTERN	MAX7219_Init
	EXTERN	MAX7219_ShutdownStart
	EXTERN	MAX7219_ShutdownStop
	EXTERN	MAX7219_DisplayTestStart
	EXTERN	MAX7219_DisplayTestStop
	EXTERN	MAX7219_SetBrightness, SetBrightness_Bright.B
	EXTERN	MAX7219_Clear
	EXTERN	MAX7219_AllumePoint
	EXTERN	MAX7219_AfficheP
	EXTERN	MAX7219_DisplayChar, DisplayChar_Digit.B, DisplayChar_Character.B

;*** (c) 2002  Nicolas Coquelle - ISEM **************************************

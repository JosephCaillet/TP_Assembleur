ST7/

;************************************************************************
; TITLE:                
; AUTHOR:               
; DESCRIPTION:          
;************************************************************************

	TITLE "SQUELET.ASM"
	
	MOTOROLA
	
	#include "ST7Lite2.INC"

	; Enlever le commentaire si vous utilisez les afficheurs
;	#include "MAX7219.INC"


;************************************************************************
;
;  ZONE DE DECLARATION DES SYMBOLES
;
;************************************************************************

TEMPO EQU 18999

;************************************************************************
;
;  FIN DE LA ZONE DE DECLARATION DES SYMBOLES
;
;************************************************************************

	
	BYTES
	
	segment byte 'ram0'

;************************************************************************
;
;  ZONE DE DECLARATION DES VARIABLES
;
;************************************************************************



;************************************************************************
;
;  FIN DE LA ZONE DE DECLARATION DES VARIABLES
;
;************************************************************************


        WORDS

	segment byte 'rom'

;************************************************************************
;
;  ZONE DE DECLARATION DES CONSTANTES
;
;************************************************************************




;************************************************************************
;
;  FIN DE LA ZONE DE DECLARATION DES CONSTANTES
;
;************************************************************************

;------------------------------------------------------------------------

;************************************************************************
;
;  ZONE DE DECLARATION DES SOUS-PROGRAMMES
;
;************************************************************************

init_ports_led:
	LD	A,PADDR;init PADDR dire quoi est en push/pull etc
	OR	A,#%10011011
	LD	PADDR,A
	
	LD	A,PAOR;init PAOR
	OR	A,#%10011011
	LD	PAOR,A
	
	LD	A,PBDDR;init PBDDR dire quoi est en push/pull etc
	OR	A,#%01110000
	LD	PBDDR,A
	
	LD	A,PBOR;init PBOR
	OR	A,#%01110000
	LD	PBOR,A
	RET

allume_impair:
	LD	A,PADR
	OR	A,#%10001001
	AND	A,#%11101101
	LD	PADR,A
	
	LD	A,PBDR
	OR	A,#%00100000
	AND	A,#%10101111
	LD	PBDR,A
	;BSET	PADR,#0
	;BSET	PADR,#3
	;BSET	PADR,#7
	;BSET	PBDR,#5
	RET

allume_pair:
	LD	A,PADR
	OR	A,#%00011010
	AND	A,#%01110110
	LD	PADR,A
	
	LD	A,PBDR
	OR	A,#%01010000
	AND	A,#%11011111
	LD	PBDR,A
	;BRES	PADR,#0
	;BRES	PADR,#3
	;BRES	PADR,#7
	;BRES	PBDR,#5
	RET

attend_500ms:
initBoucle1:
	CLR X
boucle1:
	INC X
	CALL initBoucle2
	CP X,#200
	JRNE boucle1
	RET
initBoucle2:
	CLR Y
boucle2:
	INC Y
	CP Y,#200
	JRNE boucle2
	RET
	
;************************************************************************
;
;  FIN DE LA ZONE DE DECLARATION DES SOUS-PROGRAMMES
;
;************************************************************************


;************************************************************************
;
;  PROGRAMME PRINCIPAL
;
;************************************************************************

main:
	RSP			; Reset Stack Pointer
	CALL	init_ports_led
		
boucl
	CALL allume_pair
	CALL attend_500ms
	CALL allume_impair
	CALL attend_500ms
	JP	boucl



;************************************************************************
;
;  ZONE DE DECLARATION DES SOUS-PROGRAMMES D'INTERRUPTION
;
;************************************************************************


dummy_rt:	IRET	; Procédure vide : retour au programme principal.



;************************************************************************
;
;  ZONE DE DECLARATION DES VECTEURS D'INTERRUPTION
;
;************************************************************************


	segment 'vectit'


		DC.W	dummy_rt	; Adresse FFE0-FFE1h
SPI_it		DC.W	dummy_rt	; Adresse FFE2-FFE3h
lt_RTC1_it	DC.W	dummy_rt	; Adresse FFE4-FFE5h
lt_IC_it	DC.W	dummy_rt	; Adresse FFE6-FFE7h
at_timerover_it	DC.W	dummy_rt	; Adresse FFE8-FFE9h
at_timerOC_it	DC.W	dummy_rt	; Adresse FFEA-FFEBh
AVD_it		DC.W	dummy_rt	; Adresse FFEC-FFEDh
		DC.W	dummy_rt	; Adresse FFEE-FFEFh
lt_RTC2_it	DC.W	dummy_rt	; Adresse FFF0-FFF1h
ext3_it		DC.W	dummy_rt	; Adresse FFF2-FFF3h
ext2_it		DC.W	dummy_rt	; Adresse FFF4-FFF5h
ext1_it		DC.W	dummy_rt	; Adresse FFF6-FFF7h
ext0_it		DC.W	dummy_rt	; Adresse FFF8-FFF9h
AWU_it		DC.W	dummy_rt	; Adresse FFFA-FFFBh
softit		DC.W	dummy_rt	; Adresse FFFC-FFFDh
reset		DC.W	main		; Adresse FFFE-FFFFh


	END

;************************************************************************

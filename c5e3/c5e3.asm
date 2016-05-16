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

;--- Initialise les ports PA et PB avec les masques PADDR, PAOR, PBDDR et PBOR ---;
init_port:
	;--- PADDR = 1xxx1xx1
	LD	A,PADDR
	OR	A,#%10001001
	LD	PADDR,A
	
	;--- PAOR = 1xxx1xx1
	LD	A,PAOR;init PAOR
	OR	A,#%10001001
	LD	PAOR,A
	
	;--- PBDDR = xx1xxxxx
	LD	A,PBDDR
	OR	A,#%00100000
	LD	PBDDR,A
	
	;--- PBOR = xx1xxxxx
	LD	A,PBOR;init PBOR
	OR	A,#%00100000
	LD	PBOR,A
	RET

;--- allume les LEDs 0, 3, 5 et 7 ---;
ledOn:
	BSET	PADR,#0;allume les led impaires, comme fait une seule fois, on utilise bset plutot que les masques,
	BSET	PADR,#3;plus facile pour moi, et n'impacte pas les performance, comme fais une seule fois.
	BSET	PADR,#7
	BSET	PBDR,#5
boucl:
	WFI;economie d'energie
	JP boucl
		
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
	CALL	init_port
	JP	ledOn



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

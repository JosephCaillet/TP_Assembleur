;************************************************************************ 
; TITLE:                ST7FLite2.INC
; AUTHOR:               CMG Microcontroller Application Team
; DESCRIPTION:          ST7FLite2 Register and memory mapping 
;************************************************************************;*********************************************************************

;**********************************************************************
;		I/O Ports Registers
;**********************************************************************

	EXTERN	PADR.b		; port A data register
	EXTERN	PADDR.b		; port A data direction register
	EXTERN	PAOR.b		; port A option register

	EXTERN	PBDR.b		; port B data register
	EXTERN	PBDDR.b		; port B data direction register
	EXTERN	PBOR.b		; port B option register

;**********************************************************************
;		Lite Timer Registers
;**********************************************************************
   
	EXTERN LTCSR2.b  	; Lite Timer Control/Status register 2
	EXTERN LTCARR.b   	; Lite Timer Auto-reload register
	EXTERN LTCNTR.b  	; Lite Timer Counter register
	EXTERN LTCSR1.b 	 ; Lite Timer Control/Status register 1
	EXTERN LTICR.b  	 ; Lite Timer Input Capture register
	
;**********************************************************************
;		Auto reload timer registers
;**********************************************************************

	EXTERN ATCSR.b		; Timer Control/Status register 1
	EXTERN CNTRH.b		; Counter Register High
	EXTERN CNTRL.b		; Counter Register Low 
	EXTERN ATRH.b	    ; Auto-Reload Register High
	EXTERN ATRL.b	    ; Auto-Reload Register Low
	EXTERN PWMCR.b		; PWM Output Control Register
	EXTERN PWM0CSR.b 	; PWM 0 Control/Status Register  
	EXTERN PWM1CSR.b 	; PWM 1 Control/Status Register  
	EXTERN PWM2CSR.b 	; PWM 2 Control/Status Register  
	EXTERN PWM3CSR.b 	; PWM 3 Control/Status Register  
	EXTERN DCR0H.b		; PWM 0 Duty Cycle Register High
	EXTERN DCR0L.b		; PWM 0 Duty Cycle Register Low   
	EXTERN DCR1H.b		; PWM 0 Duty Cycle Register High
	EXTERN DCR1L.b		; PWM 0 Duty Cycle Register Low   
	EXTERN DCR2H.b		; PWM 0 Duty Cycle Register High
	EXTERN DCR2L.b		; PWM 0 Duty Cycle Register Low   
	EXTERN DCR3H.b		; PWM 0 Duty Cycle Register High
	EXTERN DCR3L.b		; PWM 0 Duty Cycle Register Low   
	EXTERN ATICRH.b		; Input Capture Register High 
	EXTERN ATICRL.b		; Input Capture Register Low
	EXTERN TRANCR.b		; Transfer Control Register
	EXTERN BREAKCR.b	; Break Control Register  

;**********************************************************************
;                        Watchdog Control  register
;**********************************************************************
   
	EXTERN WDGCR.b  	; Watchdog Control Register 


;**********************************************************************
;		Flash Register
;**********************************************************************

	EXTERN	FCSR.b		; flash control/satus register

;**********************************************************************
;		EEPROM Register
;**********************************************************************

	EXTERN	EECSR.b		; data EEPROM control status register

;**********************************************************************
;		SPI Registers
;**********************************************************************

	EXTERN	SPIDR.b		; SPI data I/O register
	EXTERN	SPICR.b		; SPI control register
	EXTERN	SPISR.b		; SPI status register

;**********************************************************************
;		ADC Registers
;**********************************************************************
    
	EXTERN ADCCSR.b		; ADC Control Status register
	EXTERN ADCDRH.b  	; ADC Data register
	EXTERN ADCDRL.b		; ADC Amplifier Control register
 
;**********************************************************************
;		ITC Registers
;**********************************************************************
   
	EXTERN	EICR.b		; external interrupt control register

;**********************************************************************
;		MCC egisters
;**********************************************************************

	EXTERN	MCCSR.b		; main clock control/status register
    
;**********************************************************************
;		Clock & Reset Registers
;**********************************************************************

	EXTERN	RCCR.b		; RC oscilator control register
	EXTERN	SICSR.b		; system integrity control/status register

;**********************************************************************
;                        External Interrupt Selection Registers
;**********************************************************************

	EXTERN EISR.b  ;  External Interrupt Selection Register

;**********************************************************************
;                        Dali Registers
;**********************************************************************

	EXTERN DCMCLK.b  ; DALI Clock Register
	EXTERN DCMFA.b  ; DALI Forward Address Register
	EXTERN DCMFD.b  ; DALI Forward Data Register
	EXTERN DCMBD.b  ; DALI Backward Data Register
	EXTERN DCMCR.b  ; DALI Control Register
	EXTERN DCMCSR.b  ; DALI Control/Status Register

;**********************************************************************
;                        AWU Registers
;**********************************************************************

	EXTERN AWUPR.b  	; AWU Prescaler Register
	EXTERN AWUCSR.b  ; AWU Control/Status Register

;**********************************************************************
;                        DM Registers
;**********************************************************************

	EXTERN DMCR.b  	; DM Control Register
	EXTERN DMSR.b  	; DM Status Register
	EXTERN DMBK1H.b  ; DM Breakpoint Register 1 High
	EXTERN DMBK1L.b  ; DM Breakpoint Register 1 Low
	EXTERN DMBK2H.b  ; DM Breakpoint Register 2 High
	EXTERN DMBK2L.b  ; DM Breakpoint Register 2 Low


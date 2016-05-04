st7/

;************************************************************************ 
; TITLE:                ST7FLite2.ASM
; AUTHOR:               CMG Microcontroller Application Team
; DESCRIPTION:          ST7FLite2 Registers and memory mapping 
;
; Define here the micro ROM Size according to the sales type:
;
 #define ST7FLite20   1   ;=> no Data EEPROM
; #define ST7FLite25   1   ;=> no Data EEPROM
; #define ST7FLite29    1   ;=> Data EEPROM
;    
;************************************************************************


;+------------------------------------------------------------------------------+
;|	HARDAWRE REGISTERS							|
;+------------------------------------------------------------------------------+
   
    BYTES           ; following addresses are 8 bit length

;********************************************************************
    segment byte at 0-7F 'periph'
;********************************************************************

;**********************************************************************
;		I/O Ports Registers
;**********************************************************************

.PADR   DS.B    1       ; port A data register
.PADDR  DS.B    1       ; port A data direction register
.PAOR   DS.B    1       ; port A option register

.PBDR   DS.B    1       ; port B data register
.PBDDR  DS.B    1       ; port B data direction register
.PBOR   DS.B    1       ; port B option register

reserved0    
		DS.B    2  ; unused

;**********************************************************************
;		Lite Timer Registers
;**********************************************************************
   
.LTCSR2	DS.B	1	; lite timer control/status register 2
.LTCARR	DS.B	1	; lite timer auto reload register
.LTCNTR	DS.B	1	; lite timer counter register
.LTCSR1	DS.B	1	; lite timer control/status register 1
.LTICR	DS.B	1	; lite timer input capture register

;**********************************************************************
;		Auto reload timer registers
;**********************************************************************

.ATCSR  DS.B  1     ; Timer Control/Status register 1
.CNTRH	DS.B	1	; Counter Register High
.CNTRL	DS.B	1	; Counter Register Low 
.ATRH	DS.B	1	; Auto-Reload Register High
.ATRL	DS.B	1	; Auto-Reload Register Low
.PWMCR	DS.B	1	; PWM Output Control Register
.PWM0CSR DS.B	1	; PWM 0 Control/Status Register  
.PWM1CSR DS.B	1	; PWM 1 Control/Status Register  
.PWM2CSR DS.B	1	; PWM 2 Control/Status Register  
.PWM3CSR DS.B	1	; PWM 3 Control/Status Register  
.DCR0H	 DS.B	1	; PWM 0 Duty Cycle Register High
.DCR0L	 DS.B	1	; PWM 0 Duty Cycle Register Low   
.DCR1H	 DS.B	1	; PWM 1 Duty Cycle Register High
.DCR1L	 DS.B	1	; PWM 1 Duty Cycle Register Low   
.DCR2H	 DS.B	1	; PWM 2 Duty Cycle Register High
.DCR2L	 DS.B	1	; PWM 2 Duty Cycle Register Low   
.DCR3H	 DS.B	1	; PWM 3 Duty Cycle Register High
.DCR3L	 DS.B	1	; PWM 3 Duty Cycle Register Low   
.ATICRH	 DS.B	1	; Input Capture Register High 
.ATICRL	 DS.B	1	; Input Capture Register Low
.TRANCR	 DS.B	1	; Transfer Control Register
.BREAKCR DS.B	1	; Break Control Register  

reserved1 
		DS.B   11      ;  unused
		
;**********************************************************************
;                        Watchdog Control  register					
;**********************************************************************
   
.WDGCR  DS.B    1       ; Watchdog Control Register 

;**********************************************************************
;		Flash Register
;**********************************************************************

.FCSR	DS.B    1       ; flash control/satus register

;**********************************************************************
;		EEPROM Register
;**********************************************************************

.EECSR	DS.B	1		; data EEPROM control status register
 
;**********************************************************************
;		SPI Registers
;**********************************************************************

.SPIDR	DS.B	1		; SPI data I/O register
.SPICR	DS.B	1       ; SPI control register
.SPISR	DS.B	1       ; SPI status register

;**********************************************************************
;		ADC Registers
;**********************************************************************
    
.ADCCSR	DS.B	1	; A/D control/status register
.ADCDRH	DS.B	1	; ADC Data register
.ADCDRL	DS.B	1	; ADC Amplifier Control register and Data Low Register

;**********************************************************************
;		ITC Registers
;**********************************************************************
   
.EICR	DS.B	1	; external interrupt control register

;**********************************************************************
;		MCC Registers
;**********************************************************************

.MCCSR	DS.B	1	; main clock control/status register
    
;**********************************************************************
;		Clock & Reset Registers
;**********************************************************************

.RCCR	DS.B	1	; RC oscilator control register
.SICSR	DS.B	1	; system integrity control/status register

reserved2 
		DS.B    1   ;  unused

.EISR	DS.B	1	;  External Interrupt Selection Register

reserved3    
		DS.B    3      ; 3 bytes unused	3Dh to 3Fh

;**********************************************************************
;                        Dali Registers	
;**********************************************************************

.DCMCLK	DS.B	1	; DALI Clock Register
.DCMFA	DS.B	1	; DALI Forward Address Register
.DCMFD	DS.B	1	; DALI Forward Data Register
.DCMBD	DS.B	1	; DALI Backward Data Register
.DCMCR	DS.B	1	; DALI Control Register
.DCMCSR	DS.B	1	; DALI Control/Status Register

reserved4
	    DS.B    3   ; 3 bytes unused	46h to 48h

;**********************************************************************
;                        AWU Registers	
;**********************************************************************

.AWUPR	DS.B	1	; AWU Prescaler Register
.AWUCSR	DS.B	1	; AWU Control/Status Register

;**********************************************************************
;                        DM Registers	
;**********************************************************************

.DMCR	DS.B	1	; DM Control Register
.DMSR	DS.B	1	; DM Status Register
.DMBK1H	DS.B	1	; DM Breakpoint Register 1 High
.DMBK1L	DS.B	1	; DM Breakpoint Register 1 Low
.DMBK2H	DS.B	1	; DM Breakpoint Register 2 High
.DMBK2L	DS.B	1	; DM Breakpoint Register 2 Low



;**********************************************************************
    segment byte at 80-17F 'ram0' ;Zero Page
;**********************************************************************

    WORDS           ; following addresses are 16 bit length

;**********************************************************************
    segment byte at 180-1FF 'stack'
;**********************************************************************

;**********************************************************************
  #ifdef ST7FLite29 
    segment byte at 1000-107F 'data eeprom'
  #endif
;**********************************************************************

;********************************************************************** 
    segment byte at E000-FFDF 'rom'                 
;**********************************************************************

;**********************************************************************
    segment byte at FFE0-FFFF 'vectit'
;**********************************************************************

        end

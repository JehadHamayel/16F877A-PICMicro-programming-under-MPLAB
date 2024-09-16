PROCESSOR 16F877A
		INCLUDE "P16F877A.INC"	
		
		__CONFIG 0x3731
		 
		 CBLOCK  0x20
			pulseWidthH       ; Variable to store the high byte of pulse width
			pulseWidthL       ; Variable to store the low byte of pulse width
			quotient         ; Quotient of division
			quotientH
			tempH            ; Temporary high byte
			tempL            ; Temporary low byte
			num58
			CurPosotion 
			Count
			huns
			tens
			ones
			resOfMul
			
		ENDC
		
		CBLOCK 0x30
		     us1_L
			us1_H
			us2_L
			us2_H
			us3_L
			us3_H
			us4_L
			us4_H
			us5_L
			us5_H
			us6_L
			us6_H
			us7_L
			us7_H
			us8_L
			us8_H
			us9_L
			us9_H
			us10_L
			us10_H
			us11_L
			us11_H
			us12_L
			us12_H
			us13_L
			us13_H
			us14_L
			us14_H
			us15_L
			us15_H
			us16_L
			us16_H
			us17_L
			us17_H
			us18_L
			us18_H
			us19_L
			us19_H
			us20_L
			us20_H
			us21_L
			us21_H
			us22_L
			us22_H
			us23_L
			us23_H
			us24_L
			us24_H
			us1_NUM
			us2_NUM
			us3_NUM
			us4_NUM
			us5_NUM
			us6_NUM
			us7_NUM
			us8_NUM
			us9_NUM
			us10_NUM
			us11_NUM
			us12_NUM
			us13_NUM
			us14_NUM
			us15_NUM
			us16_NUM
			us17_NUM
			us18_NUM
			us19_NUM
			us20_NUM
			us21_NUM
			us22_NUM
			us23_NUM
			us24_NUM
			temp_high1
			temp_low1 
			temp_high2 
			temp_low2 
			i          
			j
			outN 
			inN 

		ENDC
		; Define constants
		#define ECHO_PIN     PORTB, 1   ; Echo pin on PORTB.1
		
		
		; the instruction shoude start from here
		ORG 0x00
		GOTO init
		
		ORG 0x04 ; for intarpt
		GOTO ISR
		
		
		;when intrupt happend the program will enter here
ISR
	    
		BTFSS   PIR1, TMR1IF   ; Check if Timer1 overflowed
		RETFIE                  ; If not, return from ISR
		MOVF    TMR1H, W       ; Move Timer1 high byte to W
		MOVWF   pulseWidthH    ; Store high byte
		MOVF    TMR1L, W       ; Move Timer1 low byte to W
		MOVWF   pulseWidthL    ; Store low byte
		BCF     T1CON, TMR1ON  ; Stop Timer1
		BCF     PIR1, TMR1IF   ; Clear Timer1 interrupt flag
		
		BANKSEL PORTD
		retfie

		INCLUDE "LCDIS_PORTD.INC"
;the init for our programe
init
	
		BANKSEL TRISD
		CLRF TRISD ; make it outputs

		BANKSEL TRISC
		CLRF TRISC ; make it outputs
		
		;BANKSEL PORTD
		;CLRF PORTD
		
		;BANKSEL PORTC
		;CLRF PORTC
		
		
		
		
		BANKSEL TRISB
		BCF TRISB, RB0
		BSF TRISB, RB1
		BCF TRISB, RB2
		BCF TRISB, RB3
		BCF TRISB, RB4
		
		BCF TRISB, RB5
		BCF TRISB, RB6
		BCF TRISB, RB7
		
	
		;BANKSEL PORTB
		;CLRF PORTB
		
		
		BANKSEL T1CON
		BCF     T1CON, TMR1ON  ; Ensure Timer1 is off
		
		BANKSEL PORTD
		BCF STATUS,Z
		BCF STATUS,C
		
		CLRF	pulseWidthH       ; Variable to store the high byte of pulse width
		 CLRF	pulseWidthL       ; Variable to store the low byte of pulse width
		 CLRF	quotient         ; Quotient of division
		 CLRF	quotientH
		 CLRF	 tempH            ; Temporary high byte
		 CLRF	tempL            ; Temporary low byte
		 CLRF	num58
		 CLRF	CurPosotion 
		 CLRF	Count
		 CLRF	 huns
		 CLRF	tens
		 CLRF	ones
		
		
		
	
		GOTO start

;the main code for our programe
start
		CALL xms
		CALL xms
		CALL inid
	
		CALL welcomeMessage
		
		CALL delay500ms
		BCF     Select,RS      ; select command register
		MOVLW   0x08           ; load command for display control
		CALL    send
		CALL    xms
		MOVLW   0x0C           ; load command to turn on display with no cursor
		CALL    send

		CALL delay500ms
		MOVLW   0x08
		CALL    send
		CALL    xms
		MOVLW   0x0C
		CALL    send

		CALL delay500ms
		MOVLW d'1'
		MOVWF us1_NUM	
		
		MOVLW d'2'
		MOVWF us2_NUM
		
		MOVLW d'3'
		MOVWF us3_NUM
		
		MOVLW d'4'
		MOVWF us4_NUM
		
		MOVLW d'5'
		MOVWF us5_NUM
		
		MOVLW d'6'
		MOVWF us6_NUM
		
		MOVLW d'7'
		MOVWF us7_NUM
		
		MOVLW d'8'
		MOVWF us8_NUM
		
		MOVLW d'9'
		MOVWF us9_NUM
		
		MOVLW d'10'
		MOVWF us10_NUM
		
		MOVLW d'11'
		MOVWF us11_NUM
		
		MOVLW d'12'
		MOVWF us12_NUM
		
		MOVLW d'13'
		MOVWF us13_NUM
		
		MOVLW d'14'
		MOVWF us14_NUM
		
		MOVLW d'15'
		MOVWF us15_NUM
		
		MOVLW d'16'
		MOVWF us16_NUM
		
		MOVLW d'17'
		MOVWF us17_NUM
		
		MOVLW d'18'
		MOVWF us18_NUM
		
		MOVLW d'19'
		MOVWF us19_NUM
		
		MOVLW d'20'
		MOVWF us20_NUM
		
		MOVLW d'21'
		MOVWF us21_NUM
		
		MOVLW d'22'
		MOVWF us22_NUM
		
		MOVLW d'23'
		MOVWF us23_NUM
		
		MOVLW d'24'
		MOVWF us24_NUM
		
		
		
	        MOVLW 0x3A
		MOVWF num58
	
		
	        
	MOVLW 0x64
    MOVWF us1_L
    MOVLW 0x00
    MOVWF us1_H

    MOVLW 0x34
    MOVWF us2_L
    MOVLW 0x00
    MOVWF us2_H

    MOVLW 0x36
    MOVWF us3_L
    MOVLW 0x00
    MOVWF us3_H

    MOVLW 0x38
    MOVWF us4_L
    MOVLW 0x00
    MOVWF us4_H

    MOVLW 0x3A
    MOVWF us5_L
    MOVLW 0x00
    MOVWF us5_H

    MOVLW 0x3C
    MOVWF us6_L
    MOVLW 0x00
    MOVWF us6_H

    MOVLW 0x3E
    MOVWF us7_L
    MOVLW 0x00
    MOVWF us7_H

    MOVLW 0x40
    MOVWF us8_L
    MOVLW 0x00
    MOVWF us8_H

    MOVLW 0x42
    MOVWF us9_L
    MOVLW 0x00
    MOVWF us9_H

    MOVLW 0x44
    MOVWF us10_L
    MOVLW 0x00
    MOVWF us10_H

    MOVLW 0x46
    MOVWF us11_L
    MOVLW 0x00
    MOVWF us11_H

    MOVLW 0x48
    MOVWF us12_L
    MOVLW 0x00
    MOVWF us12_H

    MOVLW 0x4A
    MOVWF us13_L
    MOVLW 0x00
    MOVWF us13_H

    MOVLW 0x4C
    MOVWF us14_L
    MOVLW 0x00
    MOVWF us14_H

    MOVLW 0x4E
    MOVWF us15_L
    MOVLW 0x00
    MOVWF us15_H

    MOVLW 0x50
    MOVWF us16_L
    MOVLW 0x00
    MOVWF us16_H

    MOVLW 0x52
    MOVWF us17_L
    MOVLW 0x00
    MOVWF us17_H

    MOVLW 0x54
    MOVWF us18_L
    MOVLW 0x00
    MOVWF us18_H

    MOVLW 0x56
    MOVWF us19_L
    MOVLW 0x00
    MOVWF us19_H

    MOVLW 0x58
    MOVWF us20_L
    MOVLW 0x00
    MOVWF us20_H

    MOVLW 0x5A
    MOVWF us21_L
    MOVLW 0x00
    MOVWF us21_H

    MOVLW 0x5C
    MOVWF us22_L
    MOVLW 0x00
    MOVWF us22_H

    MOVLW 0x5E
    MOVWF us23_L
    MOVLW 0x00
    MOVWF us23_H

    MOVLW 0x60
    MOVWF us24_L
    MOVLW 0x00
    MOVWF us24_H
			
			
		
			;CALL meatureDistanses
	CALL sortDistanses
		
		
		MOVFW us24_NUM
		MOVWF us1_NUM
		MOVFW us23_NUM
		MOVWF us2_NUM
		MOVFW us22_NUM
		MOVWF us3_NUM
		MOVFW us21_NUM
		MOVWF us4_NUM
		;;CALL delay1000ms
		CALL displayFirst4US
		
		CALL delay1000ms
		CALL delay1000ms
	
loop		
		GOTO loop
		
		
meatureDistanses:

		CALL selectROW1
		CALL selectColumn1InRow1
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us1_L
		MOVF quotientH,W
		MOVWF us1_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW1
		CALL selectColumn2InRow1
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us2_L
		MOVF quotientH,W
		MOVWF us2_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW1
		CALL selectColumn3InRow1
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us3_L
		MOVF quotientH,W
		MOVWF us3_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW1
		CALL selectColumn4InRow1
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us4_L
		MOVF quotientH,W
		MOVWF us4_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW1
		CALL selectColumn5InRow1
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us5_L
		MOVF quotientH,W
		MOVWF us5_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW1
		CALL selectColumn6InRow1
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us6_L
		MOVF quotientH,W
		MOVWF us6_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
	
		CALL selectROW1
		CALL selectColumn7InRow1
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us7_L
		MOVF quotientH,W
		MOVWF us7_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW1
		CALL selectColumn8InRow1
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us8_L
		MOVF quotientH,W
		MOVWF us8_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW2
		CALL selectColumn1InRow2
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us9_L
		MOVF quotientH,W
		MOVWF us9_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW2
		CALL selectColumn2InRow2
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us10_L
		MOVF quotientH,W
		MOVWF us10_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW2
		CALL selectColumn3InRow2
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us11_L
		MOVF quotientH,W
		MOVWF us11_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW2
		CALL selectColumn4InRow2
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us12_L
		MOVF quotientH,W
		MOVWF us12_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW2
		CALL selectColumn5InRow2
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us13_L
		MOVF quotientH,W
		MOVWF us13_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW2
		CALL selectColumn6InRow2
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us14_L
		MOVF quotientH,W
		MOVWF us14_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW2
		CALL selectColumn7InRow2
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us15_L
		MOVF quotientH,W
		MOVWF us15_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW2
		CALL selectColumn8InRow2
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us16_L
		MOVF quotientH,W
		MOVWF us16_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW3
		CALL selectColumn1InRow3
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us17_L
		MOVF quotientH,W
		MOVWF us17_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW3
		CALL selectColumn2InRow3
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us18_L
		MOVF quotientH,W
		MOVWF us18_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW3
		CALL selectColumn3InRow3
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us19_L
		MOVF quotientH,W
		MOVWF us19_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW3
		CALL selectColumn4InRow3
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us20_L
		MOVF quotientH,W
		MOVWF us20_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW3
		CALL selectColumn5InRow3
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us21_L
		MOVF quotientH,W
		MOVWF us21_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW3
		CALL selectColumn6InRow3
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us22_L
		MOVF quotientH,W
		MOVWF us22_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW3
		CALL selectColumn7InRow3
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us23_L
		MOVF quotientH,W
		MOVWF us23_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL selectROW3
		CALL selectColumn8InRow3
		CALL TriggerSensor
		CALL MeasureDistance
		MOVF quotient,W
		MOVWF us24_L
		MOVF quotientH,W
		MOVWF us24_H
		CALL condec
		CALL clearDisplay
		CALL putLCD
		CALL delay1000ms
		
		CALL sortDistanses
		return
displayFirst4US:
		 
		
	   CALL clearDisplay
		MOVLW 0x00
		MOVWF CurPosotion
		call setCursorPosition
		
		BSF Select, RS
		MOVLW 'U'
		CALL send
		MOVLW 0x60
	        MOVWF FSR
		
		MOVFW INDF
		MOVWF quotient
		CALL condec2
		CALL putLCD3
		
		
		
		MOVLW ':'
		CALL send
		
		MOVLW 0x5E
	    MOVWF FSR
		MOVFW INDF
		MOVWF quotient
		
		MOVLW d'1'
		ADDWF FSR,F
		MOVFW INDF
		MOVWF quotientH
		CALL condec
		CALL putLCD2
		
		MOVLW ' '
		CALL send
		MOVLW ' '
		CALL send
		
		BSF Select, RS
		MOVLW 'U'
		CALL send
		
		MOVLW 0x61
	        MOVWF FSR
		MOVFW INDF
		MOVWF quotient
		CALL condec2
		CALL putLCD3
		
		
		MOVLW ':'
		CALL send

		MOVLW 0x5C
	    MOVWF FSR
		MOVFW INDF
		MOVWF quotient
		
		MOVLW d'1'
		ADDWF FSR,F
		MOVFW INDF
		MOVWF quotientH
		
		CALL condec
		CALL putLCD2
		
		MOVLW 0x40
		ADDWF CurPosotion,F
		call setCursorPosition
		
		BSF Select, RS
		MOVLW 'U'
		CALL send
		
		MOVLW 0x62
	        MOVWF FSR
		MOVFW INDF
		MOVWF quotient
		CALL condec2
		CALL putLCD3
		

		MOVLW ':'
		CALL send

		MOVLW 0x5A
	    MOVWF FSR
		MOVFW INDF
		MOVWF quotient
		
		MOVLW d'1'
		ADDWF FSR,F
		MOVFW INDF
		MOVWF quotientH
		CALL condec
		CALL putLCD2
		
		MOVLW ' '
		CALL send
		MOVLW ' '
		CALL send
		
		BSF Select, RS
		MOVLW 'U'
		CALL send
		
		MOVLW 0x63
	    MOVWF FSR
		MOVFW INDF
		MOVWF quotient
		CALL condec2
		CALL putLCD3
		
		MOVLW ':'
		CALL send

		MOVLW 0x58
	    MOVWF FSR
		MOVFW INDF
		MOVWF quotient
		
		MOVLW d'1'
		ADDWF FSR,F
		MOVFW INDF
		MOVWF quotientH
		
		CALL condec
		CALL putLCD2
		
	
		
		RETURN
sortDistanses:
	MOVLW d'23'
	MOVWF outN
	; outN = n - 1 ; n=24		
	CLRF i
	
OUTER_LOOP:
    MOVFW i
	SUBWF  outN,w
	; outN - i
 
    BTFSC STATUS, Z
    GOTO END_SORT       
	CLRF j
	MOVWF inN
INNER_LOOP:
	MOVLW 0x30
	MOVWF FSR
    MOVF j, W
    SUBWF inN,w
	; inN - j
    BTFSC STATUS, Z
    GOTO NEXT_OUTER

	;tempH  
	;tempL
    ; Load NUMBERS[j] (16-bit)
	;MOVFW FSR
	CALL MultIn2by_j
	MOVFW resOfMul
	ADDWF FSR,f
    MOVFW INDF
    MOVWF temp_low1

	MOVLW d'48'
	MOVWF Count
	MOVFW j
	SUBWF Count,F
	MOVFW Count
	ADDWF FSR,F
	MOVFW INDF
	MOVWF tempL
	MOVFW Count
	SUBWF FSR,F
	

	MOVLW d'1'
	ADDWF FSR,F
	MOVFW INDF
	MOVWF temp_high1
	

	MOVLW d'48'
	MOVWF Count
	MOVFW j
	SUBWF Count,F
	MOVFW Count
	ADDWF FSR,F
	MOVFW INDF
	MOVWF tempH
	MOVFW Count
	SUBWF FSR,F
	
    ; Load NUMBERS[j+1] (16-bit)
	MOVLW d'1'
	ADDWF FSR,F
	MOVFW INDF
    MOVWF temp_low2
	

	MOVLW d'1'
	ADDWF FSR,F
	MOVFW INDF
	;MOVF us1_H + 2 * j + 3, W
	MOVWF temp_high2
	

    ; Compare the high bytes first
	GOTO chickTheEqH  
	MOVF temp_high1, W
	SUBWF temp_high2, W
        BTFSC STATUS, C
        GOTO NO_SWAP
NEXT
    ; Compare the low bytes if high bytes are equal
	GOTO chickTheEqL
nextChick
    MOVF temp_low1, W
    SUBWF temp_low2, W
    BTFSC STATUS, C
    GOTO NO_SWAP

    ; Swap NUMBERS[j] and NUMBERS[j+1]
Swap:    
	MOVLW d'3'
	SUBWF FSR,F
	MOVF temp_low2, W
	MOVWF INDF
	


	MOVLW d'48'
	MOVWF Count
	MOVFW j
	SUBWF Count,F
	MOVFW Count
	ADDWF FSR,F
    MOVF tempH, W
	MOVWF INDF
	MOVFW Count
	SUBWF FSR,F
   
	MOVLW d'1'
	ADDWF FSR,F
    MOVF temp_high2, W
	MOVWF INDF
	
	
	MOVLW d'48'
	MOVWF Count
	MOVFW j
	SUBWF Count,F
	MOVFW Count
	ADDWF FSR,F
    MOVF tempL, W
	MOVWF INDF
	MOVFW Count
	SUBWF FSR,F


	MOVLW d'1'
	ADDWF FSR,F
        MOVF temp_low1, W
	MOVWF INDF

    
	MOVLW d'1'
	ADDWF FSR,F
    MOVF temp_high1, W
    MOVWF INDF


NO_SWAP:
    INCF j, F
    GOTO INNER_LOOP

NEXT_OUTER:
    INCF i, F
    GOTO OUTER_LOOP

END_SORT:
      RETURN
chickTheEqH:
	MOVF temp_high1, W
    SUBWF temp_high2, W
    BTFSC STATUS, Z
    GOTO NEXT
	GOTO andNext
andNext:
	BTFSS STATUS, C
	GOTO Swap
	GOTO NO_SWAP
	
chickTheEqL:
	MOVF temp_low1, W
    SUBWF temp_low2, W
    BTFSC STATUS, Z
    GOTO NO_SWAP
	GOTO nextChick
				
MultIn2by_j
	CLRF resOfMul
	MOVF j,F
	BTFSC STATUS, Z
	RETURN
	MOVLW D'2'
	MOVWF Count
	MOVLW d'0'
mulLoop:
	ADDWF j,W
	DECFSZ Count, F
	GOTO mulLoop
	MOVWF resOfMul
	RETURN
	
selectROW1:
	BANKSEL PORTB
	BCF PORTB, RB2
	BCF PORTB, RB3
	RETURN
selectROW2:
	BANKSEL PORTB
	BCF PORTB, RB2
	BSF PORTB, RB3
	RETURN
selectROW3:
	BANKSEL PORTB
	BSF PORTB, RB2
	BCF PORTB, RB3
	RETURN
	
	
selectColumn1InRow1:
	BANKSEL PORTC
	BCF PORTC, RC2
	BCF PORTC, RC1
	BCF PORTC, RC0
	RETURN
selectColumn2InRow1:
	BANKSEL PORTC
	BCF PORTC, RC2
	BCF PORTC, RC1
	BSF PORTC, RC0
	RETURN
selectColumn3InRow1:
	BANKSEL PORTC
	BCF PORTC, RC2
	BSF PORTC, RC1
	BCF PORTC, RC0
	RETURN	
selectColumn4InRow1:
	BANKSEL PORTC
	BCF PORTC, RC2
	BSF PORTC, RC1
	BSF PORTC, RC0
	RETURN
selectColumn5InRow1:
	BANKSEL PORTC
	BSF PORTC, RC2
	BCF PORTC, RC1
	BCF PORTC, RC0
	RETURN

selectColumn6InRow1:
	BANKSEL PORTC
	BSF PORTC, RC2
	BCF PORTC, RC1
	BSF PORTC, RC0
	RETURN
selectColumn7InRow1:
	BANKSEL PORTC
	BSF PORTC, RC2
	BSF PORTC, RC1
	BCF PORTC, RC0
	RETURN
selectColumn8InRow1:
	BANKSEL PORTC
	BSF PORTC, RC2
	BSF PORTC, RC1
	BSF PORTC, RC0
	RETURN


selectColumn1InRow2:
	BANKSEL PORTC
	BCF PORTC, RC5
	BCF PORTC, RC4
	BCF PORTC, RC3
	RETURN
selectColumn2InRow2:
	BANKSEL PORTC
	BCF PORTC, RC5
	BCF PORTC, RC4
	BSF PORTC, RC3
	RETURN
selectColumn3InRow2:
	BANKSEL PORTC
	BCF PORTC, RC5
	BSF PORTC, RC4
	BCF PORTC, RC3
	RETURN
selectColumn4InRow2:
	BANKSEL PORTC
	BCF PORTC, RC5
	BSF PORTC, RC4
	BSF PORTC, RC3
	RETURN
selectColumn5InRow2:
	BANKSEL PORTC
	BSF PORTC, RC5
	BCF PORTC, RC4
	BCF PORTC, RC3
	RETURN
selectColumn6InRow2:
	BANKSEL PORTC
	BSF PORTC, RC5
	BCF PORTC, RC4
	BSF PORTC, RC3
	RETURN	
selectColumn7InRow2:
	BANKSEL PORTC
	BSF PORTC, RC5
	BSF PORTC, RC4
	BCF PORTC, RC3
	RETURN
selectColumn8InRow2:
	BANKSEL PORTC
	BSF PORTC, RC5
	BSF PORTC, RC4
	BSF PORTC, RC3
	RETURN
	;;;;;;;;;;;;;;;;
	
selectColumn1InRow3:
	BANKSEL PORTB
	BCF PORTB, RB4
	BANKSEL PORTC
	BCF PORTC, RC7
	BCF PORTC, RC6
	RETURN
selectColumn2InRow3:
	BANKSEL PORTB
	BCF PORTB, RB4
	BANKSEL PORTC
	BCF PORTC, RC7
	BSF PORTC, RC6
	RETURN
selectColumn3InRow3:
	BANKSEL PORTB
	BCF PORTB, RB4
	BANKSEL PORTC
	BSF PORTC, RC7
	BCF PORTC, RC6
	RETURN
selectColumn4InRow3:
	BANKSEL PORTB
	BCF PORTB, RB4
	BANKSEL PORTC
	BSF PORTC, RC7
	BSF PORTC, RC6
	RETURN
selectColumn5InRow3:
	BANKSEL PORTB
	BSF PORTB, RB4
	BANKSEL PORTC
	BCF PORTC, RC7
	BCF PORTC, RC6
	RETURN
selectColumn6InRow3:
	BANKSEL PORTB
	BSF PORTB, RB4
	BANKSEL PORTC
	BCF PORTC, RC7
	BSF PORTC, RC6
	RETURN
selectColumn7InRow3:
	BANKSEL PORTB
	BSF PORTB, RB4
	BANKSEL PORTC
	BSF PORTC, RC7
	BCF PORTC, RC6
	RETURN
selectColumn8InRow3:
	BANKSEL PORTB
	BSF PORTB, RB4
	BANKSEL PORTC
	BSF PORTC, RC7
	BSF PORTC, RC6
	RETURN
	
chickLargerThan100

		MOVLW   d'100'       ; Load high byte of dividend
	    SUBWF quotient,W
		MOVWF quotient
		BTFSC STATUS,Z
		CALL chickHunsHighLargerThan1
		BCF STATUS,Z
		RETURN
chickquotientHLargerThan1
		MOVF quotientH,F
		BTFSC STATUS, Z 
		RETURN
		MOVF quotient,F
		BTFSS STATUS, Z 
		DECF quotientH
		BSF STATUS,C
		
		MOVLW   d'100'       ; Load high byte of dividend
	    SUBWF   quotient,W
		
		RETURN
			
; Convert input to decimal ................................
condec2  ;MOVWF	quotient		; get ADC result
		CLRF	tens			; zero tens digit = 5
		CLRF	ones		; zero ones digit = 5
		GOTO TENS
		
condec  ;MOVWF	quotient		; get ADC result
		CLRF	huns		; zero hundreds digit = 2
		CLRF	tens			; zero tens digit = 5
		CLRF	ones		; zero ones digit = 5

; Calclulate hundreds......................................

?		BSF		STATUS,C	; set carry for subtract
		MOVLW	D'100'		; load 100
sub1	CALL	chickLargerThan100
		BTFSS STATUS,C
		CALL	chickHunsHighLargerThan1
		BZ finishhunds
		;SUBWF	quotient,1		; and subtract from result
		INCF	huns		; count number of loops
		;BTFSC	STATUS,C	; and check if done
		GOTO	sub1		; no, carry on
finishhunds
		MOVLW 	d'100'
		ADDWF	quotient,1		; yes, add 100 back on
	;	DECF	huns		; and correct loop count

; Calculate tens digit.....................................
TENS:
		BSF		STATUS,C	; repeat process for tens
		MOVLW	D'10'		; load 10
sub2	SUBWF	quotient		; and subtract from result
		INCF	tens		; count number of loops
		BTFSC	STATUS,C	; and check if done
		GOTO	sub2		; no, carry on

		ADDWF	quotient		; yes, add 100 back on
		DECF	tens		; and correct loop count
		MOVF	quotient,W		; load remainder
		MOVWF	ones		; and store as ones digit

		RETURN				; done

chickHunsHighLargerThan1
		MOVF quotientH,F
		BTFSC STATUS, Z 
		RETURN
		MOVF quotient,F
		BTFSS STATUS, Z 
		DECF quotientH
		BSF STATUS,C
		
		MOVLW   d'100'       ; Load high byte of dividend
	    SUBWF   quotient,W
		
		RETURN

; Output to display........................................
putLCD3
	MOVLW	0x30			; load ASCII offset
	ADDWF	tens,1		; convert tens to ASCII
	ADDWF	ones,1		; convert ones to ASCII

	MOVF	tens,W		; load tens code
	CALL	send		; and output
	MOVF	ones,W		; load ones code
	CALL	send		; and output
	
	RETURN				; done

putLCD2	
; Convert digits to ASCII and display......................

	MOVLW	0x30			; load ASCII offset
	ADDWF	huns,1		; convert hundreds to ASCII
	ADDWF	tens,1		; convert tens to ASCII
	ADDWF	ones,1		; convert ones to ASCII

	MOVF	huns,W		; load hundreds code
	CALL	send		; and send to display
	MOVF	tens,W		; load tens code
	CALL	send		; and output
	MOVF	ones,W		; load ones code
	CALL	send		; and output
	
	RETURN				; done		

	
putLCD	BCF		Select,RS	; set display command mode
		MOVLW	0x80			; code to home cursor
		CALL	send		; output it to display
		BSF		Select,RS	; and restore data mode

; Convert digits to ASCII and display......................

	MOVLW	0x30			; load ASCII offset
	ADDWF	huns,1		; convert hundreds to ASCII
	ADDWF	tens,1		; convert tens to ASCII
	ADDWF	ones,1		; convert ones to ASCII

	MOVF	huns,W		; load hundreds code
	CALL	send		; and send to display
	MOVF	tens,W		; load tens code
	CALL	send		; and output
	MOVF	ones,W		; load ones code
	CALL	send		; and output
	MOVLW	' '			; load space code
	CALL	send		; and output
	MOVLW	'c'			; load volts code
	CALL	send		; and output
	MOVLW	'm'			; load volts code
	CALL	send		; and output
	

	RETURN				; done	
TRIGGER_PIN_LOW:
      BANKSEL PORTB
      BSF PORTB, RB5
      BCF PORTB, RB6
      BCF PORTB, RB7
      RETURN
TRIGGER_PIN_HIGH:
      BANKSEL PORTB
      BCF PORTB, RB5
      BCF PORTB, RB6
      BSF PORTB, RB7
      RETURN
; Subroutine to Trigger the Ultrasonic Sensor
TriggerSensor:
	    CALL TRIGGER_PIN_LOW
	    CALL Delay_2us
	    CALL TRIGGER_PIN_HIGH              ; Set Trigger pin high
	    CALL Delay_10us
	    CALL TRIGGER_PIN_LOW               ; Set Trigger pin low
	    RETURN		
; Subroutine to Measure Distance
MeasureDistance:
WAIT_ECHO
	    BTFSS   ECHO_PIN
	    GOTO    WAIT_ECHO
	
	    ; Start Timer1
	    CLRF    TMR1H           ; Clear Timer1 high byte
	    CLRF    TMR1L           ; Clear Timer1 low byte
	    BSF     T1CON, TMR1ON   ; Turn on Timer1

    ; Wait for echo pin to go low
WAIT_ECHO_LOW
	    BTFSC   ECHO_PIN
	    GOTO    WAIT_ECHO_LOW
	
	    ; Stop Timer1
	    BCF     T1CON, TMR1ON
	
	    ; Read Timer1 value
	    MOVF    TMR1H, W
	    MOVWF   pulseWidthH
	    MOVF    TMR1L, W
	    MOVWF   pulseWidthL
		

	    ; Combine pulseWidthH and pulseWidthL into a 16-bit value
	    MOVF    pulseWidthH, W   ; Load high byte of pulse width
	    MOVWF   tempH            ; Store in tempH
	    MOVF    pulseWidthL, W   ; Load low byte of pulse width
	    MOVWF   tempL            ; Store in tempL
		
		BCF 	STATUS,Z
		BCF 	STATUS,C
		CLRF quotient
		CLRF quotientH
		CALL    DIV_LOOP         ; Call the division subroutine
		
		
		RETURN

DIV_LOOP
		CALL chickLessThan58
		BTFSS STATUS,C
		CALL chickHighLargerThan1 
		BZ finish
		INCF quotient,F
		MOVF quotient,F
		BTFSC STATUS,Z
		CALL chickZero
		GOTO DIV_LOOP

finish:
		INCF quotient,F
	    	RETURN

chickLessThan58
		MOVFW   num58       ; Load high byte of dividend
	    SUBWF   tempL,W
		MOVWF tempL
		BTFSC STATUS,Z
		CALL chickHighLargerThan1
		BCF STATUS,Z
		RETURN

chickHighLargerThan1
		MOVF tempH,F
		BTFSC STATUS, Z 
		RETURN
		MOVF tempL,F
		BTFSS STATUS, Z 
		DECF tempH
		BSF STATUS,C
		
		MOVFW   num58       ; Load high byte of dividend
	    SUBWF   tempL,W
		
		RETURN	
chickZero
		CLRF quotient
		INCF quotientH
		RETURN
; Delay Subroutines
Delay_2us:
	    NOP
	    NOP
	    RETURN


Delay_10us:
	    MOVLW D'10'
	    MOVWF Count
DelayLoop:
	    DECFSZ Count, F
	    GOTO DelayLoop
	    RETURN
	
clearDisplay:
		MOVLW	0x01		; Code to clear display
		BCF Select, RS
		CALL	send		; and send code
		RETURN
delay500ms:
		MOVLW	D'250'		; Set delay 250ms
	        CALL	xms		; and wait
		MOVLW	D'250'		; Set delay 250ms
	        CALL	xms		; and wait
		RETURN
delay1000ms:
	        CALL delay500ms
		CALL delay500ms
		RETURN
welcomeMessage:
		MOVLW 0x00
		MOVWF CurPosotion
		call setCursorPosition
		
		BSF Select, RS
		MOVLW 'W'
		CALL send
		MOVLW 'e'
		CALL send
		MOVLW 'l'
		CALL send
		MOVLW 'c'
		CALL send
		MOVLW 'o'
		CALL send
		MOVLW 'm'
		CALL send
		MOVLW 'e'
		CALL send
		MOVLW ' '
		CALL send
		MOVLW 't'
		CALL send
		MOVLW 'o'
		CALL send
		
		MOVLW 0x40
		ADDWF CurPosotion,F
		call setCursorPosition
		
		BSF Select, RS
		MOVLW 'H'
		CALL send
		MOVLW 'C'
		CALL send
		MOVLW 'S'
		CALL send
		MOVLW 'R'
		CALL send
		MOVLW '0'
		CALL send
		MOVLW '4'
		CALL send
		MOVLW ' '
		CALL send
		MOVLW 'M'
		CALL send
		MOVLW 'o'
		CALL send
		MOVLW 'd'
		CALL send
		MOVLW 'u'
		CALL send
		MOVLW 'l'
		CALL send
		MOVLW 'e'
		CALL send
		MOVLW 's'
		CALL send
		
		RETURN
		


; Set cursor to a specific DDRAM address
; Call this with the address in W
setCursorPosition
	       BTFSC CurPosotion,4
		GOTO moveCursorSecondRow
		IORLW   0x80        ; Combine with 0x80 to form the correct command
		BCF Select, RS
		CALL    send        ; Send command
		RETURN
; Move cursor to the beginning of the second row
moveCursorSecondRow
		MOVLW   0x40        ; Address of the beginning of the second row
		MOVWF CurPosotion
		IORLW   0x80        ; Combine with 0x80 to form the set DDRAM address command
		BCF Select, RS
		CALL    send        ; Send the command to the LCD
		RETURN



END
   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.10.2 - 02 Nov 2011
   3                     ; Generator (Limited) V4.3.7 - 29 Nov 2011
  43                     ; 7 void initPin(void)
  43                     ; 8 {
  45                     	switch	.text
  46  0000               _initPin:
  50                     ; 9     GPIOC -> DDR = 0x00;///Entrée bouton
  52  0000 725f500c      	clr	20492
  53                     ; 10 	GPIOC -> CR1 = 0x00;
  55  0004 725f500d      	clr	20493
  56                     ; 11 	GPIOC -> CR2 = 0x00;
  58  0008 725f500e      	clr	20494
  59                     ; 13     GPIOB -> DDR = 0xFF;///sortie des leds
  61  000c 35ff5007      	mov	20487,#255
  62                     ; 14 	GPIOB -> CR1 = 0xFF;
  64  0010 35ff5008      	mov	20488,#255
  65                     ; 15 	GPIOB -> CR2 = 0x00;
  67  0014 725f5009      	clr	20489
  68                     ; 17 	GPIOA -> DDR = 0x00;///dernier bouton 8 eme led
  70  0018 725f5002      	clr	20482
  71                     ; 18 	GPIOA -> CR1 = 0x00;
  73  001c 725f5003      	clr	20483
  74                     ; 19 	GPIOA -> CR2 = 0x00;
  76  0020 725f5004      	clr	20484
  77                     ; 21     GPIOE -> DDR = 0x00;///button prise de donnée
  79  0024 725f5016      	clr	20502
  80                     ; 22 	GPIOE -> CR1 = BUTTONGETDATA;
  82  0028 35805017      	mov	20503,#128
  83                     ; 23 	GPIOE -> CR2 = 0x00;
  85  002c 725f5018      	clr	20504
  86                     ; 26     GPIOA ->DDR = LEDIND;
  88  0030 35785002      	mov	20482,#120
  89                     ; 27     GPIOA->CR1 = LEDIND;
  91  0034 35785003      	mov	20483,#120
  92                     ; 28     GPIOA ->CR2 = 0x00;
  94  0038 725f5004      	clr	20484
  95                     ; 30 }
  98  003c 81            	ret
 101                     	switch	.ubsct
 102  0000               L52_posbuffer:
 103  0000 00            	ds.b	1
 104  0001               L12_caractData:
 105  0001 00            	ds.b	1
 106  0002               L72_end:
 107  0002 00            	ds.b	1
 108  0003               L32_buffer:
 109  0003 000000000000  	ds.b	10
 173                     ; 32 void programme(void)
 173                     ; 33 {
 174                     	switch	.text
 175  003d               _programme:
 179                     ; 39     end =0;
 181  003d 3f02          	clr	L72_end
 182                     ; 40     posbuffer = 0;
 184  003f 3f00          	clr	L52_posbuffer
 185                     ; 42     removeP();
 187  0041 ad7a          	call	_removeP
 189                     ; 43     affindex(posbuffer);
 191  0043 b600          	ld	a,L52_posbuffer
 192  0045 ad7b          	call	_affindex
 195  0047 2035          	jra	L56
 196  0049               L36:
 197                     ; 46         GPIOB->ODR = getData();
 199  0049 ad4d          	call	_getData
 201  004b c75005        	ld	20485,a
 202                     ; 47         if(!(GPIOE->IDR & BUTTONGETDATA))
 204  004e c65015        	ld	a,20501
 205  0051 a580          	bcp	a,#128
 206  0053 2629          	jrne	L56
 207                     ; 49             caractData =getData();
 209  0055 ad41          	call	_getData
 211  0057 b701          	ld	L12_caractData,a
 212                     ; 50             buffer[posbuffer] =  caractData;
 214  0059 b600          	ld	a,L52_posbuffer
 215  005b 5f            	clrw	x
 216  005c 97            	ld	xl,a
 217  005d b601          	ld	a,L12_caractData
 218  005f e703          	ld	(L32_buffer,x),a
 219                     ; 51             posbuffer++;
 221  0061 3c00          	inc	L52_posbuffer
 222                     ; 52             affindex(posbuffer);
 224  0063 b600          	ld	a,L52_posbuffer
 225  0065 ad5b          	call	_affindex
 227                     ; 53             if(posbuffer >= 10 || !caractData )
 229  0067 b600          	ld	a,L52_posbuffer
 230  0069 a10a          	cp	a,#10
 231  006b 2404          	jruge	L57
 233  006d 3d01          	tnz	L12_caractData
 234  006f 2606          	jrne	L101
 235  0071               L57:
 236                     ; 55                 end = 1;
 238  0071 35010002      	mov	L72_end,#1
 239                     ; 56                 affP();
 241  0075 ad41          	call	_affP
 243  0077               L101:
 244                     ; 59             while (!( GPIOE->IDR & BUTTONGETDATA));
 246  0077 c65015        	ld	a,20501
 247  007a a580          	bcp	a,#128
 248  007c 27f9          	jreq	L101
 249  007e               L56:
 250                     ; 44     while (!end)
 252  007e 3d02          	tnz	L72_end
 253  0080 27c7          	jreq	L36
 255  0082               L701:
 256                     ; 63     while (( GPIOE->IDR & BUTTONGETDATA));
 258  0082 c65015        	ld	a,20501
 259  0085 a580          	bcp	a,#128
 260  0087 26f9          	jrne	L701
 262  0089               L511:
 263                     ; 64     while (!( GPIOE->IDR & BUTTONGETDATA));
 265  0089 c65015        	ld	a,20501
 266  008c a580          	bcp	a,#128
 267  008e 27f9          	jreq	L511
 268                     ; 65 }
 271  0090 81            	ret
 296                     ; 67 void programme5 (void)
 296                     ; 68 {
 297                     	switch	.text
 298  0091               _programme5:
 302                     ; 69     initPin();
 304  0091 cd0000        	call	_initPin
 306  0094               L131:
 307                     ; 71         programme();
 309  0094 ada7          	call	_programme
 312  0096 20fc          	jra	L131
 346                     ; 77 char getData(void)
 346                     ; 78 {
 347                     	switch	.text
 348  0098               _getData:
 350  0098 88            	push	a
 351       00000001      OFST:	set	1
 354                     ; 80     value = GPIOC -> IDR;		
 356  0099 c6500b        	ld	a,20491
 357  009c 6b01          	ld	(OFST+0,sp),a
 358                     ; 81 		if(GPIOA -> IDR & MASKLAST)
 360  009e c65001        	ld	a,20481
 361  00a1 a502          	bcp	a,#2
 362  00a3 2708          	jreq	L351
 363                     ; 83 			value = value |0x01;
 365  00a5 7b01          	ld	a,(OFST+0,sp)
 366  00a7 aa01          	or	a,#1
 367  00a9 6b01          	ld	(OFST+0,sp),a
 369  00ab 2006          	jra	L551
 370  00ad               L351:
 371                     ; 86 			value = value &0xFE;
 373  00ad 7b01          	ld	a,(OFST+0,sp)
 374  00af a4fe          	and	a,#254
 375  00b1 6b01          	ld	(OFST+0,sp),a
 376  00b3               L551:
 377                     ; 87     return value;
 379  00b3 7b01          	ld	a,(OFST+0,sp)
 382  00b5 5b01          	addw	sp,#1
 383  00b7 81            	ret
 406                     ; 90 void affP(void)
 406                     ; 91 {
 407                     	switch	.text
 408  00b8               _affP:
 412                     ; 92     GPIOB->ODR = PSEGMENT;
 414  00b8 35ce5005      	mov	20485,#206
 415                     ; 93 }
 418  00bc 81            	ret
 441                     ; 95 void removeP(void)
 441                     ; 96 {
 442                     	switch	.text
 443  00bd               _removeP:
 447                     ; 97     GPIOB->ODR = 0xFF;
 449  00bd 35ff5005      	mov	20485,#255
 450                     ; 98 }
 453  00c1 81            	ret
 496                     ; 100 void affindex(char num)
 496                     ; 101 {
 497                     	switch	.text
 498  00c2               _affindex:
 500  00c2 88            	push	a
 501       00000001      OFST:	set	1
 504                     ; 102     char value = ~(num <<3);
 506  00c3 48            	sll	a
 507  00c4 48            	sll	a
 508  00c5 48            	sll	a
 509  00c6 43            	cpl	a
 510  00c7 6b01          	ld	(OFST+0,sp),a
 511                     ; 103     GPIOA->ODR = value;
 513  00c9 7b01          	ld	a,(OFST+0,sp)
 514  00cb c75000        	ld	20480,a
 515                     ; 104 }
 518  00ce 84            	pop	a
 519  00cf 81            	ret
 532                     	xdef	_programme
 533                     	xdef	_initPin
 534                     	xdef	_affindex
 535                     	xdef	_programme5
 536                     	xdef	_removeP
 537                     	xdef	_affP
 538                     	xdef	_getData
 557                     	end

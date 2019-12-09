#include "echo2.h"

#define BUTTONCOMPLEMENT 0x01 /// ligne 0 du port E
#define MASKLAST 0x02

void initPin(void)
{
    GPIOE->DDR =0x00;///bouton pour complement A1
    GPIOE->CR1 = 0x01;
    GPIOE->CR2 = 0x00;

    GPIOC -> DDR = 0x00;///Entrée bouton
	GPIOC -> CR1 = 0x00;
	GPIOC -> CR2 = 0x00;
	
	GPIOB -> DDR = 0xFF;///sortie des leds
	GPIOB -> CR1 = 0xFF;
	GPIOB -> CR2 = 0x00;
	
	GPIOA -> DDR = 0x00;///dernier bouton 8 eme led
	GPIOA -> CR1 = 0x00;
	GPIOA -> CR2 = 0x00;

}

void programme4(void)
{
    char value;
    initPin();
	while(1)
	{
        
		value = GPIOC -> IDR;		
		if(GPIOA -> IDR & MASKLAST)
		{
			value = value |0x01;
		}
		else
			value = value &0xFE;

        if(GPIOE->IDR & BUTTONCOMPLEMENT)
        {
            GPIOB ->ODR = (~value & 0xFF);
        }
        else
        {
            GPIOB->ODR = value;
        }
        
        
	}
}

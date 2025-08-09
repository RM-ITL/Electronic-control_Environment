#ifndef __BSP_LED_H__
#define __BSP_LED_H__

#include "stm32h7xx.h"
#include "spi.h"
#define WS2812_SPI_UNIT     hspi6
extern SPI_HandleTypeDef WS2812_SPI_UNIT;
void WS2812_Ctrl(uint8_t r, uint8_t g, uint8_t b);
void LED_Normal();
void LED_Warning();

#endif

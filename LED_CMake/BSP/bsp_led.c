#include "bsp_led.h"

#define WS2812_LowLevel    0xC0     // 0码
#define WS2812_HighLevel   0xF0     // 1码

void WS2812_Ctrl(uint8_t r, uint8_t g, uint8_t b)
{
    uint8_t txbuf[24];
    uint8_t res = 0;
    for (int i = 0; i < 8; i++)
    {
        txbuf[7-i]  = (((g>>i)&0x01) ? WS2812_HighLevel : WS2812_LowLevel)>>1;
        txbuf[15-i] = (((r>>i)&0x01) ? WS2812_HighLevel : WS2812_LowLevel)>>1;
        txbuf[23-i] = (((b>>i)&0x01) ? WS2812_HighLevel : WS2812_LowLevel)>>1;
    }
    HAL_SPI_Transmit(&WS2812_SPI_UNIT, &res, 0, 0xFFFF);
    while (WS2812_SPI_UNIT.State != HAL_SPI_STATE_READY);
    HAL_SPI_Transmit(&WS2812_SPI_UNIT, txbuf, 24, 0xFFFF);
    for (int i = 0; i < 100; i++)
    {
        HAL_SPI_Transmit(&WS2812_SPI_UNIT, &res, 1, 0xFFFF);
    }
}

void LED_Normal()
{
    WS2812_Ctrl(0,20,0);
}

void LED_Warning()
{
    WS2812_Ctrl(20,0,0);
}
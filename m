From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 05/14] pinctrl: sh-pfc: r8a7795-es1: Use generic bias register description
Date: Wed, 04 Oct 2017 13:40:13 +0300
Message-ID: <1744705.qyxHaYEude@avalon>
References: <1507108033-8606-1-git-send-email-geert+renesas@glider.be> <1507108033-8606-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1507108033-8606-6-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday, 4 October 2017 12:07:04 EEST Geert Uytterhoeven wrote:
> Move R-Car H3 ES1.x bias support over to the generic way to describe
> bias registers, which will be needed for suspend/resume support.
> 
> As the new description is more compact, this decreases kernel size by
> ca. 304 bytes.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 499 ++++++++++++++-------------
>  1 file changed, 258 insertions(+), 241 deletions(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c index
> 246d0de915feaffe..229192cf8e7430af 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c
> @@ -1449,6 +1449,7 @@ static const u16 pinmux_data[] = {
>  #define ROW_GROUP_A(r) ('Z' - 'A' + 1 + (r))
>  #define PIN_NUMBER(r, c) (((r) - 'A') * 39 + (c) + 300)
>  #define PIN_A_NUMBER(r, c) PIN_NUMBER(ROW_GROUP_A(r), c)
> +#define PIN_NONE U16_MAX
> 
>  static const struct sh_pfc_pin pinmux_pins[] = {
>  	PINMUX_GPIO_GP_ALL(),
> @@ -5438,242 +5439,261 @@ static int r8a7795es1_pin_to_pocctrl(struct sh_pfc
> *pfc, unsigned int pin, return bit;
>  }
> 
> -#define PUEN	0xe6060400
> -#define PUD	0xe6060440
> -
> -#define PU0	0x00
> -#define PU1	0x04
> -#define PU2	0x08
> -#define PU3	0x0c
> -#define PU4	0x10
> -#define PU5	0x14
> -#define PU6	0x18
> -
> -static const struct sh_pfc_bias_info bias_info[] = {
> -	{ RCAR_GP_PIN(2, 11),    PU0, 31 },	/* AVB_PHY_INT */
> -	{ RCAR_GP_PIN(2, 10),    PU0, 30 },	/* AVB_MAGIC */
> -	{ RCAR_GP_PIN(2,  9),    PU0, 29 },	/* AVB_MDC */
> -	{ PIN_NUMBER('A', 9),    PU0, 28 },	/* AVB_MDIO */
> -	{ PIN_NUMBER('A', 12),   PU0, 27 },	/* AVB_TXCREFCLK */
> -	{ PIN_NUMBER('B', 17),   PU0, 26 },	/* AVB_TD3 */
> -	{ PIN_NUMBER('A', 17),   PU0, 25 },	/* AVB_TD2 */
> -	{ PIN_NUMBER('B', 18),   PU0, 24 },	/* AVB_TD1 */
> -	{ PIN_NUMBER('A', 18),   PU0, 23 },	/* AVB_TD0 */
> -	{ PIN_NUMBER('A', 19),   PU0, 22 },	/* AVB_TXC */
> -	{ PIN_NUMBER('A', 8),    PU0, 21 },	/* AVB_TX_CTL */
> -	{ PIN_NUMBER('B', 14),   PU0, 20 },	/* AVB_RD3 */
> -	{ PIN_NUMBER('A', 14),   PU0, 19 },	/* AVB_RD2 */
> -	{ PIN_NUMBER('B', 13),   PU0, 18 },	/* AVB_RD1 */
> -	{ PIN_NUMBER('A', 13),   PU0, 17 },	/* AVB_RD0 */
> -	{ PIN_NUMBER('B', 19),   PU0, 16 },	/* AVB_RXC */
> -	{ PIN_NUMBER('A', 16),   PU0, 15 },	/* AVB_RX_CTL */
> -	{ PIN_NUMBER('V', 7),    PU0, 14 },	/* RPC_RESET# */
> -	{ PIN_NUMBER('V', 6),    PU0, 13 },	/* RPC_WP# */
> -	{ PIN_NUMBER('Y', 7),    PU0, 12 },	/* RPC_INT# */
> -	{ PIN_NUMBER('V', 5),    PU0, 11 },	/* QSPI1_SSL */
> -	{ PIN_A_NUMBER('C', 3),  PU0, 10 },	/* QSPI1_IO3 */
> -	{ PIN_A_NUMBER('E', 4),  PU0,  9 },	/* QSPI1_IO2 */
> -	{ PIN_A_NUMBER('E', 5),  PU0,  8 },	/* QSPI1_MISO_IO1 */
> -	{ PIN_A_NUMBER('C', 7),  PU0,  7 },	/* QSPI1_MOSI_IO0 */
> -	{ PIN_NUMBER('V', 3),    PU0,  6 },	/* QSPI1_SPCLK */
> -	{ PIN_NUMBER('Y', 3),    PU0,  5 },	/* QSPI0_SSL */
> -	{ PIN_A_NUMBER('B', 6),  PU0,  4 },	/* QSPI0_IO3 */
> -	{ PIN_NUMBER('Y', 6),    PU0,  3 },	/* QSPI0_IO2 */
> -	{ PIN_A_NUMBER('B', 4),  PU0,  2 },	/* QSPI0_MISO_IO1 */
> -	{ PIN_A_NUMBER('C', 5),  PU0,  1 },	/* QSPI0_MOSI_IO0 */
> -	{ PIN_NUMBER('W', 3),    PU0,  0 },	/* QSPI0_SPCLK */
> -
> -	{ RCAR_GP_PIN(1, 19),    PU1, 31 },	/* A19 */
> -	{ RCAR_GP_PIN(1, 18),    PU1, 30 },	/* A18 */
> -	{ RCAR_GP_PIN(1, 17),    PU1, 29 },	/* A17 */
> -	{ RCAR_GP_PIN(1, 16),    PU1, 28 },	/* A16 */
> -	{ RCAR_GP_PIN(1, 15),    PU1, 27 },	/* A15 */
> -	{ RCAR_GP_PIN(1, 14),    PU1, 26 },	/* A14 */
> -	{ RCAR_GP_PIN(1, 13),    PU1, 25 },	/* A13 */
> -	{ RCAR_GP_PIN(1, 12),    PU1, 24 },	/* A12 */
> -	{ RCAR_GP_PIN(1, 11),    PU1, 23 },	/* A11 */
> -	{ RCAR_GP_PIN(1, 10),    PU1, 22 },	/* A10 */
> -	{ RCAR_GP_PIN(1,  9),    PU1, 21 },	/* A9 */
> -	{ RCAR_GP_PIN(1,  8),    PU1, 20 },	/* A8 */
> -	{ RCAR_GP_PIN(1,  7),    PU1, 19 },	/* A7 */
> -	{ RCAR_GP_PIN(1,  6),    PU1, 18 },	/* A6 */
> -	{ RCAR_GP_PIN(1,  5),    PU1, 17 },	/* A5 */
> -	{ RCAR_GP_PIN(1,  4),    PU1, 16 },	/* A4 */
> -	{ RCAR_GP_PIN(1,  3),    PU1, 15 },	/* A3 */
> -	{ RCAR_GP_PIN(1,  2),    PU1, 14 },	/* A2 */
> -	{ RCAR_GP_PIN(1,  1),    PU1, 13 },	/* A1 */
> -	{ RCAR_GP_PIN(1,  0),    PU1, 12 },	/* A0 */
> -	{ RCAR_GP_PIN(2,  8),    PU1, 11 },	/* PWM2_A */
> -	{ RCAR_GP_PIN(2,  7),    PU1, 10 },	/* PWM1_A */
> -	{ RCAR_GP_PIN(2,  6),    PU1,  9 },	/* PWM0 */
> -	{ RCAR_GP_PIN(2,  5),    PU1,  8 },	/* IRQ5 */
> -	{ RCAR_GP_PIN(2,  4),    PU1,  7 },	/* IRQ4 */
> -	{ RCAR_GP_PIN(2,  3),    PU1,  6 },	/* IRQ3 */
> -	{ RCAR_GP_PIN(2,  2),    PU1,  5 },	/* IRQ2 */
> -	{ RCAR_GP_PIN(2,  1),    PU1,  4 },	/* IRQ1 */
> -	{ RCAR_GP_PIN(2,  0),    PU1,  3 },	/* IRQ0 */
> -	{ RCAR_GP_PIN(2, 14),    PU1,  2 },	/* AVB_AVTP_CAPTURE_A */
> -	{ RCAR_GP_PIN(2, 13),    PU1,  1 },	/* AVB_AVTP_MATCH_A */
> -	{ RCAR_GP_PIN(2, 12),    PU1,  0 },	/* AVB_LINK */
> -
> -	{ PIN_A_NUMBER('P', 8),  PU2, 31 },	/* DU_DOTCLKIN1 */
> -	{ PIN_A_NUMBER('P', 7),  PU2, 30 },	/* DU_DOTCLKIN0 */
> -	{ RCAR_GP_PIN(7,  3),    PU2, 29 },	/* HDMI1_CEC */
> -	{ RCAR_GP_PIN(7,  2),    PU2, 28 },	/* HDMI0_CEC */
> -	{ RCAR_GP_PIN(7,  1),    PU2, 27 },	/* AVS2 */
> -	{ RCAR_GP_PIN(7,  0),    PU2, 26 },	/* AVS1 */
> -	{ RCAR_GP_PIN(0, 15),    PU2, 25 },	/* D15 */
> -	{ RCAR_GP_PIN(0, 14),    PU2, 24 },	/* D14 */
> -	{ RCAR_GP_PIN(0, 13),    PU2, 23 },	/* D13 */
> -	{ RCAR_GP_PIN(0, 12),    PU2, 22 },	/* D12 */
> -	{ RCAR_GP_PIN(0, 11),    PU2, 21 },	/* D11 */
> -	{ RCAR_GP_PIN(0, 10),    PU2, 20 },	/* D10 */
> -	{ RCAR_GP_PIN(0,  9),    PU2, 19 },	/* D9 */
> -	{ RCAR_GP_PIN(0,  8),    PU2, 18 },	/* D8 */
> -	{ RCAR_GP_PIN(0,  7),    PU2, 17 },	/* D7 */
> -	{ RCAR_GP_PIN(0,  6),    PU2, 16 },	/* D6 */
> -	{ RCAR_GP_PIN(0,  5),    PU2, 15 },	/* D5 */
> -	{ RCAR_GP_PIN(0,  4),    PU2, 14 },	/* D4 */
> -	{ RCAR_GP_PIN(0,  3),    PU2, 13 },	/* D3 */
> -	{ RCAR_GP_PIN(0,  2),    PU2, 12 },	/* D2 */
> -	{ RCAR_GP_PIN(0,  1),    PU2, 11 },	/* D1 */
> -	{ RCAR_GP_PIN(0,  0),    PU2, 10 },	/* D0 */
> -	{ PIN_NUMBER('C', 1),    PU2,  9 },	/* PRESETOUT# */
> -	{ RCAR_GP_PIN(1, 27),    PU2,  8 },	/* EX_WAIT0_A */
> -	{ RCAR_GP_PIN(1, 26),    PU2,  7 },	/* WE1_N */
> -	{ RCAR_GP_PIN(1, 25),    PU2,  6 },	/* WE0_N */
> -	{ RCAR_GP_PIN(1, 24),    PU2,  5 },	/* RD_WR_N */
> -	{ RCAR_GP_PIN(1, 23),    PU2,  4 },	/* RD_N */
> -	{ RCAR_GP_PIN(1, 22),    PU2,  3 },	/* BS_N */
> -	{ RCAR_GP_PIN(1, 21),    PU2,  2 },	/* CS1_N_A26 */
> -	{ RCAR_GP_PIN(1, 20),    PU2,  1 },	/* CS0_N */
> -	{ PIN_NUMBER('F', 1),    PU2,  0 },	/* CLKOUT */
> -
> -	{ RCAR_GP_PIN(4,  9),    PU3, 31 },	/* SD3_DAT0 */
> -	{ RCAR_GP_PIN(4,  8),    PU3, 30 },	/* SD3_CMD */
> -	{ RCAR_GP_PIN(4,  7),    PU3, 29 },	/* SD3_CLK */
> -	{ RCAR_GP_PIN(4,  6),    PU3, 28 },	/* SD2_DS */
> -	{ RCAR_GP_PIN(4,  5),    PU3, 27 },	/* SD2_DAT3 */
> -	{ RCAR_GP_PIN(4,  4),    PU3, 26 },	/* SD2_DAT2 */
> -	{ RCAR_GP_PIN(4,  3),    PU3, 25 },	/* SD2_DAT1 */
> -	{ RCAR_GP_PIN(4,  2),    PU3, 24 },	/* SD2_DAT0 */
> -	{ RCAR_GP_PIN(4,  1),    PU3, 23 },	/* SD2_CMD */
> -	{ RCAR_GP_PIN(4,  0),    PU3, 22 },	/* SD2_CLK */
> -	{ RCAR_GP_PIN(3, 11),    PU3, 21 },	/* SD1_DAT3 */
> -	{ RCAR_GP_PIN(3, 10),    PU3, 20 },	/* SD1_DAT2 */
> -	{ RCAR_GP_PIN(3,  9),    PU3, 19 },	/* SD1_DAT1 */
> -	{ RCAR_GP_PIN(3,  8),    PU3, 18 },	/* SD1_DAT0 */
> -	{ RCAR_GP_PIN(3,  7),    PU3, 17 },	/* SD1_CMD */
> -	{ RCAR_GP_PIN(3,  6),    PU3, 16 },	/* SD1_CLK */
> -	{ RCAR_GP_PIN(3,  5),    PU3, 15 },	/* SD0_DAT3 */
> -	{ RCAR_GP_PIN(3,  4),    PU3, 14 },	/* SD0_DAT2 */
> -	{ RCAR_GP_PIN(3,  3),    PU3, 13 },	/* SD0_DAT1 */
> -	{ RCAR_GP_PIN(3,  2),    PU3, 12 },	/* SD0_DAT0 */
> -	{ RCAR_GP_PIN(3,  1),    PU3, 11 },	/* SD0_CMD */
> -	{ RCAR_GP_PIN(3,  0),    PU3, 10 },	/* SD0_CLK */
> -	{ PIN_A_NUMBER('T', 30), PU3,  9 },	/* ASEBRK */
> -	/* bit 8 n/a */
> -	{ PIN_A_NUMBER('R', 29), PU3,  7 },	/* TDI */
> -	{ PIN_A_NUMBER('R', 30), PU3,  6 },	/* TMS */
> -	{ PIN_A_NUMBER('T', 27), PU3,  5 },	/* TCK */
> -	{ PIN_A_NUMBER('R', 26), PU3,  4 },	/* TRST# */
> -	{ PIN_A_NUMBER('D', 39), PU3,  3 },	/* EXTALR*/
> -	{ PIN_A_NUMBER('D', 38), PU3,  2 },	/* FSCLKST# */
> -	{ PIN_A_NUMBER('R', 8),  PU3,  1 },	/* DU_DOTCLKIN3 */
> -	{ PIN_A_NUMBER('R', 7),  PU3,  0 },	/* DU_DOTCLKIN2 */
> -
> -	{ RCAR_GP_PIN(5, 19),    PU4, 31 },	/* MSIOF0_SS1 */
> -	{ RCAR_GP_PIN(5, 18),    PU4, 30 },	/* MSIOF0_SYNC */
> -	{ RCAR_GP_PIN(5, 17),    PU4, 29 },	/* MSIOF0_SCK */
> -	{ RCAR_GP_PIN(5, 16),    PU4, 28 },	/* HRTS0_N */
> -	{ RCAR_GP_PIN(5, 15),    PU4, 27 },	/* HCTS0_N */
> -	{ RCAR_GP_PIN(5, 14),    PU4, 26 },	/* HTX0 */
> -	{ RCAR_GP_PIN(5, 13),    PU4, 25 },	/* HRX0 */
> -	{ RCAR_GP_PIN(5, 12),    PU4, 24 },	/* HSCK0 */
> -	{ RCAR_GP_PIN(5, 11),    PU4, 23 },	/* RX2_A */
> -	{ RCAR_GP_PIN(5, 10),    PU4, 22 },	/* TX2_A */
> -	{ RCAR_GP_PIN(5,  9),    PU4, 21 },	/* SCK2 */
> -	{ RCAR_GP_PIN(5,  8),    PU4, 20 },	/* RTS1_N_TANS */
> -	{ RCAR_GP_PIN(5,  7),    PU4, 19 },	/* CTS1_N */
> -	{ RCAR_GP_PIN(5,  6),    PU4, 18 },	/* TX1_A */
> -	{ RCAR_GP_PIN(5,  5),    PU4, 17 },	/* RX1_A */
> -	{ RCAR_GP_PIN(5,  4),    PU4, 16 },	/* RTS0_N_TANS */
> -	{ RCAR_GP_PIN(5,  3),    PU4, 15 },	/* CTS0_N */
> -	{ RCAR_GP_PIN(5,  2),    PU4, 14 },	/* TX0 */
> -	{ RCAR_GP_PIN(5,  1),    PU4, 13 },	/* RX0 */
> -	{ RCAR_GP_PIN(5,  0),    PU4, 12 },	/* SCK0 */
> -	{ RCAR_GP_PIN(3, 15),    PU4, 11 },	/* SD1_WP */
> -	{ RCAR_GP_PIN(3, 14),    PU4, 10 },	/* SD1_CD */
> -	{ RCAR_GP_PIN(3, 13),    PU4,  9 },	/* SD0_WP */
> -	{ RCAR_GP_PIN(3, 12),    PU4,  8 },	/* SD0_CD */
> -	{ RCAR_GP_PIN(4, 17),    PU4,  7 },	/* SD3_DS */
> -	{ RCAR_GP_PIN(4, 16),    PU4,  6 },	/* SD3_DAT7 */
> -	{ RCAR_GP_PIN(4, 15),    PU4,  5 },	/* SD3_DAT6 */
> -	{ RCAR_GP_PIN(4, 14),    PU4,  4 },	/* SD3_DAT5 */
> -	{ RCAR_GP_PIN(4, 13),    PU4,  3 },	/* SD3_DAT4 */
> -	{ RCAR_GP_PIN(4, 12),    PU4,  2 },	/* SD3_DAT3 */
> -	{ RCAR_GP_PIN(4, 11),    PU4,  1 },	/* SD3_DAT2 */
> -	{ RCAR_GP_PIN(4, 10),    PU4,  0 },	/* SD3_DAT1 */
> -
> -	{ RCAR_GP_PIN(6, 24),    PU5, 31 },	/* USB0_PWEN */
> -	{ RCAR_GP_PIN(6, 23),    PU5, 30 },	/* AUDIO_CLKB_B */
> -	{ RCAR_GP_PIN(6, 22),    PU5, 29 },	/* AUDIO_CLKA_A */
> -	{ RCAR_GP_PIN(6, 21),    PU5, 28 },	/* SSI_SDATA9_A */
> -	{ RCAR_GP_PIN(6, 20),    PU5, 27 },	/* SSI_SDATA8 */
> -	{ RCAR_GP_PIN(6, 19),    PU5, 26 },	/* SSI_SDATA7 */
> -	{ RCAR_GP_PIN(6, 18),    PU5, 25 },	/* SSI_WS78 */
> -	{ RCAR_GP_PIN(6, 17),    PU5, 24 },	/* SSI_SCK78 */
> -	{ RCAR_GP_PIN(6, 16),    PU5, 23 },	/* SSI_SDATA6 */
> -	{ RCAR_GP_PIN(6, 15),    PU5, 22 },	/* SSI_WS6 */
> -	{ RCAR_GP_PIN(6, 14),    PU5, 21 },	/* SSI_SCK6 */
> -	{ RCAR_GP_PIN(6, 13),    PU5, 20 },	/* SSI_SDATA5 */
> -	{ RCAR_GP_PIN(6, 12),    PU5, 19 },	/* SSI_WS5 */
> -	{ RCAR_GP_PIN(6, 11),    PU5, 18 },	/* SSI_SCK5 */
> -	{ RCAR_GP_PIN(6, 10),    PU5, 17 },	/* SSI_SDATA4 */
> -	{ RCAR_GP_PIN(6,  9),    PU5, 16 },	/* SSI_WS4 */
> -	{ RCAR_GP_PIN(6,  8),    PU5, 15 },	/* SSI_SCK4 */
> -	{ RCAR_GP_PIN(6,  7),    PU5, 14 },	/* SSI_SDATA3 */
> -	{ RCAR_GP_PIN(6,  6),    PU5, 13 },	/* SSI_WS349 */
> -	{ RCAR_GP_PIN(6,  5),    PU5, 12 },	/* SSI_SCK349 */
> -	{ RCAR_GP_PIN(6,  4),    PU5, 11 },	/* SSI_SDATA2_A */
> -	{ RCAR_GP_PIN(6,  3),    PU5, 10 },	/* SSI_SDATA1_A */
> -	{ RCAR_GP_PIN(6,  2),    PU5,  9 },	/* SSI_SDATA0 */
> -	{ RCAR_GP_PIN(6,  1),    PU5,  8 },	/* SSI_WS01239 */
> -	{ RCAR_GP_PIN(6,  0),    PU5,  7 },	/* SSI_SCK01239 */
> -	{ PIN_NUMBER('H', 37),   PU5,  6 },	/* MLB_REF */
> -	{ RCAR_GP_PIN(5, 25),    PU5,  5 },	/* MLB_DAT */
> -	{ RCAR_GP_PIN(5, 24),    PU5,  4 },	/* MLB_SIG */
> -	{ RCAR_GP_PIN(5, 23),    PU5,  3 },	/* MLB_CLK */
> -	{ RCAR_GP_PIN(5, 22),    PU5,  2 },	/* MSIOF0_RXD */
> -	{ RCAR_GP_PIN(5, 21),    PU5,  1 },	/* MSIOF0_SS2 */
> -	{ RCAR_GP_PIN(5, 20),    PU5,  0 },	/* MSIOF0_TXD */
> -
> -	{ RCAR_GP_PIN(6, 31),    PU6,  6 },	/* USB31_OVC */
> -	{ RCAR_GP_PIN(6, 30),    PU6,  5 },	/* USB31_PWEN */
> -	{ RCAR_GP_PIN(6, 29),    PU6,  4 },	/* USB30_OVC */
> -	{ RCAR_GP_PIN(6, 28),    PU6,  3 },	/* USB30_PWEN */
> -	{ RCAR_GP_PIN(6, 27),    PU6,  2 },	/* USB1_OVC */
> -	{ RCAR_GP_PIN(6, 26),    PU6,  1 },	/* USB1_PWEN */
> -	{ RCAR_GP_PIN(6, 25),    PU6,  0 },	/* USB0_OVC */
> +static const struct pinmux_bias_reg pinmux_bias_regs[] = {
> +	{ PINMUX_BIAS_REG("PUEN0", 0xe6060400, "PUD0", 0xe6060440) {
> +		[ 0] = PIN_NUMBER('W', 3),	/* QSPI0_SPCLK */
> +		[ 1] = PIN_A_NUMBER('C', 5),	/* QSPI0_MOSI_IO0 */
> +		[ 2] = PIN_A_NUMBER('B', 4),	/* QSPI0_MISO_IO1 */
> +		[ 3] = PIN_NUMBER('Y', 6),	/* QSPI0_IO2 */
> +		[ 4] = PIN_A_NUMBER('B', 6),	/* QSPI0_IO3 */
> +		[ 5] = PIN_NUMBER('Y', 3),	/* QSPI0_SSL */
> +		[ 6] = PIN_NUMBER('V', 3),	/* QSPI1_SPCLK */
> +		[ 7] = PIN_A_NUMBER('C', 7),	/* QSPI1_MOSI_IO0 */
> +		[ 8] = PIN_A_NUMBER('E', 5),	/* QSPI1_MISO_IO1 */
> +		[ 9] = PIN_A_NUMBER('E', 4),	/* QSPI1_IO2 */
> +		[10] = PIN_A_NUMBER('C', 3),	/* QSPI1_IO3 */
> +		[11] = PIN_NUMBER('V', 5),	/* QSPI1_SSL */
> +		[12] = PIN_NUMBER('Y', 7),	/* RPC_INT# */
> +		[13] = PIN_NUMBER('V', 6),	/* RPC_WP# */
> +		[14] = PIN_NUMBER('V', 7),	/* RPC_RESET# */
> +		[15] = PIN_NUMBER('A', 16),	/* AVB_RX_CTL */
> +		[16] = PIN_NUMBER('B', 19),	/* AVB_RXC */
> +		[17] = PIN_NUMBER('A', 13),	/* AVB_RD0 */
> +		[18] = PIN_NUMBER('B', 13),	/* AVB_RD1 */
> +		[19] = PIN_NUMBER('A', 14),	/* AVB_RD2 */
> +		[20] = PIN_NUMBER('B', 14),	/* AVB_RD3 */
> +		[21] = PIN_NUMBER('A', 8),	/* AVB_TX_CTL */
> +		[22] = PIN_NUMBER('A', 19),	/* AVB_TXC */
> +		[23] = PIN_NUMBER('A', 18),	/* AVB_TD0 */
> +		[24] = PIN_NUMBER('B', 18),	/* AVB_TD1 */
> +		[25] = PIN_NUMBER('A', 17),	/* AVB_TD2 */
> +		[26] = PIN_NUMBER('B', 17),	/* AVB_TD3 */
> +		[27] = PIN_NUMBER('A', 12),	/* AVB_TXCREFCLK */
> +		[28] = PIN_NUMBER('A', 9),	/* AVB_MDIO */
> +		[29] = RCAR_GP_PIN(2,  9),	/* AVB_MDC */
> +		[30] = RCAR_GP_PIN(2, 10),	/* AVB_MAGIC */
> +		[31] = RCAR_GP_PIN(2, 11),	/* AVB_PHY_INT */
> +	} },
> +	{ PINMUX_BIAS_REG("PUEN1", 0xe6060404, "PUD1", 0xe6060444) {
> +		[ 0] = RCAR_GP_PIN(2, 12),	/* AVB_LINK */
> +		[ 1] = RCAR_GP_PIN(2, 13),	/* AVB_AVTP_MATCH_A */
> +		[ 2] = RCAR_GP_PIN(2, 14),	/* AVB_AVTP_CAPTURE_A */
> +		[ 3] = RCAR_GP_PIN(2,  0),	/* IRQ0 */
> +		[ 4] = RCAR_GP_PIN(2,  1),	/* IRQ1 */
> +		[ 5] = RCAR_GP_PIN(2,  2),	/* IRQ2 */
> +		[ 6] = RCAR_GP_PIN(2,  3),	/* IRQ3 */
> +		[ 7] = RCAR_GP_PIN(2,  4),	/* IRQ4 */
> +		[ 8] = RCAR_GP_PIN(2,  5),	/* IRQ5 */
> +		[ 9] = RCAR_GP_PIN(2,  6),	/* PWM0 */
> +		[10] = RCAR_GP_PIN(2,  7),	/* PWM1_A */
> +		[11] = RCAR_GP_PIN(2,  8),	/* PWM2_A */
> +		[12] = RCAR_GP_PIN(1,  0),	/* A0 */
> +		[13] = RCAR_GP_PIN(1,  1),	/* A1 */
> +		[14] = RCAR_GP_PIN(1,  2),	/* A2 */
> +		[15] = RCAR_GP_PIN(1,  3),	/* A3 */
> +		[16] = RCAR_GP_PIN(1,  4),	/* A4 */
> +		[17] = RCAR_GP_PIN(1,  5),	/* A5 */
> +		[18] = RCAR_GP_PIN(1,  6),	/* A6 */
> +		[19] = RCAR_GP_PIN(1,  7),	/* A7 */
> +		[20] = RCAR_GP_PIN(1,  8),	/* A8 */
> +		[21] = RCAR_GP_PIN(1,  9),	/* A9 */
> +		[22] = RCAR_GP_PIN(1, 10),	/* A10 */
> +		[23] = RCAR_GP_PIN(1, 11),	/* A11 */
> +		[24] = RCAR_GP_PIN(1, 12),	/* A12 */
> +		[25] = RCAR_GP_PIN(1, 13),	/* A13 */
> +		[26] = RCAR_GP_PIN(1, 14),	/* A14 */
> +		[27] = RCAR_GP_PIN(1, 15),	/* A15 */
> +		[28] = RCAR_GP_PIN(1, 16),	/* A16 */
> +		[29] = RCAR_GP_PIN(1, 17),	/* A17 */
> +		[30] = RCAR_GP_PIN(1, 18),	/* A18 */
> +		[31] = RCAR_GP_PIN(1, 19),	/* A19 */
> +	} },
> +	{ PINMUX_BIAS_REG("PUEN2", 0xe6060408, "PUD2", 0xe6060448) {
> +		[ 0] = PIN_NUMBER('F', 1),	/* CLKOUT */
> +		[ 1] = RCAR_GP_PIN(1, 20),	/* CS0_N */
> +		[ 2] = RCAR_GP_PIN(1, 21),	/* CS1_N_A26 */
> +		[ 3] = RCAR_GP_PIN(1, 22),	/* BS_N */
> +		[ 4] = RCAR_GP_PIN(1, 23),	/* RD_N */
> +		[ 5] = RCAR_GP_PIN(1, 24),	/* RD_WR_N */
> +		[ 6] = RCAR_GP_PIN(1, 25),	/* WE0_N */
> +		[ 7] = RCAR_GP_PIN(1, 26),	/* WE1_N */
> +		[ 8] = RCAR_GP_PIN(1, 27),	/* EX_WAIT0_A */
> +		[ 9] = PIN_NUMBER('C', 1),	/* PRESETOUT# */
> +		[10] = RCAR_GP_PIN(0,  0),	/* D0 */
> +		[11] = RCAR_GP_PIN(0,  1),	/* D1 */
> +		[12] = RCAR_GP_PIN(0,  2),	/* D2 */
> +		[13] = RCAR_GP_PIN(0,  3),	/* D3 */
> +		[14] = RCAR_GP_PIN(0,  4),	/* D4 */
> +		[15] = RCAR_GP_PIN(0,  5),	/* D5 */
> +		[16] = RCAR_GP_PIN(0,  6),	/* D6 */
> +		[17] = RCAR_GP_PIN(0,  7),	/* D7 */
> +		[18] = RCAR_GP_PIN(0,  8),	/* D8 */
> +		[19] = RCAR_GP_PIN(0,  9),	/* D9 */
> +		[20] = RCAR_GP_PIN(0, 10),	/* D10 */
> +		[21] = RCAR_GP_PIN(0, 11),	/* D11 */
> +		[22] = RCAR_GP_PIN(0, 12),	/* D12 */
> +		[23] = RCAR_GP_PIN(0, 13),	/* D13 */
> +		[24] = RCAR_GP_PIN(0, 14),	/* D14 */
> +		[25] = RCAR_GP_PIN(0, 15),	/* D15 */
> +		[26] = RCAR_GP_PIN(7,  0),	/* AVS1 */
> +		[27] = RCAR_GP_PIN(7,  1),	/* AVS2 */
> +		[28] = RCAR_GP_PIN(7,  2),	/* HDMI0_CEC */
> +		[29] = RCAR_GP_PIN(7,  3),	/* HDMI1_CEC */
> +		[30] = PIN_A_NUMBER('P', 7),	/* DU_DOTCLKIN0 */
> +		[31] = PIN_A_NUMBER('P', 8),	/* DU_DOTCLKIN1 */
> +	} },
> +	{ PINMUX_BIAS_REG("PUEN3", 0xe606040c, "PUD3", 0xe606044c) {
> +		[ 0] = PIN_A_NUMBER('R', 7),	/* DU_DOTCLKIN2 */
> +		[ 1] = PIN_A_NUMBER('R', 8),	/* DU_DOTCLKIN3 */
> +		[ 2] = PIN_A_NUMBER('D', 38),	/* FSCLKST# */
> +		[ 3] = PIN_A_NUMBER('D', 39),	/* EXTALR*/
> +		[ 4] = PIN_A_NUMBER('R', 26),	/* TRST# */
> +		[ 5] = PIN_A_NUMBER('T', 27),	/* TCK */
> +		[ 6] = PIN_A_NUMBER('R', 30),	/* TMS */
> +		[ 7] = PIN_A_NUMBER('R', 29),	/* TDI */
> +		[ 8] = PIN_NONE,
> +		[ 9] = PIN_A_NUMBER('T', 30),	/* ASEBRK */
> +		[10] = RCAR_GP_PIN(3,  0),	/* SD0_CLK */
> +		[11] = RCAR_GP_PIN(3,  1),	/* SD0_CMD */
> +		[12] = RCAR_GP_PIN(3,  2),	/* SD0_DAT0 */
> +		[13] = RCAR_GP_PIN(3,  3),	/* SD0_DAT1 */
> +		[14] = RCAR_GP_PIN(3,  4),	/* SD0_DAT2 */
> +		[15] = RCAR_GP_PIN(3,  5),	/* SD0_DAT3 */
> +		[16] = RCAR_GP_PIN(3,  6),	/* SD1_CLK */
> +		[17] = RCAR_GP_PIN(3,  7),	/* SD1_CMD */
> +		[18] = RCAR_GP_PIN(3,  8),	/* SD1_DAT0 */
> +		[19] = RCAR_GP_PIN(3,  9),	/* SD1_DAT1 */
> +		[20] = RCAR_GP_PIN(3, 10),	/* SD1_DAT2 */
> +		[21] = RCAR_GP_PIN(3, 11),	/* SD1_DAT3 */
> +		[22] = RCAR_GP_PIN(4,  0),	/* SD2_CLK */
> +		[23] = RCAR_GP_PIN(4,  1),	/* SD2_CMD */
> +		[24] = RCAR_GP_PIN(4,  2),	/* SD2_DAT0 */
> +		[25] = RCAR_GP_PIN(4,  3),	/* SD2_DAT1 */
> +		[26] = RCAR_GP_PIN(4,  4),	/* SD2_DAT2 */
> +		[27] = RCAR_GP_PIN(4,  5),	/* SD2_DAT3 */
> +		[28] = RCAR_GP_PIN(4,  6),	/* SD2_DS */
> +		[29] = RCAR_GP_PIN(4,  7),	/* SD3_CLK */
> +		[30] = RCAR_GP_PIN(4,  8),	/* SD3_CMD */
> +		[31] = RCAR_GP_PIN(4,  9),	/* SD3_DAT0 */
> +	} },
> +	{ PINMUX_BIAS_REG("PUEN4", 0xe6060410, "PUD4", 0xe6060450) {
> +		[ 0] = RCAR_GP_PIN(4, 10),	/* SD3_DAT1 */
> +		[ 1] = RCAR_GP_PIN(4, 11),	/* SD3_DAT2 */
> +		[ 2] = RCAR_GP_PIN(4, 12),	/* SD3_DAT3 */
> +		[ 3] = RCAR_GP_PIN(4, 13),	/* SD3_DAT4 */
> +		[ 4] = RCAR_GP_PIN(4, 14),	/* SD3_DAT5 */
> +		[ 5] = RCAR_GP_PIN(4, 15),	/* SD3_DAT6 */
> +		[ 6] = RCAR_GP_PIN(4, 16),	/* SD3_DAT7 */
> +		[ 7] = RCAR_GP_PIN(4, 17),	/* SD3_DS */
> +		[ 8] = RCAR_GP_PIN(3, 12),	/* SD0_CD */
> +		[ 9] = RCAR_GP_PIN(3, 13),	/* SD0_WP */
> +		[10] = RCAR_GP_PIN(3, 14),	/* SD1_CD */
> +		[11] = RCAR_GP_PIN(3, 15),	/* SD1_WP */
> +		[12] = RCAR_GP_PIN(5,  0),	/* SCK0 */
> +		[13] = RCAR_GP_PIN(5,  1),	/* RX0 */
> +		[14] = RCAR_GP_PIN(5,  2),	/* TX0 */
> +		[15] = RCAR_GP_PIN(5,  3),	/* CTS0_N */
> +		[16] = RCAR_GP_PIN(5,  4),	/* RTS0_N_TANS */
> +		[17] = RCAR_GP_PIN(5,  5),	/* RX1_A */
> +		[18] = RCAR_GP_PIN(5,  6),	/* TX1_A */
> +		[19] = RCAR_GP_PIN(5,  7),	/* CTS1_N */
> +		[20] = RCAR_GP_PIN(5,  8),	/* RTS1_N_TANS */
> +		[21] = RCAR_GP_PIN(5,  9),	/* SCK2 */
> +		[22] = RCAR_GP_PIN(5, 10),	/* TX2_A */
> +		[23] = RCAR_GP_PIN(5, 11),	/* RX2_A */
> +		[24] = RCAR_GP_PIN(5, 12),	/* HSCK0 */
> +		[25] = RCAR_GP_PIN(5, 13),	/* HRX0 */
> +		[26] = RCAR_GP_PIN(5, 14),	/* HTX0 */
> +		[27] = RCAR_GP_PIN(5, 15),	/* HCTS0_N */
> +		[28] = RCAR_GP_PIN(5, 16),	/* HRTS0_N */
> +		[29] = RCAR_GP_PIN(5, 17),	/* MSIOF0_SCK */
> +		[30] = RCAR_GP_PIN(5, 18),	/* MSIOF0_SYNC */
> +		[31] = RCAR_GP_PIN(5, 19),	/* MSIOF0_SS1 */
> +	} },
> +	{ PINMUX_BIAS_REG("PUEN5", 0xe6060414, "PUD5", 0xe6060454) {
> +		[ 0] = RCAR_GP_PIN(5, 20),	/* MSIOF0_TXD */
> +		[ 1] = RCAR_GP_PIN(5, 21),	/* MSIOF0_SS2 */
> +		[ 2] = RCAR_GP_PIN(5, 22),	/* MSIOF0_RXD */
> +		[ 3] = RCAR_GP_PIN(5, 23),	/* MLB_CLK */
> +		[ 4] = RCAR_GP_PIN(5, 24),	/* MLB_SIG */
> +		[ 5] = RCAR_GP_PIN(5, 25),	/* MLB_DAT */
> +		[ 6] = PIN_NUMBER('H', 37),	/* MLB_REF */
> +		[ 7] = RCAR_GP_PIN(6,  0),	/* SSI_SCK01239 */
> +		[ 8] = RCAR_GP_PIN(6,  1),	/* SSI_WS01239 */
> +		[ 9] = RCAR_GP_PIN(6,  2),	/* SSI_SDATA0 */
> +		[10] = RCAR_GP_PIN(6,  3),	/* SSI_SDATA1_A */
> +		[11] = RCAR_GP_PIN(6,  4),	/* SSI_SDATA2_A */
> +		[12] = RCAR_GP_PIN(6,  5),	/* SSI_SCK349 */
> +		[13] = RCAR_GP_PIN(6,  6),	/* SSI_WS349 */
> +		[14] = RCAR_GP_PIN(6,  7),	/* SSI_SDATA3 */
> +		[15] = RCAR_GP_PIN(6,  8),	/* SSI_SCK4 */
> +		[16] = RCAR_GP_PIN(6,  9),	/* SSI_WS4 */
> +		[17] = RCAR_GP_PIN(6, 10),	/* SSI_SDATA4 */
> +		[18] = RCAR_GP_PIN(6, 11),	/* SSI_SCK5 */
> +		[19] = RCAR_GP_PIN(6, 12),	/* SSI_WS5 */
> +		[20] = RCAR_GP_PIN(6, 13),	/* SSI_SDATA5 */
> +		[21] = RCAR_GP_PIN(6, 14),	/* SSI_SCK6 */
> +		[22] = RCAR_GP_PIN(6, 15),	/* SSI_WS6 */
> +		[23] = RCAR_GP_PIN(6, 16),	/* SSI_SDATA6 */
> +		[24] = RCAR_GP_PIN(6, 17),	/* SSI_SCK78 */
> +		[25] = RCAR_GP_PIN(6, 18),	/* SSI_WS78 */
> +		[26] = RCAR_GP_PIN(6, 19),	/* SSI_SDATA7 */
> +		[27] = RCAR_GP_PIN(6, 20),	/* SSI_SDATA8 */
> +		[28] = RCAR_GP_PIN(6, 21),	/* SSI_SDATA9_A */
> +		[29] = RCAR_GP_PIN(6, 22),	/* AUDIO_CLKA_A */
> +		[30] = RCAR_GP_PIN(6, 23),	/* AUDIO_CLKB_B */
> +		[31] = RCAR_GP_PIN(6, 24),	/* USB0_PWEN */
> +	} },
> +	{ PINMUX_BIAS_REG("PUEN6", 0xe6060418, "PUD6", 0xe6060458) {
> +		[ 0] = RCAR_GP_PIN(6, 25),	/* USB0_OVC */
> +		[ 1] = RCAR_GP_PIN(6, 26),	/* USB1_PWEN */
> +		[ 2] = RCAR_GP_PIN(6, 27),	/* USB1_OVC */
> +		[ 3] = RCAR_GP_PIN(6, 28),	/* USB30_PWEN */
> +		[ 4] = RCAR_GP_PIN(6, 29),	/* USB30_OVC */
> +		[ 5] = RCAR_GP_PIN(6, 30),	/* USB31_PWEN */
> +		[ 6] = RCAR_GP_PIN(6, 31),	/* USB31_OVC */
> +		[ 7] = PIN_NONE,
> +		[ 8] = PIN_NONE,
> +		[ 9] = PIN_NONE,
> +		[10] = PIN_NONE,
> +		[11] = PIN_NONE,
> +		[12] = PIN_NONE,
> +		[13] = PIN_NONE,
> +		[14] = PIN_NONE,
> +		[15] = PIN_NONE,
> +		[16] = PIN_NONE,
> +		[17] = PIN_NONE,
> +		[18] = PIN_NONE,
> +		[19] = PIN_NONE,
> +		[20] = PIN_NONE,
> +		[21] = PIN_NONE,
> +		[22] = PIN_NONE,
> +		[23] = PIN_NONE,
> +		[24] = PIN_NONE,
> +		[25] = PIN_NONE,
> +		[26] = PIN_NONE,
> +		[27] = PIN_NONE,
> +		[28] = PIN_NONE,
> +		[29] = PIN_NONE,
> +		[30] = PIN_NONE,
> +		[31] = PIN_NONE,
> +	} },
> +	{ },
>  };
> 
>  static unsigned int r8a7795es1_pinmux_get_bias(struct sh_pfc *pfc,
>  					       unsigned int pin)
>  {
> -	const struct sh_pfc_bias_info *info;
> -	u32 reg;
> -	u32 bit;
> +	const struct pinmux_bias_reg *reg;
> +	unsigned int bit;
> 
> -	info = sh_pfc_pin_to_bias_info(bias_info, ARRAY_SIZE(bias_info), pin);
> -	if (!info)
> +	reg = sh_pfc_pin_to_bias_reg(pfc, pin, &bit);
> +	if (!reg)
>  		return PIN_CONFIG_BIAS_DISABLE;
> 
> -	reg = info->reg;
> -	bit = BIT(info->bit);
> -
> -	if (!(sh_pfc_read_reg(pfc, PUEN + reg) & bit))
> +	if (!(sh_pfc_read_reg(pfc, reg->puen) & BIT(bit)))
>  		return PIN_CONFIG_BIAS_DISABLE;
> -	else if (sh_pfc_read_reg(pfc, PUD + reg) & bit)
> +	else if (sh_pfc_read_reg(pfc, reg->pud) & BIT(bit))
>  		return PIN_CONFIG_BIAS_PULL_UP;
>  	else
>  		return PIN_CONFIG_BIAS_PULL_DOWN;
> @@ -5682,28 +5702,24 @@ static unsigned int
> r8a7795es1_pinmux_get_bias(struct sh_pfc *pfc, static void
> r8a7795es1_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin, unsigned
> int bias)
>  {
> -	const struct sh_pfc_bias_info *info;
> +	const struct pinmux_bias_reg *reg;
>  	u32 enable, updown;
> -	u32 reg;
> -	u32 bit;
> +	unsigned int bit;
> 
> -	info = sh_pfc_pin_to_bias_info(bias_info, ARRAY_SIZE(bias_info), pin);
> -	if (!info)
> +	reg = sh_pfc_pin_to_bias_reg(pfc, pin, &bit);
> +	if (!reg)
>  		return;
> 
> -	reg = info->reg;
> -	bit = BIT(info->bit);
> -
> -	enable = sh_pfc_read_reg(pfc, PUEN + reg) & ~bit;
> +	enable = sh_pfc_read_reg(pfc, reg->puen) & ~BIT(bit);
>  	if (bias != PIN_CONFIG_BIAS_DISABLE)
> -		enable |= bit;
> +		enable |= BIT(bit);
> 
> -	updown = sh_pfc_read_reg(pfc, PUD + reg) & ~bit;
> +	updown = sh_pfc_read_reg(pfc, reg->pud) & ~BIT(bit);
>  	if (bias == PIN_CONFIG_BIAS_PULL_UP)
> -		updown |= bit;
> +		updown |= BIT(bit);
> 
> -	sh_pfc_write_reg(pfc, PUD + reg, updown);
> -	sh_pfc_write_reg(pfc, PUEN + reg, enable);
> +	sh_pfc_write_reg(pfc, reg->pud, updown);
> +	sh_pfc_write_reg(pfc, reg->puen, enable);
>  }
> 
>  static const struct sh_pfc_soc_operations r8a7795es1_pinmux_ops = {
> @@ -5728,6 +5744,7 @@ const struct sh_pfc_soc_info r8a7795es1_pinmux_info =
> {
> 
>  	.cfg_regs = pinmux_config_regs,
>  	.drive_regs = pinmux_drive_regs,
> +	.bias_regs = pinmux_bias_regs,
> 
>  	.pinmux_data = pinmux_data,
>  	.pinmux_data_size = ARRAY_SIZE(pinmux_data),


-- 
Regards,

Laurent Pinchart

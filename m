From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 08/14] pinctrl: sh-pfc: r8a7778: Use generic bias register description
Date: Wed,  4 Oct 2017 11:07:07 +0200
Message-ID: <1507108033-8606-9-git-send-email-geert+renesas@glider.be>
References: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from michel.telenet-ops.be ([195.130.137.88]:37462 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdJDJHV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2017 05:07:21 -0400
In-Reply-To: <1507108033-8606-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Move R-Car M1A bias support over to the generic way to describe bias
registers.

As the new description is more compact, this decreases kernel size by
ca. 148 bytes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested due to lack of hardware.
---
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 403 +++++++++++++++++++----------------
 1 file changed, 222 insertions(+), 181 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index c3af9ebee4afc7b0..e962c7c0d9012d85 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -2912,189 +2912,230 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ },
 };
 
-#define PUPR0	0x100
-#define PUPR1	0x104
-#define PUPR2	0x108
-#define PUPR3	0x10c
-#define PUPR4	0x110
-#define PUPR5	0x114
-
-static const struct sh_pfc_bias_info bias_info[] = {
-	{ RCAR_GP_PIN(0,  6), PUPR0,  0 },	/* A0 */
-	{ RCAR_GP_PIN(0,  7), PUPR0,  1 },	/* A1 */
-	{ RCAR_GP_PIN(0,  8), PUPR0,  2 },	/* A2 */
-	{ RCAR_GP_PIN(0,  9), PUPR0,  3 },	/* A3 */
-	{ RCAR_GP_PIN(0, 10), PUPR0,  4 },	/* A4 */
-	{ RCAR_GP_PIN(0, 11), PUPR0,  5 },	/* A5 */
-	{ RCAR_GP_PIN(0, 12), PUPR0,  6 },	/* A6 */
-	{ RCAR_GP_PIN(0, 13), PUPR0,  7 },	/* A7 */
-	{ RCAR_GP_PIN(0, 14), PUPR0,  8 },	/* A8 */
-	{ RCAR_GP_PIN(0, 15), PUPR0,  9 },	/* A9 */
-	{ RCAR_GP_PIN(0, 16), PUPR0, 10 },	/* A10 */
-	{ RCAR_GP_PIN(0, 17), PUPR0, 11 },	/* A11 */
-	{ RCAR_GP_PIN(0, 18), PUPR0, 12 },	/* A12 */
-	{ RCAR_GP_PIN(0, 19), PUPR0, 13 },	/* A13 */
-	{ RCAR_GP_PIN(0, 20), PUPR0, 14 },	/* A14 */
-	{ RCAR_GP_PIN(0, 21), PUPR0, 15 },	/* A15 */
-	{ RCAR_GP_PIN(0, 22), PUPR0, 16 },	/* A16 */
-	{ RCAR_GP_PIN(0, 23), PUPR0, 17 },	/* A17 */
-	{ RCAR_GP_PIN(0, 24), PUPR0, 18 },	/* A18 */
-	{ RCAR_GP_PIN(0, 25), PUPR0, 19 },	/* A19 */
-	{ RCAR_GP_PIN(0, 26), PUPR0, 20 },	/* A20 */
-	{ RCAR_GP_PIN(0, 27), PUPR0, 21 },	/* A21 */
-	{ RCAR_GP_PIN(0, 28), PUPR0, 22 },	/* A22 */
-	{ RCAR_GP_PIN(0, 29), PUPR0, 23 },	/* A23 */
-	{ RCAR_GP_PIN(0, 30), PUPR0, 24 },	/* A24 */
-	{ RCAR_GP_PIN(0, 31), PUPR0, 25 },	/* A25 */
-	{ RCAR_GP_PIN(1,  3), PUPR0, 26 },	/* /EX_CS0 */
-	{ RCAR_GP_PIN(1,  4), PUPR0, 27 },	/* /EX_CS1 */
-	{ RCAR_GP_PIN(1,  5), PUPR0, 28 },	/* /EX_CS2 */
-	{ RCAR_GP_PIN(1,  6), PUPR0, 29 },	/* /EX_CS3 */
-	{ RCAR_GP_PIN(1,  7), PUPR0, 30 },	/* /EX_CS4 */
-	{ RCAR_GP_PIN(1,  8), PUPR0, 31 },	/* /EX_CS5 */
-
-	{ RCAR_GP_PIN(0,  0), PUPR1,  0 },	/* /PRESETOUT	*/
-	{ RCAR_GP_PIN(0,  5), PUPR1,  1 },	/* /BS		*/
-	{ RCAR_GP_PIN(1,  0), PUPR1,  2 },	/* RD//WR	*/
-	{ RCAR_GP_PIN(1,  1), PUPR1,  3 },	/* /WE0		*/
-	{ RCAR_GP_PIN(1,  2), PUPR1,  4 },	/* /WE1		*/
-	{ RCAR_GP_PIN(1, 11), PUPR1,  5 },	/* EX_WAIT0	*/
-	{ RCAR_GP_PIN(1,  9), PUPR1,  6 },	/* DREQ0	*/
-	{ RCAR_GP_PIN(1, 10), PUPR1,  7 },	/* DACK0	*/
-	{ RCAR_GP_PIN(1, 12), PUPR1,  8 },	/* IRQ0		*/
-	{ RCAR_GP_PIN(1, 13), PUPR1,  9 },	/* IRQ1		*/
-
-	{ RCAR_GP_PIN(1, 22), PUPR2,  0 },	/* DU0_DR0	*/
-	{ RCAR_GP_PIN(1, 23), PUPR2,  1 },	/* DU0_DR1	*/
-	{ RCAR_GP_PIN(1, 24), PUPR2,  2 },	/* DU0_DR2	*/
-	{ RCAR_GP_PIN(1, 25), PUPR2,  3 },	/* DU0_DR3	*/
-	{ RCAR_GP_PIN(1, 26), PUPR2,  4 },	/* DU0_DR4	*/
-	{ RCAR_GP_PIN(1, 27), PUPR2,  5 },	/* DU0_DR5	*/
-	{ RCAR_GP_PIN(1, 28), PUPR2,  6 },	/* DU0_DR6	*/
-	{ RCAR_GP_PIN(1, 29), PUPR2,  7 },	/* DU0_DR7	*/
-	{ RCAR_GP_PIN(1, 30), PUPR2,  8 },	/* DU0_DG0	*/
-	{ RCAR_GP_PIN(1, 31), PUPR2,  9 },	/* DU0_DG1	*/
-	{ RCAR_GP_PIN(2,  0), PUPR2, 10 },	/* DU0_DG2	*/
-	{ RCAR_GP_PIN(2,  1), PUPR2, 11 },	/* DU0_DG3	*/
-	{ RCAR_GP_PIN(2,  2), PUPR2, 12 },	/* DU0_DG4	*/
-	{ RCAR_GP_PIN(2,  3), PUPR2, 13 },	/* DU0_DG5	*/
-	{ RCAR_GP_PIN(2,  4), PUPR2, 14 },	/* DU0_DG6	*/
-	{ RCAR_GP_PIN(2,  5), PUPR2, 15 },	/* DU0_DG7	*/
-	{ RCAR_GP_PIN(2,  6), PUPR2, 16 },	/* DU0_DB0	*/
-	{ RCAR_GP_PIN(2,  7), PUPR2, 17 },	/* DU0_DB1	*/
-	{ RCAR_GP_PIN(2,  8), PUPR2, 18 },	/* DU0_DB2	*/
-	{ RCAR_GP_PIN(2,  9), PUPR2, 19 },	/* DU0_DB3	*/
-	{ RCAR_GP_PIN(2, 10), PUPR2, 20 },	/* DU0_DB4	*/
-	{ RCAR_GP_PIN(2, 11), PUPR2, 21 },	/* DU0_DB5	*/
-	{ RCAR_GP_PIN(2, 12), PUPR2, 22 },	/* DU0_DB6	*/
-	{ RCAR_GP_PIN(2, 13), PUPR2, 23 },	/* DU0_DB7	*/
-	{ RCAR_GP_PIN(2, 14), PUPR2, 24 },	/* DU0_DOTCLKIN	*/
-	{ RCAR_GP_PIN(2, 15), PUPR2, 25 },	/* DU0_DOTCLKOUT0 */
-	{ RCAR_GP_PIN(2, 17), PUPR2, 26 },	/* DU0_HSYNC	*/
-	{ RCAR_GP_PIN(2, 18), PUPR2, 27 },	/* DU0_VSYNC	*/
-	{ RCAR_GP_PIN(2, 19), PUPR2, 28 },	/* DU0_EXODDF	*/
-	{ RCAR_GP_PIN(2, 20), PUPR2, 29 },	/* DU0_DISP	*/
-	{ RCAR_GP_PIN(2, 21), PUPR2, 30 },	/* DU0_CDE	*/
-	{ RCAR_GP_PIN(2, 16), PUPR2, 31 },	/* DU0_DOTCLKOUT1 */
-
-	{ RCAR_GP_PIN(3, 24), PUPR3,  0 },	/* VI0_CLK	*/
-	{ RCAR_GP_PIN(3, 25), PUPR3,  1 },	/* VI0_CLKENB	*/
-	{ RCAR_GP_PIN(3, 26), PUPR3,  2 },	/* VI0_FIELD	*/
-	{ RCAR_GP_PIN(3, 27), PUPR3,  3 },	/* /VI0_HSYNC	*/
-	{ RCAR_GP_PIN(3, 28), PUPR3,  4 },	/* /VI0_VSYNC	*/
-	{ RCAR_GP_PIN(3, 29), PUPR3,  5 },	/* VI0_DATA0	*/
-	{ RCAR_GP_PIN(3, 30), PUPR3,  6 },	/* VI0_DATA1	*/
-	{ RCAR_GP_PIN(3, 31), PUPR3,  7 },	/* VI0_DATA2	*/
-	{ RCAR_GP_PIN(4,  0), PUPR3,  8 },	/* VI0_DATA3	*/
-	{ RCAR_GP_PIN(4,  1), PUPR3,  9 },	/* VI0_DATA4	*/
-	{ RCAR_GP_PIN(4,  2), PUPR3, 10 },	/* VI0_DATA5	*/
-	{ RCAR_GP_PIN(4,  3), PUPR3, 11 },	/* VI0_DATA6	*/
-	{ RCAR_GP_PIN(4,  4), PUPR3, 12 },	/* VI0_DATA7	*/
-	{ RCAR_GP_PIN(4,  5), PUPR3, 13 },	/* VI0_G2	*/
-	{ RCAR_GP_PIN(4,  6), PUPR3, 14 },	/* VI0_G3	*/
-	{ RCAR_GP_PIN(4,  7), PUPR3, 15 },	/* VI0_G4	*/
-	{ RCAR_GP_PIN(4,  8), PUPR3, 16 },	/* VI0_G5	*/
-	{ RCAR_GP_PIN(4, 21), PUPR3, 17 },	/* VI1_DATA12	*/
-	{ RCAR_GP_PIN(4, 22), PUPR3, 18 },	/* VI1_DATA13	*/
-	{ RCAR_GP_PIN(4, 23), PUPR3, 19 },	/* VI1_DATA14	*/
-	{ RCAR_GP_PIN(4, 24), PUPR3, 20 },	/* VI1_DATA15	*/
-	{ RCAR_GP_PIN(4,  9), PUPR3, 21 },	/* ETH_REF_CLK	*/
-	{ RCAR_GP_PIN(4, 10), PUPR3, 22 },	/* ETH_TXD0	*/
-	{ RCAR_GP_PIN(4, 11), PUPR3, 23 },	/* ETH_TXD1	*/
-	{ RCAR_GP_PIN(4, 12), PUPR3, 24 },	/* ETH_CRS_DV	*/
-	{ RCAR_GP_PIN(4, 13), PUPR3, 25 },	/* ETH_TX_EN	*/
-	{ RCAR_GP_PIN(4, 14), PUPR3, 26 },	/* ETH_RX_ER	*/
-	{ RCAR_GP_PIN(4, 15), PUPR3, 27 },	/* ETH_RXD0	*/
-	{ RCAR_GP_PIN(4, 16), PUPR3, 28 },	/* ETH_RXD1	*/
-	{ RCAR_GP_PIN(4, 17), PUPR3, 29 },	/* ETH_MDC	*/
-	{ RCAR_GP_PIN(4, 18), PUPR3, 30 },	/* ETH_MDIO	*/
-	{ RCAR_GP_PIN(4, 19), PUPR3, 31 },	/* ETH_LINK	*/
-
-	{ RCAR_GP_PIN(3,  6), PUPR4,  0 },	/* SSI_SCK012	*/
-	{ RCAR_GP_PIN(3,  7), PUPR4,  1 },	/* SSI_WS012	*/
-	{ RCAR_GP_PIN(3, 10), PUPR4,  2 },	/* SSI_SDATA0	*/
-	{ RCAR_GP_PIN(3,  9), PUPR4,  3 },	/* SSI_SDATA1	*/
-	{ RCAR_GP_PIN(3,  8), PUPR4,  4 },	/* SSI_SDATA2	*/
-	{ RCAR_GP_PIN(3,  2), PUPR4,  5 },	/* SSI_SCK34	*/
-	{ RCAR_GP_PIN(3,  3), PUPR4,  6 },	/* SSI_WS34	*/
-	{ RCAR_GP_PIN(3,  5), PUPR4,  7 },	/* SSI_SDATA3	*/
-	{ RCAR_GP_PIN(3,  4), PUPR4,  8 },	/* SSI_SDATA4	*/
-	{ RCAR_GP_PIN(2, 31), PUPR4,  9 },	/* SSI_SCK5	*/
-	{ RCAR_GP_PIN(3,  0), PUPR4, 10 },	/* SSI_WS5	*/
-	{ RCAR_GP_PIN(3,  1), PUPR4, 11 },	/* SSI_SDATA5	*/
-	{ RCAR_GP_PIN(2, 28), PUPR4, 12 },	/* SSI_SCK6	*/
-	{ RCAR_GP_PIN(2, 29), PUPR4, 13 },	/* SSI_WS6	*/
-	{ RCAR_GP_PIN(2, 30), PUPR4, 14 },	/* SSI_SDATA6	*/
-	{ RCAR_GP_PIN(2, 24), PUPR4, 15 },	/* SSI_SCK78	*/
-	{ RCAR_GP_PIN(2, 25), PUPR4, 16 },	/* SSI_WS78	*/
-	{ RCAR_GP_PIN(2, 27), PUPR4, 17 },	/* SSI_SDATA7	*/
-	{ RCAR_GP_PIN(2, 26), PUPR4, 18 },	/* SSI_SDATA8	*/
-	{ RCAR_GP_PIN(3, 23), PUPR4, 19 },	/* TCLK0	*/
-	{ RCAR_GP_PIN(3, 11), PUPR4, 20 },	/* SD0_CLK	*/
-	{ RCAR_GP_PIN(3, 12), PUPR4, 21 },	/* SD0_CMD	*/
-	{ RCAR_GP_PIN(3, 13), PUPR4, 22 },	/* SD0_DAT0	*/
-	{ RCAR_GP_PIN(3, 14), PUPR4, 23 },	/* SD0_DAT1	*/
-	{ RCAR_GP_PIN(3, 15), PUPR4, 24 },	/* SD0_DAT2	*/
-	{ RCAR_GP_PIN(3, 16), PUPR4, 25 },	/* SD0_DAT3	*/
-	{ RCAR_GP_PIN(3, 17), PUPR4, 26 },	/* SD0_CD	*/
-	{ RCAR_GP_PIN(3, 18), PUPR4, 27 },	/* SD0_WP	*/
-	{ RCAR_GP_PIN(2, 22), PUPR4, 28 },	/* AUDIO_CLKA	*/
-	{ RCAR_GP_PIN(2, 23), PUPR4, 29 },	/* AUDIO_CLKB	*/
-	{ RCAR_GP_PIN(1, 14), PUPR4, 30 },	/* IRQ2		*/
-	{ RCAR_GP_PIN(1, 15), PUPR4, 31 },	/* IRQ3		*/
-
-	{ RCAR_GP_PIN(0,  1), PUPR5,  0 },	/* PENC0	*/
-	{ RCAR_GP_PIN(0,  2), PUPR5,  1 },	/* PENC1	*/
-	{ RCAR_GP_PIN(0,  3), PUPR5,  2 },	/* USB_OVC0	*/
-	{ RCAR_GP_PIN(0,  4), PUPR5,  3 },	/* USB_OVC1	*/
-	{ RCAR_GP_PIN(1, 16), PUPR5,  4 },	/* SCIF_CLK	*/
-	{ RCAR_GP_PIN(1, 17), PUPR5,  5 },	/* TX0		*/
-	{ RCAR_GP_PIN(1, 18), PUPR5,  6 },	/* RX0		*/
-	{ RCAR_GP_PIN(1, 19), PUPR5,  7 },	/* SCK0		*/
-	{ RCAR_GP_PIN(1, 20), PUPR5,  8 },	/* /CTS0	*/
-	{ RCAR_GP_PIN(1, 21), PUPR5,  9 },	/* /RTS0	*/
-	{ RCAR_GP_PIN(3, 19), PUPR5, 10 },	/* HSPI_CLK0	*/
-	{ RCAR_GP_PIN(3, 20), PUPR5, 11 },	/* /HSPI_CS0	*/
-	{ RCAR_GP_PIN(3, 21), PUPR5, 12 },	/* HSPI_RX0	*/
-	{ RCAR_GP_PIN(3, 22), PUPR5, 13 },	/* HSPI_TX0	*/
-	{ RCAR_GP_PIN(4, 20), PUPR5, 14 },	/* ETH_MAGIC	*/
-	{ RCAR_GP_PIN(4, 25), PUPR5, 15 },	/* AVS1		*/
-	{ RCAR_GP_PIN(4, 26), PUPR5, 16 },	/* AVS2		*/
+#define PIN_NONE	U16_MAX
+
+static const struct pinmux_bias_reg pinmux_bias_regs[] = {
+	{ PINMUX_BIAS_REG("PUPR0", 0x100, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(0,  6),	/* A0 */
+		[ 1] = RCAR_GP_PIN(0,  7),	/* A1 */
+		[ 2] = RCAR_GP_PIN(0,  8),	/* A2 */
+		[ 3] = RCAR_GP_PIN(0,  9),	/* A3 */
+		[ 4] = RCAR_GP_PIN(0, 10),	/* A4 */
+		[ 5] = RCAR_GP_PIN(0, 11),	/* A5 */
+		[ 6] = RCAR_GP_PIN(0, 12),	/* A6 */
+		[ 7] = RCAR_GP_PIN(0, 13),	/* A7 */
+		[ 8] = RCAR_GP_PIN(0, 14),	/* A8 */
+		[ 9] = RCAR_GP_PIN(0, 15),	/* A9 */
+		[10] = RCAR_GP_PIN(0, 16),	/* A10 */
+		[11] = RCAR_GP_PIN(0, 17),	/* A11 */
+		[12] = RCAR_GP_PIN(0, 18),	/* A12 */
+		[13] = RCAR_GP_PIN(0, 19),	/* A13 */
+		[14] = RCAR_GP_PIN(0, 20),	/* A14 */
+		[15] = RCAR_GP_PIN(0, 21),	/* A15 */
+		[16] = RCAR_GP_PIN(0, 22),	/* A16 */
+		[17] = RCAR_GP_PIN(0, 23),	/* A17 */
+		[18] = RCAR_GP_PIN(0, 24),	/* A18 */
+		[19] = RCAR_GP_PIN(0, 25),	/* A19 */
+		[20] = RCAR_GP_PIN(0, 26),	/* A20 */
+		[21] = RCAR_GP_PIN(0, 27),	/* A21 */
+		[22] = RCAR_GP_PIN(0, 28),	/* A22 */
+		[23] = RCAR_GP_PIN(0, 29),	/* A23 */
+		[24] = RCAR_GP_PIN(0, 30),	/* A24 */
+		[25] = RCAR_GP_PIN(0, 31),	/* A25 */
+		[26] = RCAR_GP_PIN(1,  3),	/* /EX_CS0 */
+		[27] = RCAR_GP_PIN(1,  4),	/* /EX_CS1 */
+		[28] = RCAR_GP_PIN(1,  5),	/* /EX_CS2 */
+		[29] = RCAR_GP_PIN(1,  6),	/* /EX_CS3 */
+		[30] = RCAR_GP_PIN(1,  7),	/* /EX_CS4 */
+		[31] = RCAR_GP_PIN(1,  8),	/* /EX_CS5 */
+	} },
+	{ PINMUX_BIAS_REG("PUPR1", 0x104, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(0,  0),	/* /PRESETOUT	*/
+		[ 1] = RCAR_GP_PIN(0,  5),	/* /BS		*/
+		[ 2] = RCAR_GP_PIN(1,  0),	/* RD//WR	*/
+		[ 3] = RCAR_GP_PIN(1,  1),	/* /WE0		*/
+		[ 4] = RCAR_GP_PIN(1,  2),	/* /WE1		*/
+		[ 5] = RCAR_GP_PIN(1, 11),	/* EX_WAIT0	*/
+		[ 6] = RCAR_GP_PIN(1,  9),	/* DREQ0	*/
+		[ 7] = RCAR_GP_PIN(1, 10),	/* DACK0	*/
+		[ 8] = RCAR_GP_PIN(1, 12),	/* IRQ0		*/
+		[ 9] = RCAR_GP_PIN(1, 13),	/* IRQ1		*/
+		[10] = PIN_NONE,
+		[11] = PIN_NONE,
+		[12] = PIN_NONE,
+		[13] = PIN_NONE,
+		[14] = PIN_NONE,
+		[15] = PIN_NONE,
+		[16] = PIN_NONE,
+		[17] = PIN_NONE,
+		[18] = PIN_NONE,
+		[19] = PIN_NONE,
+		[20] = PIN_NONE,
+		[21] = PIN_NONE,
+		[22] = PIN_NONE,
+		[23] = PIN_NONE,
+		[24] = PIN_NONE,
+		[25] = PIN_NONE,
+		[26] = PIN_NONE,
+		[27] = PIN_NONE,
+		[28] = PIN_NONE,
+		[29] = PIN_NONE,
+		[30] = PIN_NONE,
+		[31] = PIN_NONE,
+	} },
+	{ PINMUX_BIAS_REG("PUPR2", 0x108, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(1, 22),	/* DU0_DR0	*/
+		[ 1] = RCAR_GP_PIN(1, 23),	/* DU0_DR1	*/
+		[ 2] = RCAR_GP_PIN(1, 24),	/* DU0_DR2	*/
+		[ 3] = RCAR_GP_PIN(1, 25),	/* DU0_DR3	*/
+		[ 4] = RCAR_GP_PIN(1, 26),	/* DU0_DR4	*/
+		[ 5] = RCAR_GP_PIN(1, 27),	/* DU0_DR5	*/
+		[ 6] = RCAR_GP_PIN(1, 28),	/* DU0_DR6	*/
+		[ 7] = RCAR_GP_PIN(1, 29),	/* DU0_DR7	*/
+		[ 8] = RCAR_GP_PIN(1, 30),	/* DU0_DG0	*/
+		[ 9] = RCAR_GP_PIN(1, 31),	/* DU0_DG1	*/
+		[10] = RCAR_GP_PIN(2,  0),	/* DU0_DG2	*/
+		[11] = RCAR_GP_PIN(2,  1),	/* DU0_DG3	*/
+		[12] = RCAR_GP_PIN(2,  2),	/* DU0_DG4	*/
+		[13] = RCAR_GP_PIN(2,  3),	/* DU0_DG5	*/
+		[14] = RCAR_GP_PIN(2,  4),	/* DU0_DG6	*/
+		[15] = RCAR_GP_PIN(2,  5),	/* DU0_DG7	*/
+		[16] = RCAR_GP_PIN(2,  6),	/* DU0_DB0	*/
+		[17] = RCAR_GP_PIN(2,  7),	/* DU0_DB1	*/
+		[18] = RCAR_GP_PIN(2,  8),	/* DU0_DB2	*/
+		[19] = RCAR_GP_PIN(2,  9),	/* DU0_DB3	*/
+		[20] = RCAR_GP_PIN(2, 10),	/* DU0_DB4	*/
+		[21] = RCAR_GP_PIN(2, 11),	/* DU0_DB5	*/
+		[22] = RCAR_GP_PIN(2, 12),	/* DU0_DB6	*/
+		[23] = RCAR_GP_PIN(2, 13),	/* DU0_DB7	*/
+		[24] = RCAR_GP_PIN(2, 14),	/* DU0_DOTCLKIN	*/
+		[25] = RCAR_GP_PIN(2, 15),	/* DU0_DOTCLKOUT0 */
+		[26] = RCAR_GP_PIN(2, 17),	/* DU0_HSYNC	*/
+		[27] = RCAR_GP_PIN(2, 18),	/* DU0_VSYNC	*/
+		[28] = RCAR_GP_PIN(2, 19),	/* DU0_EXODDF	*/
+		[29] = RCAR_GP_PIN(2, 20),	/* DU0_DISP	*/
+		[30] = RCAR_GP_PIN(2, 21),	/* DU0_CDE	*/
+		[31] = RCAR_GP_PIN(2, 16),	/* DU0_DOTCLKOUT1 */
+	} },
+	{ PINMUX_BIAS_REG("PUPR3", 0x10c, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(3, 24),	/* VI0_CLK	*/
+		[ 1] = RCAR_GP_PIN(3, 25),	/* VI0_CLKENB	*/
+		[ 2] = RCAR_GP_PIN(3, 26),	/* VI0_FIELD	*/
+		[ 3] = RCAR_GP_PIN(3, 27),	/* /VI0_HSYNC	*/
+		[ 4] = RCAR_GP_PIN(3, 28),	/* /VI0_VSYNC	*/
+		[ 5] = RCAR_GP_PIN(3, 29),	/* VI0_DATA0	*/
+		[ 6] = RCAR_GP_PIN(3, 30),	/* VI0_DATA1	*/
+		[ 7] = RCAR_GP_PIN(3, 31),	/* VI0_DATA2	*/
+		[ 8] = RCAR_GP_PIN(4,  0),	/* VI0_DATA3	*/
+		[ 9] = RCAR_GP_PIN(4,  1),	/* VI0_DATA4	*/
+		[10] = RCAR_GP_PIN(4,  2),	/* VI0_DATA5	*/
+		[11] = RCAR_GP_PIN(4,  3),	/* VI0_DATA6	*/
+		[12] = RCAR_GP_PIN(4,  4),	/* VI0_DATA7	*/
+		[13] = RCAR_GP_PIN(4,  5),	/* VI0_G2	*/
+		[14] = RCAR_GP_PIN(4,  6),	/* VI0_G3	*/
+		[15] = RCAR_GP_PIN(4,  7),	/* VI0_G4	*/
+		[16] = RCAR_GP_PIN(4,  8),	/* VI0_G5	*/
+		[17] = RCAR_GP_PIN(4, 21),	/* VI1_DATA12	*/
+		[18] = RCAR_GP_PIN(4, 22),	/* VI1_DATA13	*/
+		[19] = RCAR_GP_PIN(4, 23),	/* VI1_DATA14	*/
+		[20] = RCAR_GP_PIN(4, 24),	/* VI1_DATA15	*/
+		[21] = RCAR_GP_PIN(4,  9),	/* ETH_REF_CLK	*/
+		[22] = RCAR_GP_PIN(4, 10),	/* ETH_TXD0	*/
+		[23] = RCAR_GP_PIN(4, 11),	/* ETH_TXD1	*/
+		[24] = RCAR_GP_PIN(4, 12),	/* ETH_CRS_DV	*/
+		[25] = RCAR_GP_PIN(4, 13),	/* ETH_TX_EN	*/
+		[26] = RCAR_GP_PIN(4, 14),	/* ETH_RX_ER	*/
+		[27] = RCAR_GP_PIN(4, 15),	/* ETH_RXD0	*/
+		[28] = RCAR_GP_PIN(4, 16),	/* ETH_RXD1	*/
+		[29] = RCAR_GP_PIN(4, 17),	/* ETH_MDC	*/
+		[30] = RCAR_GP_PIN(4, 18),	/* ETH_MDIO	*/
+		[31] = RCAR_GP_PIN(4, 19),	/* ETH_LINK	*/
+	} },
+	{ PINMUX_BIAS_REG("PUPR4", 0x110, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(3,  6),	/* SSI_SCK012	*/
+		[ 1] = RCAR_GP_PIN(3,  7),	/* SSI_WS012	*/
+		[ 2] = RCAR_GP_PIN(3, 10),	/* SSI_SDATA0	*/
+		[ 3] = RCAR_GP_PIN(3,  9),	/* SSI_SDATA1	*/
+		[ 4] = RCAR_GP_PIN(3,  8),	/* SSI_SDATA2	*/
+		[ 5] = RCAR_GP_PIN(3,  2),	/* SSI_SCK34	*/
+		[ 6] = RCAR_GP_PIN(3,  3),	/* SSI_WS34	*/
+		[ 7] = RCAR_GP_PIN(3,  5),	/* SSI_SDATA3	*/
+		[ 8] = RCAR_GP_PIN(3,  4),	/* SSI_SDATA4	*/
+		[ 9] = RCAR_GP_PIN(2, 31),	/* SSI_SCK5	*/
+		[10] = RCAR_GP_PIN(3,  0),	/* SSI_WS5	*/
+		[11] = RCAR_GP_PIN(3,  1),	/* SSI_SDATA5	*/
+		[12] = RCAR_GP_PIN(2, 28),	/* SSI_SCK6	*/
+		[13] = RCAR_GP_PIN(2, 29),	/* SSI_WS6	*/
+		[14] = RCAR_GP_PIN(2, 30),	/* SSI_SDATA6	*/
+		[15] = RCAR_GP_PIN(2, 24),	/* SSI_SCK78	*/
+		[16] = RCAR_GP_PIN(2, 25),	/* SSI_WS78	*/
+		[17] = RCAR_GP_PIN(2, 27),	/* SSI_SDATA7	*/
+		[18] = RCAR_GP_PIN(2, 26),	/* SSI_SDATA8	*/
+		[19] = RCAR_GP_PIN(3, 23),	/* TCLK0	*/
+		[20] = RCAR_GP_PIN(3, 11),	/* SD0_CLK	*/
+		[21] = RCAR_GP_PIN(3, 12),	/* SD0_CMD	*/
+		[22] = RCAR_GP_PIN(3, 13),	/* SD0_DAT0	*/
+		[23] = RCAR_GP_PIN(3, 14),	/* SD0_DAT1	*/
+		[24] = RCAR_GP_PIN(3, 15),	/* SD0_DAT2	*/
+		[25] = RCAR_GP_PIN(3, 16),	/* SD0_DAT3	*/
+		[26] = RCAR_GP_PIN(3, 17),	/* SD0_CD	*/
+		[27] = RCAR_GP_PIN(3, 18),	/* SD0_WP	*/
+		[28] = RCAR_GP_PIN(2, 22),	/* AUDIO_CLKA	*/
+		[29] = RCAR_GP_PIN(2, 23),	/* AUDIO_CLKB	*/
+		[30] = RCAR_GP_PIN(1, 14),	/* IRQ2		*/
+		[31] = RCAR_GP_PIN(1, 15),	/* IRQ3		*/
+	} },
+	{ PINMUX_BIAS_REG("PUPR5", 0x114, "N/A", 0) {
+		[ 0] = RCAR_GP_PIN(0,  1),	/* PENC0	*/
+		[ 1] = RCAR_GP_PIN(0,  2),	/* PENC1	*/
+		[ 2] = RCAR_GP_PIN(0,  3),	/* USB_OVC0	*/
+		[ 3] = RCAR_GP_PIN(0,  4),	/* USB_OVC1	*/
+		[ 4] = RCAR_GP_PIN(1, 16),	/* SCIF_CLK	*/
+		[ 5] = RCAR_GP_PIN(1, 17),	/* TX0		*/
+		[ 6] = RCAR_GP_PIN(1, 18),	/* RX0		*/
+		[ 7] = RCAR_GP_PIN(1, 19),	/* SCK0		*/
+		[ 8] = RCAR_GP_PIN(1, 20),	/* /CTS0	*/
+		[ 9] = RCAR_GP_PIN(1, 21),	/* /RTS0	*/
+		[10] = RCAR_GP_PIN(3, 19),	/* HSPI_CLK0	*/
+		[11] = RCAR_GP_PIN(3, 20),	/* /HSPI_CS0	*/
+		[12] = RCAR_GP_PIN(3, 21),	/* HSPI_RX0	*/
+		[13] = RCAR_GP_PIN(3, 22),	/* HSPI_TX0	*/
+		[14] = RCAR_GP_PIN(4, 20),	/* ETH_MAGIC	*/
+		[15] = RCAR_GP_PIN(4, 25),	/* AVS1		*/
+		[16] = RCAR_GP_PIN(4, 26),	/* AVS2		*/
+		[17] = PIN_NONE,
+		[18] = PIN_NONE,
+		[19] = PIN_NONE,
+		[20] = PIN_NONE,
+		[21] = PIN_NONE,
+		[22] = PIN_NONE,
+		[23] = PIN_NONE,
+		[24] = PIN_NONE,
+		[25] = PIN_NONE,
+		[26] = PIN_NONE,
+		[27] = PIN_NONE,
+		[28] = PIN_NONE,
+		[29] = PIN_NONE,
+		[30] = PIN_NONE,
+		[31] = PIN_NONE,
+	} },
+	{ },
 };
 
 static unsigned int r8a7778_pinmux_get_bias(struct sh_pfc *pfc,
 					    unsigned int pin)
 {
-	const struct sh_pfc_bias_info *info;
+	const struct pinmux_bias_reg *reg;
 	void __iomem *addr;
+	unsigned int bit;
 
-	info = sh_pfc_pin_to_bias_info(bias_info, ARRAY_SIZE(bias_info), pin);
-	if (!info)
+	reg = sh_pfc_pin_to_bias_reg(pfc, pin, &bit);
+	if (!reg)
 		return PIN_CONFIG_BIAS_DISABLE;
 
-	addr = pfc->windows->virt + info->reg;
+	addr = pfc->windows->virt + reg->puen;
 
-	if (ioread32(addr) & BIT(info->bit))
+	if (ioread32(addr) & BIT(bit))
 		return PIN_CONFIG_BIAS_PULL_UP;
 	else
 		return PIN_CONFIG_BIAS_DISABLE;
@@ -3103,21 +3144,20 @@ static unsigned int r8a7778_pinmux_get_bias(struct sh_pfc *pfc,
 static void r8a7778_pinmux_set_bias(struct sh_pfc *pfc, unsigned int pin,
 				   unsigned int bias)
 {
-	const struct sh_pfc_bias_info *info;
+	const struct pinmux_bias_reg *reg;
 	void __iomem *addr;
+	unsigned int bit;
 	u32 value;
-	u32 bit;
 
-	info = sh_pfc_pin_to_bias_info(bias_info, ARRAY_SIZE(bias_info), pin);
-	if (!info)
+	reg = sh_pfc_pin_to_bias_reg(pfc, pin, &bit);
+	if (!reg)
 		return;
 
-	addr = pfc->windows->virt + info->reg;
-	bit = BIT(info->bit);
+	addr = pfc->windows->virt + reg->puen;
 
-	value = ioread32(addr) & ~bit;
+	value = ioread32(addr) & ~BIT(bit);
 	if (bias == PIN_CONFIG_BIAS_PULL_UP)
-		value |= bit;
+		value |= BIT(bit);
 	iowrite32(value, addr);
 }
 
@@ -3144,6 +3184,7 @@ const struct sh_pfc_soc_info r8a7778_pinmux_info = {
 	.nr_functions = ARRAY_SIZE(pinmux_functions),
 
 	.cfg_regs = pinmux_config_regs,
+	.bias_regs = pinmux_bias_regs,
 
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
-- 
2.7.4

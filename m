From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 02/26] ARM: pxa: magician: Change comments to be more
 informative
Date: Thu, 17 Sep 2015 06:55:01 +0200
Message-ID: <55FA47A5.1050609@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, g.liakhovetski@gmx.de
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch changes the comments in the HTC Magician machine source code
to better describe used devices and interfaces.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 46 +++++++++++++++++++++++++++++-------=
--------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.=
c
index c10f932..c8fa379 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -57,31 +57,31 @@ static unsigned long magician_pin_config[] __initda=
ta =3D {
 	GPIO80_nCS_4,
 	GPIO33_nCS_5,
=20
-	/* I2C */
+	/* I2C UDA1380 + OV9640 */
 	GPIO117_I2C_SCL,
 	GPIO118_I2C_SDA,
=20
-	/* PWM 0 */
+	/* PWM 0 - LCD backlight */
 	GPIO16_PWM0_OUT,
=20
-	/* I2S */
+	/* I2S UDA1380 capture */
 	GPIO28_I2S_BITCLK_OUT,
 	GPIO29_I2S_SDATA_IN,
 	GPIO31_I2S_SYNC,
 	GPIO113_I2S_SYSCLK,
=20
-	/* SSP 1 */
+	/* SSP 1 UDA1380 playback */
 	GPIO23_SSP1_SCLK,
 	GPIO24_SSP1_SFRM,
 	GPIO25_SSP1_TXD,
=20
-	/* SSP 2 */
+	/* SSP 2 TSC2046 touchscreen */
 	GPIO19_SSP2_SCLK,
 	GPIO14_SSP2_SFRM,
 	GPIO89_SSP2_TXD,
 	GPIO88_SSP2_RXD,
=20
-	/* MMC */
+	/* MMC/SD/SDHC slot */
 	GPIO32_MMC_CLK,
 	GPIO92_MMC_DAT_0,
 	GPIO109_MMC_DAT_1,
@@ -92,7 +92,7 @@ static unsigned long magician_pin_config[] __initdata=
 =3D {
 	/* LCD */
 	GPIOxx_LCD_TFT_16BPP,
=20
-	/* QCI */
+	/* QCI camera interface */
 	GPIO12_CIF_DD_7,
 	GPIO17_CIF_DD_6,
 	GPIO50_CIF_DD_3,
@@ -120,7 +120,7 @@ static unsigned long magician_pin_config[] __initda=
ta =3D {
 };
=20
 /*
- * IRDA
+ * IrDA
  */
=20
 static struct pxaficp_platform_data magician_ficp_info =3D {
@@ -175,7 +175,9 @@ static struct platform_device gpio_keys =3D {
 /*
  * EGPIO (Xilinx CPLD)
  *
- * 7 32-bit aligned 8-bit registers: 3x output, 1x irq, 3x input
+ * 32-bit aligned 8-bit registers
+ * 16 possible registers (reg windows size), only 7 used:
+ * 3x output, 1x irq, 3x input
  */
=20
 static struct resource egpio_resources[] =3D {
@@ -197,7 +199,10 @@ static struct htc_egpio_chip egpio_chips[] =3D {
 		.gpio_base	=3D MAGICIAN_EGPIO(0, 0),
 		.num_gpios	=3D 24,
 		.direction	=3D HTC_EGPIO_OUTPUT,
-		.initial_values	=3D 0x40, /* EGPIO_MAGICIAN_GSM_RESET */
+		/*
+		 * Depends on modules configuration
+		 */
+		.initial_values	=3D 0x40,
 	},
 	[1] =3D {
 		.reg_start	=3D 4,
@@ -228,7 +233,7 @@ static struct platform_device egpio =3D {
 };
=20
 /*
- * LCD - Toppoly TD028STEB1 or Samsung LTP280QV
+ * PXAFB LCD - Toppoly TD028STEB1 or Samsung LTP280QV
  */
=20
 static struct pxafb_mode_info toppoly_modes[] =3D {
@@ -372,6 +377,13 @@ static void magician_backlight_exit(struct device =
*dev)
 	gpio_free_array(ARRAY_AND_SIZE(magician_bl_gpios));
 }
=20
+/*
+ * LCD PWM backlight (main)
+ *
+ * MP1521 frequency should be:
+ *	100-400 Hz =3D 2=E2=80=AF.5*10^6 - 10=E2=80=AF*10^6 ns
+ */
+
 static struct platform_pwm_backlight_data backlight_data =3D {
 	.pwm_id		=3D 0,
 	.max_brightness	=3D 272,
@@ -393,7 +405,7 @@ static struct platform_device backlight =3D {
 };
=20
 /*
- * LEDs
+ * GPIO LEDs, Phone keys backlight, vibra
  */
=20
 static struct gpio_led gpio_leds[] =3D {
@@ -422,6 +434,10 @@ static struct platform_device leds_gpio =3D {
 	},
 };
=20
+/*
+ * PASIC3 LEDs
+ */
+
 static struct pasic3_led pasic3_leds[] =3D {
 	{
 		.led =3D {
@@ -459,7 +475,7 @@ static struct pasic3_leds_machinfo pasic3_leds_info=
 =3D {
 };
=20
 /*
- * PASIC3 with DS1WM
+ * PASIC3 DS1WM
  */
=20
 static struct resource pasic3_resources[] =3D {
@@ -492,7 +508,7 @@ static struct platform_device pasic3 =3D {
 };
=20
 /*
- * USB "Transceiver"
+ * PXA UDC
  */
=20
 static struct resource gpio_vbus_resource =3D {
@@ -695,7 +711,7 @@ static struct platform_device strataflash =3D {
 };
=20
 /*
- * I2C
+ * PXA I2C main controller
  */
=20
 static struct i2c_pxa_platform_data i2c_info =3D {
--=20
1.7.12.1

From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 03/21] ARM: pxa: magician: Fix comments, debug functions
 and print strings
Date: Mon, 17 Aug 2015 23:57:33 +0200
Message-ID: <55D258CD.40101@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

=46ix comments, debug functions and print strings. Rename backlight
structures to be more specific.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 121 +++++++++++++++++++++++++++++++----=
--------
 1 file changed, 89 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.=
c
index 9e8698a..57da133 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -11,6 +11,46 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
+ *
+ * NOTICE MDA Compact (T-mobile XDA) facts:
+ *   On "LCD type =3D 1, system_rev =3D 2" (0x3a in CPLD)
+ * Samsung LTP280QV - valid LCD init sequence sequence:
+ *   powerup: Vdigital->Vanalog->gate Voff->gate Von->data enable
+ *   powerdown: data disable->gate Von->gate Voff->Vanalog->Vdigital
+ * Measured on PCB:
+ *   GPIO106
+ *     Affects VOFF, VON and other voltages
+ *     Probably main reset pin for DC-DC converter
+ *   GPIO75
+ *     Must be AF0+OUT (WM leaves it to AF2+OUT), not LCD signal
+ *     GPIO106 works only when GPIO75 is high (DC-DC power enable?)
+ *     After LCD powerup, value is irrelevant
+ *   GPIO104
+ *     LCD VOFF (gate off voltage)
+ *   GPIO105
+ *     LCD VON (gate on voltage)
+ * FFUART (/dev/ttyS0) WM: 38400,8,n,1,crtscts (GSM data?)
+ * BTUART (/dev/ttyS1) WM: 115200,8,n,1,crtscts (GSM AT commands)
+ *   Use a HTC line discipline: 0x02 channel(=3D=3D0x16) data 0x02
+ * EGPIO(CPLD) should be always present (controls "all" supply power)
+ *   For rootfs on MMC/SD: EGPIO module controls card power (in kernel=
)
+ * cpu-freq often freeze platform (errata?, use userspace gov)
+ * Do not use YUV420, (erratum E24) causes LCD hang (forever)
+ * Many GSM related pins are unknown
+ * gpio-rc-recv probably require lowpass filter (sw is OK)
+ * TODO EGPIO_MAGICIAN_IR_RECEIVE_SHUTDOWN
+ * FIXME AC charging blocks IrDA
+ * Unimplemented blocking of camera+power+reset, reset and door open r=
eset
+ *   Registers: htc-pasic3.h (but blocks charging too)
+ * Other PXA machines have wait_for_sync for ADS7846 (during LCD refre=
sh)
+ * pda-power has not optimal charging (accu can be bloated)
+ * TODO Current switching works? Is gpio-regulator/bq24022 required?
+ * pdata supports alternative drivers (mutually exclusive modules)
+ *   i2c-pxa vs i2c-gpio (SCCB)
+ *   pwm_bl vs gpio_backlight
+ *   pxa27x_udc vs phy-gpio-vbus-usb
+ *   physmap-flash vs pxa2xx-flash
+ *
  */
=20
 #include <linux/kernel.h>
@@ -57,31 +97,31 @@ static unsigned long magician_pin_config[] __initda=
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
@@ -92,7 +132,7 @@ static unsigned long magician_pin_config[] __initdat=
a =3D {
 	/* LCD */
 	GPIOxx_LCD_TFT_16BPP,
=20
-	/* QCI */
+	/* QCI camera interface */
 	GPIO12_CIF_DD_7,
 	GPIO17_CIF_DD_6,
 	GPIO50_CIF_DD_3,
@@ -120,11 +160,12 @@ static unsigned long magician_pin_config[] __init=
data =3D {
 };
=20
 /*
- * IRDA
+ * IrDA
  */
=20
 static struct pxaficp_platform_data magician_ficp_info =3D {
 	.gpio_pwdown		=3D GPIO83_MAGICIAN_nIR_EN,
+	/* TODO test with FIR dongle */
 	.transceiver_cap	=3D IR_SIRMODE | IR_OFF,
 };
=20
@@ -174,8 +215,8 @@ static struct platform_device gpio_keys =3D {
=20
 /*
  * EGPIO (Xilinx CPLD)
- *
- * 7 32-bit aligned 8-bit registers: 3x output, 1x irq, 3x input
+ * 32-bit aligned
+ * 7x 8-bit registers: 3x output, 1x irq, 3x input
  */
=20
 static struct resource egpio_resources[] =3D {
@@ -197,7 +238,11 @@ static struct htc_egpio_chip egpio_chips[] =3D {
 		.gpio_base =3D MAGICIAN_EGPIO(0, 0),
 		.num_gpios =3D 24,
 		.direction =3D HTC_EGPIO_OUTPUT,
-		.initial_values =3D 0x40, /* EGPIO_MAGICIAN_GSM_RESET */
+
+		/*
+		 * Depends on modules configuration
+		 */
+		.initial_values =3D 0x40,
 	},
 	[1] =3D {
 		.reg_start =3D 4,
@@ -228,7 +273,7 @@ static struct platform_device egpio =3D {
 };
=20
 /*
- * LCD - Toppoly TD028STEB1 or Samsung LTP280QV
+ * PXAFB LCD - Toppoly TD028STEB1 or Samsung LTP280QV
  */
=20
 static struct pxafb_mode_info toppoly_modes[] =3D {
@@ -265,10 +310,9 @@ static struct pxafb_mode_info samsung_modes[] =3D =
{
=20
 static void toppoly_lcd_power(int on, struct fb_var_screeninfo *si)
 {
-	pr_debug("Toppoly LCD power\n");
+	pr_debug("Toppoly LCD power: %s\n", on ? "on" : "off");
=20
 	if (on) {
-		pr_debug("on\n");
 		gpio_set_value(EGPIO_MAGICIAN_TOPPOLY_POWER, 1);
 		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 1);
 		udelay(2000);
@@ -280,8 +324,7 @@ static void toppoly_lcd_power(int on, struct fb_var=
_screeninfo *si)
 		udelay(2000);
 		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
 	} else {
-		pr_debug("off\n");
-		msleep(15);
+		mdelay(15);
 		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
 		udelay(500);
 		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 0);
@@ -293,10 +336,9 @@ static void toppoly_lcd_power(int on, struct fb_va=
r_screeninfo *si)
=20
 static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
 {
-	pr_debug("Samsung LCD power\n");
+	pr_debug("Samsung LCD power: %s\n", on ? "on" : "off");
=20
 	if (on) {
-		pr_debug("on\n");
 		if (system_rev < 3)
 			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER, 1);
 		else
@@ -309,7 +351,6 @@ static void samsung_lcd_power(int on, struct fb_var=
_screeninfo *si)
 		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
 		mdelay(10);
 	} else {
-		pr_debug("off\n");
 		mdelay(10);
 		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
 		mdelay(30);
@@ -346,8 +387,8 @@ static struct pxafb_mach_info samsung_info =3D {
  */
=20
 static struct gpio magician_bl_gpios[] =3D {
-	{ EGPIO_MAGICIAN_BL_POWER,  GPIOF_DIR_OUT, "Backlight power" },
-	{ EGPIO_MAGICIAN_BL_POWER2, GPIOF_DIR_OUT, "Backlight power 2" },
+	{ EGPIO_MAGICIAN_BL_POWER, GPIOF_DIR_OUT, "Backlight power" },
+	{ EGPIO_MAGICIAN_BL_POWER2, GPIOF_DIR_OUT, "Extra backlight power" },
 };
=20
 static int magician_backlight_init(struct device *dev)
@@ -357,6 +398,7 @@ static int magician_backlight_init(struct device *d=
ev)
=20
 static int magician_backlight_notify(struct device *dev, int brightnes=
s)
 {
+	pr_debug("Brightness =3D %i\n", brightness);
 	gpio_set_value(EGPIO_MAGICIAN_BL_POWER, brightness);
 	if (brightness >=3D 200) {
 		gpio_set_value(EGPIO_MAGICIAN_BL_POWER2, 1);
@@ -372,7 +414,13 @@ static void magician_backlight_exit(struct device =
*dev)
 	gpio_free_array(ARRAY_AND_SIZE(magician_bl_gpios));
 }
=20
-static struct platform_pwm_backlight_data backlight_data =3D {
+/*
+ * LCD backlight by PWM (main)
+ * PWM frequency for MP1521 should be:
+ *   100-400 Hz =3D 2=E2=80=AF.5*10^6 - 10=E2=80=AF*10^6 ns
+ */
+
+static struct platform_pwm_backlight_data pwm_backlight_data =3D {
 	.pwm_id		=3D 0,
 	.max_brightness	=3D 272,
 	.dft_brightness	=3D 100,
@@ -383,12 +431,12 @@ static struct platform_pwm_backlight_data backlig=
ht_data =3D {
 	.exit		=3D magician_backlight_exit,
 };
=20
-static struct platform_device backlight =3D {
+static struct platform_device pwm_backlight =3D {
 	.name	=3D "pwm-backlight",
 	.id	=3D -1,
 	.dev	=3D {
 		.parent		=3D &pxa27x_device_pwm0.dev,
-		.platform_data	=3D &backlight_data,
+		.platform_data	=3D &pwm_backlight_data,
 	},
 };
=20
@@ -422,6 +470,10 @@ static struct platform_device leds_gpio =3D {
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
@@ -459,7 +511,7 @@ static struct pasic3_leds_machinfo pasic3_leds_info=
 =3D {
 };
=20
 /*
- * PASIC3 with DS1WM
+ * PASIC3 DS1WM
  */
=20
 static struct resource pasic3_resources[] =3D {
@@ -477,8 +529,8 @@ static struct resource pasic3_resources[] =3D {
 };
=20
 static struct pasic3_platform_data pasic3_platform_data =3D {
-	.led_pdata	=3D &pasic3_leds_info,
 	.clock_rate	=3D 4000000,
+	.led_pdata	=3D &pasic3_leds_info,
 };
=20
 static struct platform_device pasic3 =3D {
@@ -517,7 +569,7 @@ static struct platform_device gpio_vbus =3D {
 };
=20
 /*
- * External power
+ * Charging functions
  */
=20
 static int power_supply_init(struct device *dev)
@@ -539,6 +591,10 @@ static char *magician_supplicants[] =3D {
 	"ds2760-battery.0", "backup-battery"
 };
=20
+/*
+ * pda_power Li-ion charger
+ */
+
 static struct pda_power_pdata power_supply_info =3D {
 	.init		=3D power_supply_init,
 	.is_ac_online	=3D magician_is_ac_online,
@@ -575,7 +631,7 @@ static struct platform_device power_supply =3D {
 };
=20
 /*
- * Battery charger
+ * Charging current switch
  */
=20
 static struct regulator_consumer_supply bq24022_consumers[] =3D {
@@ -695,7 +751,7 @@ static struct platform_device strataflash =3D {
 };
=20
 /*
- * I2C
+ * PXA I2C normal controller (main)
  */
=20
 static struct i2c_pxa_platform_data i2c_info =3D {
@@ -709,7 +765,7 @@ static struct i2c_pxa_platform_data i2c_info =3D {
 static struct platform_device *devices[] __initdata =3D {
 	&gpio_keys,
 	&egpio,
-	&backlight,
+	&pwm_backlight,
 	&pasic3,
 	&bq24022,
 	&gpio_vbus,
@@ -734,9 +790,10 @@ static void __init magician_init(void)
 	int err;
=20
 	pxa2xx_mfp_config(ARRAY_AND_SIZE(magician_pin_config));
+
 	err =3D gpio_request_array(ARRAY_AND_SIZE(magician_global_gpios));
 	if (err)
-		pr_err("magician: Failed to request GPIOs: %d\n", err);
+		pr_err("magician: Failed to request global GPIOs: %d\n", err);
=20
 	pxa_set_ffuart_info(NULL);
 	pxa_set_btuart_info(NULL);
@@ -761,7 +818,7 @@ static void __init magician_init(void)
 		pr_info("LCD type: %s\n", lcd_select ? "Samsung" : "Toppoly");
 		if (lcd_select && (system_rev < 3))
 			gpio_request_one(GPIO75_MAGICIAN_SAMSUNG_POWER,
-				GPIOF_OUT_INIT_LOW, "SAMSUNG_POWER");
+				GPIOF_OUT_INIT_LOW, "Samsung LCD Power");
 		pxa_set_fb_info(NULL,
 			lcd_select ? &samsung_info : &toppoly_info);
 	} else
--=20
1.7.12.1

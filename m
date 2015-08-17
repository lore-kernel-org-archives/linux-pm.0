From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 04/21] ARM: pxa: magician: Add, fix and init (new) GPIOs
Date: Mon, 17 Aug 2015 23:58:01 +0200
Message-ID: <55D258E9.9010303@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add new GPIOs, fix some GPIO names and initialization (EGPIO, LCD power on
sequence).

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/include/mach/magician.h |  39 ++++---
 arch/arm/mach-pxa/magician.c              | 166 +++++++++++++++++++++++-------
 2 files changed, 153 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
index ba6a6e1..d19e504 100644
--- a/arch/arm/mach-pxa/include/mach/magician.h
+++ b/arch/arm/mach-pxa/include/mach/magician.h
@@ -21,10 +21,10 @@
 
 #define GPIO0_MAGICIAN_KEY_POWER		0
 #define GPIO9_MAGICIAN_UNKNOWN			9
-#define GPIO10_MAGICIAN_GSM_IRQ			10
+#define GPIO10_MAGICIAN_GSM_IRQ		10
 #define GPIO11_MAGICIAN_GSM_OUT1		11
 #define GPIO13_MAGICIAN_CPLD_IRQ		13
-#define GPIO18_MAGICIAN_UNKNOWN			18
+#define GPIO18_MAGICIAN_UNKNOWN		18
 #define GPIO22_MAGICIAN_VIBRA_EN		22
 #define GPIO26_MAGICIAN_GSM_POWER		26
 #define GPIO27_MAGICIAN_USBC_PUEN		27
@@ -32,8 +32,10 @@
 #define GPIO37_MAGICIAN_KEY_HANGUP		37
 #define GPIO38_MAGICIAN_KEY_CONTACTS		38
 #define GPIO40_MAGICIAN_GSM_OUT2		40
-#define GPIO48_MAGICIAN_UNKNOWN			48
-#define GPIO56_MAGICIAN_UNKNOWN			56
+#define GPIO46_MAGICIAN_IR_RX			46
+#define GPIO47_MAGICIAN_IR_TX			47
+#define GPIO48_MAGICIAN_UNKNOWN		48
+#define GPIO56_MAGICIAN_UNKNOWN		56
 #define GPIO57_MAGICIAN_CAM_RESET		57
 #define GPIO75_MAGICIAN_SAMSUNG_POWER		75
 #define GPIO83_MAGICIAN_nIR_EN			83
@@ -51,15 +53,17 @@
 #define GPIO100_MAGICIAN_KEY_VOL_UP		100
 #define GPIO101_MAGICIAN_KEY_VOL_DOWN 		101
 #define GPIO102_MAGICIAN_KEY_PHONE		102
-#define GPIO103_MAGICIAN_LED_KP			103
-#define GPIO104_MAGICIAN_LCD_POWER_1 		104
-#define GPIO105_MAGICIAN_LCD_POWER_2		105
-#define GPIO106_MAGICIAN_LCD_POWER_3		106
+#define GPIO103_MAGICIAN_LED_KP		103
+#define GPIO104_MAGICIAN_LCD_VOFF_EN		104
+#define GPIO105_MAGICIAN_LCD_VON_EN		105
+#define GPIO106_MAGICIAN_LCD_DCDC_NRESET	106
 #define GPIO107_MAGICIAN_DS1WM_IRQ		107
 #define GPIO108_MAGICIAN_GSM_READY		108
 #define GPIO114_MAGICIAN_UNKNOWN		114
 #define GPIO115_MAGICIAN_nPEN_IRQ		115
 #define GPIO116_MAGICIAN_nCAM_EN		116
+#define GPIO117_MAGICIAN_I2C_SCL		117
+#define GPIO118_MAGICIAN_I2C_SDA		118
 #define GPIO119_MAGICIAN_UNKNOWN		119
 #define GPIO120_MAGICIAN_UNKNOWN		120
 
@@ -78,7 +82,7 @@
  * CPLD EGPIOs
  */
 
-#define MAGICIAN_EGPIO_BASE			PXA_NR_BUILTIN_GPIO
+#define MAGICIAN_EGPIO_BASE	PXA_NR_BUILTIN_GPIO
 #define MAGICIAN_EGPIO(reg,bit) \
 	(MAGICIAN_EGPIO_BASE + 8*reg + bit)
 
@@ -89,25 +93,28 @@
 #define EGPIO_MAGICIAN_GSM_RESET		MAGICIAN_EGPIO(0, 6)
 #define EGPIO_MAGICIAN_LCD_POWER		MAGICIAN_EGPIO(0, 7)
 #define EGPIO_MAGICIAN_SPK_POWER		MAGICIAN_EGPIO(1, 0)
-#define EGPIO_MAGICIAN_EP_POWER			MAGICIAN_EGPIO(1, 1)
+#define EGPIO_MAGICIAN_EP_POWER		MAGICIAN_EGPIO(1, 1)
 #define EGPIO_MAGICIAN_IN_SEL0			MAGICIAN_EGPIO(1, 2)
 #define EGPIO_MAGICIAN_IN_SEL1			MAGICIAN_EGPIO(1, 3)
 #define EGPIO_MAGICIAN_MIC_POWER		MAGICIAN_EGPIO(1, 4)
 #define EGPIO_MAGICIAN_CODEC_RESET		MAGICIAN_EGPIO(1, 5)
 #define EGPIO_MAGICIAN_CODEC_POWER		MAGICIAN_EGPIO(1, 6)
-#define EGPIO_MAGICIAN_BL_POWER			MAGICIAN_EGPIO(1, 7)
-#define EGPIO_MAGICIAN_SD_POWER			MAGICIAN_EGPIO(2, 0)
+#define EGPIO_MAGICIAN_BL_POWER		MAGICIAN_EGPIO(1, 7)
+#define EGPIO_MAGICIAN_SD_POWER		MAGICIAN_EGPIO(2, 0)
 #define EGPIO_MAGICIAN_CARKIT_MIC		MAGICIAN_EGPIO(2, 1)
-#define EGPIO_MAGICIAN_UNKNOWN_WAVEDEV_DLL	MAGICIAN_EGPIO(2, 2)
+#define EGPIO_MAGICIAN_IR_RECEIVE_SHUTDOWN	MAGICIAN_EGPIO(2, 2)
 #define EGPIO_MAGICIAN_FLASH_VPP		MAGICIAN_EGPIO(2, 3)
 #define EGPIO_MAGICIAN_BL_POWER2		MAGICIAN_EGPIO(2, 4)
 #define EGPIO_MAGICIAN_BQ24022_ISET2		MAGICIAN_EGPIO(2, 5)
+#define EGPIO_MAGICIAN_NICD_CHARGE		MAGICIAN_EGPIO(2, 6)
 #define EGPIO_MAGICIAN_GSM_POWER		MAGICIAN_EGPIO(2, 7)
 
 /* input */
 
-#define EGPIO_MAGICIAN_CABLE_STATE_AC		MAGICIAN_EGPIO(4, 0)
-#define EGPIO_MAGICIAN_CABLE_STATE_USB		MAGICIAN_EGPIO(4, 1)
+/* AC=1, USB=0 */
+#define EGPIO_MAGICIAN_CABLE_TYPE		MAGICIAN_EGPIO(4, 0)
+/* =1 when AC or USB cable inserted */
+#define EGPIO_MAGICIAN_CABLE_INSERT1		MAGICIAN_EGPIO(4, 1)
 
 #define EGPIO_MAGICIAN_BOARD_ID0		MAGICIAN_EGPIO(5, 0)
 #define EGPIO_MAGICIAN_BOARD_ID1		MAGICIAN_EGPIO(5, 1)
@@ -116,5 +123,7 @@
 #define EGPIO_MAGICIAN_nSD_READONLY		MAGICIAN_EGPIO(5, 4)
 
 #define EGPIO_MAGICIAN_EP_INSERT		MAGICIAN_EGPIO(6, 1)
+/* FIXME behave like 4,1, may differ for host/device */
+#define EGPIO_MAGICIAN_CABLE_INSERT2		MAGICIAN_EGPIO(6, 4)
 
 #endif /* _MAGICIAN_H_ */
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 57da133..bc206f8 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -4,8 +4,9 @@
  * and T-Mobile MDA Compact.
  *
  * Copyright (c) 2006-2007 Philipp Zabel
+ * Copyright (c) 2014-2015 Petr Cvek (massive rework)
  *
- * Based on hx4700.c, spitz.c and others.
+ * Based on hx4700.c, spitz.c, board-overo.c and others.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -96,13 +97,24 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO79_nCS_3,	/* EGPIO CPLD */
 	GPIO80_nCS_4,
 	GPIO33_nCS_5,
+	GPIO49_nPWE,
+	GPIO18_RDY,
 
 	/* I2C UDA1380 + OV9640 */
 	GPIO117_I2C_SCL,
 	GPIO118_I2C_SDA,
 
+	/* Omnivision camera power and reset GPIO */
+	MFP_CFG_OUT(GPIO116, AF0, DRIVE_HIGH),	/* nEnable, active in low */
+	MFP_CFG_OUT(GPIO57, AF0, DRIVE_HIGH),	/* Reset, active in high */
+
+#if IS_ENABLED(CONFIG_PWM_PXA)
 	/* PWM 0 - LCD backlight */
 	GPIO16_PWM0_OUT,
+#else
+	/* Ensure static backlight without any driver */
+	MFP_CFG_OUT(GPIO16, AF0, DRIVE_LOW),	/* Backlight enabled */
+#endif
 
 	/* I2S UDA1380 capture */
 	GPIO28_I2S_BITCLK_OUT,
@@ -129,8 +141,26 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO111_MMC_DAT_3,
 	GPIO112_MMC_CMD,
 
-	/* LCD */
-	GPIOxx_LCD_TFT_16BPP,
+	/*
+	 * LCD
+	 * NOTICE Samsung LTP280QV:
+	 *   cannot use GPIOxx_LCD_TFT_16BPP, GPIO75 is LCD power,
+	 * 74 unused (AF0 by bootloader?)
+	 */
+	GPIOxx_LCD_16BPP,
+	GPIO76_LCD_PCLK,
+	GPIO77_LCD_BIAS,	/* data_valid (v/hsync) (ADS7846 sync?) */
+
+	/* NOTICE valid LCD init sequence */
+
+	/* for GPIO75_MAGICIAN_SAMSUNG_POWER */
+	MFP_CFG_OUT(GPIO75, AF0, DRIVE_HIGH),
+	/* for GPIO106_MAGICIAN_LCD_DCDC_NRESET */
+	MFP_CFG_OUT(GPIO106, AF0, DRIVE_HIGH),
+	/* for GPIO104_MAGICIAN_LCD_VOFF_EN */
+	MFP_CFG_OUT(GPIO104, AF0, DRIVE_HIGH),
+	/* for GPIO105_MAGICIAN_LCD_VON_EN */
+	MFP_CFG_OUT(GPIO105, AF0, DRIVE_HIGH),
 
 	/* QCI camera interface */
 	GPIO12_CIF_DD_7,
@@ -147,16 +177,69 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO85_CIF_LV,
 
 	/* Magician specific input GPIOs */
-	GPIO9_GPIO,		/* unknown */
 	GPIO10_GPIO,	/* GSM_IRQ */
 	GPIO13_GPIO,	/* CPLD_IRQ */
 	GPIO107_GPIO,	/* DS1WM_IRQ */
 	GPIO108_GPIO,	/* GSM_READY */
 	GPIO115_GPIO,	/* nPEN_IRQ */
 
-	/* I2C */
-	GPIO117_I2C_SCL,
-	GPIO118_I2C_SDA,
+	/* FIXME: probably IrDA transmitter disable */
+	MFP_CFG_OUT(GPIO83, AF0, DRIVE_HIGH),
+
+	/* Vibration motor */
+	MFP_CFG_OUT(GPIO22, AF0, DRIVE_LOW),
+
+	/* Keypad LEDs (red/green phone) */
+	MFP_CFG_OUT(GPIO103, AF0, DRIVE_LOW),
+
+	/* GSM pins */
+	MFP_CFG_OUT(GPIO11, AF0, DRIVE_LOW), /* CPU is unavailable(?) */
+	MFP_CFG_OUT(GPIO26, AF0, DRIVE_LOW), /* GSM power, active high */
+	MFP_CFG_OUT(GPIO86, AF0, DRIVE_HIGH), /* GSM reset, active high */
+
+	/* USB connector */
+	MFP_CFG_OUT(GPIO27, AF0, DRIVE_LOW), /* usbc pull-up enable */
+	MFP_CFG_OUT(GPIO30, AF0, DRIVE_LOW), /* charging enable, active low */
+
+	/* FFUART, FIXME never observed to do something, GSM data? */
+	GPIO34_FFUART_RXD,
+	GPIO35_FFUART_CTS,
+	GPIO36_FFUART_DCD,
+	GPIO39_FFUART_TXD,
+	GPIO41_FFUART_RTS,
+
+	/* BTUART, AT commands/data, HTC port line discipline */
+	GPIO42_BTUART_RXD,
+	GPIO43_BTUART_TXD,
+	GPIO44_BTUART_CTS,
+	GPIO45_BTUART_RTS,
+
+	/* Power I2C, enabled controller will overrule GPIO */
+	GPIO3_GPIO,	/* SCL */
+	GPIO4_GPIO,	/* SDA */
+
+	/* IrDA GPIOs, if pxaficp, it will change AF accordingly to mode */
+	MFP_CFG_IN(GPIO46, AF0),
+	MFP_CFG_OUT(GPIO47, AF0, DRIVE_LOW),
+	MFP_CFG_OUT(GPIO83, AF0, DRIVE_HIGH),
+
+	/* TODO unknown */
+	GPIO9_GPIO,		/* unknown */
+	MFP_CFG_OUT(GPIO40, AF0, DRIVE_LOW),	/* FIXME GSM? */
+	MFP_CFG_OUT(GPIO87, AF0, DRIVE_LOW),	/* FIXME GSM? */
+
+	/* Left GPIOs (undefined here):
+	 * 18, 49 : bootloader=VLIO?, WinM=TODO
+	 * 48 : AF0/out0
+	 * 56 : AF0/out0
+	 * 74 : bootloader=AF0/output
+	 * 86 : bootloader=AF0/input (but should be gsm reset???)
+	 * 114 : AF0/out0
+	 * 119 : AF0/out0
+	 * 120 : AF0/out
+	 * 1 : dedicated reset, AF0/output
+	 * 13 : cpld irq, output (??)
+	 */
 };
 
 /*
@@ -241,8 +324,9 @@ static struct htc_egpio_chip egpio_chips[] = {
 
 		/*
 		 * Depends on modules configuration
+		 * Things like MMC and LCD should be enabled
 		 */
-		.initial_values = 0x40,
+		.initial_values = 0x21a0c0,
 	},
 	[1] = {
 		.reg_start = 4,
@@ -314,22 +398,22 @@ static void toppoly_lcd_power(int on, struct fb_var_screeninfo *si)
 
 	if (on) {
 		gpio_set_value(EGPIO_MAGICIAN_TOPPOLY_POWER, 1);
-		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 1);
+		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 1);
 		udelay(2000);
 		gpio_set_value(EGPIO_MAGICIAN_LCD_POWER, 1);
 		udelay(2000);
 		/* FIXME: enable LCDC here */
 		udelay(2000);
-		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 1);
+		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 1);
 		udelay(2000);
-		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
+		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 1);
 	} else {
 		mdelay(15);
-		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
+		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 0);
 		udelay(500);
-		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 0);
+		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 0);
 		udelay(1000);
-		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 0);
+		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 0);
 		gpio_set_value(EGPIO_MAGICIAN_LCD_POWER, 0);
 	}
 }
@@ -343,21 +427,19 @@ static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
 			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER, 1);
 		else
 			gpio_set_value(EGPIO_MAGICIAN_LCD_POWER, 1);
-		mdelay(10);
-		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 1);
-		mdelay(10);
-		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 1);
-		mdelay(30);
-		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
-		mdelay(10);
+		mdelay(6);
+		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 1);
+		mdelay(6);	/* Avdd -> Voff >5ms */
+		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 1);
+		mdelay(16);	/* Voff -> Von >(5+10)ms */
+		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 1);
 	} else {
-		mdelay(10);
-		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
-		mdelay(30);
-		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 0);
-		mdelay(10);
-		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 0);
-		mdelay(10);
+		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 0);
+		mdelay(16);
+		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 0);
+		mdelay(6);
+		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 0);
+		mdelay(6);
 		if (system_rev < 3)
 			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER, 0);
 		else
@@ -555,7 +637,7 @@ static struct resource gpio_vbus_resource = {
 
 static struct gpio_vbus_mach_info gpio_vbus_info = {
 	.gpio_pullup = GPIO27_MAGICIAN_USBC_PUEN,
-	.gpio_vbus = EGPIO_MAGICIAN_CABLE_STATE_USB,
+	.gpio_vbus = EGPIO_MAGICIAN_CABLE_INSERT1,
 };
 
 static struct platform_device gpio_vbus = {
@@ -574,17 +656,17 @@ static struct platform_device gpio_vbus = {
 
 static int power_supply_init(struct device *dev)
 {
-	return gpio_request(EGPIO_MAGICIAN_CABLE_STATE_AC, "CABLE_STATE_AC");
+	return gpio_request(EGPIO_MAGICIAN_CABLE_TYPE, "CABLE_STATE_AC");
 }
 
 static int magician_is_ac_online(void)
 {
-	return gpio_get_value(EGPIO_MAGICIAN_CABLE_STATE_AC);
+	return gpio_get_value(EGPIO_MAGICIAN_CABLE_INSERT1);
 }
 
 static void power_supply_exit(struct device *dev)
 {
-	gpio_free(EGPIO_MAGICIAN_CABLE_STATE_AC);
+	gpio_free(EGPIO_MAGICIAN_CABLE_TYPE);
 }
 
 static char *magician_supplicants[] = {
@@ -774,12 +856,21 @@ static struct platform_device *devices[] __initdata = {
 	&leds_gpio,
 };
 
+/*
+ * Global GPIOs
+ */
+
 static struct gpio magician_global_gpios[] = {
-	{ GPIO13_MAGICIAN_CPLD_IRQ, GPIOF_IN,		"CPLD_IRQ" },
-	{ GPIO107_MAGICIAN_DS1WM_IRQ, GPIOF_IN,	"DS1WM_IRQ" },
-	{ GPIO104_MAGICIAN_LCD_POWER_1, GPIOF_OUT_INIT_LOW, "LCD power 1" },
-	{ GPIO105_MAGICIAN_LCD_POWER_2, GPIOF_OUT_INIT_LOW, "LCD power 2" },
-	{ GPIO106_MAGICIAN_LCD_POWER_3, GPIOF_OUT_INIT_LOW, "LCD power 3" },
+	{ GPIO13_MAGICIAN_CPLD_IRQ, GPIOF_IN, "CPLD_IRQ" },
+	{ GPIO107_MAGICIAN_DS1WM_IRQ, GPIOF_IN, "DS1WM_IRQ" },
+
+	/* NOTICE valid LCD init sequence */
+	{ GPIO106_MAGICIAN_LCD_DCDC_NRESET, GPIOF_OUT_INIT_HIGH,
+		"LCD DCDC nreset" },
+	{ GPIO104_MAGICIAN_LCD_VOFF_EN, GPIOF_OUT_INIT_HIGH,
+		"LCD VOFF enable" },
+	{ GPIO105_MAGICIAN_LCD_VON_EN, GPIOF_OUT_INIT_HIGH,
+		"LCD VON enable" },
 	{ GPIO83_MAGICIAN_nIR_EN, GPIOF_OUT_INIT_HIGH,	"nIR_EN" },
 };
 
@@ -817,6 +908,7 @@ static void __init magician_init(void)
 		lcd_select = board_id & 0x8;
 		pr_info("LCD type: %s\n", lcd_select ? "Samsung" : "Toppoly");
 		if (lcd_select && (system_rev < 3))
+			/* NOTICE valid LCD init sequence */
 			gpio_request_one(GPIO75_MAGICIAN_SAMSUNG_POWER,
 				GPIOF_OUT_INIT_LOW, "Samsung LCD Power");
 		pxa_set_fb_info(NULL,
-- 
1.7.12.1

From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 01/26] ARM: pxa: magician: Fix indentation in machine files
Date: Thu, 17 Sep 2015 06:54:25 +0200
Message-ID: <55FA4781.30103@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:36663 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbbIQEye (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Sep 2015 00:54:34 -0400
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, g.liakhovetski@gmx.de
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch fixes the indentation for the HTC Magician machine definition.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/include/mach/magician.h |  62 ++---
 arch/arm/mach-pxa/magician.c              | 368 +++++++++++++++---------------
 2 files changed, 215 insertions(+), 215 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
index ba6a6e1..a88f551 100644
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
@@ -32,8 +32,8 @@
 #define GPIO37_MAGICIAN_KEY_HANGUP		37
 #define GPIO38_MAGICIAN_KEY_CONTACTS		38
 #define GPIO40_MAGICIAN_GSM_OUT2		40
-#define GPIO48_MAGICIAN_UNKNOWN			48
-#define GPIO56_MAGICIAN_UNKNOWN			56
+#define GPIO48_MAGICIAN_UNKNOWN		48
+#define GPIO56_MAGICIAN_UNKNOWN		56
 #define GPIO57_MAGICIAN_CAM_RESET		57
 #define GPIO75_MAGICIAN_SAMSUNG_POWER		75
 #define GPIO83_MAGICIAN_nIR_EN			83
@@ -51,7 +51,7 @@
 #define GPIO100_MAGICIAN_KEY_VOL_UP		100
 #define GPIO101_MAGICIAN_KEY_VOL_DOWN 		101
 #define GPIO102_MAGICIAN_KEY_PHONE		102
-#define GPIO103_MAGICIAN_LED_KP			103
+#define GPIO103_MAGICIAN_LED_KP		103
 #define GPIO104_MAGICIAN_LCD_POWER_1 		104
 #define GPIO105_MAGICIAN_LCD_POWER_2		105
 #define GPIO106_MAGICIAN_LCD_POWER_3		106
@@ -84,37 +84,37 @@
 
 /* output */
 
-#define EGPIO_MAGICIAN_TOPPOLY_POWER		MAGICIAN_EGPIO(0, 2)
-#define EGPIO_MAGICIAN_LED_POWER		MAGICIAN_EGPIO(0, 5)
-#define EGPIO_MAGICIAN_GSM_RESET		MAGICIAN_EGPIO(0, 6)
-#define EGPIO_MAGICIAN_LCD_POWER		MAGICIAN_EGPIO(0, 7)
-#define EGPIO_MAGICIAN_SPK_POWER		MAGICIAN_EGPIO(1, 0)
-#define EGPIO_MAGICIAN_EP_POWER			MAGICIAN_EGPIO(1, 1)
-#define EGPIO_MAGICIAN_IN_SEL0			MAGICIAN_EGPIO(1, 2)
-#define EGPIO_MAGICIAN_IN_SEL1			MAGICIAN_EGPIO(1, 3)
-#define EGPIO_MAGICIAN_MIC_POWER		MAGICIAN_EGPIO(1, 4)
-#define EGPIO_MAGICIAN_CODEC_RESET		MAGICIAN_EGPIO(1, 5)
-#define EGPIO_MAGICIAN_CODEC_POWER		MAGICIAN_EGPIO(1, 6)
-#define EGPIO_MAGICIAN_BL_POWER			MAGICIAN_EGPIO(1, 7)
-#define EGPIO_MAGICIAN_SD_POWER			MAGICIAN_EGPIO(2, 0)
-#define EGPIO_MAGICIAN_CARKIT_MIC		MAGICIAN_EGPIO(2, 1)
+#define EGPIO_MAGICIAN_TOPPOLY_POWER	MAGICIAN_EGPIO(0, 2)
+#define EGPIO_MAGICIAN_LED_POWER	MAGICIAN_EGPIO(0, 5)
+#define EGPIO_MAGICIAN_GSM_RESET	MAGICIAN_EGPIO(0, 6)
+#define EGPIO_MAGICIAN_LCD_POWER	MAGICIAN_EGPIO(0, 7)
+#define EGPIO_MAGICIAN_SPK_POWER	MAGICIAN_EGPIO(1, 0)
+#define EGPIO_MAGICIAN_EP_POWER	MAGICIAN_EGPIO(1, 1)
+#define EGPIO_MAGICIAN_IN_SEL0		MAGICIAN_EGPIO(1, 2)
+#define EGPIO_MAGICIAN_IN_SEL1		MAGICIAN_EGPIO(1, 3)
+#define EGPIO_MAGICIAN_MIC_POWER	MAGICIAN_EGPIO(1, 4)
+#define EGPIO_MAGICIAN_CODEC_RESET	MAGICIAN_EGPIO(1, 5)
+#define EGPIO_MAGICIAN_CODEC_POWER	MAGICIAN_EGPIO(1, 6)
+#define EGPIO_MAGICIAN_BL_POWER	MAGICIAN_EGPIO(1, 7)
+#define EGPIO_MAGICIAN_SD_POWER	MAGICIAN_EGPIO(2, 0)
+#define EGPIO_MAGICIAN_CARKIT_MIC	MAGICIAN_EGPIO(2, 1)
 #define EGPIO_MAGICIAN_UNKNOWN_WAVEDEV_DLL	MAGICIAN_EGPIO(2, 2)
-#define EGPIO_MAGICIAN_FLASH_VPP		MAGICIAN_EGPIO(2, 3)
-#define EGPIO_MAGICIAN_BL_POWER2		MAGICIAN_EGPIO(2, 4)
-#define EGPIO_MAGICIAN_BQ24022_ISET2		MAGICIAN_EGPIO(2, 5)
-#define EGPIO_MAGICIAN_GSM_POWER		MAGICIAN_EGPIO(2, 7)
+#define EGPIO_MAGICIAN_FLASH_VPP	MAGICIAN_EGPIO(2, 3)
+#define EGPIO_MAGICIAN_BL_POWER2	MAGICIAN_EGPIO(2, 4)
+#define EGPIO_MAGICIAN_BQ24022_ISET2	MAGICIAN_EGPIO(2, 5)
+#define EGPIO_MAGICIAN_GSM_POWER	MAGICIAN_EGPIO(2, 7)
 
 /* input */
 
-#define EGPIO_MAGICIAN_CABLE_STATE_AC		MAGICIAN_EGPIO(4, 0)
-#define EGPIO_MAGICIAN_CABLE_STATE_USB		MAGICIAN_EGPIO(4, 1)
+#define EGPIO_MAGICIAN_CABLE_STATE_AC	MAGICIAN_EGPIO(4, 0)
+#define EGPIO_MAGICIAN_CABLE_STATE_USB	MAGICIAN_EGPIO(4, 1)
 
-#define EGPIO_MAGICIAN_BOARD_ID0		MAGICIAN_EGPIO(5, 0)
-#define EGPIO_MAGICIAN_BOARD_ID1		MAGICIAN_EGPIO(5, 1)
-#define EGPIO_MAGICIAN_BOARD_ID2		MAGICIAN_EGPIO(5, 2)
-#define EGPIO_MAGICIAN_LCD_SELECT		MAGICIAN_EGPIO(5, 3)
-#define EGPIO_MAGICIAN_nSD_READONLY		MAGICIAN_EGPIO(5, 4)
+#define EGPIO_MAGICIAN_BOARD_ID0	MAGICIAN_EGPIO(5, 0)
+#define EGPIO_MAGICIAN_BOARD_ID1	MAGICIAN_EGPIO(5, 1)
+#define EGPIO_MAGICIAN_BOARD_ID2	MAGICIAN_EGPIO(5, 2)
+#define EGPIO_MAGICIAN_LCD_SELECT	MAGICIAN_EGPIO(5, 3)
+#define EGPIO_MAGICIAN_nSD_READONLY	MAGICIAN_EGPIO(5, 4)
 
-#define EGPIO_MAGICIAN_EP_INSERT		MAGICIAN_EGPIO(6, 1)
+#define EGPIO_MAGICIAN_EP_INSERT	MAGICIAN_EGPIO(6, 1)
 
 #endif /* _MAGICIAN_H_ */
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index a9761c2..c10f932 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -52,8 +52,8 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO20_nSDCS_2,
 	GPIO21_nSDCS_3,
 	GPIO15_nCS_1,
-	GPIO78_nCS_2,   /* PASIC3 */
-	GPIO79_nCS_3,   /* EGPIO CPLD */
+	GPIO78_nCS_2,	/* PASIC3 */
+	GPIO79_nCS_3,	/* EGPIO CPLD */
 	GPIO80_nCS_4,
 	GPIO33_nCS_5,
 
@@ -134,11 +134,11 @@ static struct pxaficp_platform_data magician_ficp_info = {
 
 #define INIT_KEY(_code, _gpio, _desc)	\
 	{				\
-		.code   = KEY_##_code,	\
-		.gpio   = _gpio,	\
-		.desc   = _desc,	\
-		.type   = EV_KEY,	\
-		.wakeup = 1,		\
+		.code	= KEY_##_code,	\
+		.gpio	= _gpio,	\
+		.desc	= _desc,	\
+		.type	= EV_KEY,	\
+		.wakeup	= 1,		\
 	}
 
 static struct gpio_keys_button magician_button_table[] = {
@@ -160,19 +160,18 @@ static struct gpio_keys_button magician_button_table[] = {
 };
 
 static struct gpio_keys_platform_data gpio_keys_data = {
-	.buttons  = magician_button_table,
-	.nbuttons = ARRAY_SIZE(magician_button_table),
+	.buttons	= magician_button_table,
+	.nbuttons	= ARRAY_SIZE(magician_button_table),
 };
 
 static struct platform_device gpio_keys = {
-	.name = "gpio-keys",
-	.dev  = {
+	.name	= "gpio-keys",
+	.dev	= {
 		.platform_data = &gpio_keys_data,
 	},
-	.id   = -1,
+	.id	= -1,
 };
 
-
 /*
  * EGPIO (Xilinx CPLD)
  *
@@ -181,48 +180,48 @@ static struct platform_device gpio_keys = {
 
 static struct resource egpio_resources[] = {
 	[0] = {
-		.start = PXA_CS3_PHYS,
-		.end   = PXA_CS3_PHYS + 0x20 - 1,
-		.flags = IORESOURCE_MEM,
+		.start	= PXA_CS3_PHYS,
+		.end	= PXA_CS3_PHYS + 0x20 - 1,
+		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-		.start = PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
-		.end   = PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
-		.flags = IORESOURCE_IRQ,
+		.start	= PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
+		.end	= PXA_GPIO_TO_IRQ(GPIO13_MAGICIAN_CPLD_IRQ),
+		.flags	= IORESOURCE_IRQ,
 	},
 };
 
 static struct htc_egpio_chip egpio_chips[] = {
 	[0] = {
-		.reg_start = 0,
-		.gpio_base = MAGICIAN_EGPIO(0, 0),
-		.num_gpios = 24,
-		.direction = HTC_EGPIO_OUTPUT,
-		.initial_values = 0x40, /* EGPIO_MAGICIAN_GSM_RESET */
+		.reg_start	= 0,
+		.gpio_base	= MAGICIAN_EGPIO(0, 0),
+		.num_gpios	= 24,
+		.direction	= HTC_EGPIO_OUTPUT,
+		.initial_values	= 0x40, /* EGPIO_MAGICIAN_GSM_RESET */
 	},
 	[1] = {
-		.reg_start = 4,
-		.gpio_base = MAGICIAN_EGPIO(4, 0),
-		.num_gpios = 24,
-		.direction = HTC_EGPIO_INPUT,
+		.reg_start	= 4,
+		.gpio_base	= MAGICIAN_EGPIO(4, 0),
+		.num_gpios	= 24,
+		.direction	= HTC_EGPIO_INPUT,
 	},
 };
 
 static struct htc_egpio_platform_data egpio_info = {
-	.reg_width    = 8,
-	.bus_width    = 32,
-	.irq_base     = IRQ_BOARD_START,
-	.num_irqs     = 4,
-	.ack_register = 3,
-	.chip         = egpio_chips,
-	.num_chips    = ARRAY_SIZE(egpio_chips),
+	.reg_width	= 8,
+	.bus_width	= 32,
+	.irq_base	= IRQ_BOARD_START,
+	.num_irqs	= 4,
+	.ack_register	= 3,
+	.chip		= egpio_chips,
+	.num_chips	= ARRAY_SIZE(egpio_chips),
 };
 
 static struct platform_device egpio = {
-	.name          = "htc-egpio",
-	.id            = -1,
-	.resource      = egpio_resources,
-	.num_resources = ARRAY_SIZE(egpio_resources),
+	.name		= "htc-egpio",
+	.id		= -1,
+	.resource	= egpio_resources,
+	.num_resources	= ARRAY_SIZE(egpio_resources),
 	.dev = {
 		.platform_data = &egpio_info,
 	},
@@ -234,33 +233,33 @@ static struct platform_device egpio = {
 
 static struct pxafb_mode_info toppoly_modes[] = {
 	{
-		.pixclock     = 96153,
-		.bpp          = 16,
-		.xres         = 240,
-		.yres         = 320,
-		.hsync_len    = 11,
-		.vsync_len    = 3,
-		.left_margin  = 19,
-		.upper_margin = 2,
-		.right_margin = 10,
-		.lower_margin = 2,
-		.sync         = 0,
+		.pixclock	= 96153,
+		.bpp		= 16,
+		.xres		= 240,
+		.yres		= 320,
+		.hsync_len	= 11,
+		.vsync_len	= 3,
+		.left_margin	= 19,
+		.upper_margin	= 2,
+		.right_margin	= 10,
+		.lower_margin	= 2,
+		.sync		= 0,
 	},
 };
 
 static struct pxafb_mode_info samsung_modes[] = {
 	{
-		.pixclock     = 96153,
-		.bpp          = 16,
-		.xres         = 240,
-		.yres         = 320,
-		.hsync_len    = 8,
-		.vsync_len    = 4,
-		.left_margin  = 9,
-		.upper_margin = 4,
-		.right_margin = 9,
-		.lower_margin = 4,
-		.sync         = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		.pixclock	= 96153,
+		.bpp		= 16,
+		.xres		= 240,
+		.yres		= 320,
+		.hsync_len	= 8,
+		.vsync_len	= 4,
+		.left_margin	= 9,
+		.upper_margin	= 4,
+		.right_margin	= 9,
+		.lower_margin	= 4,
+		.sync	= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 	},
 };
 
@@ -326,20 +325,20 @@ static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
 }
 
 static struct pxafb_mach_info toppoly_info = {
-	.modes           = toppoly_modes,
-	.num_modes       = 1,
-	.fixed_modes     = 1,
-	.lcd_conn	= LCD_COLOR_TFT_16BPP,
-	.pxafb_lcd_power = toppoly_lcd_power,
+	.modes			= toppoly_modes,
+	.num_modes		= 1,
+	.fixed_modes		= 1,
+	.lcd_conn		= LCD_COLOR_TFT_16BPP,
+	.pxafb_lcd_power	= toppoly_lcd_power,
 };
 
 static struct pxafb_mach_info samsung_info = {
-	.modes           = samsung_modes,
-	.num_modes       = 1,
-	.fixed_modes     = 1,
-	.lcd_conn	 = LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL |\
-			   LCD_ALTERNATE_MAPPING,
-	.pxafb_lcd_power = samsung_lcd_power,
+	.modes			= samsung_modes,
+	.num_modes		= 1,
+	.fixed_modes		= 1,
+	.lcd_conn		= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL |
+		LCD_ALTERNATE_MAPPING,
+	.pxafb_lcd_power	= samsung_lcd_power,
 };
 
 /*
@@ -347,8 +346,8 @@ static struct pxafb_mach_info samsung_info = {
  */
 
 static struct gpio magician_bl_gpios[] = {
-	{ EGPIO_MAGICIAN_BL_POWER,  GPIOF_DIR_OUT, "Backlight power" },
-	{ EGPIO_MAGICIAN_BL_POWER2, GPIOF_DIR_OUT, "Backlight power 2" },
+	{ EGPIO_MAGICIAN_BL_POWER,	GPIOF_DIR_OUT, "Backlight power" },
+	{ EGPIO_MAGICIAN_BL_POWER2,	GPIOF_DIR_OUT, "Backlight power 2" },
 };
 
 static int magician_backlight_init(struct device *dev)
@@ -374,22 +373,22 @@ static void magician_backlight_exit(struct device *dev)
 }
 
 static struct platform_pwm_backlight_data backlight_data = {
-	.pwm_id         = 0,
-	.max_brightness = 272,
-	.dft_brightness = 100,
-	.pwm_period_ns  = 30923,
-	.enable_gpio    = -1,
-	.init           = magician_backlight_init,
-	.notify         = magician_backlight_notify,
-	.exit           = magician_backlight_exit,
+	.pwm_id		= 0,
+	.max_brightness	= 272,
+	.dft_brightness	= 100,
+	.pwm_period_ns	= 30923,
+	.enable_gpio	= -1,
+	.init		= magician_backlight_init,
+	.notify		= magician_backlight_notify,
+	.exit		= magician_backlight_exit,
 };
 
 static struct platform_device backlight = {
-	.name = "pwm-backlight",
-	.id   = -1,
-	.dev  = {
-		.parent        = &pxa27x_device_pwm0.dev,
-		.platform_data = &backlight_data,
+	.name	= "pwm-backlight",
+	.id	= -1,
+	.dev	= {
+		.parent		= &pxa27x_device_pwm0.dev,
+		.platform_data	= &backlight_data,
 	},
 };
 
@@ -416,9 +415,9 @@ static struct gpio_led_platform_data gpio_led_info = {
 };
 
 static struct platform_device leds_gpio = {
-	.name = "leds-gpio",
-	.id   = -1,
-	.dev  = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
 		.platform_data = &gpio_led_info,
 	},
 };
@@ -426,37 +425,37 @@ static struct platform_device leds_gpio = {
 static struct pasic3_led pasic3_leds[] = {
 	{
 		.led = {
-			.name            = "magician:red",
+			.name = "magician:red",
 			.default_trigger = "ds2760-battery.0-charging",
 		},
-		.hw_num = 0,
-		.bit2   = PASIC3_BIT2_LED0,
-		.mask   = PASIC3_MASK_LED0,
+		.hw_num	= 0,
+		.bit2	= PASIC3_BIT2_LED0,
+		.mask	= PASIC3_MASK_LED0,
 	},
 	{
 		.led = {
-			.name            = "magician:green",
+			.name = "magician:green",
 			.default_trigger = "ds2760-battery.0-charging-or-full",
 		},
-		.hw_num = 1,
-		.bit2   = PASIC3_BIT2_LED1,
-		.mask   = PASIC3_MASK_LED1,
+		.hw_num	= 1,
+		.bit2	= PASIC3_BIT2_LED1,
+		.mask	= PASIC3_MASK_LED1,
 	},
 	{
 		.led = {
-			.name            = "magician:blue",
+			.name = "magician:blue",
 			.default_trigger = "bluetooth",
 		},
-		.hw_num = 2,
-		.bit2   = PASIC3_BIT2_LED2,
-		.mask   = PASIC3_MASK_LED2,
+		.hw_num	= 2,
+		.bit2	= PASIC3_BIT2_LED2,
+		.mask	= PASIC3_MASK_LED2,
 	},
 };
 
 static struct pasic3_leds_machinfo pasic3_leds_info = {
-	.num_leds   = ARRAY_SIZE(pasic3_leds),
-	.power_gpio = EGPIO_MAGICIAN_LED_POWER,
-	.leds       = pasic3_leds,
+	.num_leds	= ARRAY_SIZE(pasic3_leds),
+	.power_gpio	= EGPIO_MAGICIAN_LED_POWER,
+	.leds		= pasic3_leds,
 };
 
 /*
@@ -465,21 +464,21 @@ static struct pasic3_leds_machinfo pasic3_leds_info = {
 
 static struct resource pasic3_resources[] = {
 	[0] = {
-		.start  = PXA_CS2_PHYS,
+		.start	= PXA_CS2_PHYS,
 		.end	= PXA_CS2_PHYS + 0x1b,
-		.flags  = IORESOURCE_MEM,
+		.flags	= IORESOURCE_MEM,
 	},
 	/* No IRQ handler in the PASIC3, DS1WM needs an external IRQ */
 	[1] = {
-		.start  = PXA_GPIO_TO_IRQ(GPIO107_MAGICIAN_DS1WM_IRQ),
-		.end    = PXA_GPIO_TO_IRQ(GPIO107_MAGICIAN_DS1WM_IRQ),
-		.flags  = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
+		.start	= PXA_GPIO_TO_IRQ(GPIO107_MAGICIAN_DS1WM_IRQ),
+		.end	= PXA_GPIO_TO_IRQ(GPIO107_MAGICIAN_DS1WM_IRQ),
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE,
 	}
 };
 
 static struct pasic3_platform_data pasic3_platform_data = {
-	.led_pdata  = &pasic3_leds_info,
-	.clock_rate = 4000000,
+	.led_pdata	= &pasic3_leds_info,
+	.clock_rate	= 4000000,
 };
 
 static struct platform_device pasic3 = {
@@ -497,21 +496,21 @@ static struct platform_device pasic3 = {
  */
 
 static struct resource gpio_vbus_resource = {
-	.flags = IORESOURCE_IRQ,
-	.start = IRQ_MAGICIAN_VBUS,
-	.end   = IRQ_MAGICIAN_VBUS,
+	.flags	= IORESOURCE_IRQ,
+	.start	= IRQ_MAGICIAN_VBUS,
+	.end	= IRQ_MAGICIAN_VBUS,
 };
 
 static struct gpio_vbus_mach_info gpio_vbus_info = {
-	.gpio_pullup = GPIO27_MAGICIAN_USBC_PUEN,
-	.gpio_vbus   = EGPIO_MAGICIAN_CABLE_STATE_USB,
+	.gpio_pullup	= GPIO27_MAGICIAN_USBC_PUEN,
+	.gpio_vbus	= EGPIO_MAGICIAN_CABLE_STATE_USB,
 };
 
 static struct platform_device gpio_vbus = {
-	.name          = "gpio-vbus",
-	.id            = -1,
-	.num_resources = 1,
-	.resource      = &gpio_vbus_resource,
+	.name		= "gpio-vbus",
+	.id		= -1,
+	.num_resources	= 1,
+	.resource	= &gpio_vbus_resource,
 	.dev = {
 		.platform_data = &gpio_vbus_info,
 	},
@@ -541,38 +540,38 @@ static char *magician_supplicants[] = {
 };
 
 static struct pda_power_pdata power_supply_info = {
-	.init            = power_supply_init,
-	.is_ac_online    = magician_is_ac_online,
-	.exit            = power_supply_exit,
-	.supplied_to     = magician_supplicants,
-	.num_supplicants = ARRAY_SIZE(magician_supplicants),
+	.init			= power_supply_init,
+	.is_ac_online		= magician_is_ac_online,
+	.exit			= power_supply_exit,
+	.supplied_to		= magician_supplicants,
+	.num_supplicants	= ARRAY_SIZE(magician_supplicants),
 };
 
 static struct resource power_supply_resources[] = {
 	[0] = {
-		.name  = "ac",
-		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
-		         IORESOURCE_IRQ_LOWEDGE,
-		.start = IRQ_MAGICIAN_VBUS,
-		.end   = IRQ_MAGICIAN_VBUS,
+		.name	= "ac",
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
+			IORESOURCE_IRQ_LOWEDGE,
+		.start	= IRQ_MAGICIAN_VBUS,
+		.end	= IRQ_MAGICIAN_VBUS,
 	},
 	[1] = {
-		.name  = "usb",
-		.flags = IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
-		         IORESOURCE_IRQ_LOWEDGE,
-		.start = IRQ_MAGICIAN_VBUS,
-		.end   = IRQ_MAGICIAN_VBUS,
+		.name	= "usb",
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_HIGHEDGE |
+			IORESOURCE_IRQ_LOWEDGE,
+		.start	= IRQ_MAGICIAN_VBUS,
+		.end	= IRQ_MAGICIAN_VBUS,
 	},
 };
 
 static struct platform_device power_supply = {
-	.name = "pda-power",
-	.id   = -1,
-	.dev  = {
+	.name	= "pda-power",
+	.id	= -1,
+	.dev = {
 		.platform_data = &power_supply_info,
 	},
-	.resource      = power_supply_resources,
-	.num_resources = ARRAY_SIZE(power_supply_resources),
+	.resource	= power_supply_resources,
+	.num_resources	= ARRAY_SIZE(power_supply_resources),
 };
 
 /*
@@ -586,11 +585,12 @@ static struct regulator_consumer_supply bq24022_consumers[] = {
 
 static struct regulator_init_data bq24022_init_data = {
 	.constraints = {
-		.max_uA         = 500000,
-		.valid_ops_mask = REGULATOR_CHANGE_CURRENT | REGULATOR_CHANGE_STATUS,
+		.max_uA		= 500000,
+		.valid_ops_mask	= REGULATOR_CHANGE_CURRENT |
+			REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = ARRAY_SIZE(bq24022_consumers),
-	.consumer_supplies      = bq24022_consumers,
+	.num_consumer_supplies	= ARRAY_SIZE(bq24022_consumers),
+	.consumer_supplies	= bq24022_consumers,
 };
 
 static struct gpio bq24022_gpios[] = {
@@ -603,26 +603,26 @@ static struct gpio_regulator_state bq24022_states[] = {
 };
 
 static struct gpio_regulator_config bq24022_info = {
-	.supply_name = "bq24022",
+	.supply_name		= "bq24022",
 
-	.enable_gpio = GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
-	.enable_high = 0,
-	.enabled_at_boot = 0,
+	.enable_gpio		= GPIO30_MAGICIAN_BQ24022_nCHARGE_EN,
+	.enable_high		= 0,
+	.enabled_at_boot	= 0,
 
-	.gpios = bq24022_gpios,
-	.nr_gpios = ARRAY_SIZE(bq24022_gpios),
+	.gpios			= bq24022_gpios,
+	.nr_gpios		= ARRAY_SIZE(bq24022_gpios),
 
-	.states = bq24022_states,
-	.nr_states = ARRAY_SIZE(bq24022_states),
+	.states			= bq24022_states,
+	.nr_states		= ARRAY_SIZE(bq24022_states),
 
-	.type = REGULATOR_CURRENT,
-	.init_data = &bq24022_init_data,
+	.type			= REGULATOR_CURRENT,
+	.init_data		= &bq24022_init_data,
 };
 
 static struct platform_device bq24022 = {
-	.name = "gpio-regulator",
-	.id   = -1,
-	.dev  = {
+	.name	= "gpio-regulator",
+	.id	= -1,
+	.dev	= {
 		.platform_data = &bq24022_info,
 	},
 };
@@ -632,10 +632,10 @@ static struct platform_device bq24022 = {
  */
 
 static int magician_mci_init(struct device *dev,
-				irq_handler_t detect_irq, void *data)
+	irq_handler_t detect_irq, void *data)
 {
 	return request_irq(IRQ_MAGICIAN_SD, detect_irq, 0,
-			   "mmc card detect", data);
+		"mmc card detect", data);
 }
 
 static void magician_mci_exit(struct device *dev, void *data)
@@ -644,9 +644,9 @@ static void magician_mci_exit(struct device *dev, void *data)
 }
 
 static struct pxamci_platform_data magician_mci_info = {
-	.ocr_mask 		= MMC_VDD_32_33|MMC_VDD_33_34,
-	.init     		= magician_mci_init,
-	.exit     		= magician_mci_exit,
+	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
+	.init			= magician_mci_init,
+	.exit			= magician_mci_exit,
 	.gpio_card_detect	= -1,
 	.gpio_card_ro		= EGPIO_MAGICIAN_nSD_READONLY,
 	.gpio_card_ro_invert	= 1,
@@ -664,7 +664,6 @@ static struct pxaohci_platform_data magician_ohci_info = {
 	.power_budget	= 0,
 };
 
-
 /*
  * StrataFlash
  */
@@ -675,21 +674,21 @@ static void magician_set_vpp(struct platform_device *pdev, int vpp)
 }
 
 static struct resource strataflash_resource = {
-	.start = PXA_CS0_PHYS,
-	.end   = PXA_CS0_PHYS + SZ_64M - 1,
-	.flags = IORESOURCE_MEM,
+	.start	= PXA_CS0_PHYS,
+	.end	= PXA_CS0_PHYS + SZ_64M - 1,
+	.flags	= IORESOURCE_MEM,
 };
 
 static struct physmap_flash_data strataflash_data = {
-	.width = 4,
-	.set_vpp = magician_set_vpp,
+	.width		= 4,
+	.set_vpp	= magician_set_vpp,
 };
 
 static struct platform_device strataflash = {
-	.name          = "physmap-flash",
-	.id            = -1,
-	.resource      = &strataflash_resource,
-	.num_resources = 1,
+	.name		= "physmap-flash",
+	.id		= -1,
+	.resource	= &strataflash_resource,
+	.num_resources	= 1,
 	.dev = {
 		.platform_data = &strataflash_data,
 	},
@@ -720,7 +719,7 @@ static struct platform_device *devices[] __initdata = {
 };
 
 static struct gpio magician_global_gpios[] = {
-	{ GPIO13_MAGICIAN_CPLD_IRQ,   GPIOF_IN, "CPLD_IRQ" },
+	{ GPIO13_MAGICIAN_CPLD_IRQ, GPIOF_IN, "CPLD_IRQ" },
 	{ GPIO107_MAGICIAN_DS1WM_IRQ, GPIOF_IN, "DS1WM_IRQ" },
 	{ GPIO104_MAGICIAN_LCD_POWER_1, GPIOF_OUT_INIT_LOW, "LCD power 1" },
 	{ GPIO105_MAGICIAN_LCD_POWER_2, GPIOF_OUT_INIT_LOW, "LCD power 2" },
@@ -754,27 +753,28 @@ static void __init magician_init(void)
 	/* Check LCD type we have */
 	cpld = ioremap_nocache(PXA_CS3_PHYS, 0x1000);
 	if (cpld) {
-		u8 board_id = __raw_readb(cpld+0x14);
+		u8 board_id = __raw_readb(cpld + 0x14);
+
 		iounmap(cpld);
 		system_rev = board_id & 0x7;
 		lcd_select = board_id & 0x8;
 		pr_info("LCD type: %s\n", lcd_select ? "Samsung" : "Toppoly");
 		if (lcd_select && (system_rev < 3))
 			gpio_request_one(GPIO75_MAGICIAN_SAMSUNG_POWER,
-			                 GPIOF_OUT_INIT_LOW, "SAMSUNG_POWER");
-		pxa_set_fb_info(NULL, lcd_select ? &samsung_info : &toppoly_info);
+				GPIOF_OUT_INIT_LOW, "SAMSUNG_POWER");
+		pxa_set_fb_info(NULL,
+			lcd_select ? &samsung_info : &toppoly_info);
 	} else
 		pr_err("LCD detection: CPLD mapping failed\n");
 }
 
-
 MACHINE_START(MAGICIAN, "HTC Magician")
-	.atag_offset = 0x100,
-	.map_io = pxa27x_map_io,
-	.nr_irqs = MAGICIAN_NR_IRQS,
-	.init_irq = pxa27x_init_irq,
-	.handle_irq = pxa27x_handle_irq,
-	.init_machine = magician_init,
+	.atag_offset	= 0x100,
+	.map_io		= pxa27x_map_io,
+	.nr_irqs	= MAGICIAN_NR_IRQS,
+	.init_irq	= pxa27x_init_irq,
+	.handle_irq	= pxa27x_handle_irq,
+	.init_machine	= magician_init,
 	.init_time	= pxa_timer_init,
 	.restart	= pxa_restart,
 MACHINE_END
-- 
1.7.12.1


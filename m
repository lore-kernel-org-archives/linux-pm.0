From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 02/21] ARM: pxa: magician: Fix indentation and whitespaces
Date: Mon, 17 Aug 2015 23:56:54 +0200
Message-ID: <55D258A6.2040105@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bubo.tul.cz ([147.230.16.1]:49592 "EHLO bubo.tul.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbbHQVyD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Aug 2015 17:54:03 -0400
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Fix magician.c: indentation and whitespaces.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 356 +++++++++++++++++++++----------------------
 1 file changed, 178 insertions(+), 178 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index a9761c2..9e8698a 100644
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
 
@@ -107,7 +107,7 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO85_CIF_LV,
 
 	/* Magician specific input GPIOs */
-	GPIO9_GPIO,	/* unknown */
+	GPIO9_GPIO,		/* unknown */
 	GPIO10_GPIO,	/* GSM_IRQ */
 	GPIO13_GPIO,	/* CPLD_IRQ */
 	GPIO107_GPIO,	/* DS1WM_IRQ */
@@ -133,46 +133,45 @@ static struct pxaficp_platform_data magician_ficp_info = {
  */
 
 #define INIT_KEY(_code, _gpio, _desc)	\
-	{				\
-		.code   = KEY_##_code,	\
-		.gpio   = _gpio,	\
-		.desc   = _desc,	\
-		.type   = EV_KEY,	\
-		.wakeup = 1,		\
+	{						\
+		.code	= KEY_##_code,	\
+		.gpio	= _gpio,	\
+		.desc	= _desc,	\
+		.type	= EV_KEY,	\
+		.wakeup	= 1,		\
 	}
 
 static struct gpio_keys_button magician_button_table[] = {
-	INIT_KEY(POWER,      GPIO0_MAGICIAN_KEY_POWER,      "Power button"),
-	INIT_KEY(ESC,        GPIO37_MAGICIAN_KEY_HANGUP,    "Hangup button"),
-	INIT_KEY(F10,        GPIO38_MAGICIAN_KEY_CONTACTS,  "Contacts button"),
-	INIT_KEY(CALENDAR,   GPIO90_MAGICIAN_KEY_CALENDAR,  "Calendar button"),
-	INIT_KEY(CAMERA,     GPIO91_MAGICIAN_KEY_CAMERA,    "Camera button"),
-	INIT_KEY(UP,         GPIO93_MAGICIAN_KEY_UP,        "Up button"),
-	INIT_KEY(DOWN,       GPIO94_MAGICIAN_KEY_DOWN,      "Down button"),
-	INIT_KEY(LEFT,       GPIO95_MAGICIAN_KEY_LEFT,      "Left button"),
-	INIT_KEY(RIGHT,      GPIO96_MAGICIAN_KEY_RIGHT,     "Right button"),
-	INIT_KEY(KPENTER,    GPIO97_MAGICIAN_KEY_ENTER,     "Action button"),
-	INIT_KEY(RECORD,     GPIO98_MAGICIAN_KEY_RECORD,    "Record button"),
-	INIT_KEY(VOLUMEUP,   GPIO100_MAGICIAN_KEY_VOL_UP,   "Volume up"),
-	INIT_KEY(VOLUMEDOWN, GPIO101_MAGICIAN_KEY_VOL_DOWN, "Volume down"),
-	INIT_KEY(PHONE,      GPIO102_MAGICIAN_KEY_PHONE,    "Phone button"),
-	INIT_KEY(PLAY,       GPIO99_MAGICIAN_HEADPHONE_IN,  "Headset button"),
+	INIT_KEY(POWER,		GPIO0_MAGICIAN_KEY_POWER,	"Power button"),
+	INIT_KEY(ESC,		GPIO37_MAGICIAN_KEY_HANGUP,	"Hangup button"),
+	INIT_KEY(F10,		GPIO38_MAGICIAN_KEY_CONTACTS,	"Contacts button"),
+	INIT_KEY(CALENDAR,	GPIO90_MAGICIAN_KEY_CALENDAR,	"Calendar button"),
+	INIT_KEY(CAMERA,	GPIO91_MAGICIAN_KEY_CAMERA,	"Camera button"),
+	INIT_KEY(UP,		GPIO93_MAGICIAN_KEY_UP,		"Up button"),
+	INIT_KEY(DOWN,		GPIO94_MAGICIAN_KEY_DOWN,	"Down button"),
+	INIT_KEY(LEFT,		GPIO95_MAGICIAN_KEY_LEFT,	"Left button"),
+	INIT_KEY(RIGHT,		GPIO96_MAGICIAN_KEY_RIGHT,	"Right button"),
+	INIT_KEY(KPENTER,	GPIO97_MAGICIAN_KEY_ENTER,	"Action button"),
+	INIT_KEY(RECORD,	GPIO98_MAGICIAN_KEY_RECORD,	"Record button"),
+	INIT_KEY(VOLUMEUP,	GPIO100_MAGICIAN_KEY_VOL_UP,	"Volume up"),
+	INIT_KEY(VOLUMEDOWN,	GPIO101_MAGICIAN_KEY_VOL_DOWN,	"Volume down"),
+	INIT_KEY(PHONE,		GPIO102_MAGICIAN_KEY_PHONE,	"Phone button"),
+	INIT_KEY(PLAY,		GPIO99_MAGICIAN_HEADPHONE_IN,	"Headset button"),
 };
 
 static struct gpio_keys_platform_data gpio_keys_data = {
-	.buttons  = magician_button_table,
+	.buttons = magician_button_table,
 	.nbuttons = ARRAY_SIZE(magician_button_table),
 };
 
 static struct platform_device gpio_keys = {
 	.name = "gpio-keys",
-	.dev  = {
+	.dev = {
 		.platform_data = &gpio_keys_data,
 	},
-	.id   = -1,
+	.id = -1,
 };
 
-
 /*
  * EGPIO (Xilinx CPLD)
  *
@@ -181,14 +180,14 @@ static struct platform_device gpio_keys = {
 
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
 
@@ -209,20 +208,20 @@ static struct htc_egpio_chip egpio_chips[] = {
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
 
@@ -326,19 +325,19 @@ static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
 }
 
 static struct pxafb_mach_info toppoly_info = {
-	.modes           = toppoly_modes,
-	.num_modes       = 1,
-	.fixed_modes     = 1,
+	.modes		= toppoly_modes,
+	.num_modes	= 1,
+	.fixed_modes	= 1,
 	.lcd_conn	= LCD_COLOR_TFT_16BPP,
 	.pxafb_lcd_power = toppoly_lcd_power,
 };
 
 static struct pxafb_mach_info samsung_info = {
-	.modes           = samsung_modes,
-	.num_modes       = 1,
-	.fixed_modes     = 1,
-	.lcd_conn	 = LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL |\
-			   LCD_ALTERNATE_MAPPING,
+	.modes		= samsung_modes,
+	.num_modes	= 1,
+	.fixed_modes	= 1,
+	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL |
+		LCD_ALTERNATE_MAPPING,
 	.pxafb_lcd_power = samsung_lcd_power,
 };
 
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
@@ -465,28 +464,28 @@ static struct pasic3_leds_machinfo pasic3_leds_info = {
 
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
-	.name		= "pasic3",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(pasic3_resources),
-	.resource	= pasic3_resources,
+	.name = "pasic3",
+	.id = -1,
+	.num_resources = ARRAY_SIZE(pasic3_resources),
+	.resource = pasic3_resources,
 	.dev = {
 		.platform_data = &pasic3_platform_data,
 	},
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
 	.gpio_pullup = GPIO27_MAGICIAN_USBC_PUEN,
-	.gpio_vbus   = EGPIO_MAGICIAN_CABLE_STATE_USB,
+	.gpio_vbus = EGPIO_MAGICIAN_CABLE_STATE_USB,
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
+	.init		= power_supply_init,
+	.is_ac_online	= magician_is_ac_online,
+	.exit		= power_supply_exit,
+	.supplied_to	= magician_supplicants,
 	.num_supplicants = ARRAY_SIZE(magician_supplicants),
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
+		.max_uA = 500000,
+		.valid_ops_mask = REGULATOR_CHANGE_CURRENT |
+			REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = ARRAY_SIZE(bq24022_consumers),
-	.consumer_supplies      = bq24022_consumers,
+	.num_consumer_supplies = ARRAY_SIZE(bq24022_consumers),
+	.consumer_supplies = bq24022_consumers,
 };
 
 static struct gpio bq24022_gpios[] = {
@@ -620,9 +620,9 @@ static struct gpio_regulator_config bq24022_info = {
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
@@ -644,13 +644,13 @@ static void magician_mci_exit(struct device *dev, void *data)
 }
 
 static struct pxamci_platform_data magician_mci_info = {
-	.ocr_mask 		= MMC_VDD_32_33|MMC_VDD_33_34,
-	.init     		= magician_mci_init,
-	.exit     		= magician_mci_exit,
+	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
+	.init		= magician_mci_init,
+	.exit		= magician_mci_exit,
 	.gpio_card_detect	= -1,
 	.gpio_card_ro		= EGPIO_MAGICIAN_nSD_READONLY,
 	.gpio_card_ro_invert	= 1,
-	.gpio_power		= EGPIO_MAGICIAN_SD_POWER,
+	.gpio_power	= EGPIO_MAGICIAN_SD_POWER,
 };
 
 
@@ -664,7 +664,6 @@ static struct pxaohci_platform_data magician_ohci_info = {
 	.power_budget	= 0,
 };
 
-
 /*
  * StrataFlash
  */
@@ -675,9 +674,9 @@ static void magician_set_vpp(struct platform_device *pdev, int vpp)
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
@@ -686,10 +685,10 @@ static struct physmap_flash_data strataflash_data = {
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
@@ -720,12 +719,12 @@ static struct platform_device *devices[] __initdata = {
 };
 
 static struct gpio magician_global_gpios[] = {
-	{ GPIO13_MAGICIAN_CPLD_IRQ,   GPIOF_IN, "CPLD_IRQ" },
-	{ GPIO107_MAGICIAN_DS1WM_IRQ, GPIOF_IN, "DS1WM_IRQ" },
+	{ GPIO13_MAGICIAN_CPLD_IRQ, GPIOF_IN,		"CPLD_IRQ" },
+	{ GPIO107_MAGICIAN_DS1WM_IRQ, GPIOF_IN,	"DS1WM_IRQ" },
 	{ GPIO104_MAGICIAN_LCD_POWER_1, GPIOF_OUT_INIT_LOW, "LCD power 1" },
 	{ GPIO105_MAGICIAN_LCD_POWER_2, GPIOF_OUT_INIT_LOW, "LCD power 2" },
 	{ GPIO106_MAGICIAN_LCD_POWER_3, GPIOF_OUT_INIT_LOW, "LCD power 3" },
-	{ GPIO83_MAGICIAN_nIR_EN, GPIOF_OUT_INIT_HIGH, "nIR_EN" },
+	{ GPIO83_MAGICIAN_nIR_EN, GPIOF_OUT_INIT_HIGH,	"nIR_EN" },
 };
 
 static void __init magician_init(void)
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


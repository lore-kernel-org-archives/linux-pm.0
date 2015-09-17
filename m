From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v3 08/26] ARM: pxa: magician: Rename abstract LCD GPIOs
Date: Thu, 17 Sep 2015 06:57:11 +0200
Message-ID: <55FA4827.7030307@tul.cz>
References: <cover.1442462898.git.petr.cvek@tul.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <cover.1442462898.git.petr.cvek@tul.cz>
Sender: linux-leds-owner@vger.kernel.org
To: robert.jarzmik@free.fr, philipp.zabel@gmail.com, daniel@zonque.org, haojian.zhuang@gmail.com, cooloney@gmail.com, rpurdie@rpsys.net, j.anaszewski@samsung.com, linux@arm.linux.org.uk, sre@kernel.org, dbaryshkov@gmail.com, lee.jones@linaro.org, sameo@linux.intel.com, dwmw2@infradead.org, arnd@arndb.de, g.liakhovetski@gmx.de
Cc: linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

This patch renames GPIOs, which are used to control the power lines to
the LCD screen. New names correspond to a real functionality, which was
measured on the HTC Magician board_id 0x3a.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/include/mach/magician.h |  6 +++---
 arch/arm/mach-pxa/magician.c              | 33 +++++++++++++++++--------------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/magician.h b/arch/arm/mach-pxa/include/mach/magician.h
index 88da10e..f0e08f8 100644
--- a/arch/arm/mach-pxa/include/mach/magician.h
+++ b/arch/arm/mach-pxa/include/mach/magician.h
@@ -52,9 +52,9 @@
 #define GPIO101_MAGICIAN_KEY_VOL_DOWN 		101
 #define GPIO102_MAGICIAN_KEY_PHONE		102
 #define GPIO103_MAGICIAN_LED_KP		103
-#define GPIO104_MAGICIAN_LCD_POWER_1 		104
-#define GPIO105_MAGICIAN_LCD_POWER_2		105
-#define GPIO106_MAGICIAN_LCD_POWER_3		106
+#define GPIO104_MAGICIAN_LCD_VOFF_EN		104
+#define GPIO105_MAGICIAN_LCD_VON_EN		105
+#define GPIO106_MAGICIAN_LCD_DCDC_NRESET	106
 #define GPIO107_MAGICIAN_DS1WM_IRQ		107
 #define GPIO108_MAGICIAN_GSM_READY		108
 #define GPIO114_MAGICIAN_UNKNOWN		114
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 91d302b..d78fc3a 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -337,22 +337,22 @@ static void toppoly_lcd_power(int on, struct fb_var_screeninfo *si)
 
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
 		msleep(15);
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
@@ -367,19 +367,19 @@ static void samsung_lcd_power(int on, struct fb_var_screeninfo *si)
 		else
 			gpio_set_value(EGPIO_MAGICIAN_LCD_POWER, 1);
 		mdelay(10);
-		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 1);
+		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 1);
 		mdelay(10);
-		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 1);
+		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 1);
 		mdelay(30);
-		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 1);
+		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 1);
 		mdelay(10);
 	} else {
 		mdelay(10);
-		gpio_set_value(GPIO105_MAGICIAN_LCD_POWER_2, 0);
+		gpio_set_value(GPIO105_MAGICIAN_LCD_VON_EN, 0);
 		mdelay(30);
-		gpio_set_value(GPIO104_MAGICIAN_LCD_POWER_1, 0);
+		gpio_set_value(GPIO104_MAGICIAN_LCD_VOFF_EN, 0);
 		mdelay(10);
-		gpio_set_value(GPIO106_MAGICIAN_LCD_POWER_3, 0);
+		gpio_set_value(GPIO106_MAGICIAN_LCD_DCDC_NRESET, 0);
 		mdelay(10);
 		if (system_rev < 3)
 			gpio_set_value(GPIO75_MAGICIAN_SAMSUNG_POWER, 0);
@@ -796,9 +796,11 @@ static struct platform_device *devices[] __initdata = {
 static struct gpio magician_global_gpios[] = {
 	{ GPIO13_MAGICIAN_CPLD_IRQ, GPIOF_IN, "CPLD_IRQ" },
 	{ GPIO107_MAGICIAN_DS1WM_IRQ, GPIOF_IN, "DS1WM_IRQ" },
-	{ GPIO104_MAGICIAN_LCD_POWER_1, GPIOF_OUT_INIT_LOW, "LCD power 1" },
-	{ GPIO105_MAGICIAN_LCD_POWER_2, GPIOF_OUT_INIT_LOW, "LCD power 2" },
-	{ GPIO106_MAGICIAN_LCD_POWER_3, GPIOF_OUT_INIT_LOW, "LCD power 3" },
+
+	/* NOTICE valid LCD init sequence */
+	{ GPIO106_MAGICIAN_LCD_DCDC_NRESET, GPIOF_OUT_INIT_LOW, "LCD DCDC nreset" },
+	{ GPIO104_MAGICIAN_LCD_VOFF_EN, GPIOF_OUT_INIT_LOW, "LCD VOFF enable" },
+	{ GPIO105_MAGICIAN_LCD_VON_EN, GPIOF_OUT_INIT_LOW, "LCD VON enable" },
 	{ GPIO83_MAGICIAN_nIR_EN, GPIOF_OUT_INIT_HIGH, "nIR_EN" },
 };
 
@@ -835,6 +837,7 @@ static void __init magician_init(void)
 		lcd_select = board_id & 0x8;
 		pr_info("LCD type: %s\n", lcd_select ? "Samsung" : "Toppoly");
 		if (lcd_select && (system_rev < 3))
+			/* NOTICE valid LCD init sequence */
 			gpio_request_one(GPIO75_MAGICIAN_SAMSUNG_POWER,
 				GPIOF_OUT_INIT_LOW, "Samsung LCD Power");
 		pxa_set_fb_info(NULL,
-- 
1.7.12.1

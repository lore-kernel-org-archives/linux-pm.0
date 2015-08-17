From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 05/21] ARM: pxa: magician: Add support for ADS7846
 touchscreen
Date: Mon, 17 Aug 2015 23:58:55 +0200
Message-ID: <55D2591F.10509@tul.cz>
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

Add support for ADS7846 touchscreen.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index bc206f8..fc1c035 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -68,6 +68,7 @@
 #include <linux/pwm_backlight.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/gpio-regulator.h>
+#include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/i2c/pxa-i2c.h>
@@ -84,6 +85,10 @@
 #include <linux/platform_data/irda-pxaficp.h>
 #include <linux/platform_data/usb-ohci-pxa27x.h>
 
+#include <linux/spi/spi.h>
+#include <linux/spi/pxa2xx_spi.h>
+#include <linux/spi/ads7846.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -766,6 +771,37 @@ static struct platform_device bq24022 = {
 };
 
 /*
+ * fixed regulator for ads7846
+ */
+
+static struct regulator_consumer_supply ads7846_supply =
+	REGULATOR_SUPPLY("vcc", "spi2.0");
+
+static struct regulator_init_data vads7846_regulator = {
+	.constraints = {
+		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = 1,
+	.consumer_supplies = &ads7846_supply,
+};
+
+static struct fixed_voltage_config vads7846 = {
+	.supply_name = "vads7846",
+	.microvolts = 3300000, /* probably */
+	.gpio = -EINVAL,
+	.startup_delay = 0,
+	.init_data = &vads7846_regulator,
+};
+
+static struct platform_device vads7846_device = {
+	.name = "reg-fixed-voltage",
+	.id = 1,
+	.dev = {
+		.platform_data = &vads7846,
+	},
+};
+
+/*
  * MMC/SD
  */
 
@@ -841,6 +877,51 @@ static struct i2c_pxa_platform_data i2c_info = {
 };
 
 /*
+ * Touchscreen
+ */
+
+static struct ads7846_platform_data ads7846_pdata = {
+	.model		= 7846,
+	.x_min		= 0,
+	.y_min		= 0,
+	.x_max		= 4096,
+	.y_max		= 4096,
+	.x_plate_ohms	= 320,	/* measured */
+	.y_plate_ohms	= 500,
+	.pressure_max	= 255,	/* up to 12bit sampling */
+	.debounce_max	= 10,
+	.debounce_tol	= 3,
+	.debounce_rep	= 1,
+	.gpio_pendown	= GPIO115_MAGICIAN_nPEN_IRQ,
+	.keep_vref_on	= 1,	/* FIXME, external Vref? */
+	.vref_delay_usecs = 100,
+	/* .wait_for_sync, GPIO77_LCD_BIAS low noise measure, latency! */
+};
+
+struct pxa2xx_spi_chip tsc2046_chip_info = {
+	.tx_threshold = 1,
+	.rx_threshold = 2,
+	.timeout = 64,
+	.gpio_cs = -1,
+};
+
+static struct pxa2xx_spi_master magician_spi_info = {
+	.num_chipselect = 1,
+/*	.enable_dma = 1, */ /* FIXME probably unnecessary */
+};
+
+static struct spi_board_info ads7846_spi_board_info[] __initdata = {
+	{
+		.modalias		= "ads7846",
+		.bus_num		= 2,
+		.max_speed_hz		= 1857143,
+		.platform_data		= &ads7846_pdata,
+		.controller_data	= &tsc2046_chip_info,
+		.irq = PXA_GPIO_TO_IRQ(GPIO115_MAGICIAN_nPEN_IRQ),
+	},
+};
+
+/*
  * Platform devices
  */
 
@@ -849,6 +930,7 @@ static struct platform_device *devices[] __initdata = {
 	&egpio,
 	&pwm_backlight,
 	&pasic3,
+	&vads7846_device,
 	&bq24022,
 	&gpio_vbus,
 	&power_supply,
@@ -915,6 +997,10 @@ static void __init magician_init(void)
 			lcd_select ? &samsung_info : &toppoly_info);
 	} else
 		pr_err("LCD detection: CPLD mapping failed\n");
+
+	pxa2xx_set_spi_info(2, &magician_spi_info);
+	spi_register_board_info(ARRAY_AND_SIZE(ads7846_spi_board_info));
+
 }
 
 MACHINE_START(MAGICIAN, "HTC Magician")
-- 
1.7.12.1

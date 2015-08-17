From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 06/21] ARM: pxa: magician: Add normal and power I2C
 definition
Date: Mon, 17 Aug 2015 23:59:22 +0200
Message-ID: <55D2593A.5060400@tul.cz>
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

Add normal and power I2C definition to HTC Magician.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index fc1c035..702e8e0 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -72,6 +72,8 @@
 #include <linux/regulator/machine.h>
 #include <linux/usb/gpio_vbus.h>
 #include <linux/i2c/pxa-i2c.h>
+#include <linux/i2c-gpio.h>
+#include <linux/i2c.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -873,10 +875,39 @@ static struct platform_device strataflash = {
  */
 
 static struct i2c_pxa_platform_data i2c_info = {
-	.fast_mode = 1,
+	.fast_mode = 0,	/* fast mode seems to be have bit errors */
+	.use_pio = 0, /* no polling */
 };
 
 /*
+ * PXA I2C power controller
+ */
+
+static struct i2c_pxa_platform_data magician_i2c_power_info = {
+	.fast_mode = 0,
+	.use_pio = 0,
+};
+
+/*
+ * GPIO I2C normal controller (alternative)
+ */
+
+static struct i2c_gpio_platform_data rtc_device_data = {
+	.sda_pin = GPIO118_MAGICIAN_I2C_SDA,
+	.scl_pin = GPIO117_MAGICIAN_I2C_SCL,
+	.udelay = 100
+};
+
+static struct platform_device i2c_gpio_bus_alt = {
+	.name = "i2c-gpio",
+	.id = 0,
+	.dev = {
+		.platform_data = &rtc_device_data,
+	}
+};
+
+
+/*
  * Touchscreen
  */
 
@@ -936,6 +967,9 @@ static struct platform_device *devices[] __initdata = {
 	&power_supply,
 	&strataflash,
 	&leds_gpio,
+
+	/* NOTICE mutually exclusive with PXA I2C */
+	&i2c_gpio_bus_alt,
 };
 
 /*
@@ -975,7 +1009,7 @@ static void __init magician_init(void)
 	platform_add_devices(ARRAY_AND_SIZE(devices));
 
 	pxa_set_ficp_info(&magician_ficp_info);
-	pxa27x_set_i2c_power_info(NULL);
+	pxa27x_set_i2c_power_info(&magician_i2c_power_info);
 	pxa_set_i2c_info(&i2c_info);
 	pxa_set_mci_info(&magician_mci_info);
 	pxa_set_ohci_info(&magician_ohci_info);
-- 
1.7.12.1

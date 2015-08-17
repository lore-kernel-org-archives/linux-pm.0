From: Petr Cvek <petr.cvek@tul.cz>
Subject: [PATCH v2 09/21] ARM: pxa: magician: Add OV9640 camera support
Date: Tue, 18 Aug 2015 00:01:05 +0200
Message-ID: <55D259A1.6090102@tul.cz>
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

Add OV9640 camera support for HTC Magician.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 63 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 7331b34..63604e1 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -91,6 +91,9 @@
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/spi/ads7846.h>
 
+#include <linux/platform_data/camera-pxa.h>
+#include <media/soc_camera.h>
+
 #include "devices.h"
 #include "generic.h"
 
@@ -634,6 +637,60 @@ static struct platform_device pasic3 = {
 };
 
 /*
+ * SoC Camera
+ */
+
+static struct pxacamera_platform_data magician_pxacamera_pdata = {
+	.flags = PXA_CAMERA_MASTER | PXA_CAMERA_DATAWIDTH_8 |
+		PXA_CAMERA_PCLK_EN | PXA_CAMERA_MCLK_EN,
+	.mclk_10khz = 4800,
+};
+
+static int magician_camera_power(struct device *dev, int power)
+{
+	pr_debug("Camera power = %i\n", power);
+
+	gpio_set_value(GPIO116_MAGICIAN_nCAM_EN, !power);
+	mdelay(3);
+
+	return 0;
+}
+
+static int magician_camera_reset(struct device *dev)
+{
+	pr_debug("Camera reset\n");
+
+	gpio_set_value(GPIO57_MAGICIAN_CAM_RESET, 1);
+	mdelay(3);
+	gpio_set_value(GPIO57_MAGICIAN_CAM_RESET, 0);
+	mdelay(3);
+
+	return 0;
+}
+
+static struct i2c_board_info magician_camera_i2c_board_info = {
+	I2C_BOARD_INFO("ov9640", 0x30),
+	.flags = I2C_CLIENT_SCCB,
+};
+
+static struct soc_camera_link magician_camera_iclink = {
+	.bus_id		= 0,
+	.flags		= SOCAM_DATAWIDTH_8,
+	.i2c_adapter_id	= 0,
+	.board_info	= &magician_camera_i2c_board_info,
+	.power		= magician_camera_power,
+	.reset		= magician_camera_reset,
+};
+
+static struct platform_device magician_camera = {
+	.name = "soc-camera-pdrv",
+	.id = 0,
+	.dev = {
+		.platform_data = &magician_camera_iclink,
+	},
+};
+
+/*
  * USB "Transceiver"
  */
 
@@ -1038,6 +1095,7 @@ static struct platform_device *devices[] __initdata = {
 	&gpio_vbus,
 	&power_supply,
 	&leds_gpio,
+	&magician_camera,
 
 	/* NOTICE mutually exclusive with PXA I2C */
 	&i2c_gpio_bus_alt,
@@ -1058,6 +1116,10 @@ static struct gpio magician_global_gpios[] = {
 		"LCD VOFF enable" },
 	{ GPIO105_MAGICIAN_LCD_VON_EN, GPIOF_OUT_INIT_HIGH,
 		"LCD VON enable" },
+	{ GPIO57_MAGICIAN_CAM_RESET, GPIOF_OUT_INIT_HIGH,
+		"Camera reset" },
+	{ GPIO116_MAGICIAN_nCAM_EN, GPIOF_OUT_INIT_HIGH,
+		"Camera power" },
 };
 
 static void __init magician_init(void)
@@ -1105,6 +1167,7 @@ static void __init magician_init(void)
 	pxa2xx_set_spi_info(2, &magician_spi_info);
 	spi_register_board_info(ARRAY_AND_SIZE(ads7846_spi_board_info));
 
+	pxa_set_camera_info(&magician_pxacamera_pdata);
 }
 
 MACHINE_START(MAGICIAN, "HTC Magician")
-- 
1.7.12.1

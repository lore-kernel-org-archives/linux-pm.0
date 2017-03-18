From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH V2 2/2] thermal: broadcom: add Raspberry Pi thermal driver
Date: Sat, 18 Mar 2017 01:06:03 +0100
Message-ID: <20170318000603.10158-2-zajec5@gmail.com>
References: <20170318000132.9212-1-zajec5@gmail.com>
 <20170318000603.10158-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170318000603.10158-1-zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

From: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>

Raspberry Pi devices use BCM283[567] SoCs with a thermal device inside.
Querying it is possible using Raspberry specific firmware interface.
This simple driver allows reading SoC temperature.

Signed-off-by: Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
---
V2: Update Kconfig help message. I forgot to locally rebase & fixup  before
    sending, sorry.
---
 drivers/thermal/Kconfig                        |  5 ++
 drivers/thermal/Makefile                       |  1 +
 drivers/thermal/broadcom/Kconfig               |  7 +++
 drivers/thermal/broadcom/Makefile              |  1 +
 drivers/thermal/broadcom/raspberrypi-thermal.c | 85 ++++++++++++++++++++++++++
 5 files changed, 99 insertions(+)
 create mode 100644 drivers/thermal/broadcom/Kconfig
 create mode 100644 drivers/thermal/broadcom/Makefile
 create mode 100644 drivers/thermal/broadcom/raspberrypi-thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 776b34396144..008e173ec825 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -392,6 +392,11 @@ config MTK_THERMAL
 	  Enable this option if you want to have support for thermal management
 	  controller present in Mediatek SoCs
 
+menu "Broadcom thermal drivers"
+depends on ARCH_BCM || COMPILE_TEST
+source "drivers/thermal/broadcom/Kconfig"
+endmenu
+
 menu "Texas Instruments thermal drivers"
 depends on ARCH_HAS_BANDGAP || COMPILE_TEST
 depends on HAS_IOMEM
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 7adae2029355..549d81b6363c 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -27,6 +27,7 @@ thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
 thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
 
 # platform thermal drivers
+obj-y				+= broadcom/
 obj-$(CONFIG_QCOM_SPMI_TEMP_ALARM)	+= qcom-spmi-temp-alarm.o
 obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
 obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
new file mode 100644
index 000000000000..2524b2ff16f6
--- /dev/null
+++ b/drivers/thermal/broadcom/Kconfig
@@ -0,0 +1,7 @@
+config RASPBERRYPI_THERMAL
+	tristate "Raspberry Pi thermal driver"
+	depends on ARCH_BCM2835 || COMPILE_TEST
+	depends on RASPBERRYPI_FIRMWARE=y
+	help
+	  This enables support for the RPi thermal that is part of BCM2835 SoC
+	  and can be accessed using firmware interface.
diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
new file mode 100644
index 000000000000..5ea7f8819b7d
--- /dev/null
+++ b/drivers/thermal/broadcom/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_RASPBERRYPI_THERMAL)	+= raspberrypi-thermal.o
diff --git a/drivers/thermal/broadcom/raspberrypi-thermal.c b/drivers/thermal/broadcom/raspberrypi-thermal.c
new file mode 100644
index 000000000000..d9c1db06f806
--- /dev/null
+++ b/drivers/thermal/broadcom/raspberrypi-thermal.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright (C) 2017 Rafał Miłecki <rafal-g1n6cQUeyibVItvQsEIGlw@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#include <soc/bcm2835/raspberrypi-firmware.h>
+
+struct rpi_thermal {
+	struct rpi_firmware *fw;
+};
+
+static int rpi_thermal_get_temp(void *data, int *temp)
+{
+	struct rpi_thermal *rpi_thermal = data;
+	struct {
+		u32 id;
+		u32 temp;
+	} tag_data = {};
+	int err;
+
+	err = rpi_firmware_property(rpi_thermal->fw,
+				    RPI_FIRMWARE_GET_TEMPERATURE,
+				    &tag_data, sizeof(tag_data));
+	if (!err)
+		*temp = tag_data.temp;
+
+	return err;
+}
+
+const struct thermal_zone_of_device_ops rpi_thermal_ops = {
+	.get_temp = rpi_thermal_get_temp,
+};
+
+static int rpi_thermal_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct rpi_thermal *rpi_thermal;
+	struct device_node *fw_np;
+	struct thermal_zone_device *tzd;
+
+	rpi_thermal = devm_kzalloc(dev, sizeof(*rpi_thermal), GFP_KERNEL);
+	if (!rpi_thermal)
+		return -ENOMEM;
+
+	fw_np = of_parse_phandle(dev->of_node, "firmware", 0);
+	if (!fw_np) {
+		dev_err(dev, "Failed to get firmware phandle\n");
+		return -ENOENT;
+	}
+
+	rpi_thermal->fw = rpi_firmware_get(fw_np);
+	of_node_put(fw_np);
+	if (!rpi_thermal->fw)
+		return -ENODEV;
+
+	tzd = devm_thermal_zone_of_sensor_register(dev, 0, rpi_thermal,
+						   &rpi_thermal_ops);
+
+	return PTR_ERR_OR_ZERO(tzd);
+}
+
+static const struct of_device_id rpi_thermal_of_match[] = {
+	{ .compatible = "raspberrypi,bcm2835-thermal", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rpi_thermal_of_match);
+
+static struct platform_driver rpi_thermal_driver = {
+	.probe		= rpi_thermal_probe,
+	.driver = {
+		.name = "raspberrypi-thermal",
+		.of_match_table = rpi_thermal_of_match,
+	},
+};
+module_platform_driver(rpi_thermal_driver);
+
+MODULE_DESCRIPTION("Raspberry Pi thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

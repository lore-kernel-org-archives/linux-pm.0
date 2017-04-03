From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V5 2/2] thermal: broadcom: add Northstar thermal driver
Date: Mon,  3 Apr 2017 17:48:29 +0200
Message-ID: <20170403154829.29780-2-zajec5@gmail.com>
References: <20170331201124.656-1-zajec5@gmail.com>
 <20170403154829.29780-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34342 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753851AbdDCPsn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 11:48:43 -0400
In-Reply-To: <20170403154829.29780-1-zajec5@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>, Jon Mason <jon.mason@broadcom.com>

From: Rafał Miłecki <rafal@milecki.pl>

Northstar is a SoC family commonly used in home routers. This commit
adds a driver for checking CPU temperature. As Northstar Plus seems to
also have this IP block this new symbol gets ARCH_BCM_IPROC dependency.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
V2: Make it iProc specific as NSP can also use this driver
    Select proper symbols in config ARCH_BCM_IPROC
    Define PVTMON register bits
    Update code selecting temperature monitor mode
    Thank you Jon!
V3: More details in help message for BCM_NS_THERMAL
    Use slope & offset
    Drop arch code change (I'll be submitted using a proper tree)
    Thank you Eduardo!
V4: Comment operations on PVTMON_CONTROL0 register
---
 drivers/thermal/Kconfig               |   5 ++
 drivers/thermal/Makefile              |   1 +
 drivers/thermal/broadcom/Kconfig      |   8 +++
 drivers/thermal/broadcom/Makefile     |   1 +
 drivers/thermal/broadcom/ns-thermal.c | 105 ++++++++++++++++++++++++++++++++++
 5 files changed, 120 insertions(+)
 create mode 100644 drivers/thermal/broadcom/Kconfig
 create mode 100644 drivers/thermal/broadcom/Makefile
 create mode 100644 drivers/thermal/broadcom/ns-thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 3bd24063375e..ac7301703d03 100644
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
index f23cde05dac6..6b7706b9f27c 100644
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
index 000000000000..f0dea8a8e002
--- /dev/null
+++ b/drivers/thermal/broadcom/Kconfig
@@ -0,0 +1,8 @@
+config BCM_NS_THERMAL
+	tristate "Northstar thermal driver"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	help
+	  Northstar is a family of SoCs that includes e.g. BCM4708, BCM47081,
+	  BCM4709 and BCM47094. It contains DMU (Device Management Unit) block
+	  with a thermal sensor that allows checking CPU temperature. This
+	  driver provides support for it.
diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
new file mode 100644
index 000000000000..059df9a0ed69
--- /dev/null
+++ b/drivers/thermal/broadcom/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_BCM_NS_THERMAL)		+= ns-thermal.o
diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
new file mode 100644
index 000000000000..eab96b3572b9
--- /dev/null
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2017 Rafał Miłecki <rafal@milecki.pl>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/thermal.h>
+
+#define PVTMON_CONTROL0					0x00
+#define PVTMON_CONTROL0_SEL_MASK			0x0000000e
+#define PVTMON_CONTROL0_SEL_TEMP_MONITOR		0x00000000
+#define PVTMON_CONTROL0_SEL_TEST_MODE			0x0000000e
+#define PVTMON_STATUS					0x08
+
+struct ns_thermal {
+	struct thermal_zone_device *tz;
+	void __iomem *pvtmon;
+};
+
+static int ns_thermal_get_temp(void *data, int *temp)
+{
+	struct ns_thermal *ns_thermal = data;
+	int offset = thermal_zone_get_offset(ns_thermal->tz);
+	int slope = thermal_zone_get_slope(ns_thermal->tz);
+	u32 val;
+
+	val = readl(ns_thermal->pvtmon + PVTMON_CONTROL0);
+	if ((val & PVTMON_CONTROL0_SEL_MASK) != PVTMON_CONTROL0_SEL_TEMP_MONITOR) {
+		/* Clear current mode selection */
+		val &= ~PVTMON_CONTROL0_SEL_MASK;
+
+		/* Set temp monitor mode (it's the default actually) */
+		val |= PVTMON_CONTROL0_SEL_TEMP_MONITOR;
+
+		writel(val, ns_thermal->pvtmon + PVTMON_CONTROL0);
+	}
+
+	val = readl(ns_thermal->pvtmon + PVTMON_STATUS);
+	*temp = slope * val + offset;
+
+	return 0;
+}
+
+const struct thermal_zone_of_device_ops ns_thermal_ops = {
+	.get_temp = ns_thermal_get_temp,
+};
+
+static int ns_thermal_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ns_thermal *ns_thermal;
+
+	ns_thermal = devm_kzalloc(dev, sizeof(*ns_thermal), GFP_KERNEL);
+	if (!ns_thermal)
+		return -ENOMEM;
+
+	ns_thermal->pvtmon = of_iomap(dev_of_node(dev), 0);
+	if (WARN_ON(!ns_thermal->pvtmon))
+		return -ENOENT;
+
+	ns_thermal->tz = devm_thermal_zone_of_sensor_register(dev, 0,
+							      ns_thermal,
+							      &ns_thermal_ops);
+	if (IS_ERR(ns_thermal->tz)) {
+		iounmap(ns_thermal->pvtmon);
+		return PTR_ERR(ns_thermal->tz);
+	}
+
+	platform_set_drvdata(pdev, ns_thermal);
+
+	return 0;
+}
+
+static int ns_thermal_remove(struct platform_device *pdev)
+{
+	struct ns_thermal *ns_thermal = platform_get_drvdata(pdev);
+
+	iounmap(ns_thermal->pvtmon);
+
+	return 0;
+}
+
+static const struct of_device_id ns_thermal_of_match[] = {
+	{ .compatible = "brcm,ns-thermal", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ns_thermal_of_match);
+
+static struct platform_driver ns_thermal_driver = {
+	.probe		= ns_thermal_probe,
+	.remove		= ns_thermal_remove,
+	.driver = {
+		.name = "ns-thermal",
+		.of_match_table = ns_thermal_of_match,
+	},
+};
+module_platform_driver(ns_thermal_driver);
+
+MODULE_DESCRIPTION("Northstar thermal driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

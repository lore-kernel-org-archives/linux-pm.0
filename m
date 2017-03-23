From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH V2 2/2] thermal: broadcom: add Northstar thermal driver
Date: Thu, 23 Mar 2017 23:30:45 +0100
Message-ID: <20170323223045.15786-2-zajec5@gmail.com>
References: <20170318155632.18099-1-zajec5@gmail.com>
 <20170323223045.15786-1-zajec5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34523 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbdCWWbK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 18:31:10 -0400
In-Reply-To: <20170323223045.15786-1-zajec5@gmail.com>
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
---
 arch/arm/mach-bcm/Kconfig             |  2 +
 drivers/thermal/Kconfig               |  5 ++
 drivers/thermal/Makefile              |  1 +
 drivers/thermal/broadcom/Kconfig      |  7 +++
 drivers/thermal/broadcom/Makefile     |  1 +
 drivers/thermal/broadcom/ns-thermal.c | 98 +++++++++++++++++++++++++++++++++++
 6 files changed, 114 insertions(+)
 create mode 100644 drivers/thermal/broadcom/Kconfig
 create mode 100644 drivers/thermal/broadcom/Makefile
 create mode 100644 drivers/thermal/broadcom/ns-thermal.c

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index a0e66d8200c5..da2bfeb8e390 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -19,6 +19,8 @@ config ARCH_BCM_IPROC
 	select GPIOLIB
 	select ARM_AMBA
 	select PINCTRL
+	select THERMAL
+	select THERMAL_OF
 	help
 	  This enables support for systems based on Broadcom IPROC architected SoCs.
 	  The IPROC complex contains one or more ARM CPUs along with common
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
index 000000000000..39b92a1f3584
--- /dev/null
+++ b/drivers/thermal/broadcom/Kconfig
@@ -0,0 +1,7 @@
+config BCM_NS_THERMAL
+	tristate "Northstar thermal driver"
+	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	help
+	  Northstar's DMU (Device Management Unit) block contains a thermal
+	  sensor that allows checking CPU temperature. This driver provides
+	  support for it.
diff --git a/drivers/thermal/broadcom/Makefile b/drivers/thermal/broadcom/Makefile
new file mode 100644
index 000000000000..059df9a0ed69
--- /dev/null
+++ b/drivers/thermal/broadcom/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_BCM_NS_THERMAL)		+= ns-thermal.o
diff --git a/drivers/thermal/broadcom/ns-thermal.c b/drivers/thermal/broadcom/ns-thermal.c
new file mode 100644
index 000000000000..acf3a4de62a4
--- /dev/null
+++ b/drivers/thermal/broadcom/ns-thermal.c
@@ -0,0 +1,98 @@
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
+	void __iomem *pvtmon;
+};
+
+static int ns_thermal_get_temp(void *data, int *temp)
+{
+	struct ns_thermal *ns_thermal = data;
+	u32 val;
+
+	val = readl(ns_thermal->pvtmon + PVTMON_CONTROL0);
+	if ((val & PVTMON_CONTROL0_SEL_MASK) != PVTMON_CONTROL0_SEL_TEMP_MONITOR) {
+		val &= ~PVTMON_CONTROL0_SEL_MASK;
+		val |= PVTMON_CONTROL0_SEL_TEMP_MONITOR;
+		writel(val, ns_thermal->pvtmon + PVTMON_CONTROL0);
+	}
+
+	val = readl(ns_thermal->pvtmon + PVTMON_STATUS);
+	*temp = (418 - (val * 5556 / 10000)) * 1000;
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
+	struct thermal_zone_device *tzd;
+
+	ns_thermal = devm_kzalloc(dev, sizeof(*ns_thermal), GFP_KERNEL);
+	if (!ns_thermal)
+		return -ENOMEM;
+
+	ns_thermal->pvtmon = of_iomap(dev_of_node(dev), 0);
+	if (WARN_ON(!ns_thermal->pvtmon))
+		return -ENOENT;
+
+	tzd = devm_thermal_zone_of_sensor_register(dev, 0, ns_thermal,
+						   &ns_thermal_ops);
+	if (IS_ERR(tzd)) {
+		iounmap(ns_thermal->pvtmon);
+		return PTR_ERR(tzd);
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

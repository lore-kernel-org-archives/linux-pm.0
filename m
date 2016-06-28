From: Bin Gao <bin.gao@linux.intel.com>
Subject: [PATCH] thermal: add Intel BXT WhiskeyCove PMIC thermal driver
Date: Mon, 27 Jun 2016 17:58:25 -0700
Message-ID: <20160628005825.GC9303@worksta>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57104 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbcF1Ay0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jun 2016 20:54:26 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ysiyer <yegnesh.s.iyer@intel.com>, Ajay Thomas <ajay.thomas.david.rajamanickam@intel.com>, Bin Gao <bin.gao@intel.com>

This patch adds Intel Whiskey Cove PMIC thermal driver which is intended
to handle the alert interrupts triggered upon thermal trip point cross
and notify the thermal framework appropriately with the zone, temp,
crossed trip and event details.

Signed-off-by: Yegnesh S Iyer <yegnesh.s.iyer@intel.com>
Signed-off-by: Bin Gao <bin.gao@intel.com>
---
 drivers/thermal/Kconfig              |  10 +++
 drivers/thermal/Makefile             |   1 +
 drivers/thermal/intel_pmic_thermal.c | 158 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/intel_soc_pmic.h   |  21 +++++
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/thermal/intel_pmic_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 2d702ca..9065ba7 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -332,6 +332,16 @@ menu "ACPI INT340X thermal drivers"
 source drivers/thermal/int340x_thermal/Kconfig
 endmenu
 
+config INTEL_PMIC_THERMAL
+	tristate "Intel PMIC thermal driver"
+	depends on X86 && INTEL_SOC_PMIC && REGMAP
+	help
+	  Select this driver for Intel PMIC with ADC channels monitoring system
+	  temperature measurements and alerts.
+	  This driver is used for monitoring the ADC channels of PMIC and handles
+	  the alert trip point interrupts and notifies the thermal framework with
+	  the trip point and temperature details of the zone.
+
 config INTEL_PCH_THERMAL
 	tristate "Intel PCH Thermal Reporting Driver"
 	depends on X86 && PCI
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 10b07c1..159efcc 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_INTEL_SOC_DTS_THERMAL)	+= intel_soc_dts_thermal.o
 obj-$(CONFIG_INTEL_QUARK_DTS_THERMAL)	+= intel_quark_dts_thermal.o
 obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
 obj-$(CONFIG_INT340X_THERMAL)  += int340x_thermal/
+obj-$(CONFIG_INTEL_PMIC_THERMAL) += intel_pmic_thermal.o
 obj-$(CONFIG_INTEL_PCH_THERMAL)	+= intel_pch_thermal.o
 obj-$(CONFIG_ST_THERMAL)	+= st/
 obj-$(CONFIG_TEGRA_SOCTHERM)	+= tegra/
diff --git a/drivers/thermal/intel_pmic_thermal.c b/drivers/thermal/intel_pmic_thermal.c
new file mode 100644
index 0000000..43881c7
--- /dev/null
+++ b/drivers/thermal/intel_pmic_thermal.c
@@ -0,0 +1,158 @@
+/*
+ * pmic_thermal.c - PMIC thermal driver
+ *
+ * Copyright (C) 2015 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/thermal.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/mfd/intel_soc_pmic.h>
+
+static irqreturn_t pmic_thermal_irq_handler(int irq, void *data)
+{
+	struct platform_device *pdev = data;
+	struct pmic_thermal_data *td =
+			(struct pmic_thermal_data *)pdev->dev.platform_data;
+	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
+	struct regmap *regmap = pmic->regmap;
+	struct thermal_zone_device *tzd;
+	int i, j, ret;
+	u16 reg, evt_stat_reg;
+	u8 reg_val, mask, irq_stat, trip;
+
+	/* Resolve thermal irqs */
+	for (i = 0; i < td->num_maps; i++) {
+		for (j = 0; j < td->maps[i].num_trips; j++) {
+			reg = td->maps[i].trip_config[j].irq_reg;
+			mask = td->maps[i].trip_config[j].irq_mask;
+			/*
+			 * Read the irq register to resolve whether the
+			 * interrupt was triggered for this sensor
+			 */
+			if (regmap_read(regmap, reg, &ret))
+				return IRQ_HANDLED;
+
+			reg_val = (u8)ret;
+
+			irq_stat = ((u8)ret & mask);
+			if (irq_stat) {
+				/*
+				 * Read the status register to find out what
+				 * event occurred i.e a high or a low
+				 */
+				evt_stat_reg =
+					td->maps[i].trip_config[j].evt_stat;
+				if (regmap_read(regmap, evt_stat_reg, &ret))
+					return IRQ_HANDLED;
+
+				trip = td->maps[i].trip_config[j].trip_num;
+				tzd = thermal_zone_get_zone_by_name(
+						td->maps[i].handle);
+				if (!IS_ERR(tzd))
+					thermal_zone_device_update(tzd);
+
+				/* Clear the appropriate irq */
+				regmap_write(regmap, reg, reg_val & mask);
+			}
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int pmic_thermal_probe(struct platform_device *pdev)
+{
+	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
+	struct regmap *regmap = pmic->regmap;
+	struct pmic_thermal_data *thermal_data;
+	struct regmap_irq_chip_data *regmap_irq_chip;
+	int ret, irq, virq, i, j, pmic_irq_count = 0;
+	u16 reg;
+	u8 mask;
+
+	thermal_data = (struct pmic_thermal_data *)pdev->dev.platform_data;
+	if (thermal_data == NULL) {
+		dev_err(&pdev->dev, "No thermal data initialized!!\n");
+		return -ENODEV;
+	}
+
+	regmap_irq_chip = pmic->irq_chip_data_level2;
+	while ((irq = platform_get_irq(pdev, pmic_irq_count)) != -ENXIO) {
+		ret = request_threaded_irq(irq, NULL, pmic_thermal_irq_handler,
+			      IRQF_ONESHOT, "pmic_thermal", thermal_data);
+
+		virq = regmap_irq_get_virq(regmap_irq_chip, irq);
+		if (virq < 0) {
+			dev_err(&pdev->dev,
+				"failed to get virtual interrupt=%d\n", irq);
+			return virq;
+		}
+
+		ret = devm_request_threaded_irq(&pdev->dev, virq,
+				NULL, pmic_thermal_irq_handler,
+				IRQF_ONESHOT, "pmic_thermal", pdev);
+
+		if (ret) {
+			dev_err(&pdev->dev, "request irq failed: %d,virq: %d\n",
+								ret, virq);
+			return ret;
+		}
+		pmic_irq_count++;
+	}
+
+	/* Enable thermal interrupts */
+	for (i = 0; i < thermal_data->num_maps; i++) {
+		for (j = 0; j < thermal_data->maps[i].num_trips; j++) {
+			reg = thermal_data->maps[i].trip_config[j].irq_en;
+			mask = thermal_data->maps[i].trip_config[j].irq_en_mask;
+			if (regmap_update_bits(regmap, reg, mask, 0x00))
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int pmic_thermal_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_device_id pmic_thermal_id_table[] = {
+	{ .name = "whiskey_cove_thermal" },
+	{ .name = "bxt_wcove_thermal" },
+	{},
+};
+
+static struct platform_driver pmic_thermal_driver = {
+	.probe = pmic_thermal_probe,
+	.remove = pmic_thermal_remove,
+	.driver = {
+		.name = "pmic_thermal",
+	},
+	.id_table = pmic_thermal_id_table,
+};
+
+MODULE_DEVICE_TABLE(platform, pmic_thermal_id_table);
+module_platform_driver(pmic_thermal_driver);
+
+MODULE_AUTHOR("Yegnesh S Iyer <yegnesh.s.iyer@intel.com>");
+MODULE_DESCRIPTION("PMIC thermal Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
index cf619db..7df4302 100644
--- a/include/linux/mfd/intel_soc_pmic.h
+++ b/include/linux/mfd/intel_soc_pmic.h
@@ -21,6 +21,27 @@
 
 #include <linux/regmap.h>
 
+struct trip_config_map {
+	u16 irq_reg;
+	u16 irq_en;
+	u16 evt_stat;
+	u8 irq_mask;
+	u8 irq_en_mask;
+	u8 evt_mask;
+	u8 trip_num;
+};
+
+struct thermal_irq_map {
+	char handle[20];
+	int num_trips;
+	struct trip_config_map *trip_config;
+};
+
+struct pmic_thermal_data {
+	struct thermal_irq_map *maps;
+	int num_maps;
+};
+
 struct intel_soc_pmic {
 	int irq;
 	struct regmap *regmap;
-- 
1.9.1


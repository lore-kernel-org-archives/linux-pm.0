From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v7 1/7] qcom: spm: Add Subsystem Power Manager driver
Date: Fri, 26 Sep 2014 18:58:09 -0600
Message-ID: <1411779495-39724-2-git-send-email-lina.iyer@linaro.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:51647 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbaI0A6b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Sep 2014 20:58:31 -0400
Received: by mail-pd0-f169.google.com with SMTP id p10so1948131pdj.0
        for <linux-pm@vger.kernel.org>; Fri, 26 Sep 2014 17:58:31 -0700 (PDT)
In-Reply-To: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Based on work by many authors, available at codeaurora.org

SPM is a hardware block that controls the peripheral logic surrounding
the application cores (cpu/l$). When the core executes WFI instruction,
the SPM takes over the putting the core in low power state as
configured. The wake up for the SPM is an interrupt at the GIC, which
then completes the rest of low power mode sequence and brings the core
out of low power mode.

The SPM has a set of control registers that configure the SPMs
individually based on the type of the core and the runtime conditions.
SPM is a finite state machine block to which a sequence is provided and
it interprets the bytes  and executes them in sequence. Each low power
mode that the core can enter into is provided to the SPM as a sequence.

Configure the SPM to set the core (cpu or L2) into its low power mode,
the index of the first command in the sequence is set in the SPM_CTL
register. When the core executes ARM wfi instruction, it triggers the
SPM state machine to start executing from that index. The SPM state
machine waits until the interrupt occurs and starts executing the rest
of the sequence until it hits the end of the sequence. The end of the
sequence jumps the core out of its low power mode.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[lina: simplify the driver for initial submission, clean up and update
commit text]
---
 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  10 +-
 drivers/soc/qcom/Kconfig                           |   8 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/spm.c                             | 216 +++++++++++++++++++++
 include/soc/qcom/spm.h                             |  35 ++++
 5 files changed, 264 insertions(+), 6 deletions(-)
 create mode 100644 drivers/soc/qcom/spm.c
 create mode 100644 include/soc/qcom/spm.h

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
index 1505fb8..9a9cc99 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
@@ -14,10 +14,9 @@ PROPERTIES
 	Value type: <string>
 	Definition: shall contain "qcom,saw2". A more specific value should be
 		    one of:
-			 "qcom,saw2-v1"
-			 "qcom,saw2-v1.1"
-			 "qcom,saw2-v2"
-			 "qcom,saw2-v2.1"
+			 "qcom,apq8064-saw2-v1.1-cpu"
+			 "qcom,msm8974-saw2-v2.1-cpu"
+			 "qcom,apq8084-saw2-v2.1-cpu"
 
 - reg:
 	Usage: required
@@ -26,10 +25,9 @@ PROPERTIES
 		    the register region. An optional second element specifies
 		    the base address and size of the alias register region.
 
-
 Example:
 
-	regulator@2099000 {
+	saw@2099000 {
 		compatible = "qcom,saw2";
 		reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
 	};
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 7dcd554..cd249c4 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -11,3 +11,11 @@ config QCOM_GSBI
 
 config QCOM_SCM
 	bool
+
+config QCOM_PM
+	bool "Qualcomm Power Management"
+	depends on PM && ARCH_QCOM
+	help
+	  QCOM Platform specific power driver to manage cores and L2 low power
+	  modes. It interface with various system drivers to put the cores in
+	  low power modes.
diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index 70d52ed..20b329f 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
+obj-$(CONFIG_QCOM_PM)	+=	spm.o
 CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
 obj-$(CONFIG_QCOM_SCM) += scm.o scm-boot.o
diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
new file mode 100644
index 0000000..0ba7949
--- /dev/null
+++ b/drivers/soc/qcom/spm.c
@@ -0,0 +1,216 @@
+/* Copyright (c) 2011-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
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
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+
+#include <soc/qcom/spm.h>
+
+enum {
+	SPM_REG_CFG,
+	SPM_REG_SPM_CTL,
+	SPM_REG_DLY,
+	SPM_REG_PMIC_DATA_0,
+	SPM_REG_PMIC_DATA_1,
+	SPM_REG_PMIC_DATA_2,
+	SPM_REG_PMIC_DATA_3,
+	SPM_REG_VCTL,
+	SPM_REG_SEQ_ENTRY_0,
+	SPM_REG_SEQ_ENTRY_1,
+	SPM_REG_SEQ_ENTRY_2,
+	SPM_REG_SEQ_ENTRY_3,
+	SPM_REG_SEQ_ENTRY_4,
+	SPM_REG_SEQ_ENTRY_5,
+	SPM_REG_SEQ_ENTRY_6,
+	SPM_REG_SEQ_ENTRY_7,
+	SPM_REG_SEQ_ENTRY_LAST = SPM_REG_SEQ_ENTRY_7,
+	SPM_REG_SPM_STS,
+	SPM_REG_PMIC_STS,
+	SPM_REG_NR,
+};
+
+struct spm_reg_data {
+	/* Register position and initialization value */
+	struct register_info {
+		u8 offset;
+		u32 value;
+	} reg[SPM_REG_NR];
+
+	/* Start address offset for the supported idle states*/
+	u8 start_addr[SPM_MODE_NR];
+};
+
+struct spm_driver_data {
+	void __iomem *reg_base_addr;
+	const struct spm_reg_data *reg_data;
+};
+
+/* SPM register data for 8974, 8084 */
+static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
+	.reg[SPM_REG_CFG]		= {0x08, 0x1},
+	.reg[SPM_REG_SPM_STS]		= {0x0C, 0x0},
+	.reg[SPM_REG_PMIC_STS]		= {0x14, 0x0},
+	.reg[SPM_REG_VCTL]		= {0x1C, 0x0},
+	.reg[SPM_REG_SPM_CTL]		= {0x30, 0x1},
+	.reg[SPM_REG_DLY]		= {0x34, 0x3C102800},
+	.reg[SPM_REG_PMIC_DATA_0]	= {0x40, 0x0},
+	.reg[SPM_REG_PMIC_DATA_1]	= {0x44, 0x0},
+	.reg[SPM_REG_PMIC_DATA_2]	= {0x48, 0x0},
+	.reg[SPM_REG_SEQ_ENTRY_0]	= {0x80, 0x000F0B03},
+	.reg[SPM_REG_SEQ_ENTRY_1]	= {0x84, 0xE8108020},
+	.reg[SPM_REG_SEQ_ENTRY_2]	= {0x88, 0xE83B035B},
+	.reg[SPM_REG_SEQ_ENTRY_3]	= {0x8C, 0x300B1082},
+	.reg[SPM_REG_SEQ_ENTRY_4]	= {0x90, 0x0F302606},
+	.reg[SPM_REG_SEQ_ENTRY_5]	= {0x94, 0x0},
+	.reg[SPM_REG_SEQ_ENTRY_6]	= {0x98, 0x0},
+	.reg[SPM_REG_SEQ_ENTRY_7]	= {0x9C, 0x0},
+
+	.start_addr[SPM_MODE_CLOCK_GATING]	= 0,
+	.start_addr[SPM_MODE_POWER_COLLAPSE]	= 3,
+};
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct spm_driver_data, cpu_spm_drv);
+
+/**
+ * spm_set_low_power_mode() - Configure SPM start address for low power mode
+ * @mode: SPM LPM mode to enter
+ */
+int qcom_spm_set_low_power_mode(enum spm_mode mode)
+{
+	struct spm_driver_data *drv = &__get_cpu_var(cpu_spm_drv);
+	u32 start_addr = 0;
+	u32 ctl_val;
+
+	if (!drv || !drv->reg_data)
+		return -ENXIO;
+
+	start_addr = drv->reg_data->start_addr[mode];
+
+	/* Update bits 10:4 in the SPM CTL register */
+	ctl_val = readl_relaxed(drv->reg_base_addr +
+				drv->reg_data->reg[SPM_REG_SPM_CTL].offset);
+	start_addr &= 0x7F;
+	start_addr <<= 4;
+	ctl_val &= 0xFFFFF80F;
+	ctl_val |= start_addr;
+	writel_relaxed(ctl_val, drv->reg_base_addr +
+				drv->reg_data->reg[SPM_REG_SPM_CTL].offset);
+	/* Ensure we have written the start address */
+	wmb();
+
+	return 0;
+}
+
+static struct spm_driver_data *spm_get_drv(struct platform_device *pdev)
+{
+	struct spm_driver_data *drv = NULL;
+	struct device_node *cpu_node, *saw_node;
+	u32 cpu;
+
+	for_each_possible_cpu(cpu) {
+		cpu_node = of_get_cpu_node(cpu, NULL);
+		if (!cpu_node)
+			continue;
+		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
+		if (!saw_node)
+			continue;
+		if (saw_node == pdev->dev.of_node) {
+			drv = &per_cpu(cpu_spm_drv, cpu);
+			break;
+		}
+	}
+
+	return drv;
+}
+
+static const struct of_device_id spm_match_table[] __initconst = {
+	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
+	  .data = &spm_reg_8974_8084_cpu },
+	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
+	  .data = &spm_reg_8974_8084_cpu },
+	{ },
+};
+
+static int spm_dev_probe(struct platform_device *pdev)
+{
+	struct spm_driver_data *drv;
+	struct resource *res;
+	const struct of_device_id *match_id;
+	int i;
+
+	 /* Get the right SPM device */
+	drv = spm_get_drv(pdev);
+	if (!drv)
+		return -EINVAL;
+
+	/* Get the SPM start address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	drv->reg_base_addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(drv->reg_base_addr))
+		return PTR_ERR(drv->reg_base_addr);
+
+	match_id = of_match_node(spm_match_table, pdev->dev.of_node);
+	if (!match_id)
+		return -ENODEV;
+
+	/* Get the SPM register data for this instance */
+	drv->reg_data = match_id->data;
+	if (!drv->reg_data)
+		return -EINVAL;
+
+	/* Write the SPM sequences first */
+	for (i = SPM_REG_SEQ_ENTRY_0; i <= SPM_REG_SEQ_ENTRY_LAST; i++)
+		writel_relaxed(drv->reg_data->reg[i].value,
+			drv->reg_base_addr + drv->reg_data->reg[i].offset);
+
+	/* Write the SPM control registers */
+	writel_relaxed(drv->reg_data->reg[SPM_REG_DLY].value,
+		drv->reg_base_addr + drv->reg_data->reg[SPM_REG_DLY].offset);
+
+	writel_relaxed(drv->reg_data->reg[SPM_REG_CFG].value,
+		drv->reg_base_addr + drv->reg_data->reg[SPM_REG_CFG].offset);
+
+	writel_relaxed(drv->reg_data->reg[SPM_REG_SPM_CTL].value,
+			drv->reg_base_addr +
+			drv->reg_data->reg[SPM_REG_SPM_CTL].offset);
+
+	/**
+	 * Ensure all observers see the above register writes before the
+	 * cpuidle driver is allowed to use the SPM.
+	 */
+	wmb();
+
+	return 0;
+}
+
+static struct platform_driver spm_driver = {
+	.probe = spm_dev_probe,
+	.driver = {
+		.name = "spm",
+		.of_match_table = spm_match_table,
+	},
+};
+
+static int __init spm_driver_init(void)
+{
+	return platform_driver_register(&spm_driver);
+}
+device_initcall(spm_driver_init);
diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
new file mode 100644
index 0000000..997abfc
--- /dev/null
+++ b/include/soc/qcom/spm.h
@@ -0,0 +1,35 @@
+/* Copyright (c) 2010-2014, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __QCOM_SPM_H
+#define __QCOM_SPM_H
+
+enum spm_mode {
+	SPM_MODE_CLOCK_GATING,
+	SPM_MODE_RETENTION,
+	SPM_MODE_GDHS,
+	SPM_MODE_POWER_COLLAPSE,
+	SPM_MODE_NR
+};
+
+#if defined(CONFIG_QCOM_PM)
+
+int qcom_spm_set_low_power_mode(enum spm_mode mode);
+
+#else
+
+static inline int qcom_spm_set_low_power_mode(enum spm_mode mode)
+{ return -ENOSYS; }
+
+#endif  /* CONFIG_QCOM_PM */
+
+#endif  /* __QCOM_SPM_H */
-- 
1.9.1


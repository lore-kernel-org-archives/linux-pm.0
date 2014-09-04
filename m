From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v5 3/7] qcom: spm-devices: Add SPM device manager for the SoC
Date: Thu,  4 Sep 2014 16:35:28 -0600
Message-ID: <1409870132-16929-4-git-send-email-lina.iyer@linaro.org>
References: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1409870132-16929-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org
Cc: linux-pm@vger.kernel.org, msivasub@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Based on work by many authors, available at codeaurora.org

Each cpu or an L2$ has an SPM device. They are identical instances of
the same SPM block. This allows for multiple instances be grouped and
managed collectively. spm-devices.c is the SPM device manager managing
multiple SPM devices on top of the driver layer.

Device configuration of each SPM is picked up from the DTS. The hardware
configuration of each of the SPM is handled by the driver (spm.c).

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
[lina: simplify the driver for initial submission, clean up and update
commit text]
---
 Documentation/devicetree/bindings/arm/msm/spm.txt |  47 +++++
 drivers/soc/qcom/Kconfig                          |   8 +
 drivers/soc/qcom/Makefile                         |   2 +-
 drivers/soc/qcom/spm-devices.c                    | 198 ++++++++++++++++++++++
 include/soc/qcom/spm.h                            |  38 +++++
 5 files changed, 292 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/spm.txt
 create mode 100644 drivers/soc/qcom/spm-devices.c
 create mode 100644 include/soc/qcom/spm.h

diff --git a/Documentation/devicetree/bindings/arm/msm/spm.txt b/Documentation/devicetree/bindings/arm/msm/spm.txt
new file mode 100644
index 0000000..30623b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/spm.txt
@@ -0,0 +1,47 @@
+* Subsystem Power Manager (SAW2)
+
+S4 generation of MSMs have SPM hardware blocks to control the Application
+Processor Sub-System power. These SPM blocks run individual state machine
+to determine what the core (L2 or Krait/Scorpion) would do when the WFI
+instruction is executed by the core.
+
+The devicetree representation of the SPM block should be:
+
+Required properties
+
+- compatible: Could be one of -
+		"qcom,spm-v2.1"
+- reg: The physical address and the size of the SPM's memory mapped registers
+- qcom,cpu: phandle for the CPU that the SPM block is attached to.
+	This field is required on only for SPMs that control the CPU.
+- qcom,saw2-clk-div: SAW2 configuration register to program the SPM runtime
+	clocks.
+- qcom,saw2-delays: The SPM delay values that SPM sequences would refer to.
+- qcom,saw2-enable: The SPM control register to enable/disable the sleep state
+	machine.
+
+Optional properties
+
+- qcom,saw2-spm-cmd-wfi: The WFI command sequence
+- qcom,saw2-spm-cmd-ret: The Retention command sequence
+- qcom,saw2-spm-cmd-spc: The Standalone PC command sequence
+- qcom,saw2-spm-cmd-pc: The Power Collapse command sequence. This sequence may
+	turn off other SoC components.
+- qcom,saw2-spm-cmd-gdhs: GDHS (Globally Distributed Head Switch) command
+	sequence. This sequence will retain the memory but turn off the logic.
+-
+Example:
+	spm@f9089000 {
+		compatible = "qcom,spm-v2.1";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xf9089000 0x1000>;
+		qcom,cpu = <&CPU0>;
+		qcom,saw2-clk-div = <0x1>;
+		qcom,saw2-delays = <0x20000400>;
+		qcom,saw2-enable = <0x1>;
+		qcom,saw2-spm-cmd-wfi = [03 0b 0f];
+		qcom,saw2-spm-cmd-spc = [00 20 50 80 60 70 10 92
+				a0 b0 03 68 70 3b 92 a0 b0
+				82 2b 50 10 30 02 22 30 0f];
+	};
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
index 20b329f..9457b2a 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_QCOM_GSBI)	+=	qcom_gsbi.o
-obj-$(CONFIG_QCOM_PM)	+=	spm.o
+obj-$(CONFIG_QCOM_PM)	+=	spm.o spm-devices.o
 CFLAGS_scm.o :=$(call as-instr,.arch_extension sec,-DREQUIRES_SEC=1)
 obj-$(CONFIG_QCOM_SCM) += scm.o scm-boot.o
diff --git a/drivers/soc/qcom/spm-devices.c b/drivers/soc/qcom/spm-devices.c
new file mode 100644
index 0000000..776c0af
--- /dev/null
+++ b/drivers/soc/qcom/spm-devices.c
@@ -0,0 +1,198 @@
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
+#include "spm-drv.h"
+
+/**
+ * All related information for an SPM device
+ * Helps manage the collective.
+ */
+struct msm_spm_device {
+	bool initialized;
+	struct msm_spm_driver_data drv;
+};
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct msm_spm_device, msm_cpu_spm_device);
+
+/**
+ * msm_spm_set_low_power_mode() - Configure SPM start address for low power mode
+ * @mode: SPM LPM mode to enter
+ */
+int msm_spm_set_low_power_mode(u32 mode)
+{
+	struct msm_spm_device *dev = &__get_cpu_var(msm_cpu_spm_device);
+	int ret = -EINVAL;
+
+	if (!dev->initialized)
+		return -ENXIO;
+
+	if (mode == MSM_SPM_MODE_DISABLED)
+		ret = msm_spm_drv_set_spm_enable(&dev->drv, false);
+	else if (!msm_spm_drv_set_spm_enable(&dev->drv, true))
+		ret = msm_spm_drv_set_low_power_mode(&dev->drv, mode);
+
+	return ret;
+}
+EXPORT_SYMBOL(msm_spm_set_low_power_mode);
+
+static int get_cpu_id(struct device_node *node)
+{
+	struct device_node *cpu_node;
+	u32 cpu;
+	int ret = -EINVAL;
+	char *key = "qcom,cpu";
+
+	cpu_node = of_parse_phandle(node, key, 0);
+	if (cpu_node) {
+		for_each_possible_cpu(cpu) {
+			if (of_get_cpu_node(cpu, NULL) == cpu_node)
+				return cpu;
+		}
+	}
+	return ret;
+}
+
+static struct msm_spm_device *msm_spm_get_device(struct platform_device *pdev)
+{
+	struct msm_spm_device *dev = NULL;
+	int cpu = get_cpu_id(pdev->dev.of_node);
+
+	if ((cpu >= 0) && cpu < num_possible_cpus())
+		dev = &per_cpu(msm_cpu_spm_device, cpu);
+
+	return dev;
+}
+
+static int msm_spm_dev_probe(struct platform_device *pdev)
+{
+	int ret;
+	int i;
+	struct device_node *node = pdev->dev.of_node;
+	char *key;
+	u32 val;
+	struct msm_spm_mode modes[MSM_SPM_MODE_NR];
+	struct msm_spm_device *spm_dev;
+	struct resource *res;
+	u32 mode_count = 0;
+
+	struct spm_of {
+		char *key;
+		u32 id;
+	};
+
+	/* SPM Configuration registers */
+	struct spm_of spm_of_data[] = {
+		{"qcom,saw2-clk-div", MSM_SPM_REG_SAW2_CFG},
+		{"qcom,saw2-enable", MSM_SPM_REG_SAW2_SPM_CTL},
+		{"qcom,saw2-delays", MSM_SPM_REG_SAW2_SPM_DLY},
+	};
+
+	/* SPM sleep sequences */
+	struct spm_of mode_of_data[] = {
+		{"qcom,saw2-spm-cmd-wfi", MSM_SPM_MODE_CLOCK_GATING},
+		{"qcom,saw2-spm-cmd-spc", MSM_SPM_MODE_POWER_COLLAPSE},
+		{"qcom,saw2-spm-cmd-ret", MSM_SPM_MODE_RETENTION},
+	};
+
+	 /* Get the right SPM device */
+	spm_dev = msm_spm_get_device(pdev);
+	if (IS_ERR_OR_NULL(spm_dev))
+		return -EINVAL;
+
+	/* Get the SAW start address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -EINVAL;
+		goto fail;
+	}
+	spm_dev->drv.reg_base_addr = devm_ioremap(&pdev->dev, res->start,
+					resource_size(res));
+	if (!spm_dev->drv.reg_base_addr) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	/* Read the SPM configuration register values */
+	for (i = 0; i < ARRAY_SIZE(spm_of_data); i++) {
+		ret = of_property_read_u32(node, spm_of_data[i].key, &val);
+		if (ret)
+			continue;
+		spm_dev->drv.reg_shadow[spm_of_data[i].id] = val;
+	}
+
+	/* Read the byte arrays for the SPM sleep sequences */
+	for (i = 0; i < ARRAY_SIZE(mode_of_data); i++) {
+		modes[mode_count].start_addr = 0;
+		key = mode_of_data[i].key;
+		modes[mode_count].cmd =
+			(u8 *)of_get_property(node, key, &val);
+		if (!modes[mode_count].cmd)
+			continue;
+		modes[mode_count].mode = mode_of_data[i].id;
+		mode_count++;
+	}
+
+	spm_dev->drv.modes = devm_kcalloc(&pdev->dev, mode_count,
+						sizeof(modes[0]), GFP_KERNEL);
+	if (!spm_dev->drv.modes)
+		return -ENOMEM;
+	spm_dev->drv.num_modes = mode_count;
+	memcpy(spm_dev->drv.modes, &modes[0], sizeof(modes[0]) * mode_count);
+
+	/* Initialize the hardware */
+	ret = msm_spm_drv_init(&spm_dev->drv);
+	if (ret) {
+		kfree(spm_dev->drv.modes);
+		return ret;
+	}
+
+	spm_dev->initialized = true;
+	return ret;
+
+fail:
+	dev_err(&pdev->dev, "SPM device probe failed: %d\n", ret);
+	return ret;
+}
+
+static struct of_device_id msm_spm_match_table[] = {
+	{.compatible = "qcom,spm-v2.1"},
+	{},
+};
+
+static struct platform_driver msm_spm_device_driver = {
+	.probe = msm_spm_dev_probe,
+	.driver = {
+		.name = "spm-v2",
+		.owner = THIS_MODULE,
+		.of_match_table = msm_spm_match_table,
+	},
+};
+
+static int __init msm_spm_device_init(void)
+{
+	return platform_driver_register(&msm_spm_device_driver);
+}
+device_initcall(msm_spm_device_init);
diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
new file mode 100644
index 0000000..29686ef
--- /dev/null
+++ b/include/soc/qcom/spm.h
@@ -0,0 +1,38 @@
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
+enum {
+	MSM_SPM_MODE_DISABLED,
+	MSM_SPM_MODE_CLOCK_GATING,
+	MSM_SPM_MODE_RETENTION,
+	MSM_SPM_MODE_GDHS,
+	MSM_SPM_MODE_POWER_COLLAPSE,
+	MSM_SPM_MODE_NR
+};
+
+struct msm_spm_device;
+
+#if defined(CONFIG_QCOM_PM)
+
+int msm_spm_set_low_power_mode(u32 mode);
+
+#else
+
+static inline int msm_spm_set_low_power_mode(u32 mode)
+{ return -ENOSYS; }
+
+#endif  /* CONFIG_QCOM_PM */
+
+#endif  /* __QCOM_SPM_H */
-- 
1.9.1

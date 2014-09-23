From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v6 1/5] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 23 Sep 2014 17:51:17 -0600
Message-ID: <1411516281-58328-2-git-send-email-lina.iyer@linaro.org>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: galak@codeaurora.org, sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@linaro.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

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
 Documentation/devicetree/bindings/arm/msm/spm.txt |  43 +++
 drivers/soc/qcom/Kconfig                          |   8 +
 drivers/soc/qcom/Makefile                         |   1 +
 drivers/soc/qcom/spm.c                            | 388 ++++++++++++++++++++++
 include/soc/qcom/spm.h                            |  38 +++
 5 files changed, 478 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/spm.txt
 create mode 100644 drivers/soc/qcom/spm.c
 create mode 100644 include/soc/qcom/spm.h

diff --git a/Documentation/devicetree/bindings/arm/msm/spm.txt b/Documentation/devicetree/bindings/arm/msm/spm.txt
new file mode 100644
index 0000000..2ff2454
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/spm.txt
@@ -0,0 +1,43 @@
+* Subsystem Power Manager (SPM)
+
+Qualcomm Snapdragons have SPM hardware blocks to control the Application
+Processor Sub-System power. These SPM blocks run individual state machine
+to determine what the core (L2 or Krait/Scorpion) would do when the WFI
+instruction is executed by the core.
+
+The devicetree representation of the SPM block should be:
+
+Required properties
+
+- compatible: Must be -
+		 "qcom,spm-v2.1"
+- reg: The physical address and the size of the SPM's memory mapped registers
+- qcom,cpu: phandle for the CPU that the SPM block is attached to.
+	This field is required on only for SPMs that control the CPU.
+- qcom,saw2-clk-div: SAW2 configuration register to program the SPM runtime
+	clocks. The register for this property is MSM_SPM_REG_SAW2_CFG.
+- qcom,saw2-delays: The SPM delay values that SPM sequences would refer to.
+	The register for this property is MSM_SPM_REG_SAW2_SPM_DLY.
+- qcom,saw2-enable: The SPM control register to enable/disable the sleep state
+	machine. The register for this property is MSM_SPM_REG_SAW2_SPM_CTL.
+
+Optional properties
+
+- qcom,saw2-spm-cmd-wfi: The WFI command sequence
+- qcom,saw2-spm-cmd-spc: The Standalone PC command sequence
+
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
index 0000000..1fa6a96
--- /dev/null
+++ b/drivers/soc/qcom/spm.c
@@ -0,0 +1,388 @@
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
+#define NUM_SEQ_ENTRY 32
+#define SPM_CTL_ENABLE BIT(0)
+
+enum {
+	MSM_SPM_REG_SAW2_CFG,
+	MSM_SPM_REG_SAW2_AVS_CTL,
+	MSM_SPM_REG_SAW2_AVS_HYSTERESIS,
+	MSM_SPM_REG_SAW2_SPM_CTL,
+	MSM_SPM_REG_SAW2_PMIC_DLY,
+	MSM_SPM_REG_SAW2_AVS_LIMIT,
+	MSM_SPM_REG_SAW2_AVS_DLY,
+	MSM_SPM_REG_SAW2_SPM_DLY,
+	MSM_SPM_REG_SAW2_PMIC_DATA_0,
+	MSM_SPM_REG_SAW2_PMIC_DATA_1,
+	MSM_SPM_REG_SAW2_PMIC_DATA_2,
+	MSM_SPM_REG_SAW2_PMIC_DATA_3,
+	MSM_SPM_REG_SAW2_PMIC_DATA_4,
+	MSM_SPM_REG_SAW2_PMIC_DATA_5,
+	MSM_SPM_REG_SAW2_PMIC_DATA_6,
+	MSM_SPM_REG_SAW2_PMIC_DATA_7,
+	MSM_SPM_REG_SAW2_RST,
+
+	MSM_SPM_REG_NR_INITIALIZE = MSM_SPM_REG_SAW2_RST,
+
+	MSM_SPM_REG_SAW2_ID,
+	MSM_SPM_REG_SAW2_SECURE,
+	MSM_SPM_REG_SAW2_STS0,
+	MSM_SPM_REG_SAW2_STS1,
+	MSM_SPM_REG_SAW2_STS2,
+	MSM_SPM_REG_SAW2_VCTL,
+	MSM_SPM_REG_SAW2_SEQ_ENTRY,
+	MSM_SPM_REG_SAW2_SPM_STS,
+	MSM_SPM_REG_SAW2_AVS_STS,
+	MSM_SPM_REG_SAW2_PMIC_STS,
+	MSM_SPM_REG_SAW2_VERSION,
+
+	MSM_SPM_REG_NR,
+};
+
+static u32 reg_offsets_saw2_v2_1[MSM_SPM_REG_NR] = {
+	[MSM_SPM_REG_SAW2_SECURE]		= 0x00,
+	[MSM_SPM_REG_SAW2_ID]			= 0x04,
+	[MSM_SPM_REG_SAW2_CFG]			= 0x08,
+	[MSM_SPM_REG_SAW2_SPM_STS]		= 0x0C,
+	[MSM_SPM_REG_SAW2_AVS_STS]		= 0x10,
+	[MSM_SPM_REG_SAW2_PMIC_STS]		= 0x14,
+	[MSM_SPM_REG_SAW2_RST]			= 0x18,
+	[MSM_SPM_REG_SAW2_VCTL]			= 0x1C,
+	[MSM_SPM_REG_SAW2_AVS_CTL]		= 0x20,
+	[MSM_SPM_REG_SAW2_AVS_LIMIT]		= 0x24,
+	[MSM_SPM_REG_SAW2_AVS_DLY]		= 0x28,
+	[MSM_SPM_REG_SAW2_AVS_HYSTERESIS]	= 0x2C,
+	[MSM_SPM_REG_SAW2_SPM_CTL]		= 0x30,
+	[MSM_SPM_REG_SAW2_SPM_DLY]		= 0x34,
+	[MSM_SPM_REG_SAW2_PMIC_DATA_0]		= 0x40,
+	[MSM_SPM_REG_SAW2_PMIC_DATA_1]		= 0x44,
+	[MSM_SPM_REG_SAW2_PMIC_DATA_2]		= 0x48,
+	[MSM_SPM_REG_SAW2_PMIC_DATA_3]		= 0x4C,
+	[MSM_SPM_REG_SAW2_PMIC_DATA_4]		= 0x50,
+	[MSM_SPM_REG_SAW2_PMIC_DATA_5]		= 0x54,
+	[MSM_SPM_REG_SAW2_PMIC_DATA_6]		= 0x58,
+	[MSM_SPM_REG_SAW2_PMIC_DATA_7]		= 0x5C,
+	[MSM_SPM_REG_SAW2_SEQ_ENTRY]		= 0x80,
+	[MSM_SPM_REG_SAW2_VERSION]		= 0xFD0,
+};
+
+struct spm_of {
+	char *key;
+	u32 id;
+};
+
+struct msm_spm_mode {
+	u32 mode;
+	u32 start_addr;
+};
+
+struct msm_spm_driver_data {
+	void __iomem *reg_base_addr;
+	u32 *reg_offsets;
+	struct msm_spm_mode *modes;
+	u32 num_modes;
+};
+
+struct msm_spm_device {
+	bool initialized;
+	struct msm_spm_driver_data drv;
+};
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct msm_spm_device, msm_cpu_spm_device);
+
+static const struct of_device_id msm_spm_match_table[] __initconst;
+
+static int msm_spm_drv_set_low_power_mode(struct msm_spm_driver_data *drv,
+						u32 mode)
+{
+	int i;
+	u32 start_addr = 0;
+	u32 ctl_val;
+
+	for (i = 0; i < drv->num_modes; i++) {
+		if (drv->modes[i].mode == mode) {
+			start_addr = drv->modes[i].start_addr;
+			break;
+		}
+	}
+
+	if (i == drv->num_modes)
+		return -EINVAL;
+
+	/* Update bits 10:4 in the SPM CTL register */
+	ctl_val = readl_relaxed(drv->reg_base_addr +
+			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
+	start_addr &= 0x7F;
+	start_addr <<= 4;
+	ctl_val &= 0xFFFFF80F;
+	ctl_val |= start_addr;
+	writel_relaxed(ctl_val, drv->reg_base_addr +
+			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
+	/* Ensure we have written the start address */
+	wmb();
+
+	return 0;
+}
+
+static int msm_spm_drv_set_spm_enable(struct msm_spm_driver_data *drv,
+					bool enable)
+{
+	u32 value = enable ? 0x01 : 0x00;
+	u32 ctl_val;
+
+	ctl_val = readl_relaxed(drv->reg_base_addr +
+			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
+
+	/* Update SPM_CTL to enable/disable the SPM */
+	if ((ctl_val & SPM_CTL_ENABLE) != value) {
+		/* Clear the existing value and update */
+		ctl_val &= ~0x1;
+		ctl_val |= value;
+		writel_relaxed(ctl_val, drv->reg_base_addr +
+			drv->reg_offsets[MSM_SPM_REG_SAW2_SPM_CTL]);
+
+		/* Ensure we have enabled/disabled before returning */
+		wmb();
+	}
+
+	return 0;
+}
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
+static void append_seq_data(u32 *reg_seq_entry, u8 *cmd, u32 *offset)
+{
+	u32 cmd_w;
+	u32 offset_w = *offset / 4;
+	u8 last_cmd;
+
+	while (1) {
+		int i;
+
+		cmd_w = 0;
+		last_cmd = 0;
+		cmd_w = reg_seq_entry[offset_w];
+
+		for (i = (*offset % 4); i < 4; i++) {
+			last_cmd = *(cmd++);
+			cmd_w |=  last_cmd << (i * 8);
+			(*offset)++;
+			if (last_cmd == 0x0f)
+				break;
+		}
+
+		reg_seq_entry[offset_w++] = cmd_w;
+		if (last_cmd == 0x0f)
+			break;
+	}
+}
+
+static int msm_spm_seq_init(struct msm_spm_device *spm_dev,
+			struct platform_device *pdev)
+{
+	int i;
+	u8 *cmd;
+	void *addr;
+	u32 val;
+	u32 count = 0;
+	int offset = 0;
+	struct msm_spm_mode modes[MSM_SPM_MODE_NR];
+	u32 sequences[NUM_SEQ_ENTRY/4] = {0};
+	struct msm_spm_driver_data *drv = &spm_dev->drv;
+
+	/* SPM sleep sequences */
+	struct spm_of mode_of_data[] = {
+		{"qcom,saw2-spm-cmd-wfi", MSM_SPM_MODE_CLOCK_GATING},
+		{"qcom,saw2-spm-cmd-spc", MSM_SPM_MODE_POWER_COLLAPSE},
+	};
+
+	/**
+	 * Compose the u32 array based on the individual bytes of the SPM
+	 * sequence for each low power mode that we read from the DT.
+	 * The sequences are appended if there is space available in the
+	 * u32 after the end of the previous sequence.
+	 */
+
+	for (i = 0; i < ARRAY_SIZE(mode_of_data); i++) {
+		cmd = (u8 *)of_get_property(pdev->dev.of_node,
+						mode_of_data[i].key, &val);
+		if (!cmd)
+			continue;
+		/* The last in the sequence should be 0x0F */
+		if (cmd[val - 1] != 0x0F)
+			continue;
+		modes[count].mode = mode_of_data[i].id;
+		modes[count].start_addr = offset;
+		append_seq_data(&sequences[0], cmd, &offset);
+		count++;
+	}
+
+	/* Write the idle state sequences to SPM */
+	drv->modes = devm_kcalloc(&pdev->dev, count,
+					sizeof(modes[0]), GFP_KERNEL);
+	if (!drv->modes)
+		return -ENOMEM;
+
+	drv->num_modes = count;
+	memcpy(drv->modes, modes, sizeof(modes[0]) * count);
+
+	/* Flush the integer array */
+	addr = drv->reg_base_addr +
+			drv->reg_offsets[MSM_SPM_REG_SAW2_SEQ_ENTRY];
+	for (i = 0; i < ARRAY_SIZE(sequences); i++, addr += 4)
+		writel_relaxed(sequences[i], addr);
+
+	/* Ensure we flush the writes */
+	wmb();
+
+	return 0;
+}
+
+static struct msm_spm_device *msm_spm_get_device(struct platform_device *pdev)
+{
+	struct msm_spm_device *dev = NULL;
+	struct device_node *cpu_node;
+	u32 cpu;
+
+	cpu_node = of_parse_phandle(pdev->dev.of_node, "qcom,cpu", 0);
+	if (cpu_node) {
+		for_each_possible_cpu(cpu) {
+			if (of_get_cpu_node(cpu, NULL) == cpu_node)
+				dev = &per_cpu(msm_cpu_spm_device, cpu);
+		}
+	}
+
+	return dev;
+}
+
+static int msm_spm_dev_probe(struct platform_device *pdev)
+{
+	int ret;
+	int i;
+	u32 val;
+	struct msm_spm_device *spm_dev;
+	struct resource *res;
+	const struct of_device_id *match_id;
+
+	/* SPM Configuration registers */
+	struct spm_of spm_of_data[] = {
+		{"qcom,saw2-clk-div", MSM_SPM_REG_SAW2_CFG},
+		{"qcom,saw2-enable", MSM_SPM_REG_SAW2_SPM_CTL},
+		{"qcom,saw2-delays", MSM_SPM_REG_SAW2_SPM_DLY},
+	};
+
+	 /* Get the right SPM device */
+	spm_dev = msm_spm_get_device(pdev);
+	if (IS_ERR_OR_NULL(spm_dev))
+		return -EINVAL;
+
+	/* Get the SPM start address */
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
+	match_id = of_match_node(msm_spm_match_table, pdev->dev.of_node);
+	if (!match_id)
+		return -ENODEV;
+
+	/* Use the register offsets for the SPM version in use */
+	spm_dev->drv.reg_offsets = (u32 *)match_id->data;
+	if (!spm_dev->drv.reg_offsets)
+		return -EFAULT;
+
+	/* Read the SPM idle state sequences */
+	ret = msm_spm_seq_init(spm_dev, pdev);
+	if (ret)
+		return ret;
+
+	/* Read the SPM register values */
+	for (i = 0; i < ARRAY_SIZE(spm_of_data); i++) {
+		ret = of_property_read_u32(pdev->dev.of_node,
+					spm_of_data[i].key, &val);
+		if (ret)
+			continue;
+		writel_relaxed(val, spm_dev->drv.reg_base_addr +
+				spm_dev->drv.reg_offsets[spm_of_data[i].id]);
+	}
+
+	/* Flush all writes */
+	wmb();
+
+	spm_dev->initialized = true;
+	return ret;
+fail:
+	dev_err(&pdev->dev, "SPM device probe failed: %d\n", ret);
+	return ret;
+}
+
+static const struct of_device_id msm_spm_match_table[] __initconst = {
+	{.compatible = "qcom,spm-v2.1", .data = reg_offsets_saw2_v2_1},
+	{ },
+};
+
+
+static struct platform_driver msm_spm_device_driver = {
+	.probe = msm_spm_dev_probe,
+	.driver = {
+		.name = "spm",
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

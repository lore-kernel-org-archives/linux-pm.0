From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v8 1/7] qcom: spm: Add Subsystem Power Manager driver
Date: Tue,  7 Oct 2014 15:41:40 -0600
Message-ID: <1412718106-17049-2-git-send-email-lina.iyer@linaro.org>
References: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1412718106-17049-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

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

Based on work by: Mahesh Sivasubramanian <msivasub@codeaurora.org>,
Ai Li <ali@codeaurora.org>, Praveen Chidambaram <pchidamb@codeaurora.org>
Original tree available at -
git://codeaurora.org/quic/la/kernel/msm-3.10.git

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |  31 ++-
 drivers/soc/qcom/Kconfig                           |   8 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/spm.c                             | 223 +++++++++++++++++++++
 4 files changed, 257 insertions(+), 6 deletions(-)
 create mode 100644 drivers/soc/qcom/spm.c

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
index 1505fb8..a18e8fc 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt
@@ -2,11 +2,20 @@ SPM AVS Wrapper 2 (SAW2)
 
 The SAW2 is a wrapper around the Subsystem Power Manager (SPM) and the
 Adaptive Voltage Scaling (AVS) hardware. The SPM is a programmable
-micro-controller that transitions a piece of hardware (like a processor or
+power-controller that transitions a piece of hardware (like a processor or
 subsystem) into and out of low power modes via a direct connection to
 the PMIC. It can also be wired up to interact with other processors in the
 system, notifying them when a low power state is entered or exited.
 
+Multiple revisions of the SAW hardware is supported using these Device Nodes.
+SAW2 revisions differ in the register offset and configuration data. Also,
+same revision of the SAW in different SoCs may have different configuration
+data due the the differences in hardware capabilities. Hence the SoC name, the
+version of the SAW hardware in that SoC and the distinction between cpu (big
+or Little) or cache, may be needed to uniquely identify the SAW register
+configuration and initialization data. The compatible string is used to
+indicate this parameter.
+
 PROPERTIES
 
 - compatible:
@@ -14,10 +23,13 @@ PROPERTIES
 	Value type: <string>
 	Definition: shall contain "qcom,saw2". A more specific value should be
 		    one of:
-			 "qcom,saw2-v1"
-			 "qcom,saw2-v1.1"
-			 "qcom,saw2-v2"
-			 "qcom,saw2-v2.1"
+			"qcom,saw2-v1"
+			"qcom,saw2-v1.1"
+			"qcom,saw2-v2"
+			"qcom,saw2-v2.1"
+			"qcom,apq8064-saw2-v1.1-cpu"
+			"qcom,msm8974-saw2-v2.1-cpu"
+			"qcom,apq8084-saw2-v2.1-cpu"
 
 - reg:
 	Usage: required
@@ -26,10 +38,17 @@ PROPERTIES
 		    the register region. An optional second element specifies
 		    the base address and size of the alias register region.
 
+- regulator:
+	Usage: optional
+	Value type: boolean
+	Definition: Indicates that this SPM device acts as a regulator device
+			device for the core (CPU or Cache) the SPM is attached
+			to.
 
 Example:
 
-	regulator@2099000 {
+	power-controller@2099000 {
 		compatible = "qcom,saw2";
 		reg = <0x02099000 0x1000>, <0x02009000 0x1000>;
+		regulator;
 	};
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 7dcd554..012fb37 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -11,3 +11,11 @@ config QCOM_GSBI
 
 config QCOM_SCM
 	bool
+
+config QCOM_PM
+	bool "Qualcomm Power Management"
+	depends on ARCH_QCOM
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
index 0000000..c1dd04b
--- /dev/null
+++ b/drivers/soc/qcom/spm.c
@@ -0,0 +1,223 @@
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
+#include <soc/qcom/pm.h>
+
+#define MAX_PMIC_DATA 3
+#define MAX_SEQ_DATA 64
+
+enum {
+	SPM_REG_CFG,
+	SPM_REG_SPM_CTL,
+	SPM_REG_DLY,
+	SPM_REG_PMIC_DLY,
+	SPM_REG_PMIC_DATA_0,
+	SPM_REG_VCTL,
+	SPM_REG_SEQ_ENTRY,
+	SPM_REG_SPM_STS,
+	SPM_REG_PMIC_STS,
+	SPM_REG_NR,
+};
+
+struct spm_reg_data {
+	/* Register position */
+	const u8 *reg_offset;
+
+	/* Register initialization values */
+	u32 spm_cfg;
+	u32 spm_dly;
+	u32 pmic_dly;
+	u32 pmic_data[MAX_PMIC_DATA];
+
+	/* Sequences and start indices */
+	u8 seq[MAX_SEQ_DATA];
+	u8 start_index[PM_SLEEP_MODE_NR];
+
+};
+
+struct spm_driver_data {
+	void __iomem *reg_base_addr;
+	const struct spm_reg_data *reg_data;
+};
+
+static const u8 spm_reg_offset_v2_1[SPM_REG_NR] = {
+	[SPM_REG_CFG]		= 0x08,
+	[SPM_REG_SPM_CTL]	= 0x30,
+	[SPM_REG_DLY]		= 0x34,
+	[SPM_REG_SEQ_ENTRY]	= 0x80,
+};
+
+/* SPM register data for 8974, 8084 */
+static const struct spm_reg_data spm_reg_8974_8084_cpu  = {
+	.reg_offset = spm_reg_offset_v2_1,
+	.spm_cfg = 0x1,
+	.spm_dly = 0x3C102800,
+	.seq = { 0x03, 0x0B, 0x0F, 0x00, 0x20, 0x80, 0x10, 0xE8, 0x5B, 0x03,
+		0x3B, 0xE8, 0x5B, 0x82, 0x10, 0x0B, 0x30, 0x06, 0x26, 0x30,
+		0x0F },
+	.start_index[PM_SLEEP_MODE_STBY] = 0,
+	.start_index[PM_SLEEP_MODE_SPC] = 3,
+};
+
+static DEFINE_PER_CPU_SHARED_ALIGNED(struct spm_driver_data, cpu_spm_drv);
+
+/**
+ * spm_set_low_power_mode() - Configure SPM start address for low power mode
+ * @mode: SPM LPM mode to enter
+ */
+int qcom_spm_set_low_power_mode(enum pm_sleep_mode mode)
+{
+	struct spm_driver_data *drv = &__get_cpu_var(cpu_spm_drv);
+	u32 start_index;
+	u32 ctl_val;
+
+	if (!drv->reg_base_addr)
+		return -ENXIO;
+
+	start_index = drv->reg_data->start_index[mode];
+
+	ctl_val = readl_relaxed(drv->reg_base_addr +
+				drv->reg_data->reg_offset[SPM_REG_SPM_CTL]);
+	start_index &= 0x7F;
+	start_index <<= 4;
+	ctl_val &= 0xFFFFF80F;
+	ctl_val |= start_index;
+	ctl_val |= 0x1; /* Enable the SPM CTL register */
+	writel_relaxed(ctl_val, drv->reg_base_addr +
+				drv->reg_data->reg_offset[SPM_REG_SPM_CTL]);
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
+		if (drv)
+			break;
+		cpu_node = of_get_cpu_node(cpu, NULL);
+		if (!cpu_node)
+			continue;
+		saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
+		if (saw_node) {
+			if (saw_node == pdev->dev.of_node)
+				drv = &per_cpu(cpu_spm_drv, cpu);
+			of_node_put(saw_node);
+		}
+		of_node_put(cpu_node);
+	}
+
+	return drv;
+}
+
+static const struct of_device_id spm_match_table[] = {
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
+	void __iomem *addr, *reg_base;
+	int i;
+	const u32 *seq_regs;
+
+	 /* Get the right SPM device */
+	drv = spm_get_drv(pdev);
+	if (!drv)
+		return -EINVAL;
+
+	/* Get the SPM start address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(reg_base))
+		return PTR_ERR(reg_base);
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
+	/* Write the SPM sequences */
+	addr = reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
+	seq_regs = (const u32 *)drv->reg_data->seq;
+	for (i = 0; i < ARRAY_SIZE(drv->reg_data->seq)/4; i++)
+		writel_relaxed(seq_regs[i], 4 * i + addr);
+
+	/**
+	 *  Write the SPM registers.
+	 *  An offset of 0, indicates that the SPM version does not support
+	 *  this register, otherwise it should be supported.
+	 */
+	writel_relaxed(drv->reg_data->spm_cfg,
+			reg_base + drv->reg_data->reg_offset[SPM_REG_CFG]);
+
+	if (drv->reg_data->reg_offset[SPM_REG_DLY])
+		writel_relaxed(drv->reg_data->spm_dly, reg_base +
+				drv->reg_data->reg_offset[SPM_REG_DLY]);
+
+	if (drv->reg_data->reg_offset[SPM_REG_PMIC_DLY])
+		writel_relaxed(drv->reg_data->pmic_dly, reg_base +
+				drv->reg_data->reg_offset[SPM_REG_PMIC_DLY]);
+
+	/* Write the PMIC data */
+	if (drv->reg_data->reg_offset[SPM_REG_PMIC_DATA_0])
+		for (i = 0; i < MAX_PMIC_DATA; i++)
+			writel_relaxed(drv->reg_data->pmic_data[i], reg_base +
+				drv->reg_data->reg_offset[SPM_REG_PMIC_DATA_0] +
+				4 * i);
+
+	/**
+	 * Ensure all observers see the above register writes before the
+	 * cpuidle driver is allowed to use the SPM.
+	 */
+	wmb();
+	drv->reg_base_addr = reg_base;
+
+	return 0;
+}
+
+static struct platform_driver spm_driver = {
+	.probe = spm_dev_probe,
+	.driver = {
+		.name = "qcom,spm",
+		.of_match_table = spm_match_table,
+	},
+};
+
+module_platform_driver(spm_driver);
-- 
1.9.1

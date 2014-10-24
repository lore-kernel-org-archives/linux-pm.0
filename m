From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v9 6/9] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Fri, 24 Oct 2014 17:40:21 -0600
Message-ID: <1414194024-55547-7-git-send-email-lina.iyer@linaro.org>
References: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:48722 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932850AbaJXXk5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Oct 2014 19:40:57 -0400
Received: by mail-pd0-f172.google.com with SMTP id r10so2276211pdi.17
        for <linux-pm@vger.kernel.org>; Fri, 24 Oct 2014 16:40:57 -0700 (PDT)
In-Reply-To: <1414194024-55547-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Add cpuidle driver interface to allow cpus to go into C-States. Use the
cpuidle DT interface, common across ARM architectures, to provide the
C-State information to the cpuidle framework.

Supported modes at this time are Standby and Standalone Power Collapse.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 .../bindings/arm/msm/qcom,idle-state.txt           | 81 ++++++++++++++++++++++
 drivers/cpuidle/Kconfig.arm                        |  7 ++
 drivers/cpuidle/Makefile                           |  1 +
 drivers/cpuidle/cpuidle-qcom.c                     | 72 +++++++++++++++++++
 4 files changed, 161 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
 create mode 100644 drivers/cpuidle/cpuidle-qcom.c

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
new file mode 100644
index 0000000..ae1b07f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
@@ -0,0 +1,81 @@
+QCOM Idle States for cpuidle driver
+
+ARM provides idle-state node to define the cpuidle states, as defined in [1].
+cpuidle-qcom is the cpuidle driver for Qualcomm SoCs and uses these idle
+states. Idle states have different enter/exit latency and residency values.
+The idle states supported by the QCOM SoC are defined as -
+
+    * Standby
+    * Retention
+    * Standalone Power Collapse (Standalone PC or SPC)
+    * Power Collapse (PC)
+
+Standby: Standby does a little more in addition to architectural clock gating.
+When the WFI instruction is executed the ARM core would gate its internal
+clocks. In addition to gating the clocks, QCOM cpus use this instruction as a
+trigger to execute the SPM state machine. The SPM state machine waits for the
+interrupt to trigger the core back in to active. This triggers the cache
+hierarchy to enter standby states, when all cpus are idle. An interrupt brings
+the SPM state machine out of its wait, the next step is to ensure that the
+cache hierarchy is also out of standby, and then the cpu is allowed to resume
+execution.
+
+Retention: Retention is a low power state where the core is clock gated and
+the memory and the registers associated with the core are retained. The
+voltage may be reduced to the minimum value needed to keep the processor
+registers active. The SPM should be configured to execute the retention
+sequence and would wait for interrupt, before restoring the cpu to execution
+state. Retention may have a slightly higher latency than Standby.
+
+Standalone PC: A cpu can power down and warmboot if there is a sufficient time
+between the time it enters idle and the next known wake up. SPC mode is used
+to indicate a core entering a power down state without consulting any other
+cpu or the system resources. This helps save power only on that core.  The SPM
+sequence for this idle state is programmed to power down the supply to the
+core, wait for the interrupt, restore power to the core, and ensure the
+system state including cache hierarchy is ready before allowing core to
+resume. Applying power and resetting the core causes the core to warmboot
+back into Elevation Level (EL) which trampolines the control back to the
+kernel. Entering a power down state for the cpu, needs to be done by trapping
+into a EL. Failing to do so, would result in a crash enforced by the warm boot
+code in the EL for the SoC. On SoCs with write-back L1 cache, the cache has to
+be flushed in s/w, before powering down the core.
+
+Power Collapse: This state is similar to the SPC mode, but distinguishes
+itself in that the cpu acknowledges and permits the SoC to enter deeper sleep
+modes. In a hierarchical power domain SoC, this means L2 and other caches can
+be flushed, system bus, clocks - lowered, and SoC main XO clock gated and
+voltages reduced, provided all cpus enter this state.  Since the span of low
+power modes possible at this state is vast, the exit latency and the residency
+of this low power mode would be considered high even though at a cpu level,
+this essentially is cpu power down. The SPM in this state also may handshake
+with the Resource power manager processor in the SoC to indicate a complete
+application processor subsystem shut down.
+
+The idle-state for QCOM SoCs are distinguished by the compatible property of
+the idle-states device node.
+The devicetree representation of the idle state should be -
+
+Required properties:
+
+- compatible: Must be one of -
+			"qcom,idle-state-stby",
+			"qcom,idle-state-ret",
+			"qcom,idle-state-spc",
+			"qcom,idle-state-pc",
+		and "arm,idle-state".
+
+Other required and optional properties are specified in [1].
+
+Example:
+
+	idle-states {
+		CPU_SPC: spc {
+			compatible = "qcom,idle-state-spc", "arm,idle-state";
+			entry-latency-us = <150>;
+			exit-latency-us = <200>;
+			min-residency-us = <2000>;
+		};
+	};
+
+[1]. Documentation/devicetree/bindings/arm/idle-states.txt
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8c16ab2..13c7c1f 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -63,3 +63,10 @@ config ARM_MVEBU_V7_CPUIDLE
 	depends on ARCH_MVEBU
 	help
 	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
+
+config ARM_QCOM_CPUIDLE
+	bool "CPU Idle drivers for Qualcomm processors"
+	depends on QCOM_PM
+	select DT_IDLE_STATES
+	help
+	  Select this to enable cpuidle for QCOM processors
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 4d177b9..6c222d5 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
+obj-$(CONFIG_ARM_QCOM_CPUIDLE)		+= cpuidle-qcom.o
 
 ###############################################################################
 # MIPS drivers
diff --git a/drivers/cpuidle/cpuidle-qcom.c b/drivers/cpuidle/cpuidle-qcom.c
new file mode 100644
index 0000000..1c1dcbc
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-qcom.c
@@ -0,0 +1,72 @@
+/*
+ * Copyright (c) 2014, Linaro Limited.
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
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include <soc/qcom/pm.h>
+#include "dt_idle_states.h"
+
+static struct qcom_cpu_pm_ops *lpm_ops;
+
+static int qcom_cpu_stby(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int index)
+{
+	lpm_ops->standby(NULL);
+
+	return index;
+}
+
+static int qcom_cpu_spc(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int index)
+{
+	lpm_ops->spc(NULL);
+
+	return index;
+}
+
+static struct cpuidle_driver qcom_cpuidle_driver = {
+	.name	= "qcom_cpuidle",
+};
+
+static const struct of_device_id qcom_idle_state_match[] = {
+	{ .compatible = "qcom,idle-state-stby", .data = qcom_cpu_stby},
+	{ .compatible = "qcom,idle-state-spc", .data = qcom_cpu_spc },
+	{ },
+};
+
+static int qcom_cpuidle_probe(struct platform_device *pdev)
+{
+	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
+	int ret;
+
+	lpm_ops = pdev->dev.platform_data;
+
+	/* Probe for other states, including standby */
+	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 0);
+	if (ret < 0)
+		return ret;
+
+	return cpuidle_register(drv, NULL);
+}
+
+static struct platform_driver qcom_cpuidle_plat_driver = {
+	.probe	= qcom_cpuidle_probe,
+	.driver = {
+		.name = "qcom_cpuidle",
+	},
+};
+
+module_platform_driver(qcom_cpuidle_plat_driver);
-- 
2.1.0


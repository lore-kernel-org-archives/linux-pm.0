From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v6 4/5] qcom: cpuidle: Add cpuidle driver for QCOM cpus
Date: Tue, 23 Sep 2014 17:51:20 -0600
Message-ID: <1411516281-58328-5-git-send-email-lina.iyer@linaro.org>
References: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34636 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340AbaIWXv4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Sep 2014 19:51:56 -0400
Received: by mail-pa0-f45.google.com with SMTP id lj1so7311098pab.18
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2014 16:51:55 -0700 (PDT)
In-Reply-To: <1411516281-58328-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: galak@codeaurora.org, sboyd@codeaurora.org, daniel.lezcano@linaro.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@linaro.org, msivasub@codeaurora.org, lorenzo.pieralisi@arm.com, linux-pm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>

Add cpuidle driver interface to allow cpus to go into C-States. Use the
cpuidle DT interface common across ARM architectures to provide the
C-State information to the cpuidle framework.

Supported modes at this time are clock gating (wfi) and cpu power down
(Standalone PC or spc).

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 .../bindings/arm/msm/qcom,idle-state.txt           | 72 +++++++++++++++++
 drivers/cpuidle/Kconfig.arm                        |  7 ++
 drivers/cpuidle/Makefile                           |  1 +
 drivers/cpuidle/cpuidle-qcom.c                     | 89 ++++++++++++++++++++++
 4 files changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
 create mode 100644 drivers/cpuidle/cpuidle-qcom.c

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
new file mode 100644
index 0000000..47095b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,idle-state.txt
@@ -0,0 +1,72 @@
+QCOM Idle States for cpuidle driver
+
+ARM provides idle-state node to define the cpuidle states, as defined in [1].
+cpuidle-qcom is the cpuidle driver for Qualcomm SoCs and uses these idle
+states. Idle states have different enter/exit latency and residency values.
+The idle states supported by the QCOM SoC are defined as -
+
+    * WFI
+    * Retention
+    * Standalone Power Collapse (Standalone PC or SPC)
+    * Power Collapse (PC)
+
+WFI: WFI does a little more in addition to architectural clock gating.  ARM
+processors when execute the wfi instruction will gate their internal clocks.
+QCOM cpus use this instruction as a trigger for the SPM state machine. Usually
+with a cpu entering WFI, the SPM is configured to do clock-gating as well. The
+SPM state machine waits for the interrrupt to trigger the core back in to
+active. When all CPUs in the SoC, clock gate using the ARM wfi instruction, the
+second level cache usually can also clock gate sensing no cpu activity. When a
+cpu is ready to run, it needs the cache to be active before starting execution.
+Allowing the SPM to execute the clock gating statemachine and waiting for
+interrupt on behalf of the processor has a benefit of guaranteeing that the
+system state is conducive for the core to resume execution.
+
+Retention: Retention is a low power state where the core is clockgated and the
+memory and the registers associated with the core are retained.  The voltage
+may be reduced to the minimum value needed to keep the processor registers
+active. Retention is triggered when the core executes wfi instruction. The SPM
+should be configured to execute the retention sequence and would wait for
+interrupt, before restoring the cpu to execution state. Retention may have a
+slightly higher latency than WFI.
+
+Standalone PC: A cpu can power down and warmboot if there is a sufficient time
+between now and the next know wake up. SPC mode is used to indicate a core
+entering a power down state without consulting any other cpu or the system
+resources. This helps save power only on that core. Like WFI and Retention, the
+core executes wfi and the SPM programmed to do SPC would use the cpu control
+logic to power down the core's supply and restore it back when woken up by an
+interrupt.  Applying power and reseting the core causes the core to warmboot
+back into secure mode which trampolines the control back to the kernel. To
+enter a power down state the kernel needs to call into the secure layer which
+would then execute the ARM wfi instruction. Failing to do so, would result in a
+crash enforced by the warm boot code in the secure layer. On a SoC with
+write-back L1 cache, the cache would need to be flushed.
+
+Power Collapse: This state is similiar to the SPC mode, but distinguishes
+itself in the fact that the cpu acknowledges and permits the SoC to enter
+deeper sleep modes. In a hierarchical power domain SoC, this means L2 and other
+caches can be flushed, system bus, clocks - lowered, and SoC main XO turned off
+and voltages reduced, provided all cpus enter this state. In other words, it is
+a coupled idle state.  Since the span of low power modes possible at this state
+is vast, the exit latency and the residency of this low power mode would be
+considered high even though at a cpu level, this essentially is cpu power down.
+The SPM in this state also may handshake with the Resource power manager
+processor in the SoC to indicate a complete subsystem shut down.
+
+The idle-state for QCOM SoCs are distinguished by the compatible property of
+the node. They indicate to the cpuidle driver the entry point to use for
+cpuidle. The devicetree representation of the idle state should be -
+
+Required properties:
+
+- compatible: Must be "arm,idle-state"
+		and one of -
+			"qcom,idle-state-wfi",
+			"qcom,idle-state-ret",
+			"qcom,idle-state-spc",
+			"qcom,idle-state-pc",
+
+Other required and optional properties are specified in [1].
+
+[1]. Documentation/devicetree/bindings/arm/idle-states.txt
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 38cff69..6a9ee12 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -62,3 +62,10 @@ config ARM_MVEBU_V7_CPUIDLE
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
index 0000000..d226ac1
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-qcom.c
@@ -0,0 +1,89 @@
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
+#include <linux/cpu_pm.h>
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include <soc/qcom/pm.h>
+#include "dt_idle_states.h"
+
+static void (*qcom_idle_enter)(enum msm_pm_sleep_mode);
+
+static int qcom_lpm_enter_wfi(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int index)
+{
+	qcom_idle_enter(MSM_PM_SLEEP_MODE_WFI);
+
+	return index;
+}
+
+static int qcom_lpm_enter_spc(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int index)
+{
+	cpu_pm_enter();
+	qcom_idle_enter(MSM_PM_SLEEP_MODE_SPC);
+	cpu_pm_exit();
+
+	return index;
+}
+
+static struct cpuidle_driver qcom_cpuidle_driver = {
+	.name	= "qcom_cpuidle",
+	.owner	= THIS_MODULE,
+};
+
+static const struct of_device_id qcom_idle_state_match[] __initconst = {
+	{ .compatible = "qcom,idle-state-wfi", .data = qcom_lpm_enter_wfi },
+	{ .compatible = "qcom,idle-state-spc", .data = qcom_lpm_enter_spc },
+	{ },
+};
+
+static int qcom_cpuidle_probe(struct platform_device *pdev)
+{
+	struct cpuidle_driver *drv = &qcom_cpuidle_driver;
+	int ret;
+
+	qcom_idle_enter = (void *)(pdev->dev.platform_data);
+	if (!qcom_idle_enter)
+		return -EFAULT;
+
+	 /* Probe for other states including platform WFI */
+	ret = dt_init_idle_driver(drv, qcom_idle_state_match, 0);
+	if (ret <= 0) {
+		pr_err("%s: No cpuidle state found.\n", __func__);
+		return ret;
+	}
+
+	ret = cpuidle_register(drv, NULL);
+	if (ret) {
+		pr_err("%s: failed to register cpuidle driver\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static struct platform_driver qcom_cpuidle_plat_driver = {
+	.probe	= qcom_cpuidle_probe,
+	.driver = {
+		.name = "qcom_cpuidle",
+		.owner = THIS_MODULE,
+	},
+};
+
+module_platform_driver(qcom_cpuidle_plat_driver);
-- 
1.9.1


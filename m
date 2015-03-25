From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 6/8] ARM: cpuidle: Enable the ARM64 driver for both ARM32/ARM64
Date: Wed, 25 Mar 2015 10:07:14 +0100
Message-ID: <1427274436-21916-6-git-send-email-daniel.lezcano@linaro.org>
References: <55127A53.8050206@linaro.org>
 <1427274436-21916-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427274436-21916-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, lina.iyer@linaro.org, Lorenzo.Pieralisi@arm.com
List-Id: linux-pm@vger.kernel.org

ARM32 and ARM64 have the same DT definitions and the same approaches.

The generic ARM cpuidle driver can be put in common for those two
architectures.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Kevin Hilman <khilman@linaro.org>
Acked-by: Rob Herring <robherring2@gmail.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/configs/defconfig    |   2 +-
 drivers/cpuidle/Kconfig         |   7 +--
 drivers/cpuidle/Kconfig.arm     |  28 ++++++---
 drivers/cpuidle/Kconfig.arm64   |  13 -----
 drivers/cpuidle/Makefile        |   5 +-
 drivers/cpuidle/cpuidle-arm.c   | 122 ++++++++++++++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle-arm64.c | 122 ----------------------------------------
 7 files changed, 144 insertions(+), 155 deletions(-)
 delete mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm.c
 delete mode 100644 drivers/cpuidle/cpuidle-arm64.c

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index be1f12a..af6a452 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -48,7 +48,7 @@ CONFIG_CMDLINE="console=ttyAMA0"
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_COMPAT=y
 CONFIG_CPU_IDLE=y
-CONFIG_ARM64_CPUIDLE=y
+CONFIG_ARM_CPUIDLE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index c5029c1..8c7930b 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -29,15 +29,10 @@ config DT_IDLE_STATES
 	bool
 
 menu "ARM CPU Idle Drivers"
-depends on ARM
+depends on ARM || ARM64
 source "drivers/cpuidle/Kconfig.arm"
 endmenu
 
-menu "ARM64 CPU Idle Drivers"
-depends on ARM64
-source "drivers/cpuidle/Kconfig.arm64"
-endmenu
-
 menu "MIPS CPU Idle Drivers"
 depends on MIPS
 source "drivers/cpuidle/Kconfig.mips"
diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e07c94..21340e0 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -1,10 +1,20 @@
 #
 # ARM CPU Idle drivers
 #
+config ARM_CPUIDLE
+        bool "Generic ARM/ARM64 CPU idle Driver"
+        select DT_IDLE_STATES
+        help
+          Select this to enable generic cpuidle driver for ARM.
+          It provides a generic idle driver whose idle states are configured
+          at run-time through DT nodes. The CPUidle suspend backend is
+          initialized by calling the CPU operations init idle hook
+          provided by architecture code.
+
 config ARM_BIG_LITTLE_CPUIDLE
 	bool "Support for ARM big.LITTLE processors"
 	depends on ARCH_VEXPRESS_TC2_PM || ARCH_EXYNOS
-	depends on MCPM
+	depends on MCPM && !ARM64
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	select DT_IDLE_STATES
@@ -16,51 +26,51 @@ config ARM_BIG_LITTLE_CPUIDLE
 
 config ARM_CLPS711X_CPUIDLE
 	bool "CPU Idle Driver for CLPS711X processors"
-	depends on ARCH_CLPS711X || COMPILE_TEST
+	depends on ARCH_CLPS711X && !ARM64 || COMPILE_TEST
 	help
 	  Select this to enable cpuidle on Cirrus Logic CLPS711X SOCs.
 
 config ARM_HIGHBANK_CPUIDLE
 	bool "CPU Idle Driver for Calxeda processors"
-	depends on ARM_PSCI
+	depends on ARM_PSCI && !ARM64
 	select ARM_CPU_SUSPEND
 	help
 	  Select this to enable cpuidle on Calxeda processors.
 
 config ARM_KIRKWOOD_CPUIDLE
 	bool "CPU Idle Driver for Marvell Kirkwood SoCs"
-	depends on MACH_KIRKWOOD
+	depends on MACH_KIRKWOOD && !ARM64
 	help
 	  This adds the CPU Idle driver for Marvell Kirkwood SoCs.
 
 config ARM_ZYNQ_CPUIDLE
 	bool "CPU Idle Driver for Xilinx Zynq processors"
-	depends on ARCH_ZYNQ
+	depends on ARCH_ZYNQ && !ARM64
 	help
 	  Select this to enable cpuidle on Xilinx Zynq processors.
 
 config ARM_U8500_CPUIDLE
 	bool "Cpu Idle Driver for the ST-E u8500 processors"
-	depends on ARCH_U8500
+	depends on ARCH_U8500 && !ARM64
 	help
 	  Select this to enable cpuidle for ST-E u8500 processors
 
 config ARM_AT91_CPUIDLE
 	bool "Cpu Idle Driver for the AT91 processors"
 	default y
-	depends on ARCH_AT91
+	depends on ARCH_AT91 && !ARM64
 	help
 	  Select this to enable cpuidle for AT91 processors
 
 config ARM_EXYNOS_CPUIDLE
 	bool "Cpu Idle Driver for the Exynos processors"
-	depends on ARCH_EXYNOS
+	depends on ARCH_EXYNOS && !ARM64
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	help
 	  Select this to enable cpuidle for Exynos processors
 
 config ARM_MVEBU_V7_CPUIDLE
 	bool "CPU Idle Driver for mvebu v7 family processors"
-	depends on ARCH_MVEBU
+	depends on ARCH_MVEBU && !ARM64
 	help
 	  Select this to enable cpuidle on Armada 370, 38x and XP processors.
diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
deleted file mode 100644
index 6effb36..0000000
--- a/drivers/cpuidle/Kconfig.arm64
+++ /dev/null
@@ -1,13 +0,0 @@
-#
-# ARM64 CPU Idle drivers
-#
-
-config ARM64_CPUIDLE
-	bool "Generic ARM64 CPU idle Driver"
-	select DT_IDLE_STATES
-	help
-	  Select this to enable generic cpuidle driver for ARM64.
-	  It provides a generic idle driver whose idle states are configured
-	  at run-time through DT nodes. The CPUidle suspend backend is
-	  initialized by calling the CPU operations init idle hook
-	  provided by architecture code.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 4d177b9..3ba81b1 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -17,16 +17,13 @@ obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 obj-$(CONFIG_ARM_EXYNOS_CPUIDLE)        += cpuidle-exynos.o
+obj-$(CONFIG_ARM_CPUIDLE)		+= cpuidle-arm.o
 
 ###############################################################################
 # MIPS drivers
 obj-$(CONFIG_MIPS_CPS_CPUIDLE)		+= cpuidle-cps.o
 
 ###############################################################################
-# ARM64 drivers
-obj-$(CONFIG_ARM64_CPUIDLE)		+= cpuidle-arm64.o
-
-###############################################################################
 # POWERPC drivers
 obj-$(CONFIG_PSERIES_CPUIDLE)		+= cpuidle-pseries.o
 obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
new file mode 100644
index 0000000..1c94b88
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-arm.c
@@ -0,0 +1,122 @@
+/*
+ * ARM/ARM64 generic CPU idle driver.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "CPUidle arm: " fmt
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/cpu_pm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <asm/cpuidle.h>
+
+#include "dt_idle_states.h"
+
+/*
+ * arm_enter_idle_state - Programs CPU to enter the specified state
+ *
+ * dev: cpuidle device
+ * drv: cpuidle driver
+ * idx: state index
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified target state selected by the governor.
+ */
+static int arm_enter_idle_state(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv, int idx)
+{
+	int ret;
+
+	if (!idx) {
+		cpu_do_idle();
+		return idx;
+	}
+
+	ret = cpu_pm_enter();
+	if (!ret) {
+		/*
+		 * Pass idle state index to cpu_suspend which in turn will
+		 * call the CPU ops suspend protocol with idle index as a
+		 * parameter.
+		 */
+		arm_cpuidle_suspend(idx);
+
+		cpu_pm_exit();
+	}
+
+	return ret ? -1 : idx;
+}
+
+static struct cpuidle_driver arm_idle_driver = {
+	.name = "arm_idle",
+	.owner = THIS_MODULE,
+	/*
+	 * State at index 0 is standby wfi and considered standard
+	 * on all ARM platforms. If in some platforms simple wfi
+	 * can't be used as "state 0", DT bindings must be implemented
+	 * to work around this issue and allow installing a special
+	 * handler for idle state index 0.
+	 */
+	.states[0] = {
+		.enter                  = arm_enter_idle_state,
+		.exit_latency           = 1,
+		.target_residency       = 1,
+		.power_usage		= UINT_MAX,
+		.name                   = "WFI",
+		.desc                   = "ARM WFI",
+	}
+};
+
+static const struct of_device_id arm_idle_state_match[] __initconst = {
+	{ .compatible = "arm,idle-state",
+	  .data = arm_enter_idle_state },
+	{ },
+};
+
+/*
+ * arm_idle_init
+ *
+ * Registers the arm specific cpuidle driver with the cpuidle
+ * framework. It relies on core code to parse the idle states
+ * and initialize them using driver data structures accordingly.
+ */
+static int __init arm_idle_init(void)
+{
+	int cpu, ret;
+	struct cpuidle_driver *drv = &arm_idle_driver;
+
+	/*
+	 * Initialize idle states data, starting at index 1.
+	 * This driver is DT only, if no DT idle states are detected (ret == 0)
+	 * let the driver initialization fail accordingly since there is no
+	 * reason to initialize the idle driver if only wfi is supported.
+	 */
+	ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
+	if (ret <= 0)
+		return ret ? : -ENODEV;
+
+	/*
+	 * Call arch CPU operations in order to initialize
+	 * idle states suspend back-end specific data
+	 */
+	for_each_possible_cpu(cpu) {
+		ret = arm_cpuidle_init(cpu);
+		if (ret) {
+			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
+			return ret;
+		}
+	}
+
+	return cpuidle_register(drv, NULL);
+}
+device_initcall(arm_idle_init);
diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
deleted file mode 100644
index 1c94b88..0000000
--- a/drivers/cpuidle/cpuidle-arm64.c
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- * ARM/ARM64 generic CPU idle driver.
- *
- * Copyright (C) 2014 ARM Ltd.
- * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#define pr_fmt(fmt) "CPUidle arm: " fmt
-
-#include <linux/cpuidle.h>
-#include <linux/cpumask.h>
-#include <linux/cpu_pm.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/of.h>
-
-#include <asm/cpuidle.h>
-
-#include "dt_idle_states.h"
-
-/*
- * arm_enter_idle_state - Programs CPU to enter the specified state
- *
- * dev: cpuidle device
- * drv: cpuidle driver
- * idx: state index
- *
- * Called from the CPUidle framework to program the device to the
- * specified target state selected by the governor.
- */
-static int arm_enter_idle_state(struct cpuidle_device *dev,
-				struct cpuidle_driver *drv, int idx)
-{
-	int ret;
-
-	if (!idx) {
-		cpu_do_idle();
-		return idx;
-	}
-
-	ret = cpu_pm_enter();
-	if (!ret) {
-		/*
-		 * Pass idle state index to cpu_suspend which in turn will
-		 * call the CPU ops suspend protocol with idle index as a
-		 * parameter.
-		 */
-		arm_cpuidle_suspend(idx);
-
-		cpu_pm_exit();
-	}
-
-	return ret ? -1 : idx;
-}
-
-static struct cpuidle_driver arm_idle_driver = {
-	.name = "arm_idle",
-	.owner = THIS_MODULE,
-	/*
-	 * State at index 0 is standby wfi and considered standard
-	 * on all ARM platforms. If in some platforms simple wfi
-	 * can't be used as "state 0", DT bindings must be implemented
-	 * to work around this issue and allow installing a special
-	 * handler for idle state index 0.
-	 */
-	.states[0] = {
-		.enter                  = arm_enter_idle_state,
-		.exit_latency           = 1,
-		.target_residency       = 1,
-		.power_usage		= UINT_MAX,
-		.name                   = "WFI",
-		.desc                   = "ARM WFI",
-	}
-};
-
-static const struct of_device_id arm_idle_state_match[] __initconst = {
-	{ .compatible = "arm,idle-state",
-	  .data = arm_enter_idle_state },
-	{ },
-};
-
-/*
- * arm_idle_init
- *
- * Registers the arm specific cpuidle driver with the cpuidle
- * framework. It relies on core code to parse the idle states
- * and initialize them using driver data structures accordingly.
- */
-static int __init arm_idle_init(void)
-{
-	int cpu, ret;
-	struct cpuidle_driver *drv = &arm_idle_driver;
-
-	/*
-	 * Initialize idle states data, starting at index 1.
-	 * This driver is DT only, if no DT idle states are detected (ret == 0)
-	 * let the driver initialization fail accordingly since there is no
-	 * reason to initialize the idle driver if only wfi is supported.
-	 */
-	ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
-	if (ret <= 0)
-		return ret ? : -ENODEV;
-
-	/*
-	 * Call arch CPU operations in order to initialize
-	 * idle states suspend back-end specific data
-	 */
-	for_each_possible_cpu(cpu) {
-		ret = arm_cpuidle_init(cpu);
-		if (ret) {
-			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
-			return ret;
-		}
-	}
-
-	return cpuidle_register(drv, NULL);
-}
-device_initcall(arm_idle_init);
-- 
1.9.1

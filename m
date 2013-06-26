From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 7/8] ARM: tegra: move cpuidle drivers to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:15:46 +0200
Message-ID: <1372241747-21083-8-git-send-email-b.zolnierkie@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:56402 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab3FZKRE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 06:17:04 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MOZ00AM5WKECC01@mailout3.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 26 Jun 2013 19:17:03 +0900 (KST)
In-reply-to: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

Compile tested only.

Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-tegra/Makefile           |   9 --
 arch/arm/mach-tegra/cpuidle-tegra114.c |  35 ------
 arch/arm/mach-tegra/cpuidle-tegra20.c  | 217 ---------------------------------
 arch/arm/mach-tegra/cpuidle-tegra30.c  | 149 ----------------------
 drivers/cpuidle/Makefile               |   9 ++
 drivers/cpuidle/cpuidle-tegra114.c     |  35 ++++++
 drivers/cpuidle/cpuidle-tegra20.c      | 217 +++++++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle-tegra30.c      | 149 ++++++++++++++++++++++
 8 files changed, 410 insertions(+), 410 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
 delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
 create mode 100644 drivers/cpuidle/cpuidle-tegra114.c
 create mode 100644 drivers/cpuidle/cpuidle-tegra20.c
 create mode 100644 drivers/cpuidle/cpuidle-tegra30.c

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 98b184e..7b33f82 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -17,23 +17,14 @@ obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra20_speedo.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= tegra2_emc.o
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= sleep-tegra20.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= cpuidle-tegra20.o
-endif
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= tegra30_speedo.o
 obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= sleep-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= cpuidle-tegra30.o
-endif
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)               += hotplug.o
 obj-$(CONFIG_TEGRA_PCI)			+= pcie.o
 
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= tegra114_speedo.o
 obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= sleep-tegra30.o
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= cpuidle-tegra114.o
-endif
 
 obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= board-harmony-pcie.o
 
diff --git a/arch/arm/mach-tegra/cpuidle-tegra114.c b/arch/arm/mach-tegra/cpuidle-tegra114.c
deleted file mode 100644
index 1d1c602..0000000
--- a/arch/arm/mach-tegra/cpuidle-tegra114.c
+++ /dev/null
@@ -1,35 +0,0 @@
-/*
- * Copyright (c) 2013, NVIDIA Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/cpuidle.h>
-
-#include <asm/cpuidle.h>
-
-static struct cpuidle_driver tegra_idle_driver = {
-	.name = "tegra_idle",
-	.owner = THIS_MODULE,
-	.state_count = 1,
-	.states = {
-		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
-	},
-};
-
-int __init tegra114_cpuidle_init(void)
-{
-	return cpuidle_register(&tegra_idle_driver, NULL);
-}
diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
deleted file mode 100644
index 706aa42..0000000
--- a/arch/arm/mach-tegra/cpuidle-tegra20.c
+++ /dev/null
@@ -1,217 +0,0 @@
-/*
- * CPU idle driver for Tegra CPUs
- *
- * Copyright (c) 2010-2012, NVIDIA Corporation.
- * Copyright (c) 2011 Google, Inc.
- * Author: Colin Cross <ccross@android.com>
- *         Gary King <gking@nvidia.com>
- *
- * Rework for 3.3 by Peter De Schrijver <pdeschrijver@nvidia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/cpuidle.h>
-#include <linux/cpu_pm.h>
-#include <linux/clockchips.h>
-#include <linux/clk/tegra.h>
-
-#include <asm/cpuidle.h>
-#include <asm/proc-fns.h>
-#include <asm/suspend.h>
-#include <asm/smp_plat.h>
-
-#include "pm.h"
-#include "sleep.h"
-#include "iomap.h"
-#include "irq.h"
-#include "flowctrl.h"
-
-#ifdef CONFIG_PM_SLEEP
-static bool abort_flag;
-static atomic_t abort_barrier;
-static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
-				    struct cpuidle_driver *drv,
-				    int index);
-#define TEGRA20_MAX_STATES 2
-#else
-#define TEGRA20_MAX_STATES 1
-#endif
-
-static struct cpuidle_driver tegra_idle_driver = {
-	.name = "tegra_idle",
-	.owner = THIS_MODULE,
-	.states = {
-		ARM_CPUIDLE_WFI_STATE_PWR(600),
-#ifdef CONFIG_PM_SLEEP
-		{
-			.enter            = tegra20_idle_lp2_coupled,
-			.exit_latency     = 5000,
-			.target_residency = 10000,
-			.power_usage      = 0,
-			.flags            = CPUIDLE_FLAG_TIME_VALID |
-			CPUIDLE_FLAG_COUPLED,
-			.name             = "powered-down",
-			.desc             = "CPU power gated",
-		},
-#endif
-	},
-	.state_count = TEGRA20_MAX_STATES,
-	.safe_state_index = 0,
-};
-
-#ifdef CONFIG_PM_SLEEP
-#ifdef CONFIG_SMP
-static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
-
-static int tegra20_reset_sleeping_cpu_1(void)
-{
-	int ret = 0;
-
-	tegra_pen_lock();
-
-	if (readl(pmc + PMC_SCRATCH41) == CPU_RESETTABLE)
-		tegra20_cpu_shutdown(1);
-	else
-		ret = -EINVAL;
-
-	tegra_pen_unlock();
-
-	return ret;
-}
-
-static void tegra20_wake_cpu1_from_reset(void)
-{
-	tegra_pen_lock();
-
-	tegra20_cpu_clear_resettable();
-
-	/* enable cpu clock on cpu */
-	tegra_enable_cpu_clock(1);
-
-	/* take the CPU out of reset */
-	tegra_cpu_out_of_reset(1);
-
-	/* unhalt the cpu */
-	flowctrl_write_cpu_halt(1, 0);
-
-	tegra_pen_unlock();
-}
-
-static int tegra20_reset_cpu_1(void)
-{
-	if (!cpu_online(1) || !tegra20_reset_sleeping_cpu_1())
-		return 0;
-
-	tegra20_wake_cpu1_from_reset();
-	return -EBUSY;
-}
-#else
-static inline void tegra20_wake_cpu1_from_reset(void)
-{
-}
-
-static inline int tegra20_reset_cpu_1(void)
-{
-	return 0;
-}
-#endif
-
-static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
-					   struct cpuidle_driver *drv,
-					   int index)
-{
-	while (tegra20_cpu_is_resettable_soon())
-		cpu_relax();
-
-	if (tegra20_reset_cpu_1() || !tegra_cpu_rail_off_ready())
-		return false;
-
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
-
-	tegra_idle_lp2_last();
-
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
-
-	if (cpu_online(1))
-		tegra20_wake_cpu1_from_reset();
-
-	return true;
-}
-
-#ifdef CONFIG_SMP
-static bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
-					 struct cpuidle_driver *drv,
-					 int index)
-{
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
-
-	cpu_suspend(0, tegra20_sleep_cpu_secondary_finish);
-
-	tegra20_cpu_clear_resettable();
-
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
-
-	return true;
-}
-#else
-static inline bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
-						struct cpuidle_driver *drv,
-						int index)
-{
-	return true;
-}
-#endif
-
-static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
-				    struct cpuidle_driver *drv,
-				    int index)
-{
-	bool entered_lp2 = false;
-
-	if (tegra_pending_sgi())
-		ACCESS_ONCE(abort_flag) = true;
-
-	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
-
-	if (abort_flag) {
-		cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
-		abort_flag = false;	/* clean flag for next coming */
-		return -EINTR;
-	}
-
-	local_fiq_disable();
-
-	tegra_set_cpu_in_lp2();
-	cpu_pm_enter();
-
-	if (dev->cpu == 0)
-		entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv, index);
-	else
-		entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
-
-	cpu_pm_exit();
-	tegra_clear_cpu_in_lp2();
-
-	local_fiq_enable();
-
-	smp_rmb();
-
-	return entered_lp2 ? index : 0;
-}
-#endif
-
-int __init tegra20_cpuidle_init(void)
-{
-	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
-}
diff --git a/arch/arm/mach-tegra/cpuidle-tegra30.c b/arch/arm/mach-tegra/cpuidle-tegra30.c
deleted file mode 100644
index ed2a2a7..0000000
--- a/arch/arm/mach-tegra/cpuidle-tegra30.c
+++ /dev/null
@@ -1,149 +0,0 @@
-/*
- * CPU idle driver for Tegra CPUs
- *
- * Copyright (c) 2010-2012, NVIDIA Corporation.
- * Copyright (c) 2011 Google, Inc.
- * Author: Colin Cross <ccross@android.com>
- *         Gary King <gking@nvidia.com>
- *
- * Rework for 3.3 by Peter De Schrijver <pdeschrijver@nvidia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/cpuidle.h>
-#include <linux/cpu_pm.h>
-#include <linux/clockchips.h>
-#include <linux/clk/tegra.h>
-
-#include <asm/cpuidle.h>
-#include <asm/proc-fns.h>
-#include <asm/suspend.h>
-#include <asm/smp_plat.h>
-
-#include "pm.h"
-#include "sleep.h"
-
-#ifdef CONFIG_PM_SLEEP
-static int tegra30_idle_lp2(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv,
-			    int index);
-#endif
-
-static struct cpuidle_driver tegra_idle_driver = {
-	.name = "tegra_idle",
-	.owner = THIS_MODULE,
-#ifdef CONFIG_PM_SLEEP
-	.state_count = 2,
-#else
-	.state_count = 1,
-#endif
-	.states = {
-		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
-#ifdef CONFIG_PM_SLEEP
-		[1] = {
-			.enter			= tegra30_idle_lp2,
-			.exit_latency		= 2000,
-			.target_residency	= 2200,
-			.power_usage		= 0,
-			.flags			= CPUIDLE_FLAG_TIME_VALID,
-			.name			= "powered-down",
-			.desc			= "CPU power gated",
-		},
-#endif
-	},
-};
-
-#ifdef CONFIG_PM_SLEEP
-static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
-					   struct cpuidle_driver *drv,
-					   int index)
-{
-	/* All CPUs entering LP2 is not working.
-	 * Don't let CPU0 enter LP2 when any secondary CPU is online.
-	 */
-	if (num_online_cpus() > 1 || !tegra_cpu_rail_off_ready()) {
-		cpu_do_idle();
-		return false;
-	}
-
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
-
-	tegra_idle_lp2_last();
-
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
-
-	return true;
-}
-
-#ifdef CONFIG_SMP
-static bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
-					struct cpuidle_driver *drv,
-					int index)
-{
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
-
-	smp_wmb();
-
-	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
-
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
-
-	return true;
-}
-#else
-static inline bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
-					       struct cpuidle_driver *drv,
-					       int index)
-{
-	return true;
-}
-#endif
-
-static int tegra30_idle_lp2(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv,
-			    int index)
-{
-	bool entered_lp2 = false;
-	bool last_cpu;
-
-	local_fiq_disable();
-
-	last_cpu = tegra_set_cpu_in_lp2();
-	cpu_pm_enter();
-
-	if (dev->cpu == 0) {
-		if (last_cpu)
-			entered_lp2 = tegra30_cpu_cluster_power_down(dev, drv,
-								     index);
-		else
-			cpu_do_idle();
-	} else {
-		entered_lp2 = tegra30_cpu_core_power_down(dev, drv, index);
-	}
-
-	cpu_pm_exit();
-	tegra_clear_cpu_in_lp2();
-
-	local_fiq_enable();
-
-	smp_rmb();
-
-	return (entered_lp2) ? index : 0;
-}
-#endif
-
-int __init tegra30_cpuidle_init(void)
-{
-	return cpuidle_register(&tegra_idle_driver, NULL);
-}
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 758d0d9..953771f 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -37,4 +37,13 @@ endif
 ifeq ($(CONFIG_ARCH_SHMOBILE),y)
 	obj-y += cpuidle-shmobile.o
 endif
+ifeq ($(CONFIG_ARCH_TEGRA_2x_SOC),y)
+	obj-y += cpuidle-tegra20.o
+endif
+ifeq ($(CONFIG_ARCH_TEGRA_3x_SOC),y)
+	obj-y += cpuidle-tegra30.o
+endif
+ifeq ($(CONFIG_ARCH_TEGRA_114_SOC),y)
+	obj-y += cpuidle-tegra114.o
+endif
 obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
diff --git a/drivers/cpuidle/cpuidle-tegra114.c b/drivers/cpuidle/cpuidle-tegra114.c
new file mode 100644
index 0000000..1d1c602
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-tegra114.c
@@ -0,0 +1,35 @@
+/*
+ * Copyright (c) 2013, NVIDIA Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/cpuidle.h>
+
+#include <asm/cpuidle.h>
+
+static struct cpuidle_driver tegra_idle_driver = {
+	.name = "tegra_idle",
+	.owner = THIS_MODULE,
+	.state_count = 1,
+	.states = {
+		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
+	},
+};
+
+int __init tegra114_cpuidle_init(void)
+{
+	return cpuidle_register(&tegra_idle_driver, NULL);
+}
diff --git a/drivers/cpuidle/cpuidle-tegra20.c b/drivers/cpuidle/cpuidle-tegra20.c
new file mode 100644
index 0000000..21a749c
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-tegra20.c
@@ -0,0 +1,217 @@
+/*
+ * CPU idle driver for Tegra CPUs
+ *
+ * Copyright (c) 2010-2012, NVIDIA Corporation.
+ * Copyright (c) 2011 Google, Inc.
+ * Author: Colin Cross <ccross@android.com>
+ *         Gary King <gking@nvidia.com>
+ *
+ * Rework for 3.3 by Peter De Schrijver <pdeschrijver@nvidia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/clockchips.h>
+#include <linux/clk/tegra.h>
+
+#include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
+#include <asm/smp_plat.h>
+
+#include "../../arch/arm/mach-tegra/pm.h"
+#include "../../arch/arm/mach-tegra/sleep.h"
+#include "../../arch/arm/mach-tegra/iomap.h"
+#include "../../arch/arm/mach-tegra/irq.h"
+#include "../../arch/arm/mach-tegra/flowctrl.h"
+
+#ifdef CONFIG_PM_SLEEP
+static bool abort_flag;
+static atomic_t abort_barrier;
+static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
+				    struct cpuidle_driver *drv,
+				    int index);
+#define TEGRA20_MAX_STATES 2
+#else
+#define TEGRA20_MAX_STATES 1
+#endif
+
+static struct cpuidle_driver tegra_idle_driver = {
+	.name = "tegra_idle",
+	.owner = THIS_MODULE,
+	.states = {
+		ARM_CPUIDLE_WFI_STATE_PWR(600),
+#ifdef CONFIG_PM_SLEEP
+		{
+			.enter            = tegra20_idle_lp2_coupled,
+			.exit_latency     = 5000,
+			.target_residency = 10000,
+			.power_usage      = 0,
+			.flags            = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_COUPLED,
+			.name             = "powered-down",
+			.desc             = "CPU power gated",
+		},
+#endif
+	},
+	.state_count = TEGRA20_MAX_STATES,
+	.safe_state_index = 0,
+};
+
+#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_SMP
+static void __iomem *pmc = IO_ADDRESS(TEGRA_PMC_BASE);
+
+static int tegra20_reset_sleeping_cpu_1(void)
+{
+	int ret = 0;
+
+	tegra_pen_lock();
+
+	if (readl(pmc + PMC_SCRATCH41) == CPU_RESETTABLE)
+		tegra20_cpu_shutdown(1);
+	else
+		ret = -EINVAL;
+
+	tegra_pen_unlock();
+
+	return ret;
+}
+
+static void tegra20_wake_cpu1_from_reset(void)
+{
+	tegra_pen_lock();
+
+	tegra20_cpu_clear_resettable();
+
+	/* enable cpu clock on cpu */
+	tegra_enable_cpu_clock(1);
+
+	/* take the CPU out of reset */
+	tegra_cpu_out_of_reset(1);
+
+	/* unhalt the cpu */
+	flowctrl_write_cpu_halt(1, 0);
+
+	tegra_pen_unlock();
+}
+
+static int tegra20_reset_cpu_1(void)
+{
+	if (!cpu_online(1) || !tegra20_reset_sleeping_cpu_1())
+		return 0;
+
+	tegra20_wake_cpu1_from_reset();
+	return -EBUSY;
+}
+#else
+static inline void tegra20_wake_cpu1_from_reset(void)
+{
+}
+
+static inline int tegra20_reset_cpu_1(void)
+{
+	return 0;
+}
+#endif
+
+static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
+					   struct cpuidle_driver *drv,
+					   int index)
+{
+	while (tegra20_cpu_is_resettable_soon())
+		cpu_relax();
+
+	if (tegra20_reset_cpu_1() || !tegra_cpu_rail_off_ready())
+		return false;
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+
+	tegra_idle_lp2_last();
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+
+	if (cpu_online(1))
+		tegra20_wake_cpu1_from_reset();
+
+	return true;
+}
+
+#ifdef CONFIG_SMP
+static bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
+					 struct cpuidle_driver *drv,
+					 int index)
+{
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+
+	cpu_suspend(0, tegra20_sleep_cpu_secondary_finish);
+
+	tegra20_cpu_clear_resettable();
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+
+	return true;
+}
+#else
+static inline bool tegra20_idle_enter_lp2_cpu_1(struct cpuidle_device *dev,
+						struct cpuidle_driver *drv,
+						int index)
+{
+	return true;
+}
+#endif
+
+static int tegra20_idle_lp2_coupled(struct cpuidle_device *dev,
+				    struct cpuidle_driver *drv,
+				    int index)
+{
+	bool entered_lp2 = false;
+
+	if (tegra_pending_sgi())
+		ACCESS_ONCE(abort_flag) = true;
+
+	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
+
+	if (abort_flag) {
+		cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
+		abort_flag = false;	/* clean flag for next coming */
+		return -EINTR;
+	}
+
+	local_fiq_disable();
+
+	tegra_set_cpu_in_lp2();
+	cpu_pm_enter();
+
+	if (dev->cpu == 0)
+		entered_lp2 = tegra20_cpu_cluster_power_down(dev, drv, index);
+	else
+		entered_lp2 = tegra20_idle_enter_lp2_cpu_1(dev, drv, index);
+
+	cpu_pm_exit();
+	tegra_clear_cpu_in_lp2();
+
+	local_fiq_enable();
+
+	smp_rmb();
+
+	return entered_lp2 ? index : 0;
+}
+#endif
+
+int __init tegra20_cpuidle_init(void)
+{
+	return cpuidle_register(&tegra_idle_driver, cpu_possible_mask);
+}
diff --git a/drivers/cpuidle/cpuidle-tegra30.c b/drivers/cpuidle/cpuidle-tegra30.c
new file mode 100644
index 0000000..40080ab
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-tegra30.c
@@ -0,0 +1,149 @@
+/*
+ * CPU idle driver for Tegra CPUs
+ *
+ * Copyright (c) 2010-2012, NVIDIA Corporation.
+ * Copyright (c) 2011 Google, Inc.
+ * Author: Colin Cross <ccross@android.com>
+ *         Gary King <gking@nvidia.com>
+ *
+ * Rework for 3.3 by Peter De Schrijver <pdeschrijver@nvidia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/clockchips.h>
+#include <linux/clk/tegra.h>
+
+#include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
+#include <asm/suspend.h>
+#include <asm/smp_plat.h>
+
+#include "../../arch/arm/mach-tegra/pm.h"
+#include "../../arch/arm/mach-tegra/sleep.h"
+
+#ifdef CONFIG_PM_SLEEP
+static int tegra30_idle_lp2(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv,
+			    int index);
+#endif
+
+static struct cpuidle_driver tegra_idle_driver = {
+	.name = "tegra_idle",
+	.owner = THIS_MODULE,
+#ifdef CONFIG_PM_SLEEP
+	.state_count = 2,
+#else
+	.state_count = 1,
+#endif
+	.states = {
+		[0] = ARM_CPUIDLE_WFI_STATE_PWR(600),
+#ifdef CONFIG_PM_SLEEP
+		[1] = {
+			.enter			= tegra30_idle_lp2,
+			.exit_latency		= 2000,
+			.target_residency	= 2200,
+			.power_usage		= 0,
+			.flags			= CPUIDLE_FLAG_TIME_VALID,
+			.name			= "powered-down",
+			.desc			= "CPU power gated",
+		},
+#endif
+	},
+};
+
+#ifdef CONFIG_PM_SLEEP
+static bool tegra30_cpu_cluster_power_down(struct cpuidle_device *dev,
+					   struct cpuidle_driver *drv,
+					   int index)
+{
+	/* All CPUs entering LP2 is not working.
+	 * Don't let CPU0 enter LP2 when any secondary CPU is online.
+	 */
+	if (num_online_cpus() > 1 || !tegra_cpu_rail_off_ready()) {
+		cpu_do_idle();
+		return false;
+	}
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+
+	tegra_idle_lp2_last();
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+
+	return true;
+}
+
+#ifdef CONFIG_SMP
+static bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
+					struct cpuidle_driver *drv,
+					int index)
+{
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &dev->cpu);
+
+	smp_wmb();
+
+	cpu_suspend(0, tegra30_sleep_cpu_secondary_finish);
+
+	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &dev->cpu);
+
+	return true;
+}
+#else
+static inline bool tegra30_cpu_core_power_down(struct cpuidle_device *dev,
+					       struct cpuidle_driver *drv,
+					       int index)
+{
+	return true;
+}
+#endif
+
+static int tegra30_idle_lp2(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv,
+			    int index)
+{
+	bool entered_lp2 = false;
+	bool last_cpu;
+
+	local_fiq_disable();
+
+	last_cpu = tegra_set_cpu_in_lp2();
+	cpu_pm_enter();
+
+	if (dev->cpu == 0) {
+		if (last_cpu)
+			entered_lp2 = tegra30_cpu_cluster_power_down(dev, drv,
+								     index);
+		else
+			cpu_do_idle();
+	} else {
+		entered_lp2 = tegra30_cpu_core_power_down(dev, drv, index);
+	}
+
+	cpu_pm_exit();
+	tegra_clear_cpu_in_lp2();
+
+	local_fiq_enable();
+
+	smp_rmb();
+
+	return (entered_lp2) ? index : 0;
+}
+#endif
+
+int __init tegra30_cpuidle_init(void)
+{
+	return cpuidle_register(&tegra_idle_driver, NULL);
+}
-- 
1.8.2.3


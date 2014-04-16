From: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 38/39] cpuidle: cpuidle-cps: add MIPS CPS cpuidle driver
Date: Wed, 16 Apr 2014 14:06:47 +0100
Message-ID: <1397653607-4978-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.89.28.114]:59274 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754441AbaDPNG4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 09:06:56 -0400
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-mips@linux-mips.org
Cc: Paul Burton <paul.burton@imgtec.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org

This patch adds a cpuidle driver for systems based around the MIPS
Coherent Processing System (CPS) architecture. It supports four idle
states:

  - The standard MIPS wait instruction.

  - The non-coherent wait, clock gated & power gated states exposed by
    the recently added pm-cps layer.

The pm-cps layer is used to enter all the deep idle states. Since cores
in the clock or power gated states cannot service interrupts, the
gic_send_ipi_single function is modified to send a power up command for
the appropriate core to the CPC in cases where the target CPU has marked
itself potentially incoherent.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 arch/mips/kernel/smp-gic.c    |  11 +++
 drivers/cpuidle/Kconfig       |   5 ++
 drivers/cpuidle/Kconfig.mips  |  17 ++++
 drivers/cpuidle/Makefile      |   4 +
 drivers/cpuidle/cpuidle-cps.c | 186 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 223 insertions(+)
 create mode 100644 drivers/cpuidle/Kconfig.mips
 create mode 100644 drivers/cpuidle/cpuidle-cps.c

diff --git a/arch/mips/kernel/smp-gic.c b/arch/mips/kernel/smp-gic.c
index 3bb1f92..3b21a96 100644
--- a/arch/mips/kernel/smp-gic.c
+++ b/arch/mips/kernel/smp-gic.c
@@ -15,12 +15,14 @@
 #include <linux/printk.h>
 
 #include <asm/gic.h>
+#include <asm/mips-cpc.h>
 #include <asm/smp-ops.h>
 
 void gic_send_ipi_single(int cpu, unsigned int action)
 {
 	unsigned long flags;
 	unsigned int intr;
+	unsigned int core = cpu_data[cpu].core;
 
 	pr_debug("CPU%d: %s cpu %d action %u status %08x\n",
 		 smp_processor_id(), __func__, cpu, action, read_c0_status());
@@ -41,6 +43,15 @@ void gic_send_ipi_single(int cpu, unsigned int action)
 	}
 
 	gic_send_ipi(intr);
+
+	if (mips_cpc_present() && (core != current_cpu_data.core)) {
+		while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
+			mips_cpc_lock_other(core);
+			write_cpc_co_cmd(CPC_Cx_CMD_PWRUP);
+			mips_cpc_unlock_other();
+		}
+	}
+
 	local_irq_restore(flags);
 }
 
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index f04e25f..1b96fb9 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -35,6 +35,11 @@ depends on ARM
 source "drivers/cpuidle/Kconfig.arm"
 endmenu
 
+menu "MIPS CPU Idle Drivers"
+depends on MIPS
+source "drivers/cpuidle/Kconfig.mips"
+endmenu
+
 menu "POWERPC CPU Idle Drivers"
 depends on PPC
 source "drivers/cpuidle/Kconfig.powerpc"
diff --git a/drivers/cpuidle/Kconfig.mips b/drivers/cpuidle/Kconfig.mips
new file mode 100644
index 0000000..0e70ee2
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.mips
@@ -0,0 +1,17 @@
+#
+# MIPS CPU Idle Drivers
+#
+config MIPS_CPS_CPUIDLE
+	bool "CPU Idle driver for MIPS CPS platforms"
+	depends on CPU_IDLE
+	depends on SYS_SUPPORTS_MIPS_CPS
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if MIPS_MT
+	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select MIPS_CPS_PM
+	default y
+	help
+	  Select this option to enable processor idle state management
+	  through cpuidle for systems built around the MIPS Coherent
+	  Processing System (CPS) architecture. In order to make use of
+	  the deepest idle states you will need to ensure that you are
+	  also using the CONFIG_MIPS_CPS SMP implementation.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index f71ae1b..a7fc96b 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -15,6 +15,10 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         += cpuidle-ux500.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          += cpuidle-at91.o
 
 ###############################################################################
+# MIPS drivers
+obj-$(CONFIG_MIPS_CPS_CPUIDLE)		+= cpuidle-cps.o
+
+###############################################################################
 # POWERPC drivers
 obj-$(CONFIG_PSERIES_CPUIDLE)		+= cpuidle-pseries.o
 obj-$(CONFIG_POWERNV_CPUIDLE)		+= cpuidle-powernv.o
diff --git a/drivers/cpuidle/cpuidle-cps.c b/drivers/cpuidle/cpuidle-cps.c
new file mode 100644
index 0000000..fc7b627
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-cps.c
@@ -0,0 +1,186 @@
+/*
+ * Copyright (C) 2014 Imagination Technologies
+ * Author: Paul Burton <paul.burton@imgtec.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/cpu_pm.h>
+#include <linux/cpuidle.h>
+#include <linux/init.h>
+
+#include <asm/idle.h>
+#include <asm/pm-cps.h>
+
+/* Enumeration of the various idle states this driver may enter */
+enum cps_idle_state {
+	STATE_WAIT = 0,		/* MIPS wait instruction, coherent */
+	STATE_NC_WAIT,		/* MIPS wait instruction, non-coherent */
+	STATE_CLOCK_GATED,	/* Core clock gated */
+	STATE_POWER_GATED,	/* Core power gated */
+	STATE_COUNT
+};
+
+static int cps_nc_enter(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv, int index)
+{
+	enum cps_pm_state pm_state;
+	int err;
+
+	/*
+	 * At least one core must remain powered up & clocked in order for the
+	 * system to have any hope of functioning.
+	 *
+	 * TODO: don't treat core 0 specially, just prevent the final core
+	 * TODO: remap interrupt affinity temporarily
+	 */
+	if (!cpu_data[dev->cpu].core && (index > STATE_NC_WAIT))
+		index = STATE_NC_WAIT;
+
+	/* Select the appropriate cps_pm_state */
+	switch (index) {
+	case STATE_NC_WAIT:
+		pm_state = CPS_PM_NC_WAIT;
+		break;
+	case STATE_CLOCK_GATED:
+		pm_state = CPS_PM_CLOCK_GATED;
+		break;
+	case STATE_POWER_GATED:
+		pm_state = CPS_PM_POWER_GATED;
+		break;
+	default:
+		BUG();
+		return -EINVAL;
+	}
+
+	/* Notify listeners the CPU is about to power down */
+	if ((pm_state == CPS_PM_POWER_GATED) && cpu_pm_enter())
+		return -EINTR;
+
+	/* Enter that state */
+	err = cps_pm_enter_state(pm_state);
+
+	/* Notify listeners the CPU is back up */
+	if (pm_state == CPS_PM_POWER_GATED)
+		cpu_pm_exit();
+
+	return err ?: index;
+}
+
+static struct cpuidle_driver cps_driver = {
+	.name			= "cpc_cpuidle",
+	.owner			= THIS_MODULE,
+	.states = {
+		[STATE_WAIT] = MIPS_CPUIDLE_WAIT_STATE,
+		[STATE_NC_WAIT] = {
+			.enter	= cps_nc_enter,
+			.exit_latency		= 200,
+			.target_residency	= 450,
+			.flags	= CPUIDLE_FLAG_TIME_VALID,
+			.name	= "nc-wait",
+			.desc	= "non-coherent MIPS wait",
+		},
+		[STATE_CLOCK_GATED] = {
+			.enter	= cps_nc_enter,
+			.exit_latency		= 300,
+			.target_residency	= 700,
+			.flags	= CPUIDLE_FLAG_TIME_VALID |
+				  CPUIDLE_FLAG_TIMER_STOP,
+			.name	= "clock-gated",
+			.desc	= "core clock gated",
+		},
+		[STATE_POWER_GATED] = {
+			.enter	= cps_nc_enter,
+			.exit_latency		= 600,
+			.target_residency	= 1000,
+			.flags	= CPUIDLE_FLAG_TIME_VALID |
+				  CPUIDLE_FLAG_TIMER_STOP,
+			.name	= "power-gated",
+			.desc	= "core power gated",
+		},
+	},
+	.state_count		= STATE_COUNT,
+	.safe_state_index	= 0,
+};
+
+static void __init cps_cpuidle_unregister(void)
+{
+	int cpu;
+	struct cpuidle_device *device;
+
+	for_each_possible_cpu(cpu) {
+		device = &per_cpu(cpuidle_dev, cpu);
+		cpuidle_unregister_device(device);
+	}
+
+	cpuidle_unregister_driver(&cps_driver);
+}
+
+static int __init cps_cpuidle_init(void)
+{
+	int err, cpu, core, i;
+	struct cpuidle_device *device;
+
+	/* Detect supported states */
+	if (!cps_pm_support_state(CPS_PM_POWER_GATED))
+		cps_driver.state_count = STATE_CLOCK_GATED + 1;
+	if (!cps_pm_support_state(CPS_PM_CLOCK_GATED))
+		cps_driver.state_count = STATE_NC_WAIT + 1;
+	if (!cps_pm_support_state(CPS_PM_NC_WAIT))
+		cps_driver.state_count = STATE_WAIT + 1;
+
+	/* Inform the user if some states are unavailable */
+	if (cps_driver.state_count < STATE_COUNT) {
+		pr_info("cpuidle-cps: limited to ");
+		switch (cps_driver.state_count - 1) {
+		case STATE_WAIT:
+			pr_cont("coherent wait\n");
+			break;
+		case STATE_NC_WAIT:
+			pr_cont("non-coherent wait\n");
+			break;
+		case STATE_CLOCK_GATED:
+			pr_cont("clock gating\n");
+			break;
+		}
+	}
+
+	/*
+	 * Set the coupled flag on the appropriate states if this system
+	 * requires it.
+	 */
+	if (coupled_coherence)
+		for (i = STATE_NC_WAIT; i < cps_driver.state_count; i++)
+			cps_driver.states[i].flags |= CPUIDLE_FLAG_COUPLED;
+
+	err = cpuidle_register_driver(&cps_driver);
+	if (err) {
+		pr_err("Failed to register CPS cpuidle driver\n");
+		return err;
+	}
+
+	for_each_possible_cpu(cpu) {
+		core = cpu_data[cpu].core;
+		device = &per_cpu(cpuidle_dev, cpu);
+		device->cpu = cpu;
+#ifdef CONFIG_MIPS_MT
+		cpumask_copy(&device->coupled_cpus, &cpu_sibling_map[cpu]);
+#endif
+
+		err = cpuidle_register_device(device);
+		if (err) {
+			pr_err("Failed to register CPU%d cpuidle device\n",
+			       cpu);
+			goto err_out;
+		}
+	}
+
+	return 0;
+err_out:
+	cps_cpuidle_unregister();
+	return err;
+}
+device_initcall(cps_cpuidle_init);
-- 
1.8.5.3


From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH v2 11/12] cpuidle: mvebu: Add initial CPU idle support for Armada 370/XP SoC
Date: Fri, 13 Sep 2013 12:06:40 +0200
Message-ID: <1379066801-16276-12-git-send-email-gregory.clement@free-electrons.com>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:44255 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755544Ab3IMKHC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 06:07:02 -0400
In-Reply-To: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Lior Amsalem <alior@marvell.com>, Maen Suleiman <maen@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Shadi Ammouri <shadi@marvell.com>, Eran Ben-Avi <benavi@marvell.com>, Yehuda Yitschak <yehuday@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ike Pan <ike.pan@canonical.com>, Chris Van Hoof <vanhoof@canonical.com>, Dan Frazier <dann.frazier@canonical.com>, Leif Lindholm <leif.lindholm@arm.com>, Jon Masters <jcm@redhat.com>, David Marlin <dmarlin@redhat.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Atsushi Yamagata <yamagata@plathome.co.jp>, Hironobu Shibata <h-shibata@plathome.co.jp>, Tomonori Kimura <kimura@plathome.co.jp>

Add the wfi, cpu idle and cpu deep idle power states support for the
Armada XP SoCs.

All the latencies and the power consumption values used at the
"armada_370_xp_idle_driver" structure are preliminary and will be
modified in the future after running some measurements and analysis.

Based on the work of Nadav Haklai.

Signed-off-by: Nadav Haklai <nadavh@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/cpuidle/Kconfig.arm             |   5 ++
 drivers/cpuidle/Makefile                |   1 +
 drivers/cpuidle/cpuidle-armada-370-xp.c | 103 ++++++++++++++++++++++++++++++++
 drivers/cpuidle/suspend-armada-370-xp.S |  91 ++++++++++++++++++++++++++++
 4 files changed, 200 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-armada-370-xp.c
 create mode 100644 drivers/cpuidle/suspend-armada-370-xp.S

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e36603..071d960 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -1,6 +1,11 @@
 #
 # ARM CPU Idle drivers
 #
+config ARM_ARMADA_370_XP_CPUIDLE
+	bool "CPU Idle Driver for Armada 370/XP family processors"
+	depends on ARCH_MVEBU
+	help
+	  Select this to enable cpuidle on Armada 370/XP processors.
 
 config ARM_HIGHBANK_CPUIDLE
 	bool "CPU Idle Driver for Calxeda processors"
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index cea5ef5..90fc4a6 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) += coupled.o
 
 ##################################################################################
 # ARM SoC drivers
+obj-$(CONFIG_ARM_ARMADA_370_XP_CPUIDLE) += cpuidle-armada-370-xp.o suspend-armada-370-xp.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)	+= cpuidle-calxeda.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)	+= cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)		+= cpuidle-zynq.o
diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidle/cpuidle-armada-370-xp.c
new file mode 100644
index 0000000..7c78d92
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-armada-370-xp.c
@@ -0,0 +1,103 @@
+/*
+ * Marvell Armada 370 and Armada XP SoC cpuidle driver
+ *
+ * Copyright (C) 2013 Marvell
+ *
+ * Nadav Haklai <nadavh@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * Maintainer: Gregory CLEMENT <gregory.clement@free-electrons.com>
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/suspend.h>
+#include <asm/suspend.h>
+#include <linux/smp.h>
+#include <asm/cpuidle.h>
+#include <asm/smp_plat.h>
+#include <linux/armada-370-xp-pmsu.h>
+
+#define ARMADA_370_XP_MAX_STATES	3
+
+enum mv_pm_states {
+	WFI = 0,
+	MV_CPU_IDLE,
+	MV_CPU_DEEP_IDLE,
+};
+
+extern void v7_flush_dcache_all(void);
+
+/* Functions defined in suspend-armada-370-xp.S */
+int armada_370_xp_cpu_resume(unsigned long);
+int armada_370_xp_cpu_suspend(unsigned long);
+
+static int armada_370_xp_enter_idle(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	bool deepidle = false;
+	unsigned int hw_cpu = cpu_logical_map(smp_processor_id());
+
+	armada_370_xp_pmsu_set_start_addr(armada_370_xp_cpu_resume, hw_cpu);
+
+	if (index == MV_CPU_DEEP_IDLE)
+		deepidle = true;
+
+	cpu_suspend(deepidle, armada_370_xp_cpu_suspend);
+
+	cpu_init();
+
+	armada_370_xp_pmsu_idle_restore();
+
+	return index;
+}
+
+static struct cpuidle_driver armada_370_xp_idle_driver = {
+	.name			= "armada_370_xp_idle",
+	.states[0]		= ARM_CPUIDLE_WFI_STATE,
+	.states[1]		= {
+		.enter			= armada_370_xp_enter_idle,
+		.exit_latency		= 10,
+		.power_usage		= 50,
+		.target_residency	= 100,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "MV CPU IDLE",
+		.desc			= "CPU power down",
+	},
+	.states[2]		= {
+		.enter			= armada_370_xp_enter_idle,
+		.exit_latency		= 100,
+		.power_usage		= 5,
+		.target_residency	= 1000,
+		.flags			= CPUIDLE_FLAG_TIME_VALID,
+		.name			= "MV CPU DEEP IDLE",
+		.desc			= "CPU and L2 Fabric power down",
+	},
+	.state_count = ARMADA_370_XP_MAX_STATES,
+};
+
+static int __init armada_370_xp_cpuidle_init(void)
+{
+	if (!of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu"))
+		return -ENODEV;
+
+	if (!of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
+		return -ENODEV;
+
+	pr_info("Initializing Armada-XP CPU power management ");
+
+	armada_370_xp_pmsu_enable_l2_powerdown_onidle();
+
+	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
+}
+
+module_init(armada_370_xp_cpuidle_init);
+
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpuidle/suspend-armada-370-xp.S b/drivers/cpuidle/suspend-armada-370-xp.S
new file mode 100644
index 0000000..490bb9b
--- /dev/null
+++ b/drivers/cpuidle/suspend-armada-370-xp.S
@@ -0,0 +1,91 @@
+/*
+ * CPU idle low level implementation for Marvell Armada 370 and Armada XP SoCs
+ *
+ * Copyright (C) 2013 Marvell
+ *
+ * Nadav Haklai <nadavh@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ */
+#include <linux/linkage.h>
+
+
+/*
+* armadaxp_cpu_suspend: enter cpu deepIdle state
+* input:
+*/
+ENTRY(armada_370_xp_cpu_suspend)
+/* Save ARM registers */
+	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
+
+	bl armada_370_xp_pmsu_idle_prepare
+	/*
+	 * Invalidate L1 data cache. Even though only invalidate is
+	 * necessary exported flush API is used here. Doing clean
+	 * on already clean cache would be almost NOP.
+	 */
+	bl v7_flush_dcache_all
+
+	/*
+	 * Clear the SCTLR.C bit to prevent further data cache
+	 * allocation. Clearing SCTLR.C would make all the data accesses
+	 * strongly ordered and would not hit the cache.
+	 */
+	mrc	p15, 0, r0, c1, c0, 0
+	bic	r0, r0, #(1 << 2)	@ Disable the C bit
+	mcr	p15, 0, r0, c1, c0, 0
+	isb
+
+	bl v7_flush_dcache_all
+
+	/* Data memory barrier and Data sync barrier */
+	dsb
+	dmb
+
+	bl armada_370_xp_disable_snoop_ena
+
+	dsb				@ Data Synchronization Barrier
+
+/*
+ * ===================================
+ * == WFI instruction => Enter idle ==
+ * ===================================
+ */
+
+	wfi				@ wait for interrupt
+/*
+ * ===================================
+ * == Resume path for non-OFF modes ==
+ * ===================================
+ */
+
+/* Enable SnoopEna - Exclusive */
+	mov	r0, #1			@ r0!=0 means use virtual address
+	mov	r1, #0			@ Do not add CPU to SMP group
+	bl ll_set_cpu_coherent
+
+/* Re-enable C-bit if needed */
+	mrc	p15, 0, r0, c1, c0, 0
+	tst	r0, #(1 << 2)		@ Check C bit enabled?
+	orreq	r0, r0, #(1 << 2)	@ Enable the C bit if cleared
+	mcreq	p15, 0, r0, c1, c0, 0
+	isb
+
+	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
+ENDPROC(armada_370_xp_cpu_suspend)
+
+/*
+* armada_370_xp_cpu_resume: exit cpu deepIdle state
+*/
+ENTRY(armada_370_xp_cpu_resume)
+	mov	r0, #0			@ r0==0 means use physical address
+	mov	r1, #1			@ Add CPU to SMP group
+	bl ll_set_cpu_coherent
+
+	/* Now branch to the common CPU resume function */
+	b	cpu_resume
+
+ENDPROC(armada_370_xp_cpu_resume)
-- 
1.8.1.2


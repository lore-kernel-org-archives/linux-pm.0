From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 8/8] ARM: ux500: move cpuidle drivers to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:15:47 +0200
Message-ID: <1372241747-21083-9-git-send-email-b.zolnierkie@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:26806 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285Ab3FZKRL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 06:17:11 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MOZ001GYWKMRPX0@mailout1.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 26 Jun 2013 19:17:10 +0900 (KST)
In-reply-to: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

Compile tested only.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-ux500/Makefile    |   1 -
 arch/arm/mach-ux500/cpuidle.c   | 128 ----------------------------------------
 drivers/cpuidle/Makefile        |   3 +
 drivers/cpuidle/cpuidle-ux500.c | 128 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+), 129 deletions(-)
 delete mode 100644 arch/arm/mach-ux500/cpuidle.c
 create mode 100644 drivers/cpuidle/cpuidle-ux500.c

diff --git a/arch/arm/mach-ux500/Makefile b/arch/arm/mach-ux500/Makefile
index bf9b6be..fe1f3e2 100644
--- a/arch/arm/mach-ux500/Makefile
+++ b/arch/arm/mach-ux500/Makefile
@@ -4,7 +4,6 @@
 
 obj-y				:= cpu.o devices.o devices-common.o \
 				   id.o usb.o timer.o pm.o
-obj-$(CONFIG_CPU_IDLE)          += cpuidle.o
 obj-$(CONFIG_CACHE_L2X0)	+= cache-l2x0.o
 obj-$(CONFIG_UX500_SOC_DB8500)	+= cpu-db8500.o devices-db8500.o
 obj-$(CONFIG_MACH_MOP500)	+= board-mop500.o board-mop500-sdi.o \
diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
deleted file mode 100644
index a45dd09..0000000
--- a/arch/arm/mach-ux500/cpuidle.c
+++ /dev/null
@@ -1,128 +0,0 @@
-/*
- * Copyright (c) 2012 Linaro : Daniel Lezcano <daniel.lezcano@linaro.org> (IBM)
- *
- * Based on the work of Rickard Andersson <rickard.andersson@stericsson.com>
- * and Jonas Aaberg <jonas.aberg@stericsson.com>.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/module.h>
-#include <linux/cpuidle.h>
-#include <linux/spinlock.h>
-#include <linux/atomic.h>
-#include <linux/smp.h>
-#include <linux/mfd/dbx500-prcmu.h>
-#include <linux/platform_data/arm-ux500-pm.h>
-
-#include <asm/cpuidle.h>
-#include <asm/proc-fns.h>
-
-#include "db8500-regs.h"
-#include "id.h"
-
-static atomic_t master = ATOMIC_INIT(0);
-static DEFINE_SPINLOCK(master_lock);
-
-static inline int ux500_enter_idle(struct cpuidle_device *dev,
-				   struct cpuidle_driver *drv, int index)
-{
-	int this_cpu = smp_processor_id();
-	bool recouple = false;
-
-	if (atomic_inc_return(&master) == num_online_cpus()) {
-
-		/* With this lock, we prevent the other cpu to exit and enter
-		 * this function again and become the master */
-		if (!spin_trylock(&master_lock))
-			goto wfi;
-
-		/* decouple the gic from the A9 cores */
-		if (prcmu_gic_decouple()) {
-			spin_unlock(&master_lock);
-			goto out;
-		}
-
-		/* If an error occur, we will have to recouple the gic
-		 * manually */
-		recouple = true;
-
-		/* At this state, as the gic is decoupled, if the other
-		 * cpu is in WFI, we have the guarantee it won't be wake
-		 * up, so we can safely go to retention */
-		if (!prcmu_is_cpu_in_wfi(this_cpu ? 0 : 1))
-			goto out;
-
-		/* The prcmu will be in charge of watching the interrupts
-		 * and wake up the cpus */
-		if (prcmu_copy_gic_settings())
-			goto out;
-
-		/* Check in the meantime an interrupt did
-		 * not occur on the gic ... */
-		if (prcmu_gic_pending_irq())
-			goto out;
-
-		/* ... and the prcmu */
-		if (prcmu_pending_irq())
-			goto out;
-
-		/* Go to the retention state, the prcmu will wait for the
-		 * cpu to go WFI and this is what happens after exiting this
-		 * 'master' critical section */
-		if (prcmu_set_power_state(PRCMU_AP_IDLE, true, true))
-			goto out;
-
-		/* When we switch to retention, the prcmu is in charge
-		 * of recoupling the gic automatically */
-		recouple = false;
-
-		spin_unlock(&master_lock);
-	}
-wfi:
-	cpu_do_idle();
-out:
-	atomic_dec(&master);
-
-	if (recouple) {
-		prcmu_gic_recouple();
-		spin_unlock(&master_lock);
-	}
-
-	return index;
-}
-
-static struct cpuidle_driver ux500_idle_driver = {
-	.name = "ux500_idle",
-	.owner = THIS_MODULE,
-	.states = {
-		ARM_CPUIDLE_WFI_STATE,
-		{
-			.enter		  = ux500_enter_idle,
-			.exit_latency	  = 70,
-			.target_residency = 260,
-			.flags		  = CPUIDLE_FLAG_TIME_VALID |
-			                    CPUIDLE_FLAG_TIMER_STOP,
-			.name		  = "ApIdle",
-			.desc		  = "ARM Retention",
-		},
-	},
-	.safe_state_index = 0,
-	.state_count = 2,
-};
-
-int __init ux500_idle_init(void)
-{
-	if (!(cpu_is_u8500_family() || cpu_is_ux540_family()))
-		return -ENODEV;
-
-	/* Configure wake up reasons */
-	prcmu_enable_wakeups(PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
-			     PRCMU_WAKEUP(ABB));
-
-	return cpuidle_register(&ux500_idle_driver, NULL);
-}
-
-device_initcall(ux500_idle_init);
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 953771f..941ed0b 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -46,4 +46,7 @@ endif
 ifeq ($(CONFIG_ARCH_TEGRA_114_SOC),y)
 	obj-y += cpuidle-tegra114.o
 endif
+ifeq ($(CONFIG_ARCH_U8500),y)
+	obj-y += cpuidle-ux500.o
+endif
 obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
diff --git a/drivers/cpuidle/cpuidle-ux500.c b/drivers/cpuidle/cpuidle-ux500.c
new file mode 100644
index 0000000..078ad70
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-ux500.c
@@ -0,0 +1,128 @@
+/*
+ * Copyright (c) 2012 Linaro : Daniel Lezcano <daniel.lezcano@linaro.org> (IBM)
+ *
+ * Based on the work of Rickard Andersson <rickard.andersson@stericsson.com>
+ * and Jonas Aaberg <jonas.aberg@stericsson.com>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/cpuidle.h>
+#include <linux/spinlock.h>
+#include <linux/atomic.h>
+#include <linux/smp.h>
+#include <linux/mfd/dbx500-prcmu.h>
+#include <linux/platform_data/arm-ux500-pm.h>
+
+#include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
+
+#include "../../arch/arm/mach-ux500/db8500-regs.h"
+#include "../../arch/arm/mach-ux500/id.h"
+
+static atomic_t master = ATOMIC_INIT(0);
+static DEFINE_SPINLOCK(master_lock);
+
+static inline int ux500_enter_idle(struct cpuidle_device *dev,
+				   struct cpuidle_driver *drv, int index)
+{
+	int this_cpu = smp_processor_id();
+	bool recouple = false;
+
+	if (atomic_inc_return(&master) == num_online_cpus()) {
+
+		/* With this lock, we prevent the other cpu to exit and enter
+		 * this function again and become the master */
+		if (!spin_trylock(&master_lock))
+			goto wfi;
+
+		/* decouple the gic from the A9 cores */
+		if (prcmu_gic_decouple()) {
+			spin_unlock(&master_lock);
+			goto out;
+		}
+
+		/* If an error occur, we will have to recouple the gic
+		 * manually */
+		recouple = true;
+
+		/* At this state, as the gic is decoupled, if the other
+		 * cpu is in WFI, we have the guarantee it won't be wake
+		 * up, so we can safely go to retention */
+		if (!prcmu_is_cpu_in_wfi(this_cpu ? 0 : 1))
+			goto out;
+
+		/* The prcmu will be in charge of watching the interrupts
+		 * and wake up the cpus */
+		if (prcmu_copy_gic_settings())
+			goto out;
+
+		/* Check in the meantime an interrupt did
+		 * not occur on the gic ... */
+		if (prcmu_gic_pending_irq())
+			goto out;
+
+		/* ... and the prcmu */
+		if (prcmu_pending_irq())
+			goto out;
+
+		/* Go to the retention state, the prcmu will wait for the
+		 * cpu to go WFI and this is what happens after exiting this
+		 * 'master' critical section */
+		if (prcmu_set_power_state(PRCMU_AP_IDLE, true, true))
+			goto out;
+
+		/* When we switch to retention, the prcmu is in charge
+		 * of recoupling the gic automatically */
+		recouple = false;
+
+		spin_unlock(&master_lock);
+	}
+wfi:
+	cpu_do_idle();
+out:
+	atomic_dec(&master);
+
+	if (recouple) {
+		prcmu_gic_recouple();
+		spin_unlock(&master_lock);
+	}
+
+	return index;
+}
+
+static struct cpuidle_driver ux500_idle_driver = {
+	.name = "ux500_idle",
+	.owner = THIS_MODULE,
+	.states = {
+		ARM_CPUIDLE_WFI_STATE,
+		{
+			.enter		  = ux500_enter_idle,
+			.exit_latency	  = 70,
+			.target_residency = 260,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID |
+			                    CPUIDLE_FLAG_TIMER_STOP,
+			.name		  = "ApIdle",
+			.desc		  = "ARM Retention",
+		},
+	},
+	.safe_state_index = 0,
+	.state_count = 2,
+};
+
+int __init ux500_idle_init(void)
+{
+	if (!(cpu_is_u8500_family() || cpu_is_ux540_family()))
+		return -ENODEV;
+
+	/* Configure wake up reasons */
+	prcmu_enable_wakeups(PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
+			     PRCMU_WAKEUP(ABB));
+
+	return cpuidle_register(&ux500_idle_driver, NULL);
+}
+
+device_initcall(ux500_idle_init);
-- 
1.8.2.3


From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4/8] ARM: OMAP: move cpuidle drivers to drivers/cpuidle/
Date: Wed, 26 Jun 2013 12:15:43 +0200
Message-ID: <1372241747-21083-5-git-send-email-b.zolnierkie@samsung.com>
References: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:15455 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab3FZKQn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Jun 2013 06:16:43 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MOZ00I4MWJC8BZ0@mailout4.samsung.com> for
 linux-pm@vger.kernel.org; Wed, 26 Jun 2013 19:16:41 +0900 (KST)
In-reply-to: <1372241747-21083-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, nsekhar@ti.com, khilman@deeprootsystems.com, kernel@pengutronix.de, shawn.guo@linaro.org, tony@atomide.com, ben-linux@fluff.org, kgene.kim@samsung.com, horms@verge.net.au, magnus.damm@gmail.com, swarren@wwwdotorg.org, srinidhi.kasagar@stericsson.com, linus.walleij@linaro.org, daniel.lezcano@linaro.org, rjw@sisk.pl, kyungmin.park@samsung.com, b.zolnierkie@samsung.com

While at it:
- remove file path from comment
- fix whitespace issues

Compile tested only.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/arm/mach-omap2/Makefile       |   5 -
 arch/arm/mach-omap2/cpuidle34xx.c  | 344 -------------------------------------
 arch/arm/mach-omap2/cpuidle44xx.c  | 217 -----------------------
 drivers/cpuidle/Makefile           |  10 ++
 drivers/cpuidle/cpuidle-omap34xx.c | 342 ++++++++++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle-omap44xx.c | 216 +++++++++++++++++++++++
 6 files changed, 568 insertions(+), 566 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/cpuidle34xx.c
 delete mode 100644 arch/arm/mach-omap2/cpuidle44xx.c
 create mode 100644 drivers/cpuidle/cpuidle-omap34xx.c
 create mode 100644 drivers/cpuidle/cpuidle-omap44xx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0520dc4..b80b086 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -102,11 +102,6 @@ endif
 
 endif
 
-ifeq ($(CONFIG_CPU_IDLE),y)
-obj-$(CONFIG_ARCH_OMAP3)                += cpuidle34xx.o
-obj-$(CONFIG_ARCH_OMAP4)                += cpuidle44xx.o
-endif
-
 # PRCM
 obj-y					+= prm_common.o cm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prm2xxx_3xxx.o prm2xxx.o cm2xxx.o
diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
deleted file mode 100644
index e18709d..0000000
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ /dev/null
@@ -1,344 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/cpuidle34xx.c
- *
- * OMAP3 CPU IDLE Routines
- *
- * Copyright (C) 2008 Texas Instruments, Inc.
- * Rajendra Nayak <rnayak@ti.com>
- *
- * Copyright (C) 2007 Texas Instruments, Inc.
- * Karthik Dasu <karthik-dp@ti.com>
- *
- * Copyright (C) 2006 Nokia Corporation
- * Tony Lindgren <tony@atomide.com>
- *
- * Copyright (C) 2005 Texas Instruments, Inc.
- * Richard Woodruff <r-woodruff2@ti.com>
- *
- * Based on pm.c for omap2
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/sched.h>
-#include <linux/cpuidle.h>
-#include <linux/export.h>
-#include <linux/cpu_pm.h>
-#include <asm/cpuidle.h>
-
-#include "powerdomain.h"
-#include "clockdomain.h"
-
-#include "pm.h"
-#include "control.h"
-#include "common.h"
-
-/* Mach specific information to be recorded in the C-state driver_data */
-struct omap3_idle_statedata {
-	u8 mpu_state;
-	u8 core_state;
-	u8 per_min_state;
-	u8 flags;
-};
-
-static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
-
-/*
- * Possible flag bits for struct omap3_idle_statedata.flags:
- *
- * OMAP_CPUIDLE_CX_NO_CLKDM_IDLE: don't allow the MPU clockdomain to go
- *    inactive.  This in turn prevents the MPU DPLL from entering autoidle
- *    mode, so wakeup latency is greatly reduced, at the cost of additional
- *    energy consumption.  This also prevents the CORE clockdomain from
- *    entering idle.
- */
-#define OMAP_CPUIDLE_CX_NO_CLKDM_IDLE		BIT(0)
-
-/*
- * Prevent PER OFF if CORE is not in RETention or OFF as this would
- * disable PER wakeups completely.
- */
-static struct omap3_idle_statedata omap3_idle_data[] = {
-	{
-		.mpu_state = PWRDM_POWER_ON,
-		.core_state = PWRDM_POWER_ON,
-		/* In C1 do not allow PER state lower than CORE state */
-		.per_min_state = PWRDM_POWER_ON,
-		.flags = OMAP_CPUIDLE_CX_NO_CLKDM_IDLE,
-	},
-	{
-		.mpu_state = PWRDM_POWER_ON,
-		.core_state = PWRDM_POWER_ON,
-		.per_min_state = PWRDM_POWER_RET,
-	},
-	{
-		.mpu_state = PWRDM_POWER_RET,
-		.core_state = PWRDM_POWER_ON,
-		.per_min_state = PWRDM_POWER_RET,
-	},
-	{
-		.mpu_state = PWRDM_POWER_OFF,
-		.core_state = PWRDM_POWER_ON,
-		.per_min_state = PWRDM_POWER_RET,
-	},
-	{
-		.mpu_state = PWRDM_POWER_RET,
-		.core_state = PWRDM_POWER_RET,
-		.per_min_state = PWRDM_POWER_OFF,
-	},
-	{
-		.mpu_state = PWRDM_POWER_OFF,
-		.core_state = PWRDM_POWER_RET,
-		.per_min_state = PWRDM_POWER_OFF,
-	},
-	{
-		.mpu_state = PWRDM_POWER_OFF,
-		.core_state = PWRDM_POWER_OFF,
-		.per_min_state = PWRDM_POWER_OFF,
-	},
-};
-
-/**
- * omap3_enter_idle - Programs OMAP3 to enter the specified state
- * @dev: cpuidle device
- * @drv: cpuidle driver
- * @index: the index of state to be entered
- */
-static int omap3_enter_idle(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv,
-			    int index)
-{
-	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
-
-	if (omap_irq_pending() || need_resched())
-		goto return_sleep_time;
-
-	/* Deny idle for C1 */
-	if (cx->flags & OMAP_CPUIDLE_CX_NO_CLKDM_IDLE) {
-		clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
-	} else {
-		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
-		pwrdm_set_next_pwrst(core_pd, cx->core_state);
-	}
-
-	/*
-	 * Call idle CPU PM enter notifier chain so that
-	 * VFP context is saved.
-	 */
-	if (cx->mpu_state == PWRDM_POWER_OFF)
-		cpu_pm_enter();
-
-	/* Execute ARM wfi */
-	omap_sram_idle();
-
-	/*
-	 * Call idle CPU PM enter notifier chain to restore
-	 * VFP context.
-	 */
-	if (cx->mpu_state == PWRDM_POWER_OFF &&
-	    pwrdm_read_prev_pwrst(mpu_pd) == PWRDM_POWER_OFF)
-		cpu_pm_exit();
-
-	/* Re-allow idle for C1 */
-	if (cx->flags & OMAP_CPUIDLE_CX_NO_CLKDM_IDLE)
-		clkdm_allow_idle(mpu_pd->pwrdm_clkdms[0]);
-
-return_sleep_time:
-
-	return index;
-}
-
-/**
- * next_valid_state - Find next valid C-state
- * @dev: cpuidle device
- * @drv: cpuidle driver
- * @index: Index of currently selected c-state
- *
- * If the state corresponding to index is valid, index is returned back
- * to the caller. Else, this function searches for a lower c-state which is
- * still valid (as defined in omap3_power_states[]) and returns its index.
- *
- * A state is valid if the 'valid' field is enabled and
- * if it satisfies the enable_off_mode condition.
- */
-static int next_valid_state(struct cpuidle_device *dev,
-			    struct cpuidle_driver *drv, int index)
-{
-	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
-	u32 mpu_deepest_state = PWRDM_POWER_RET;
-	u32 core_deepest_state = PWRDM_POWER_RET;
-	int idx;
-	int next_index = 0; /* C1 is the default value */
-
-	if (enable_off_mode) {
-		mpu_deepest_state = PWRDM_POWER_OFF;
-		/*
-		 * Erratum i583: valable for ES rev < Es1.2 on 3630.
-		 * CORE OFF mode is not supported in a stable form, restrict
-		 * instead the CORE state to RET.
-		 */
-		if (!IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
-			core_deepest_state = PWRDM_POWER_OFF;
-	}
-
-	/* Check if current state is valid */
-	if ((cx->mpu_state >= mpu_deepest_state) &&
-	    (cx->core_state >= core_deepest_state))
-		return index;
-
-	/*
-	 * Drop to next valid state.
-	 * Start search from the next (lower) state.
-	 */
-	for (idx = index - 1; idx >= 0; idx--) {
-		cx = &omap3_idle_data[idx];
-		if ((cx->mpu_state >= mpu_deepest_state) &&
-		    (cx->core_state >= core_deepest_state)) {
-			next_index = idx;
-			break;
-		}
-	}
-
-	return next_index;
-}
-
-/**
- * omap3_enter_idle_bm - Checks for any bus activity
- * @dev: cpuidle device
- * @drv: cpuidle driver
- * @index: array index of target state to be programmed
- *
- * This function checks for any pending activity and then programs
- * the device to the specified or a safer state.
- */
-static int omap3_enter_idle_bm(struct cpuidle_device *dev,
-			       struct cpuidle_driver *drv,
-			       int index)
-{
-	int new_state_idx, ret;
-	u8 per_next_state, per_saved_state;
-	struct omap3_idle_statedata *cx;
-
-	/*
-	 * Use only C1 if CAM is active.
-	 * CAM does not have wakeup capability in OMAP3.
-	 */
-	if (pwrdm_read_pwrst(cam_pd) == PWRDM_POWER_ON)
-		new_state_idx = drv->safe_state_index;
-	else
-		new_state_idx = next_valid_state(dev, drv, index);
-
-	/*
-	 * FIXME: we currently manage device-specific idle states
-	 *        for PER and CORE in combination with CPU-specific
-	 *        idle states.  This is wrong, and device-specific
-	 *        idle management needs to be separated out into
-	 *        its own code.
-	 */
-
-	/* Program PER state */
-	cx = &omap3_idle_data[new_state_idx];
-
-	per_next_state = pwrdm_read_next_pwrst(per_pd);
-	per_saved_state = per_next_state;
-	if (per_next_state < cx->per_min_state) {
-		per_next_state = cx->per_min_state;
-		pwrdm_set_next_pwrst(per_pd, per_next_state);
-	}
-
-	ret = omap3_enter_idle(dev, drv, new_state_idx);
-
-	/* Restore original PER state if it was modified */
-	if (per_next_state != per_saved_state)
-		pwrdm_set_next_pwrst(per_pd, per_saved_state);
-
-	return ret;
-}
-
-static struct cpuidle_driver omap3_idle_driver = {
-	.name             = "omap3_idle",
-	.owner            = THIS_MODULE,
-	.states = {
-		{
-			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 2 + 2,
-			.target_residency = 5,
-			.flags		  = CPUIDLE_FLAG_TIME_VALID,
-			.name		  = "C1",
-			.desc		  = "MPU ON + CORE ON",
-		},
-		{
-			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 10 + 10,
-			.target_residency = 30,
-			.flags		  = CPUIDLE_FLAG_TIME_VALID,
-			.name		  = "C2",
-			.desc		  = "MPU ON + CORE ON",
-		},
-		{
-			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 50 + 50,
-			.target_residency = 300,
-			.flags		  = CPUIDLE_FLAG_TIME_VALID,
-			.name		  = "C3",
-			.desc		  = "MPU RET + CORE ON",
-		},
-		{
-			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 1500 + 1800,
-			.target_residency = 4000,
-			.flags		  = CPUIDLE_FLAG_TIME_VALID,
-			.name		  = "C4",
-			.desc		  = "MPU OFF + CORE ON",
-		},
-		{
-			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 2500 + 7500,
-			.target_residency = 12000,
-			.flags		  = CPUIDLE_FLAG_TIME_VALID,
-			.name		  = "C5",
-			.desc		  = "MPU RET + CORE RET",
-		},
-		{
-			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 3000 + 8500,
-			.target_residency = 15000,
-			.flags		  = CPUIDLE_FLAG_TIME_VALID,
-			.name		  = "C6",
-			.desc		  = "MPU OFF + CORE RET",
-		},
-		{
-			.enter		  = omap3_enter_idle_bm,
-			.exit_latency	  = 10000 + 30000,
-			.target_residency = 30000,
-			.flags		  = CPUIDLE_FLAG_TIME_VALID,
-			.name		  = "C7",
-			.desc		  = "MPU OFF + CORE OFF",
-		},
-	},
-	.state_count = ARRAY_SIZE(omap3_idle_data),
-	.safe_state_index = 0,
-};
-
-/* Public functions */
-
-/**
- * omap3_idle_init - Init routine for OMAP3 idle
- *
- * Registers the OMAP3 specific cpuidle driver to the cpuidle
- * framework with the valid set of states.
- */
-int __init omap3_idle_init(void)
-{
-	mpu_pd = pwrdm_lookup("mpu_pwrdm");
-	core_pd = pwrdm_lookup("core_pwrdm");
-	per_pd = pwrdm_lookup("per_pwrdm");
-	cam_pd = pwrdm_lookup("cam_pwrdm");
-
-	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
-		return -ENODEV;
-
-	return cpuidle_register(&omap3_idle_driver, NULL);
-}
diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
deleted file mode 100644
index c443f2e..0000000
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ /dev/null
@@ -1,217 +0,0 @@
-/*
- * OMAP4+ CPU idle Routines
- *
- * Copyright (C) 2011-2013 Texas Instruments, Inc.
- * Santosh Shilimkar <santosh.shilimkar@ti.com>
- * Rajendra Nayak <rnayak@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/sched.h>
-#include <linux/cpuidle.h>
-#include <linux/cpu_pm.h>
-#include <linux/export.h>
-
-#include <asm/cpuidle.h>
-#include <asm/proc-fns.h>
-
-#include "common.h"
-#include "pm.h"
-#include "prm.h"
-#include "clockdomain.h"
-
-/* Machine specific information */
-struct idle_statedata {
-	u32 cpu_state;
-	u32 mpu_logic_state;
-	u32 mpu_state;
-};
-
-static struct idle_statedata omap4_idle_data[] = {
-	{
-		.cpu_state = PWRDM_POWER_ON,
-		.mpu_state = PWRDM_POWER_ON,
-		.mpu_logic_state = PWRDM_POWER_RET,
-	},
-	{
-		.cpu_state = PWRDM_POWER_OFF,
-		.mpu_state = PWRDM_POWER_RET,
-		.mpu_logic_state = PWRDM_POWER_RET,
-	},
-	{
-		.cpu_state = PWRDM_POWER_OFF,
-		.mpu_state = PWRDM_POWER_RET,
-		.mpu_logic_state = PWRDM_POWER_OFF,
-	},
-};
-
-static struct powerdomain *mpu_pd, *cpu_pd[NR_CPUS];
-static struct clockdomain *cpu_clkdm[NR_CPUS];
-
-static atomic_t abort_barrier;
-static bool cpu_done[NR_CPUS];
-static struct idle_statedata *state_ptr = &omap4_idle_data[0];
-
-/* Private functions */
-
-/**
- * omap_enter_idle_[simple/coupled] - OMAP4PLUS cpuidle entry functions
- * @dev: cpuidle device
- * @drv: cpuidle driver
- * @index: the index of state to be entered
- *
- * Called from the CPUidle framework to program the device to the
- * specified low power state selected by the governor.
- * Returns the amount of time spent in the low power state.
- */
-static int omap_enter_idle_simple(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-			int index)
-{
-	omap_do_wfi();
-	return index;
-}
-
-static int omap_enter_idle_coupled(struct cpuidle_device *dev,
-			struct cpuidle_driver *drv,
-			int index)
-{
-	struct idle_statedata *cx = state_ptr + index;
-
-	/*
-	 * CPU0 has to wait and stay ON until CPU1 is OFF state.
-	 * This is necessary to honour hardware recommondation
-	 * of triggeing all the possible low power modes once CPU1 is
-	 * out of coherency and in OFF mode.
-	 */
-	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
-		while (pwrdm_read_pwrst(cpu_pd[1]) != PWRDM_POWER_OFF) {
-			cpu_relax();
-
-			/*
-			 * CPU1 could have already entered & exited idle
-			 * without hitting off because of a wakeup
-			 * or a failed attempt to hit off mode.  Check for
-			 * that here, otherwise we could spin forever
-			 * waiting for CPU1 off.
-			 */
-			if (cpu_done[1])
-			    goto fail;
-
-		}
-	}
-
-	/*
-	 * Call idle CPU PM enter notifier chain so that
-	 * VFP and per CPU interrupt context is saved.
-	 */
-	cpu_pm_enter();
-
-	if (dev->cpu == 0) {
-		pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
-		omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
-
-		/*
-		 * Call idle CPU cluster PM enter notifier chain
-		 * to save GIC and wakeupgen context.
-		 */
-		if ((cx->mpu_state == PWRDM_POWER_RET) &&
-			(cx->mpu_logic_state == PWRDM_POWER_OFF))
-				cpu_cluster_pm_enter();
-	}
-
-	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
-	cpu_done[dev->cpu] = true;
-
-	/* Wakeup CPU1 only if it is not offlined */
-	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
-		clkdm_wakeup(cpu_clkdm[1]);
-		omap_set_pwrdm_state(cpu_pd[1], PWRDM_POWER_ON);
-		clkdm_allow_idle(cpu_clkdm[1]);
-	}
-
-	/*
-	 * Call idle CPU PM exit notifier chain to restore
-	 * VFP and per CPU IRQ context.
-	 */
-	cpu_pm_exit();
-
-	/*
-	 * Call idle CPU cluster PM exit notifier chain
-	 * to restore GIC and wakeupgen context.
-	 */
-	if ((cx->mpu_state == PWRDM_POWER_RET) &&
-		(cx->mpu_logic_state == PWRDM_POWER_OFF))
-		cpu_cluster_pm_exit();
-
-fail:
-	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
-	cpu_done[dev->cpu] = false;
-
-	return index;
-}
-
-static struct cpuidle_driver omap4_idle_driver = {
-	.name				= "omap4_idle",
-	.owner				= THIS_MODULE,
-	.states = {
-		{
-			/* C1 - CPU0 ON + CPU1 ON + MPU ON */
-			.exit_latency = 2 + 2,
-			.target_residency = 5,
-			.flags = CPUIDLE_FLAG_TIME_VALID,
-			.enter = omap_enter_idle_simple,
-			.name = "C1",
-			.desc = "CPUx ON, MPUSS ON"
-		},
-		{
-			/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
-			.exit_latency = 328 + 440,
-			.target_residency = 960,
-			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
-			         CPUIDLE_FLAG_TIMER_STOP,
-			.enter = omap_enter_idle_coupled,
-			.name = "C2",
-			.desc = "CPUx OFF, MPUSS CSWR",
-		},
-		{
-			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
-			.exit_latency = 460 + 518,
-			.target_residency = 1100,
-			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
-			         CPUIDLE_FLAG_TIMER_STOP,
-			.enter = omap_enter_idle_coupled,
-			.name = "C3",
-			.desc = "CPUx OFF, MPUSS OSWR",
-		},
-	},
-	.state_count = ARRAY_SIZE(omap4_idle_data),
-	.safe_state_index = 0,
-};
-
-/* Public functions */
-
-/**
- * omap4_idle_init - Init routine for OMAP4+ idle
- *
- * Registers the OMAP4+ specific cpuidle driver to the cpuidle
- * framework with the valid set of states.
- */
-int __init omap4_idle_init(void)
-{
-	mpu_pd = pwrdm_lookup("mpu_pwrdm");
-	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
-	cpu_pd[1] = pwrdm_lookup("cpu1_pwrdm");
-	if ((!mpu_pd) || (!cpu_pd[0]) || (!cpu_pd[1]))
-		return -ENODEV;
-
-	cpu_clkdm[0] = clkdm_lookup("mpu0_clkdm");
-	cpu_clkdm[1] = clkdm_lookup("mpu1_clkdm");
-	if (!cpu_clkdm[0] || !cpu_clkdm[1])
-		return -ENODEV;
-
-	return cpuidle_register(&omap4_idle_driver, cpu_online_mask);
-}
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index 9bacf85..6436c67 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -21,4 +21,14 @@ ifeq ($(CONFIG_ARCH_MXC),y)
 		obj-y += cpuidle-imx6q.o
 	endif
 endif
+ifeq ($(CONFIG_ARCH_OMAP3),y)
+	ccflags-y += -I$(srctree)/arch/arm/plat-omap/include
+	ccflags-y += -I$(srctree)/arch/arm/mach-omap2/include
+	obj-y += cpuidle-omap34xx.o
+endif
+ifeq ($(CONFIG_ARCH_OMAP4),y)
+	ccflags-y += -I$(srctree)/arch/arm/plat-omap/include
+	ccflags-y += -I$(srctree)/arch/arm/mach-omap2/include
+	obj-y += cpuidle-omap44xx.o
+endif
 obj-$(CONFIG_CPU_IDLE_ZYNQ) += cpuidle-zynq.o
diff --git a/drivers/cpuidle/cpuidle-omap34xx.c b/drivers/cpuidle/cpuidle-omap34xx.c
new file mode 100644
index 0000000..0c14077
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-omap34xx.c
@@ -0,0 +1,342 @@
+/*
+ * OMAP3 CPU IDLE Routines
+ *
+ * Copyright (C) 2008 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Karthik Dasu <karthik-dp@ti.com>
+ *
+ * Copyright (C) 2006 Nokia Corporation
+ * Tony Lindgren <tony@atomide.com>
+ *
+ * Copyright (C) 2005 Texas Instruments, Inc.
+ * Richard Woodruff <r-woodruff2@ti.com>
+ *
+ * Based on pm.c for omap2
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/sched.h>
+#include <linux/cpuidle.h>
+#include <linux/export.h>
+#include <linux/cpu_pm.h>
+#include <asm/cpuidle.h>
+
+#include "../../arch/arm/mach-omap2/powerdomain.h"
+#include "../../arch/arm/mach-omap2/clockdomain.h"
+
+#include "../../arch/arm/mach-omap2/pm.h"
+#include "../../arch/arm/mach-omap2/control.h"
+#include "../../arch/arm/mach-omap2/common.h"
+
+/* Mach specific information to be recorded in the C-state driver_data */
+struct omap3_idle_statedata {
+	u8 mpu_state;
+	u8 core_state;
+	u8 per_min_state;
+	u8 flags;
+};
+
+static struct powerdomain *mpu_pd, *core_pd, *per_pd, *cam_pd;
+
+/*
+ * Possible flag bits for struct omap3_idle_statedata.flags:
+ *
+ * OMAP_CPUIDLE_CX_NO_CLKDM_IDLE: don't allow the MPU clockdomain to go
+ *    inactive.  This in turn prevents the MPU DPLL from entering autoidle
+ *    mode, so wakeup latency is greatly reduced, at the cost of additional
+ *    energy consumption.  This also prevents the CORE clockdomain from
+ *    entering idle.
+ */
+#define OMAP_CPUIDLE_CX_NO_CLKDM_IDLE		BIT(0)
+
+/*
+ * Prevent PER OFF if CORE is not in RETention or OFF as this would
+ * disable PER wakeups completely.
+ */
+static struct omap3_idle_statedata omap3_idle_data[] = {
+	{
+		.mpu_state = PWRDM_POWER_ON,
+		.core_state = PWRDM_POWER_ON,
+		/* In C1 do not allow PER state lower than CORE state */
+		.per_min_state = PWRDM_POWER_ON,
+		.flags = OMAP_CPUIDLE_CX_NO_CLKDM_IDLE,
+	},
+	{
+		.mpu_state = PWRDM_POWER_ON,
+		.core_state = PWRDM_POWER_ON,
+		.per_min_state = PWRDM_POWER_RET,
+	},
+	{
+		.mpu_state = PWRDM_POWER_RET,
+		.core_state = PWRDM_POWER_ON,
+		.per_min_state = PWRDM_POWER_RET,
+	},
+	{
+		.mpu_state = PWRDM_POWER_OFF,
+		.core_state = PWRDM_POWER_ON,
+		.per_min_state = PWRDM_POWER_RET,
+	},
+	{
+		.mpu_state = PWRDM_POWER_RET,
+		.core_state = PWRDM_POWER_RET,
+		.per_min_state = PWRDM_POWER_OFF,
+	},
+	{
+		.mpu_state = PWRDM_POWER_OFF,
+		.core_state = PWRDM_POWER_RET,
+		.per_min_state = PWRDM_POWER_OFF,
+	},
+	{
+		.mpu_state = PWRDM_POWER_OFF,
+		.core_state = PWRDM_POWER_OFF,
+		.per_min_state = PWRDM_POWER_OFF,
+	},
+};
+
+/**
+ * omap3_enter_idle - Programs OMAP3 to enter the specified state
+ * @dev: cpuidle device
+ * @drv: cpuidle driver
+ * @index: the index of state to be entered
+ */
+static int omap3_enter_idle(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv,
+			    int index)
+{
+	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
+
+	if (omap_irq_pending() || need_resched())
+		goto return_sleep_time;
+
+	/* Deny idle for C1 */
+	if (cx->flags & OMAP_CPUIDLE_CX_NO_CLKDM_IDLE) {
+		clkdm_deny_idle(mpu_pd->pwrdm_clkdms[0]);
+	} else {
+		pwrdm_set_next_pwrst(mpu_pd, cx->mpu_state);
+		pwrdm_set_next_pwrst(core_pd, cx->core_state);
+	}
+
+	/*
+	 * Call idle CPU PM enter notifier chain so that
+	 * VFP context is saved.
+	 */
+	if (cx->mpu_state == PWRDM_POWER_OFF)
+		cpu_pm_enter();
+
+	/* Execute ARM wfi */
+	omap_sram_idle();
+
+	/*
+	 * Call idle CPU PM enter notifier chain to restore
+	 * VFP context.
+	 */
+	if (cx->mpu_state == PWRDM_POWER_OFF &&
+	    pwrdm_read_prev_pwrst(mpu_pd) == PWRDM_POWER_OFF)
+		cpu_pm_exit();
+
+	/* Re-allow idle for C1 */
+	if (cx->flags & OMAP_CPUIDLE_CX_NO_CLKDM_IDLE)
+		clkdm_allow_idle(mpu_pd->pwrdm_clkdms[0]);
+
+return_sleep_time:
+
+	return index;
+}
+
+/**
+ * next_valid_state - Find next valid C-state
+ * @dev: cpuidle device
+ * @drv: cpuidle driver
+ * @index: Index of currently selected c-state
+ *
+ * If the state corresponding to index is valid, index is returned back
+ * to the caller. Else, this function searches for a lower c-state which is
+ * still valid (as defined in omap3_power_states[]) and returns its index.
+ *
+ * A state is valid if the 'valid' field is enabled and
+ * if it satisfies the enable_off_mode condition.
+ */
+static int next_valid_state(struct cpuidle_device *dev,
+			    struct cpuidle_driver *drv, int index)
+{
+	struct omap3_idle_statedata *cx = &omap3_idle_data[index];
+	u32 mpu_deepest_state = PWRDM_POWER_RET;
+	u32 core_deepest_state = PWRDM_POWER_RET;
+	int idx;
+	int next_index = 0; /* C1 is the default value */
+
+	if (enable_off_mode) {
+		mpu_deepest_state = PWRDM_POWER_OFF;
+		/*
+		 * Erratum i583: valable for ES rev < Es1.2 on 3630.
+		 * CORE OFF mode is not supported in a stable form, restrict
+		 * instead the CORE state to RET.
+		 */
+		if (!IS_PM34XX_ERRATUM(PM_SDRC_WAKEUP_ERRATUM_i583))
+			core_deepest_state = PWRDM_POWER_OFF;
+	}
+
+	/* Check if current state is valid */
+	if ((cx->mpu_state >= mpu_deepest_state) &&
+	    (cx->core_state >= core_deepest_state))
+		return index;
+
+	/*
+	 * Drop to next valid state.
+	 * Start search from the next (lower) state.
+	 */
+	for (idx = index - 1; idx >= 0; idx--) {
+		cx = &omap3_idle_data[idx];
+		if ((cx->mpu_state >= mpu_deepest_state) &&
+		    (cx->core_state >= core_deepest_state)) {
+			next_index = idx;
+			break;
+		}
+	}
+
+	return next_index;
+}
+
+/**
+ * omap3_enter_idle_bm - Checks for any bus activity
+ * @dev: cpuidle device
+ * @drv: cpuidle driver
+ * @index: array index of target state to be programmed
+ *
+ * This function checks for any pending activity and then programs
+ * the device to the specified or a safer state.
+ */
+static int omap3_enter_idle_bm(struct cpuidle_device *dev,
+			       struct cpuidle_driver *drv,
+			       int index)
+{
+	int new_state_idx, ret;
+	u8 per_next_state, per_saved_state;
+	struct omap3_idle_statedata *cx;
+
+	/*
+	 * Use only C1 if CAM is active.
+	 * CAM does not have wakeup capability in OMAP3.
+	 */
+	if (pwrdm_read_pwrst(cam_pd) == PWRDM_POWER_ON)
+		new_state_idx = drv->safe_state_index;
+	else
+		new_state_idx = next_valid_state(dev, drv, index);
+
+	/*
+	 * FIXME: we currently manage device-specific idle states
+	 *        for PER and CORE in combination with CPU-specific
+	 *        idle states.  This is wrong, and device-specific
+	 *        idle management needs to be separated out into
+	 *        its own code.
+	 */
+
+	/* Program PER state */
+	cx = &omap3_idle_data[new_state_idx];
+
+	per_next_state = pwrdm_read_next_pwrst(per_pd);
+	per_saved_state = per_next_state;
+	if (per_next_state < cx->per_min_state) {
+		per_next_state = cx->per_min_state;
+		pwrdm_set_next_pwrst(per_pd, per_next_state);
+	}
+
+	ret = omap3_enter_idle(dev, drv, new_state_idx);
+
+	/* Restore original PER state if it was modified */
+	if (per_next_state != per_saved_state)
+		pwrdm_set_next_pwrst(per_pd, per_saved_state);
+
+	return ret;
+}
+
+static struct cpuidle_driver omap3_idle_driver = {
+	.name             = "omap3_idle",
+	.owner            = THIS_MODULE,
+	.states = {
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 2 + 2,
+			.target_residency = 5,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C1",
+			.desc		  = "MPU ON + CORE ON",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 10 + 10,
+			.target_residency = 30,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C2",
+			.desc		  = "MPU ON + CORE ON",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 50 + 50,
+			.target_residency = 300,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C3",
+			.desc		  = "MPU RET + CORE ON",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 1500 + 1800,
+			.target_residency = 4000,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C4",
+			.desc		  = "MPU OFF + CORE ON",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 2500 + 7500,
+			.target_residency = 12000,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C5",
+			.desc		  = "MPU RET + CORE RET",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 3000 + 8500,
+			.target_residency = 15000,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C6",
+			.desc		  = "MPU OFF + CORE RET",
+		},
+		{
+			.enter		  = omap3_enter_idle_bm,
+			.exit_latency	  = 10000 + 30000,
+			.target_residency = 30000,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.name		  = "C7",
+			.desc		  = "MPU OFF + CORE OFF",
+		},
+	},
+	.state_count = ARRAY_SIZE(omap3_idle_data),
+	.safe_state_index = 0,
+};
+
+/* Public functions */
+
+/**
+ * omap3_idle_init - Init routine for OMAP3 idle
+ *
+ * Registers the OMAP3 specific cpuidle driver to the cpuidle
+ * framework with the valid set of states.
+ */
+int __init omap3_idle_init(void)
+{
+	mpu_pd = pwrdm_lookup("mpu_pwrdm");
+	core_pd = pwrdm_lookup("core_pwrdm");
+	per_pd = pwrdm_lookup("per_pwrdm");
+	cam_pd = pwrdm_lookup("cam_pwrdm");
+
+	if (!mpu_pd || !core_pd || !per_pd || !cam_pd)
+		return -ENODEV;
+
+	return cpuidle_register(&omap3_idle_driver, NULL);
+}
diff --git a/drivers/cpuidle/cpuidle-omap44xx.c b/drivers/cpuidle/cpuidle-omap44xx.c
new file mode 100644
index 0000000..86b8a51
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-omap44xx.c
@@ -0,0 +1,216 @@
+/*
+ * OMAP4+ CPU idle Routines
+ *
+ * Copyright (C) 2011-2013 Texas Instruments, Inc.
+ * Santosh Shilimkar <santosh.shilimkar@ti.com>
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/sched.h>
+#include <linux/cpuidle.h>
+#include <linux/cpu_pm.h>
+#include <linux/export.h>
+
+#include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
+
+#include "../../arch/arm/mach-omap2/common.h"
+#include "../../arch/arm/mach-omap2/pm.h"
+#include "../../arch/arm/mach-omap2/prm.h"
+#include "../../arch/arm/mach-omap2/clockdomain.h"
+
+/* Machine specific information */
+struct idle_statedata {
+	u32 cpu_state;
+	u32 mpu_logic_state;
+	u32 mpu_state;
+};
+
+static struct idle_statedata omap4_idle_data[] = {
+	{
+		.cpu_state = PWRDM_POWER_ON,
+		.mpu_state = PWRDM_POWER_ON,
+		.mpu_logic_state = PWRDM_POWER_RET,
+	},
+	{
+		.cpu_state = PWRDM_POWER_OFF,
+		.mpu_state = PWRDM_POWER_RET,
+		.mpu_logic_state = PWRDM_POWER_RET,
+	},
+	{
+		.cpu_state = PWRDM_POWER_OFF,
+		.mpu_state = PWRDM_POWER_RET,
+		.mpu_logic_state = PWRDM_POWER_OFF,
+	},
+};
+
+static struct powerdomain *mpu_pd, *cpu_pd[NR_CPUS];
+static struct clockdomain *cpu_clkdm[NR_CPUS];
+
+static atomic_t abort_barrier;
+static bool cpu_done[NR_CPUS];
+static struct idle_statedata *state_ptr = &omap4_idle_data[0];
+
+/* Private functions */
+
+/**
+ * omap_enter_idle_[simple/coupled] - OMAP4PLUS cpuidle entry functions
+ * @dev: cpuidle device
+ * @drv: cpuidle driver
+ * @index: the index of state to be entered
+ *
+ * Called from the CPUidle framework to program the device to the
+ * specified low power state selected by the governor.
+ * Returns the amount of time spent in the low power state.
+ */
+static int omap_enter_idle_simple(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int index)
+{
+	omap_do_wfi();
+	return index;
+}
+
+static int omap_enter_idle_coupled(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv,
+			int index)
+{
+	struct idle_statedata *cx = state_ptr + index;
+
+	/*
+	 * CPU0 has to wait and stay ON until CPU1 is OFF state.
+	 * This is necessary to honour hardware recommondation
+	 * of triggeing all the possible low power modes once CPU1 is
+	 * out of coherency and in OFF mode.
+	 */
+	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
+		while (pwrdm_read_pwrst(cpu_pd[1]) != PWRDM_POWER_OFF) {
+			cpu_relax();
+
+			/*
+			 * CPU1 could have already entered & exited idle
+			 * without hitting off because of a wakeup
+			 * or a failed attempt to hit off mode.  Check for
+			 * that here, otherwise we could spin forever
+			 * waiting for CPU1 off.
+			 */
+			if (cpu_done[1])
+				goto fail;
+		}
+	}
+
+	/*
+	 * Call idle CPU PM enter notifier chain so that
+	 * VFP and per CPU interrupt context is saved.
+	 */
+	cpu_pm_enter();
+
+	if (dev->cpu == 0) {
+		pwrdm_set_logic_retst(mpu_pd, cx->mpu_logic_state);
+		omap_set_pwrdm_state(mpu_pd, cx->mpu_state);
+
+		/*
+		 * Call idle CPU cluster PM enter notifier chain
+		 * to save GIC and wakeupgen context.
+		 */
+		if ((cx->mpu_state == PWRDM_POWER_RET) &&
+			(cx->mpu_logic_state == PWRDM_POWER_OFF))
+				cpu_cluster_pm_enter();
+	}
+
+	omap4_enter_lowpower(dev->cpu, cx->cpu_state);
+	cpu_done[dev->cpu] = true;
+
+	/* Wakeup CPU1 only if it is not offlined */
+	if (dev->cpu == 0 && cpumask_test_cpu(1, cpu_online_mask)) {
+		clkdm_wakeup(cpu_clkdm[1]);
+		omap_set_pwrdm_state(cpu_pd[1], PWRDM_POWER_ON);
+		clkdm_allow_idle(cpu_clkdm[1]);
+	}
+
+	/*
+	 * Call idle CPU PM exit notifier chain to restore
+	 * VFP and per CPU IRQ context.
+	 */
+	cpu_pm_exit();
+
+	/*
+	 * Call idle CPU cluster PM exit notifier chain
+	 * to restore GIC and wakeupgen context.
+	 */
+	if ((cx->mpu_state == PWRDM_POWER_RET) &&
+		(cx->mpu_logic_state == PWRDM_POWER_OFF))
+		cpu_cluster_pm_exit();
+
+fail:
+	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
+	cpu_done[dev->cpu] = false;
+
+	return index;
+}
+
+static struct cpuidle_driver omap4_idle_driver = {
+	.name				= "omap4_idle",
+	.owner				= THIS_MODULE,
+	.states = {
+		{
+			/* C1 - CPU0 ON + CPU1 ON + MPU ON */
+			.exit_latency = 2 + 2,
+			.target_residency = 5,
+			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.enter = omap_enter_idle_simple,
+			.name = "C1",
+			.desc = "CPUx ON, MPUSS ON"
+		},
+		{
+			/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
+			.exit_latency = 328 + 440,
+			.target_residency = 960,
+			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
+				 CPUIDLE_FLAG_TIMER_STOP,
+			.enter = omap_enter_idle_coupled,
+			.name = "C2",
+			.desc = "CPUx OFF, MPUSS CSWR",
+		},
+		{
+			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
+			.exit_latency = 460 + 518,
+			.target_residency = 1100,
+			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
+				 CPUIDLE_FLAG_TIMER_STOP,
+			.enter = omap_enter_idle_coupled,
+			.name = "C3",
+			.desc = "CPUx OFF, MPUSS OSWR",
+		},
+	},
+	.state_count = ARRAY_SIZE(omap4_idle_data),
+	.safe_state_index = 0,
+};
+
+/* Public functions */
+
+/**
+ * omap4_idle_init - Init routine for OMAP4+ idle
+ *
+ * Registers the OMAP4+ specific cpuidle driver to the cpuidle
+ * framework with the valid set of states.
+ */
+int __init omap4_idle_init(void)
+{
+	mpu_pd = pwrdm_lookup("mpu_pwrdm");
+	cpu_pd[0] = pwrdm_lookup("cpu0_pwrdm");
+	cpu_pd[1] = pwrdm_lookup("cpu1_pwrdm");
+	if ((!mpu_pd) || (!cpu_pd[0]) || (!cpu_pd[1]))
+		return -ENODEV;
+
+	cpu_clkdm[0] = clkdm_lookup("mpu0_clkdm");
+	cpu_clkdm[1] = clkdm_lookup("mpu1_clkdm");
+	if (!cpu_clkdm[0] || !cpu_clkdm[1])
+		return -ENODEV;
+
+	return cpuidle_register(&omap4_idle_driver, cpu_online_mask);
+}
-- 
1.8.2.3


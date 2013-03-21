From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/4] cpuidle / omap4 : use CPUIDLE_FLAG_TIMER_STOP flag
Date: Thu, 21 Mar 2013 13:21:32 +0100
Message-ID: <1363868494-5503-2-git-send-email-daniel.lezcano@linaro.org>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:65076 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757595Ab3CUMVj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 08:21:39 -0400
Received: by mail-wg0-f51.google.com with SMTP id 8so2141265wgl.6
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2013 05:21:38 -0700 (PDT)
In-Reply-To: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, lenb@kernel.org, linus.walleij@linaro.org, santosh.shilimkar@ti.com, rnayak@ti.com, kernel@pengutronix.de, tglx@linutronix.de

Use the CPUIDLE_FLAG_TIMER_STOP and let the cpuidle framework
to handle the CLOCK_EVT_NOTIFY_BROADCAST_ENTER/EXIT when entering
this state.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index d639aef..fe0e025 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -82,7 +82,6 @@ static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
 			int index)
 {
 	struct omap4_idle_statedata *cx = &omap4_idle_data[index];
-	int cpu_id = smp_processor_id();
 
 	local_fiq_disable();
 
@@ -109,8 +108,6 @@ static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
 		}
 	}
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu_id);
-
 	/*
 	 * Call idle CPU PM enter notifier chain so that
 	 * VFP and per CPU interrupt context is saved.
@@ -152,8 +149,6 @@ static int omap4_enter_idle_coupled(struct cpuidle_device *dev,
 	if (omap4_mpuss_read_prev_context_state())
 		cpu_cluster_pm_exit();
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu_id);
-
 fail:
 	cpuidle_coupled_parallel_barrier(dev, &abort_barrier);
 	cpu_done[dev->cpu] = false;
@@ -193,7 +188,8 @@ static struct cpuidle_driver omap4_idle_driver = {
 			/* C2 - CPU0 OFF + CPU1 OFF + MPU CSWR */
 			.exit_latency = 328 + 440,
 			.target_residency = 960,
-			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
+			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
+			         CPUIDLE_FLAG_TIMER_STOP,
 			.enter = omap4_enter_idle_coupled,
 			.name = "C2",
 			.desc = "MPUSS CSWR",
@@ -202,7 +198,8 @@ static struct cpuidle_driver omap4_idle_driver = {
 			/* C3 - CPU0 OFF + CPU1 OFF + MPU OSWR */
 			.exit_latency = 460 + 518,
 			.target_residency = 1100,
-			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED,
+			.flags = CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_COUPLED |
+			         CPUIDLE_FLAG_TIMER_STOP,
 			.enter = omap4_enter_idle_coupled,
 			.name = "C3",
 			.desc = "MPUSS OSWR",
-- 
1.7.9.5


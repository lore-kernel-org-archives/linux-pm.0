From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/5] cpuidle: OMAP4: remove timer broadcast initialization
Date: Wed, 27 Mar 2013 11:22:12 +0100
Message-ID: <1364379733-23725-4-git-send-email-daniel.lezcano@linaro.org>
References: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:51441 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab3C0KWZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 06:22:25 -0400
Received: by mail-we0-f169.google.com with SMTP id x43so2748587wey.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2013 03:22:24 -0700 (PDT)
In-Reply-To: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: tglx@linutronix.de, linus.walleij@linaro.org, kernel@pengutronix.de, santosh.shilimkar@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org

The initialization is done from the cpuidle framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/cpuidle44xx.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle44xx.c b/arch/arm/mach-omap2/cpuidle44xx.c
index fe0e025..f4b1b23 100644
--- a/arch/arm/mach-omap2/cpuidle44xx.c
+++ b/arch/arm/mach-omap2/cpuidle44xx.c
@@ -14,7 +14,6 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/export.h>
-#include <linux/clockchips.h>
 
 #include <asm/proc-fns.h>
 
@@ -158,16 +157,6 @@ fail:
 	return index;
 }
 
-/*
- * For each cpu, setup the broadcast timer because local timers
- * stops for the states above C1.
- */
-static void omap_setup_broadcast_timer(void *arg)
-{
-	int cpu = smp_processor_id();
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
-}
-
 static DEFINE_PER_CPU(struct cpuidle_device, omap4_idle_dev);
 
 static struct cpuidle_driver omap4_idle_driver = {
@@ -233,9 +222,6 @@ int __init omap4_idle_init(void)
 	if (!cpu_clkdm[0] || !cpu_clkdm[1])
 		return -ENODEV;
 
-	/* Configure the broadcast timer on each cpu */
-	on_each_cpu(omap_setup_broadcast_timer, NULL, 1);
-
 	for_each_cpu(cpu_id, cpu_online_mask) {
 		dev = &per_cpu(omap4_idle_dev, cpu_id);
 		dev->cpu = cpu_id;
-- 
1.7.9.5


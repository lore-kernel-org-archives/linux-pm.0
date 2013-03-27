From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/5] cpuidle: ux500: remove timer broadcast initialization
Date: Wed, 27 Mar 2013 11:22:11 +0100
Message-ID: <1364379733-23725-3-git-send-email-daniel.lezcano@linaro.org>
References: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:58332 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab3C0KWY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 06:22:24 -0400
Received: by mail-wi0-f169.google.com with SMTP id c10so2131062wiw.2
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2013 03:22:22 -0700 (PDT)
In-Reply-To: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: tglx@linutronix.de, linus.walleij@linaro.org, kernel@pengutronix.de, santosh.shilimkar@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org

The initialization is done from the cpuidle framework.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-ux500/cpuidle.c |   18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index 6d0c4b6..1b16d9e 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -11,7 +11,6 @@
 
 #include <linux/module.h>
 #include <linux/cpuidle.h>
-#include <linux/clockchips.h>
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/smp.h>
@@ -112,16 +111,6 @@ static struct cpuidle_driver ux500_idle_driver = {
 	.state_count = 2,
 };
 
-/*
- * For each cpu, setup the broadcast timer because we will
- * need to migrate the timers for the states >= ApIdle.
- */
-static void ux500_setup_broadcast_timer(void *arg)
-{
-	int cpu = smp_processor_id();
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
-}
-
 int __init ux500_idle_init(void)
 {
 	int ret, cpu;
@@ -131,13 +120,6 @@ int __init ux500_idle_init(void)
 	prcmu_enable_wakeups(PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
 			     PRCMU_WAKEUP(ABB));
 
-	/*
-	 * Configure the timer broadcast for each cpu, that must
-	 * be done from the cpu context, so we use a smp cross
-	 * call with 'on_each_cpu'.
-	 */
-	on_each_cpu(ux500_setup_broadcast_timer, NULL, 1);
-
 	ret = cpuidle_register_driver(&ux500_idle_driver);
 	if (ret) {
 		printk(KERN_ERR "failed to register ux500 idle driver\n");
-- 
1.7.9.5


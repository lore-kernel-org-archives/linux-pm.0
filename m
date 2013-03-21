From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 3/4] cpuidle / imx6 : use CPUIDLE_FLAG_TIMER_STOP flag
Date: Thu, 21 Mar 2013 13:21:33 +0100
Message-ID: <1363868494-5503-3-git-send-email-daniel.lezcano@linaro.org>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:63500 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699Ab3CUMVn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 08:21:43 -0400
Received: by mail-wg0-f50.google.com with SMTP id es5so2140463wgb.17
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2013 05:21:42 -0700 (PDT)
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
 arch/arm/mach-imx/cpuidle-imx6q.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index d533e26..5ae22f7 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -21,10 +21,6 @@ static DEFINE_SPINLOCK(master_lock);
 static int imx6q_enter_wait(struct cpuidle_device *dev,
 			    struct cpuidle_driver *drv, int index)
 {
-	int cpu = dev->cpu;
-
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
-
 	if (atomic_inc_return(&master) == num_online_cpus()) {
 		/*
 		 * With this lock, we prevent other cpu to exit and enter
@@ -43,7 +39,6 @@ idle:
 	cpu_do_idle();
 done:
 	atomic_dec(&master);
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
 
 	return index;
 }
@@ -70,7 +65,8 @@ static struct cpuidle_driver imx6q_cpuidle_driver = {
 		{
 			.exit_latency = 50,
 			.target_residency = 75,
-			.flags = CPUIDLE_FLAG_TIME_VALID,
+			.flags = CPUIDLE_FLAG_TIME_VALID |
+			         CPUIDLE_FLAG_TIMER_STOP,
 			.enter = imx6q_enter_wait,
 			.name = "WAIT",
 			.desc = "Clock off",
-- 
1.7.9.5


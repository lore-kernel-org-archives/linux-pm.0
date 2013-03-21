From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 4/4] cpuidle / ux500 : use CPUIDLE_FLAG_TIMER_STOP flag
Date: Thu, 21 Mar 2013 13:21:34 +0100
Message-ID: <1363868494-5503-4-git-send-email-daniel.lezcano@linaro.org>
References: <1363868494-5503-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:37614 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757967Ab3CUMVp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Mar 2013 08:21:45 -0400
Received: by mail-wg0-f52.google.com with SMTP id 15so2138032wgd.31
        for <linux-pm@vger.kernel.org>; Thu, 21 Mar 2013 05:21:44 -0700 (PDT)
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
 arch/arm/mach-ux500/cpuidle.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index ce91493..6d0c4b6 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -30,8 +30,6 @@ static inline int ux500_enter_idle(struct cpuidle_device *dev,
 	int this_cpu = smp_processor_id();
 	bool recouple = false;
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &this_cpu);
-
 	if (atomic_inc_return(&master) == num_online_cpus()) {
 
 		/* With this lock, we prevent the other cpu to exit and enter
@@ -91,8 +89,6 @@ out:
 		spin_unlock(&master_lock);
 	}
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &this_cpu);
-
 	return index;
 }
 
@@ -106,7 +102,8 @@ static struct cpuidle_driver ux500_idle_driver = {
 			.enter		  = ux500_enter_idle,
 			.exit_latency	  = 70,
 			.target_residency = 260,
-			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID |
+			                    CPUIDLE_FLAG_TIMER_STOP,
 			.name		  = "ApIdle",
 			.desc		  = "ARM Retention",
 		},
-- 
1.7.9.5


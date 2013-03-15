From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [RFC patch 03/11] cpuidle / ux500 : use common ARM cpuidle driver
Date: Fri, 15 Mar 2013 15:27:02 +0100
Message-ID: <1363357630-22214-4-git-send-email-daniel.lezcano@linaro.org>
References: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37362 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab3COO1X (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Mar 2013 10:27:23 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so568354wib.4
        for <linux-pm@vger.kernel.org>; Fri, 15 Mar 2013 07:27:22 -0700 (PDT)
In-Reply-To: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, rjw@sisk.pl, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, andrew@lunn.ch

The ARM generic cpuidle driver handles the initialization and the
CPUIDLE_FLAG_TIMER_STOP allows the cpuidle framework to call clockevents_notify.

This patch removes the duplicated code and use the arm_idle_init function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-ux500/cpuidle.c |   56 +++--------------------------------------
 1 file changed, 3 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index ce91493..36bf4fd 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -22,7 +22,6 @@
 
 static atomic_t master = ATOMIC_INIT(0);
 static DEFINE_SPINLOCK(master_lock);
-static DEFINE_PER_CPU(struct cpuidle_device, ux500_cpuidle_device);
 
 static inline int ux500_enter_idle(struct cpuidle_device *dev,
 				   struct cpuidle_driver *drv, int index)
@@ -30,8 +29,6 @@ static inline int ux500_enter_idle(struct cpuidle_device *dev,
 	int this_cpu = smp_processor_id();
 	bool recouple = false;
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &this_cpu);
-
 	if (atomic_inc_return(&master) == num_online_cpus()) {
 
 		/* With this lock, we prevent the other cpu to exit and enter
@@ -91,8 +88,6 @@ out:
 		spin_unlock(&master_lock);
 	}
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &this_cpu);
-
 	return index;
 }
 
@@ -106,7 +101,8 @@ static struct cpuidle_driver ux500_idle_driver = {
 			.enter		  = ux500_enter_idle,
 			.exit_latency	  = 70,
 			.target_residency = 260,
-			.flags		  = CPUIDLE_FLAG_TIME_VALID,
+			.flags		  = CPUIDLE_FLAG_TIME_VALID |
+			CPUIDLE_FLAG_TIMER_STOP,
 			.name		  = "ApIdle",
 			.desc		  = "ARM Retention",
 		},
@@ -115,59 +111,13 @@ static struct cpuidle_driver ux500_idle_driver = {
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
-	int ret, cpu;
-	struct cpuidle_device *device;
-
         /* Configure wake up reasons */
 	prcmu_enable_wakeups(PRCMU_WAKEUP(ARM) | PRCMU_WAKEUP(RTC) |
 			     PRCMU_WAKEUP(ABB));
 
-	/*
-	 * Configure the timer broadcast for each cpu, that must
-	 * be done from the cpu context, so we use a smp cross
-	 * call with 'on_each_cpu'.
-	 */
-	on_each_cpu(ux500_setup_broadcast_timer, NULL, 1);
-
-	ret = cpuidle_register_driver(&ux500_idle_driver);
-	if (ret) {
-		printk(KERN_ERR "failed to register ux500 idle driver\n");
-		return ret;
-	}
-
-	for_each_online_cpu(cpu) {
-		device = &per_cpu(ux500_cpuidle_device, cpu);
-		device->cpu = cpu;
-		ret = cpuidle_register_device(device);
-		if (ret) {
-			printk(KERN_ERR "Failed to register cpuidle "
-			       "device for cpu%d\n", cpu);
-			goto out_unregister;
-		}
-	}
-out:
-	return ret;
-
-out_unregister:
-	for_each_online_cpu(cpu) {
-		device = &per_cpu(ux500_cpuidle_device, cpu);
-		cpuidle_unregister_device(device);
-	}
-
-	cpuidle_unregister_driver(&ux500_idle_driver);
-	goto out;
+	return arm_idle_init(&ux500_idle_driver);
 }
 
 device_initcall(ux500_idle_init);
-- 
1.7.9.5


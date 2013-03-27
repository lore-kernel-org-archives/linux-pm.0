From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 2/5] cpuidle: initialize the broadcast timer framework
Date: Wed, 27 Mar 2013 11:22:10 +0100
Message-ID: <1364379733-23725-2-git-send-email-daniel.lezcano@linaro.org>
References: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:62634 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab3C0KWV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Mar 2013 06:22:21 -0400
Received: by mail-wg0-f41.google.com with SMTP id y10so316103wgg.0
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2013 03:22:20 -0700 (PDT)
In-Reply-To: <1364379733-23725-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: tglx@linutronix.de, linus.walleij@linaro.org, kernel@pengutronix.de, santosh.shilimkar@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org

The commit 89878baa73f0f1c679355006bd8632e5d78f96c2 introduced
the CPUIDLE_FLAG_TIMER_STOP flag where we specify a specific idle
state stops the local timer.

Now use this flag to check at init time if one state will need
the broadcast timer and, in this case, setup the broadcast timer
framework. That prevents multiple code duplication in the drivers.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/driver.c |   31 +++++++++++++++++++++++++++++--
 include/linux/cpuidle.h  |    2 ++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 422c7b6..8dfaaae 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -11,6 +11,8 @@
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/clockchips.h>
 
 #include "cpuidle.h"
 
@@ -19,9 +21,28 @@ DEFINE_SPINLOCK(cpuidle_driver_lock);
 static void __cpuidle_set_cpu_driver(struct cpuidle_driver *drv, int cpu);
 static struct cpuidle_driver * __cpuidle_get_cpu_driver(int cpu);
 
-static void __cpuidle_driver_init(struct cpuidle_driver *drv)
+static void cpuidle_setup_broadcast_timer(void *arg)
 {
+	int cpu = smp_processor_id();
+	clockevents_notify((long)(arg), &cpu);
+}
+
+static void __cpuidle_driver_init(struct cpuidle_driver *drv, int cpu)
+{
+	int i;
+
 	drv->refcnt = 0;
+
+	for (i = drv->state_count - 1; i >= 0 ; i--) {
+
+		if (!(drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP))
+			continue;
+
+		drv->bctimer = 1;
+		on_each_cpu_mask(get_cpu_mask(cpu), cpuidle_setup_broadcast_timer,
+				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON, 1);
+		break;
+	}
 }
 
 static int __cpuidle_register_driver(struct cpuidle_driver *drv, int cpu)
@@ -35,7 +56,7 @@ static int __cpuidle_register_driver(struct cpuidle_driver *drv, int cpu)
 	if (__cpuidle_get_cpu_driver(cpu))
 		return -EBUSY;
 
-	__cpuidle_driver_init(drv);
+	__cpuidle_driver_init(drv, cpu);
 
 	__cpuidle_set_cpu_driver(drv, cpu);
 
@@ -49,6 +70,12 @@ static void __cpuidle_unregister_driver(struct cpuidle_driver *drv, int cpu)
 
 	if (!WARN_ON(drv->refcnt > 0))
 		__cpuidle_set_cpu_driver(NULL, cpu);
+
+	if (drv->bctimer) {
+		drv->bctimer = 0;
+		on_each_cpu_mask(get_cpu_mask(cpu), cpuidle_setup_broadcast_timer,
+				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
+	}
 }
 
 #ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a837b33..fc3e580 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -107,6 +107,8 @@ struct cpuidle_driver {
 
 	/* set to 1 to use the core cpuidle time keeping (for all states). */
 	unsigned int		en_core_tk_irqen:1;
+        /* used by the cpuidle framework to setup the broadcast timer */
+	unsigned int            bctimer:1;
 	/* states array must be ordered in decreasing power consumption */
 	struct cpuidle_state	states[CPUIDLE_STATE_MAX];
 	int			state_count;
-- 
1.7.9.5


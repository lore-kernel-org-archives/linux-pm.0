From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [v2][PATCH 06/21] cpuidle: Use explicit broadcast control function
Date: Fri, 03 Apr 2015 02:02:18 +0200
Message-ID: <2106401.cYdJzzA6Ic@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan> <2186067.gb1n6y4Zoc@vostro.rjw.lan> <3410621.5uMny9y0B7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3410621.5uMny9y0B7@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Replace the clockevents_notify() call with an explicit function call.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpuidle/driver.c |   25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

Index: linux-pm/drivers/cpuidle/driver.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/driver.c
+++ linux-pm/drivers/cpuidle/driver.c
@@ -13,7 +13,7 @@
 #include <linux/sched.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
-#include <linux/clockchips.h>
+#include <linux/tick.h>
 
 #include "cpuidle.h"
 
@@ -130,21 +130,20 @@ static inline void __cpuidle_unset_drive
 #endif
 
 /**
- * cpuidle_setup_broadcast_timer - enable/disable the broadcast timer
+ * cpuidle_setup_broadcast_timer - enable/disable the broadcast timer on a cpu
  * @arg: a void pointer used to match the SMP cross call API
  *
- * @arg is used as a value of type 'long' with one of the two values:
- * - CLOCK_EVT_NOTIFY_BROADCAST_ON
- * - CLOCK_EVT_NOTIFY_BROADCAST_OFF
- *
- * Set the broadcast timer notification for the current CPU.  This function
- * is executed per CPU by an SMP cross call.  It not supposed to be called
- * directly.
+ * If @arg is NULL broadcast is disabled otherwise enabled
+ *
+ * This function is executed per CPU by an SMP cross call.  It's not
+ * supposed to be called directly.
  */
 static void cpuidle_setup_broadcast_timer(void *arg)
 {
-	int cpu = smp_processor_id();
-	clockevents_notify((long)(arg), &cpu);
+	if (arg)
+		tick_broadcast_enable();
+	else
+		tick_broadcast_disable();
 }
 
 /**
@@ -239,7 +238,7 @@ static int __cpuidle_register_driver(str
 
 	if (drv->bctimer)
 		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
-				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_ON, 1);
+				 (void *)1, 1);
 
 	poll_idle_init(drv);
 
@@ -263,7 +262,7 @@ static void __cpuidle_unregister_driver(
 	if (drv->bctimer) {
 		drv->bctimer = 0;
 		on_each_cpu_mask(drv->cpumask, cpuidle_setup_broadcast_timer,
-				 (void *)CLOCK_EVT_NOTIFY_BROADCAST_OFF, 1);
+				 NULL, 1);
 	}
 
 	__cpuidle_unset_driver(drv);

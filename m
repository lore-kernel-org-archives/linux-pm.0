From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 18/20]  clockevents: Make tick handover explicit
Date: Thu, 02 Apr 2015 00:24:04 +0200
Message-ID: <1889903.Zmz9h0EYfy@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

clockevents_notify() is a leftover from the early design of the
clockevents facility. It's really not a notification mechanism, it's a
multiplex call. We are way better off to have explicit calls instead of this
monstrosity.

Split out the tick_handover call and invoke it explicitely from the
hotplug code. Temporary solution will be cleaned up in later patches.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[ rjw: Rebase ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/clockchips.h  |    1 -
 include/linux/tick.h        |    2 ++
 kernel/cpu.c                |    3 +++
 kernel/time/clockevents.c   |    4 ----
 kernel/time/hrtimer.c       |    4 ----
 kernel/time/tick-common.c   |    9 ++++++---
 kernel/time/tick-internal.h |    1 -
 7 files changed, 11 insertions(+), 13 deletions(-)

Index: linux-pm/include/linux/clockchips.h
===================================================================
--- linux-pm.orig/include/linux/clockchips.h
+++ linux-pm/include/linux/clockchips.h
@@ -11,7 +11,6 @@
 /* Clock event notification values */
 enum clock_event_nofitiers {
 	CLOCK_EVT_NOTIFY_ADD,
-	CLOCK_EVT_NOTIFY_CPU_DYING,
 	CLOCK_EVT_NOTIFY_CPU_DEAD,
 };
 
Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -19,12 +19,14 @@ extern void tick_unfreeze(void);
 extern void tick_suspend_local(void);
 /* Should be core only, but XEN resume magic and ARM BL switcher require it */
 extern void tick_resume_local(void);
+extern void tick_handover_do_timer(void);
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
 static inline void tick_freeze(void) { }
 static inline void tick_unfreeze(void) { }
 static inline void tick_suspend_local(void) { }
 static inline void tick_resume_local(void) { }
+static inline void tick_handover_do_timer(void) { }
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
 
 #ifdef CONFIG_TICK_ONESHOT
Index: linux-pm/kernel/cpu.c
===================================================================
--- linux-pm.orig/kernel/cpu.c
+++ linux-pm/kernel/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/gfp.h>
 #include <linux/suspend.h>
 #include <linux/lockdep.h>
+#include <linux/tick.h>
 #include <trace/events/power.h>
 
 #include "smpboot.h"
@@ -338,6 +339,8 @@ static int __ref take_cpu_down(void *_pa
 		return err;
 
 	cpu_notify(CPU_DYING | param->mod, param->hcpu);
+	/* Give up timekeeping duties */
+	tick_handover_do_timer();
 	/* Park the stopper thread */
 	kthread_park(current);
 	return 0;
Index: linux-pm/kernel/time/clockevents.c
===================================================================
--- linux-pm.orig/kernel/time/clockevents.c
+++ linux-pm/kernel/time/clockevents.c
@@ -655,10 +655,6 @@ int clockevents_notify(unsigned long rea
 	raw_spin_lock_irqsave(&clockevents_lock, flags);
 
 	switch (reason) {
-	case CLOCK_EVT_NOTIFY_CPU_DYING:
-		tick_handover_do_timer(arg);
-		break;
-
 	case CLOCK_EVT_NOTIFY_CPU_DEAD:
 		tick_shutdown_broadcast_oneshot(arg);
 		tick_shutdown_broadcast(arg);
Index: linux-pm/kernel/time/hrtimer.c
===================================================================
--- linux-pm.orig/kernel/time/hrtimer.c
+++ linux-pm/kernel/time/hrtimer.c
@@ -1707,10 +1707,6 @@ static int hrtimer_cpu_notify(struct not
 		break;
 
 #ifdef CONFIG_HOTPLUG_CPU
-	case CPU_DYING:
-	case CPU_DYING_FROZEN:
-		clockevents_notify(CLOCK_EVT_NOTIFY_CPU_DYING, &scpu);
-		break;
 	case CPU_DEAD:
 	case CPU_DEAD_FROZEN:
 	{
Index: linux-pm/kernel/time/tick-common.c
===================================================================
--- linux-pm.orig/kernel/time/tick-common.c
+++ linux-pm/kernel/time/tick-common.c
@@ -332,20 +332,23 @@ out_bc:
 	tick_install_broadcast_device(newdev);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 /*
  * Transfer the do_timer job away from a dying cpu.
  *
- * Called with interrupts disabled.
+ * Called with interrupts disabled. Not locking required. If
+ * tick_do_timer_cpu is owned by this cpu, nothing can change it.
  */
-void tick_handover_do_timer(int *cpup)
+void tick_handover_do_timer(void)
 {
-	if (*cpup == tick_do_timer_cpu) {
+	if (tick_do_timer_cpu == smp_processor_id()) {
 		int cpu = cpumask_first(cpu_online_mask);
 
 		tick_do_timer_cpu = (cpu < nr_cpu_ids) ? cpu :
 			TICK_DO_TIMER_NONE;
 	}
 }
+#endif
 
 /*
  * Shutdown an event device on a given cpu:
Index: linux-pm/kernel/time/tick-internal.h
===================================================================
--- linux-pm.orig/kernel/time/tick-internal.h
+++ linux-pm/kernel/time/tick-internal.h
@@ -20,7 +20,6 @@ extern int tick_do_timer_cpu __read_most
 extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
 extern void tick_handle_periodic(struct clock_event_device *dev);
 extern void tick_check_new_device(struct clock_event_device *dev);
-extern void tick_handover_do_timer(int *cpup);
 extern void tick_shutdown(unsigned int *cpup);
 extern void tick_suspend(void);
 extern void tick_resume(void);


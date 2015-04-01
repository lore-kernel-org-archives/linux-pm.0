From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 19/20] clockevents: Cleanup dead cpu explicitely
Date: Thu, 02 Apr 2015 00:25:26 +0200
Message-ID: <2204028.umbiazfx9G@vostro.rjw.lan>
References: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64981 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752477AbbDAWDY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2015 18:03:24 -0400
In-Reply-To: <2112147.0kYCHhbEJT@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

clockevents_notify() is a leftover from the early design of the
clockevents facility. It's really not a notification mechanism, it's a
multiplex call. We are way better off to have explicit calls instead of this
monstrosity.

Split out the cleanup function for a dead cpu and invoke it directly
from the cpu down code. Make it conditional on CPU_HOTPLUG as well.

Temporary change, will be refined in the future.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[ rjw: Rebased, added clockevents_notify() removal ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/clockchips.h   |    6 -----
 include/linux/tick.h         |    2 +
 kernel/cpu.c                 |    1 
 kernel/time/clockevents.c    |   51 +++++++++++++++++--------------------------
 kernel/time/hrtimer.c        |    3 --
 kernel/time/tick-broadcast.c |   29 ++++++++++++------------
 kernel/time/tick-common.c    |    6 ++---
 kernel/time/tick-internal.h  |   10 ++++----
 8 files changed, 47 insertions(+), 61 deletions(-)

Index: linux-pm/include/linux/clockchips.h
===================================================================
--- linux-pm.orig/include/linux/clockchips.h
+++ linux-pm/include/linux/clockchips.h
@@ -8,12 +8,6 @@
 #ifndef _LINUX_CLOCKCHIPS_H
 #define _LINUX_CLOCKCHIPS_H
 
-/* Clock event notification values */
-enum clock_event_nofitiers {
-	CLOCK_EVT_NOTIFY_ADD,
-	CLOCK_EVT_NOTIFY_CPU_DEAD,
-};
-
 #ifdef CONFIG_GENERIC_CLOCKEVENTS
 
 #include <linux/clocksource.h>
Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -20,6 +20,7 @@ extern void tick_suspend_local(void);
 /* Should be core only, but XEN resume magic and ARM BL switcher require it */
 extern void tick_resume_local(void);
 extern void tick_handover_do_timer(void);
+extern void tick_cleanup_dead_cpu(int cpu);
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
 static inline void tick_freeze(void) { }
@@ -27,6 +28,7 @@ static inline void tick_unfreeze(void) {
 static inline void tick_suspend_local(void) { }
 static inline void tick_resume_local(void) { }
 static inline void tick_handover_do_timer(void) { }
+static inline void tick_cleanup_dead_cpu(int cpu) { }
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
 
 #ifdef CONFIG_TICK_ONESHOT
Index: linux-pm/kernel/cpu.c
===================================================================
--- linux-pm.orig/kernel/cpu.c
+++ linux-pm/kernel/cpu.c
@@ -418,6 +418,7 @@ static int __ref _cpu_down(unsigned int
 	__cpu_die(cpu);
 
 	/* CPU is completely dead: tell everyone.  Too late to complain. */
+	tick_cleanup_dead_cpu(cpu);
 	cpu_notify_nofail(CPU_DEAD | mod, hcpu);
 
 	check_for_tasks(cpu);
Index: linux-pm/kernel/time/clockevents.c
===================================================================
--- linux-pm.orig/kernel/time/clockevents.c
+++ linux-pm/kernel/time/clockevents.c
@@ -642,49 +642,40 @@ void clockevents_resume(void)
 			dev->resume(dev);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 /**
- * clockevents_notify - notification about relevant events
- * Returns 0 on success, any other value on error
+ * tick_cleanup_dead_cpu - Cleanup the tick and clockevents of a dead cpu
  */
-int clockevents_notify(unsigned long reason, void *arg)
+void tick_cleanup_dead_cpu(int cpu)
 {
 	struct clock_event_device *dev, *tmp;
 	unsigned long flags;
-	int cpu, ret = 0;
 
 	raw_spin_lock_irqsave(&clockevents_lock, flags);
 
-	switch (reason) {
-	case CLOCK_EVT_NOTIFY_CPU_DEAD:
-		tick_shutdown_broadcast_oneshot(arg);
-		tick_shutdown_broadcast(arg);
-		tick_shutdown(arg);
-		/*
-		 * Unregister the clock event devices which were
-		 * released from the users in the notify chain.
-		 */
-		list_for_each_entry_safe(dev, tmp, &clockevents_released, list)
+	tick_shutdown_broadcast_oneshot(cpu);
+	tick_shutdown_broadcast(cpu);
+	tick_shutdown(cpu);
+	/*
+	 * Unregister the clock event devices which were
+	 * released from the users in the notify chain.
+	 */
+	list_for_each_entry_safe(dev, tmp, &clockevents_released, list)
+		list_del(&dev->list);
+	/*
+	 * Now check whether the CPU has left unused per cpu devices
+	 */
+	list_for_each_entry_safe(dev, tmp, &clockevent_devices, list) {
+		if (cpumask_test_cpu(cpu, dev->cpumask) &&
+		    cpumask_weight(dev->cpumask) == 1 &&
+		    !tick_is_broadcast_device(dev)) {
+			BUG_ON(dev->state != CLOCK_EVT_STATE_DETACHED);
 			list_del(&dev->list);
-		/*
-		 * Now check whether the CPU has left unused per cpu devices
-		 */
-		cpu = *((int *)arg);
-		list_for_each_entry_safe(dev, tmp, &clockevent_devices, list) {
-			if (cpumask_test_cpu(cpu, dev->cpumask) &&
-			    cpumask_weight(dev->cpumask) == 1 &&
-			    !tick_is_broadcast_device(dev)) {
-				BUG_ON(dev->state != CLOCK_EVT_STATE_DETACHED);
-				list_del(&dev->list);
-			}
 		}
-		break;
-	default:
-		break;
 	}
 	raw_spin_unlock_irqrestore(&clockevents_lock, flags);
-	return ret;
 }
-EXPORT_SYMBOL_GPL(clockevents_notify);
+#endif
 
 #ifdef CONFIG_SYSFS
 struct bus_type clockevents_subsys = {
Index: linux-pm/kernel/time/hrtimer.c
===================================================================
--- linux-pm.orig/kernel/time/hrtimer.c
+++ linux-pm/kernel/time/hrtimer.c
@@ -1709,11 +1709,8 @@ static int hrtimer_cpu_notify(struct not
 #ifdef CONFIG_HOTPLUG_CPU
 	case CPU_DEAD:
 	case CPU_DEAD_FROZEN:
-	{
-		clockevents_notify(CLOCK_EVT_NOTIFY_CPU_DEAD, &scpu);
 		migrate_hrtimers(scpu);
 		break;
-	}
 #endif
 
 	default:
Index: linux-pm/kernel/time/tick-broadcast.c
===================================================================
--- linux-pm.orig/kernel/time/tick-broadcast.c
+++ linux-pm/kernel/time/tick-broadcast.c
@@ -410,14 +410,14 @@ void tick_set_periodic_handler(struct cl
 		dev->event_handler = tick_handle_periodic_broadcast;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 /*
  * Remove a CPU from broadcasting
  */
-void tick_shutdown_broadcast(unsigned int *cpup)
+void tick_shutdown_broadcast(unsigned int cpu)
 {
 	struct clock_event_device *bc;
 	unsigned long flags;
-	unsigned int cpu = *cpup;
 
 	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
 
@@ -432,6 +432,7 @@ void tick_shutdown_broadcast(unsigned in
 
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
+#endif
 
 void tick_suspend_broadcast(void)
 {
@@ -672,16 +673,6 @@ static void broadcast_shutdown_local(str
 	clockevents_set_state(dev, CLOCK_EVT_STATE_SHUTDOWN);
 }
 
-static void broadcast_move_bc(int deadcpu)
-{
-	struct clock_event_device *bc = tick_broadcast_device.evtdev;
-
-	if (!bc || !broadcast_needs_cpu(bc, deadcpu))
-		return;
-	/* This moves the broadcast assignment to this cpu */
-	clockevents_program_event(bc, bc->next_event, 1);
-}
-
 /**
  * tick_broadcast_oneshot_control - Enter/exit broadcast oneshot mode
  * @state:	The target state (enter/exit)
@@ -903,14 +894,23 @@ void tick_broadcast_switch_to_oneshot(vo
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static void broadcast_move_bc(int deadcpu)
+{
+	struct clock_event_device *bc = tick_broadcast_device.evtdev;
+
+	if (!bc || !broadcast_needs_cpu(bc, deadcpu))
+		return;
+	/* This moves the broadcast assignment to this cpu */
+	clockevents_program_event(bc, bc->next_event, 1);
+}
 
 /*
  * Remove a dead CPU from broadcasting
  */
-void tick_shutdown_broadcast_oneshot(unsigned int *cpup)
+void tick_shutdown_broadcast_oneshot(unsigned int cpu)
 {
 	unsigned long flags;
-	unsigned int cpu = *cpup;
 
 	raw_spin_lock_irqsave(&tick_broadcast_lock, flags);
 
@@ -926,6 +926,7 @@ void tick_shutdown_broadcast_oneshot(uns
 
 	raw_spin_unlock_irqrestore(&tick_broadcast_lock, flags);
 }
+#endif
 
 /*
  * Check, whether the broadcast device is in one shot mode
Index: linux-pm/kernel/time/tick-common.c
===================================================================
--- linux-pm.orig/kernel/time/tick-common.c
+++ linux-pm/kernel/time/tick-common.c
@@ -348,7 +348,6 @@ void tick_handover_do_timer(void)
 			TICK_DO_TIMER_NONE;
 	}
 }
-#endif
 
 /*
  * Shutdown an event device on a given cpu:
@@ -357,9 +356,9 @@ void tick_handover_do_timer(void)
  * access the hardware device itself.
  * We just set the mode and remove it from the lists.
  */
-void tick_shutdown(unsigned int *cpup)
+void tick_shutdown(unsigned int cpu)
 {
-	struct tick_device *td = &per_cpu(tick_cpu_device, *cpup);
+	struct tick_device *td = &per_cpu(tick_cpu_device, cpu);
 	struct clock_event_device *dev = td->evtdev;
 
 	td->mode = TICKDEV_MODE_PERIODIC;
@@ -375,6 +374,7 @@ void tick_shutdown(unsigned int *cpup)
 		td->evtdev = NULL;
 	}
 }
+#endif
 
 /**
  * tick_suspend_local - Suspend the local tick device
Index: linux-pm/kernel/time/tick-internal.h
===================================================================
--- linux-pm.orig/kernel/time/tick-internal.h
+++ linux-pm/kernel/time/tick-internal.h
@@ -20,7 +20,7 @@ extern int tick_do_timer_cpu __read_most
 extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
 extern void tick_handle_periodic(struct clock_event_device *dev);
 extern void tick_check_new_device(struct clock_event_device *dev);
-extern void tick_shutdown(unsigned int *cpup);
+extern void tick_shutdown(unsigned int cpu);
 extern void tick_suspend(void);
 extern void tick_resume(void);
 extern bool tick_check_replacement(struct clock_event_device *curdev,
@@ -84,7 +84,7 @@ static inline int tick_check_oneshot_cha
 extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
 extern void tick_install_broadcast_device(struct clock_event_device *dev);
 extern int tick_is_broadcast_device(struct clock_event_device *dev);
-extern void tick_shutdown_broadcast(unsigned int *cpup);
+extern void tick_shutdown_broadcast(unsigned int cpu);
 extern void tick_suspend_broadcast(void);
 extern void tick_resume_broadcast(void);
 extern bool tick_resume_check_broadcast(void);
@@ -98,7 +98,7 @@ static inline void tick_install_broadcas
 static inline int tick_is_broadcast_device(struct clock_event_device *dev) { return 0; }
 static inline int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu) { return 0; }
 static inline void tick_do_periodic_broadcast(struct clock_event_device *d) { }
-static inline void tick_shutdown_broadcast(unsigned int *cpup) { }
+static inline void tick_shutdown_broadcast(unsigned int cpu) { }
 static inline void tick_suspend_broadcast(void) { }
 static inline void tick_resume_broadcast(void) { }
 static inline bool tick_resume_check_broadcast(void) { return false; }
@@ -118,7 +118,7 @@ static inline void tick_set_periodic_han
 #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_TICK_ONESHOT)
 extern void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
 extern void tick_broadcast_switch_to_oneshot(void);
-extern void tick_shutdown_broadcast_oneshot(unsigned int *cpup);
+extern void tick_shutdown_broadcast_oneshot(unsigned int cpu);
 extern int tick_broadcast_oneshot_active(void);
 extern void tick_check_oneshot_broadcast_this_cpu(void);
 bool tick_broadcast_oneshot_available(void);
@@ -126,7 +126,7 @@ extern struct cpumask *tick_get_broadcas
 #else /* BROADCAST && ONESHOT */
 static inline void tick_broadcast_setup_oneshot(struct clock_event_device *bc) { BUG(); }
 static inline void tick_broadcast_switch_to_oneshot(void) { }
-static inline void tick_shutdown_broadcast_oneshot(unsigned int *cpup) { }
+static inline void tick_shutdown_broadcast_oneshot(unsigned int cpu) { }
 static inline int tick_broadcast_oneshot_active(void) { return 0; }
 static inline void tick_check_oneshot_broadcast_this_cpu(void) { }
 static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_possible(); }


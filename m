From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update][PATCH 4/6 v2] PM / sleep: Make it possible to quiesce timers during suspend-to-idle
Date: Thu, 12 Feb 2015 23:36:42 +0100
Message-ID: <1735177.ictnQBr1LP@vostro.rjw.lan>
References: <8292243.ibkmfVtXac@vostro.rjw.lan> <3761728.YL7DDdWRW2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56053 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750959AbbBLWNi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 12 Feb 2015 17:13:38 -0500
In-Reply-To: <3761728.YL7DDdWRW2@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The efficiency of suspend-to-idle depends on being able to keep CPUs
in the deepest available idle states for as much time as possible.
Ideally, they should only be brought out of idle by system wakeup
interrupts.

However, timer interrupts occurring periodically prevent that from
happening and it is not practical to chase all of the "misbehaving"
timers in a whack-a-mole fashion.  A much more effective approach is
to suspend the local ticks for all CPUs and the entire timekeeping
along the lines of what is done during full suspend, which also
helps to keep suspend-to-idle and full suspend reasonably similar.

The idea is to suspend the local tick on each CPU executing
cpuidle_enter_freeze() and to make the last of them suspend the
entire timekeeping.  That should prevent timer interrupts from
triggering until an IO interrupt wakes up one of the CPUs.  It
needs to be done with interrupts disabled on all of the CPUs,
though, because otherwise the suspended clocksource might be
accessed by an interrupt handler which might lead to fatal
consequences.

Unfortunately, the existing ->enter callbacks provided by cpuidle
drivers generally cannot be used for implementing that, because some
of them re-enable interrupts temporarily and some idle entry methods
cause interrupts to be re-enabled automatically on exit.  Also some
of these callbacks manipulate local clock event devices of the CPUs
which really shouldn't be done after suspending their ticks.

To overcome that difficulty, introduce a new cpuidle state callback,
->enter_freeze, that will be guaranteed (1) to keep interrupts
disabled all the time (and return with interrupts disabled) and (2)
not to touch the CPU timer devices.  Modify cpuidle_enter_freeze() to
look for the deepest available idle state with ->enter_freeze present
and to make the CPU execute that callback with suspended tick (and the
last of the online CPUs to execute it with suspended timekeeping).

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
 - Add WARN_ON(!irqs_disabled()) to enter_freeze_proper(),
 - add a comment about ->enter_freeze requirements to the definition
   of struct cpuidle_state in cpuidle.h.

---
 drivers/cpuidle/cpuidle.c |   49 ++++++++++++++++++++++++++++++++++++++++-----
 include/linux/cpuidle.h   |    9 ++++++++
 include/linux/tick.h      |    2 +
 kernel/time/tick-common.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/time/timekeeping.c |    4 +--
 kernel/time/timekeeping.h |    2 +
 6 files changed, 109 insertions(+), 7 deletions(-)

Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -226,5 +226,7 @@ static inline void tick_nohz_task_switch
 		__tick_nohz_task_switch(tsk);
 }
 
+extern void tick_freeze(void);
+extern void tick_unfreeze(void);
 
 #endif
Index: linux-pm/kernel/time/tick-common.c
===================================================================
--- linux-pm.orig/kernel/time/tick-common.c
+++ linux-pm/kernel/time/tick-common.c
@@ -394,6 +394,56 @@ void tick_resume(void)
 	}
 }
 
+static DEFINE_RAW_SPINLOCK(tick_freeze_lock);
+static unsigned int tick_freeze_depth;
+
+/**
+ * tick_freeze - Suspend the local tick and (possibly) timekeeping.
+ *
+ * Check if this is the last online CPU executing the function and if so,
+ * suspend timekeeping.  Otherwise suspend the local tick.
+ *
+ * Call with interrupts disabled.  Must be balanced with %tick_unfreeze().
+ * Interrupts must not be enabled before the subsequent %tick_unfreeze().
+ */
+void tick_freeze(void)
+{
+	raw_spin_lock(&tick_freeze_lock);
+
+	tick_freeze_depth++;
+	if (tick_freeze_depth == num_online_cpus()) {
+		timekeeping_suspend();
+	} else {
+		tick_suspend();
+		tick_suspend_broadcast();
+	}
+
+	raw_spin_unlock(&tick_freeze_lock);
+}
+
+/**
+ * tick_unfreeze - Resume the local tick and (possibly) timekeeping.
+ *
+ * Check if this is the first CPU executing the function and if so, resume
+ * timekeeping.  Otherwise resume the local tick.
+ *
+ * Call with interrupts disabled.  Must be balanced with %tick_freeze().
+ * Interrupts must not be enabled after the preceding %tick_freeze().
+ */
+void tick_unfreeze(void)
+{
+	raw_spin_lock(&tick_freeze_lock);
+
+	if (tick_freeze_depth == num_online_cpus())
+		timekeeping_resume();
+	else
+		tick_resume();
+
+	tick_freeze_depth--;
+
+	raw_spin_unlock(&tick_freeze_lock);
+}
+
 /**
  * tick_init - initialize the tick control
  */
Index: linux-pm/kernel/time/timekeeping.h
===================================================================
--- linux-pm.orig/kernel/time/timekeeping.h
+++ linux-pm/kernel/time/timekeeping.h
@@ -16,5 +16,7 @@ extern int timekeeping_inject_offset(str
 extern s32 timekeeping_get_tai_offset(void);
 extern void timekeeping_set_tai_offset(s32 tai_offset);
 extern void timekeeping_clocktai(struct timespec *ts);
+extern int timekeeping_suspend(void);
+extern void timekeeping_resume(void);
 
 #endif
Index: linux-pm/kernel/time/timekeeping.c
===================================================================
--- linux-pm.orig/kernel/time/timekeeping.c
+++ linux-pm/kernel/time/timekeeping.c
@@ -1168,7 +1168,7 @@ void timekeeping_inject_sleeptime64(stru
  * xtime/wall_to_monotonic/jiffies/etc are
  * still managed by arch specific suspend/resume code.
  */
-static void timekeeping_resume(void)
+void timekeeping_resume(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *clock = tk->tkr.clock;
@@ -1262,7 +1262,7 @@ static cycle_t dummy_clock_read(struct c
 	return cycles_at_suspend;
 }
 
-static int timekeeping_suspend(void)
+int timekeeping_suspend(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *clock = tk->tkr.clock;
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -50,6 +50,15 @@ struct cpuidle_state {
 			int index);
 
 	int (*enter_dead) (struct cpuidle_device *dev, int index);
+
+	/*
+	 * CPUs execute ->enter_freeze with the local tick or entire timekeeping
+	 * suspended, so it must not re-enable interrupts at any point (even
+	 * temporarily) or attempt to change states of clock event devices.
+	 */
+	void (*enter_freeze) (struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv,
+			      int index);
 };
 
 /* Idle State Flags */
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -20,6 +20,7 @@
 #include <linux/hrtimer.h>
 #include <linux/module.h>
 #include <linux/suspend.h>
+#include <linux/tick.h>
 #include <trace/events/power.h>
 
 #include "cpuidle.h"
@@ -69,18 +70,20 @@ int cpuidle_play_dead(void)
  * cpuidle_find_deepest_state - Find deepest state meeting specific conditions.
  * @drv: cpuidle driver for the given CPU.
  * @dev: cpuidle device for the given CPU.
+ * @freeze: Whether or not the state should be suitable for suspend-to-idle.
  */
 static int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
-				      struct cpuidle_device *dev)
+				      struct cpuidle_device *dev, bool freeze)
 {
 	unsigned int latency_req = 0;
-	int i, ret = CPUIDLE_DRIVER_STATE_START - 1;
+	int i, ret = freeze ? -1 : CPUIDLE_DRIVER_STATE_START - 1;
 
 	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
 		struct cpuidle_state *s = &drv->states[i];
 		struct cpuidle_state_usage *su = &dev->states_usage[i];
 
-		if (s->disabled || su->disable || s->exit_latency <= latency_req)
+		if (s->disabled || su->disable || s->exit_latency <= latency_req
+		    || (freeze && !s->enter_freeze))
 			continue;
 
 		latency_req = s->exit_latency;
@@ -89,10 +92,31 @@ static int cpuidle_find_deepest_state(st
 	return ret;
 }
 
+static void enter_freeze_proper(struct cpuidle_driver *drv,
+				struct cpuidle_device *dev, int index)
+{
+	tick_freeze();
+	/*
+	 * The state used here cannot be a "coupled" one, because the "coupled"
+	 * cpuidle mechanism enables interrupts and doing that with timekeeping
+	 * suspended is generally unsafe.
+	 */
+	drv->states[index].enter_freeze(dev, drv, index);
+	WARN_ON(!irqs_disabled());
+	/*
+	 * timekeeping_resume() that will be called by tick_unfreeze() for the
+	 * last CPU executing it calls functions containing RCU read-side
+	 * critical sections, so tell RCU about that.
+	 */
+	RCU_NONIDLE(tick_unfreeze());
+}
+
 /**
  * cpuidle_enter_freeze - Enter an idle state suitable for suspend-to-idle.
  *
- * Find the deepest state available and enter it.
+ * If there are states with the ->enter_freeze callback, find the deepest of
+ * them and enter it with frozen tick.  Otherwise, find the deepest state
+ * available and enter it normally.
  */
 void cpuidle_enter_freeze(void)
 {
@@ -100,7 +124,22 @@ void cpuidle_enter_freeze(void)
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int index;
 
-	index = cpuidle_find_deepest_state(drv, dev);
+	/*
+	 * Find the deepest state with ->enter_freeze present, which guarantees
+	 * that interrupts won't be enabled when it exits and allows the tick to
+	 * be frozen safely.
+	 */
+	index = cpuidle_find_deepest_state(drv, dev, true);
+	if (index >= 0) {
+		enter_freeze_proper(drv, dev, index);
+		return;
+	}
+
+	/*
+	 * It is not safe to freeze the tick, find the deepest state available
+	 * at all and try to enter it normally.
+	 */
+	index = cpuidle_find_deepest_state(drv, dev, false);
 	if (index >= 0)
 		cpuidle_enter(drv, dev, index);
 	else


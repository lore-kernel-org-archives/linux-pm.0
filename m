From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update] Re: [PATCH v3]PM/Sleep: Timer quiesce in freeze state
Date: Fri, 06 Feb 2015 02:20:13 +0100
Message-ID: <2439333.L8nfGI3YZp@vostro.rjw.lan>
References: <54866625.8010406@linux.intel.com> <alpine.DEB.2.11.1501260946390.5526@nanos> <16564156.c5NBzjJuA3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63718 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751178AbbBFA5Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Feb 2015 19:57:16 -0500
In-Reply-To: <16564156.c5NBzjJuA3@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Li, Aubrey" <aubrey.li@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "Brown, Len" <len.brown@intel.com>, Alan Cox <alan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>


On Thursday, January 29, 2015 11:20:10 PM Rafael J. Wysocki wrote:
> On Monday, January 26, 2015 10:40:24 AM Thomas Gleixner wrote:
> > On Mon, 26 Jan 2015, Li, Aubrey wrote:
> > > On 2015/1/22 18:15, Thomas Gleixner wrote:

[cut]

> > 
> > You need to make sure in the low level idle implementation that this
> > cannot happen.
> > 
> > tick_freeze()
> > {
> > 	raw_spin_lock(&tick_freeze_lock);
> > 	tick_frozen++;
> > 	if (tick_frozen == num_online_cpus())
> > 		timekeeping_suspend();
> > 	else
> > 		tick_suspend_local();
> > 	raw_spin_unlock(&tick_freeze_lock);
> > }
> > 
> > tick_unfreeze()
> > {
> > 	raw_spin_lock(&tick_freeze_lock);
> > 	if (tick_frozen == num_online_cpus())
> > 		timekeeping_resume();
> > 	else
> > 		tick_resume_local();
> > 	tick_frozen--;
> > 	raw_spin_unlock(&tick_freeze_lock);
> > }
> > 
> > idle_freeze()
> > {
> > 	local_irq_disable();
> > 
> > 	tick_freeze();
> > 
> > 	/* Must keep interrupts disabled! */
> >        	go_deep_idle()
> > 
> > 	tick_unfreeze();
> > 
> > 	local_irq_enable();
> > }
> > 
> > That's the only way you can do it proper, everything else will just be
> > a horrible mess of bandaids and duct tape.
> > 
> > So that does not need any of the irq_enter/exit conditionals, it does
> > not need the real_handler hack. It just works.
> > 
> > The only remaining issue might be a NMI calling into
> > ktime_get_mono_fast_ns() before timekeeping is resumed. Its probably a
> > non issue on x86/tsc, but it might be a problem on other platforms
> > which turn off devices, clocks, It's not rocket science to prevent
> > that.
> 
> So the patch below is my version of the $subject one trying to take the
> above suggestion into account.  It doesn not address the ktime_get_mono_fast_ns()
> in NMI case at this stage, because quite frankly I'd prefer to get the core
> changes right in the first place.
> 
> The new ->enter_freeze callback is there in struct cpuidle_state, because we
> generally cannot trust the existing ->enter callbacks to keep interrupts
> disabled all the time.  Some of them enable interrupts temporarily and
> some idle entry methods enable interrupts automatically on exit.  So
> ->enter_freeze is required to keep interrupts disabled and it is safe to
> suspend/resume timekeeping around it.
> 
> The rest is reasonably straightforward.  If suspend-to-idle is requested,
> couidle_idle_call() calls cpuidle_enter_freeze() that bypasses the governor
> and selects the deepest suitable state.  If ->enter_freeze is available,
> it will be used along with tick_freeze()/tick_unfreeze() and the normal
> idle entry code path will be used otherwise.

In the meantime I learned how to tell RCU that it actually should track stuff
inside of the idle loop, so cpuidle_enter_freeze() can go under the
rcu_idle_enter/exit() now which makes it look more like "real" idle.

Also I noticed that freeze_enter() could lose a wakeup event if it happened
between dpm_suspend_noirq() and the point where suspend_freeze_state is set,
so that race should be closed now.

In my testing (with a hacked ACPI cpuidle driver) I get a number of wakeups
(usually no more than 30) in enter_freeze_proper() per suspend-to-idle cycle,
but that number doesn't seem to depend on the length of sleep, so my theory
is that this happens early until things relax sufficiently.

ktime_get_mono_fast_ns() is not covered yet, but I'm going to get to that next.

The current patch is appended, please let me know what you think.


---
 drivers/cpuidle/cpuidle.c |   88 ++++++++++++++++++++++++++++++++--------------
 include/linux/cpuidle.h   |    8 +++-
 include/linux/suspend.h   |    2 +
 include/linux/tick.h      |    2 +
 kernel/power/suspend.c    |   55 +++++++++++++++++++++++++---
 kernel/sched/idle.c       |    7 +++
 kernel/time/tick-common.c |   50 ++++++++++++++++++++++++++
 kernel/time/timekeeping.c |    4 +-
 kernel/time/timekeeping.h |    2 +
 9 files changed, 181 insertions(+), 37 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -37,7 +37,21 @@ const char *pm_states[PM_SUSPEND_MAX];
 static const struct platform_suspend_ops *suspend_ops;
 static const struct platform_freeze_ops *freeze_ops;
 static DECLARE_WAIT_QUEUE_HEAD(suspend_freeze_wait_head);
-static bool suspend_freeze_wake;
+
+/* Suspend-to-idle state machnine. */
+enum freeze_state {
+	FREEZE_STATE_NONE,      /* Not suspended/suspending. */
+	FREEZE_STATE_ENTER,     /* Enter suspend-to-idle. */
+	FREEZE_STATE_WAKE,      /* Wake up from suspend-to-idle. */
+};
+
+static enum freeze_state suspend_freeze_state;
+static DEFINE_SPINLOCK(suspend_freeze_lock);
+
+bool idle_should_freeze(void)
+{
+	return suspend_freeze_state == FREEZE_STATE_ENTER;
+}
 
 void freeze_set_ops(const struct platform_freeze_ops *ops)
 {
@@ -48,22 +62,49 @@ void freeze_set_ops(const struct platfor
 
 static void freeze_begin(void)
 {
-	suspend_freeze_wake = false;
+	suspend_freeze_state = FREEZE_STATE_NONE;
 }
 
 static void freeze_enter(void)
 {
-	cpuidle_use_deepest_state(true);
+	spin_lock_irq(&suspend_freeze_lock);
+	if (pm_wakeup_pending())
+		goto out;
+
+	suspend_freeze_state = FREEZE_STATE_ENTER;
+	spin_unlock_irq(&suspend_freeze_lock);
+
+	get_online_cpus();
 	cpuidle_resume();
-	wait_event(suspend_freeze_wait_head, suspend_freeze_wake);
+
+	/* Push all the CPUs into the idle loop. */
+	wake_up_all_idle_cpus();
+	pr_debug("PM: suspend-to-idle\n");
+	/* Make the current CPU wait so it can enter the idle loop too. */
+	wait_event(suspend_freeze_wait_head,
+		   suspend_freeze_state == FREEZE_STATE_WAKE);
+	pr_debug("PM: resume from suspend-to-idle\n");
+
 	cpuidle_pause();
-	cpuidle_use_deepest_state(false);
+	put_online_cpus();
+
+	spin_lock_irq(&suspend_freeze_lock);
+
+ out:
+	suspend_freeze_state = FREEZE_STATE_NONE;
+	spin_unlock_irq(&suspend_freeze_lock);
 }
 
 void freeze_wake(void)
 {
-	suspend_freeze_wake = true;
-	wake_up(&suspend_freeze_wait_head);
+	unsigned long flags;
+
+	spin_lock_irqsave(&suspend_freeze_lock, flags);
+	if (suspend_freeze_state > FREEZE_STATE_NONE) {
+		suspend_freeze_state = FREEZE_STATE_WAKE;
+		wake_up(&suspend_freeze_wait_head);
+	}
+	spin_unlock_irqrestore(&suspend_freeze_lock, flags);
 }
 EXPORT_SYMBOL_GPL(freeze_wake);
 
Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -203,6 +203,7 @@ extern void suspend_set_ops(const struct
 extern int suspend_valid_only_mem(suspend_state_t state);
 extern void freeze_set_ops(const struct platform_freeze_ops *ops);
 extern void freeze_wake(void);
+extern bool idle_should_freeze(void);
 
 /**
  * arch_suspend_disable_irqs - disable IRQs for suspend
@@ -230,6 +231,7 @@ static inline void suspend_set_ops(const
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
 static inline void freeze_set_ops(const struct platform_freeze_ops *ops) {}
 static inline void freeze_wake(void) {}
+static inline bool idle_should_freeze(void) { return false; }
 #endif /* !CONFIG_SUSPEND */
 
 /* struct pbe is used for creating lists of pages that should be restored
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -7,6 +7,7 @@
 #include <linux/tick.h>
 #include <linux/mm.h>
 #include <linux/stackprotector.h>
+#include <linux/suspend.h>
 
 #include <asm/tlb.h>
 
@@ -103,6 +104,12 @@ static void cpuidle_idle_call(void)
 	 */
 	rcu_idle_enter();
 
+	if (idle_should_freeze()) {
+		cpuidle_enter_freeze();
+		local_irq_enable();
+		goto exit_idle;
+	}
+
 	/*
 	 * Ask the cpuidle framework to choose a convenient idle state.
 	 * Fall back to the default arch idle method on errors.
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -19,6 +19,8 @@
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
+#include <linux/tick.h>
 #include <trace/events/power.h>
 
 #include "cpuidle.h"
@@ -32,7 +34,6 @@ LIST_HEAD(cpuidle_detected_devices);
 static int enabled_devices;
 static int off __read_mostly;
 static int initialized __read_mostly;
-static bool use_deepest_state __read_mostly;
 
 int cpuidle_disabled(void)
 {
@@ -66,36 +67,23 @@ int cpuidle_play_dead(void)
 }
 
 /**
- * cpuidle_use_deepest_state - Enable/disable the "deepest idle" mode.
- * @enable: Whether enable or disable the feature.
- *
- * If the "deepest idle" mode is enabled, cpuidle will ignore the governor and
- * always use the state with the greatest exit latency (out of the states that
- * are not disabled).
- *
- * This function can only be called after cpuidle_pause() to avoid races.
- */
-void cpuidle_use_deepest_state(bool enable)
-{
-	use_deepest_state = enable;
-}
-
-/**
- * cpuidle_find_deepest_state - Find the state of the greatest exit latency.
- * @drv: cpuidle driver for a given CPU.
- * @dev: cpuidle device for a given CPU.
+ * cpuidle_find_deepest_state - Find deepest state meeting specific conditions.
+ * @drv: cpuidle driver for the given CPU.
+ * @dev: cpuidle device for the given CPU.
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
@@ -104,6 +92,57 @@ static int cpuidle_find_deepest_state(st
 	return ret;
 }
 
+static void enter_freeze_proper(struct cpuidle_driver *drv,
+				struct cpuidle_device *dev, int index)
+{
+	tick_freeze();
+	drv->states[index].enter_freeze(dev, drv, index);
+	/*
+	 * timekeeping_resume() that will be called by tick_unfreeze() for the
+	 * last CPU executing it calls functions containing RCU read-side
+	 * critical sections, so tell RCU about that.
+	 */
+	RCU_NONIDLE(tick_unfreeze());
+}
+
+/**
+ * cpuidle_enter_freeze - Enter an idle state suitable for suspend-to-idle.
+ *
+ * If there are states with the ->enter_freeze callback, find the deepest of
+ * them and enter it with frozen tick.  Otherwise, find the deepest state
+ * available and enter it normally.
+ */
+void cpuidle_enter_freeze(void)
+{
+	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	int index;
+
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
+	if (index >= 0)
+		cpuidle_enter(drv, dev, index);
+	else
+		arch_cpu_idle();
+
+	/* Interrupts are enabled again here. */
+	local_irq_disable();
+}
+
 /**
  * cpuidle_enter_state - enter the state and update stats
  * @dev: cpuidle device for this cpu
@@ -166,9 +205,6 @@ int cpuidle_select(struct cpuidle_driver
 	if (!drv || !dev || !dev->enabled)
 		return -EBUSY;
 
-	if (unlikely(use_deepest_state))
-		return cpuidle_find_deepest_state(drv, dev);
-
 	return cpuidle_curr_governor->select(drv, dev);
 }
 
@@ -200,7 +236,7 @@ int cpuidle_enter(struct cpuidle_driver
  */
 void cpuidle_reflect(struct cpuidle_device *dev, int index)
 {
-	if (cpuidle_curr_governor->reflect && !unlikely(use_deepest_state))
+	if (cpuidle_curr_governor->reflect)
 		cpuidle_curr_governor->reflect(dev, index);
 }
 
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -50,6 +50,10 @@ struct cpuidle_state {
 			int index);
 
 	int (*enter_dead) (struct cpuidle_device *dev, int index);
+
+	void (*enter_freeze) (struct cpuidle_device *dev,
+			      struct cpuidle_driver *drv,
+			      int index);
 };
 
 /* Idle State Flags */
@@ -141,7 +145,7 @@ extern void cpuidle_resume(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
 extern int cpuidle_play_dead(void);
-extern void cpuidle_use_deepest_state(bool enable);
+extern void cpuidle_enter_freeze(void);
 
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
 #else
@@ -174,7 +178,7 @@ static inline int cpuidle_enable_device(
 {return -ENODEV; }
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
 static inline int cpuidle_play_dead(void) {return -ENODEV; }
-static inline void cpuidle_use_deepest_state(bool enable) {}
+static inline void cpuidle_enter_freeze(void) { }
 static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
 	struct cpuidle_device *dev) {return NULL; }
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
Index: linux-pm/kernel/time/timekeeping.c
===================================================================
--- linux-pm.orig/kernel/time/timekeeping.c
+++ linux-pm/kernel/time/timekeeping.c
@@ -1170,7 +1170,7 @@ void timekeeping_inject_sleeptime64(stru
  * xtime/wall_to_monotonic/jiffies/etc are
  * still managed by arch specific suspend/resume code.
  */
-static void timekeeping_resume(void)
+void timekeeping_resume(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *clock = tk->tkr.clock;
@@ -1251,7 +1251,7 @@ static void timekeeping_resume(void)
 	hrtimers_resume();
 }
 
-static int timekeeping_suspend(void)
+int timekeeping_suspend(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long flags;
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


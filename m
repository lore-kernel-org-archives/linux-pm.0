From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [Update][PATCH 1/6 v2] PM / sleep: Re-implement suspend-to-idle handling
Date: Thu, 12 Feb 2015 23:33:15 +0100
Message-ID: <27939105.9DhLRpLl4r@vostro.rjw.lan>
References: <8292243.ibkmfVtXac@vostro.rjw.lan> <5802443.EAllF0NTnO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <5802443.EAllF0NTnO@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Alan Cox <alan@linux.intel.com>, "Li, Aubrey" <aubrey.li@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kristen Carlson Accardi <kristen@linux.intel.com>, John Stultz <john.stultz@linaro.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In preparation for adding support for quiescing timers in the final
stage of suspend-to-idle transitions, rework the freeze_enter()
function making the system wait on a wakeup event, the freeze_wake()
function terminating the suspend-to-idle loop and the mechanism by
which deep idle states are entered during suspend-to-idle.

First of all, introduce a simple state machine for suspend-to-idle
and make the code in question use it.

Second, prevent freeze_enter() from losing wakeup events due to race
conditions and ensure that the number of online CPUs won't change
while it is being executed.  In addition to that, make it force
all of the CPUs re-enter the idle loop in case they are in idle
states already (so they can enter deeper idle states if possible).

Next, drop cpuidle_use_deepest_state() and replace use_deepest_state
checks in cpuidle_select() and cpuidle_reflect() with a single
suspend-to-idle state check in cpuidle_idle_call().

Finally, introduce cpuidle_enter_freeze() that will simply find the
deepest idle state available to the given CPU and enter it using
cpuidle_enter().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
 - Move the definition of enum freeze_state to suspend.h,
 - make suspend_freeze_state extern and declare it in suspend.h,
 - move the definition of idle_should_freeze() to suspend.h and
   define it as static inline. 

---
 drivers/cpuidle/cpuidle.c |   49 ++++++++++++++++++++++++----------------------
 include/linux/cpuidle.h   |    4 +--
 include/linux/suspend.h   |   16 +++++++++++++++
 kernel/power/suspend.c    |   43 +++++++++++++++++++++++++++++++++-------
 kernel/sched/idle.c       |   16 +++++++++++++++
 5 files changed, 96 insertions(+), 32 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -37,7 +37,9 @@ const char *pm_states[PM_SUSPEND_MAX];
 static const struct platform_suspend_ops *suspend_ops;
 static const struct platform_freeze_ops *freeze_ops;
 static DECLARE_WAIT_QUEUE_HEAD(suspend_freeze_wait_head);
-static bool suspend_freeze_wake;
+
+enum freeze_state __read_mostly suspend_freeze_state;
+static DEFINE_SPINLOCK(suspend_freeze_lock);
 
 void freeze_set_ops(const struct platform_freeze_ops *ops)
 {
@@ -48,22 +50,49 @@ void freeze_set_ops(const struct platfor
 
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
@@ -201,6 +201,21 @@ struct platform_freeze_ops {
  */
 extern void suspend_set_ops(const struct platform_suspend_ops *ops);
 extern int suspend_valid_only_mem(suspend_state_t state);
+
+/* Suspend-to-idle state machnine. */
+enum freeze_state {
+	FREEZE_STATE_NONE,      /* Not suspended/suspending. */
+	FREEZE_STATE_ENTER,     /* Enter suspend-to-idle. */
+	FREEZE_STATE_WAKE,      /* Wake up from suspend-to-idle. */
+};
+
+extern enum freeze_state __read_mostly suspend_freeze_state;
+
+static inline bool idle_should_freeze(void)
+{
+	return unlikely(suspend_freeze_state == FREEZE_STATE_ENTER);
+}
+
 extern void freeze_set_ops(const struct platform_freeze_ops *ops);
 extern void freeze_wake(void);
 
@@ -228,6 +243,7 @@ extern int pm_suspend(suspend_state_t st
 
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
+static inline bool idle_should_freeze(void) { return false; }
 static inline void freeze_set_ops(const struct platform_freeze_ops *ops) {}
 static inline void freeze_wake(void) {}
 #endif /* !CONFIG_SUSPEND */
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
 
@@ -104,6 +105,21 @@ static void cpuidle_idle_call(void)
 	rcu_idle_enter();
 
 	/*
+	 * Suspend-to-idle ("freeze") is a system state in which all user space
+	 * has been frozen, all I/O devices have been suspended and the only
+	 * activity happens here and in iterrupts (if any).  In that case bypass
+	 * the cpuidle governor and go stratight for the deepest idle state
+	 * available.  Possibly also suspend the local tick and the entire
+	 * timekeeping to prevent timer interrupts from kicking us out of idle
+	 * until a proper wakeup interrupt happens.
+	 */
+	if (idle_should_freeze()) {
+		cpuidle_enter_freeze();
+		local_irq_enable();
+		goto exit_idle;
+	}
+
+	/*
 	 * Ask the cpuidle framework to choose a convenient idle state.
 	 * Fall back to the default arch idle method on errors.
 	 */
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -19,6 +19,7 @@
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
 #include <linux/module.h>
+#include <linux/suspend.h>
 #include <trace/events/power.h>
 
 #include "cpuidle.h"
@@ -32,7 +33,6 @@ LIST_HEAD(cpuidle_detected_devices);
 static int enabled_devices;
 static int off __read_mostly;
 static int initialized __read_mostly;
-static bool use_deepest_state __read_mostly;
 
 int cpuidle_disabled(void)
 {
@@ -66,24 +66,9 @@ int cpuidle_play_dead(void)
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
  */
 static int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 				      struct cpuidle_device *dev)
@@ -105,6 +90,27 @@ static int cpuidle_find_deepest_state(st
 }
 
 /**
+ * cpuidle_enter_freeze - Enter an idle state suitable for suspend-to-idle.
+ *
+ * Find the deepest state available and enter it.
+ */
+void cpuidle_enter_freeze(void)
+{
+	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
+	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
+	int index;
+
+	index = cpuidle_find_deepest_state(drv, dev);
+	if (index >= 0)
+		cpuidle_enter(drv, dev, index);
+	else
+		arch_cpu_idle();
+
+	/* Interrupts are enabled again here. */
+	local_irq_disable();
+}
+
+/**
  * cpuidle_enter_state - enter the state and update stats
  * @dev: cpuidle device for this cpu
  * @drv: cpuidle driver for this cpu
@@ -166,9 +172,6 @@ int cpuidle_select(struct cpuidle_driver
 	if (!drv || !dev || !dev->enabled)
 		return -EBUSY;
 
-	if (unlikely(use_deepest_state))
-		return cpuidle_find_deepest_state(drv, dev);
-
 	return cpuidle_curr_governor->select(drv, dev);
 }
 
@@ -200,7 +203,7 @@ int cpuidle_enter(struct cpuidle_driver
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
@@ -141,7 +141,7 @@ extern void cpuidle_resume(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
 extern int cpuidle_play_dead(void);
-extern void cpuidle_use_deepest_state(bool enable);
+extern void cpuidle_enter_freeze(void);
 
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
 #else
@@ -174,7 +174,7 @@ static inline int cpuidle_enable_device(
 {return -ENODEV; }
 static inline void cpuidle_disable_device(struct cpuidle_device *dev) { }
 static inline int cpuidle_play_dead(void) {return -ENODEV; }
-static inline void cpuidle_use_deepest_state(bool enable) {}
+static inline void cpuidle_enter_freeze(void) { }
 static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
 	struct cpuidle_device *dev) {return NULL; }
 #endif


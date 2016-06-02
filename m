From: dbasehore@chromium.org
Subject: [PATCH 4/5] freeze: Add error reporting
Date: Wed,  1 Jun 2016 21:33:28 -0700
Message-ID: <1464842009-21789-5-git-send-email-dbasehore@chromium.org>
References: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464842009-21789-1-git-send-email-dbasehore@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: dbasehore@chromium.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This adds error reporting for cpuidle to freeze so suspend-to-idle can
report errors when the CPU/SoC is unable to idle properly. Freeze will
abort when an error is encounted.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/acpi/processor_idle.c | 10 ++++++----
 drivers/cpuidle/cpuidle.c     | 31 ++++++++++++++++++++++++++-----
 drivers/idle/intel_idle.c     |  8 +++++---
 include/linux/cpuidle.h       | 10 ++++++----
 kernel/power/suspend.c        | 11 +++++++----
 5 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 444e374..a959b32 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -783,8 +783,8 @@ static int acpi_idle_enter(struct cpuidle_device *dev,
 	return index;
 }
 
-static void acpi_idle_enter_freeze(struct cpuidle_device *dev,
-				   struct cpuidle_driver *drv, int index)
+static int acpi_idle_enter_freeze(struct cpuidle_device *dev,
+				  struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
 
@@ -792,16 +792,18 @@ static void acpi_idle_enter_freeze(struct cpuidle_device *dev,
 		struct acpi_processor *pr = __this_cpu_read(processors);
 
 		if (unlikely(!pr))
-			return;
+			return 0;
 
 		if (pr->flags.bm_check) {
 			acpi_idle_enter_bm(pr, cx, false);
-			return;
+			return 0;
 		} else {
 			ACPI_FLUSH_CPU_CACHE();
 		}
 	}
 	acpi_idle_do_entry(cx);
+
+	return 0;
 }
 
 struct cpuidle_driver acpi_idle_driver = {
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a4d0059..2664a6c 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -34,6 +34,7 @@ LIST_HEAD(cpuidle_detected_devices);
 static int enabled_devices;
 static int off __read_mostly;
 static int initialized __read_mostly;
+static int cpuidle_freeze_error;
 
 int cpuidle_disabled(void)
 {
@@ -109,9 +110,11 @@ int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 	return find_deepest_state(drv, dev, UINT_MAX, 0, false);
 }
 
-static void enter_freeze_proper(struct cpuidle_driver *drv,
+static int enter_freeze_proper(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev, int index)
 {
+	int ret;
+
 	/*
 	 * trace_suspend_resume() called by tick_freeze() for the last CPU
 	 * executing it contains RCU usage regarded as invalid in the idle
@@ -124,7 +127,7 @@ static void enter_freeze_proper(struct cpuidle_driver *drv,
 	 * suspended is generally unsafe.
 	 */
 	stop_critical_timings();
-	drv->states[index].enter_freeze(dev, drv, index);
+	ret = drv->states[index].enter_freeze(dev, drv, index);
 	WARN_ON(!irqs_disabled());
 	/*
 	 * timekeeping_resume() that will be called by tick_unfreeze() for the
@@ -133,6 +136,7 @@ static void enter_freeze_proper(struct cpuidle_driver *drv,
 	 */
 	RCU_NONIDLE(tick_unfreeze());
 	start_critical_timings();
+	return ret;
 }
 
 /**
@@ -145,7 +149,7 @@ static void enter_freeze_proper(struct cpuidle_driver *drv,
  */
 int cpuidle_enter_freeze(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	int index;
+	int index, ret = 0;
 
 	/*
 	 * Find the deepest state with ->enter_freeze present, which guarantees
@@ -153,8 +157,13 @@ int cpuidle_enter_freeze(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * be frozen safely.
 	 */
 	index = find_deepest_state(drv, dev, UINT_MAX, 0, true);
-	if (index > 0)
-		enter_freeze_proper(drv, dev, index);
+	if (index >= 0)
+		ret = enter_freeze_proper(drv, dev, index);
+
+	if (ret < 0) {
+		cpuidle_freeze_error = ret;
+		freeze_wake();
+	}
 
 	return index;
 }
@@ -353,6 +362,18 @@ void cpuidle_resume(void)
 	mutex_unlock(&cpuidle_lock);
 }
 
+void cpuidle_prepare_freeze(void)
+{
+	cpuidle_freeze_error = 0;
+	cpuidle_resume();
+}
+
+int cpuidle_complete_freeze(void)
+{
+	cpuidle_pause();
+	return cpuidle_freeze_error;
+}
+
 /**
  * cpuidle_enable_device - enables idle PM for a CPU
  * @dev: the CPU
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c966492..98565de 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -97,8 +97,8 @@ static const struct idle_cpu *icpu;
 static struct cpuidle_device __percpu *intel_idle_cpuidle_devices;
 static int intel_idle(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv, int index);
-static void intel_idle_freeze(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv, int index);
+static int intel_idle_freeze(struct cpuidle_device *dev,
+			     struct cpuidle_driver *drv, int index);
 static int intel_idle_cpu_init(int cpu);
 
 static struct cpuidle_state *cpuidle_state_table;
@@ -870,13 +870,15 @@ static int intel_idle(struct cpuidle_device *dev,
  * @drv: cpuidle driver
  * @index: state index
  */
-static void intel_idle_freeze(struct cpuidle_device *dev,
+static int intel_idle_freeze(struct cpuidle_device *dev,
 			     struct cpuidle_driver *drv, int index)
 {
 	unsigned long ecx = 1; /* break on interrupt flag */
 	unsigned long eax = flg2MWAIT(drv->states[index].flags);
 
 	mwait_idle_with_hints(eax, ecx);
+
+	return 0;
 }
 
 static void __setup_broadcast_timer(void *arg)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 786ad32..27f6b11 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -54,11 +54,11 @@ struct cpuidle_state {
 	/*
 	 * CPUs execute ->enter_freeze with the local tick or entire timekeeping
 	 * suspended, so it must not re-enable interrupts at any point (even
-	 * temporarily) or attempt to change states of clock event devices.
+	 * temporarily). Returns 0 on success and non-zero if an error occurred.
 	 */
-	void (*enter_freeze) (struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv,
-			      int index);
+	int (*enter_freeze) (struct cpuidle_device *dev,
+			     struct cpuidle_driver *drv,
+			     int index);
 };
 
 /* Idle State Flags */
@@ -147,6 +147,8 @@ extern void cpuidle_pause_and_lock(void);
 extern void cpuidle_resume_and_unlock(void);
 extern void cpuidle_pause(void);
 extern void cpuidle_resume(void);
+extern void cpuidle_prepare_freeze(void);
+extern int cpuidle_complete_freeze(void);
 extern int cpuidle_enable_device(struct cpuidle_device *dev);
 extern void cpuidle_disable_device(struct cpuidle_device *dev);
 extern int cpuidle_play_dead(void);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 5b70d64..419154b 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -57,8 +57,10 @@ static void freeze_begin(void)
 	suspend_freeze_state = FREEZE_STATE_NONE;
 }
 
-static void freeze_enter(void)
+static int freeze_enter(void)
 {
+	int error = 0;
+
 	spin_lock_irq(&suspend_freeze_lock);
 	if (pm_wakeup_pending())
 		goto out;
@@ -67,7 +69,7 @@ static void freeze_enter(void)
 	spin_unlock_irq(&suspend_freeze_lock);
 
 	get_online_cpus();
-	cpuidle_resume();
+	cpuidle_prepare_freeze();
 
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
@@ -77,7 +79,7 @@ static void freeze_enter(void)
 		   suspend_freeze_state == FREEZE_STATE_WAKE);
 	pr_debug("PM: resume from suspend-to-idle\n");
 
-	cpuidle_pause();
+	error = cpuidle_complete_freeze();
 	put_online_cpus();
 
 	spin_lock_irq(&suspend_freeze_lock);
@@ -85,6 +87,7 @@ static void freeze_enter(void)
  out:
 	suspend_freeze_state = FREEZE_STATE_NONE;
 	spin_unlock_irq(&suspend_freeze_lock);
+	return error;
 }
 
 void freeze_wake(void)
@@ -347,7 +350,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	 */
 	if (state == PM_SUSPEND_FREEZE) {
 		trace_suspend_resume(TPS("machine_suspend"), state, true);
-		freeze_enter();
+		error = freeze_enter();
 		trace_suspend_resume(TPS("machine_suspend"), state, false);
 		goto Platform_wake;
 	}
-- 
2.8.0.rc3.226.g39d4020

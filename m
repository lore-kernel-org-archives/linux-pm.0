From: Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v5 4/5] freeze: Add error reporting
Date: Fri,  7 Jul 2017 17:03:02 -0700
Message-ID: <20170708000303.21863-4-dbasehore@chromium.org>
References: <20170708000303.21863-1-dbasehore@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:35913 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbdGHADX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 20:03:23 -0400
Received: by mail-pg0-f54.google.com with SMTP id u62so23904149pgb.3
        for <linux-pm@vger.kernel.org>; Fri, 07 Jul 2017 17:03:23 -0700 (PDT)
In-Reply-To: <20170708000303.21863-1-dbasehore@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>, x86@kernel.org, platform-driver-x86@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>

This adds error reporting for cpuidle to freeze so suspend-to-idle can
report errors when the CPU/SoC is unable to idle properly. Freeze will
abort when an error is encounted.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/acpi/processor_idle.c | 10 ++++++----
 drivers/cpuidle/cpuidle.c     | 32 +++++++++++++++++++++++++++-----
 drivers/idle/intel_idle.c     |  8 +++++---
 include/linux/cpuidle.h       | 12 ++++++++----
 kernel/power/suspend.c        | 20 +++++++++++++-------
 5 files changed, 59 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5c8aa9cf62d7..1c0ac4d24563 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -789,8 +789,8 @@ static int acpi_idle_enter(struct cpuidle_device *dev,
 	return index;
 }
 
-static void acpi_idle_enter_freeze(struct cpuidle_device *dev,
-				   struct cpuidle_driver *drv, int index)
+static int acpi_idle_enter_freeze(struct cpuidle_device *dev,
+				  struct cpuidle_driver *drv, int index)
 {
 	struct acpi_processor_cx *cx = per_cpu(acpi_cstate[index], dev->cpu);
 
@@ -798,16 +798,18 @@ static void acpi_idle_enter_freeze(struct cpuidle_device *dev,
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
 
 static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 60bb64f4329d..862c55341088 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -128,9 +128,13 @@ int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 }
 
 #ifdef CONFIG_SUSPEND
-static void enter_freeze_proper(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev, int index)
+static int cpuidle_freeze_error;
+
+static int enter_freeze_proper(struct cpuidle_driver *drv,
+			       struct cpuidle_device *dev, int index)
 {
+	int ret;
+
 	/*
 	 * trace_suspend_resume() called by tick_freeze() for the last CPU
 	 * executing it contains RCU usage regarded as invalid in the idle
@@ -143,7 +147,7 @@ static void enter_freeze_proper(struct cpuidle_driver *drv,
 	 * suspended is generally unsafe.
 	 */
 	stop_critical_timings();
-	drv->states[index].enter_freeze(dev, drv, index);
+	ret = drv->states[index].enter_freeze(dev, drv, index);
 	WARN_ON(!irqs_disabled());
 	/*
 	 * timekeeping_resume() that will be called by tick_unfreeze() for the
@@ -152,6 +156,7 @@ static void enter_freeze_proper(struct cpuidle_driver *drv,
 	 */
 	RCU_NONIDLE(tick_unfreeze());
 	start_critical_timings();
+	return ret;
 }
 
 /**
@@ -164,7 +169,7 @@ static void enter_freeze_proper(struct cpuidle_driver *drv,
  */
 int cpuidle_enter_freeze(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
-	int index;
+	int index, ret = 0;
 
 	/*
 	 * Find the deepest state with ->enter_freeze present, which guarantees
@@ -173,10 +178,27 @@ int cpuidle_enter_freeze(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 */
 	index = find_deepest_state(drv, dev, UINT_MAX, 0, true);
 	if (index > 0)
-		enter_freeze_proper(drv, dev, index);
+		ret = enter_freeze_proper(drv, dev, index);
+
+	if (ret < 0) {
+		cpuidle_freeze_error = ret;
+		freeze_wake();
+	}
 
 	return index;
 }
+
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
 #endif /* CONFIG_SUSPEND */
 
 /**
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c2ae819a871c..ebed3f804291 100644
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
 static struct cpuidle_state *cpuidle_state_table;
 
 /*
@@ -941,13 +941,15 @@ static __cpuidle int intel_idle(struct cpuidle_device *dev,
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
 
 static void __setup_broadcast_timer(bool on)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index fc1e5d7fc1c7..ad0b563c5975 100644
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
@@ -200,6 +200,8 @@ extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 extern int cpuidle_enter_freeze(struct cpuidle_driver *drv,
 				struct cpuidle_device *dev);
 extern void cpuidle_use_deepest_state(bool enable);
+extern void cpuidle_prepare_freeze(void);
+extern int cpuidle_complete_freeze(void);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 					     struct cpuidle_device *dev)
@@ -210,6 +212,8 @@ static inline int cpuidle_enter_freeze(struct cpuidle_driver *drv,
 static inline void cpuidle_use_deepest_state(bool enable)
 {
 }
+static inline void cpuidle_prepare_freeze(void) { }
+static inline int cpuidle_complete_freeze(void) { return -ENODEV; }
 #endif
 
 /* kernel/sched/idle.c */
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 3ecf275d7e44..4ee883642093 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -70,8 +70,10 @@ static void freeze_begin(void)
 	suspend_freeze_state = FREEZE_STATE_NONE;
 }
 
-static void freeze_enter(void)
+static int freeze_enter(void)
 {
+	int error = 0;
+
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_FREEZE, true);
 
 	spin_lock_irq(&suspend_freeze_lock);
@@ -82,7 +84,7 @@ static void freeze_enter(void)
 	spin_unlock_irq(&suspend_freeze_lock);
 
 	get_online_cpus();
-	cpuidle_resume();
+	cpuidle_prepare_freeze();
 
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
@@ -90,7 +92,7 @@ static void freeze_enter(void)
 	wait_event(suspend_freeze_wait_head,
 		   suspend_freeze_state == FREEZE_STATE_WAKE);
 
-	cpuidle_pause();
+	error = cpuidle_complete_freeze();
 	put_online_cpus();
 
 	spin_lock_irq(&suspend_freeze_lock);
@@ -100,14 +102,17 @@ static void freeze_enter(void)
 	spin_unlock_irq(&suspend_freeze_lock);
 
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_FREEZE, false);
+	return error;
 }
 
-static void s2idle_loop(void)
+static int s2idle_loop(void)
 {
+	int ret;
+
 	pr_debug("PM: suspend-to-idle\n");
 
 	do {
-		freeze_enter();
+		ret = freeze_enter();
 
 		if (freeze_ops && freeze_ops->wake)
 			freeze_ops->wake();
@@ -116,13 +121,14 @@ static void s2idle_loop(void)
 		if (freeze_ops && freeze_ops->sync)
 			freeze_ops->sync();
 
-		if (pm_wakeup_pending())
+		if (ret < 0 || pm_wakeup_pending())
 			break;
 
 		pm_wakeup_clear(false);
 	} while (!dpm_suspend_noirq(PMSG_SUSPEND));
 
 	pr_debug("PM: resume from suspend-to-idle\n");
+	return ret;
 }
 
 void freeze_wake(void)
@@ -396,7 +402,7 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	 * all the devices are suspended.
 	 */
 	if (state == PM_SUSPEND_FREEZE) {
-		s2idle_loop();
+		error = s2idle_loop();
 		goto Platform_early_resume;
 	}
 
-- 
2.13.2.725.g09c95d1e9-goog

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2 2/4] PM / s2idle: Rename freeze_state enum and related items
Date: Thu, 10 Aug 2017 00:13:56 +0200
Message-ID: <8922129.VdBnjzkN8y@aspire.rjw.lan>
References: <1912685.WjJGzNPQ5e@aspire.rjw.lan> <4362123.MquenKSW7f@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4362123.MquenKSW7f@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rename the freeze_state enum representing the suspend-to-idle state
machine states to s2idle_states and rename the related variables and
functions accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/wakeup.c |    2 -
 include/linux/suspend.h     |   20 +++++++++---------
 kernel/power/suspend.c      |   48 ++++++++++++++++++++++----------------------
 kernel/sched/idle.c         |    6 ++---
 4 files changed, 38 insertions(+), 38 deletions(-)

Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -57,10 +57,10 @@ EXPORT_SYMBOL_GPL(pm_suspend_global_flag
 
 static const struct platform_suspend_ops *suspend_ops;
 static const struct platform_freeze_ops *freeze_ops;
-static DECLARE_WAIT_QUEUE_HEAD(suspend_freeze_wait_head);
+static DECLARE_WAIT_QUEUE_HEAD(s2idle_wait_head);
 
-enum freeze_state __read_mostly suspend_freeze_state;
-static DEFINE_SPINLOCK(suspend_freeze_lock);
+enum s2idle_states __read_mostly s2idle_state;
+static DEFINE_SPINLOCK(s2idle_lock);
 
 void freeze_set_ops(const struct platform_freeze_ops *ops)
 {
@@ -69,21 +69,21 @@ void freeze_set_ops(const struct platfor
 	unlock_system_sleep();
 }
 
-static void freeze_begin(void)
+static void s2idle_begin(void)
 {
-	suspend_freeze_state = FREEZE_STATE_NONE;
+	s2idle_state = S2IDLE_STATE_NONE;
 }
 
-static void freeze_enter(void)
+static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
-	spin_lock_irq(&suspend_freeze_lock);
+	spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
 
-	suspend_freeze_state = FREEZE_STATE_ENTER;
-	spin_unlock_irq(&suspend_freeze_lock);
+	s2idle_state = S2IDLE_STATE_ENTER;
+	spin_unlock_irq(&s2idle_lock);
 
 	get_online_cpus();
 	cpuidle_resume();
@@ -91,17 +91,17 @@ static void freeze_enter(void)
 	/* Push all the CPUs into the idle loop. */
 	wake_up_all_idle_cpus();
 	/* Make the current CPU wait so it can enter the idle loop too. */
-	wait_event(suspend_freeze_wait_head,
-		   suspend_freeze_state == FREEZE_STATE_WAKE);
+	wait_event(s2idle_wait_head,
+		   s2idle_state == S2IDLE_STATE_WAKE);
 
 	cpuidle_pause();
 	put_online_cpus();
 
-	spin_lock_irq(&suspend_freeze_lock);
+	spin_lock_irq(&s2idle_lock);
 
  out:
-	suspend_freeze_state = FREEZE_STATE_NONE;
-	spin_unlock_irq(&suspend_freeze_lock);
+	s2idle_state = S2IDLE_STATE_NONE;
+	spin_unlock_irq(&s2idle_lock);
 
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
 }
@@ -118,12 +118,12 @@ static void s2idle_loop(void)
 		/*
 		 * Suspend-to-idle equals
 		 * frozen processes + suspended devices + idle processors.
-		 * Thus freeze_enter() should be called right after
+		 * Thus s2idle_enter() should be called right after
 		 * all devices have been suspended.
 		 */
 		error = dpm_noirq_suspend_devices(PMSG_SUSPEND);
 		if (!error)
-			freeze_enter();
+			s2idle_enter();
 
 		dpm_noirq_resume_devices(PMSG_RESUME);
 		if (error && (error != -EBUSY || !pm_wakeup_pending())) {
@@ -148,18 +148,18 @@ static void s2idle_loop(void)
 	pm_pr_dbg("resume from suspend-to-idle\n");
 }
 
-void freeze_wake(void)
+void s2idle_wake(void)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&suspend_freeze_lock, flags);
-	if (suspend_freeze_state > FREEZE_STATE_NONE) {
-		suspend_freeze_state = FREEZE_STATE_WAKE;
-		wake_up(&suspend_freeze_wait_head);
+	spin_lock_irqsave(&s2idle_lock, flags);
+	if (s2idle_state > S2IDLE_STATE_NONE) {
+		s2idle_state = S2IDLE_STATE_WAKE;
+		wake_up(&s2idle_wait_head);
 	}
-	spin_unlock_irqrestore(&suspend_freeze_lock, flags);
+	spin_unlock_irqrestore(&s2idle_lock, flags);
 }
-EXPORT_SYMBOL_GPL(freeze_wake);
+EXPORT_SYMBOL_GPL(s2idle_wake);
 
 static bool valid_state(suspend_state_t state)
 {
@@ -552,7 +552,7 @@ static int enter_state(suspend_state_t s
 		return -EBUSY;
 
 	if (state == PM_SUSPEND_TO_IDLE)
-		freeze_begin();
+		s2idle_begin();
 
 #ifndef CONFIG_SUSPEND_SKIP_SYNC
 	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
Index: linux-pm/kernel/sched/idle.c
===================================================================
--- linux-pm.orig/kernel/sched/idle.c
+++ linux-pm/kernel/sched/idle.c
@@ -158,7 +158,7 @@ static void cpuidle_idle_call(void)
 	}
 
 	/*
-	 * Suspend-to-idle ("freeze") is a system state in which all user space
+	 * Suspend-to-idle ("s2idle") is a system state in which all user space
 	 * has been frozen, all I/O devices have been suspended and the only
 	 * activity happens here and in iterrupts (if any).  In that case bypass
 	 * the cpuidle governor and go stratight for the deepest idle state
@@ -167,8 +167,8 @@ static void cpuidle_idle_call(void)
 	 * until a proper wakeup interrupt happens.
 	 */
 
-	if (idle_should_freeze() || dev->use_deepest_state) {
-		if (idle_should_freeze()) {
+	if (idle_should_enter_s2idle() || dev->use_deepest_state) {
+		if (idle_should_enter_s2idle()) {
 			entered_state = cpuidle_enter_freeze(drv, dev);
 			if (entered_state > 0) {
 				local_irq_enable();
Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -237,22 +237,22 @@ static inline bool pm_resume_via_firmwar
 }
 
 /* Suspend-to-idle state machnine. */
-enum freeze_state {
-	FREEZE_STATE_NONE,      /* Not suspended/suspending. */
-	FREEZE_STATE_ENTER,     /* Enter suspend-to-idle. */
-	FREEZE_STATE_WAKE,      /* Wake up from suspend-to-idle. */
+enum s2idle_states {
+	S2IDLE_STATE_NONE,      /* Not suspended/suspending. */
+	S2IDLE_STATE_ENTER,     /* Enter suspend-to-idle. */
+	S2IDLE_STATE_WAKE,      /* Wake up from suspend-to-idle. */
 };
 
-extern enum freeze_state __read_mostly suspend_freeze_state;
+extern enum s2idle_states __read_mostly s2idle_state;
 
-static inline bool idle_should_freeze(void)
+static inline bool idle_should_enter_s2idle(void)
 {
-	return unlikely(suspend_freeze_state == FREEZE_STATE_ENTER);
+	return unlikely(s2idle_state == S2IDLE_STATE_ENTER);
 }
 
 extern void __init pm_states_init(void);
 extern void freeze_set_ops(const struct platform_freeze_ops *ops);
-extern void freeze_wake(void);
+extern void s2idle_wake(void);
 
 /**
  * arch_suspend_disable_irqs - disable IRQs for suspend
@@ -284,10 +284,10 @@ static inline bool pm_resume_via_firmwar
 
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
-static inline bool idle_should_freeze(void) { return false; }
+static inline bool idle_should_enter_s2idle(void) { return false; }
 static inline void __init pm_states_init(void) {}
 static inline void freeze_set_ops(const struct platform_freeze_ops *ops) {}
-static inline void freeze_wake(void) {}
+static inline void s2idle_wake(void) {}
 #endif /* !CONFIG_SUSPEND */
 
 /* struct pbe is used for creating lists of pages that should be restored
Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -865,7 +865,7 @@ bool pm_wakeup_pending(void)
 void pm_system_wakeup(void)
 {
 	atomic_inc(&pm_abort_suspend);
-	freeze_wake();
+	s2idle_wake();
 }
 EXPORT_SYMBOL_GPL(pm_system_wakeup);
 

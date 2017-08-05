From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 4/4] PM / s2idle: Rename platform operations structure
Date: Sat, 05 Aug 2017 15:00:58 +0200
Message-ID: <3324625.5eR4bVNclN@aspire.rjw.lan>
References: <1912685.WjJGzNPQ5e@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1912685.WjJGzNPQ5e@aspire.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Len Brown <lenb@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Rename struct platform_freeze_ops to platform_s2idle_ops to make it
clear that the callbacks in it are used during suspend-to-idle
suspend/resume transitions and rename the related functions,
variables and so on accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sleep.c    |   28 ++++++++++++++--------------
 include/linux/suspend.h |    6 +++---
 kernel/power/suspend.c  |   30 +++++++++++++++---------------
 3 files changed, 32 insertions(+), 32 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -186,7 +186,7 @@ struct platform_suspend_ops {
 	void (*recover)(void);
 };
 
-struct platform_freeze_ops {
+struct platform_s2idle_ops {
 	int (*begin)(void);
 	int (*prepare)(void);
 	void (*wake)(void);
@@ -251,7 +251,7 @@ static inline bool idle_should_enter_s2i
 }
 
 extern void __init pm_states_init(void);
-extern void freeze_set_ops(const struct platform_freeze_ops *ops);
+extern void s2idle_set_ops(const struct platform_s2idle_ops *ops);
 extern void s2idle_wake(void);
 
 /**
@@ -286,7 +286,7 @@ static inline void suspend_set_ops(const
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
 static inline bool idle_should_enter_s2idle(void) { return false; }
 static inline void __init pm_states_init(void) {}
-static inline void freeze_set_ops(const struct platform_freeze_ops *ops) {}
+static inline void s2idle_set_ops(const struct platform_s2idle_ops *ops) {}
 static inline void s2idle_wake(void) {}
 #endif /* !CONFIG_SUSPEND */
 
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -737,14 +737,14 @@ static struct acpi_scan_handler lps0_han
 	.attach = lps0_device_attach,
 };
 
-static int acpi_freeze_begin(void)
+static int acpi_s2idle_begin(void)
 {
 	acpi_scan_lock_acquire();
 	s2idle_in_progress = true;
 	return 0;
 }
 
-static int acpi_freeze_prepare(void)
+static int acpi_s2idle_prepare(void)
 {
 	if (lps0_device_handle) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
@@ -764,7 +764,7 @@ static int acpi_freeze_prepare(void)
 	return 0;
 }
 
-static void acpi_freeze_wake(void)
+static void acpi_s2idle_wake(void)
 {
 	/*
 	 * If IRQD_WAKEUP_ARMED is not set for the SCI at this point, it means
@@ -778,7 +778,7 @@ static void acpi_freeze_wake(void)
 	}
 }
 
-static void acpi_freeze_sync(void)
+static void acpi_s2idle_sync(void)
 {
 	/*
 	 * Process all pending events in case there are any wakeup ones.
@@ -791,7 +791,7 @@ static void acpi_freeze_sync(void)
 	s2idle_wakeup = false;
 }
 
-static void acpi_freeze_restore(void)
+static void acpi_s2idle_restore(void)
 {
 	if (acpi_sci_irq_valid())
 		disable_irq_wake(acpi_sci_irq);
@@ -804,19 +804,19 @@ static void acpi_freeze_restore(void)
 	}
 }
 
-static void acpi_freeze_end(void)
+static void acpi_s2idle_end(void)
 {
 	s2idle_in_progress = false;
 	acpi_scan_lock_release();
 }
 
-static const struct platform_freeze_ops acpi_freeze_ops = {
-	.begin = acpi_freeze_begin,
-	.prepare = acpi_freeze_prepare,
-	.wake = acpi_freeze_wake,
-	.sync = acpi_freeze_sync,
-	.restore = acpi_freeze_restore,
-	.end = acpi_freeze_end,
+static const struct platform_s2idle_ops acpi_s2idle_ops = {
+	.begin = acpi_s2idle_begin,
+	.prepare = acpi_s2idle_prepare,
+	.wake = acpi_s2idle_wake,
+	.sync = acpi_s2idle_sync,
+	.restore = acpi_s2idle_restore,
+	.end = acpi_s2idle_end,
 };
 
 static void acpi_sleep_suspend_setup(void)
@@ -831,7 +831,7 @@ static void acpi_sleep_suspend_setup(voi
 		&acpi_suspend_ops_old : &acpi_suspend_ops);
 
 	acpi_scan_add_handler(&lps0_handler);
-	freeze_set_ops(&acpi_freeze_ops);
+	s2idle_set_ops(&acpi_s2idle_ops);
 }
 
 #else /* !CONFIG_SUSPEND */
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -56,16 +56,16 @@ unsigned int pm_suspend_global_flags;
 EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
 
 static const struct platform_suspend_ops *suspend_ops;
-static const struct platform_freeze_ops *freeze_ops;
+static const struct platform_s2idle_ops *s2idle_ops;
 static DECLARE_WAIT_QUEUE_HEAD(s2idle_wait_head);
 
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_SPINLOCK(s2idle_lock);
 
-void freeze_set_ops(const struct platform_freeze_ops *ops)
+void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
 	lock_system_sleep();
-	freeze_ops = ops;
+	s2idle_ops = ops;
 	unlock_system_sleep();
 }
 
@@ -131,13 +131,13 @@ static void s2idle_loop(void)
 			break;
 		}
 
-		if (freeze_ops && freeze_ops->wake)
-			freeze_ops->wake();
+		if (s2idle_ops && s2idle_ops->wake)
+			s2idle_ops->wake();
 
 		dpm_noirq_end();
 
-		if (freeze_ops && freeze_ops->sync)
-			freeze_ops->sync();
+		if (s2idle_ops && s2idle_ops->sync)
+			s2idle_ops->sync();
 
 		if (pm_wakeup_pending())
 			break;
@@ -250,8 +250,8 @@ static int platform_suspend_prepare(susp
 
 static int platform_suspend_prepare_late(suspend_state_t state)
 {
-	return state == PM_SUSPEND_S2IDLE && freeze_ops && freeze_ops->prepare ?
-		freeze_ops->prepare() : 0;
+	return state == PM_SUSPEND_S2IDLE && s2idle_ops && s2idle_ops->prepare ?
+		s2idle_ops->prepare() : 0;
 }
 
 static int platform_suspend_prepare_noirq(suspend_state_t state)
@@ -268,8 +268,8 @@ static void platform_resume_noirq(suspen
 
 static void platform_resume_early(suspend_state_t state)
 {
-	if (state == PM_SUSPEND_S2IDLE && freeze_ops && freeze_ops->restore)
-		freeze_ops->restore();
+	if (state == PM_SUSPEND_S2IDLE && s2idle_ops && s2idle_ops->restore)
+		s2idle_ops->restore();
 }
 
 static void platform_resume_finish(suspend_state_t state)
@@ -280,8 +280,8 @@ static void platform_resume_finish(suspe
 
 static int platform_suspend_begin(suspend_state_t state)
 {
-	if (state == PM_SUSPEND_S2IDLE && freeze_ops && freeze_ops->begin)
-		return freeze_ops->begin();
+	if (state == PM_SUSPEND_S2IDLE && s2idle_ops && s2idle_ops->begin)
+		return s2idle_ops->begin();
 	else if (suspend_ops && suspend_ops->begin)
 		return suspend_ops->begin(state);
 	else
@@ -290,8 +290,8 @@ static int platform_suspend_begin(suspen
 
 static void platform_resume_end(suspend_state_t state)
 {
-	if (state == PM_SUSPEND_S2IDLE && freeze_ops && freeze_ops->end)
-		freeze_ops->end();
+	if (state == PM_SUSPEND_S2IDLE && s2idle_ops && s2idle_ops->end)
+		s2idle_ops->end();
 	else if (suspend_ops && suspend_ops->end)
 		suspend_ops->end();
 }



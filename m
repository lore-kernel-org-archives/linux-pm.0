From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 06/09] clockevents: Make suspend/resume calls explicit
Date: Wed, 25 Mar 2015 13:09:16 +0100
Message-ID: <713674030.jVm1qaHuPf@vostro.rjw.lan>
References: <20150216121435.203983131@infradead.org> <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4241632.Wi7SZdKMQs@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

clockevents_notify() is a leftover from the early design of the
clockevents facility. It's really not a notification mechanism, it's a
multiplex call.

We are way better off to have explicit calls instead of this
monstrosity. Split out the suspend/resume() calls and invoke them
directly from the call sites.

No locking required at this point because these calls happen with
interrupts disabled and a single cpu online.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[ rjw: Rebased on top of 4.0-rc5 ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/xen/suspend.c      |   11 ++++-------
 include/linux/clockchips.h  |    2 --
 include/linux/tick.h        |    3 +++
 kernel/time/clockevents.c   |    9 ---------
 kernel/time/tick-common.c   |   26 +++++++++++++++++++++++---
 kernel/time/tick-internal.h |    3 ++-
 kernel/time/timekeeping.c   |    6 ++----
 7 files changed, 34 insertions(+), 26 deletions(-)

Index: linux-pm/arch/x86/xen/suspend.c
===================================================================
--- linux-pm.orig/arch/x86/xen/suspend.c
+++ linux-pm/arch/x86/xen/suspend.c
@@ -1,5 +1,5 @@
 #include <linux/types.h>
-#include <linux/clockchips.h>
+#include <linux/tick.h>
 
 #include <xen/interface/xen.h>
 #include <xen/grant_table.h>
@@ -81,17 +81,14 @@ void xen_arch_post_suspend(int cancelled
 
 static void xen_vcpu_notify_restore(void *data)
 {
-	unsigned long reason = (unsigned long)data;
-
 	/* Boot processor notified via generic timekeeping_resume() */
-	if ( smp_processor_id() == 0)
+	if (smp_processor_id() == 0)
 		return;
 
-	clockevents_notify(reason, NULL);
+	tick_resume();
 }
 
 void xen_arch_resume(void)
 {
-	on_each_cpu(xen_vcpu_notify_restore,
-		    (void *)CLOCK_EVT_NOTIFY_RESUME, 1);
+	on_each_cpu(xen_vcpu_notify_restore, NULL, 1);
 }
Index: linux-pm/include/linux/clockchips.h
===================================================================
--- linux-pm.orig/include/linux/clockchips.h
+++ linux-pm/include/linux/clockchips.h
@@ -16,8 +16,6 @@ enum clock_event_nofitiers {
 	CLOCK_EVT_NOTIFY_BROADCAST_FORCE,
 	CLOCK_EVT_NOTIFY_BROADCAST_ENTER,
 	CLOCK_EVT_NOTIFY_BROADCAST_EXIT,
-	CLOCK_EVT_NOTIFY_SUSPEND,
-	CLOCK_EVT_NOTIFY_RESUME,
 	CLOCK_EVT_NOTIFY_CPU_DYING,
 	CLOCK_EVT_NOTIFY_CPU_DEAD,
 };
Index: linux-pm/include/linux/tick.h
===================================================================
--- linux-pm.orig/include/linux/tick.h
+++ linux-pm/include/linux/tick.h
@@ -29,10 +29,13 @@ extern struct tick_device *tick_get_devi
 extern void __init tick_init(void);
 extern void tick_freeze(void);
 extern void tick_unfreeze(void);
+/* Should be core only, but XEN resume magic abuses this interface */
+extern void tick_resume(void);
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
 static inline void tick_freeze(void) { }
 static inline void tick_unfreeze(void) { }
+static inline void tick_resume(void) { }
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
 
 #ifdef CONFIG_TICK_ONESHOT
Index: linux-pm/kernel/time/clockevents.c
===================================================================
--- linux-pm.orig/kernel/time/clockevents.c
+++ linux-pm/kernel/time/clockevents.c
@@ -566,15 +566,6 @@ int clockevents_notify(unsigned long rea
 		tick_handover_do_timer(arg);
 		break;
 
-	case CLOCK_EVT_NOTIFY_SUSPEND:
-		tick_suspend();
-		tick_suspend_broadcast();
-		break;
-
-	case CLOCK_EVT_NOTIFY_RESUME:
-		tick_resume();
-		break;
-
 	case CLOCK_EVT_NOTIFY_CPU_DEAD:
 		tick_shutdown_broadcast_oneshot(arg);
 		tick_shutdown_broadcast(arg);
Index: linux-pm/kernel/time/tick-common.c
===================================================================
--- linux-pm.orig/kernel/time/tick-common.c
+++ linux-pm/kernel/time/tick-common.c
@@ -372,18 +372,39 @@ void tick_shutdown(unsigned int *cpup)
 	}
 }
 
+/**
+ * tick_suspend - Suspend the tick and the broadcast device
+ *
+ * Called from syscore_suspend() via timekeeping_suspend with only one
+ * CPU online and interrupts disabled or from tick_unfreeze() under
+ * tick_freeze_lock.
+ *
+ * No locks required. Nothing can change the per cpu device.
+ */
 void tick_suspend(void)
 {
 	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 
 	clockevents_shutdown(td->evtdev);
+	tick_suspend_broadcast();
 }
 
+/**
+ * tick_resume - Resume the tick and the broadcast device
+ *
+ * Called from syscore_resume() via timekeeping_resume with only one
+ * CPU online and interrupts disabled or from tick_unfreeze() under
+ * tick_freeze_lock.
+ *
+ * No locks required. Nothing can change the per cpu device.
+ */
 void tick_resume(void)
 {
-	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
-	int broadcast = tick_resume_broadcast();
+	struct tick_device *td;
+	int broadcast;
 
+	broadcast = tick_resume_broadcast();
+	td = this_cpu_ptr(&tick_cpu_device);
 	clockevents_set_mode(td->evtdev, CLOCK_EVT_MODE_RESUME);
 
 	if (!broadcast) {
@@ -420,7 +441,6 @@ void tick_freeze(void)
 		timekeeping_suspend_count++;
 	} else {
 		tick_suspend();
-		tick_suspend_broadcast();
 	}
 
 	raw_spin_unlock(&tick_freeze_lock);
Index: linux-pm/kernel/time/tick-internal.h
===================================================================
--- linux-pm.orig/kernel/time/tick-internal.h
+++ linux-pm/kernel/time/tick-internal.h
@@ -23,7 +23,6 @@ extern void tick_check_new_device(struct
 extern void tick_handover_do_timer(int *cpup);
 extern void tick_shutdown(unsigned int *cpup);
 extern void tick_suspend(void);
-extern void tick_resume(void);
 extern bool tick_check_replacement(struct clock_event_device *curdev,
 				   struct clock_event_device *newdev);
 extern void tick_install_replacement(struct clock_event_device *dev);
@@ -41,6 +40,8 @@ extern void clockevents_exchange_device(
 extern void clockevents_handle_noop(struct clock_event_device *dev);
 extern int __clockevents_update_freq(struct clock_event_device *dev, u32 freq);
 extern ssize_t sysfs_get_uname(const char *buf, char *dst, size_t cnt);
+#else
+static inline void tick_suspend(void) { }
 #endif /* GENERIC_CLOCKEVENTS */
 
 /* Oneshot related functions */
Index: linux-pm/kernel/time/timekeeping.c
===================================================================
--- linux-pm.orig/kernel/time/timekeeping.c
+++ linux-pm/kernel/time/timekeeping.c
@@ -1272,9 +1272,7 @@ void timekeeping_resume(void)
 
 	touch_softlockup_watchdog();
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_RESUME, NULL);
-
-	/* Resume hrtimers */
+	tick_resume();
 	hrtimers_resume();
 }
 
@@ -1327,7 +1325,7 @@ int timekeeping_suspend(void)
 	write_seqcount_end(&tk_core.seq);
 	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
 
-	clockevents_notify(CLOCK_EVT_NOTIFY_SUSPEND, NULL);
+	tick_suspend();
 	clocksource_suspend();
 	clockevents_suspend();
 

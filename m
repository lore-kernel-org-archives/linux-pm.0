From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/5] ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle
Date: Wed, 26 Apr 2017 23:23:03 +0200
Message-ID: <2095415.MaUKCj6gyx@aspire.rjw.lan>
References: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1979543.KIEJ8uyRaT@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI SCI (System Control Interrupt) is set up as a wakeup IRQ
during suspend-to-idle transitions and, consequently, any events
signaled through it wake up the system from that state.  However,
on some systems some of the events signaled via the ACPI SCI while
suspended to idle should not cause the system to wake up.  In fact,
quite often they should just be discarded.

Arguably, systems should not resume entirely on such events, but in
order to decide which events really should cause the system to resume
and which are spurious, it is necessary to resume up to the point
when ACPI SCIs are actually handled and processed, which is after
executing dpm_resume_noirq() in the system resume path.

For this reasons, add a loop around freeze_enter() in which the
platforms can process events signaled via multiplexed IRQ lines
like the ACPI SCI and add suspend-to-idle hooks that can be
used for this purpose to struct platform_freeze_ops.

In the ACPI case, the ->wake hook is used for checking if the SCI
has triggered while suspended and deferring the interrupt-induced
system wakeup until the events signaled through it are actually
processed sufficiently to decide whether or not the system should
resume.  In turn, the ->sync hook allows all of the relevant event
queues to be flushed so as to prevent events from being missed due
to race conditions.

In addition to that, some ACPI code processing wakeup events needs
to be modified to use the "hard" version of wakeup triggers, so that
it will cause a system resume to happen on device-induced wakeup
events even if the "soft" mechanism to prevent the system from
suspending is not enabled (that also helps to catch device-induced
wakeup events occurring during suspend transitions in progress).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c      |    2 +-
 drivers/acpi/button.c       |    5 +++--
 drivers/acpi/device_pm.c    |    3 ++-
 drivers/acpi/sleep.c        |   28 ++++++++++++++++++++++++++++
 drivers/base/power/main.c   |    5 -----
 drivers/base/power/wakeup.c |   18 ++++++++++++------
 include/linux/suspend.h     |    7 +++++--
 kernel/power/process.c      |    2 +-
 kernel/power/suspend.c      |   29 +++++++++++++++++++++++++----
 9 files changed, 77 insertions(+), 22 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -189,6 +189,8 @@ struct platform_suspend_ops {
 struct platform_freeze_ops {
 	int (*begin)(void);
 	int (*prepare)(void);
+	void (*wake)(void);
+	void (*sync)(void);
 	void (*restore)(void);
 	void (*end)(void);
 };
@@ -428,7 +430,8 @@ extern unsigned int pm_wakeup_irq;
 
 extern bool pm_wakeup_pending(void);
 extern void pm_system_wakeup(void);
-extern void pm_wakeup_clear(void);
+extern void pm_system_cancel_wakeup(void);
+extern void pm_wakeup_clear(bool reset);
 extern void pm_system_irq_wakeup(unsigned int irq_number);
 extern bool pm_get_wakeup_count(unsigned int *count, bool block);
 extern bool pm_save_wakeup_count(unsigned int count);
@@ -478,7 +481,7 @@ static inline int unregister_pm_notifier
 
 static inline bool pm_wakeup_pending(void) { return false; }
 static inline void pm_system_wakeup(void) {}
-static inline void pm_wakeup_clear(void) {}
+static inline void pm_wakeup_clear(bool reset) {}
 static inline void pm_system_irq_wakeup(unsigned int irq_number) {}
 
 static inline void lock_system_sleep(void) {}
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -72,6 +72,8 @@ static void freeze_begin(void)
 
 static void freeze_enter(void)
 {
+	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_FREEZE, true);
+
 	spin_lock_irq(&suspend_freeze_lock);
 	if (pm_wakeup_pending())
 		goto out;
@@ -98,6 +100,27 @@ static void freeze_enter(void)
  out:
 	suspend_freeze_state = FREEZE_STATE_NONE;
 	spin_unlock_irq(&suspend_freeze_lock);
+
+	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_FREEZE, false);
+}
+
+static void s2idle_loop(void)
+{
+	do {
+		freeze_enter();
+
+		if (freeze_ops && freeze_ops->wake)
+			freeze_ops->wake();
+
+		dpm_resume_noirq(PMSG_RESUME);
+		if (freeze_ops && freeze_ops->sync)
+			freeze_ops->sync();
+
+		if (pm_wakeup_pending())
+			break;
+
+		pm_wakeup_clear(false);
+	} while (!dpm_suspend_noirq(PMSG_SUSPEND));
 }
 
 void freeze_wake(void)
@@ -371,10 +394,8 @@ static int suspend_enter(suspend_state_t
 	 * all the devices are suspended.
 	 */
 	if (state == PM_SUSPEND_FREEZE) {
-		trace_suspend_resume(TPS("machine_suspend"), state, true);
-		freeze_enter();
-		trace_suspend_resume(TPS("machine_suspend"), state, false);
-		goto Platform_wake;
+		s2idle_loop();
+		goto Platform_early_resume;
 	}
 
 	error = disable_nonboot_cpus();
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1091,11 +1091,6 @@ static int __device_suspend_noirq(struct
 	if (async_error)
 		goto Complete;
 
-	if (pm_wakeup_pending()) {
-		async_error = -EBUSY;
-		goto Complete;
-	}
-
 	if (dev->power.syscore || dev->power.direct_complete)
 		goto Complete;
 
Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -28,8 +28,8 @@ bool events_check_enabled __read_mostly;
 /* First wakeup IRQ seen by the kernel in the last cycle. */
 unsigned int pm_wakeup_irq __read_mostly;
 
-/* If set and the system is suspending, terminate the suspend. */
-static bool pm_abort_suspend __read_mostly;
+/* If greater than 0 and the system is suspending, terminate the suspend. */
+static atomic_t pm_abort_suspend __read_mostly;
 
 /*
  * Combined counters of registered wakeup events and wakeup events in progress.
@@ -856,20 +856,26 @@ bool pm_wakeup_pending(void)
 		pm_print_active_wakeup_sources();
 	}
 
-	return ret || pm_abort_suspend;
+	return ret || atomic_read(&pm_abort_suspend) > 0;
 }
 
 void pm_system_wakeup(void)
 {
-	pm_abort_suspend = true;
+	atomic_inc(&pm_abort_suspend);
 	freeze_wake();
 }
 EXPORT_SYMBOL_GPL(pm_system_wakeup);
 
-void pm_wakeup_clear(void)
+void pm_system_cancel_wakeup(void)
+{
+	atomic_dec(&pm_abort_suspend);
+}
+
+void pm_wakeup_clear(bool reset)
 {
-	pm_abort_suspend = false;
 	pm_wakeup_irq = 0;
+	if (reset)
+		atomic_set(&pm_abort_suspend, 0);
 }
 
 void pm_system_irq_wakeup(unsigned int irq_number)
Index: linux-pm/kernel/power/process.c
===================================================================
--- linux-pm.orig/kernel/power/process.c
+++ linux-pm/kernel/power/process.c
@@ -132,7 +132,7 @@ int freeze_processes(void)
 	if (!pm_freezing)
 		atomic_inc(&system_freezing_cnt);
 
-	pm_wakeup_clear();
+	pm_wakeup_clear(true);
 	pr_info("Freezing user space processes ... ");
 	pm_freezing = true;
 	error = try_to_freeze_tasks(true);
Index: linux-pm/drivers/acpi/sleep.c
===================================================================
--- linux-pm.orig/drivers/acpi/sleep.c
+++ linux-pm/drivers/acpi/sleep.c
@@ -662,14 +662,40 @@ static int acpi_freeze_prepare(void)
 	acpi_os_wait_events_complete();
 	if (acpi_sci_irq_valid())
 		enable_irq_wake(acpi_sci_irq);
+
 	return 0;
 }
 
+static void acpi_freeze_wake(void)
+{
+	/*
+	 * If IRQD_WAKEUP_ARMED is not set for the SCI at this point, it means
+	 * that the SCI has triggered while suspended, so cancel the wakeup in
+	 * case it has not been a wakeup event (the GPEs will be checked later).
+	 */
+	if (acpi_sci_irq_valid() &&
+	    !irqd_is_wakeup_armed(irq_get_irq_data(acpi_sci_irq)))
+		pm_system_cancel_wakeup();
+}
+
+static void acpi_freeze_sync(void)
+{
+	/*
+	 * Process all pending events in case there are any wakeup ones.
+	 *
+	 * The EC driver uses the system workqueue, so that one needs to be
+	 * flushed too.
+	 */
+	acpi_os_wait_events_complete();
+	flush_scheduled_work();
+}
+
 static void acpi_freeze_restore(void)
 {
 	acpi_disable_wakeup_devices(ACPI_STATE_S0);
 	if (acpi_sci_irq_valid())
 		disable_irq_wake(acpi_sci_irq);
+
 	acpi_enable_all_runtime_gpes();
 }
 
@@ -681,6 +707,8 @@ static void acpi_freeze_end(void)
 static const struct platform_freeze_ops acpi_freeze_ops = {
 	.begin = acpi_freeze_begin,
 	.prepare = acpi_freeze_prepare,
+	.wake = acpi_freeze_wake,
+	.sync = acpi_freeze_sync,
 	.restore = acpi_freeze_restore,
 	.end = acpi_freeze_end,
 };
Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -24,6 +24,7 @@
 #include <linux/pm_qos.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/suspend.h>
 
 #include "internal.h"
 
@@ -399,7 +400,7 @@ static void acpi_pm_notify_handler(acpi_
 	mutex_lock(&acpi_pm_notifier_lock);
 
 	if (adev->wakeup.flags.notifier_present) {
-		__pm_wakeup_event(adev->wakeup.ws, 0);
+		pm_wakeup_ws_event(adev->wakeup.ws, 0, true);
 		if (adev->wakeup.context.work.func)
 			queue_pm_work(&adev->wakeup.context.work);
 	}
Index: linux-pm/drivers/acpi/button.c
===================================================================
--- linux-pm.orig/drivers/acpi/button.c
+++ linux-pm/drivers/acpi/button.c
@@ -216,7 +216,7 @@ static int acpi_lid_notify_state(struct
 	}
 
 	if (state)
-		pm_wakeup_event(&device->dev, 0);
+		pm_wakeup_hard_event(&device->dev);
 
 	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
 	if (ret == NOTIFY_DONE)
@@ -398,7 +398,7 @@ static void acpi_button_notify(struct ac
 		} else {
 			int keycode;
 
-			pm_wakeup_event(&device->dev, 0);
+			pm_wakeup_hard_event(&device->dev);
 			if (button->suspended)
 				break;
 
@@ -530,6 +530,7 @@ static int acpi_button_add(struct acpi_d
 		lid_device = device;
 	}
 
+	device_init_wakeup(&device->dev, true);
 	printk(KERN_INFO PREFIX "%s [%s]\n", name, acpi_device_bid(device));
 	return 0;
 
Index: linux-pm/drivers/acpi/battery.c
===================================================================
--- linux-pm.orig/drivers/acpi/battery.c
+++ linux-pm/drivers/acpi/battery.c
@@ -782,7 +782,7 @@ static int acpi_battery_update(struct ac
 	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
 	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
             (battery->capacity_now <= battery->alarm)))
-		pm_wakeup_event(&battery->device->dev, 0);
+		pm_wakeup_hard_event(&battery->device->dev);
 
 	return result;
 }

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/4] PM / core: Split dpm_suspend_noirq() and dpm_resume_noirq()
Date: Fri, 21 Jul 2017 02:09:22 +0200
Message-ID: <2637300.76LCBDfMZE@aspire.rjw.lan>
References: <1846472.PIoZyNk2cf@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1846472.PIoZyNk2cf@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Put the device interrupts disabling and enabling as well as
cpuidle_pause() and cpuidle_resume() called during the "noirq"
stages of system suspend into separate functions to allow the
core suspend-to-idle code to be optimized (later).

The only functional difference this makes is that debug facilities
and diagnostic tools will not include the above operations into the
"noirq" device suspend/resume duration measurements.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   67 +++++++++++++++++++++++++++++++---------------
 include/linux/pm.h        |    4 ++
 2 files changed, 50 insertions(+), 21 deletions(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -598,14 +598,7 @@ static void async_resume_noirq(void *dat
 	put_device(dev);
 }
 
-/**
- * dpm_resume_noirq - Execute "noirq resume" callbacks for all devices.
- * @state: PM transition of the system being carried out.
- *
- * Call the "noirq" resume handlers for all devices in dpm_noirq_list and
- * enable device drivers to receive interrupts.
- */
-void dpm_resume_noirq(pm_message_t state)
+void dpm_noirq_resume_devices(pm_message_t state)
 {
 	struct device *dev;
 	ktime_t starttime = ktime_get();
@@ -651,10 +644,27 @@ void dpm_resume_noirq(pm_message_t state
 	mutex_unlock(&dpm_list_mtx);
 	async_synchronize_full();
 	dpm_show_time(starttime, state, "noirq");
+	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
+}
+
+void dpm_noirq_end(void)
+{
 	resume_device_irqs();
 	device_wakeup_disarm_wake_irqs();
 	cpuidle_resume();
-	trace_suspend_resume(TPS("dpm_resume_noirq"), state.event, false);
+}
+
+/**
+ * dpm_resume_noirq - Execute "noirq resume" callbacks for all devices.
+ * @state: PM transition of the system being carried out.
+ *
+ * Invoke the "noirq" resume callbacks for all devices in dpm_noirq_list and
+ * allow device drivers' interrupt handlers to be called.
+ */
+void dpm_resume_noirq(pm_message_t state)
+{
+	dpm_noirq_resume_devices(state);
+	dpm_noirq_end();
 }
 
 /**
@@ -1154,22 +1164,19 @@ static int device_suspend_noirq(struct d
 	return __device_suspend_noirq(dev, pm_transition, false);
 }
 
-/**
- * dpm_suspend_noirq - Execute "noirq suspend" callbacks for all devices.
- * @state: PM transition of the system being carried out.
- *
- * Prevent device drivers from receiving interrupts and call the "noirq" suspend
- * handlers for all non-sysdev devices.
- */
-int dpm_suspend_noirq(pm_message_t state)
+void dpm_noirq_begin(void)
+{
+	cpuidle_pause();
+	device_wakeup_arm_wake_irqs();
+	suspend_device_irqs();
+}
+
+int dpm_noirq_suspend_devices(pm_message_t state)
 {
 	ktime_t starttime = ktime_get();
 	int error = 0;
 
 	trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, true);
-	cpuidle_pause();
-	device_wakeup_arm_wake_irqs();
-	suspend_device_irqs();
 	mutex_lock(&dpm_list_mtx);
 	pm_transition = state;
 	async_error = 0;
@@ -1204,7 +1211,6 @@ int dpm_suspend_noirq(pm_message_t state
 	if (error) {
 		suspend_stats.failed_suspend_noirq++;
 		dpm_save_failed_step(SUSPEND_SUSPEND_NOIRQ);
-		dpm_resume_noirq(resume_event(state));
 	} else {
 		dpm_show_time(starttime, state, "noirq");
 	}
@@ -1213,6 +1219,25 @@ int dpm_suspend_noirq(pm_message_t state
 }
 
 /**
+ * dpm_suspend_noirq - Execute "noirq suspend" callbacks for all devices.
+ * @state: PM transition of the system being carried out.
+ *
+ * Prevent device drivers' interrupt handlers from being called and invoke
+ * "noirq" suspend callbacks for all non-sysdev devices.
+ */
+int dpm_suspend_noirq(pm_message_t state)
+{
+	int ret;
+
+	dpm_noirq_begin();
+	ret = dpm_noirq_suspend_devices(state);
+	if (ret)
+		dpm_resume_noirq(resume_event(state));
+
+	return ret;
+}
+
+/**
  * device_suspend_late - Execute a "late suspend" callback for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
Index: linux-pm/include/linux/pm.h
===================================================================
--- linux-pm.orig/include/linux/pm.h
+++ linux-pm/include/linux/pm.h
@@ -689,6 +689,8 @@ struct dev_pm_domain {
 extern void device_pm_lock(void);
 extern void dpm_resume_start(pm_message_t state);
 extern void dpm_resume_end(pm_message_t state);
+extern void dpm_noirq_resume_devices(pm_message_t state);
+extern void dpm_noirq_end(void);
 extern void dpm_resume_noirq(pm_message_t state);
 extern void dpm_resume_early(pm_message_t state);
 extern void dpm_resume(pm_message_t state);
@@ -697,6 +699,8 @@ extern void dpm_complete(pm_message_t st
 extern void device_pm_unlock(void);
 extern int dpm_suspend_end(pm_message_t state);
 extern int dpm_suspend_start(pm_message_t state);
+extern void dpm_noirq_begin(void);
+extern int dpm_noirq_suspend_devices(pm_message_t state);
 extern int dpm_suspend_noirq(pm_message_t state);
 extern int dpm_suspend_late(pm_message_t state);
 extern int dpm_suspend(pm_message_t state);

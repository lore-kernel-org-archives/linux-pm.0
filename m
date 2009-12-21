From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/5] PM: Make the initcall_debug style timing for
	suspend/resume complete
Date: Mon, 21 Dec 2009 22:03:15 +0100
Message-ID: <200912212203.15198.rjw__16522.1298965209$1261430015$gmane$org@sisk.pl>
References: <200912212201.47920.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912212201.47920.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Commit f2511774863487e61b56a97da07ebf8dd61d7836
(PM: Add initcall_debug style timing for suspend/resume) introduced
basic timing instrumentation, needed for a scritps/bootgraph.pl
equivalent or humans, but it missed the fact that bus types and
device classes which haven't been switched to using struct dev_pm_ops
objects yet need special handling.  As a result, the suspend/resume
timing information is only available for devices whose bus types or
device classes use struct dev_pm_ops objects, so the majority of
devices is not covered.

Fix this by adding basic suspend/resume timing instrumentation for
devices whose bus types and device classes still don't use struct
dev_pm_ops objects for power management.  To reduce code duplication
move the timing code to helper functions.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/main.c |   97 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 20 deletions(-)

Index: linux-2.6/drivers/base/power/main.c
===================================================================
--- linux-2.6.orig/drivers/base/power/main.c
+++ linux-2.6/drivers/base/power/main.c
@@ -161,6 +161,32 @@ void device_pm_move_last(struct device *
 	list_move_tail(&dev->power.entry, &dpm_list);
 }
 
+static ktime_t initcall_debug_start(struct device *dev)
+{
+	ktime_t calltime = ktime_set(0, 0);
+
+	if (initcall_debug) {
+		pr_info("calling  %s+ @ %i\n",
+				dev_name(dev), task_pid_nr(current));
+		calltime = ktime_get();
+	}
+
+	return calltime;
+}
+
+static void initcall_debug_report(struct device *dev, ktime_t calltime,
+				  int error)
+{
+	ktime_t delta, rettime;
+
+	if (initcall_debug) {
+		rettime = ktime_get();
+		delta = ktime_sub(rettime, calltime);
+		pr_info("call %s+ returned %d after %Ld usecs\n", dev_name(dev),
+			error, (unsigned long long)ktime_to_ns(delta) >> 10);
+	}
+}
+
 /**
  * pm_op - Execute the PM operation appropriate for given PM event.
  * @dev: Device to handle.
@@ -172,13 +198,9 @@ static int pm_op(struct device *dev,
 		 pm_message_t state)
 {
 	int error = 0;
-	ktime_t calltime, delta, rettime;
+	ktime_t calltime;
 
-	if (initcall_debug) {
-		pr_info("calling  %s+ @ %i\n",
-				dev_name(dev), task_pid_nr(current));
-		calltime = ktime_get();
-	}
+	calltime = initcall_debug_start(dev);
 
 	switch (state.event) {
 #ifdef CONFIG_SUSPEND
@@ -227,12 +249,7 @@ static int pm_op(struct device *dev,
 		error = -EINVAL;
 	}
 
-	if (initcall_debug) {
-		rettime = ktime_get();
-		delta = ktime_sub(rettime, calltime);
-		pr_info("call %s+ returned %d after %Ld usecs\n", dev_name(dev),
-			error, (unsigned long long)ktime_to_ns(delta) >> 10);
-	}
+	initcall_debug_report(dev, calltime, error);
 
 	return error;
 }
@@ -309,8 +326,9 @@ static int pm_noirq_op(struct device *de
 	if (initcall_debug) {
 		rettime = ktime_get();
 		delta = ktime_sub(rettime, calltime);
-		printk("initcall %s_i+ returned %d after %Ld usecs\n", dev_name(dev),
-			error, (unsigned long long)ktime_to_ns(delta) >> 10);
+		printk("initcall %s_i+ returned %d after %Ld usecs\n",
+			dev_name(dev), error,
+			(unsigned long long)ktime_to_ns(delta) >> 10);
 	}
 
 	return error;
@@ -408,6 +426,26 @@ void dpm_resume_noirq(pm_message_t state
 EXPORT_SYMBOL_GPL(dpm_resume_noirq);
 
 /**
+ * legacy_resume - Execute a legacy (bus or class) resume callback for device.
+ * dev: Device to resume.
+ * cb: Resume callback to execute.
+ */
+static int legacy_resume(struct device *dev, int (*cb)(struct device *dev))
+{
+	int error;
+	ktime_t calltime;
+
+	calltime = initcall_debug_start(dev);
+
+	error = cb(dev);
+	suspend_report_result(cb, error);
+
+	initcall_debug_report(dev, calltime, error);
+
+	return error;
+}
+
+/**
  * device_resume - Execute "resume" callbacks for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
@@ -427,7 +465,7 @@ static int device_resume(struct device *
 			error = pm_op(dev, dev->bus->pm, state);
 		} else if (dev->bus->resume) {
 			pm_dev_dbg(dev, state, "legacy ");
-			error = dev->bus->resume(dev);
+			error = legacy_resume(dev, dev->bus->resume);
 		}
 		if (error)
 			goto End;
@@ -448,7 +486,7 @@ static int device_resume(struct device *
 			error = pm_op(dev, dev->class->pm, state);
 		} else if (dev->class->resume) {
 			pm_dev_dbg(dev, state, "legacy class ");
-			error = dev->class->resume(dev);
+			error = legacy_resume(dev, dev->class->resume);
 		}
 	}
  End:
@@ -648,6 +686,27 @@ int dpm_suspend_noirq(pm_message_t state
 EXPORT_SYMBOL_GPL(dpm_suspend_noirq);
 
 /**
+ * legacy_suspend - Execute a legacy (bus or class) suspend callback for device.
+ * dev: Device to suspend.
+ * cb: Suspend callback to execute.
+ */
+static int legacy_suspend(struct device *dev, pm_message_t state,
+			  int (*cb)(struct device *dev, pm_message_t state))
+{
+	int error;
+	ktime_t calltime;
+
+	calltime = initcall_debug_start(dev);
+
+	error = cb(dev, state);
+	suspend_report_result(cb, error);
+
+	initcall_debug_report(dev, calltime, error);
+
+	return error;
+}
+
+/**
  * device_suspend - Execute "suspend" callbacks for given device.
  * @dev: Device to handle.
  * @state: PM transition of the system being carried out.
@@ -664,8 +723,7 @@ static int device_suspend(struct device 
 			error = pm_op(dev, dev->class->pm, state);
 		} else if (dev->class->suspend) {
 			pm_dev_dbg(dev, state, "legacy class ");
-			error = dev->class->suspend(dev, state);
-			suspend_report_result(dev->class->suspend, error);
+			error = legacy_suspend(dev, state, dev->class->suspend);
 		}
 		if (error)
 			goto End;
@@ -686,8 +744,7 @@ static int device_suspend(struct device 
 			error = pm_op(dev, dev->bus->pm, state);
 		} else if (dev->bus->suspend) {
 			pm_dev_dbg(dev, state, "legacy ");
-			error = dev->bus->suspend(dev, state);
-			suspend_report_result(dev->bus->suspend, error);
+			error = legacy_suspend(dev, state, dev->bus->suspend);
 		}
 	}
  End:

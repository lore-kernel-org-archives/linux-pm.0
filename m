From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 2/7] PM: move code in power/runtime.c
Date: Fri, 24 Sep 2010 16:38:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1009241635160.1287-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1421) moves the PM runtime accounting subroutines up to
the beginning of runtime.c, taking them out of the middle of the
functions that do the actual work.  No operational changes.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -15,6 +15,44 @@ static int __pm_request_idle(struct devi
 static int __pm_request_resume(struct device *dev);
 
 /**
+ * update_pm_runtime_accounting - Update the time accounting of power states
+ * @dev: Device to update the accounting for
+ *
+ * In order to be able to have time accounting of the various power states
+ * (as used by programs such as PowerTOP to show the effectiveness of runtime
+ * PM), we need to track the time spent in each state.
+ * update_pm_runtime_accounting must be called each time before the
+ * runtime_status field is updated, to account the time in the old state
+ * correctly.
+ */
+void update_pm_runtime_accounting(struct device *dev)
+{
+	unsigned long now = jiffies;
+	int delta;
+
+	delta = now - dev->power.accounting_timestamp;
+
+	if (delta < 0)
+		delta = 0;
+
+	dev->power.accounting_timestamp = now;
+
+	if (dev->power.disable_depth > 0)
+		return;
+
+	if (dev->power.runtime_status == RPM_SUSPENDED)
+		dev->power.suspended_jiffies += delta;
+	else
+		dev->power.active_jiffies += delta;
+}
+
+static void __update_runtime_status(struct device *dev, enum rpm_status status)
+{
+	update_pm_runtime_accounting(dev);
+	dev->power.runtime_status = status;
+}
+
+/**
  * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
  * @dev: Device to handle.
  */
@@ -123,45 +161,6 @@ int pm_runtime_idle(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(pm_runtime_idle);
 
-
-/**
- * update_pm_runtime_accounting - Update the time accounting of power states
- * @dev: Device to update the accounting for
- *
- * In order to be able to have time accounting of the various power states
- * (as used by programs such as PowerTOP to show the effectiveness of runtime
- * PM), we need to track the time spent in each state.
- * update_pm_runtime_accounting must be called each time before the
- * runtime_status field is updated, to account the time in the old state
- * correctly.
- */
-void update_pm_runtime_accounting(struct device *dev)
-{
-	unsigned long now = jiffies;
-	int delta;
-
-	delta = now - dev->power.accounting_timestamp;
-
-	if (delta < 0)
-		delta = 0;
-
-	dev->power.accounting_timestamp = now;
-
-	if (dev->power.disable_depth > 0)
-		return;
-
-	if (dev->power.runtime_status == RPM_SUSPENDED)
-		dev->power.suspended_jiffies += delta;
-	else
-		dev->power.active_jiffies += delta;
-}
-
-static void __update_runtime_status(struct device *dev, enum rpm_status status)
-{
-	update_pm_runtime_accounting(dev);
-	dev->power.runtime_status = status;
-}
-
 /**
  * __pm_runtime_suspend - Carry out run-time suspend of given device.
  * @dev: Device to suspend.

From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PM: allow for usage_count > 0 in pm_runtime_get()
Date: Mon, 30 Nov 2009 11:35:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0911301132520.4478-100000@iolanthe.rowland.org>
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

This patch (as1308) fixes __pm_runtime_get().  Currently the routine
will resume a device if the prior usage count was 0.  But this isn't
right; thanks to pm_runtime_get_noresume() the usage count can be
positive even while the device is suspended.

Now the routine always tries to carry out a resume when called
synchronously.  When called asynchronously, it avoids the overhead of
an unnecessary spinlock acquisition by doing the resume only if the
device's state was SUSPENDING or SUSPENDED.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/base/power/runtime.c
===================================================================
--- usb-2.6.orig/drivers/base/power/runtime.c
+++ usb-2.6/drivers/base/power/runtime.c
@@ -703,16 +703,22 @@ EXPORT_SYMBOL_GPL(pm_request_resume);
  * @dev: Device to handle.
  * @sync: If set and the device is suspended, resume it synchronously.
  *
- * Increment the usage count of the device and if it was zero previously,
- * resume it or submit a resume request for it, depending on the value of @sync.
+ * Increment the usage count of the device.  If @sync is set, resume the device
+ * and wait for the resume to complete.  Otherwise if the device is currently
+ * suspending or suspended, submit a resume request.
+ *
+ * If @sync is clear, the caller is responsible for synchronization.
  */
 int __pm_runtime_get(struct device *dev, bool sync)
 {
-	int retval = 1;
-
-	if (atomic_add_return(1, &dev->power.usage_count) == 1)
-		retval = sync ? pm_runtime_resume(dev) : pm_request_resume(dev);
+	int retval = 0;
 
+	atomic_inc(&dev->power.usage_count);
+	if (sync)
+		retval = pm_runtime_resume(dev);
+	else if (dev->power.runtime_status == RPM_SUSPENDING ||
+	    dev->power.runtime_status == RPM_SUSPENDED)
+		retval = pm_request_resume(dev);
 	return retval;
 }
 EXPORT_SYMBOL_GPL(__pm_runtime_get);
Index: usb-2.6/Documentation/power/runtime_pm.txt
===================================================================
--- usb-2.6.orig/Documentation/power/runtime_pm.txt
+++ usb-2.6/Documentation/power/runtime_pm.txt
@@ -276,8 +276,9 @@ drivers/base/power/runtime.c and include
     - increment the device's usage counter
 
   int pm_runtime_get(struct device *dev);
-    - increment the device's usage counter, run pm_request_resume(dev) and
-      return its result
+    - increment the device's usage counter; if the device is currently
+      suspending or suspended then run pm_request_resume(dev) and return its
+      result
 
   int pm_runtime_get_sync(struct device *dev);
     - increment the device's usage counter, run pm_runtime_resume(dev) and

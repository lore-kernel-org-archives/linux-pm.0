From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Wed, 03 Jan 2018 12:06:40 +0100
Message-ID: <303007688.lvsDLFNCpe@aspire.rjw.lan>
References: <4069324.Q7yJt6I4hJ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:52059 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbeACLHq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jan 2018 06:07:46 -0500
In-Reply-To: <4069324.Q7yJt6I4hJ@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lukas Wunner <lukas@wunner.de>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One of the limitations of pm_runtime_force_suspend/resume() is that
if a parent driver wants to use these functions, all of its child
drivers have to do that too because of the parent usage counter
manipulations necessary to get the correct state of the parent during
system-wide transitions to the working state (system resume).
However, that limitation turns out to be artificial, so remove it.

Namely, pm_runtime_force_suspend() only needs to update the children
counter of its parent (if there's is a parent) when the device can
stay in suspend after the subsequent system resume transition, as
that counter is correct already otherwise.  Now, if the parent's
children counter is not updated, it is not necessary to increment
the parent's usage counter in that case any more, as long as the
children counters of devices are checked along with their usage
counters in order to decide whether or not the devices may be left
in suspend after the subsequent system resume transition.

Accordingly, modify pm_runtime_force_suspend() to only call
pm_runtime_set_suspended() for devices whose usage and children
counters are at the "no references" level (the runtime PM status
of the device needs to be updated to "suspended" anyway in case
this function is called once again for the same device during the
transition under way), drop the parent usage counter incrementation
from it and update pm_runtime_force_resume() to compensate for these
changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   74 +++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 40 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1613,17 +1613,28 @@ void pm_runtime_drop_link(struct device
 	spin_unlock_irq(&dev->power.lock);
 }
 
+static bool pm_runtime_need_not_resume(struct device *dev)
+{
+	return atomic_read(&dev->power.usage_count) <= 1 &&
+		atomic_read(&dev->power.child_count) == 0;
+}
+
 /**
  * pm_runtime_force_suspend - Force a device into suspend state if needed.
  * @dev: Device to suspend.
  *
  * Disable runtime PM so we safely can check the device's runtime PM status and
- * if it is active, invoke it's .runtime_suspend callback to bring it into
- * suspend state. Keep runtime PM disabled to preserve the state unless we
- * encounter errors.
+ * if it is active, invoke its ->runtime_suspend callback to suspend it and
+ * change its runtime PM status field to RPM_SUSPENDED.  Also, if the device's
+ * usage and children counters don't indicate that the device was in use before
+ * the system-wide transition under way, decrement its parent's children counter
+ * (if there is a parent).  Keep runtime PM disabled to preserve the state
+ * unless we encounter errors.
  *
  * Typically this function may be invoked from a system suspend callback to make
- * sure the device is put into low power state.
+ * sure the device is put into low power state and it should only be used during
+ * system-wide PM transitions to sleep states.  It assumes that the analogous
+ * pm_runtime_force_resume() will be used to resume the device.
  */
 int pm_runtime_force_suspend(struct device *dev)
 {
@@ -1646,17 +1657,18 @@ int pm_runtime_force_suspend(struct devi
 		goto err;
 
 	/*
-	 * Increase the runtime PM usage count for the device's parent, in case
-	 * when we find the device being used when system suspend was invoked.
-	 * This informs pm_runtime_force_resume() to resume the parent
-	 * immediately, which is needed to be able to resume its children,
-	 * when not deferring the resume to be managed via runtime PM.
+	 * If the device can stay in suspend after the system-wide transition
+	 * to the working state that will follow, drop the children counter of
+	 * its parent, but set its status to RPM_SUSPENDED anyway in case this
+	 * function will be called again for it in the meantime.
 	 */
-	if (dev->parent && atomic_read(&dev->power.usage_count) > 1)
-		pm_runtime_get_noresume(dev->parent);
+	if (pm_runtime_need_not_resume(dev))
+		pm_runtime_set_suspended(dev);
+	else
+		__update_runtime_status(dev, RPM_SUSPENDED);
 
-	pm_runtime_set_suspended(dev);
 	return 0;
+
 err:
 	pm_runtime_enable(dev);
 	return ret;
@@ -1669,13 +1681,9 @@ EXPORT_SYMBOL_GPL(pm_runtime_force_suspe
  *
  * Prior invoking this function we expect the user to have brought the device
  * into low power state by a call to pm_runtime_force_suspend(). Here we reverse
- * those actions and brings the device into full power, if it is expected to be
- * used on system resume. To distinguish that, we check whether the runtime PM
- * usage count is greater than 1 (the PM core increases the usage count in the
- * system PM prepare phase), as that indicates a real user (such as a subsystem,
- * driver, userspace, etc.) is using it. If that is the case, the device is
- * expected to be used on system resume as well, so then we resume it. In the
- * other case, we defer the resume to be managed via runtime PM.
+ * those actions and bring the device into full power, if it is expected to be
+ * used on system resume.  In the other case, we defer the resume to be managed
+ * via runtime PM.
  *
  * Typically this function may be invoked from a system resume callback.
  */
@@ -1684,32 +1692,18 @@ int pm_runtime_force_resume(struct devic
 	int (*callback)(struct device *);
 	int ret = 0;
 
-	callback = RPM_GET_CALLBACK(dev, runtime_resume);
-
-	if (!callback) {
-		ret = -ENOSYS;
-		goto out;
-	}
-
-	if (!pm_runtime_status_suspended(dev))
+	if (!pm_runtime_status_suspended(dev) || pm_runtime_need_not_resume(dev))
 		goto out;
 
 	/*
-	 * Decrease the parent's runtime PM usage count, if we increased it
-	 * during system suspend in pm_runtime_force_suspend().
-	*/
-	if (atomic_read(&dev->power.usage_count) > 1) {
-		if (dev->parent)
-			pm_runtime_put_noidle(dev->parent);
-	} else {
-		goto out;
-	}
+	 * The value of the parent's children counter is correct already, so
+	 * just update the status of the device.
+	 */
+	__update_runtime_status(dev, RPM_ACTIVE);
 
-	ret = pm_runtime_set_active(dev);
-	if (ret)
-		goto out;
+	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
-	ret = callback(dev);
+	ret = callback ? callback(dev) : -ENOSYS;
 	if (ret) {
 		pm_runtime_set_suspended(dev);
 		goto out;

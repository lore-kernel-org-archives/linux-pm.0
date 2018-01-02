From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / runtime: Rework pm_runtime_force_suspend/resume()
Date: Tue, 02 Jan 2018 01:56:28 +0100
Message-ID: <4069324.Q7yJt6I4hJ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:56649 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753401AbeABA5c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jan 2018 19:57:32 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One of the limitations of pm_runtime_force_suspend/resume() is that
if a parent driver wants to use these functions, all of its child
drivers have to do that too because of the parent usage counter
manipulations necessary to get the correct state of the parent during
system-wide transitions to the working state (system resume).
However, that limitation turns out to be artificial, so remove it.

First, notice that it is not really necessary to change the device's
runtime PM status in pm_runtime_force_suspend().  Moreover, if
pm_runtime_set_suspended() is not called for a device, the children
counter of its parent (if there is a parent) will not drop, so it
is not necessary to increment the parent's usage counter in that
case, as long as the children counters of devices are checked
along with their usage counters in order to decide whether or not
the devices may be left in suspend on the way out (that is, during
the subsequent system-wide transition to the working state).

Accordingly, modify pm_runtime_force_suspend() to only call
pm_runtime_set_suspended() for devices whose usage and children
counters are at the "no references" level and drop the parent usage
counter incrementation from it.

Second, notice that with the above change in pm_runtime_force_suspend(),
if the runtime PM status of the device in pm_runtime_force_resume() is
"suspended", then either the device had remained in runtime suspend
before pm_runtime_force_suspend() was called for it (in which case it
is safe to leave it in suspend), or its runtime PM status has been
changed by pm_runtime_force_suspend() itself.  Of course, the latter
case is only possible if the usage and children counters of the device
are at the "no reference" levels, so the device may be left in suspend
then.

In turn, if the runtime PM status of the device in
pm_runtime_force_resume() is "active", pm_runtime_force_suspend()
called for it previously found active references to it, so it needs
to be resumed.

Hence, with the above change in pm_runtime_force_suspend(),
pm_runtime_force_resume() only needs to check the device's runtime PM
status to decide whether or not to resume it and it doesn't need to
manipulate the device parent's usage counter any more, so modify it
accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   61 +++++++++++++------------------------------
 1 file changed, 19 insertions(+), 42 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1618,12 +1618,15 @@ void pm_runtime_drop_link(struct device
  * @dev: Device to suspend.
  *
  * Disable runtime PM so we safely can check the device's runtime PM status and
- * if it is active, invoke it's .runtime_suspend callback to bring it into
- * suspend state. Keep runtime PM disabled to preserve the state unless we
- * encounter errors.
+ * if it is active, invoke it's ->runtime_suspend callback to suspend it.  Also,
+ * if the device's usage and children counters don't indicate that the device
+ * was in use before the system-wide transition under way, change its runtime PM
+ * status to suspended after suspending it.  Keep runtime PM disabled to
+ * preserve the state unless we encounter errors.
  *
  * Typically this function may be invoked from a system suspend callback to make
- * sure the device is put into low power state.
+ * sure the device is put into low power state.  It assumes that the analogous
+ * pm_runtime_force_resume() will be used to resume the device.
  */
 int pm_runtime_force_suspend(struct device *dev)
 {
@@ -1645,18 +1648,12 @@ int pm_runtime_force_suspend(struct devi
 	if (ret)
 		goto err;
 
-	/*
-	 * Increase the runtime PM usage count for the device's parent, in case
-	 * when we find the device being used when system suspend was invoked.
-	 * This informs pm_runtime_force_resume() to resume the parent
-	 * immediately, which is needed to be able to resume its children,
-	 * when not deferring the resume to be managed via runtime PM.
-	 */
-	if (dev->parent && atomic_read(&dev->power.usage_count) > 1)
-		pm_runtime_get_noresume(dev->parent);
+	if (atomic_read(&dev->power.usage_count) <= 1 &&
+	    atomic_read(&dev->power.child_count) == 0)
+		pm_runtime_set_suspended(dev);
 
-	pm_runtime_set_suspended(dev);
 	return 0;
+
 err:
 	pm_runtime_enable(dev);
 	return ret;
@@ -1669,13 +1666,9 @@ EXPORT_SYMBOL_GPL(pm_runtime_force_suspe
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
@@ -1684,6 +1677,9 @@ int pm_runtime_force_resume(struct devic
 	int (*callback)(struct device *);
 	int ret = 0;
 
+	if (pm_runtime_status_suspended(dev))
+		goto out;
+
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
 	if (!callback) {
@@ -1691,31 +1687,12 @@ int pm_runtime_force_resume(struct devic
 		goto out;
 	}
 
-	if (!pm_runtime_status_suspended(dev))
-		goto out;
-
-	/*
-	 * Decrease the parent's runtime PM usage count, if we increased it
-	 * during system suspend in pm_runtime_force_suspend().
-	*/
-	if (atomic_read(&dev->power.usage_count) > 1) {
-		if (dev->parent)
-			pm_runtime_put_noidle(dev->parent);
-	} else {
-		goto out;
-	}
-
-	ret = pm_runtime_set_active(dev);
-	if (ret)
-		goto out;
-
 	ret = callback(dev);
-	if (ret) {
-		pm_runtime_set_suspended(dev);
+	if (ret)
 		goto out;
-	}
 
 	pm_runtime_mark_last_busy(dev);
+
 out:
 	pm_runtime_enable(dev);
 	return ret;

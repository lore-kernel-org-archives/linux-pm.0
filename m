From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC v2] PM / Runtime: Better support for nested irq_safe drivers
Date: Thu, 4 Dec 2014 13:59:31 +0200
Message-ID: <1417694371-9019-1-git-send-email-jsarha@ti.com>
References: <1417551543-15009-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46994 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753500AbaLDL7m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Dec 2014 06:59:42 -0500
In-Reply-To: <1417551543-15009-1-git-send-email-jsarha@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, pavel@ucw.cz, t-kristo@ti.com, tomi.valkeinen@ti.com, stern@rowland.harvard.edu, Jyri Sarha <jsarha@ti.com>

Do not lock parent of irq safe device to enabled state if the parent
is also irq safe.

Before this patch the pm_runtime_irq_safe() always called
pm_runtime_get_sync() for the parent, locking the parent to enabled
state and for sure making any parent irq_safe. This is hardly optimal
if the parent device PM code is also irq_safe.

After this patch the PM runtime core synchronously enables any
irq_safe parents of an irq_safe device when pm_runtime_get_sync() is
called. The parents are checked asyncronously after pm_runtime_put()
call.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
I sent this just for the record and for the sake of the convesation. I
do not expect this patch to get applied as I do not undrestand all the
implication it may have. I can only say that it appears to work well
in our environment (OMAPDSS on omap4+).

 drivers/base/power/runtime.c |   45 +++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 67c7938..6d8802a 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -406,13 +406,14 @@ static int rpm_callback(int (*cb)(struct device *), struct device *dev)
  * or wait for it to finish, depending on the RPM_NOWAIT and RPM_ASYNC
  * flags. If the RPM_ASYNC flag is set then queue a suspend request;
  * otherwise run the ->runtime_suspend() callback directly. When
- * ->runtime_suspend succeeded, if a deferred resume was requested while
- * the callback was running then carry it out, otherwise send an idle
- * notification for its parent (if the suspend succeeded and both
- * ignore_children of parent->power and irq_safe of dev->power are not set).
- * If ->runtime_suspend failed with -EAGAIN or -EBUSY, and if the RPM_AUTO
- * flag is set and the next autosuspend-delay expiration time is in the
- * future, schedule another autosuspend attempt.
+ * ->runtime_suspend succeeded, if a deferred resume was requested
+ * while the callback was running then carry it out, otherwise send an
+ * idle notification for its parent (if the suspend succeeded,
+ * ignore_children of parent->power is not set and irq_safe of
+ * parent->power is set or irq_safe of dev->power is not set).  If
+ * ->runtime_suspend failed with -EAGAIN or -EBUSY, and if the
+ * RPM_AUTO flag is set and the next autosuspend-delay expiration time
+ * is in the future, schedule another autosuspend attempt.
  *
  * This function must be called under dev->power.lock with interrupts disabled.
  */
@@ -541,7 +542,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	}
 
 	/* Maybe the parent is now able to suspend. */
-	if (parent && !parent->power.ignore_children && !dev->power.irq_safe) {
+	if (parent && !parent->power.ignore_children &&
+	    (!dev->power.irq_safe || parent->power.irq_safe)) {
 		spin_unlock(&dev->power.lock);
 
 		spin_lock(&parent->power.lock);
@@ -701,12 +703,13 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 	if (!parent && dev->parent) {
 		/*
-		 * Increment the parent's usage counter and resume it if
-		 * necessary.  Not needed if dev is irq-safe; then the
-		 * parent is permanently resumed.
+		 * Increment the parent's usage counter and resume it
+		 * if necessary.  Not needed if dev is irq-safe and
+		 * its paret is not; then the parent is permanently
+		 * resumed.
 		 */
 		parent = dev->parent;
-		if (dev->power.irq_safe)
+		if (dev->power.irq_safe && !parent->power.irq_safe)
 			goto skip_parent;
 		spin_unlock(&dev->power.lock);
 
@@ -755,7 +758,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 		rpm_idle(dev, RPM_ASYNC);
 
  out:
-	if (parent && !dev->power.irq_safe) {
+	if (parent && (!dev->power.irq_safe || parent->power.irq_safe)) {
 		spin_unlock_irq(&dev->power.lock);
 
 		pm_runtime_put(parent);
@@ -1261,15 +1264,17 @@ EXPORT_SYMBOL_GPL(pm_runtime_no_callbacks);
  * @dev: Device to handle
  *
  * Set the power.irq_safe flag, which tells the PM core that the
- * ->runtime_suspend() and ->runtime_resume() callbacks for this device should
- * always be invoked with the spinlock held and interrupts disabled.  It also
- * causes the parent's usage counter to be permanently incremented, preventing
- * the parent from runtime suspending -- otherwise an irq-safe child might have
- * to wait for a non-irq-safe parent.
+ * ->runtime_suspend() and ->runtime_resume() callbacks for this
+ * device should always be invoked with the spinlock held and
+ * interrupts disabled.  It also causes the parent's usage counter to
+ * be permanently incremented if the parent's power.irq_safe flag is
+ * not set, preventing a non-irq-safe parent from runtime suspending
+ * -- otherwise an irq-safe child might have to wait for a
+ * non-irq-safe parent.
  */
 void pm_runtime_irq_safe(struct device *dev)
 {
-	if (dev->parent)
+	if (dev->parent && !dev->parent->power.irq_safe)
 		pm_runtime_get_sync(dev->parent);
 	spin_lock_irq(&dev->power.lock);
 	dev->power.irq_safe = 1;
@@ -1399,7 +1404,7 @@ void pm_runtime_remove(struct device *dev)
 	/* Change the status back to 'suspended' to match the initial status. */
 	if (dev->power.runtime_status == RPM_ACTIVE)
 		pm_runtime_set_suspended(dev);
-	if (dev->power.irq_safe && dev->parent)
+	if (dev->power.irq_safe && dev->parent && !dev->parent->power.irq_safe)
 		pm_runtime_put(dev->parent);
 }
 #endif
-- 
1.7.9.5


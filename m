From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC] PM / Runtime: Better support for nested irq_safe drivers
Date: Tue, 2 Dec 2014 22:19:03 +0200
Message-ID: <1417551543-15009-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42725 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933038AbaLBUTN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 2 Dec 2014 15:19:13 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, pavel@ucw.cz, t-kristo@ti.com, tomi.valkeinen@ti.com, Jyri Sarha <jsarha@ti.com>

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
 drivers/base/power/runtime.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 67c7938..800ca1e 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -541,7 +541,8 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 	}
 
 	/* Maybe the parent is now able to suspend. */
-	if (parent && !parent->power.ignore_children && !dev->power.irq_safe) {
+	if (parent && !parent->power.ignore_children && 
+	    (!dev->power.irq_safe || parent->power.irq_safe)) {
 		spin_unlock(&dev->power.lock);
 
 		spin_lock(&parent->power.lock);
@@ -706,7 +707,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 		 * parent is permanently resumed.
 		 */
 		parent = dev->parent;
-		if (dev->power.irq_safe)
+		if (dev->power.irq_safe && !parent->power.irq_safe)
 			goto skip_parent;
 		spin_unlock(&dev->power.lock);
 
@@ -755,7 +756,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 		rpm_idle(dev, RPM_ASYNC);
 
  out:
-	if (parent && !dev->power.irq_safe) {
+	if (parent && (!dev->power.irq_safe || parent->power.irq_safe)) {
 		spin_unlock_irq(&dev->power.lock);
 
 		pm_runtime_put(parent);
@@ -1269,7 +1270,7 @@ EXPORT_SYMBOL_GPL(pm_runtime_no_callbacks);
  */
 void pm_runtime_irq_safe(struct device *dev)
 {
-	if (dev->parent)
+	if (dev->parent && !dev->parent->power.irq_safe)
 		pm_runtime_get_sync(dev->parent);
 	spin_lock_irq(&dev->power.lock);
 	dev->power.irq_safe = 1;
@@ -1399,7 +1400,7 @@ void pm_runtime_remove(struct device *dev)
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


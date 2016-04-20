From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH v2] PM / Runtime: Only force-resume device if it has been force-suspended
Date: Thu, 21 Apr 2016 02:52:55 +0300
Message-ID: <1461196375-21768-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from galahad.ideasonboard.com ([185.26.127.97]:33491 "EHLO
	galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbcDTXw6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Apr 2016 19:52:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@kernel.org>, linux-renesas-soc@vger.kernel.org

The pm_runtime_force_suspend() and pm_runtime_force_resume() helpers are
designed to help driver being RPM-centric by offering an easy way to
manage runtime PM state during system suspend and resume. The first
function will force the device into runtime suspend at system suspend
time, while the second one will perform the reverse operation at system
resume time.

However, the pm_runtime_force_resume() really forces resume, regardless
of whether the device was running or already suspended before the call
to pm_runtime_force_suspend(). This results in devices being runtime
resumed at system resume time when they shouldn't.

Fix this by recording whether the device has been forcefully suspended
in pm_runtime_force_suspend() and condition resume in
pm_runtime_force_resume() to that state.

All current users of pm_runtime_force_resume() call the function
unconditionally in their system resume handler (some actually set it as
the resume handler), all after calling pm_runtime_force_suspend() at
system suspend time. The change in behaviour should thus be safe.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/base/power/runtime.c | 19 ++++++++++++++++---
 include/linux/pm.h           |  1 +
 2 files changed, 17 insertions(+), 3 deletions(-)

Changes since v1:

- Fix typos
- Protect the is_force_suspended flag modifications with power.lock

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4c7055009bd6..8fc7fba811fa 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1400,6 +1400,7 @@ void pm_runtime_init(struct device *dev)
 	pm_suspend_ignore_children(dev, false);
 	dev->power.runtime_auto = true;
 
+	dev->power.is_force_suspended = false;
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
@@ -1457,6 +1458,7 @@ void pm_runtime_remove(struct device *dev)
 int pm_runtime_force_suspend(struct device *dev)
 {
 	int (*callback)(struct device *);
+	unsigned long flags;
 	int ret = 0;
 
 	pm_runtime_disable(dev);
@@ -1475,6 +1477,10 @@ int pm_runtime_force_suspend(struct device *dev)
 		goto err;
 
 	pm_runtime_set_suspended(dev);
+	spin_lock_irqsave(&dev->power.lock, flags);
+	dev->power.is_force_suspended = true;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
 	return 0;
 err:
 	pm_runtime_enable(dev);
@@ -1483,13 +1489,13 @@ err:
 EXPORT_SYMBOL_GPL(pm_runtime_force_suspend);
 
 /**
- * pm_runtime_force_resume - Force a device into resume state.
+ * pm_runtime_force_resume - Force a device into resume state if needed.
  * @dev: Device to resume.
  *
  * Prior invoking this function we expect the user to have brought the device
  * into low power state by a call to pm_runtime_force_suspend(). Here we reverse
- * those actions and brings the device into full power. We update the runtime PM
- * status and re-enables runtime PM.
+ * those actions and bring the device back to its runtime PM state before forced
+ * suspension. We update the runtime PM status and re-enable runtime PM.
  *
  * Typically this function may be invoked from a system resume callback to make
  * sure the device is put into full power state.
@@ -1497,8 +1503,12 @@ EXPORT_SYMBOL_GPL(pm_runtime_force_suspend);
 int pm_runtime_force_resume(struct device *dev)
 {
 	int (*callback)(struct device *);
+	unsigned long flags;
 	int ret = 0;
 
+	if (!dev->power.is_force_suspended)
+		goto out;
+
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
 	if (!callback) {
@@ -1510,6 +1520,9 @@ int pm_runtime_force_resume(struct device *dev)
 	if (ret)
 		goto out;
 
+	spin_lock_irqsave(&dev->power.lock, flags);
+	dev->power.is_force_suspended = false;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
 	pm_runtime_set_active(dev);
 	pm_runtime_mark_last_busy(dev);
 out:
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 6a5d654f4447..bec15e0f244e 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -596,6 +596,7 @@ struct dev_pm_info {
 	unsigned int		use_autosuspend:1;
 	unsigned int		timer_autosuspends:1;
 	unsigned int		memalloc_noio:1;
+	unsigned int		is_force_suspended:1;
 	enum rpm_request	request;
 	enum rpm_status		runtime_status;
 	int			runtime_error;
-- 
Regards,

Laurent Pinchart


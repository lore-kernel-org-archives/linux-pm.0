From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/3] PM / Domains: Remove ->save|restore_state() callbacks
Date: Thu, 31 Mar 2016 11:21:27 +0200
Message-ID: <1459416087-23519-4-git-send-email-ulf.hansson@linaro.org>
References: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34178 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103AbcCaJVs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 05:21:48 -0400
Received: by mail-lb0-f177.google.com with SMTP id vo2so48574984lbb.1
        for <linux-pm@vger.kernel.org>; Thu, 31 Mar 2016 02:21:47 -0700 (PDT)
In-Reply-To: <1459416087-23519-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>

As a part of the ongoing consolidation of genpd, it's become questionable
whether clients actually needs to be able to assign their own set of
->save|restore_state() callbacks. Currently all users copes fine with the
default callbacks, so let's remove the configuration option and stick to
the default ones.

This enables further clarifications of the related code and let's also
rename pm_genpd_default_save|restore_state() into
__genpd_runtime_suspend|resume() to apply the rule of static functionnames
in genpd.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 113 +++++++++++++++++++-------------------------
 include/linux/pm_domain.h   |   2 -
 2 files changed, 49 insertions(+), 66 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 75b994a..4ce4ce0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -229,17 +229,6 @@ static int genpd_poweron(struct generic_pm_domain *genpd, unsigned int depth)
 	return ret;
 }
 
-static int genpd_save_dev(struct generic_pm_domain *genpd, struct device *dev)
-{
-	return GENPD_DEV_CALLBACK(genpd, int, save_state, dev);
-}
-
-static int genpd_restore_dev(struct generic_pm_domain *genpd,
-			struct device *dev)
-{
-	return GENPD_DEV_CALLBACK(genpd, int, restore_state, dev);
-}
-
 static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 				     unsigned long val, void *ptr)
 {
@@ -372,6 +361,52 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 }
 
 /**
+ * __genpd_runtime_suspend - walk the hierarchy of ->runtime_suspend() callbacks
+ * @dev: Device to handle.
+ */
+static int __genpd_runtime_suspend(struct device *dev)
+{
+	int (*cb)(struct device *__dev);
+
+	if (dev->type && dev->type->pm)
+		cb = dev->type->pm->runtime_suspend;
+	else if (dev->class && dev->class->pm)
+		cb = dev->class->pm->runtime_suspend;
+	else if (dev->bus && dev->bus->pm)
+		cb = dev->bus->pm->runtime_suspend;
+	else
+		cb = NULL;
+
+	if (!cb && dev->driver && dev->driver->pm)
+		cb = dev->driver->pm->runtime_suspend;
+
+	return cb ? cb(dev) : 0;
+}
+
+/**
+ * __genpd_runtime_resume - walk the hierarchy of ->runtime_resume() callbacks
+ * @dev: Device to handle.
+ */
+static int __genpd_runtime_resume(struct device *dev)
+{
+	int (*cb)(struct device *__dev);
+
+	if (dev->type && dev->type->pm)
+		cb = dev->type->pm->runtime_resume;
+	else if (dev->class && dev->class->pm)
+		cb = dev->class->pm->runtime_resume;
+	else if (dev->bus && dev->bus->pm)
+		cb = dev->bus->pm->runtime_resume;
+	else
+		cb = NULL;
+
+	if (!cb && dev->driver && dev->driver->pm)
+		cb = dev->driver->pm->runtime_resume;
+
+	return cb ? cb(dev) : 0;
+}
+
+/**
  * genpd_runtime_suspend - Suspend a device belonging to I/O PM domain.
  * @dev: Device to suspend.
  *
@@ -409,13 +444,13 @@ static int genpd_runtime_suspend(struct device *dev)
 	if (runtime_pm)
 		time_start = ktime_get();
 
-	ret = genpd_save_dev(genpd, dev);
+	ret = __genpd_runtime_suspend(dev);
 	if (ret)
 		return ret;
 
 	ret = genpd_stop_dev(genpd, dev);
 	if (ret) {
-		genpd_restore_dev(genpd, dev);
+		__genpd_runtime_resume(dev);
 		return ret;
 	}
 
@@ -491,7 +526,7 @@ static int genpd_runtime_resume(struct device *dev)
 	if (ret)
 		goto err_poweroff;
 
-	ret = genpd_restore_dev(genpd, dev);
+	ret = __genpd_runtime_resume(dev);
 	if (ret)
 		goto err_stop;
 
@@ -1427,54 +1462,6 @@ out:
 }
 EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
 
-/* Default device callbacks for generic PM domains. */
-
-/**
- * pm_genpd_default_save_state - Default "save device state" for PM domains.
- * @dev: Device to handle.
- */
-static int pm_genpd_default_save_state(struct device *dev)
-{
-	int (*cb)(struct device *__dev);
-
-	if (dev->type && dev->type->pm)
-		cb = dev->type->pm->runtime_suspend;
-	else if (dev->class && dev->class->pm)
-		cb = dev->class->pm->runtime_suspend;
-	else if (dev->bus && dev->bus->pm)
-		cb = dev->bus->pm->runtime_suspend;
-	else
-		cb = NULL;
-
-	if (!cb && dev->driver && dev->driver->pm)
-		cb = dev->driver->pm->runtime_suspend;
-
-	return cb ? cb(dev) : 0;
-}
-
-/**
- * pm_genpd_default_restore_state - Default PM domains "restore device state".
- * @dev: Device to handle.
- */
-static int pm_genpd_default_restore_state(struct device *dev)
-{
-	int (*cb)(struct device *__dev);
-
-	if (dev->type && dev->type->pm)
-		cb = dev->type->pm->runtime_resume;
-	else if (dev->class && dev->class->pm)
-		cb = dev->class->pm->runtime_resume;
-	else if (dev->bus && dev->bus->pm)
-		cb = dev->bus->pm->runtime_resume;
-	else
-		cb = NULL;
-
-	if (!cb && dev->driver && dev->driver->pm)
-		cb = dev->driver->pm->runtime_resume;
-
-	return cb ? cb(dev) : 0;
-}
-
 /**
  * pm_genpd_init - Initialize a generic I/O PM domain object.
  * @genpd: PM domain object to initialize.
@@ -1520,8 +1507,6 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->domain.ops.restore_early = pm_genpd_resume_early;
 	genpd->domain.ops.restore = pm_genpd_resume;
 	genpd->domain.ops.complete = pm_genpd_complete;
-	genpd->dev_ops.save_state = pm_genpd_default_save_state;
-	genpd->dev_ops.restore_state = pm_genpd_default_restore_state;
 
 	if (genpd->flags & GENPD_FLAG_PM_CLK) {
 		genpd->dev_ops.stop = pm_clk_suspend;
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index e913939..39285c7 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -34,8 +34,6 @@ struct dev_power_governor {
 struct gpd_dev_ops {
 	int (*start)(struct device *dev);
 	int (*stop)(struct device *dev);
-	int (*save_state)(struct device *dev);
-	int (*restore_state)(struct device *dev);
 	bool (*active_wakeup)(struct device *dev);
 };
 
-- 
1.9.1


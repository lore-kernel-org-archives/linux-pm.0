From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] PM / Domains: Allow genpd to power on during the system PM phase
Date: Tue, 26 Apr 2016 14:23:30 +0200
Message-ID: <1461673411-14245-2-git-send-email-ulf.hansson@linaro.org>
References: <1461673411-14245-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33991 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcDZMXr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2016 08:23:47 -0400
Received: by mail-lf0-f53.google.com with SMTP id j11so15704926lfb.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Apr 2016 05:23:46 -0700 (PDT)
In-Reply-To: <1461673411-14245-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

If the PM domain is powered off when the first device in the domain starts
its system PM prepare phase, genpd prevents any further attempts to power
on the PM domain during the system PM phase. This constraint affects not
only the current device which is being prepared, but all devices within
the same PM domain.

This behaviour needs to be changed, as a subsystem/driver for a device in
the same PM domain may still need to be able to serve requests in the
system PM phase. Accordingly, it may need to runtime resume its device and
thus also request the corresponding PM domain to be powered on.

To deal with these scenarios, let's make the device operational in the
system PM prepare phase by runtime resuming it, no matter if the PM domain
was powered on or not. Additionally allow the PM domain to be powered on
via runtime PM during the system PM phase.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 84 +++++++++++++++++----------------------------
 include/linux/pm_domain.h   |  1 -
 2 files changed, 31 insertions(+), 54 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index de23b64..a608f52 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -187,8 +187,7 @@ static int genpd_poweron(struct generic_pm_domain *genpd, unsigned int depth)
 	struct gpd_link *link;
 	int ret = 0;
 
-	if (genpd->status == GPD_STATE_ACTIVE
-	    || (genpd->prepared_count > 0 && genpd->suspend_power_off))
+	if (genpd->status == GPD_STATE_ACTIVE)
 		return 0;
 
 	/*
@@ -735,21 +734,22 @@ static int pm_genpd_prepare(struct device *dev)
 
 	mutex_lock(&genpd->lock);
 
-	if (genpd->prepared_count++ == 0) {
+	if (genpd->prepared_count++ == 0)
 		genpd->suspended_count = 0;
-		genpd->suspend_power_off = genpd->status == GPD_STATE_POWER_OFF;
-	}
 
 	mutex_unlock(&genpd->lock);
 
-	if (genpd->suspend_power_off)
-		return 0;
-
 	/*
-	 * The PM domain must be in the GPD_STATE_ACTIVE state at this point,
-	 * so genpd_poweron() will return immediately, but if the device
-	 * is suspended (e.g. it's been stopped by genpd_stop_dev()), we need
-	 * to make it operational.
+	 * Even if the PM domain is powered off at this point, we can't expect
+	 * it to remain in that state during the entire system PM suspend
+	 * phase. Any subsystem/driver for a device in the PM domain, may still
+	 * need to serve a request which may require the device to be runtime
+	 * resumed and its PM domain to be powered.
+	 *
+	 * As we are disabling runtime PM at this point, we are preventing the
+	 * subsystem/driver to decide themselves. For that reason, we need to
+	 * make sure the device is operational as it may be required in some
+	 * cases.
 	 */
 	pm_runtime_resume(dev);
 	__pm_runtime_disable(dev, false);
@@ -758,8 +758,7 @@ static int pm_genpd_prepare(struct device *dev)
 	if (ret) {
 		mutex_lock(&genpd->lock);
 
-		if (--genpd->prepared_count == 0)
-			genpd->suspend_power_off = false;
+		genpd->prepared_count--;
 
 		mutex_unlock(&genpd->lock);
 		pm_runtime_enable(dev);
@@ -786,7 +785,7 @@ static int pm_genpd_suspend(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : pm_generic_suspend(dev);
+	return pm_generic_suspend(dev);
 }
 
 /**
@@ -807,7 +806,7 @@ static int pm_genpd_suspend_late(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : pm_generic_suspend_late(dev);
+	return pm_generic_suspend_late(dev);
 }
 
 /**
@@ -827,8 +826,7 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (genpd->suspend_power_off
-	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
+	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
 		return 0;
 
 	genpd_stop_dev(genpd, dev);
@@ -860,8 +858,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (genpd->suspend_power_off
-	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
+	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
 		return 0;
 
 	/*
@@ -894,7 +891,7 @@ static int pm_genpd_resume_early(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : pm_generic_resume_early(dev);
+	return pm_generic_resume_early(dev);
 }
 
 /**
@@ -915,7 +912,7 @@ static int pm_genpd_resume(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : pm_generic_resume(dev);
+	return pm_generic_resume(dev);
 }
 
 /**
@@ -936,7 +933,7 @@ static int pm_genpd_freeze(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : pm_generic_freeze(dev);
+	return pm_generic_freeze(dev);
 }
 
 /**
@@ -958,7 +955,7 @@ static int pm_genpd_freeze_late(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : pm_generic_freeze_late(dev);
+	return pm_generic_freeze_late(dev);
 }
 
 /**
@@ -980,7 +977,7 @@ static int pm_genpd_freeze_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_stop_dev(genpd, dev);
+	return genpd_stop_dev(genpd, dev);
 }
 
 /**
@@ -1000,8 +997,7 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ?
-		0 : genpd_start_dev(genpd, dev);
+	return genpd_start_dev(genpd, dev);
 }
 
 /**
@@ -1023,7 +1019,7 @@ static int pm_genpd_thaw_early(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : pm_generic_thaw_early(dev);
+	return pm_generic_thaw_early(dev);
 }
 
 /**
@@ -1044,7 +1040,7 @@ static int pm_genpd_thaw(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : pm_generic_thaw(dev);
+	return pm_generic_thaw(dev);
 }
 
 /**
@@ -1072,26 +1068,13 @@ static int pm_genpd_restore_noirq(struct device *dev)
 	 * At this point suspended_count == 0 means we are being run for the
 	 * first time for the given domain in the present cycle.
 	 */
-	if (genpd->suspended_count++ == 0) {
+	if (genpd->suspended_count++ == 0)
 		/*
 		 * The boot kernel might put the domain into arbitrary state,
 		 * so make it appear as powered off to pm_genpd_sync_poweron(),
 		 * so that it tries to power it on in case it was really off.
 		 */
 		genpd->status = GPD_STATE_POWER_OFF;
-		if (genpd->suspend_power_off) {
-			/*
-			 * If the domain was off before the hibernation, make
-			 * sure it will be off going forward.
-			 */
-			genpd_power_off(genpd, true);
-
-			return 0;
-		}
-	}
-
-	if (genpd->suspend_power_off)
-		return 0;
 
 	pm_genpd_sync_poweron(genpd, true);
 
@@ -1110,7 +1093,6 @@ static int pm_genpd_restore_noirq(struct device *dev)
 static void pm_genpd_complete(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	bool run_complete;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -1120,18 +1102,14 @@ static void pm_genpd_complete(struct device *dev)
 
 	mutex_lock(&genpd->lock);
 
-	run_complete = !genpd->suspend_power_off;
-	if (--genpd->prepared_count == 0)
-		genpd->suspend_power_off = false;
+	genpd->prepared_count--;
 
 	mutex_unlock(&genpd->lock);
 
-	if (run_complete) {
-		pm_generic_complete(dev);
-		pm_runtime_set_active(dev);
-		pm_runtime_enable(dev);
-		pm_request_idle(dev);
-	}
+	pm_generic_complete(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_request_idle(dev);
 }
 
 /**
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 39285c7..dd5b044 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -57,7 +57,6 @@ struct generic_pm_domain {
 	unsigned int device_count;	/* Number of devices */
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
-	bool suspend_power_off;	/* Power status before system suspend */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
 	struct gpd_dev_ops dev_ops;
-- 
1.9.1


From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/4] PM / Domains: Allow runtime PM during system PM phases
Date: Tue, 17 May 2016 13:41:35 +0200
Message-ID: <1463485296-22742-4-git-send-email-ulf.hansson@linaro.org>
References: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34115 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbcEQLlw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2016 07:41:52 -0400
Received: by mail-lf0-f54.google.com with SMTP id m64so5577594lfd.1
        for <linux-pm@vger.kernel.org>; Tue, 17 May 2016 04:41:51 -0700 (PDT)
In-Reply-To: <1463485296-22742-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The PM core disables runtime PM at __device_suspend_late() before it calls
a system PM "late" callback for the device. When resuming the device,
after the corresponding "early" callback has been invoked, it re-enables
runtime PM.

By changing genpd to conform to this behaviour, the device no longer have
to be unconditionally runtime resumed from genpd's ->prepare() callback. In
most cases that avoids unnecessary operations.

As runtime PM then isn't disabled/enabled by genpd, the subsystem/driver
can rely on the generic behaviour from PM core. Consequentially runtime PM
is allowed in more phases of system PM than before.

Although, because of this change and due to that genpd powers on the PM
domain unconditionally in the system PM resume "noirq" phase, it could
potentially cause a PM domain to stay powered on even if it's unused after
the system has resumed. To avoid this, let's schedule a power off work
when genpd's system PM ->complete() callback has been invoked for the last
device in the PM domain.

Another issue that arises due to this change in genpd, concerns those
platforms/PM domains that makes use of genpd's device ->stop|start()
callbacks. In these scenarios, the corresponding subsystem/driver needs to
invoke pm_runtime_force_suspend() from a system PM suspend callback to
allow genpd's ->runtime_suspend() to be invoked for an active device, else
genpd can't "stop" a device that is "started".

The subsystem/driver also needs to invoke pm_runtime_force_resume()
in a system PM resume callback, to restore the runtime PM state for the
device and to re-enable runtime PM.

Currently not all involved subsystem/drivers makes use of
pm_runtime_force_suspend|resume() accordingly. Therefore, let's invoke
pm_runtime_force_suspend|resume() from genpd's "noirq" system PM
callbacks, in cases when the ->stop|start() callbacks are being used.

In this way, devices are "stoped" during suspend and "started" during
resume, even in those cases when the subsystem/driver don't call
pm_runtime_force_suspend|resume() themselves.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 55 ++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 60a9971..9193aac 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -739,21 +739,6 @@ static int pm_genpd_prepare(struct device *dev)
 
 	mutex_unlock(&genpd->lock);
 
-	/*
-	 * Even if the PM domain is powered off at this point, we can't expect
-	 * it to remain in that state during the entire system PM suspend
-	 * phase. Any subsystem/driver for a device in the PM domain, may still
-	 * need to serve a request which may require the device to be runtime
-	 * resumed and its PM domain to be powered.
-	 *
-	 * As we are disabling runtime PM at this point, we are preventing the
-	 * subsystem/driver to decide themselves. For that reason, we need to
-	 * make sure the device is operational as it may be required in some
-	 * cases.
-	 */
-	pm_runtime_resume(dev);
-	__pm_runtime_disable(dev, false);
-
 	ret = pm_generic_prepare(dev);
 	if (ret) {
 		mutex_lock(&genpd->lock);
@@ -761,7 +746,6 @@ static int pm_genpd_prepare(struct device *dev)
 		genpd->prepared_count--;
 
 		mutex_unlock(&genpd->lock);
-		pm_runtime_enable(dev);
 	}
 
 	return ret;
@@ -777,6 +761,7 @@ static int pm_genpd_prepare(struct device *dev)
 static int pm_genpd_suspend_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -787,7 +772,11 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
 		return 0;
 
-	genpd_stop_dev(genpd, dev);
+	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
+		ret = pm_runtime_force_suspend(dev);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Since all of the "noirq" callbacks are executed sequentially, it is
@@ -809,6 +798,7 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 static int pm_genpd_resume_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -827,7 +817,10 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	pm_genpd_sync_poweron(genpd, true);
 	genpd->suspended_count--;
 
-	return genpd_start_dev(genpd, dev);
+	if (genpd->dev_ops.stop && genpd->dev_ops.start)
+		ret = pm_runtime_force_resume(dev);
+
+	return ret;
 }
 
 /**
@@ -842,6 +835,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
 static int pm_genpd_freeze_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -849,7 +843,10 @@ static int pm_genpd_freeze_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd_stop_dev(genpd, dev);
+	if (genpd->dev_ops.stop && genpd->dev_ops.start)
+		ret = pm_runtime_force_suspend(dev);
+
+	return ret;
 }
 
 /**
@@ -862,6 +859,7 @@ static int pm_genpd_freeze_noirq(struct device *dev)
 static int pm_genpd_thaw_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -869,7 +867,10 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd_start_dev(genpd, dev);
+	if (genpd->dev_ops.stop && genpd->dev_ops.start)
+		ret = pm_runtime_force_resume(dev);
+
+	return ret;
 }
 
 /**
@@ -882,6 +883,7 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 static int pm_genpd_restore_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -907,7 +909,10 @@ static int pm_genpd_restore_noirq(struct device *dev)
 
 	pm_genpd_sync_poweron(genpd, true);
 
-	return genpd_start_dev(genpd, dev);
+	if (genpd->dev_ops.stop && genpd->dev_ops.start)
+		ret = pm_runtime_force_resume(dev);
+
+	return ret;
 }
 
 /**
@@ -929,15 +934,15 @@ static void pm_genpd_complete(struct device *dev)
 	if (IS_ERR(genpd))
 		return;
 
+	pm_generic_complete(dev);
+
 	mutex_lock(&genpd->lock);
 
 	genpd->prepared_count--;
+	if (!genpd->prepared_count)
+		genpd_queue_power_off_work(genpd);
 
 	mutex_unlock(&genpd->lock);
-
-	pm_generic_complete(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
 }
 
 /**
-- 
1.9.1


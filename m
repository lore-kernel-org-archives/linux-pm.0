From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 3/5] PM / Domains: Allow runtime PM during system PM phases
Date: Mon, 30 May 2016 11:33:13 +0200
Message-ID: <1464600795-26307-4-git-send-email-ulf.hansson@linaro.org>
References: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34638 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141AbcE3Jd3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 05:33:29 -0400
Received: by mail-lf0-f51.google.com with SMTP id k98so69927645lfi.1
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2016 02:33:28 -0700 (PDT)
In-Reply-To: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

In cases when the PM domain isn't powered off when genpd's ->prepare()
callback is invoked, genpd runtime resumes and disables runtime PM for the
device. This behaviour was needed when genpd managed intermediate states
during the power off sequence, as to maintain proper low power states of
devices during system PM suspend/resume.

The commit ba2bbfbf6307 ("PM / Domains: Remove intermediate states from
the power off sequence"), enables genpd to improve its behaviour in this
regards.

The PM core disables runtime PM at __device_suspend_late() before it calls
a system PM "late" callback for a device. When resuming a device, after a
corresponding "early" callback has been invoked, the PM core re-enables
runtime PM.

By changing genpd to allow runtime PM according to the same system PM
phases as the PM core, devices can be runtime resumed by its corresponding
subsystem/driver when really needed.

In this way, genpd no longer need to runtime resume the device from its
->prepare() callback. In most cases that avoids unnecessary and energy-
wasting operations of runtime resuming devices that have nothing to do,
only to runtime suspend them shortly after.

Although, because of changing this behaviour in genpd and due to that
genpd powers on the PM domain unconditionally in the system PM resume
"noirq" phase, it could potentially cause a PM domain to stay powered on
even if it's unused after the system has resumed. To avoid this, let's
schedule a power off work when genpd's system PM ->complete() callback has
been invoked for the last device in the PM domain.

Another issue that arises due to this change in genpd, concerns those
platforms/PM domains that makes use of genpd's device ->stop|start()
callbacks. In these scenarios, the corresponding subsystem/driver needs to
invoke pm_runtime_force_suspend() from a system PM suspend callback to
allow genpd's ->runtime_suspend() to be invoked for an active device, else
genpd won't "stop" a device that has been "started".

The subsystem/driver also needs to invoke pm_runtime_force_resume()
in a system PM resume callback, to restore the runtime PM state for the
device and to re-enable runtime PM.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Updated changelog.
	- Split patch into two pieces, to deal with stop/start issues from a
	separate change on top of this one.

---
 drivers/base/power/domain.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 60a9971..4cb57f3 100644
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
@@ -787,8 +771,6 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
 		return 0;
 
-	genpd_stop_dev(genpd, dev);
-
 	/*
 	 * Since all of the "noirq" callbacks are executed sequentially, it is
 	 * guaranteed that this function will never run twice in parallel for
@@ -827,7 +809,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	pm_genpd_sync_poweron(genpd, true);
 	genpd->suspended_count--;
 
-	return genpd_start_dev(genpd, dev);
+	return 0;
 }
 
 /**
@@ -849,7 +831,7 @@ static int pm_genpd_freeze_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd_stop_dev(genpd, dev);
+	return 0;
 }
 
 /**
@@ -869,7 +851,7 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd_start_dev(genpd, dev);
+	return 0;
 }
 
 /**
@@ -907,7 +889,7 @@ static int pm_genpd_restore_noirq(struct device *dev)
 
 	pm_genpd_sync_poweron(genpd, true);
 
-	return genpd_start_dev(genpd, dev);
+	return 0;
 }
 
 /**
@@ -929,15 +911,15 @@ static void pm_genpd_complete(struct device *dev)
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


From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 4/5] PM / Domains: Stop/start devices during system PM suspend/resume in genpd
Date: Mon, 30 May 2016 11:33:14 +0200
Message-ID: <1464600795-26307-5-git-send-email-ulf.hansson@linaro.org>
References: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:34644 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932219AbcE3Jdb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 05:33:31 -0400
Received: by mail-lf0-f48.google.com with SMTP id k98so69927876lfi.1
        for <linux-pm@vger.kernel.org>; Mon, 30 May 2016 02:33:30 -0700 (PDT)
In-Reply-To: <1464600795-26307-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Not all subsystems/drivers that manages devices attached to a genpd, makes
use of the pm_runtime_force_suspend|resume() helper functions to deal with
system PM suspend/resume.

In cases like these and when genpd's ->stop|start() callbacks are being
used for the device, invoke the pm_runtime_force_suspend|resume() helper
functions from genpd's "noirq" system PM callbacks. In this way we make
sure to "stop" the device on suspend and to "start" it on resume.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- New patch. Implements the second part of the earlier version of
	[PATCH 3/4] PM / Domains: Allow runtime PM during system PM phases

---
 drivers/base/power/domain.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4cb57f3..9193aac 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -761,6 +761,7 @@ static int pm_genpd_prepare(struct device *dev)
 static int pm_genpd_suspend_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -771,6 +772,12 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 	if (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev))
 		return 0;
 
+	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
+		ret = pm_runtime_force_suspend(dev);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * Since all of the "noirq" callbacks are executed sequentially, it is
 	 * guaranteed that this function will never run twice in parallel for
@@ -791,6 +798,7 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 static int pm_genpd_resume_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -809,7 +817,10 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	pm_genpd_sync_poweron(genpd, true);
 	genpd->suspended_count--;
 
-	return 0;
+	if (genpd->dev_ops.stop && genpd->dev_ops.start)
+		ret = pm_runtime_force_resume(dev);
+
+	return ret;
 }
 
 /**
@@ -824,6 +835,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
 static int pm_genpd_freeze_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -831,7 +843,10 @@ static int pm_genpd_freeze_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return 0;
+	if (genpd->dev_ops.stop && genpd->dev_ops.start)
+		ret = pm_runtime_force_suspend(dev);
+
+	return ret;
 }
 
 /**
@@ -844,6 +859,7 @@ static int pm_genpd_freeze_noirq(struct device *dev)
 static int pm_genpd_thaw_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -851,7 +867,10 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return 0;
+	if (genpd->dev_ops.stop && genpd->dev_ops.start)
+		ret = pm_runtime_force_resume(dev);
+
+	return ret;
 }
 
 /**
@@ -864,6 +883,7 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 static int pm_genpd_restore_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
+	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -889,7 +909,10 @@ static int pm_genpd_restore_noirq(struct device *dev)
 
 	pm_genpd_sync_poweron(genpd, true);
 
-	return 0;
+	if (genpd->dev_ops.stop && genpd->dev_ops.start)
+		ret = pm_runtime_force_resume(dev);
+
+	return ret;
 }
 
 /**
-- 
1.9.1


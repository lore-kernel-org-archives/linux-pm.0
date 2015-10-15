From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/2] PM / Domains: Don't measure ->start|stop() latency in system PM callbacks
Date: Thu, 15 Oct 2015 17:02:06 +0200
Message-ID: <1444921326-22574-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36176 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752336AbbJOPCQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 11:02:16 -0400
Received: by lbcao8 with SMTP id ao8so72042824lbc.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 08:02:14 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Measure latency does by itself contribute to an increased latency, thus we
should avoid it when it isn't needed.

Genpd measures latencies in the system PM phase for the ->start|stop()
callbacks and is thus affecting the system PM suspend/resume time.
Moreover these latencies are validated only at runtime PM suspend/resume.

To this reasoning, let's decide to leave these measurements out of the
system PM phase. There should be plenty of occasions during runtime PM to
perform these measurements anyway.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6e1bcde..a1c3ec4 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -90,8 +90,12 @@ static struct generic_pm_domain *dev_to_genpd(struct device *dev)
 	return pd_to_genpd(dev->pm_domain);
 }
 
-static int genpd_stop_dev(struct generic_pm_domain *genpd, struct device *dev)
+static int genpd_stop_dev(struct generic_pm_domain *genpd, struct device *dev,
+			bool timed)
 {
+	if (!timed)
+		return GENPD_DEV_CALLBACK(genpd, int, stop, dev);
+
 	return GENPD_DEV_TIMED_CALLBACK(genpd, int, stop, dev,
 					stop_latency_ns, "stop");
 }
@@ -434,7 +438,7 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = genpd_stop_dev(genpd, dev);
+	ret = genpd_stop_dev(genpd, dev, true);
 	if (ret) {
 		genpd_restore_dev(genpd, dev, true);
 		return ret;
@@ -779,7 +783,7 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 	    || (dev->power.wakeup_path && genpd_dev_active_wakeup(genpd, dev)))
 		return 0;
 
-	genpd_stop_dev(genpd, dev);
+	genpd_stop_dev(genpd, dev, false);
 
 	/*
 	 * Since all of the "noirq" callbacks are executed sequentially, it is
@@ -820,7 +824,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
 	pm_genpd_sync_poweron(genpd, true);
 	genpd->suspended_count--;
 
-	return genpd_start_dev(genpd, dev, true);
+	return genpd_start_dev(genpd, dev, false);
 }
 
 /**
@@ -928,7 +932,7 @@ static int pm_genpd_freeze_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_stop_dev(genpd, dev);
+	return genpd->suspend_power_off ? 0 : genpd_stop_dev(genpd, dev, false);
 }
 
 /**
@@ -948,7 +952,8 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_start_dev(genpd, dev, true);
+	return genpd->suspend_power_off ?
+		0 : genpd_start_dev(genpd, dev, false);
 }
 
 /**
@@ -1042,7 +1047,7 @@ static int pm_genpd_restore_noirq(struct device *dev)
 
 	pm_genpd_sync_poweron(genpd, true);
 
-	return genpd_start_dev(genpd, dev, true);
+	return genpd_start_dev(genpd, dev, false);
 }
 
 /**
-- 
1.9.1


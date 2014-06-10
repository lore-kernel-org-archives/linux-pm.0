From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 06/24] PM / Domains: Remove system PM callbacks from gpd_dev_ops
Date: Tue, 10 Jun 2014 12:51:19 +0200
Message-ID: <1402397497-26737-7-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:63793 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaFJKwS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:52:18 -0400
Received: by mail-la0-f51.google.com with SMTP id gf5so3749552lab.24
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 03:52:17 -0700 (PDT)
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

There no users of these callbacks, let's simplify the generic power
domain by removing them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |   64 ++++++-------------------------------------
 include/linux/pm_domain.h   |    8 ------
 2 files changed, 8 insertions(+), 64 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index ab6597b..da058e9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -771,46 +771,6 @@ static bool genpd_dev_active_wakeup(struct generic_pm_domain *genpd,
 	return GENPD_DEV_CALLBACK(genpd, bool, active_wakeup, dev);
 }
 
-static int genpd_suspend_dev(struct generic_pm_domain *genpd, struct device *dev)
-{
-	return GENPD_DEV_CALLBACK(genpd, int, suspend, dev);
-}
-
-static int genpd_suspend_late(struct generic_pm_domain *genpd, struct device *dev)
-{
-	return GENPD_DEV_CALLBACK(genpd, int, suspend_late, dev);
-}
-
-static int genpd_resume_early(struct generic_pm_domain *genpd, struct device *dev)
-{
-	return GENPD_DEV_CALLBACK(genpd, int, resume_early, dev);
-}
-
-static int genpd_resume_dev(struct generic_pm_domain *genpd, struct device *dev)
-{
-	return GENPD_DEV_CALLBACK(genpd, int, resume, dev);
-}
-
-static int genpd_freeze_dev(struct generic_pm_domain *genpd, struct device *dev)
-{
-	return GENPD_DEV_CALLBACK(genpd, int, freeze, dev);
-}
-
-static int genpd_freeze_late(struct generic_pm_domain *genpd, struct device *dev)
-{
-	return GENPD_DEV_CALLBACK(genpd, int, freeze_late, dev);
-}
-
-static int genpd_thaw_early(struct generic_pm_domain *genpd, struct device *dev)
-{
-	return GENPD_DEV_CALLBACK(genpd, int, thaw_early, dev);
-}
-
-static int genpd_thaw_dev(struct generic_pm_domain *genpd, struct device *dev)
-{
-	return GENPD_DEV_CALLBACK(genpd, int, thaw, dev);
-}
-
 /**
  * pm_genpd_sync_poweroff - Synchronously power off a PM domain and its masters.
  * @genpd: PM domain to power off, if possible.
@@ -992,7 +952,7 @@ static int pm_genpd_suspend(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_suspend_dev(genpd, dev);
+	return genpd->suspend_power_off ? 0 : pm_generic_suspend(dev);
 }
 
 /**
@@ -1013,7 +973,7 @@ static int pm_genpd_suspend_late(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_suspend_late(genpd, dev);
+	return genpd->suspend_power_off ? 0 : pm_generic_suspend_late(dev);
 }
 
 /**
@@ -1100,7 +1060,7 @@ static int pm_genpd_resume_early(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_resume_early(genpd, dev);
+	return genpd->suspend_power_off ? 0 : pm_generic_resume_early(dev);
 }
 
 /**
@@ -1121,7 +1081,7 @@ static int pm_genpd_resume(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_resume_dev(genpd, dev);
+	return genpd->suspend_power_off ? 0 : pm_generic_resume(dev);
 }
 
 /**
@@ -1142,7 +1102,7 @@ static int pm_genpd_freeze(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_freeze_dev(genpd, dev);
+	return genpd->suspend_power_off ? 0 : pm_generic_freeze(dev);
 }
 
 /**
@@ -1164,7 +1124,7 @@ static int pm_genpd_freeze_late(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_freeze_late(genpd, dev);
+	return genpd->suspend_power_off ? 0 : pm_generic_freeze_late(dev);
 }
 
 /**
@@ -1228,7 +1188,7 @@ static int pm_genpd_thaw_early(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_thaw_early(genpd, dev);
+	return genpd->suspend_power_off ? 0 : pm_generic_thaw_early(dev);
 }
 
 /**
@@ -1249,7 +1209,7 @@ static int pm_genpd_thaw(struct device *dev)
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	return genpd->suspend_power_off ? 0 : genpd_thaw_dev(genpd, dev);
+	return genpd->suspend_power_off ? 0 : pm_generic_thaw(dev);
 }
 
 /**
@@ -1957,14 +1917,6 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->domain.ops.complete = pm_genpd_complete;
 	genpd->dev_ops.save_state = pm_genpd_default_save_state;
 	genpd->dev_ops.restore_state = pm_genpd_default_restore_state;
-	genpd->dev_ops.suspend = pm_generic_suspend;
-	genpd->dev_ops.suspend_late = pm_generic_suspend_late;
-	genpd->dev_ops.resume_early = pm_generic_resume_early;
-	genpd->dev_ops.resume = pm_generic_resume;
-	genpd->dev_ops.freeze = pm_generic_freeze;
-	genpd->dev_ops.freeze_late = pm_generic_freeze_late;
-	genpd->dev_ops.thaw_early = pm_generic_thaw_early;
-	genpd->dev_ops.thaw = pm_generic_thaw;
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
 	mutex_unlock(&gpd_list_lock);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 983efdc..87810a7 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -35,14 +35,6 @@ struct gpd_dev_ops {
 	int (*stop)(struct device *dev);
 	int (*save_state)(struct device *dev);
 	int (*restore_state)(struct device *dev);
-	int (*suspend)(struct device *dev);
-	int (*suspend_late)(struct device *dev);
-	int (*resume_early)(struct device *dev);
-	int (*resume)(struct device *dev);
-	int (*freeze)(struct device *dev);
-	int (*freeze_late)(struct device *dev);
-	int (*thaw_early)(struct device *dev);
-	int (*thaw)(struct device *dev);
 	bool (*active_wakeup)(struct device *dev);
 };
 
-- 
1.7.9.5


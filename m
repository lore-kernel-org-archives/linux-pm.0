From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Don't skip driver's ->suspend|resume_noirq() callbacks
Date: Wed, 10 Jan 2018 21:31:56 +0100
Message-ID: <1515616316-5118-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42895 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeAJUio (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jan 2018 15:38:44 -0500
Received: by mail-lf0-f67.google.com with SMTP id e27so300305lfb.9
        for <linux-pm@vger.kernel.org>; Wed, 10 Jan 2018 12:38:44 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: khilman@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Mikko Perttunen <mperttunen@nvidia.com>

The commit 10da65423fdb ("PM / Domains: Call driver's noirq callbacks")
started to respect driver's noirq callbacks, but while doing that it also
introduced a few potential problems.

More precisely, in genpd_finish_suspend() and genpd_resume_noirq() the
noirq callbacks at the driver level should be invoked, no matter of whether
dev->power.wakeup_path is set or not.

Additionally, the commit in question also made genpd_resume_noirq() to
ignore the return value from pm_runtime_force_resume().

Let's fix both these issues!

Fixes: 10da65423fdb ("PM / Domains: Call driver's noirq callbacks")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f9dcc98..48255ce 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1032,15 +1032,12 @@ static int genpd_prepare(struct device *dev)
 static int genpd_finish_suspend(struct device *dev, bool poweroff)
 {
 	struct generic_pm_domain *genpd;
-	int ret;
+	int ret = 0;
 
 	genpd = dev_to_genpd(dev);
 	if (IS_ERR(genpd))
 		return -EINVAL;
 
-	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
-		return 0;
-
 	if (poweroff)
 		ret = pm_generic_poweroff_noirq(dev);
 	else
@@ -1048,10 +1045,18 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 	if (ret)
 		return ret;
 
+	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
+		return 0;
+
 	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
 		ret = pm_runtime_force_suspend(dev);
-		if (ret)
+		if (ret) {
+			if (poweroff)
+				pm_generic_restore_noirq(dev);
+			else
+				pm_generic_resume_noirq(dev);
 			return ret;
+		}
 	}
 
 	genpd_lock(genpd);
@@ -1085,7 +1090,7 @@ static int genpd_suspend_noirq(struct device *dev)
 static int genpd_resume_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
-	int ret = 0;
+	int ret;
 
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -1094,21 +1099,20 @@ static int genpd_resume_noirq(struct device *dev)
 		return -EINVAL;
 
 	if (dev->power.wakeup_path && genpd_is_active_wakeup(genpd))
-		return 0;
+		return pm_generic_resume_noirq(dev);
 
 	genpd_lock(genpd);
 	genpd_sync_power_on(genpd, true, 0);
 	genpd->suspended_count--;
 	genpd_unlock(genpd);
 
-	if (genpd->dev_ops.stop && genpd->dev_ops.start)
+	if (genpd->dev_ops.stop && genpd->dev_ops.start) {
 		ret = pm_runtime_force_resume(dev);
+		if (ret)
+			return ret;
+	}
 
-	ret = pm_generic_resume_noirq(dev);
-	if (ret)
-		return ret;
-
-	return ret;
+	return pm_generic_resume_noirq(dev);
 }
 
 /**
-- 
2.7.4

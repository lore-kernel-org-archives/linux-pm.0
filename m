From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Silence compiler warning for an unused function
Date: Mon,  1 Feb 2016 14:52:41 +0100
Message-ID: <1454334761-13678-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33055 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183AbcBANws (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Feb 2016 08:52:48 -0500
Received: by mail-lf0-f52.google.com with SMTP id m1so21619209lfg.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Feb 2016 05:52:48 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Arnd Bergmann <arnd@arndb.de>

The only remaining caller of genpd_poweron() is conditionally compiled
based on CONFIG_PM_GENERIC_DOMAINS_OF, so we get a warning when that is
unset.

By moving the locking/unlocking of the genpd outside genpd_poweron(), thus
to the caller, genpd_poweron() becomes redundant.

Within this context let's then rename the wrapper function,
__genpd_poweron(), to genpd_poweron() as it will then be consistent with
its friend genpd_poweroff().

This change silence the warning about the unused function.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Fixes: ea823c7cbffa ("PM / Domains: Remove pm_genpd_poweron() API")
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 784dbe8..301b785 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -173,14 +173,14 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 }
 
 /**
- * __genpd_poweron - Restore power to a given PM domain and its masters.
+ * genpd_poweron - Restore power to a given PM domain and its masters.
  * @genpd: PM domain to power up.
  * @depth: nesting count for lockdep.
  *
  * Restore power to @genpd and all of its masters so that it is possible to
  * resume a device belonging to it.
  */
-static int __genpd_poweron(struct generic_pm_domain *genpd, unsigned int depth)
+static int genpd_poweron(struct generic_pm_domain *genpd, unsigned int depth)
 {
 	struct gpd_link *link;
 	int ret = 0;
@@ -200,7 +200,7 @@ static int __genpd_poweron(struct generic_pm_domain *genpd, unsigned int depth)
 		genpd_sd_counter_inc(master);
 
 		mutex_lock_nested(&master->lock, depth + 1);
-		ret = __genpd_poweron(master, depth + 1);
+		ret = genpd_poweron(master, depth + 1);
 		mutex_unlock(&master->lock);
 
 		if (ret) {
@@ -227,21 +227,6 @@ static int __genpd_poweron(struct generic_pm_domain *genpd, unsigned int depth)
 	return ret;
 }
 
-/**
- * genpd_poweron - Restore power to a given PM domain and its masters.
- * @genpd: PM domain to power up.
- */
-static int genpd_poweron(struct generic_pm_domain *genpd)
-{
-	int ret;
-
-	mutex_lock(&genpd->lock);
-	ret = __genpd_poweron(genpd, 0);
-	mutex_unlock(&genpd->lock);
-	return ret;
-}
-
-
 static int genpd_save_dev(struct generic_pm_domain *genpd, struct device *dev)
 {
 	return GENPD_DEV_CALLBACK(genpd, int, save_state, dev);
@@ -489,7 +474,7 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	}
 
 	mutex_lock(&genpd->lock);
-	ret = __genpd_poweron(genpd, 0);
+	ret = genpd_poweron(genpd, 0);
 	mutex_unlock(&genpd->lock);
 
 	if (ret)
@@ -1821,8 +1806,10 @@ int genpd_dev_pm_attach(struct device *dev)
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
-	ret = genpd_poweron(pd);
 
+	mutex_lock(&pd->lock);
+	ret = genpd_poweron(pd, 0);
+	mutex_unlock(&pd->lock);
 out:
 	return ret ? -EPROBE_DEFER : 0;
 }
-- 
1.9.1


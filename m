From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH V2] PM / Domains: Rename *pm_genpd_poweron|poweroff()
Date: Tue, 13 Oct 2015 09:58:02 +0200
Message-ID: <1444723082-23751-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33004 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbbJMH6I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 03:58:08 -0400
Received: by lbbk10 with SMTP id k10so10058866lbb.0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 00:58:06 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

This is another step to get consistent names of functions in genpd. Let's
rename the internal *pm_genpd_poweron|poweroff() into
*genpd_poweron|poweroff().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	This patch was earlier a part of below patchset, but it needed a rebase.
	http://comments.gmane.org/gmane.linux.power-management.general/66480

---
 drivers/base/power/domain.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 8724b47..6e1bcde 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -181,10 +181,10 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
 }
 
 /**
- * genpd_queue_power_off_work - Queue up the execution of pm_genpd_poweroff().
+ * genpd_queue_power_off_work - Queue up the execution of genpd_poweroff().
  * @genpd: PM domait to power off.
  *
- * Queue up the execution of pm_genpd_poweroff() unless it's already been done
+ * Queue up the execution of genpd_poweroff() unless it's already been done
  * before.
  */
 static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
@@ -192,16 +192,16 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 	queue_work(pm_wq, &genpd->power_off_work);
 }
 
-static int pm_genpd_poweron(struct generic_pm_domain *genpd);
+static int genpd_poweron(struct generic_pm_domain *genpd);
 
 /**
- * __pm_genpd_poweron - Restore power to a given PM domain and its masters.
+ * __genpd_poweron - Restore power to a given PM domain and its masters.
  * @genpd: PM domain to power up.
  *
  * Restore power to @genpd and all of its masters so that it is possible to
  * resume a device belonging to it.
  */
-static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
+static int __genpd_poweron(struct generic_pm_domain *genpd)
 {
 	struct gpd_link *link;
 	int ret = 0;
@@ -218,7 +218,7 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 	list_for_each_entry(link, &genpd->slave_links, slave_node) {
 		genpd_sd_counter_inc(link->master);
 
-		ret = pm_genpd_poweron(link->master);
+		ret = genpd_poweron(link->master);
 		if (ret) {
 			genpd_sd_counter_dec(link->master);
 			goto err;
@@ -244,15 +244,15 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
 }
 
 /**
- * pm_genpd_poweron - Restore power to a given PM domain and its masters.
+ * genpd_poweron - Restore power to a given PM domain and its masters.
  * @genpd: PM domain to power up.
  */
-static int pm_genpd_poweron(struct generic_pm_domain *genpd)
+static int genpd_poweron(struct generic_pm_domain *genpd)
 {
 	int ret;
 
 	mutex_lock(&genpd->lock);
-	ret = __pm_genpd_poweron(genpd);
+	ret = __genpd_poweron(genpd);
 	mutex_unlock(&genpd->lock);
 	return ret;
 }
@@ -315,14 +315,14 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 }
 
 /**
- * pm_genpd_poweroff - Remove power from a given PM domain.
+ * genpd_poweroff - Remove power from a given PM domain.
  * @genpd: PM domain to power down.
  * @is_async: PM domain is powered down from a scheduled work
  *
  * If all of the @genpd's devices have been suspended and all of its subdomains
  * have been powered down, remove power from @genpd.
  */
-static int pm_genpd_poweroff(struct generic_pm_domain *genpd, bool is_async)
+static int genpd_poweroff(struct generic_pm_domain *genpd, bool is_async)
 {
 	struct pm_domain_data *pdd;
 	struct gpd_link *link;
@@ -370,10 +370,10 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd, bool is_async)
 
 		/*
 		 * If sd_count > 0 at this point, one of the subdomains hasn't
-		 * managed to call pm_genpd_poweron() for the master yet after
-		 * incrementing it.  In that case pm_genpd_poweron() will wait
+		 * managed to call genpd_poweron() for the master yet after
+		 * incrementing it.  In that case genpd_poweron() will wait
 		 * for us to drop the lock, so we can call .power_off() and let
-		 * the pm_genpd_poweron() restore power for us (this shouldn't
+		 * the genpd_poweron() restore power for us (this shouldn't
 		 * happen very often).
 		 */
 		ret = genpd_power_off(genpd, true);
@@ -402,7 +402,7 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
 	mutex_lock(&genpd->lock);
-	pm_genpd_poweroff(genpd, true);
+	genpd_poweroff(genpd, true);
 	mutex_unlock(&genpd->lock);
 }
 
@@ -448,7 +448,7 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 		return 0;
 
 	mutex_lock(&genpd->lock);
-	pm_genpd_poweroff(genpd, false);
+	genpd_poweroff(genpd, false);
 	mutex_unlock(&genpd->lock);
 
 	return 0;
@@ -481,7 +481,7 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	}
 
 	mutex_lock(&genpd->lock);
-	ret = __pm_genpd_poweron(genpd);
+	ret = __genpd_poweron(genpd);
 	mutex_unlock(&genpd->lock);
 
 	if (ret)
@@ -694,7 +694,7 @@ static int pm_genpd_prepare(struct device *dev)
 
 	/*
 	 * The PM domain must be in the GPD_STATE_ACTIVE state at this point,
-	 * so pm_genpd_poweron() will return immediately, but if the device
+	 * so genpd_poweron() will return immediately, but if the device
 	 * is suspended (e.g. it's been stopped by genpd_stop_dev()), we need
 	 * to make it operational.
 	 */
@@ -1793,7 +1793,7 @@ int genpd_dev_pm_attach(struct device *dev)
 
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
-	ret = pm_genpd_poweron(pd);
+	ret = genpd_poweron(pd);
 
 out:
 	return ret ? -EPROBE_DEFER : 0;
-- 
1.9.1


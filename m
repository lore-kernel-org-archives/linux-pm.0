From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 01/15] PM / Domains: Remove the pm_genpd_add|remove_callbacks APIs
Date: Wed,  3 Sep 2014 12:52:17 +0200
Message-ID: <1409741551-16437-2-git-send-email-ulf.hansson@linaro.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:59978 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885AbaICKw4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Sep 2014 06:52:56 -0400
Received: by mail-wg0-f47.google.com with SMTP id z12so8301631wgg.30
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2014 03:52:55 -0700 (PDT)
In-Reply-To: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

There are no users of these APIs. To simplify the generic power domain
let's remove them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 106 --------------------------------------------
 include/linux/pm_domain.h   |  19 --------
 2 files changed, 125 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index eee55c1..e613e3c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1744,112 +1744,6 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 }
 
 /**
- * pm_genpd_add_callbacks - Add PM domain callbacks to a given device.
- * @dev: Device to add the callbacks to.
- * @ops: Set of callbacks to add.
- * @td: Timing data to add to the device along with the callbacks (optional).
- *
- * Every call to this routine should be balanced with a call to
- * __pm_genpd_remove_callbacks() and they must not be nested.
- */
-int pm_genpd_add_callbacks(struct device *dev, struct gpd_dev_ops *ops,
-			   struct gpd_timing_data *td)
-{
-	struct generic_pm_domain_data *gpd_data_new, *gpd_data = NULL;
-	int ret = 0;
-
-	if (!(dev && ops))
-		return -EINVAL;
-
-	gpd_data_new = __pm_genpd_alloc_dev_data(dev);
-	if (!gpd_data_new)
-		return -ENOMEM;
-
-	pm_runtime_disable(dev);
-	device_pm_lock();
-
-	ret = dev_pm_get_subsys_data(dev);
-	if (ret)
-		goto out;
-
-	spin_lock_irq(&dev->power.lock);
-
-	if (dev->power.subsys_data->domain_data) {
-		gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
-	} else {
-		gpd_data = gpd_data_new;
-		dev->power.subsys_data->domain_data = &gpd_data->base;
-	}
-	gpd_data->refcount++;
-	gpd_data->ops = *ops;
-	if (td)
-		gpd_data->td = *td;
-
-	spin_unlock_irq(&dev->power.lock);
-
- out:
-	device_pm_unlock();
-	pm_runtime_enable(dev);
-
-	if (gpd_data != gpd_data_new)
-		__pm_genpd_free_dev_data(dev, gpd_data_new);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pm_genpd_add_callbacks);
-
-/**
- * __pm_genpd_remove_callbacks - Remove PM domain callbacks from a given device.
- * @dev: Device to remove the callbacks from.
- * @clear_td: If set, clear the device's timing data too.
- *
- * This routine can only be called after pm_genpd_add_callbacks().
- */
-int __pm_genpd_remove_callbacks(struct device *dev, bool clear_td)
-{
-	struct generic_pm_domain_data *gpd_data = NULL;
-	bool remove = false;
-	int ret = 0;
-
-	if (!(dev && dev->power.subsys_data))
-		return -EINVAL;
-
-	pm_runtime_disable(dev);
-	device_pm_lock();
-
-	spin_lock_irq(&dev->power.lock);
-
-	if (dev->power.subsys_data->domain_data) {
-		gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
-		gpd_data->ops = (struct gpd_dev_ops){ NULL };
-		if (clear_td)
-			gpd_data->td = (struct gpd_timing_data){ 0 };
-
-		if (--gpd_data->refcount == 0) {
-			dev->power.subsys_data->domain_data = NULL;
-			remove = true;
-		}
-	} else {
-		ret = -EINVAL;
-	}
-
-	spin_unlock_irq(&dev->power.lock);
-
-	device_pm_unlock();
-	pm_runtime_enable(dev);
-
-	if (ret)
-		return ret;
-
-	dev_pm_put_subsys_data(dev);
-	if (remove)
-		__pm_genpd_free_dev_data(dev, gpd_data);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(__pm_genpd_remove_callbacks);
-
-/**
  * pm_genpd_attach_cpuidle - Connect the given PM domain with cpuidle.
  * @genpd: PM domain to be connected with cpuidle.
  * @state: cpuidle state this domain can disable/enable.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 7c1d252..0aa9ad9 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -151,10 +151,6 @@ extern int pm_genpd_add_subdomain_names(const char *master_name,
 					const char *subdomain_name);
 extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 				     struct generic_pm_domain *target);
-extern int pm_genpd_add_callbacks(struct device *dev,
-				  struct gpd_dev_ops *ops,
-				  struct gpd_timing_data *td);
-extern int __pm_genpd_remove_callbacks(struct device *dev, bool clear_td);
 extern int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state);
 extern int pm_genpd_name_attach_cpuidle(const char *name, int state);
 extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
@@ -217,16 +213,6 @@ static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
-static inline int pm_genpd_add_callbacks(struct device *dev,
-					 struct gpd_dev_ops *ops,
-					 struct gpd_timing_data *td)
-{
-	return -ENOSYS;
-}
-static inline int __pm_genpd_remove_callbacks(struct device *dev, bool clear_td)
-{
-	return -ENOSYS;
-}
 static inline int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int st)
 {
 	return -ENOSYS;
@@ -281,11 +267,6 @@ static inline int pm_genpd_name_add_device(const char *domain_name,
 	return __pm_genpd_name_add_device(domain_name, dev, NULL);
 }
 
-static inline int pm_genpd_remove_callbacks(struct device *dev)
-{
-	return __pm_genpd_remove_callbacks(dev, true);
-}
-
 #ifdef CONFIG_PM_GENERIC_DOMAINS_RUNTIME
 extern void genpd_queue_power_off_work(struct generic_pm_domain *genpd);
 extern void pm_genpd_poweroff_unused(void);
-- 
1.9.1


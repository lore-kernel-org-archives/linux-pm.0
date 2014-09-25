From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Remove legacy API for adding devices through DT
Date: Thu, 25 Sep 2014 17:49:59 +0200
Message-ID: <1411660199-2022-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:52096 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbaIYPw2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Sep 2014 11:52:28 -0400
Received: by mail-wi0-f173.google.com with SMTP id r20so9223546wiv.6
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2014 08:52:26 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

There are no active clients of the legacy API and we now also have a
better way to handle genpd DT support. So let's remove the legacy API.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 33 ---------------------------------
 include/linux/pm_domain.h   | 17 -----------------
 2 files changed, 50 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cd40057..8ba04cd 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1454,39 +1454,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 }
 
 /**
- * __pm_genpd_of_add_device - Add a device to an I/O PM domain.
- * @genpd_node: Device tree node pointer representing a PM domain to which the
- *   the device is added to.
- * @dev: Device to be added.
- * @td: Set of PM QoS timing parameters to attach to the device.
- */
-int __pm_genpd_of_add_device(struct device_node *genpd_node, struct device *dev,
-			     struct gpd_timing_data *td)
-{
-	struct generic_pm_domain *genpd = NULL, *gpd;
-
-	dev_dbg(dev, "%s()\n", __func__);
-
-	if (IS_ERR_OR_NULL(genpd_node) || IS_ERR_OR_NULL(dev))
-		return -EINVAL;
-
-	mutex_lock(&gpd_list_lock);
-	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
-		if (gpd->of_node == genpd_node) {
-			genpd = gpd;
-			break;
-		}
-	}
-	mutex_unlock(&gpd_list_lock);
-
-	if (!genpd)
-		return -EINVAL;
-
-	return __pm_genpd_add_device(genpd, dev, td);
-}
-
-
-/**
  * __pm_genpd_name_add_device - Find I/O PM domain and add a device to it.
  * @domain_name: Name of the PM domain to add the device to.
  * @dev: Device to be added.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 292079d..c3763a3 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -71,7 +71,6 @@ struct generic_pm_domain {
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
-	struct device_node *of_node; /* Node in device tree */
 	struct gpd_cpu_data *cpu_data;
 };
 
@@ -122,10 +121,6 @@ extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 				 struct device *dev,
 				 struct gpd_timing_data *td);
 
-extern int __pm_genpd_of_add_device(struct device_node *genpd_node,
-				    struct device *dev,
-				    struct gpd_timing_data *td);
-
 extern int __pm_genpd_name_add_device(const char *domain_name,
 				      struct device *dev,
 				      struct gpd_timing_data *td);
@@ -167,12 +162,6 @@ static inline int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
-static inline int __pm_genpd_of_add_device(struct device_node *genpd_node,
-					   struct device *dev,
-					   struct gpd_timing_data *td)
-{
-	return -ENOSYS;
-}
 static inline int __pm_genpd_name_add_device(const char *domain_name,
 					     struct device *dev,
 					     struct gpd_timing_data *td)
@@ -238,12 +227,6 @@ static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 	return __pm_genpd_add_device(genpd, dev, NULL);
 }
 
-static inline int pm_genpd_of_add_device(struct device_node *genpd_node,
-					 struct device *dev)
-{
-	return __pm_genpd_of_add_device(genpd_node, dev, NULL);
-}
-
 static inline int pm_genpd_name_add_device(const char *domain_name,
 					   struct device *dev)
 {
-- 
1.9.1


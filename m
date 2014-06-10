From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 11/24] PM / Domains: Remove legacy API for adding devices through DT
Date: Tue, 10 Jun 2014 12:51:24 +0200
Message-ID: <1402397497-26737-12-git-send-email-ulf.hansson@linaro.org>
References: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:49157 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbaFJKwc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 06:52:32 -0400
Received: by mail-la0-f44.google.com with SMTP id hr17so3867179lab.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2014 03:52:30 -0700 (PDT)
In-Reply-To: <1402397497-26737-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>

There are no active clients of the legacy API and we now also have a
sophisticated way, where driver core deals with adding devices to genpd
while probing. So, let's remove the legacy API.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c |   33 ---------------------------------
 include/linux/pm_domain.h   |   17 -----------------
 2 files changed, 50 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 0362360..3b29477 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1433,39 +1433,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
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
index 7aadf40..0e6205e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -71,7 +71,6 @@ struct generic_pm_domain {
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
-	struct device_node *of_node; /* Node in device tree */
 	struct gpd_cpu_data *cpu_data;
 };
 
@@ -124,10 +123,6 @@ extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 				 struct device *dev,
 				 struct gpd_timing_data *td);
 
-extern int __pm_genpd_of_add_device(struct device_node *genpd_node,
-				    struct device *dev,
-				    struct gpd_timing_data *td);
-
 extern int __pm_genpd_name_add_device(const char *domain_name,
 				      struct device *dev,
 				      struct gpd_timing_data *td);
@@ -170,12 +165,6 @@ static inline int __pm_genpd_add_device(struct generic_pm_domain *genpd,
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
@@ -245,12 +234,6 @@ static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
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
1.7.9.5


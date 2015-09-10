From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Remove name based API for genpd
Date: Thu, 10 Sep 2015 16:00:50 +0200
Message-ID: <1441893650-19923-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:32842 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbbIJOA5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2015 10:00:57 -0400
Received: by lbcjc2 with SMTP id jc2so23619349lbc.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2015 07:00:56 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

As all users of the named based APIs now have converted to the non-named
based APIs, the time has come to remove them.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 90 ---------------------------------------------
 include/linux/pm_domain.h   | 38 -------------------
 2 files changed, 128 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 16550c6..a46427e 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -53,24 +53,6 @@
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
-static struct generic_pm_domain *pm_genpd_lookup_name(const char *domain_name)
-{
-	struct generic_pm_domain *genpd = NULL, *gpd;
-
-	if (IS_ERR_OR_NULL(domain_name))
-		return NULL;
-
-	mutex_lock(&gpd_list_lock);
-	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
-		if (!strcmp(gpd->name, domain_name)) {
-			genpd = gpd;
-			break;
-		}
-	}
-	mutex_unlock(&gpd_list_lock);
-	return genpd;
-}
-
 /*
  * Get the generic PM domain for a particular struct device.
  * This validates the struct device pointer, the PM domain pointer,
@@ -295,18 +277,6 @@ int pm_genpd_poweron(struct generic_pm_domain *genpd)
 	return ret;
 }
 
-/**
- * pm_genpd_name_poweron - Restore power to a given PM domain and its masters.
- * @domain_name: Name of the PM domain to power up.
- */
-int pm_genpd_name_poweron(const char *domain_name)
-{
-	struct generic_pm_domain *genpd;
-
-	genpd = pm_genpd_lookup_name(domain_name);
-	return genpd ? pm_genpd_poweron(genpd) : -EINVAL;
-}
-
 static int genpd_save_dev(struct generic_pm_domain *genpd, struct device *dev)
 {
 	return GENPD_DEV_TIMED_CALLBACK(genpd, int, save_state, dev,
@@ -1317,18 +1287,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 }
 
 /**
- * __pm_genpd_name_add_device - Find I/O PM domain and add a device to it.
- * @domain_name: Name of the PM domain to add the device to.
- * @dev: Device to be added.
- * @td: Set of PM QoS timing parameters to attach to the device.
- */
-int __pm_genpd_name_add_device(const char *domain_name, struct device *dev,
-			       struct gpd_timing_data *td)
-{
-	return __pm_genpd_add_device(pm_genpd_lookup_name(domain_name), dev, td);
-}
-
-/**
  * pm_genpd_remove_device - Remove a device from an I/O PM domain.
  * @genpd: PM domain to remove the device from.
  * @dev: Device to be removed.
@@ -1429,35 +1387,6 @@ int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 }
 
 /**
- * pm_genpd_add_subdomain_names - Add a subdomain to an I/O PM domain.
- * @master_name: Name of the master PM domain to add the subdomain to.
- * @subdomain_name: Name of the subdomain to be added.
- */
-int pm_genpd_add_subdomain_names(const char *master_name,
-				 const char *subdomain_name)
-{
-	struct generic_pm_domain *master = NULL, *subdomain = NULL, *gpd;
-
-	if (IS_ERR_OR_NULL(master_name) || IS_ERR_OR_NULL(subdomain_name))
-		return -EINVAL;
-
-	mutex_lock(&gpd_list_lock);
-	list_for_each_entry(gpd, &gpd_list, gpd_list_node) {
-		if (!master && !strcmp(gpd->name, master_name))
-			master = gpd;
-
-		if (!subdomain && !strcmp(gpd->name, subdomain_name))
-			subdomain = gpd;
-
-		if (master && subdomain)
-			break;
-	}
-	mutex_unlock(&gpd_list_lock);
-
-	return pm_genpd_add_subdomain(master, subdomain);
-}
-
-/**
  * pm_genpd_remove_subdomain - Remove a subdomain from an I/O PM domain.
  * @genpd: Master PM domain to remove the subdomain from.
  * @subdomain: Subdomain to be removed.
@@ -1566,16 +1495,6 @@ int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state)
 }
 
 /**
- * pm_genpd_name_attach_cpuidle - Find PM domain and connect cpuidle to it.
- * @name: Name of the domain to connect to cpuidle.
- * @state: cpuidle state this domain can manipulate.
- */
-int pm_genpd_name_attach_cpuidle(const char *name, int state)
-{
-	return pm_genpd_attach_cpuidle(pm_genpd_lookup_name(name), state);
-}
-
-/**
  * pm_genpd_detach_cpuidle - Remove the cpuidle connection from a PM domain.
  * @genpd: PM domain to remove the cpuidle connection from.
  *
@@ -1613,15 +1532,6 @@ int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 	return ret;
 }
 
-/**
- * pm_genpd_name_detach_cpuidle - Find PM domain and disconnect cpuidle from it.
- * @name: Name of the domain to disconnect cpuidle from.
- */
-int pm_genpd_name_detach_cpuidle(const char *name)
-{
-	return pm_genpd_detach_cpuidle(pm_genpd_lookup_name(name));
-}
-
 /* Default device callbacks for generic PM domains. */
 
 /**
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index b1cf7e7..443fc19 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -125,27 +125,18 @@ extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 				 struct device *dev,
 				 struct gpd_timing_data *td);
 
-extern int __pm_genpd_name_add_device(const char *domain_name,
-				      struct device *dev,
-				      struct gpd_timing_data *td);
-
 extern int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 				  struct device *dev);
 extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 				  struct generic_pm_domain *new_subdomain);
-extern int pm_genpd_add_subdomain_names(const char *master_name,
-					const char *subdomain_name);
 extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 				     struct generic_pm_domain *target);
 extern int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int state);
-extern int pm_genpd_name_attach_cpuidle(const char *name, int state);
 extern int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd);
-extern int pm_genpd_name_detach_cpuidle(const char *name);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
 
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
-extern int pm_genpd_name_poweron(const char *domain_name);
 extern void pm_genpd_poweroff_unused(void);
 
 extern struct dev_power_governor simple_qos_governor;
@@ -166,12 +157,6 @@ static inline int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
-static inline int __pm_genpd_name_add_device(const char *domain_name,
-					     struct device *dev,
-					     struct gpd_timing_data *td)
-{
-	return -ENOSYS;
-}
 static inline int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 					 struct device *dev)
 {
@@ -182,11 +167,6 @@ static inline int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
-static inline int pm_genpd_add_subdomain_names(const char *master_name,
-					       const char *subdomain_name)
-{
-	return -ENOSYS;
-}
 static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 					    struct generic_pm_domain *target)
 {
@@ -196,18 +176,10 @@ static inline int pm_genpd_attach_cpuidle(struct generic_pm_domain *genpd, int s
 {
 	return -ENOSYS;
 }
-static inline int pm_genpd_name_attach_cpuidle(const char *name, int state)
-{
-	return -ENOSYS;
-}
 static inline int pm_genpd_detach_cpuidle(struct generic_pm_domain *genpd)
 {
 	return -ENOSYS;
 }
-static inline int pm_genpd_name_detach_cpuidle(const char *name)
-{
-	return -ENOSYS;
-}
 static inline void pm_genpd_init(struct generic_pm_domain *genpd,
 				 struct dev_power_governor *gov, bool is_off)
 {
@@ -216,10 +188,6 @@ static inline int pm_genpd_poweron(struct generic_pm_domain *genpd)
 {
 	return -ENOSYS;
 }
-static inline int pm_genpd_name_poweron(const char *domain_name)
-{
-	return -ENOSYS;
-}
 static inline void pm_genpd_poweroff_unused(void) {}
 #endif
 
@@ -229,12 +197,6 @@ static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 	return __pm_genpd_add_device(genpd, dev, NULL);
 }
 
-static inline int pm_genpd_name_add_device(const char *domain_name,
-					   struct device *dev)
-{
-	return __pm_genpd_name_add_device(domain_name, dev, NULL);
-}
-
 #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
 extern void pm_genpd_syscore_poweroff(struct device *dev);
 extern void pm_genpd_syscore_poweron(struct device *dev);
-- 
1.9.1


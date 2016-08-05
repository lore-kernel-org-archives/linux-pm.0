From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH] PM / Domains: Replace -ENOSYS with -ENODEV
Date: Fri,  5 Aug 2016 11:06:56 -0600
Message-ID: <1470416816-53336-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35961 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbcHERHC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Aug 2016 13:07:02 -0400
Received: by mail-pf0-f180.google.com with SMTP id h186so98726835pfg.3
        for <linux-pm@vger.kernel.org>; Fri, 05 Aug 2016 10:07:01 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: Lina Iyer <lina.iyer@linaro.org>

ENOSYS is for syscalls that are not supported. ENODEV is a better return
value when the PM Domains are not available.

Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
---
 include/linux/pm_domain.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 688dc57..8a63406 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -151,7 +151,7 @@ extern struct dev_power_governor pm_domain_always_on_gov;
 
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 {
-	return ERR_PTR(-ENOSYS);
+	return ERR_PTR(-ENODEV);
 }
 static inline struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev)
 {
@@ -161,27 +161,27 @@ static inline int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 					struct device *dev,
 					struct gpd_timing_data *td)
 {
-	return -ENOSYS;
+	return -ENODEV;
 }
 static inline int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 					 struct device *dev)
 {
-	return -ENOSYS;
+	return -ENODEV;
 }
 static inline int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 					 struct generic_pm_domain *new_sd)
 {
-	return -ENOSYS;
+	return -ENODEV;
 }
 static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 					    struct generic_pm_domain *target)
 {
-	return -ENOSYS;
+	return -ENODEV;
 }
 static inline int pm_genpd_init(struct generic_pm_domain *genpd,
 				struct dev_power_governor *gov, bool is_off)
 {
-	return -ENOSYS;
+	return -ENODEV;
 }
 static inline int pm_genpd_of_parse_power_states(
 				struct generic_pm_domain *genpd)
-- 
2.7.4


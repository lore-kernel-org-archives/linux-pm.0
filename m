From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/4] PM / Domains: Remove pm_genpd_poweroff_unused() API
Date: Tue,  6 Oct 2015 14:27:42 +0200
Message-ID: <1444134462-17937-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:35517 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbbJFM1r (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 08:27:47 -0400
Received: by lbwr8 with SMTP id r8so75056939lbw.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2015 05:27:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

As the last user of the pm_genpd_poweroff_unused() API has moved into
relying on genpd to deal with this internally from a late_initcall, let's
remove the API.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 10 +++-------
 include/linux/pm_domain.h   |  3 ---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index cf4950d..432d4e3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -502,15 +502,15 @@ static int __init pd_ignore_unused_setup(char *__unused)
 __setup("pd_ignore_unused", pd_ignore_unused_setup);
 
 /**
- * pm_genpd_poweroff_unused - Power off all PM domains with no devices in use.
+ * genpd_poweroff_unused - Power off all PM domains with no devices in use.
  */
-void pm_genpd_poweroff_unused(void)
+static int __init genpd_poweroff_unused(void)
 {
 	struct generic_pm_domain *genpd;
 
 	if (pd_ignore_unused) {
 		pr_warn("genpd: Not disabling unused power domains\n");
-		return;
+		return 0;
 	}
 
 	mutex_lock(&gpd_list_lock);
@@ -519,11 +519,7 @@ void pm_genpd_poweroff_unused(void)
 		genpd_queue_power_off_work(genpd);
 
 	mutex_unlock(&gpd_list_lock);
-}
 
-static int __init genpd_poweroff_unused(void)
-{
-	pm_genpd_poweroff_unused();
 	return 0;
 }
 late_initcall(genpd_poweroff_unused);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 384b1d1..faa6922 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -126,9 +126,7 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 				     struct generic_pm_domain *target);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
-
 extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
-extern void pm_genpd_poweroff_unused(void);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -171,7 +169,6 @@ static inline int pm_genpd_poweron(struct generic_pm_domain *genpd)
 {
 	return -ENOSYS;
 }
-static inline void pm_genpd_poweroff_unused(void) {}
 #endif
 
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-- 
1.9.1


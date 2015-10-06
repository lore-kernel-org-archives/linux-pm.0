From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/4] PM / Domains: Remove pm_genpd_poweron() API
Date: Tue,  6 Oct 2015 14:27:51 +0200
Message-ID: <1444134471-17979-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34115 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbbJFM14 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 08:27:56 -0400
Received: by lbbwt4 with SMTP id wt4so37501115lbb.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2015 05:27:54 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Once genpd could be configured to be built with CONFIG_PM_RUNTIME unset
(nowadays CONFIG_PM), the pm_genpd_poweron() API served a purpose, since
it allowed users to power on a PM domain.

As such configuration no longer is supported, users shall solely rely on
using some of the runtime PM APIs to power on a PM domain.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 4 +++-
 include/linux/pm_domain.h   | 5 -----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 432d4e3..c2c0de9 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -192,6 +192,8 @@ static void genpd_queue_power_off_work(struct generic_pm_domain *genpd)
 	queue_work(pm_wq, &genpd->power_off_work);
 }
 
+static int pm_genpd_poweron(struct generic_pm_domain *genpd);
+
 /**
  * __pm_genpd_poweron - Restore power to a given PM domain and its masters.
  * @genpd: PM domain to power up.
@@ -245,7 +247,7 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
  * pm_genpd_poweron - Restore power to a given PM domain and its masters.
  * @genpd: PM domain to power up.
  */
-int pm_genpd_poweron(struct generic_pm_domain *genpd)
+static int pm_genpd_poweron(struct generic_pm_domain *genpd)
 {
 	int ret;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index faa6922..edc2744 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -126,7 +126,6 @@ extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 				     struct generic_pm_domain *target);
 extern void pm_genpd_init(struct generic_pm_domain *genpd,
 			  struct dev_power_governor *gov, bool is_off);
-extern int pm_genpd_poweron(struct generic_pm_domain *genpd);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -165,10 +164,6 @@ static inline void pm_genpd_init(struct generic_pm_domain *genpd,
 				 struct dev_power_governor *gov, bool is_off)
 {
 }
-static inline int pm_genpd_poweron(struct generic_pm_domain *genpd)
-{
-	return -ENOSYS;
-}
 #endif
 
 static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-- 
1.9.1


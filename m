From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] PM / Domains: avoid unused function warning
Date: Fri, 30 Jun 2017 18:09:13 +0200
Message-ID: <20170630160921.4192052-1-arnd@arndb.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:59537 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdF3QJk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2017 12:09:40 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The only caller of pm_genpd_present outside of CONFIG_PM_GENERIC_DOMAINS_OF
was removed, so we now get a warning when that is disabled:

drivers/base/power/domain.c:725:13: error: 'pm_genpd_present' defined but not used [-Werror=unused-function]

This moves the function definition inside of the #ifdef section.

Fixes: 8b55e55ee443 ("PM / Domains: Handle safely genpd_syscore_switch() call on non-genpd device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/base/power/domain.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7eca0f0cbc3b..a380d9d61335 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -716,28 +716,6 @@ static int __init genpd_power_off_unused(void)
 }
 late_initcall(genpd_power_off_unused);
 
-#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_GENERIC_DOMAINS_OF)
-
-/**
- * pm_genpd_present - Check if the given PM domain has been initialized.
- * @genpd: PM domain to check.
- */
-static bool pm_genpd_present(const struct generic_pm_domain *genpd)
-{
-	const struct generic_pm_domain *gpd;
-
-	if (IS_ERR_OR_NULL(genpd))
-		return false;
-
-	list_for_each_entry(gpd, &gpd_list, gpd_list_node)
-		if (gpd == genpd)
-			return true;
-
-	return false;
-}
-
-#endif
-
 #ifdef CONFIG_PM_SLEEP
 
 static bool genpd_dev_active_wakeup(const struct generic_pm_domain *genpd,
@@ -1675,6 +1653,24 @@ static LIST_HEAD(of_genpd_providers);
 static DEFINE_MUTEX(of_genpd_mutex);
 
 /**
+ * pm_genpd_present - Check if the given PM domain has been initialized.
+ * @genpd: PM domain to check.
+ */
+static bool pm_genpd_present(const struct generic_pm_domain *genpd)
+{
+	const struct generic_pm_domain *gpd;
+
+	if (IS_ERR_OR_NULL(genpd))
+		return false;
+
+	list_for_each_entry(gpd, &gpd_list, gpd_list_node)
+		if (gpd == genpd)
+			return true;
+
+	return false;
+}
+
+/**
  * genpd_xlate_simple() - Xlate function for direct node-domain mapping
  * @genpdspec: OF phandle args to map into a PM domain
  * @data: xlate function private data - pointer to struct generic_pm_domain
-- 
2.9.0

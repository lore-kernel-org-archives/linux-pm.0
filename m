From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Convert pm_genpd_init() to return an error code
Date: Fri, 17 Jun 2016 12:27:52 +0200
Message-ID: <1466159272-9726-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36054 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029AbcFQK16 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Jun 2016 06:27:58 -0400
Received: by mail-lf0-f41.google.com with SMTP id q132so57470924lfe.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Jun 2016 03:27:57 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Axel Haslam <ahaslam@baylibre.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jon Hunter <jonathanh@nvidia.com>, Andy Gross <andy.gross@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The are already cases when pm_genpd_init() can fail. Currently we hide the
failures instead of propagating an error code, which is a better method.

Moreover, to prepare for future changes like moving away from using a
fixed array-size of the struct genpd_power_state, to instead dynamically
allocate data for it, the pm_genpd_init() API needs to be able to return
an error code, as allocation can fail.

Current users of the pm_genpd_init() is thus requested to start dealing
with error codes. In the transition phase, users will have to live with
only error messages being printed to log.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 10 +++++++---
 include/linux/pm_domain.h   |  9 +++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9193aac..a1f2aff 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1258,12 +1258,14 @@ EXPORT_SYMBOL_GPL(pm_genpd_remove_subdomain);
  * @genpd: PM domain object to initialize.
  * @gov: PM domain governor to associate with the domain (may be NULL).
  * @is_off: Initial value of the domain's power_is_off field.
+ *
+ * Returns 0 on successful initialization, else a negative error code.
  */
-void pm_genpd_init(struct generic_pm_domain *genpd,
-		   struct dev_power_governor *gov, bool is_off)
+int pm_genpd_init(struct generic_pm_domain *genpd,
+		  struct dev_power_governor *gov, bool is_off)
 {
 	if (IS_ERR_OR_NULL(genpd))
-		return;
+		return -EINVAL;
 
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
@@ -1321,6 +1323,8 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
 	mutex_unlock(&gpd_list_lock);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(pm_genpd_init);
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index dd5b044..31fec85 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -127,8 +127,8 @@ extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
 				  struct generic_pm_domain *new_subdomain);
 extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 				     struct generic_pm_domain *target);
-extern void pm_genpd_init(struct generic_pm_domain *genpd,
-			  struct dev_power_governor *gov, bool is_off);
+extern int pm_genpd_init(struct generic_pm_domain *genpd,
+			 struct dev_power_governor *gov, bool is_off);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -163,9 +163,10 @@ static inline int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 {
 	return -ENOSYS;
 }
-static inline void pm_genpd_init(struct generic_pm_domain *genpd,
-				 struct dev_power_governor *gov, bool is_off)
+static inline int pm_genpd_init(struct generic_pm_domain *genpd,
+				struct dev_power_governor *gov, bool is_off)
 {
+	return -ENOSYS;
 }
 #endif
 
-- 
1.9.1


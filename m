From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
Subject: [PATCH] PM / Domains: export pm_genpd_add_device symbol
Date: Mon, 16 Nov 2015 14:37:28 +0530
Message-ID: <1447664848-11372-1-git-send-email-Maruthi.Bayyavarapu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bl2on0075.outbound.protection.outlook.com ([65.55.169.75]:17890
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751628AbbKPJwe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 16 Nov 2015 04:52:34 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org
Cc: broonie@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>

Drivers which can be built as loadable module needs
symbol - pm_genpd_add_device to be exported. Those drivers
create platform devices which comes under a powerdomain.

Signed-off-by: Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
---
 drivers/base/power/domain.c | 7 +++++++
 include/linux/pm_domain.h   | 9 ++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f932058..72998f8 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1253,6 +1253,13 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	return ret;
 }
 
+int pm_genpd_add_device(struct generic_pm_domain *genpd,
+				      struct device *dev)
+{
+	return __pm_genpd_add_device(genpd, dev, NULL);
+}
+EXPORT_SYMBOL_GPL(pm_genpd_add_device);
+
 /**
  * pm_genpd_remove_device - Remove a device from an I/O PM domain.
  * @genpd: PM domain to remove the device from.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index ba4ced3..f9e2f7e 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -114,7 +114,8 @@ extern struct generic_pm_domain *pm_genpd_lookup_dev(struct device *dev);
 extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
 				 struct device *dev,
 				 struct gpd_timing_data *td);
-
+extern int pm_genpd_add_device(struct generic_pm_domain *genpd,
+				      struct device *dev);
 extern int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 				  struct device *dev);
 extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
@@ -163,12 +164,6 @@ static inline void pm_genpd_init(struct generic_pm_domain *genpd,
 }
 #endif
 
-static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
-				      struct device *dev)
-{
-	return __pm_genpd_add_device(genpd, dev, NULL);
-}
-
 #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
 extern void pm_genpd_syscore_poweroff(struct device *dev);
 extern void pm_genpd_syscore_poweron(struct device *dev);
-- 
1.9.1


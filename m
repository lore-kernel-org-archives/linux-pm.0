From: Amit Daniel Kachhap <amit.daniel@samsung.com>
Subject: [PATCH v2] PM/ Domains: Export of_genpd_get_from_provider function.
Date: Mon, 15 Dec 2014 09:08:59 +0530
Message-ID: <1418614739-7989-1-git-send-email-amit.daniel@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42880 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbaLODqT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Dec 2014 22:46:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Amit Daniel Kachhap <amit.daniel@samsung.com>

This function looks up a PM domain form the provider. This will be
useful to add parent/child domain relationship from the SoC specific
code. The caller of the function must make sure that PM domain provider
is already registered.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
Changes from v1:
* Added Ulf Hansson Reviewed by.
* Cc'd to linux-pm

This patch may solve the same purpose which is done by earlier posts
1) https://lkml.org/lkml/2014/11/24/319 - In this there were comments
for not using the PM domain name.

2) Ulf Hansson posted a patch
http://www.spinics.net/lists/linux-samsung-soc/msg39745.html which also solves
similar purpose but I feel this is slightly complex and involves changing
the genpd structure.

 drivers/base/power/domain.c | 3 ++-
 include/linux/pm_domain.h   | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6a103a3..0d8780c 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2088,7 +2088,7 @@ EXPORT_SYMBOL_GPL(of_genpd_del_provider);
  * Returns a valid pointer to struct generic_pm_domain on success or ERR_PTR()
  * on failure.
  */
-static struct generic_pm_domain *of_genpd_get_from_provider(
+struct generic_pm_domain *of_genpd_get_from_provider(
 					struct of_phandle_args *genpdspec)
 {
 	struct generic_pm_domain *genpd = ERR_PTR(-ENOENT);
@@ -2108,6 +2108,7 @@ static struct generic_pm_domain *of_genpd_get_from_provider(
 
 	return genpd;
 }
+EXPORT_SYMBOL_GPL(of_genpd_get_from_provider);
 
 /**
  * genpd_dev_pm_detach - Detach a device from its PM domain.
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 6cd20d5..a9edab2 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -271,6 +271,8 @@ typedef struct generic_pm_domain *(*genpd_xlate_t)(struct of_phandle_args *args,
 int __of_genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
 			void *data);
 void of_genpd_del_provider(struct device_node *np);
+struct generic_pm_domain *of_genpd_get_from_provider(
+			struct of_phandle_args *genpdspec);
 
 struct generic_pm_domain *__of_genpd_xlate_simple(
 					struct of_phandle_args *genpdspec,
@@ -288,6 +290,12 @@ static inline int __of_genpd_add_provider(struct device_node *np,
 }
 static inline void of_genpd_del_provider(struct device_node *np) {}
 
+static inline struct generic_pm_domain *of_genpd_get_from_provider(
+			struct of_phandle_args *genpdspec)
+{
+	return NULL;
+}
+
 #define __of_genpd_xlate_simple		NULL
 #define __of_genpd_xlate_onecell	NULL
 
-- 
2.2.0


From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/8] PM / Domains: Rename __pm_genpd_alloc|free_dev_data()
Date: Tue, 27 Jan 2015 21:13:38 +0100
Message-ID: <1422389625-11730-2-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:36437 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbbA0UOH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 15:14:07 -0500
Received: by mail-la0-f46.google.com with SMTP id s18so15384119lam.5
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 12:14:06 -0800 (PST)
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

In a step to get consistent names of functions in genpd, rename
the internal __pm_genpd_alloc|free_dev_data() into
gendp_alloc|free_dev_data().

As discussed on the linux-pm list, let's move towards the following
name rules:

Internal functions:
genpd_*
_genpd_*
__genpd_*

External functions:
pm_genpd_*
_pm_genpd_*
__pm_genpd_*

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c5280f2..f9e7df5 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1384,7 +1384,7 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 
 #endif /* CONFIG_PM_SLEEP */
 
-static struct generic_pm_domain_data *__pm_genpd_alloc_dev_data(struct device *dev)
+static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
 {
 	struct generic_pm_domain_data *gpd_data;
 
@@ -1398,8 +1398,8 @@ static struct generic_pm_domain_data *__pm_genpd_alloc_dev_data(struct device *d
 	return gpd_data;
 }
 
-static void __pm_genpd_free_dev_data(struct device *dev,
-				     struct generic_pm_domain_data *gpd_data)
+static void genpd_free_dev_data(struct device *dev,
+				struct generic_pm_domain_data *gpd_data)
 {
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
 	kfree(gpd_data);
@@ -1423,7 +1423,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data_new = __pm_genpd_alloc_dev_data(dev);
+	gpd_data_new = genpd_alloc_dev_data(dev);
 	if (!gpd_data_new)
 		return -ENOMEM;
 
@@ -1477,7 +1477,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	genpd_release_lock(genpd);
 
 	if (gpd_data != gpd_data_new)
-		__pm_genpd_free_dev_data(dev, gpd_data_new);
+		genpd_free_dev_data(dev, gpd_data_new);
 
 	return ret;
 }
@@ -1548,7 +1548,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
 	dev_pm_put_subsys_data(dev);
 	if (remove)
-		__pm_genpd_free_dev_data(dev, gpd_data);
+		genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
 
-- 
1.9.1


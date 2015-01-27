From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/8] PM / Domains: Don't check for an existing device when adding a new
Date: Tue, 27 Jan 2015 21:13:41 +0100
Message-ID: <1422389625-11730-5-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:52534 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759611AbbA0UOO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 15:14:14 -0500
Received: by mail-la0-f44.google.com with SMTP id s18so15399719lam.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 12:14:13 -0800 (PST)
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

When adding a device to a genpd, we no longer need to walk genpd's list
of existing devices to verify it hasn't already been added.

Instead we can now rely on the verification of not allowing existing
generic_pm_domain_data for a device, since that has the same meaning.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 76eb0c3..88198ba 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1415,7 +1415,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			  struct gpd_timing_data *td)
 {
 	struct generic_pm_domain_data *gpd_data_new, *gpd_data = NULL;
-	struct pm_domain_data *pdd;
 	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
@@ -1434,12 +1433,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 		goto out;
 	}
 
-	list_for_each_entry(pdd, &genpd->dev_list, list_node)
-		if (pdd->dev == dev) {
-			ret = -EINVAL;
-			goto out;
-		}
-
 	ret = dev_pm_get_subsys_data(dev);
 	if (ret)
 		goto out;
-- 
1.9.1


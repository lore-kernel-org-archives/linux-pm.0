From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/8] PM / Domains: Don't allow an existing generic_pm_domain_data
Date: Tue, 27 Jan 2015 21:13:40 +0100
Message-ID: <1422389625-11730-4-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:59722 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759598AbbA0UOM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 15:14:12 -0500
Received: by mail-lb0-f172.google.com with SMTP id l4so15124626lbv.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 12:14:10 -0800 (PST)
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

When adding a device to a genpd, a struct generic_pm_domain_data is
allocated per device.

Verify that there are no existing generic_pm_domain_data for the device
we are about to add, since that tells us it has already been added to a
genpd.

When genpd supported PM domain device callbacks, this was a valid
scenario. Now it isn't so let's return an error code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 351df5b..76eb0c3 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1444,26 +1444,30 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (ret)
 		goto out;
 
-	genpd->device_count++;
-	genpd->max_off_time_changed = true;
-
 	spin_lock_irq(&dev->power.lock);
 
-	dev->pm_domain = &genpd->domain;
 	if (dev->power.subsys_data->domain_data) {
-		gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
-	} else {
-		gpd_data = gpd_data_new;
-		dev->power.subsys_data->domain_data = &gpd_data->base;
+		spin_unlock_irq(&dev->power.lock);
+		ret = -EINVAL;
+		goto out;
 	}
+
+	gpd_data = gpd_data_new;
+	dev->power.subsys_data->domain_data = &gpd_data->base;
+
 	if (td)
 		gpd_data->td = *td;
 
+	dev->pm_domain = &genpd->domain;
+
 	spin_unlock_irq(&dev->power.lock);
 
 	if (genpd->attach_dev)
 		genpd->attach_dev(genpd, dev);
 
+	genpd->device_count++;
+	genpd->max_off_time_changed = true;
+
 	mutex_lock(&gpd_data->lock);
 	gpd_data->base.dev = dev;
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
-- 
1.9.1


From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 1/4] PM / Domains: Remove reference counting for the generic_pm_domain_data
Date: Tue, 28 Oct 2014 15:38:07 +0100
Message-ID: <1414507090-516-2-git-send-email-ulf.hansson@linaro.org>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:60189 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbaJ1OiV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Oct 2014 10:38:21 -0400
Received: by mail-lb0-f178.google.com with SMTP id f15so791238lbj.23
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2014 07:38:20 -0700 (PDT)
In-Reply-To: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

The reference counting isn't needed, let's remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 10 ++--------
 include/linux/pm_domain.h   |  1 -
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 40bc2f4..7546242 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1430,7 +1430,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 		gpd_data = gpd_data_new;
 		dev->power.subsys_data->domain_data = &gpd_data->base;
 	}
-	gpd_data->refcount++;
 	if (td)
 		gpd_data->td = *td;
 
@@ -1478,7 +1477,6 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 {
 	struct generic_pm_domain_data *gpd_data;
 	struct pm_domain_data *pdd;
-	bool remove = false;
 	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
@@ -1507,10 +1505,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	pdd = dev->power.subsys_data->domain_data;
 	list_del_init(&pdd->list_node);
 	gpd_data = to_gpd_data(pdd);
-	if (--gpd_data->refcount == 0) {
-		dev->power.subsys_data->domain_data = NULL;
-		remove = true;
-	}
+	dev->power.subsys_data->domain_data = NULL;
 
 	spin_unlock_irq(&dev->power.lock);
 
@@ -1521,8 +1516,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd_release_lock(genpd);
 
 	dev_pm_put_subsys_data(dev);
-	if (remove)
-		__pm_genpd_free_dev_data(dev, gpd_data);
+	__pm_genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 73e938b..e4edde1 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -103,7 +103,6 @@ struct generic_pm_domain_data {
 	struct gpd_timing_data td;
 	struct notifier_block nb;
 	struct mutex lock;
-	unsigned int refcount;
 	bool need_restore;
 };
 
-- 
1.9.1


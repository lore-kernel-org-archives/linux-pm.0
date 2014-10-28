From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/4] PM / Domains: Improve error handling while adding/removing devices
Date: Tue, 28 Oct 2014 15:38:09 +0100
Message-ID: <1414507090-516-4-git-send-email-ulf.hansson@linaro.org>
References: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33558 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753715AbaJ1Oi1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Oct 2014 10:38:27 -0400
Received: by mail-lb0-f176.google.com with SMTP id p9so732438lbv.35
        for <linux-pm@vger.kernel.org>; Tue, 28 Oct 2014 07:38:26 -0700 (PDT)
In-Reply-To: <1414507090-516-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>

To improve error handling while adding/removing devices from their PM
domains, we need to restructure the code a bit. Let's do this by moving
the device specific parts into a separate function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 132 +++++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 63 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9d511c7..4e5fcd7 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1358,25 +1358,81 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 
 #endif /* CONFIG_PM_SLEEP */
 
-static struct generic_pm_domain_data *__pm_genpd_alloc_dev_data(struct device *dev)
+static int genpd_alloc_dev_data(struct generic_pm_domain *genpd,
+				struct device *dev, struct gpd_timing_data *td)
 {
 	struct generic_pm_domain_data *gpd_data;
+	int ret;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	ret = dev_pm_get_subsys_data(dev);
+	if (ret)
+		return ret;
 
 	gpd_data = kzalloc(sizeof(*gpd_data), GFP_KERNEL);
-	if (!gpd_data)
-		return NULL;
+	if (!gpd_data) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
 
 	mutex_init(&gpd_data->lock);
+	gpd_data->base.dev = dev;
+	gpd_data->td.constraint_changed = true;
+	gpd_data->td.effective_constraint_ns = -1;
 	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
+	if (td)
+		gpd_data->td = *td;
+
+	spin_lock_irq(&dev->power.lock);
+	if (!dev->power.subsys_data->domain_data)
+		dev->power.subsys_data->domain_data = &gpd_data->base;
+	else
+		ret = -EINVAL;
+	spin_unlock_irq(&dev->power.lock);
+
+	if (ret)
+		goto err_data;
+
+	if (genpd->attach_dev)
+		genpd->attach_dev(dev);
+
 	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
-	return gpd_data;
+	return 0;
+
+ err_data:
+	kfree(gpd_data);
+ err_alloc:
+	dev_pm_put_subsys_data(dev);
+	return ret;
 }
 
-static void __pm_genpd_free_dev_data(struct device *dev,
-				     struct generic_pm_domain_data *gpd_data)
+static void genpd_free_dev_data(struct generic_pm_domain *genpd,
+				struct device *dev)
 {
+	struct generic_pm_domain_data *gpd_data;
+	struct pm_domain_data *pdd;
+
+	dev_dbg(dev, "%s()\n", __func__);
+
+	if (genpd->detach_dev)
+		genpd->detach_dev(dev);
+
+	spin_lock_irq(&dev->power.lock);
+	dev->pm_domain = NULL;
+	pdd = dev->power.subsys_data->domain_data;
+	list_del_init(&pdd->list_node);
+	gpd_data = to_gpd_data(pdd);
+	dev->power.subsys_data->domain_data = NULL;
+	spin_unlock_irq(&dev->power.lock);
+
+	mutex_lock(&gpd_data->lock);
+	pdd->dev = NULL;
+	mutex_unlock(&gpd_data->lock);
+
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
 	kfree(gpd_data);
+	dev_pm_put_subsys_data(dev);
 }
 
 /**
@@ -1388,7 +1444,7 @@ static void __pm_genpd_free_dev_data(struct device *dev,
 int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			  struct gpd_timing_data *td)
 {
-	struct generic_pm_domain_data *gpd_data_new, *gpd_data = NULL;
+	struct generic_pm_domain_data *gpd_data;
 	struct pm_domain_data *pdd;
 	int ret = 0;
 
@@ -1397,10 +1453,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data_new = __pm_genpd_alloc_dev_data(dev);
-	if (!gpd_data_new)
-		return -ENOMEM;
-
 	genpd_acquire_lock(genpd);
 
 	if (genpd->prepared_count > 0) {
@@ -1414,46 +1466,25 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			goto out;
 		}
 
-	ret = dev_pm_get_subsys_data(dev);
+	ret = genpd_alloc_dev_data(genpd, dev, td);
 	if (ret)
 		goto out;
 
-	genpd->device_count++;
-	genpd->max_off_time_changed = true;
-
 	spin_lock_irq(&dev->power.lock);
-
-	if (dev->power.subsys_data->domain_data) {
-		ret = -EINVAL;
-		goto out;
-	} else {
-		gpd_data = gpd_data_new;
-		dev->power.subsys_data->domain_data = &gpd_data->base;
-	}
-	if (td)
-		gpd_data->td = *td;
-
 	dev->pm_domain = &genpd->domain;
-
+	gpd_data = to_gpd_data(dev->power.subsys_data->domain_data);
 	spin_unlock_irq(&dev->power.lock);
 
-	if (genpd->attach_dev)
-		genpd->attach_dev(dev);
-
 	mutex_lock(&gpd_data->lock);
-	gpd_data->base.dev = dev;
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 	gpd_data->need_restore = genpd->status == GPD_STATE_POWER_OFF;
-	gpd_data->td.constraint_changed = true;
-	gpd_data->td.effective_constraint_ns = -1;
 	mutex_unlock(&gpd_data->lock);
 
+	genpd->device_count++;
+	genpd->max_off_time_changed = true;
+
  out:
 	genpd_release_lock(genpd);
-
-	if (gpd_data != gpd_data_new)
-		__pm_genpd_free_dev_data(dev, gpd_data_new);
-
 	return ret;
 }
 
@@ -1477,8 +1508,6 @@ int __pm_genpd_name_add_device(const char *domain_name, struct device *dev,
 int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 			   struct device *dev)
 {
-	struct generic_pm_domain_data *gpd_data;
-	struct pm_domain_data *pdd;
 	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
@@ -1498,33 +1527,10 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	genpd->device_count--;
 	genpd->max_off_time_changed = true;
 
-	if (genpd->detach_dev)
-		genpd->detach_dev(dev);
-
-	spin_lock_irq(&dev->power.lock);
-
-	dev->pm_domain = NULL;
-	pdd = dev->power.subsys_data->domain_data;
-	list_del_init(&pdd->list_node);
-	gpd_data = to_gpd_data(pdd);
-	dev->power.subsys_data->domain_data = NULL;
-
-	spin_unlock_irq(&dev->power.lock);
-
-	mutex_lock(&gpd_data->lock);
-	pdd->dev = NULL;
-	mutex_unlock(&gpd_data->lock);
-
-	genpd_release_lock(genpd);
-
-	dev_pm_put_subsys_data(dev);
-	__pm_genpd_free_dev_data(dev, gpd_data);
-
-	return 0;
+	genpd_free_dev_data(genpd, dev);
 
  out:
 	genpd_release_lock(genpd);
-
 	return ret;
 }
 
-- 
1.9.1


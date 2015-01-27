From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 7/8] PM / Domains: Re-order initialization of generic_pm_domain_data
Date: Tue, 27 Jan 2015 21:13:44 +0100
Message-ID: <1422389625-11730-8-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

Move the initialization of the struct generic_pm_domain_data into
genpd_alloc_dev_data(), including the assignment of the device's
->pm_domain() callback. Make corresponding changes to
genpd_free_dev_data().

These changes will make the related code more readable. It will also
decrease the critical regions for where genpd's mutex is being held and
for where the device's power related spinlock is being held.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 67 +++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 3bd342f..0fd5ee1 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1377,7 +1377,9 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 
 #endif /* CONFIG_PM_SLEEP */
 
-static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
+static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
+					struct generic_pm_domain *genpd,
+					struct gpd_timing_data *td)
 {
 	struct generic_pm_domain_data *gpd_data;
 	int ret;
@@ -1392,8 +1394,32 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
 		goto err_put;
 	}
 
+	if (td)
+		gpd_data->td = *td;
+
+	gpd_data->base.dev = dev;
+	gpd_data->need_restore = -1;
+	gpd_data->td.constraint_changed = true;
+	gpd_data->td.effective_constraint_ns = -1;
+	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
+
+	spin_lock_irq(&dev->power.lock);
+
+	if (dev->power.subsys_data->domain_data) {
+		ret = -EINVAL;
+		goto err_free;
+	}
+
+	dev->power.subsys_data->domain_data = &gpd_data->base;
+	dev->pm_domain = &genpd->domain;
+
+	spin_unlock_irq(&dev->power.lock);
+
 	return gpd_data;
 
+ err_free:
+	spin_unlock_irq(&dev->power.lock);
+	kfree(gpd_data);
  err_put:
 	dev_pm_put_subsys_data(dev);
 	return ERR_PTR(ret);
@@ -1402,6 +1428,13 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
 static void genpd_free_dev_data(struct device *dev,
 				struct generic_pm_domain_data *gpd_data)
 {
+	spin_lock_irq(&dev->power.lock);
+
+	dev->pm_domain = NULL;
+	dev->power.subsys_data->domain_data = NULL;
+
+	spin_unlock_irq(&dev->power.lock);
+
 	kfree(gpd_data);
 	dev_pm_put_subsys_data(dev);
 }
@@ -1423,7 +1456,7 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data = genpd_alloc_dev_data(dev);
+	gpd_data = genpd_alloc_dev_data(dev, genpd, td);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
@@ -1434,35 +1467,13 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 		goto out;
 	}
 
-	spin_lock_irq(&dev->power.lock);
-
-	if (dev->power.subsys_data->domain_data) {
-		spin_unlock_irq(&dev->power.lock);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	dev->power.subsys_data->domain_data = &gpd_data->base;
-
-	if (td)
-		gpd_data->td = *td;
-
-	dev->pm_domain = &genpd->domain;
-
-	spin_unlock_irq(&dev->power.lock);
-
 	if (genpd->attach_dev)
 		genpd->attach_dev(genpd, dev);
 
 	genpd->device_count++;
 	genpd->max_off_time_changed = true;
 
-	gpd_data->base.dev = dev;
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
-	gpd_data->need_restore = -1;
-	gpd_data->td.constraint_changed = true;
-	gpd_data->td.effective_constraint_ns = -1;
-	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
 
  out:
 	genpd_release_lock(genpd);
@@ -1524,15 +1535,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	if (genpd->detach_dev)
 		genpd->detach_dev(genpd, dev);
 
-	spin_lock_irq(&dev->power.lock);
-
-	dev->pm_domain = NULL;
 	list_del_init(&pdd->list_node);
-	dev->power.subsys_data->domain_data = NULL;
-
-	spin_unlock_irq(&dev->power.lock);
-
-	pdd->dev = NULL;
 
 	genpd_release_lock(genpd);
 
-- 
1.9.1

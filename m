From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5/8] PM / Domains: Eliminate the mutex for the generic_pm_domain_data
Date: Tue, 27 Jan 2015 21:13:42 +0100
Message-ID: <1422389625-11730-6-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

While adding devices to their PM domains, dev_pm_qos_add_notifier() was
invoked while allocating the generic_pm_domain_data for the device.

Since the generic_pm_domain_data's device pointer will be assigned
after allocation, the ->genpd_dev_pm_qos_notifier() callback could be
called prior having a valid pointer to the device. Similar scenario
existed while removing a device from a genpd.

To cope with these scenarios a mutex was used to protect the pointer to
the device.

By re-order the sequence for when dev_pm_qos_add|remove_notifier() are
invoked, we make sure the ->genpd_dev_pm_qos_notifier() callback are
always called with a valid device pointer available.

In this way, we eliminate the need for protecting the pointer and thus
we can remove the mutex from the struct generic_pm_domain_data.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 37 ++++++++++++++-----------------------
 include/linux/pm_domain.h   |  1 -
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 88198ba..1f026c1 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -344,14 +344,7 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 	struct device *dev;
 
 	gpd_data = container_of(nb, struct generic_pm_domain_data, nb);
-
-	mutex_lock(&gpd_data->lock);
 	dev = gpd_data->base.dev;
-	if (!dev) {
-		mutex_unlock(&gpd_data->lock);
-		return NOTIFY_DONE;
-	}
-	mutex_unlock(&gpd_data->lock);
 
 	for (;;) {
 		struct generic_pm_domain *genpd;
@@ -1392,16 +1385,12 @@ static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev)
 	if (!gpd_data)
 		return NULL;
 
-	mutex_init(&gpd_data->lock);
-	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
-	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
 	return gpd_data;
 }
 
 static void genpd_free_dev_data(struct device *dev,
 				struct generic_pm_domain_data *gpd_data)
 {
-	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
 	kfree(gpd_data);
 }
 
@@ -1414,7 +1403,7 @@ static void genpd_free_dev_data(struct device *dev,
 int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			  struct gpd_timing_data *td)
 {
-	struct generic_pm_domain_data *gpd_data_new, *gpd_data = NULL;
+	struct generic_pm_domain_data *gpd_data;
 	int ret = 0;
 
 	dev_dbg(dev, "%s()\n", __func__);
@@ -1422,8 +1411,8 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data_new = genpd_alloc_dev_data(dev);
-	if (!gpd_data_new)
+	gpd_data = genpd_alloc_dev_data(dev);
+	if (!gpd_data)
 		return -ENOMEM;
 
 	genpd_acquire_lock(genpd);
@@ -1445,7 +1434,6 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 		goto out;
 	}
 
-	gpd_data = gpd_data_new;
 	dev->power.subsys_data->domain_data = &gpd_data->base;
 
 	if (td)
@@ -1461,19 +1449,20 @@ int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	genpd->device_count++;
 	genpd->max_off_time_changed = true;
 
-	mutex_lock(&gpd_data->lock);
 	gpd_data->base.dev = dev;
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 	gpd_data->need_restore = -1;
 	gpd_data->td.constraint_changed = true;
 	gpd_data->td.effective_constraint_ns = -1;
-	mutex_unlock(&gpd_data->lock);
+	gpd_data->nb.notifier_call = genpd_dev_pm_qos_notifier;
 
  out:
 	genpd_release_lock(genpd);
 
-	if (gpd_data != gpd_data_new)
-		genpd_free_dev_data(dev, gpd_data_new);
+	if (ret)
+		genpd_free_dev_data(dev, gpd_data);
+	else
+		dev_pm_qos_add_notifier(dev, &gpd_data->nb);
 
 	return ret;
 }
@@ -1509,6 +1498,11 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	    ||  pd_to_genpd(dev->pm_domain) != genpd)
 		return -EINVAL;
 
+	/* The above validation also means we have existing domain_data. */
+	pdd = dev->power.subsys_data->domain_data;
+	gpd_data = to_gpd_data(pdd);
+	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
+
 	genpd_acquire_lock(genpd);
 
 	if (genpd->prepared_count > 0) {
@@ -1525,16 +1519,12 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 	spin_lock_irq(&dev->power.lock);
 
 	dev->pm_domain = NULL;
-	pdd = dev->power.subsys_data->domain_data;
 	list_del_init(&pdd->list_node);
-	gpd_data = to_gpd_data(pdd);
 	dev->power.subsys_data->domain_data = NULL;
 
 	spin_unlock_irq(&dev->power.lock);
 
-	mutex_lock(&gpd_data->lock);
 	pdd->dev = NULL;
-	mutex_unlock(&gpd_data->lock);
 
 	genpd_release_lock(genpd);
 
@@ -1545,6 +1535,7 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
 
  out:
 	genpd_release_lock(genpd);
+	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
 
 	return ret;
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index e160a0b..080e778 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -113,7 +113,6 @@ struct generic_pm_domain_data {
 	struct pm_domain_data base;
 	struct gpd_timing_data td;
 	struct notifier_block nb;
-	struct mutex lock;
 	int need_restore;
 };
 
-- 
1.9.1

From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 7/9] PM / Domains: Abstract genpd locking
Date: Mon, 24 Oct 2016 15:21:06 -0700
Message-ID: <1477347668-41901-8-git-send-email-lina.iyer@linaro.org>
References: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1477347668-41901-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, brendan.jackman@arm.com, lorenzo.pieralisi@arm.com, sudeep.holla@arm.com, Juri.Lelli@arm.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Abstract genpd lock/unlock calls, in preparation for domain specific
locks added in the following patches.

Cc: Kevin Hilman <khilman@kernel.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 121 +++++++++++++++++++++++++++++---------------
 include/linux/pm_domain.h   |   5 +-
 2 files changed, 85 insertions(+), 41 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f056c80..1ad42f2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -39,6 +39,46 @@
 static LIST_HEAD(gpd_list);
 static DEFINE_MUTEX(gpd_list_lock);
 
+struct genpd_lock_ops {
+	void (*lock)(struct generic_pm_domain *genpd);
+	void (*lock_nested)(struct generic_pm_domain *genpd, int depth);
+	int (*lock_interruptible)(struct generic_pm_domain *genpd);
+	void (*unlock)(struct generic_pm_domain *genpd);
+};
+
+static void genpd_lock_mtx(struct generic_pm_domain *genpd)
+{
+	mutex_lock(&genpd->mlock);
+}
+
+static void genpd_lock_nested_mtx(struct generic_pm_domain *genpd,
+					int depth)
+{
+	mutex_lock_nested(&genpd->mlock, depth);
+}
+
+static int genpd_lock_interruptible_mtx(struct generic_pm_domain *genpd)
+{
+	return mutex_lock_interruptible(&genpd->mlock);
+}
+
+static void genpd_unlock_mtx(struct generic_pm_domain *genpd)
+{
+	return mutex_unlock(&genpd->mlock);
+}
+
+static const struct genpd_lock_ops genpd_mtx_ops = {
+	.lock = genpd_lock_mtx,
+	.lock_nested = genpd_lock_nested_mtx,
+	.lock_interruptible = genpd_lock_interruptible_mtx,
+	.unlock = genpd_unlock_mtx,
+};
+
+#define genpd_lock(p)			p->lock_ops->lock(p)
+#define genpd_lock_nested(p, d)		p->lock_ops->lock_nested(p, d)
+#define genpd_lock_interruptible(p)	p->lock_ops->lock_interruptible(p)
+#define genpd_unlock(p)			p->lock_ops->unlock(p)
+
 /*
  * Get the generic PM domain for a particular struct device.
  * This validates the struct device pointer, the PM domain pointer,
@@ -200,9 +240,9 @@ static int genpd_poweron(struct generic_pm_domain *genpd, unsigned int depth)
 
 		genpd_sd_counter_inc(master);
 
-		mutex_lock_nested(&master->lock, depth + 1);
+		genpd_lock_nested(master, depth + 1);
 		ret = genpd_poweron(master, depth + 1);
-		mutex_unlock(&master->lock);
+		genpd_unlock(master);
 
 		if (ret) {
 			genpd_sd_counter_dec(master);
@@ -255,9 +295,9 @@ static int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 		spin_unlock_irq(&dev->power.lock);
 
 		if (!IS_ERR(genpd)) {
-			mutex_lock(&genpd->lock);
+			genpd_lock(genpd);
 			genpd->max_off_time_changed = true;
-			mutex_unlock(&genpd->lock);
+			genpd_unlock(genpd);
 		}
 
 		dev = dev->parent;
@@ -354,9 +394,9 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 
 	genpd = container_of(work, struct generic_pm_domain, power_off_work);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	genpd_poweroff(genpd, true);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 }
 
 /**
@@ -472,9 +512,9 @@ static int genpd_runtime_suspend(struct device *dev)
 	if (dev->power.irq_safe)
 		return 0;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	genpd_poweroff(genpd, false);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	return 0;
 }
@@ -509,9 +549,9 @@ static int genpd_runtime_resume(struct device *dev)
 		goto out;
 	}
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 	ret = genpd_poweron(genpd, 0);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	if (ret)
 		return ret;
@@ -547,9 +587,9 @@ err_stop:
 	genpd_stop_dev(genpd, dev);
 err_poweroff:
 	if (!dev->power.irq_safe) {
-		mutex_lock(&genpd->lock);
+		genpd_lock(genpd);
 		genpd_poweroff(genpd, 0);
-		mutex_unlock(&genpd->lock);
+		genpd_unlock(genpd);
 	}
 
 	return ret;
@@ -732,20 +772,20 @@ static int pm_genpd_prepare(struct device *dev)
 	if (resume_needed(dev, genpd))
 		pm_runtime_resume(dev);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (genpd->prepared_count++ == 0)
 		genpd->suspended_count = 0;
 
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	ret = pm_generic_prepare(dev);
 	if (ret) {
-		mutex_lock(&genpd->lock);
+		genpd_lock(genpd);
 
 		genpd->prepared_count--;
 
-		mutex_unlock(&genpd->lock);
+		genpd_unlock(genpd);
 	}
 
 	return ret;
@@ -936,13 +976,13 @@ static void pm_genpd_complete(struct device *dev)
 
 	pm_generic_complete(dev);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	genpd->prepared_count--;
 	if (!genpd->prepared_count)
 		genpd_queue_power_off_work(genpd);
 
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 }
 
 /**
@@ -1071,7 +1111,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (genpd->prepared_count > 0) {
 		ret = -EAGAIN;
@@ -1088,7 +1128,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	list_add_tail(&gpd_data->base.list_node, &genpd->dev_list);
 
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	if (ret)
 		genpd_free_dev_data(dev, gpd_data);
@@ -1130,7 +1170,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	gpd_data = to_gpd_data(pdd);
 	dev_pm_qos_remove_notifier(dev, &gpd_data->nb);
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (genpd->prepared_count > 0) {
 		ret = -EAGAIN;
@@ -1145,14 +1185,14 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 
 	list_del_init(&pdd->list_node);
 
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	genpd_free_dev_data(dev, gpd_data);
 
 	return 0;
 
  out:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	dev_pm_qos_add_notifier(dev, &gpd_data->nb);
 
 	return ret;
@@ -1187,8 +1227,8 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 	if (!link)
 		return -ENOMEM;
 
-	mutex_lock(&subdomain->lock);
-	mutex_lock_nested(&genpd->lock, SINGLE_DEPTH_NESTING);
+	genpd_lock(subdomain);
+	genpd_lock_nested(genpd, SINGLE_DEPTH_NESTING);
 
 	if (genpd->status == GPD_STATE_POWER_OFF
 	    &&  subdomain->status != GPD_STATE_POWER_OFF) {
@@ -1211,8 +1251,8 @@ static int genpd_add_subdomain(struct generic_pm_domain *genpd,
 		genpd_sd_counter_inc(genpd);
 
  out:
-	mutex_unlock(&genpd->lock);
-	mutex_unlock(&subdomain->lock);
+	genpd_unlock(genpd);
+	genpd_unlock(subdomain);
 	if (ret)
 		kfree(link);
 	return ret;
@@ -1250,8 +1290,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(subdomain))
 		return -EINVAL;
 
-	mutex_lock(&subdomain->lock);
-	mutex_lock_nested(&genpd->lock, SINGLE_DEPTH_NESTING);
+	genpd_lock(subdomain);
+	genpd_lock_nested(genpd, SINGLE_DEPTH_NESTING);
 
 	if (!list_empty(&subdomain->master_links) || subdomain->device_count) {
 		pr_warn("%s: unable to remove subdomain %s\n", genpd->name,
@@ -1275,8 +1315,8 @@ int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
 	}
 
 out:
-	mutex_unlock(&genpd->lock);
-	mutex_unlock(&subdomain->lock);
+	genpd_unlock(genpd);
+	genpd_unlock(subdomain);
 
 	return ret;
 }
@@ -1316,7 +1356,8 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	INIT_LIST_HEAD(&genpd->master_links);
 	INIT_LIST_HEAD(&genpd->slave_links);
 	INIT_LIST_HEAD(&genpd->dev_list);
-	mutex_init(&genpd->lock);
+	mutex_init(&genpd->mlock);
+	genpd->lock_ops = &genpd_mtx_ops;
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
 	atomic_set(&genpd->sd_count, 0);
@@ -1364,16 +1405,16 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	if (IS_ERR_OR_NULL(genpd))
 		return -EINVAL;
 
-	mutex_lock(&genpd->lock);
+	genpd_lock(genpd);
 
 	if (genpd->has_provider) {
-		mutex_unlock(&genpd->lock);
+		genpd_unlock(genpd);
 		pr_err("Provider present, unable to remove %s\n", genpd->name);
 		return -EBUSY;
 	}
 
 	if (!list_empty(&genpd->master_links) || genpd->device_count) {
-		mutex_unlock(&genpd->lock);
+		genpd_unlock(genpd);
 		pr_err("%s: unable to remove %s\n", __func__, genpd->name);
 		return -EBUSY;
 	}
@@ -1385,7 +1426,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	}
 
 	list_del(&genpd->gpd_list_node);
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
 	kfree(genpd->free);
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
@@ -1909,9 +1950,9 @@ int genpd_dev_pm_attach(struct device *dev)
 	dev->pm_domain->detach = genpd_dev_pm_detach;
 	dev->pm_domain->sync = genpd_dev_pm_sync;
 
-	mutex_lock(&pd->lock);
+	genpd_lock(pd);
 	ret = genpd_poweron(pd, 0);
-	mutex_unlock(&pd->lock);
+	genpd_unlock(pd);
 out:
 	return ret ? -EPROBE_DEFER : 0;
 }
@@ -2064,7 +2105,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 	char state[16];
 	int ret;
 
-	ret = mutex_lock_interruptible(&genpd->lock);
+	ret = genpd_lock_interruptible(genpd);
 	if (ret)
 		return -ERESTARTSYS;
 
@@ -2101,7 +2142,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 
 	seq_puts(s, "\n");
 exit:
-	mutex_unlock(&genpd->lock);
+	genpd_unlock(genpd);
 
 	return 0;
 }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 6a89881..811b968 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -42,13 +42,14 @@ struct genpd_power_state {
 	struct fwnode_handle *fwnode;
 };
 
+struct genpd_lock_ops;
+
 struct generic_pm_domain {
 	struct dev_pm_domain domain;	/* PM domain operations */
 	struct list_head gpd_list_node;	/* Node in the global PM domains list */
 	struct list_head master_links;	/* Links with PM domain as a master */
 	struct list_head slave_links;	/* Links with PM domain as a slave */
 	struct list_head dev_list;	/* List of devices */
-	struct mutex lock;
 	struct dev_power_governor *gov;
 	struct work_struct power_off_work;
 	struct fwnode_handle *provider;	/* Identity of the domain provider */
@@ -74,6 +75,8 @@ struct generic_pm_domain {
 	unsigned int state_count; /* number of states */
 	unsigned int state_idx; /* state that genpd will go to when off */
 	void *free; /* Free the state that was allocated for default */
+	const struct genpd_lock_ops *lock_ops;
+	struct mutex mlock;
 
 };
 
-- 
2.7.4

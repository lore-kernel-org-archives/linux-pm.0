From: Mayuresh Kulkarni <mkulkarni@nvidia.com>
Subject: [PATCH] PM/domains: add delayed power off capability
Date: Tue, 12 Mar 2013 14:19:19 +0530
Message-ID: <1363078159-17571-1-git-send-email-mkulkarni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:6336 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755231Ab3CLItZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Mar 2013 04:49:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: len.brown@intel.com, pavel@ucw.cz, rjw@sisk.pl, gregkh@linuxfoundation.org, pdeschrijver@nvidia.com, Mayuresh Kulkarni <mkulkarni@nvidia.com>

- this commit adds a capability to delay the powering off
of the domain
- callers can use pm_genpd_set_poweroff_delay to set the
power off delay for a domain
- it expects the delay in milli-seconds
- it also adds a pm_notifier per pm domain which cancels
the delayed power off work when system suspend is invoked

Signed-off-by: Mayuresh Kulkarni <mkulkarni@nvidia.com>
---

- The idea here is to avoid the powering off of a domain if use cases causes
it to turn on within specific time in coming future
- This seems to save power and better response by avoiding context save/restore
which are heavy operations in most of the cases

 drivers/base/power/domain.c | 84 ++++++++++++++++++++++++++++++++++++++++++---
 include/linux/pm_domain.h   | 14 ++++++++
 2 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 9a6b05a..349f778 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -585,6 +585,19 @@ static int pm_genpd_poweroff(struct generic_pm_domain *genpd)
 	return ret;
 }
 
+static int __pm_genpd_poweroff(struct generic_pm_domain *genpd)
+{
+	int ret = 0;
+
+	mutex_lock(&genpd->lock);
+	genpd->in_progress++;
+	ret = pm_genpd_poweroff(genpd);
+	genpd->in_progress--;
+	mutex_unlock(&genpd->lock);
+
+	return ret;
+}
+
 /**
  * genpd_power_off_work_fn - Power off PM domain whose subdomain count is 0.
  * @work: Work structure used for scheduling the execution of this function.
@@ -601,6 +614,22 @@ static void genpd_power_off_work_fn(struct work_struct *work)
 }
 
 /**
+ * genpd_delayed_power_off_work_fn - Power off PM domain after the delay.
+ * @work: Delayed work structure used for scheduling the
+ *        execution of this function.
+ */
+static void genpd_delayed_power_off_work_fn(struct work_struct *work)
+{
+	struct generic_pm_domain *genpd;
+	struct delayed_work *delay_work = to_delayed_work(work);
+
+	genpd = container_of(delay_work, struct generic_pm_domain,
+		power_off_delayed_work);
+
+	__pm_genpd_poweroff(genpd);
+}
+
+/**
  * pm_genpd_runtime_suspend - Suspend a device belonging to I/O PM domain.
  * @dev: Device to suspend.
  *
@@ -637,11 +666,11 @@ static int pm_genpd_runtime_suspend(struct device *dev)
 	if (dev->power.irq_safe)
 		return 0;
 
-	mutex_lock(&genpd->lock);
-	genpd->in_progress++;
-	pm_genpd_poweroff(genpd);
-	genpd->in_progress--;
-	mutex_unlock(&genpd->lock);
+	if (genpd->power_off_delay)
+		queue_delayed_work(pm_wq, &genpd->power_off_delayed_work,
+			msecs_to_jiffies(genpd->power_off_delay));
+	else
+		__pm_genpd_poweroff(genpd);
 
 	return 0;
 }
@@ -672,6 +701,12 @@ static int pm_genpd_runtime_resume(struct device *dev)
 	if (dev->power.irq_safe)
 		return genpd_start_dev_no_timing(genpd, dev);
 
+	if (genpd->power_off_delay) {
+		if (delayed_work_pending(&genpd->power_off_delayed_work))
+			cancel_delayed_work_sync(
+				&genpd->power_off_delayed_work);
+	}
+
 	mutex_lock(&genpd->lock);
 	ret = __pm_genpd_poweron(genpd);
 	if (ret) {
@@ -730,6 +765,7 @@ static inline int genpd_dev_pm_qos_notifier(struct notifier_block *nb,
 }
 
 static inline void genpd_power_off_work_fn(struct work_struct *work) {}
+static inline void genpd_delayed_power_off_work_fn(struct work_struct *work) {}
 
 #define pm_genpd_runtime_suspend	NULL
 #define pm_genpd_runtime_resume		NULL
@@ -2101,6 +2137,36 @@ static int pm_genpd_default_thaw(struct device *dev)
 	return cb ? cb(dev) : pm_generic_thaw(dev);
 }
 
+static int pm_genpd_suspend_notifier(struct notifier_block *notifier,
+	unsigned long pm_event, void *unused)
+{
+	struct generic_pm_domain *genpd = container_of(notifier,
+		struct generic_pm_domain, system_suspend_notifier);
+
+	if (!genpd)
+		return NOTIFY_DONE;
+
+	switch (pm_event) {
+	case PM_SUSPEND_PREPARE:
+		if (genpd->power_off_delay) {
+			/* if a domain has scheduled a delayed work */
+			if (delayed_work_pending(
+				&genpd->power_off_delayed_work)) {
+
+				/* cancel it now */
+				cancel_delayed_work_sync(
+					&genpd->power_off_delayed_work);
+
+				/* call its power off */
+				__pm_genpd_poweroff(genpd);
+			}
+		}
+		return NOTIFY_OK;
+	}
+
+	return NOTIFY_DONE;
+}
+
 #else /* !CONFIG_PM_SLEEP */
 
 #define pm_genpd_default_suspend	NULL
@@ -2132,7 +2198,10 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	mutex_init(&genpd->lock);
 	genpd->gov = gov;
 	INIT_WORK(&genpd->power_off_work, genpd_power_off_work_fn);
+	INIT_DELAYED_WORK(&genpd->power_off_delayed_work,
+		genpd_delayed_power_off_work_fn);
 	genpd->in_progress = 0;
+	genpd->power_off_delay = 0;
 	atomic_set(&genpd->sd_count, 0);
 	genpd->status = is_off ? GPD_STATE_POWER_OFF : GPD_STATE_ACTIVE;
 	init_waitqueue_head(&genpd->status_wait_queue);
@@ -2174,6 +2243,11 @@ void pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->dev_ops.freeze_late = pm_genpd_default_freeze_late;
 	genpd->dev_ops.thaw_early = pm_genpd_default_thaw_early;
 	genpd->dev_ops.thaw = pm_genpd_default_thaw;
+#ifdef CONFIG_PM_SLEEP
+	genpd->system_suspend_notifier.notifier_call =
+		pm_genpd_suspend_notifier;
+	register_pm_notifier(&genpd->system_suspend_notifier);
+#endif
 	mutex_lock(&gpd_list_lock);
 	list_add(&genpd->gpd_list_node, &gpd_list);
 	mutex_unlock(&gpd_list_lock);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 7c1d252..3ffb068 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -82,6 +82,11 @@ struct generic_pm_domain {
 	bool cached_power_down_ok;
 	struct device_node *of_node; /* Node in device tree */
 	struct gpd_cpu_data *cpu_data;
+	struct delayed_work power_off_delayed_work;
+	s64 power_off_delay;
+#ifdef CONFIG_PM_SLEEP
+	struct notifier_block system_suspend_notifier;
+#endif
 };
 
 static inline struct generic_pm_domain *pd_to_genpd(struct dev_pm_domain *pd)
@@ -127,6 +132,12 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 	return to_gpd_data(dev->power.subsys_data->domain_data);
 }
 
+static inline void pm_genpd_set_poweroff_delay(struct generic_pm_domain *genpd,
+	s64 delay)
+{
+	genpd->power_off_delay = delay;
+}
+
 extern struct dev_power_governor simple_qos_governor;
 
 extern struct generic_pm_domain *dev_to_genpd(struct device *dev);
@@ -170,6 +181,9 @@ extern bool default_stop_ok(struct device *dev);
 extern struct dev_power_governor pm_domain_always_on_gov;
 #else
 
+static inline void pm_genpd_set_poweroff_delay(struct generic_pm_domain *genpd,
+	s64 delay) {}
+
 static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 {
 	return ERR_PTR(-ENOSYS);
-- 
1.8.1.5


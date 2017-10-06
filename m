From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] PM / Domains: Rename genpd internals from pm_genpd_* to genpd_*
Date: Fri,  6 Oct 2017 09:02:06 +0200
Message-ID: <1507273326-26132-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f47.google.com ([209.85.215.47]:45690 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbdJFHCP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Oct 2017 03:02:15 -0400
Received: by mail-lf0-f47.google.com with SMTP id d17so19333420lfe.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Oct 2017 00:02:14 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>

Most of the functions names has already moved the genpd naming rules,
however let's make this complete to avoid any further confusions.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 104 +++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 54 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e8ca5e2..a6e4c8d 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -749,11 +749,7 @@ late_initcall(genpd_power_off_unused);
 
 #if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM_GENERIC_DOMAINS_OF)
 
-/**
- * pm_genpd_present - Check if the given PM domain has been initialized.
- * @genpd: PM domain to check.
- */
-static bool pm_genpd_present(const struct generic_pm_domain *genpd)
+static bool genpd_present(const struct generic_pm_domain *genpd)
 {
 	const struct generic_pm_domain *gpd;
 
@@ -863,7 +859,7 @@ static void genpd_sync_power_on(struct generic_pm_domain *genpd, bool use_lock,
  * @genpd: PM domain the device belongs to.
  *
  * There are two cases in which a device that can wake up the system from sleep
- * states should be resumed by pm_genpd_prepare(): (1) if the device is enabled
+ * states should be resumed by genpd_prepare(): (1) if the device is enabled
  * to wake up the system and it has to remain active for this purpose while the
  * system is in the sleep state and (2) if the device is not enabled to wake up
  * the system from sleep states and it generally doesn't generate wakeup signals
@@ -886,7 +882,7 @@ static bool resume_needed(struct device *dev,
 }
 
 /**
- * pm_genpd_prepare - Start power transition of a device in a PM domain.
+ * genpd_prepare - Start power transition of a device in a PM domain.
  * @dev: Device to start the transition of.
  *
  * Start a power transition of a device (during a system-wide power transition)
@@ -894,7 +890,7 @@ static bool resume_needed(struct device *dev,
  * an object of type struct generic_pm_domain representing a PM domain
  * consisting of I/O devices.
  */
-static int pm_genpd_prepare(struct device *dev)
+static int genpd_prepare(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	int ret;
@@ -975,13 +971,13 @@ static int genpd_finish_suspend(struct device *dev, bool poweroff)
 }
 
 /**
- * pm_genpd_suspend_noirq - Completion of suspend of device in an I/O PM domain.
+ * genpd_suspend_noirq - Completion of suspend of device in an I/O PM domain.
  * @dev: Device to suspend.
  *
  * Stop the device and remove power from the domain if all devices in it have
  * been stopped.
  */
-static int pm_genpd_suspend_noirq(struct device *dev)
+static int genpd_suspend_noirq(struct device *dev)
 {
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -989,12 +985,12 @@ static int pm_genpd_suspend_noirq(struct device *dev)
 }
 
 /**
- * pm_genpd_resume_noirq - Start of resume of device in an I/O PM domain.
+ * genpd_resume_noirq - Start of resume of device in an I/O PM domain.
  * @dev: Device to resume.
  *
  * Restore power to the device's PM domain, if necessary, and start the device.
  */
-static int pm_genpd_resume_noirq(struct device *dev)
+static int genpd_resume_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	int ret = 0;
@@ -1024,7 +1020,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
 }
 
 /**
- * pm_genpd_freeze_noirq - Completion of freezing a device in an I/O PM domain.
+ * genpd_freeze_noirq - Completion of freezing a device in an I/O PM domain.
  * @dev: Device to freeze.
  *
  * Carry out a late freeze of a device under the assumption that its
@@ -1032,7 +1028,7 @@ static int pm_genpd_resume_noirq(struct device *dev)
  * struct generic_pm_domain representing a power domain consisting of I/O
  * devices.
  */
-static int pm_genpd_freeze_noirq(struct device *dev)
+static int genpd_freeze_noirq(struct device *dev)
 {
 	const struct generic_pm_domain *genpd;
 	int ret = 0;
@@ -1054,13 +1050,13 @@ static int pm_genpd_freeze_noirq(struct device *dev)
 }
 
 /**
- * pm_genpd_thaw_noirq - Early thaw of device in an I/O PM domain.
+ * genpd_thaw_noirq - Early thaw of device in an I/O PM domain.
  * @dev: Device to thaw.
  *
  * Start the device, unless power has been removed from the domain already
  * before the system transition.
  */
-static int pm_genpd_thaw_noirq(struct device *dev)
+static int genpd_thaw_noirq(struct device *dev)
 {
 	const struct generic_pm_domain *genpd;
 	int ret = 0;
@@ -1081,14 +1077,14 @@ static int pm_genpd_thaw_noirq(struct device *dev)
 }
 
 /**
- * pm_genpd_poweroff_noirq - Completion of hibernation of device in an
+ * genpd_poweroff_noirq - Completion of hibernation of device in an
  *   I/O PM domain.
  * @dev: Device to poweroff.
  *
  * Stop the device and remove power from the domain if all devices in it have
  * been stopped.
  */
-static int pm_genpd_poweroff_noirq(struct device *dev)
+static int genpd_poweroff_noirq(struct device *dev)
 {
 	dev_dbg(dev, "%s()\n", __func__);
 
@@ -1096,13 +1092,13 @@ static int pm_genpd_poweroff_noirq(struct device *dev)
 }
 
 /**
- * pm_genpd_restore_noirq - Start of restore of device in an I/O PM domain.
+ * genpd_restore_noirq - Start of restore of device in an I/O PM domain.
  * @dev: Device to resume.
  *
  * Make sure the domain will be in the same power state as before the
  * hibernation the system is resuming from and start the device if necessary.
  */
-static int pm_genpd_restore_noirq(struct device *dev)
+static int genpd_restore_noirq(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 	int ret = 0;
@@ -1139,7 +1135,7 @@ static int pm_genpd_restore_noirq(struct device *dev)
 }
 
 /**
- * pm_genpd_complete - Complete power transition of a device in a power domain.
+ * genpd_complete - Complete power transition of a device in a power domain.
  * @dev: Device to complete the transition of.
  *
  * Complete a power transition of a device (during a system-wide power
@@ -1147,7 +1143,7 @@ static int pm_genpd_restore_noirq(struct device *dev)
  * domain member of an object of type struct generic_pm_domain representing
  * a power domain consisting of I/O devices.
  */
-static void pm_genpd_complete(struct device *dev)
+static void genpd_complete(struct device *dev)
 {
 	struct generic_pm_domain *genpd;
 
@@ -1180,7 +1176,7 @@ static void genpd_syscore_switch(struct device *dev, bool suspend)
 	struct generic_pm_domain *genpd;
 
 	genpd = dev_to_genpd(dev);
-	if (!pm_genpd_present(genpd))
+	if (!genpd_present(genpd))
 		return;
 
 	if (suspend) {
@@ -1206,14 +1202,14 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 
 #else /* !CONFIG_PM_SLEEP */
 
-#define pm_genpd_prepare		NULL
-#define pm_genpd_suspend_noirq		NULL
-#define pm_genpd_resume_noirq		NULL
-#define pm_genpd_freeze_noirq		NULL
-#define pm_genpd_thaw_noirq		NULL
-#define pm_genpd_poweroff_noirq		NULL
-#define pm_genpd_restore_noirq		NULL
-#define pm_genpd_complete		NULL
+#define genpd_prepare		NULL
+#define genpd_suspend_noirq	NULL
+#define genpd_resume_noirq	NULL
+#define genpd_freeze_noirq	NULL
+#define genpd_thaw_noirq	NULL
+#define genpd_poweroff_noirq	NULL
+#define genpd_restore_noirq	NULL
+#define genpd_complete		NULL
 
 #endif /* CONFIG_PM_SLEEP */
 
@@ -1574,14 +1570,14 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	genpd->accounting_time = ktime_get();
 	genpd->domain.ops.runtime_suspend = genpd_runtime_suspend;
 	genpd->domain.ops.runtime_resume = genpd_runtime_resume;
-	genpd->domain.ops.prepare = pm_genpd_prepare;
-	genpd->domain.ops.suspend_noirq = pm_genpd_suspend_noirq;
-	genpd->domain.ops.resume_noirq = pm_genpd_resume_noirq;
-	genpd->domain.ops.freeze_noirq = pm_genpd_freeze_noirq;
-	genpd->domain.ops.thaw_noirq = pm_genpd_thaw_noirq;
-	genpd->domain.ops.poweroff_noirq = pm_genpd_poweroff_noirq;
-	genpd->domain.ops.restore_noirq = pm_genpd_restore_noirq;
-	genpd->domain.ops.complete = pm_genpd_complete;
+	genpd->domain.ops.prepare = genpd_prepare;
+	genpd->domain.ops.suspend_noirq = genpd_suspend_noirq;
+	genpd->domain.ops.resume_noirq = genpd_resume_noirq;
+	genpd->domain.ops.freeze_noirq = genpd_freeze_noirq;
+	genpd->domain.ops.thaw_noirq = genpd_thaw_noirq;
+	genpd->domain.ops.poweroff_noirq = genpd_poweroff_noirq;
+	genpd->domain.ops.restore_noirq = genpd_restore_noirq;
+	genpd->domain.ops.complete = genpd_complete;
 
 	if (genpd->flags & GENPD_FLAG_PM_CLK) {
 		genpd->dev_ops.stop = pm_clk_suspend;
@@ -1795,7 +1791,7 @@ int of_genpd_add_provider_simple(struct device_node *np,
 
 	mutex_lock(&gpd_list_lock);
 
-	if (pm_genpd_present(genpd)) {
+	if (genpd_present(genpd)) {
 		ret = genpd_add_provider(np, genpd_xlate_simple, genpd);
 		if (!ret) {
 			genpd->provider = &np->fwnode;
@@ -1831,7 +1827,7 @@ int of_genpd_add_provider_onecell(struct device_node *np,
 	for (i = 0; i < data->num_domains; i++) {
 		if (!data->domains[i])
 			continue;
-		if (!pm_genpd_present(data->domains[i]))
+		if (!genpd_present(data->domains[i]))
 			goto error;
 
 		data->domains[i]->provider = &np->fwnode;
@@ -2274,7 +2270,7 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 #include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/kobject.h>
-static struct dentry *pm_genpd_debugfs_dir;
+static struct dentry *genpd_debugfs_dir;
 
 /*
  * TODO: This function is a slightly modified version of rtpm_status_show
@@ -2302,8 +2298,8 @@ static void rtpm_status_str(struct seq_file *s, struct device *dev)
 	seq_puts(s, p);
 }
 
-static int pm_genpd_summary_one(struct seq_file *s,
-				struct generic_pm_domain *genpd)
+static int genpd_summary_one(struct seq_file *s,
+			struct generic_pm_domain *genpd)
 {
 	static const char * const status_lookup[] = {
 		[GPD_STATE_ACTIVE] = "on",
@@ -2373,7 +2369,7 @@ static int genpd_summary_show(struct seq_file *s, void *data)
 		return -ERESTARTSYS;
 
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
-		ret = pm_genpd_summary_one(s, genpd);
+		ret = genpd_summary_one(s, genpd);
 		if (ret)
 			break;
 	}
@@ -2559,23 +2555,23 @@ define_genpd_debugfs_fops(active_time);
 define_genpd_debugfs_fops(total_idle_time);
 define_genpd_debugfs_fops(devices);
 
-static int __init pm_genpd_debug_init(void)
+static int __init genpd_debug_init(void)
 {
 	struct dentry *d;
 	struct generic_pm_domain *genpd;
 
-	pm_genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
+	genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
 
-	if (!pm_genpd_debugfs_dir)
+	if (!genpd_debugfs_dir)
 		return -ENOMEM;
 
 	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
-			pm_genpd_debugfs_dir, NULL, &genpd_summary_fops);
+			genpd_debugfs_dir, NULL, &genpd_summary_fops);
 	if (!d)
 		return -ENOMEM;
 
 	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
-		d = debugfs_create_dir(genpd->name, pm_genpd_debugfs_dir);
+		d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
 		if (!d)
 			return -ENOMEM;
 
@@ -2595,11 +2591,11 @@ static int __init pm_genpd_debug_init(void)
 
 	return 0;
 }
-late_initcall(pm_genpd_debug_init);
+late_initcall(genpd_debug_init);
 
-static void __exit pm_genpd_debug_exit(void)
+static void __exit genpd_debug_exit(void)
 {
-	debugfs_remove_recursive(pm_genpd_debugfs_dir);
+	debugfs_remove_recursive(genpd_debugfs_dir);
 }
-__exitcall(pm_genpd_debug_exit);
+__exitcall(genpd_debug_exit);
 #endif /* CONFIG_DEBUG_FS */
-- 
2.7.4

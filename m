From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH 2/2] PM / Domains: Extend generic power domain debugfs.
Date: Thu, 25 May 2017 19:51:33 -0400
Message-ID: <1495756293-29534-3-git-send-email-thara.gopinath@linaro.org>
References: <1495756293-29534-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:32802 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161779AbdEYXvr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2017 19:51:47 -0400
Received: by mail-pf0-f178.google.com with SMTP id e193so180987194pfh.0
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2017 16:51:47 -0700 (PDT)
In-Reply-To: <1495756293-29534-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, ulf.hansson@linaro.org, khilman@baylibre.com

This patch extends the existing generic power domain debugfs.
Changes involve the following
- Remove the current flat format of displaying generic power domain
  summary.
- Introduce a unique debugfs entry for each generic power domain with the
  following attributes
	- current_state - Displays current state of the domain.
	- devices - Displays the devices associated with this domain.
	- slaves - Displays the sub power domains.
	- on_time - Displays the time the domain was in on state in ms.
	- idle_time - Displays the time the domain was in any of the idle
			states in ms.
	- idle_states - Displays the various idle states and the time
			spent in each idle state in ms.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/base/power/domain.c | 233 ++++++++++++++++++++++++++++----------------
 1 file changed, 150 insertions(+), 83 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index e733796..3c06e33 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2214,137 +2214,204 @@ EXPORT_SYMBOL_GPL(of_genpd_parse_idle_states);
 #include <linux/kobject.h>
 static struct dentry *pm_genpd_debugfs_dir;
 
-/*
- * TODO: This function is a slightly modified version of rtpm_status_show
- * from sysfs.c, so generalize it.
- */
-static void rtpm_status_str(struct seq_file *s, struct device *dev)
+static int pm_genpd_idle_states_show(struct seq_file *s, void *data)
 {
-	static const char * const status_lookup[] = {
-		[RPM_ACTIVE] = "active",
-		[RPM_RESUMING] = "resuming",
-		[RPM_SUSPENDED] = "suspended",
-		[RPM_SUSPENDING] = "suspending"
-	};
-	const char *p = "";
-
-	if (dev->power.runtime_error)
-		p = "error";
-	else if (dev->power.disable_depth)
-		p = "unsupported";
-	else if (dev->power.runtime_status < ARRAY_SIZE(status_lookup))
-		p = status_lookup[dev->power.runtime_status];
-	else
-		WARN_ON(1);
+	struct generic_pm_domain *genpd = s->private;
+	int i, ret = 0;
+
+	ret = genpd_lock_interruptible(genpd);
+	if (ret)
+		return -ERESTARTSYS;
+
+	seq_puts(s, "State          Time Spent(ms)\n");
+
+	for (i = 0; i < genpd->state_count; i++) {
+		ktime_t delta = 0;
+		s64 msecs;
+
+		if ((genpd->status == GPD_STATE_POWER_OFF) &&
+				(genpd->state_idx == i))
+			delta = ktime_sub(ktime_get(), genpd->accounting_time);
+
+		msecs = ktime_to_ms(
+			ktime_add(genpd->states[i].active_time, delta));
+		seq_printf(s, "S%-15i %lld\n", i, msecs);
+	}
 
-	seq_puts(s, p);
+	genpd_unlock(genpd);
+	return ret;
 }
 
-static int pm_genpd_summary_one(struct seq_file *s,
-				struct generic_pm_domain *genpd)
+static int pm_genpd_slaves_show(struct seq_file *s, void *data)
 {
-	static const char * const status_lookup[] = {
-		[GPD_STATE_ACTIVE] = "on",
-		[GPD_STATE_POWER_OFF] = "off"
-	};
-	struct pm_domain_data *pm_data;
-	const char *kobj_path;
+	struct generic_pm_domain *genpd = s->private;
 	struct gpd_link *link;
-	char state[16];
-	int ret;
+	int ret = 0;
 
 	ret = genpd_lock_interruptible(genpd);
 	if (ret)
 		return -ERESTARTSYS;
 
-	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
-		goto exit;
-	if (!genpd_status_on(genpd))
-		snprintf(state, sizeof(state), "%s-%u",
-			 status_lookup[genpd->status], genpd->state_idx);
-	else
-		snprintf(state, sizeof(state), "%s",
-			 status_lookup[genpd->status]);
-	seq_printf(s, "%-30s  %-15s ", genpd->name, state);
-
-	/*
-	 * Modifications on the list require holding locks on both
-	 * master and slave, so we are safe.
-	 * Also genpd->name is immutable.
-	 */
 	list_for_each_entry(link, &genpd->master_links, master_node) {
 		seq_printf(s, "%s", link->slave->name);
 		if (!list_is_last(&link->master_node, &genpd->master_links))
 			seq_puts(s, ", ");
 	}
+	seq_puts(s, "\n");
 
-	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
-		kobj_path = kobject_get_path(&pm_data->dev->kobj,
-				genpd_is_irq_safe(genpd) ?
-				GFP_ATOMIC : GFP_KERNEL);
-		if (kobj_path == NULL)
-			continue;
+	genpd_unlock(genpd);
+	return ret;
+}
 
-		seq_printf(s, "\n    %-50s  ", kobj_path);
-		rtpm_status_str(s, pm_data->dev);
-		kfree(kobj_path);
-	}
+static int pm_genpd_status_show(struct seq_file *s, void *data)
+{
+	static const char * const status_lookup[] = {
+		[GPD_STATE_ACTIVE] = "on",
+		[GPD_STATE_POWER_OFF] = "off"
+	};
 
-	seq_puts(s, "\n");
+	struct generic_pm_domain *genpd = s->private;
+	int ret = 0;
+
+	ret = genpd_lock_interruptible(genpd);
+	if (ret)
+		return -ERESTARTSYS;
+
+	if (WARN_ON(genpd->status >= ARRAY_SIZE(status_lookup)))
+		goto exit;
+
+	if (genpd->status == GPD_STATE_POWER_OFF)
+		seq_printf(s, "%s-%u\n", status_lookup[genpd->status],
+			genpd->state_idx);
+	else
+		seq_printf(s, "%s\n", status_lookup[genpd->status]);
 exit:
 	genpd_unlock(genpd);
+	return ret;
+}
 
-	return 0;
+static int pm_genpd_on_time_show(struct seq_file *s, void *data)
+{
+	struct generic_pm_domain *genpd = s->private;
+	ktime_t delta = 0;
+	int ret = 0;
+
+	ret = genpd_lock_interruptible(genpd);
+	if (ret)
+		return -ERESTARTSYS;
+
+	if (genpd->status == GPD_STATE_ACTIVE)
+		delta = ktime_sub(ktime_get(), genpd->accounting_time);
+
+	seq_printf(s, "%lld ms\n", ktime_to_ms(
+				ktime_add(genpd->on_time, delta)));
+
+	genpd_unlock(genpd);
+	return ret;
 }
 
-static int pm_genpd_summary_show(struct seq_file *s, void *data)
+static int pm_genpd_idle_time_show(struct seq_file *s, void *data)
 {
-	struct generic_pm_domain *genpd;
+	struct generic_pm_domain *genpd = s->private;
+	ktime_t delta = 0;
 	int ret = 0;
 
-	seq_puts(s, "domain                          status          slaves\n");
-	seq_puts(s, "    /device                                             runtime status\n");
-	seq_puts(s, "----------------------------------------------------------------------\n");
+	ret = genpd_lock_interruptible(genpd);
+	if (ret)
+		return -ERESTARTSYS;
+
+	if (genpd->status == GPD_STATE_POWER_OFF)
+		delta = ktime_sub(ktime_get(), genpd->accounting_time);
+
+	seq_printf(s, "%lld ms\n",
+			ktime_to_ms(ktime_add(genpd->off_time, delta)));
 
-	ret = mutex_lock_interruptible(&gpd_list_lock);
+	genpd_unlock(genpd);
+	return ret;
+}
+
+static int pm_genpd_devices_show(struct seq_file *s, void *data)
+{
+	struct generic_pm_domain *genpd = s->private;
+	struct pm_domain_data *pm_data;
+	const char *kobj_path;
+	int ret = 0;
+
+	ret = genpd_lock_interruptible(genpd);
 	if (ret)
 		return -ERESTARTSYS;
 
-	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
-		ret = pm_genpd_summary_one(s, genpd);
-		if (ret)
-			break;
+	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
+		kobj_path = kobject_get_path(&pm_data->dev->kobj,
+				genpd_is_irq_safe(genpd) ?
+				GFP_ATOMIC : GFP_KERNEL);
+		if (kobj_path == NULL)
+			continue;
+
+		seq_printf(s, "%s\n", kobj_path);
+		kfree(kobj_path);
 	}
-	mutex_unlock(&gpd_list_lock);
 
+	genpd_unlock(genpd);
 	return ret;
 }
 
-static int pm_genpd_summary_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pm_genpd_summary_show, NULL);
+#define define_pm_genpd_open_function(name) \
+static int pm_genpd_##name##_open(struct inode *inode, struct file *file) \
+{ \
+	return single_open(file, pm_genpd_##name##_show, inode->i_private); \
 }
 
-static const struct file_operations pm_genpd_summary_fops = {
-	.open = pm_genpd_summary_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+define_pm_genpd_open_function(status);
+define_pm_genpd_open_function(slaves);
+define_pm_genpd_open_function(idle_states);
+define_pm_genpd_open_function(on_time);
+define_pm_genpd_open_function(idle_time);
+define_pm_genpd_open_function(devices);
+
+#define define_pm_genpd_debugfs_fops(name) \
+static const struct file_operations pm_genpd_##name##_fops = { \
+	.open = pm_genpd_##name##_open, \
+	.read = seq_read, \
+	.llseek = seq_lseek, \
+	.release = single_release, \
+}
+
+define_pm_genpd_debugfs_fops(status);
+define_pm_genpd_debugfs_fops(slaves);
+define_pm_genpd_debugfs_fops(idle_states);
+define_pm_genpd_debugfs_fops(on_time);
+define_pm_genpd_debugfs_fops(idle_time);
+define_pm_genpd_debugfs_fops(devices);
 
 static int __init pm_genpd_debug_init(void)
 {
 	struct dentry *d;
+	struct generic_pm_domain *genpd;
 
 	pm_genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
 
 	if (!pm_genpd_debugfs_dir)
 		return -ENOMEM;
 
-	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
-			pm_genpd_debugfs_dir, NULL, &pm_genpd_summary_fops);
-	if (!d)
-		return -ENOMEM;
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		d = debugfs_create_dir(genpd->name, pm_genpd_debugfs_dir);
+		if (!d)
+			return -ENOMEM;
+
+		debugfs_create_file("current_state", 0444,
+				d, genpd, &pm_genpd_status_fops);
+		debugfs_create_file("slaves", 0444,
+				d, genpd, &pm_genpd_slaves_fops);
+		debugfs_create_file("idle_states", 0444,
+				d, genpd, &pm_genpd_idle_states_fops);
+		debugfs_create_file("on_time", 0444,
+				d, genpd, &pm_genpd_on_time_fops);
+		debugfs_create_file("idle_time", 0444,
+				d, genpd, &pm_genpd_idle_time_fops);
+		debugfs_create_file("devices", 0444,
+				d, genpd, &pm_genpd_devices_fops);
+	}
 
 	return 0;
 }
-- 
2.1.4

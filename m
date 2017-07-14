From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH V4 2/2] PM / Domains: Extend generic power domain debugfs.
Date: Fri, 14 Jul 2017 13:10:16 -0400
Message-ID: <1500052216-22252-3-git-send-email-thara.gopinath@linaro.org>
References: <1500052216-22252-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33683 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753716AbdGNRKW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jul 2017 13:10:22 -0400
Received: by mail-qk0-f172.google.com with SMTP id a66so66566822qkb.0
        for <linux-pm@vger.kernel.org>; Fri, 14 Jul 2017 10:10:22 -0700 (PDT)
In-Reply-To: <1500052216-22252-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org

This patch extends the existing generic power domain debugfs.
Changes involve the following
- Introduce a unique debugfs entry for each generic power domain with the
  following attributes
	- current_state - Displays current state of the domain.
	- devices - Displays the devices associated with this domain.
	- sub_domains - Displays the sub power domains.
	- active_time - Displays the time the domain was in active state
			in ms.
	- total_idle_time - Displays the time the domain was in any of the idle
			states in ms.
	- idle_states - Displays the various idle states and the time
			spent in each idle state in ms.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 205 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 195 insertions(+), 10 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 640ffc5..2e59219 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2359,7 +2359,7 @@ static int pm_genpd_summary_one(struct seq_file *s,
 	return 0;
 }
 
-static int pm_genpd_summary_show(struct seq_file *s, void *data)
+static int genpd_summary_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd;
 	int ret = 0;
@@ -2382,21 +2382,187 @@ static int pm_genpd_summary_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int pm_genpd_summary_open(struct inode *inode, struct file *file)
+static int genpd_status_show(struct seq_file *s, void *data)
 {
-	return single_open(file, pm_genpd_summary_show, NULL);
+	static const char * const status_lookup[] = {
+		[GPD_STATE_ACTIVE] = "on",
+		[GPD_STATE_POWER_OFF] = "off"
+	};
+
+	struct generic_pm_domain *genpd = s->private;
+	int ret = 0;
+
+	ret = genpd_lock_interruptible(genpd);
+	if (ret)
+		return -ERESTARTSYS;
+
+	if (WARN_ON_ONCE(genpd->status >= ARRAY_SIZE(status_lookup)))
+		goto exit;
+
+	if (genpd->status == GPD_STATE_POWER_OFF)
+		seq_printf(s, "%s-%u\n", status_lookup[genpd->status],
+			genpd->state_idx);
+	else
+		seq_printf(s, "%s\n", status_lookup[genpd->status]);
+exit:
+	genpd_unlock(genpd);
+	return ret;
 }
 
-static const struct file_operations pm_genpd_summary_fops = {
-	.open = pm_genpd_summary_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+static int genpd_sub_domains_show(struct seq_file *s, void *data)
+{
+	struct generic_pm_domain *genpd = s->private;
+	struct gpd_link *link;
+	int ret = 0;
+
+	ret = genpd_lock_interruptible(genpd);
+	if (ret)
+		return -ERESTARTSYS;
+
+	list_for_each_entry(link, &genpd->master_links, master_node)
+		seq_printf(s, "%s\n", link->slave->name);
+
+	genpd_unlock(genpd);
+	return ret;
+}
+
+static int genpd_idle_states_show(struct seq_file *s, void *data)
+{
+	struct generic_pm_domain *genpd = s->private;
+	unsigned int i;
+	int ret = 0;
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
+			ktime_add(genpd->states[i].idle_time, delta));
+		seq_printf(s, "S%-13i %lld\n", i, msecs);
+	}
+
+	genpd_unlock(genpd);
+	return ret;
+}
+
+static int genpd_active_time_show(struct seq_file *s, void *data)
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
+}
+
+static int genpd_total_idle_time_show(struct seq_file *s, void *data)
+{
+	struct generic_pm_domain *genpd = s->private;
+	ktime_t delta = 0, total = 0;
+	unsigned int i;
+	int ret = 0;
+
+	ret = genpd_lock_interruptible(genpd);
+	if (ret)
+		return -ERESTARTSYS;
+
+	for (i = 0; i < genpd->state_count; i++) {
+
+		if ((genpd->status == GPD_STATE_POWER_OFF) &&
+				(genpd->state_idx == i))
+			delta = ktime_sub(ktime_get(), genpd->accounting_time);
+
+		total = ktime_add(total, genpd->states[i].idle_time);
+	}
+	total = ktime_add(total, delta);
+
+	seq_printf(s, "%lld ms\n", ktime_to_ms(total));
+
+	genpd_unlock(genpd);
+	return ret;
+}
+
+
+static int genpd_devices_show(struct seq_file *s, void *data)
+{
+	struct generic_pm_domain *genpd = s->private;
+	struct pm_domain_data *pm_data;
+	const char *kobj_path;
+	int ret = 0;
+
+	ret = genpd_lock_interruptible(genpd);
+	if (ret)
+		return -ERESTARTSYS;
+
+	list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
+		kobj_path = kobject_get_path(&pm_data->dev->kobj,
+				genpd_is_irq_safe(genpd) ?
+				GFP_ATOMIC : GFP_KERNEL);
+		if (kobj_path == NULL)
+			continue;
+
+		seq_printf(s, "%s\n", kobj_path);
+		kfree(kobj_path);
+	}
+
+	genpd_unlock(genpd);
+	return ret;
+}
+
+#define define_genpd_open_function(name) \
+static int genpd_##name##_open(struct inode *inode, struct file *file) \
+{ \
+	return single_open(file, genpd_##name##_show, inode->i_private); \
+}
+
+define_genpd_open_function(summary);
+define_genpd_open_function(status);
+define_genpd_open_function(sub_domains);
+define_genpd_open_function(idle_states);
+define_genpd_open_function(active_time);
+define_genpd_open_function(total_idle_time);
+define_genpd_open_function(devices);
+
+#define define_genpd_debugfs_fops(name) \
+static const struct file_operations genpd_##name##_fops = { \
+	.open = genpd_##name##_open, \
+	.read = seq_read, \
+	.llseek = seq_lseek, \
+	.release = single_release, \
+}
+
+define_genpd_debugfs_fops(summary);
+define_genpd_debugfs_fops(status);
+define_genpd_debugfs_fops(sub_domains);
+define_genpd_debugfs_fops(idle_states);
+define_genpd_debugfs_fops(active_time);
+define_genpd_debugfs_fops(total_idle_time);
+define_genpd_debugfs_fops(devices);
 
 static int __init pm_genpd_debug_init(void)
 {
 	struct dentry *d;
+	struct generic_pm_domain *genpd;
 
 	pm_genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
 
@@ -2404,10 +2570,29 @@ static int __init pm_genpd_debug_init(void)
 		return -ENOMEM;
 
 	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
-			pm_genpd_debugfs_dir, NULL, &pm_genpd_summary_fops);
+			pm_genpd_debugfs_dir, NULL, &genpd_summary_fops);
 	if (!d)
 		return -ENOMEM;
 
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		d = debugfs_create_dir(genpd->name, pm_genpd_debugfs_dir);
+		if (!d)
+			return -ENOMEM;
+
+		debugfs_create_file("current_state", 0444,
+				d, genpd, &genpd_status_fops);
+		debugfs_create_file("sub_domains", 0444,
+				d, genpd, &genpd_sub_domains_fops);
+		debugfs_create_file("idle_states", 0444,
+				d, genpd, &genpd_idle_states_fops);
+		debugfs_create_file("active_time", 0444,
+				d, genpd, &genpd_active_time_fops);
+		debugfs_create_file("total_idle_time", 0444,
+				d, genpd, &genpd_total_idle_time_fops);
+		debugfs_create_file("devices", 0444,
+				d, genpd, &genpd_devices_fops);
+	}
+
 	return 0;
 }
 late_initcall(pm_genpd_debug_init);
-- 
2.1.4

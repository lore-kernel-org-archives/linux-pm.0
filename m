From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [RESEND] PM / Domains: remove define_genpd_open_function() and define_genpd_debugfs_fops()
Date: Sat, 15 Dec 2018 03:45:26 -0500
Message-ID: <20181215084526.27210-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

We already have the DEFINE_SHOW_ATTRIBUTE, There is no need to define
such a macro, so remove define_genpd_open_function and
define_genpd_debugfs_fops.

Convert them to DEFINE_SHOW_ATTRIBUTE.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/base/power/domain.c | 71 +++++++++++++------------------------
 1 file changed, 24 insertions(+), 47 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 7f38a92b444a..10a61d6147d0 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2671,7 +2671,7 @@ static int genpd_summary_one(struct seq_file *s,
 	return 0;
 }
 
-static int genpd_summary_show(struct seq_file *s, void *data)
+static int summary_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd;
 	int ret = 0;
@@ -2694,7 +2694,7 @@ static int genpd_summary_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_status_show(struct seq_file *s, void *data)
+static int status_show(struct seq_file *s, void *data)
 {
 	static const char * const status_lookup[] = {
 		[GPD_STATE_ACTIVE] = "on",
@@ -2721,7 +2721,7 @@ static int genpd_status_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_sub_domains_show(struct seq_file *s, void *data)
+static int sub_domains_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	struct gpd_link *link;
@@ -2738,7 +2738,7 @@ static int genpd_sub_domains_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_idle_states_show(struct seq_file *s, void *data)
+static int idle_states_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	unsigned int i;
@@ -2767,7 +2767,7 @@ static int genpd_idle_states_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_active_time_show(struct seq_file *s, void *data)
+static int active_time_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	ktime_t delta = 0;
@@ -2787,7 +2787,7 @@ static int genpd_active_time_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_total_idle_time_show(struct seq_file *s, void *data)
+static int total_idle_time_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	ktime_t delta = 0, total = 0;
@@ -2815,7 +2815,7 @@ static int genpd_total_idle_time_show(struct seq_file *s, void *data)
 }
 
 
-static int genpd_devices_show(struct seq_file *s, void *data)
+static int devices_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 	struct pm_domain_data *pm_data;
@@ -2841,7 +2841,7 @@ static int genpd_devices_show(struct seq_file *s, void *data)
 	return ret;
 }
 
-static int genpd_perf_state_show(struct seq_file *s, void *data)
+static int perf_state_show(struct seq_file *s, void *data)
 {
 	struct generic_pm_domain *genpd = s->private;
 
@@ -2854,37 +2854,14 @@ static int genpd_perf_state_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-#define define_genpd_open_function(name) \
-static int genpd_##name##_open(struct inode *inode, struct file *file) \
-{ \
-	return single_open(file, genpd_##name##_show, inode->i_private); \
-}
-
-define_genpd_open_function(summary);
-define_genpd_open_function(status);
-define_genpd_open_function(sub_domains);
-define_genpd_open_function(idle_states);
-define_genpd_open_function(active_time);
-define_genpd_open_function(total_idle_time);
-define_genpd_open_function(devices);
-define_genpd_open_function(perf_state);
-
-#define define_genpd_debugfs_fops(name) \
-static const struct file_operations genpd_##name##_fops = { \
-	.open = genpd_##name##_open, \
-	.read = seq_read, \
-	.llseek = seq_lseek, \
-	.release = single_release, \
-}
-
-define_genpd_debugfs_fops(summary);
-define_genpd_debugfs_fops(status);
-define_genpd_debugfs_fops(sub_domains);
-define_genpd_debugfs_fops(idle_states);
-define_genpd_debugfs_fops(active_time);
-define_genpd_debugfs_fops(total_idle_time);
-define_genpd_debugfs_fops(devices);
-define_genpd_debugfs_fops(perf_state);
+DEFINE_SHOW_ATTRIBUTE(summary);
+DEFINE_SHOW_ATTRIBUTE(status);
+DEFINE_SHOW_ATTRIBUTE(sub_domains);
+DEFINE_SHOW_ATTRIBUTE(idle_states);
+DEFINE_SHOW_ATTRIBUTE(active_time);
+DEFINE_SHOW_ATTRIBUTE(total_idle_time);
+DEFINE_SHOW_ATTRIBUTE(devices);
+DEFINE_SHOW_ATTRIBUTE(perf_state);
 
 static int __init genpd_debug_init(void)
 {
@@ -2897,7 +2874,7 @@ static int __init genpd_debug_init(void)
 		return -ENOMEM;
 
 	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
-			genpd_debugfs_dir, NULL, &genpd_summary_fops);
+			genpd_debugfs_dir, NULL, &summary_fops);
 	if (!d)
 		return -ENOMEM;
 
@@ -2907,20 +2884,20 @@ static int __init genpd_debug_init(void)
 			return -ENOMEM;
 
 		debugfs_create_file("current_state", 0444,
-				d, genpd, &genpd_status_fops);
+				d, genpd, &status_fops);
 		debugfs_create_file("sub_domains", 0444,
-				d, genpd, &genpd_sub_domains_fops);
+				d, genpd, &sub_domains_fops);
 		debugfs_create_file("idle_states", 0444,
-				d, genpd, &genpd_idle_states_fops);
+				d, genpd, &idle_states_fops);
 		debugfs_create_file("active_time", 0444,
-				d, genpd, &genpd_active_time_fops);
+				d, genpd, &active_time_fops);
 		debugfs_create_file("total_idle_time", 0444,
-				d, genpd, &genpd_total_idle_time_fops);
+				d, genpd, &total_idle_time_fops);
 		debugfs_create_file("devices", 0444,
-				d, genpd, &genpd_devices_fops);
+				d, genpd, &devices_fops);
 		if (genpd->set_performance_state)
 			debugfs_create_file("perf_state", 0444,
-					    d, genpd, &genpd_perf_state_fops);
+					    d, genpd, &perf_state_fops);
 	}
 
 	return 0;
-- 
2.17.0

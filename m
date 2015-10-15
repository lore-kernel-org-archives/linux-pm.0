From: ahaslam@baylibre.com
Subject: [PATCH v8 6/6] PM / Domains: add debugfs 'states' and 'timings' seq files
Date: Thu, 15 Oct 2015 14:16:36 +0200
Message-ID: <1444911396-3473-7-git-send-email-ahaslam@baylibre.com>
References: <1444911396-3473-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:35827 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbbJOMQ6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 08:16:58 -0400
Received: by wicll6 with SMTP id ll6so37913844wic.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 05:16:57 -0700 (PDT)
In-Reply-To: <1444911396-3473-1-git-send-email-ahaslam@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: khilman@linaro.org, ulf.hansson@linaro.org, lina.iyer@linaro.org, geert@glider.be, k.kozlowski.k@gmail.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: bcousson@baylibre.com, mturquette@baylibre.com, Marc Titinger <mtitinger@baylibre.com>

From: Marc Titinger <mtitinger@baylibre.com>

This purpose of these debug seq-files is to help investigate generic
power domain state transitions, based on device constraints.

also rename 'summary' from 'pm_genpd_summary'

sample output for 'states'
==========================

  Domain             State name        Eval = 2200nter + Exit = Min_off_on (ns)
-----------------------------------------------------------------------
a53_pd               cluster-sleep-0      1500000+800000=2300000
a57_pd               d1-retention         1000000+800000=1800000
a57_pd               cluster-sleep-0      1500000+800000=2300000

sample output for 'timings'
===========================

    Domain Devices, Timings in ns
                       Stop/Start Save/Restore, Effective
----------------------------------------------------  ---
a53_pd
    /cpus/cpu@100        1060  /660    1580  /1940  ,0 (cached stop)
    /cpus/cpu@101        1060  /740    1520  /1600  ,0 (cached stop)
    /cpus/cpu@102        880   /620    1380  /1780  ,0 (cached stop)
    /cpus/cpu@103        1080  /640    1340  /1600  ,0 (cached stop)
a57_pd
    /cpus/cpu@0          1160  /740    3280  /1800  ,0 (cached stop)
    /cpus/cpu@1          780   /1400   1440  /2080  ,0 (cached stop)
    /D1                  600   /540    7140  /6420  ,2199460 (cached stop)

Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
---
 drivers/base/power/domain.c | 107 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index df2f244..c1750ba 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2277,6 +2277,96 @@ static const struct file_operations pm_genpd_summary_fops = {
 	.release = single_release,
 };
 
+static int pm_genpd_states_show(struct seq_file *s, void *data)
+{
+	struct generic_pm_domain *genpd;
+
+	seq_puts(s,
+		 "\n  Domain             State name        Enter + Exit = Min_off_on (ns)\n");
+	seq_puts(s,
+		 "-----------------------------------------------------------------------\n");
+
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+
+		int i;
+
+		for (i = 0; i < genpd->state_count; i++) {
+			seq_printf(s, "%-20s %-20s %lld+%lld=%lld\n",
+				   genpd->name,
+				   genpd->states[i].name,
+				   genpd->states[i].power_on_latency_ns,
+				   genpd->states[i].power_off_latency_ns,
+				   genpd->states[i].power_off_latency_ns
+				   + genpd->states[i].power_on_latency_ns);
+		}
+
+	}
+
+	seq_puts(s, "\n");
+
+	return 0;
+}
+
+static int pm_genpd_states_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pm_genpd_states_show, NULL);
+}
+
+static const struct file_operations pm_genpd_states_fops = {
+	.open = pm_genpd_states_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
+static int pm_genpd_timing_show(struct seq_file *s, void *data)
+{
+	struct generic_pm_domain *genpd;
+
+	seq_puts(s, "\n    Domain Devices, Timings in ns\n");
+	seq_puts(s,
+		 "                       Stop/Start Save/Restore, Effective\n");
+	seq_puts(s,
+		 "----------------------------------------------------  ---\n");
+
+	list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
+		struct pm_domain_data *pm_data;
+
+		seq_printf(s, "%-30s", genpd->name);
+
+		list_for_each_entry(pm_data, &genpd->dev_list, list_node) {
+			struct gpd_timing_data *td = &to_gpd_data(pm_data)->td;
+
+			if (!pm_data->dev->of_node)
+				continue;
+
+			seq_printf(s,
+				   "\n    %-20s %-6lld/%-6lld %-6lld/%-6lld,%lld %s%s",
+				   pm_data->dev->of_node->full_name,
+				   td->stop_latency_ns, td->start_latency_ns,
+				   td->save_state_latency_ns,
+				   td->restore_state_latency_ns,
+				   td->effective_constraint_ns,
+				   td->cached_stop_ok ? "(cached stop) " : "",
+				   td->constraint_changed ? "(changed)" : "");
+		}
+		seq_puts(s, "\n");
+	}
+	return 0;
+}
+
+static int pm_genpd_timing_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, pm_genpd_timing_show, NULL);
+}
+
+static const struct file_operations pm_genpd_timing_fops = {
+	.open = pm_genpd_timing_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};
+
 static int __init pm_genpd_debug_init(void)
 {
 	struct dentry *d;
@@ -2286,8 +2376,21 @@ static int __init pm_genpd_debug_init(void)
 	if (!pm_genpd_debugfs_dir)
 		return -ENOMEM;
 
-	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
-			pm_genpd_debugfs_dir, NULL, &pm_genpd_summary_fops);
+	d = debugfs_create_file("summary", S_IRUGO,
+				pm_genpd_debugfs_dir, NULL,
+				&pm_genpd_summary_fops);
+	if (!d)
+		return -ENOMEM;
+
+	d = debugfs_create_file("states", S_IRUGO,
+				pm_genpd_debugfs_dir, NULL,
+				&pm_genpd_states_fops);
+	if (!d)
+		return -ENOMEM;
+
+	d = debugfs_create_file("timings", S_IRUGO,
+				pm_genpd_debugfs_dir, NULL,
+				&pm_genpd_timing_fops);
 	if (!d)
 		return -ENOMEM;
 
-- 
2.4.5


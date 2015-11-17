From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 06/27] PM / Domains: add debugfs 'states' and 'timings' seq files
Date: Tue, 17 Nov 2015 15:37:30 -0700
Message-ID: <1447799871-56374-7-git-send-email-lina.iyer@linaro.org>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36441 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932383AbbKQWi2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:38:28 -0500
Received: by pacdm15 with SMTP id dm15so22074009pac.3
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2015 14:38:28 -0800 (PST)
In-Reply-To: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com

From: Marc Titinger <mtitinger@baylibre.com>

This purpose of these debug seq-files is to help investigate
generic power domain state transitions, based on device constraints.
requires the "multiple states" patches from Axel Haslam.

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
 drivers/base/power/domain.c | 115 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 107 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index c300293..9a0df09 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2169,21 +2169,120 @@ static const struct file_operations pm_genpd_summary_fops = {
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
-	struct dentry *d;
+	struct dentry *d = NULL;
 
 	pm_genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
 
-	if (!pm_genpd_debugfs_dir)
-		return -ENOMEM;
+	if (pm_genpd_debugfs_dir)
+		d = debugfs_create_file("summary", S_IRUGO,
+				pm_genpd_debugfs_dir, NULL,
+				&pm_genpd_summary_fops);
+	if (d)
+		d = debugfs_create_file("states", S_IRUGO,
+				pm_genpd_debugfs_dir, NULL,
+				&pm_genpd_states_fops);
+	if (d)
+		d = debugfs_create_file("timings", S_IRUGO,
+				pm_genpd_debugfs_dir, NULL,
+				&pm_genpd_timing_fops);
+	if (d)
+		return 0;
 
-	d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
-			pm_genpd_debugfs_dir, NULL, &pm_genpd_summary_fops);
-	if (!d)
-		return -ENOMEM;
+	debugfs_remove_recursive(pm_genpd_debugfs_dir /*can be null*/);
 
-	return 0;
+	return -ENOMEM;
 }
 late_initcall(pm_genpd_debug_init);
 
-- 
2.1.4


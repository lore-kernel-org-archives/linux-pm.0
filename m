From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 24/26] cpu_cooling: Store frequencies in descending order
Date: Fri, 28 Nov 2014 15:14:18 +0530
Message-ID: <ecb90bfbe1dd69ad73210630ce0a2f988d6210f1.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:52091 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbaK1JqI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:46:08 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so6449671pac.8
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:46:08 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

CPUFreq framework *doesn't* guarantee that frequencies present in cpufreq table
will be in ascending or descending order. But cpu_cooling somehow assumes that.

Probably because most of current users are creating this list from DT, which is
done with the help of OPP layer. And OPP layer creates the list in ascending
order of frequencies.

But cpu_cooling can be used for other platforms too, which don't have
frequencies arranged in any order.

This patch tries to fix this issue by creating another list of valid frequencies
in descending order. Care is also taken to throw warnings for duplicate entries.

Later patches would use it to simplify code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 07414c5..9a4a323 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -65,6 +65,7 @@ struct cpufreq_cooling_device {
 	unsigned int cpufreq_state;
 	unsigned int cpufreq_val;
 	unsigned int max_level;
+	unsigned int *freq_table;	/* In descending order */
 	struct cpumask allowed_cpus;
 	struct list_head head;
 };
@@ -321,6 +322,20 @@ static struct notifier_block thermal_cpufreq_notifier_block = {
 	.notifier_call = cpufreq_thermal_notifier,
 };
 
+static unsigned int find_next_max(struct cpufreq_frequency_table *table,
+				  unsigned int prev_max)
+{
+	struct cpufreq_frequency_table *pos;
+	unsigned int max = 0;
+
+	cpufreq_for_each_valid_entry(pos, table) {
+		if (pos->frequency > max && pos->frequency < prev_max)
+			max = pos->frequency;
+	}
+
+	return max;
+}
+
 /**
  * __cpufreq_cooling_register - helper function to create cpufreq cooling device
  * @np: a valid struct device_node to the cooling device device tree node
@@ -343,6 +358,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	struct cpufreq_cooling_device *cpufreq_dev;
 	char dev_name[THERMAL_NAME_LENGTH];
 	struct cpufreq_frequency_table *pos, *table;
+	unsigned int freq, i;
 
 	table = cpufreq_frequency_get_table(cpumask_first(clip_cpus));
 	if (!table) {
@@ -358,6 +374,14 @@ __cpufreq_cooling_register(struct device_node *np,
 	cpufreq_for_each_valid_entry(pos, table)
 		cpufreq_dev->max_level++;
 
+	cpufreq_dev->freq_table = kmalloc(sizeof(*cpufreq_dev->freq_table) *
+					  cpufreq_dev->max_level, GFP_KERNEL);
+	if (!cpufreq_dev->freq_table) {
+		return ERR_PTR(-ENOMEM);
+		cool_dev = ERR_PTR(-ENOMEM);
+		goto free_cdev;
+	}
+
 	/* max_level is an index, not a counter */
 	cpufreq_dev->max_level--;
 
@@ -366,7 +390,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	cpufreq_dev->id = idr_alloc(&cpufreq_idr, NULL, 0, 0, GFP_KERNEL);
 	if (unlikely(cpufreq_dev->id < 0)) {
 		cool_dev = ERR_PTR(cpufreq_dev->id);
-		goto free_cdev;
+		goto free_table;
 	}
 
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
@@ -377,6 +401,18 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (IS_ERR(cool_dev))
 		goto remove_idr;
 
+	/* Fill freq-table in descending order of frequencies */
+	for (i = 0, freq = -1; i <= cpufreq_dev->max_level; i++) {
+		freq = find_next_max(table, freq);
+		cpufreq_dev->freq_table[i] = freq;
+
+		/* Warn for duplicate entries */
+		if (!freq)
+			pr_warn("%s: table has duplicate entries\n", __func__);
+		else
+			pr_debug("%s: freq:%u KHz\n", __func__, freq);
+	}
+
 	cpufreq_dev->cool_dev = cool_dev;
 	INIT_LIST_HEAD(&cpufreq_dev->head);
 
@@ -394,6 +430,8 @@ __cpufreq_cooling_register(struct device_node *np,
 
 remove_idr:
 	idr_remove(&cpufreq_idr, cpufreq_dev->id);
+free_table:
+	kfree(cpufreq_dev->freq_table);
 free_cdev:
 	kfree(cpufreq_dev);
 
@@ -467,6 +505,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
 	idr_remove(&cpufreq_idr, cpufreq_dev->id);
+	kfree(cpufreq_dev->freq_table);
 	kfree(cpufreq_dev);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
-- 
2.0.3.693.g996b0fd


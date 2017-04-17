From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 08/17] cpufreq: create cpufreq_table_count_valid_entries()
Date: Mon, 17 Apr 2017 11:31:53 +0530
Message-ID: <359e9dc250c2b24a8aad0551e939d5ed8a779c22.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33499 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932865AbdDQGDK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 02:03:10 -0400
Received: by mail-pf0-f171.google.com with SMTP id s16so61540158pfs.0
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2017 23:03:10 -0700 (PDT)
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

We need such a routine at two places already, lets create one.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 13 ++++---------
 drivers/thermal/cpu_cooling.c   | 22 +++++++++-------------
 include/linux/cpufreq.h         | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index f570ead62454..9c3d319dc129 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -170,11 +170,10 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	unsigned int i = 0, count = 0, ret = -ENOMEM;
 	struct cpufreq_stats *stats;
 	unsigned int alloc_size;
-	struct cpufreq_frequency_table *pos, *table;
+	struct cpufreq_frequency_table *pos;
 
-	/* We need cpufreq table for creating stats table */
-	table = policy->freq_table;
-	if (unlikely(!table))
+	count = cpufreq_table_count_valid_entries(policy);
+	if (!count)
 		return;
 
 	/* stats already initialized */
@@ -185,10 +184,6 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	if (!stats)
 		return;
 
-	/* Find total allocation size */
-	cpufreq_for_each_valid_entry(pos, table)
-		count++;
-
 	alloc_size = count * sizeof(int) + count * sizeof(u64);
 
 	alloc_size += count * count * sizeof(int);
@@ -205,7 +200,7 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	stats->max_state = count;
 
 	/* Find valid-unique entries */
-	cpufreq_for_each_valid_entry(pos, table)
+	cpufreq_for_each_valid_entry(pos, policy->freq_table)
 		if (freq_table_get_index(stats, pos->frequency) == -1)
 			stats->freq_table[i++] = pos->frequency;
 
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 23b0d3cf853a..48fc5447bbf6 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -739,15 +739,15 @@ __cpufreq_cooling_register(struct device_node *np,
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
 	char dev_name[THERMAL_NAME_LENGTH];
-	struct cpufreq_frequency_table *pos, *table;
 	unsigned int freq, i, num_cpus;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
 	bool first;
 
-	table = policy->freq_table;
-	if (!table) {
-		pr_debug("%s: CPUFreq table not found\n", __func__);
+	i = cpufreq_table_count_valid_entries(policy);
+	if (!i) {
+		pr_debug("%s: CPUFreq table not found or has no valid entries\n",
+			 __func__);
 		return ERR_PTR(-ENODEV);
 	}
 
@@ -772,20 +772,16 @@ __cpufreq_cooling_register(struct device_node *np,
 		goto free_time_in_idle;
 	}
 
-	/* Find max levels */
-	cpufreq_for_each_valid_entry(pos, table)
-		cpufreq_cdev->max_level++;
+	/* max_level is an index, not a counter */
+	cpufreq_cdev->max_level = i - 1;
 
-	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev->freq_table) *
-					  cpufreq_cdev->max_level, GFP_KERNEL);
+	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev->freq_table) * i,
+					  GFP_KERNEL);
 	if (!cpufreq_cdev->freq_table) {
 		cdev = ERR_PTR(-ENOMEM);
 		goto free_time_in_idle_timestamp;
 	}
 
-	/* max_level is an index, not a counter */
-	cpufreq_cdev->max_level--;
-
 	cpumask_copy(&cpufreq_cdev->allowed_cpus, policy->related_cpus);
 
 	if (capacitance) {
@@ -811,7 +807,7 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	/* Fill freq-table in descending order of frequencies */
 	for (i = 0, freq = -1; i <= cpufreq_cdev->max_level; i++) {
-		freq = find_next_max(table, freq);
+		freq = find_next_max(policy->freq_table, freq);
 		cpufreq_cdev->freq_table[i] = freq;
 
 		/* Warn for duplicate entries */
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 87165f06a307..affc13568af6 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -855,6 +855,20 @@ static inline int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
 		return -EINVAL;
 	}
 }
+
+static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *pos;
+	int count = 0;
+
+	if (unlikely(!policy->freq_table))
+		return 0;
+
+	cpufreq_for_each_valid_entry(pos, policy->freq_table)
+		count++;
+
+	return count;
+}
 #else
 static inline int cpufreq_boost_trigger_state(int state)
 {
-- 
2.12.0.432.g71c3a4f4ba37

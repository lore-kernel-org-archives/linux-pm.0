From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/13] cpufreq: stats: create sysfs group once we are ready
Date: Thu, 18 Dec 2014 17:30:26 +0530
Message-ID: <6a60b60e1ca803c34ee32bd63349bbc5a799feaf.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:65034 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaLRMBh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:37 -0500
Received: by mail-pa0-f54.google.com with SMTP id fb1so1291268pad.13
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:37 -0800 (PST)
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Userspace is free to read value of any file from cpufreq/stats directory once
they are created. __cpufreq_stats_create_table() is creating the sysfs files
first and then allocating resources for them. Though it would be quite difficult
to trigger the racy situation here, but for the sake of keeping sensible code
lets create sysfs entries only after we are ready to go.

This also does some makeup to the routine to make it look better.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 44 +++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index f458fdbc5bfd..dd55d57655ce 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -171,12 +171,13 @@ static void cpufreq_stats_free_table(unsigned int cpu)
 
 static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 {
-	unsigned int i, count = 0, ret = 0;
+	unsigned int i = 0, count = 0, ret = -ENOMEM;
 	struct cpufreq_stats *stat;
 	unsigned int alloc_size;
 	unsigned int cpu = policy->cpu;
 	struct cpufreq_frequency_table *pos, *table;
 
+	/* We need cpufreq table for creating stats table */
 	table = cpufreq_frequency_get_table(cpu);
 	if (unlikely(!table))
 		return 0;
@@ -186,15 +187,10 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 		return -EEXIST;
 
 	stat = kzalloc(sizeof(*stat), GFP_KERNEL);
-	if ((stat) == NULL)
+	if (!stat)
 		return -ENOMEM;
 
-	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
-	if (ret)
-		goto error_out;
-
-	policy->stats_data = stat;
-
+	/* Find total allocation size */
 	cpufreq_for_each_valid_entry(pos, table)
 		count++;
 
@@ -203,32 +199,42 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	alloc_size += count * count * sizeof(int);
 #endif
-	stat->max_state = count;
+
+	/* Allocate memory for time_in_state/freq_table/trans_table in one go */
 	stat->time_in_state = kzalloc(alloc_size, GFP_KERNEL);
-	if (!stat->time_in_state) {
-		ret = -ENOMEM;
-		goto error_alloc;
-	}
+	if (!stat->time_in_state)
+		goto free_stat;
+
 	stat->freq_table = (unsigned int *)(stat->time_in_state + count);
 
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	stat->trans_table = stat->freq_table + count;
 #endif
-	i = 0;
+
+	stat->max_state = count;
+
+	/* Find valid-unique entries */
 	cpufreq_for_each_valid_entry(pos, table)
 		if (freq_table_get_index(stat, pos->frequency) == -1)
 			stat->freq_table[i++] = pos->frequency;
 	stat->state_num = i;
+
 	spin_lock(&cpufreq_stats_lock);
 	stat->last_time = get_jiffies_64();
 	stat->last_index = freq_table_get_index(stat, policy->cur);
 	spin_unlock(&cpufreq_stats_lock);
-	return 0;
-error_alloc:
-	sysfs_remove_group(&policy->kobj, &stats_attr_group);
-error_out:
-	kfree(stat);
+
+	policy->stats_data = stat;
+	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
+	if (!ret)
+		return 0;
+
+	/* We failed, release resources */
 	policy->stats_data = NULL;
+	kfree(stat->time_in_state);
+free_stat:
+	kfree(stat);
+
 	return ret;
 }
 
-- 
2.2.0


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 12/16] cpufreq: stats: create sysfs group once we are ready
Date: Tue,  6 Jan 2015 21:09:11 +0530
Message-ID: <ba8516f9ffacf0d2c00cbdfbca5b7b363404534d.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:38117 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbbAFPkO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:40:14 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so31217261pad.31
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:40:13 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Userspace is free to read value of any file from cpufreq/stats directory once
they are created. __cpufreq_stats_create_table() is creating the sysfs files
first and then allocating resources for them. Though it would be quite difficult
to trigger the racy situation here, but for the sake of keeping sensible code
lets create sysfs entries only after we are ready to go.

This also does some makeup to the routine to make it look better.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 44 +++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 1ed703a3e21e..17df8c507594 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -164,12 +164,13 @@ static void cpufreq_stats_free_table(unsigned int cpu)
 
 static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 {
-	unsigned int i, count = 0, ret = 0;
+	unsigned int i = 0, count = 0, ret = -ENOMEM;
 	struct cpufreq_stats *stats;
 	unsigned int alloc_size;
 	unsigned int cpu = policy->cpu;
 	struct cpufreq_frequency_table *pos, *table;
 
+	/* We need cpufreq table for creating stats table */
 	table = cpufreq_frequency_get_table(cpu);
 	if (unlikely(!table))
 		return 0;
@@ -179,15 +180,10 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 		return -EEXIST;
 
 	stats = kzalloc(sizeof(*stats), GFP_KERNEL);
-	if ((stats) == NULL)
+	if (!stats)
 		return -ENOMEM;
 
-	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
-	if (ret)
-		goto error_out;
-
-	policy->stats = stats;
-
+	/* Find total allocation size */
 	cpufreq_for_each_valid_entry(pos, table)
 		count++;
 
@@ -196,32 +192,42 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	alloc_size += count * count * sizeof(int);
 #endif
-	stats->max_state = count;
+
+	/* Allocate memory for time_in_state/freq_table/trans_table in one go */
 	stats->time_in_state = kzalloc(alloc_size, GFP_KERNEL);
-	if (!stats->time_in_state) {
-		ret = -ENOMEM;
-		goto error_alloc;
-	}
+	if (!stats->time_in_state)
+		goto free_stat;
+
 	stats->freq_table = (unsigned int *)(stats->time_in_state + count);
 
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	stats->trans_table = stats->freq_table + count;
 #endif
-	i = 0;
+
+	stats->max_state = count;
+
+	/* Find valid-unique entries */
 	cpufreq_for_each_valid_entry(pos, table)
 		if (freq_table_get_index(stats, pos->frequency) == -1)
 			stats->freq_table[i++] = pos->frequency;
 	stats->state_num = i;
+
 	spin_lock(&cpufreq_stats_lock);
 	stats->last_time = get_jiffies_64();
 	stats->last_index = freq_table_get_index(stats, policy->cur);
 	spin_unlock(&cpufreq_stats_lock);
-	return 0;
-error_alloc:
-	sysfs_remove_group(&policy->kobj, &stats_attr_group);
-error_out:
-	kfree(stats);
+
+	policy->stats = stats;
+	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
+	if (!ret)
+		return 0;
+
+	/* We failed, release resources */
 	policy->stats = NULL;
+	kfree(stats->time_in_state);
+free_stat:
+	kfree(stats);
+
 	return ret;
 }
 
-- 
2.2.0


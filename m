From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 08/16] cpufreq: stats: rename 'struct cpufreq_stats' objects as 'stats'
Date: Tue,  6 Jan 2015 21:09:07 +0530
Message-ID: <a2ecca72e70859240038cd3957e15e28019b61c9.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:39856 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbbAFPj6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:39:58 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so30762424pab.26
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:39:58 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Currently we name objects of 'struct cpufreq_stats' as 'stat' and 'stats'. Use
'stats' to make it consistent.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 102 ++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index d6f5053d8ffb..ca3d5b71e828 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -31,15 +31,15 @@ struct cpufreq_stats {
 #endif
 };
 
-static int cpufreq_stats_update(struct cpufreq_stats *stat)
+static int cpufreq_stats_update(struct cpufreq_stats *stats)
 {
 	unsigned long long cur_time = get_jiffies_64();
 
 	spin_lock(&cpufreq_stats_lock);
-	if (stat->time_in_state)
-		stat->time_in_state[stat->last_index] +=
-			cur_time - stat->last_time;
-	stat->last_time = cur_time;
+	if (stats->time_in_state)
+		stats->time_in_state[stats->last_index] +=
+			cur_time - stats->last_time;
+	stats->last_time = cur_time;
 	spin_unlock(&cpufreq_stats_lock);
 	return 0;
 }
@@ -51,15 +51,15 @@ static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
 
 static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 {
-	struct cpufreq_stats *stat = policy->stats;
+	struct cpufreq_stats *stats = policy->stats;
 	ssize_t len = 0;
 	int i;
 
-	cpufreq_stats_update(stat);
-	for (i = 0; i < stat->state_num; i++) {
-		len += sprintf(buf + len, "%u %llu\n", stat->freq_table[i],
+	cpufreq_stats_update(stats);
+	for (i = 0; i < stats->state_num; i++) {
+		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
 			(unsigned long long)
-			jiffies_64_to_clock_t(stat->time_in_state[i]));
+			jiffies_64_to_clock_t(stats->time_in_state[i]));
 	}
 	return len;
 }
@@ -67,36 +67,36 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 {
-	struct cpufreq_stats *stat = policy->stats;
+	struct cpufreq_stats *stats = policy->stats;
 	ssize_t len = 0;
 	int i, j;
 
-	cpufreq_stats_update(stat);
+	cpufreq_stats_update(stats);
 	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
-	for (i = 0; i < stat->state_num; i++) {
+	for (i = 0; i < stats->state_num; i++) {
 		if (len >= PAGE_SIZE)
 			break;
 		len += snprintf(buf + len, PAGE_SIZE - len, "%9u ",
-				stat->freq_table[i]);
+				stats->freq_table[i]);
 	}
 	if (len >= PAGE_SIZE)
 		return PAGE_SIZE;
 
 	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
-	for (i = 0; i < stat->state_num; i++) {
+	for (i = 0; i < stats->state_num; i++) {
 		if (len >= PAGE_SIZE)
 			break;
 
 		len += snprintf(buf + len, PAGE_SIZE - len, "%9u: ",
-				stat->freq_table[i]);
+				stats->freq_table[i]);
 
-		for (j = 0; j < stat->state_num; j++) {
+		for (j = 0; j < stats->state_num; j++) {
 			if (len >= PAGE_SIZE)
 				break;
 			len += snprintf(buf + len, PAGE_SIZE - len, "%9u ",
-					stat->trans_table[i*stat->max_state+j]);
+					stats->trans_table[i*stats->max_state+j]);
 		}
 		if (len >= PAGE_SIZE)
 			break;
@@ -125,28 +125,28 @@ static struct attribute_group stats_attr_group = {
 	.name = "stats"
 };
 
-static int freq_table_get_index(struct cpufreq_stats *stat, unsigned int freq)
+static int freq_table_get_index(struct cpufreq_stats *stats, unsigned int freq)
 {
 	int index;
-	for (index = 0; index < stat->max_state; index++)
-		if (stat->freq_table[index] == freq)
+	for (index = 0; index < stats->max_state; index++)
+		if (stats->freq_table[index] == freq)
 			return index;
 	return -1;
 }
 
 static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
 {
-	struct cpufreq_stats *stat = policy->stats;
+	struct cpufreq_stats *stats = policy->stats;
 
 	/* Already freed */
-	if (!stat)
+	if (!stats)
 		return;
 
-	pr_debug("%s: Free stat table\n", __func__);
+	pr_debug("%s: Free stats table\n", __func__);
 
 	sysfs_remove_group(&policy->kobj, &stats_attr_group);
-	kfree(stat->time_in_state);
-	kfree(stat);
+	kfree(stats->time_in_state);
+	kfree(stats);
 	policy->stats = NULL;
 }
 
@@ -166,7 +166,7 @@ static void cpufreq_stats_free_table(unsigned int cpu)
 static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 {
 	unsigned int i, count = 0, ret = 0;
-	struct cpufreq_stats *stat;
+	struct cpufreq_stats *stats;
 	unsigned int alloc_size;
 	unsigned int cpu = policy->cpu;
 	struct cpufreq_frequency_table *pos, *table;
@@ -179,16 +179,16 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	if (policy->stats)
 		return -EEXIST;
 
-	stat = kzalloc(sizeof(*stat), GFP_KERNEL);
-	if ((stat) == NULL)
+	stats = kzalloc(sizeof(*stats), GFP_KERNEL);
+	if ((stats) == NULL)
 		return -ENOMEM;
 
 	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
 	if (ret)
 		goto error_out;
 
-	stat->cpu = cpu;
-	policy->stats = stat;
+	stats->cpu = cpu;
+	policy->stats = stats;
 
 	cpufreq_for_each_valid_entry(pos, table)
 		count++;
@@ -198,31 +198,31 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	alloc_size += count * count * sizeof(int);
 #endif
-	stat->max_state = count;
-	stat->time_in_state = kzalloc(alloc_size, GFP_KERNEL);
-	if (!stat->time_in_state) {
+	stats->max_state = count;
+	stats->time_in_state = kzalloc(alloc_size, GFP_KERNEL);
+	if (!stats->time_in_state) {
 		ret = -ENOMEM;
 		goto error_alloc;
 	}
-	stat->freq_table = (unsigned int *)(stat->time_in_state + count);
+	stats->freq_table = (unsigned int *)(stats->time_in_state + count);
 
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
-	stat->trans_table = stat->freq_table + count;
+	stats->trans_table = stats->freq_table + count;
 #endif
 	i = 0;
 	cpufreq_for_each_valid_entry(pos, table)
-		if (freq_table_get_index(stat, pos->frequency) == -1)
-			stat->freq_table[i++] = pos->frequency;
-	stat->state_num = i;
+		if (freq_table_get_index(stats, pos->frequency) == -1)
+			stats->freq_table[i++] = pos->frequency;
+	stats->state_num = i;
 	spin_lock(&cpufreq_stats_lock);
-	stat->last_time = get_jiffies_64();
-	stat->last_index = freq_table_get_index(stat, policy->cur);
+	stats->last_time = get_jiffies_64();
+	stats->last_index = freq_table_get_index(stats, policy->cur);
 	spin_unlock(&cpufreq_stats_lock);
 	return 0;
 error_alloc:
 	sysfs_remove_group(&policy->kobj, &stats_attr_group);
 error_out:
-	kfree(stat);
+	kfree(stats);
 	policy->stats = NULL;
 	return ret;
 }
@@ -273,7 +273,7 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 {
 	struct cpufreq_freqs *freq = data;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(freq->cpu);
-	struct cpufreq_stats *stat;
+	struct cpufreq_stats *stats;
 	int old_index, new_index;
 
 	if (val != CPUFREQ_POSTCHANGE)
@@ -289,26 +289,26 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 		goto put_policy;
 	}
 
-	stat = policy->stats;
+	stats = policy->stats;
 
-	old_index = stat->last_index;
-	new_index = freq_table_get_index(stat, freq->new);
+	old_index = stats->last_index;
+	new_index = freq_table_get_index(stats, freq->new);
 
-	/* We can't do stat->time_in_state[-1]= .. */
+	/* We can't do stats->time_in_state[-1]= .. */
 	if (old_index == -1 || new_index == -1)
 		return 0;
 
-	cpufreq_stats_update(stat);
+	cpufreq_stats_update(stats);
 
 	if (old_index == new_index)
 		return 0;
 
 	spin_lock(&cpufreq_stats_lock);
-	stat->last_index = new_index;
+	stats->last_index = new_index;
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
-	stat->trans_table[old_index * stat->max_state + new_index]++;
+	stats->trans_table[old_index * stats->max_state + new_index]++;
 #endif
-	stat->total_trans++;
+	stats->total_trans++;
 	spin_unlock(&cpufreq_stats_lock);
 
 put_policy:
-- 
2.2.0


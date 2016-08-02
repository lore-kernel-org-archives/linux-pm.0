From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH] cpufreq: cpufreq_stats in the absence of frequency table
Date: Tue,  2 Aug 2016 17:18:57 -0600
Message-ID: <1470179937-14698-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56647 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755060AbcHBXbD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2016 19:31:03 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org, Prashanth Prakash <pprakash@codeaurora.org>

cpufreq drivers such as CPPC works on contigious scale and does
not have a static frequency table. This commit adds cpufreq_stats
support for such drivers by creating a pseudo frequency table by
discretizing the contigious scale.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/cpufreq/cpufreq_stats.c | 63 ++++++++++++++++++++++++++++++++---------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 06d3abd..4eb9c41 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -14,6 +14,9 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/cputime.h>
+#include <linux/types.h>
+
+#define CPUFREQ_PSEUDO_FREQ_TABLE_COUNT (16)
 
 static DEFINE_SPINLOCK(cpufreq_stats_lock);
 
@@ -25,6 +28,7 @@ struct cpufreq_stats {
 	unsigned int last_index;
 	u64 *time_in_state;
 	unsigned int *freq_table;
+	bool pseudo_freq_table;
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	unsigned int *trans_table;
 #endif
@@ -130,9 +134,17 @@ static struct attribute_group stats_attr_group = {
 static int freq_table_get_index(struct cpufreq_stats *stats, unsigned int freq)
 {
 	int index;
-	for (index = 0; index < stats->max_state; index++)
-		if (stats->freq_table[index] == freq)
-			return index;
+
+	if (stats->pseudo_freq_table) {
+		for (index = 0; index < stats->max_state; index++)
+			if (stats->freq_table[index] >= freq)
+				return index;
+	} else {
+		for (index = 0; index < stats->max_state; index++)
+			if (stats->freq_table[index] == freq)
+				return index;
+	}
+
 	return -1;
 }
 
@@ -154,14 +166,14 @@ void cpufreq_stats_free_table(struct cpufreq_policy *policy)
 
 void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 {
-	unsigned int i = 0, count = 0, ret = -ENOMEM;
+	unsigned int i = 0, count = 0, ret = -ENOMEM, step_size;
 	struct cpufreq_stats *stats;
 	unsigned int alloc_size;
 	struct cpufreq_frequency_table *pos, *table;
 
-	/* We need cpufreq table for creating stats table */
+	/* We need cpufreq table or min < max for creating stats table */
 	table = policy->freq_table;
-	if (unlikely(!table))
+	if (!table && !(policy->min < policy->max))
 		return;
 
 	/* stats already initialized */
@@ -173,8 +185,20 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 		return;
 
 	/* Find total allocation size */
-	cpufreq_for_each_valid_entry(pos, table)
-		count++;
+	if (table) {
+		cpufreq_for_each_valid_entry(pos, table)
+			count++;
+	} else {
+		stats->pseudo_freq_table = true;
+		count = CPUFREQ_PSEUDO_FREQ_TABLE_COUNT;
+		step_size = (policy->max - policy->min + 1) / count;
+
+		/* count is larger than min-max range */
+		if (!step_size) {
+			count = policy->max - policy->min + 1;
+			step_size = 1;
+		}
+	}
 
 	alloc_size = count * sizeof(int) + count * sizeof(u64);
 
@@ -195,10 +219,17 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 
 	stats->max_state = count;
 
-	/* Find valid-unique entries */
-	cpufreq_for_each_valid_entry(pos, table)
-		if (freq_table_get_index(stats, pos->frequency) == -1)
-			stats->freq_table[i++] = pos->frequency;
+	if (table) {
+		/* Find valid-unique entries */
+		cpufreq_for_each_valid_entry(pos, table)
+			if (freq_table_get_index(stats, pos->frequency) == -1)
+				stats->freq_table[i++] = pos->frequency;
+	} else {
+		/* Create a pseudo frequency table */
+		for (i = 0 ; i < count ; i++)
+			stats->freq_table[i] = policy->min + i * step_size;
+		stats->freq_table[count-1] = policy->max;
+	}
 
 	stats->state_num = i;
 	stats->last_time = get_jiffies_64();
@@ -231,9 +262,15 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
 	new_index = freq_table_get_index(stats, new_freq);
 
 	/* We can't do stats->time_in_state[-1]= .. */
-	if (old_index == -1 || new_index == -1 || old_index == new_index)
+	if (old_index == -1 || new_index == -1)
 		return;
 
+	if (old_index == new_index) {
+		if (stats->pseudo_freq_table)
+			stats->total_trans++;
+		return;
+	}
+
 	cpufreq_stats_update(stats);
 
 	stats->last_index = new_index;
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.


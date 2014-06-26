From: Thomas Abraham <thomas.ab@samsung.com>
Subject: [PATCH] cpufreq: arm_big_little: set lowest frequcency for cluster when no cpus in it
Date: Thu, 26 Jun 2014 20:38:33 +0530
Message-ID: <1403795313-6903-1-git-send-email-thomas.ab@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:40648 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbaFZPIt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Jun 2014 11:08:49 -0400
Received: by mail-pb0-f54.google.com with SMTP id un15so3261429pbc.41
        for <linux-pm@vger.kernel.org>; Thu, 26 Jun 2014 08:08:49 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: viresh.kumar@linaro.org, sudeep.karkadanagesha@arm.com, thomas.ab@samsung.com

From: Thomas Abraham <thomas.ab@samsung.com>

If there are no active cpus in a cluster, the clock frequency of the cluster
can be lowered to the lowest possible frequency for that cluster. This can
help reduce the output clock speed of the PLL clocking the cluster and
save power.

The get_table_min() function is also moved with this change to avoid forward
declaration. The function get_table_max() is also moved along with
get_table_min() so that these two functions are adjacent the code.

Signed-off-by: Thomas Abraham <thomas.ab@samsung.com>
---
 drivers/cpufreq/arm_big_little.c |   51 +++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 1f4d4e3..4b1431f 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -75,6 +75,28 @@ static inline int cpu_to_cluster(int cpu)
 		MAX_CLUSTERS : raw_cpu_to_cluster(cpu);
 }
 
+/* get the minimum frequency in the cpufreq_frequency_table */
+static inline u32 get_table_min(struct cpufreq_frequency_table *table)
+{
+	struct cpufreq_frequency_table *pos;
+	uint32_t min_freq = ~0;
+	cpufreq_for_each_entry(pos, table)
+		if (pos->frequency < min_freq)
+			min_freq = pos->frequency;
+	return min_freq;
+}
+
+/* get the maximum frequency in the cpufreq_frequency_table */
+static inline u32 get_table_max(struct cpufreq_frequency_table *table)
+{
+	struct cpufreq_frequency_table *pos;
+	uint32_t max_freq = 0;
+	cpufreq_for_each_entry(pos, table)
+		if (pos->frequency > max_freq)
+			max_freq = pos->frequency;
+	return max_freq;
+}
+
 static unsigned int find_cluster_maxfreq(int cluster)
 {
 	int j;
@@ -170,9 +192,14 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
 
 		mutex_lock(&cluster_lock[old_cluster]);
 
-		/* Set freq of old cluster if there are cpus left on it */
+		/*
+		 * Set freq of old cluster. If there are no cpus left on it,
+		 * set the lowest possible frequency for that cluster.
+		 */
 		new_rate = find_cluster_maxfreq(old_cluster);
 		new_rate = ACTUAL_FREQ(old_cluster, new_rate);
+		if (!new_rate)
+			new_rate = get_table_min(freq_table[old_cluster]);
 
 		if (new_rate) {
 			pr_debug("%s: Updating rate of old cluster: %d, to freq: %d\n",
@@ -223,28 +250,6 @@ static inline u32 get_table_count(struct cpufreq_frequency_table *table)
 	return count;
 }
 
-/* get the minimum frequency in the cpufreq_frequency_table */
-static inline u32 get_table_min(struct cpufreq_frequency_table *table)
-{
-	struct cpufreq_frequency_table *pos;
-	uint32_t min_freq = ~0;
-	cpufreq_for_each_entry(pos, table)
-		if (pos->frequency < min_freq)
-			min_freq = pos->frequency;
-	return min_freq;
-}
-
-/* get the maximum frequency in the cpufreq_frequency_table */
-static inline u32 get_table_max(struct cpufreq_frequency_table *table)
-{
-	struct cpufreq_frequency_table *pos;
-	uint32_t max_freq = 0;
-	cpufreq_for_each_entry(pos, table)
-		if (pos->frequency > max_freq)
-			max_freq = pos->frequency;
-	return max_freq;
-}
-
 static int merge_cluster_tables(void)
 {
 	int i, j, k = 0, count = 1;
-- 
1.7.9.5


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 Resend 07/16] cpufreq: stats: get rid of per-cpu cpufreq_stats_table
Date: Tue, 13 Jan 2015 11:34:00 +0530
Message-ID: <6a075d926f65e72bf9c099e50deca54899ea91c7.1421128708.git.viresh.kumar@linaro.org>
References: <fc91ff3fcc9db30f784bbc691a062982af8e0fe0.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:39705 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbAMGEU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Jan 2015 01:04:20 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so1655416pab.4
        for <linux-pm@vger.kernel.org>; Mon, 12 Jan 2015 22:04:19 -0800 (PST)
In-Reply-To: <fc91ff3fcc9db30f784bbc691a062982af8e0fe0.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

All CPUs sharing a cpufreq policy share stats too. For this reason, add a stats
pointer to struct cpufreq_policy and drop per-CPU variable cpufreq_stats_table
used for accessing cpufreq stats so as to reduce code complexity.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Resending only a single patch as found a issue with it while testing with my
newly written cpufreq-test suite. The problem was that we haven't done
cpufreq_cpu_put() for few failure cases and that restricts the cpufreq driver
module to unload.

Here is the diff to V3:

@@ -265,14 +265,14 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
        struct cpufreq_stats *stats;
        int old_index, new_index;
 
-       if (val != CPUFREQ_POSTCHANGE)
-               return 0;
-
        if (!policy) {
                pr_err("%s: No policy found\n", __func__);
                return 0;
        }
 
+       if (val != CPUFREQ_POSTCHANGE)
+               goto put_policy;
+
        if (!policy->stats) {
                pr_debug("%s: No stats found\n", __func__);
                goto put_policy;
@@ -285,10 +285,10 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 
        /* We can't do stats->time_in_state[-1]= .. */
        if (old_index == -1 || new_index == -1)
-               return 0;
+               goto put_policy;
 
        if (old_index == new_index)
-               return 0;
+               goto put_policy;
 
        cpufreq_stats_update(stats);

 drivers/cpufreq/cpufreq_stats.c | 62 +++++++++++++++++++----------------------
 include/linux/cpufreq.h         |  3 ++
 2 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 6c234f548601..3792b2e2f4a8 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -31,8 +31,6 @@ struct cpufreq_stats {
 #endif
 };
 
-static DEFINE_PER_CPU(struct cpufreq_stats *, cpufreq_stats_table);
-
 static int cpufreq_stats_update(struct cpufreq_stats *stat)
 {
 	unsigned long long cur_time = get_jiffies_64();
@@ -48,20 +46,15 @@ static int cpufreq_stats_update(struct cpufreq_stats *stat)
 
 static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
 {
-	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
-	if (!stat)
-		return 0;
-	return sprintf(buf, "%d\n",
-			per_cpu(cpufreq_stats_table, stat->cpu)->total_trans);
+	return sprintf(buf, "%d\n", policy->stats->total_trans);
 }
 
 static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 {
+	struct cpufreq_stats *stat = policy->stats;
 	ssize_t len = 0;
 	int i;
-	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
-	if (!stat)
-		return 0;
+
 	cpufreq_stats_update(stat);
 	for (i = 0; i < stat->state_num; i++) {
 		len += sprintf(buf + len, "%u %llu\n", stat->freq_table[i],
@@ -74,12 +67,10 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 {
+	struct cpufreq_stats *stat = policy->stats;
 	ssize_t len = 0;
 	int i, j;
 
-	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
-	if (!stat)
-		return 0;
 	cpufreq_stats_update(stat);
 	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
@@ -145,8 +136,9 @@ static int freq_table_get_index(struct cpufreq_stats *stat, unsigned int freq)
 
 static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
 {
-	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
+	struct cpufreq_stats *stat = policy->stats;
 
+	/* Already freed */
 	if (!stat)
 		return;
 
@@ -155,7 +147,7 @@ static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
 	sysfs_remove_group(&policy->kobj, &stats_attr_group);
 	kfree(stat->time_in_state);
 	kfree(stat);
-	per_cpu(cpufreq_stats_table, policy->cpu) = NULL;
+	policy->stats = NULL;
 }
 
 static void cpufreq_stats_free_table(unsigned int cpu)
@@ -184,7 +176,7 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 		return 0;
 
 	/* stats already initialized */
-	if (per_cpu(cpufreq_stats_table, cpu))
+	if (policy->stats)
 		return -EEXIST;
 
 	stat = kzalloc(sizeof(*stat), GFP_KERNEL);
@@ -196,7 +188,7 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 		goto error_out;
 
 	stat->cpu = cpu;
-	per_cpu(cpufreq_stats_table, cpu) = stat;
+	policy->stats = stat;
 
 	cpufreq_for_each_valid_entry(pos, table)
 		count++;
@@ -231,7 +223,7 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	sysfs_remove_group(&policy->kobj, &stats_attr_group);
 error_out:
 	kfree(stat);
-	per_cpu(cpufreq_stats_table, cpu) = NULL;
+	policy->stats = NULL;
 	return ret;
 }
 
@@ -254,15 +246,7 @@ static void cpufreq_stats_create_table(unsigned int cpu)
 
 static void cpufreq_stats_update_policy_cpu(struct cpufreq_policy *policy)
 {
-	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table,
-			policy->last_cpu);
-
-	pr_debug("Updating stats_table for new_cpu %u from last_cpu %u\n",
-			policy->cpu, policy->last_cpu);
-	per_cpu(cpufreq_stats_table, policy->cpu) = per_cpu(cpufreq_stats_table,
-			policy->last_cpu);
-	per_cpu(cpufreq_stats_table, policy->last_cpu) = NULL;
-	stat->cpu = policy->cpu;
+	policy->stats->cpu = policy->cpu;
 }
 
 static int cpufreq_stat_notifier_policy(struct notifier_block *nb,
@@ -288,27 +272,36 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 		unsigned long val, void *data)
 {
 	struct cpufreq_freqs *freq = data;
+	struct cpufreq_policy *policy = cpufreq_cpu_get(freq->cpu);
 	struct cpufreq_stats *stat;
 	int old_index, new_index;
 
-	if (val != CPUFREQ_POSTCHANGE)
+	if (!policy) {
+		pr_err("%s: No policy found\n", __func__);
 		return 0;
+	}
 
-	stat = per_cpu(cpufreq_stats_table, freq->cpu);
-	if (!stat)
-		return 0;
+	if (val != CPUFREQ_POSTCHANGE)
+		goto put_policy;
+
+	if (!policy->stats) {
+		pr_debug("%s: No stats found\n", __func__);
+		goto put_policy;
+	}
+
+	stat = policy->stats;
 
 	old_index = stat->last_index;
 	new_index = freq_table_get_index(stat, freq->new);
 
 	/* We can't do stat->time_in_state[-1]= .. */
 	if (old_index == -1 || new_index == -1)
-		return 0;
+		goto put_policy;
 
 	cpufreq_stats_update(stat);
 
 	if (old_index == new_index)
-		return 0;
+		goto put_policy;
 
 	spin_lock(&cpufreq_stats_lock);
 	stat->last_index = new_index;
@@ -317,6 +310,9 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 #endif
 	stat->total_trans++;
 	spin_unlock(&cpufreq_stats_lock);
+
+put_policy:
+	cpufreq_cpu_put(policy);
 	return 0;
 }
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 4d078cebafd2..60b7b496565d 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -113,6 +113,9 @@ struct cpufreq_policy {
 	wait_queue_head_t	transition_wait;
 	struct task_struct	*transition_task; /* Task which is doing the transition */
 
+	/* cpufreq-stats */
+	struct cpufreq_stats	*stats;
+
 	/* For cpufreq driver's internal use */
 	void			*driver_data;
 };
-- 
2.2.0


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 12/14] cpufreq: stats: replace spinlock with mutex
Date: Fri,  2 Jan 2015 11:16:49 +0530
Message-ID: <7b128a0d00c54b6354ab217e905fbee0e3436e84.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:51941 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbABFrs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 00:47:48 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so22864778pdb.8
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 21:47:47 -0800 (PST)
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Later commit will allocate memory from within the spinlock as that would be part
of critical region. kzalloc() might sleep and we can't sleep from inside
spinlocks critical region, so convert the spinlock into a mutex.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 7701532b32c8..de55ca86b6f1 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -12,10 +12,11 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/cputime.h>
 
-static spinlock_t cpufreq_stats_lock;
+static DEFINE_MUTEX(cpufreq_stats_lock);
 
 struct cpufreq_stats {
 	unsigned int total_trans;
@@ -39,12 +40,12 @@ static int cpufreq_stats_update(struct cpufreq_stats *stat)
 {
 	unsigned long long cur_time = get_jiffies_64();
 
-	spin_lock(&cpufreq_stats_lock);
+	mutex_lock(&cpufreq_stats_lock);
 	if (stat->time_in_state)
 		stat->time_in_state[stat->last_index] +=
 			cur_time - stat->last_time;
 	stat->last_time = cur_time;
-	spin_unlock(&cpufreq_stats_lock);
+	mutex_unlock(&cpufreq_stats_lock);
 	return 0;
 }
 
@@ -218,10 +219,10 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 			stat->freq_table[i++] = pos->frequency;
 	stat->state_num = i;
 
-	spin_lock(&cpufreq_stats_lock);
+	mutex_lock(&cpufreq_stats_lock);
 	stat->last_time = get_jiffies_64();
 	stat->last_index = freq_table_get_index(stat, policy->cur);
-	spin_unlock(&cpufreq_stats_lock);
+	mutex_unlock(&cpufreq_stats_lock);
 
 	policy->stats_data = stat;
 	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
@@ -298,13 +299,13 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 
 	cpufreq_stats_update(stat);
 
-	spin_lock(&cpufreq_stats_lock);
+	mutex_lock(&cpufreq_stats_lock);
 	stat->last_index = new_index;
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	stat->trans_table[old_index * stat->max_state + new_index]++;
 #endif
 	stat->total_trans++;
-	spin_unlock(&cpufreq_stats_lock);
+	mutex_unlock(&cpufreq_stats_lock);
 	cpufreq_cpu_put(policy);
 	return 0;
 }
@@ -322,7 +323,6 @@ static int __init cpufreq_stats_init(void)
 	int ret;
 	unsigned int cpu;
 
-	spin_lock_init(&cpufreq_stats_lock);
 	ret = cpufreq_register_notifier(&notifier_policy_block,
 				CPUFREQ_POLICY_NOTIFIER);
 	if (ret)
-- 
2.2.0


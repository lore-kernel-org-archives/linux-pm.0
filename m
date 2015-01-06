From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 06/16] cpufreq: stats: pass 'stat' to cpufreq_stats_update()
Date: Tue,  6 Jan 2015 21:09:05 +0530
Message-ID: <181e3a27d02ce74569478191e6fa84aea73caf6c.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:62941 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbbAFPju (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:39:50 -0500
Received: by mail-pd0-f173.google.com with SMTP id ft15so30626216pdb.32
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:39:50 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

It is better to pass a struct cpufreq_stats pointer to cpufreq_stats_update()
instead of a CPU number, because that's all it needs.

Even if we pass a cpu number to cpufreq_stats_update(), it reads the per-cpu
variable to get 'stats' out of it. So we are doing these operations
unnecessarily:
- First getting the cpu number to pass to cpufreq_stats_update(), stat->cpu.
- And then getting stats from the cpu, per_cpu(cpufreq_stats_table, cpu).

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index e9d68420b876..6c234f548601 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -33,13 +33,11 @@ struct cpufreq_stats {
 
 static DEFINE_PER_CPU(struct cpufreq_stats *, cpufreq_stats_table);
 
-static int cpufreq_stats_update(unsigned int cpu)
+static int cpufreq_stats_update(struct cpufreq_stats *stat)
 {
-	struct cpufreq_stats *stat;
 	unsigned long long cur_time = get_jiffies_64();
 
 	spin_lock(&cpufreq_stats_lock);
-	stat = per_cpu(cpufreq_stats_table, cpu);
 	if (stat->time_in_state)
 		stat->time_in_state[stat->last_index] +=
 			cur_time - stat->last_time;
@@ -64,7 +62,7 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
 	if (!stat)
 		return 0;
-	cpufreq_stats_update(stat->cpu);
+	cpufreq_stats_update(stat);
 	for (i = 0; i < stat->state_num; i++) {
 		len += sprintf(buf + len, "%u %llu\n", stat->freq_table[i],
 			(unsigned long long)
@@ -82,7 +80,7 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
 	if (!stat)
 		return 0;
-	cpufreq_stats_update(stat->cpu);
+	cpufreq_stats_update(stat);
 	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
 	for (i = 0; i < stat->state_num; i++) {
@@ -307,7 +305,7 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 	if (old_index == -1 || new_index == -1)
 		return 0;
 
-	cpufreq_stats_update(freq->cpu);
+	cpufreq_stats_update(stat);
 
 	if (old_index == new_index)
 		return 0;
-- 
2.2.0


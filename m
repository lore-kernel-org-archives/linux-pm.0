From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/13] cpufreq: stats: pass 'stat' to cpufreq_stats_update()
Date: Thu, 18 Dec 2014 17:30:21 +0530
Message-ID: <662f310dbb4aa67a258c8b9d3a4a52e1b3ff1846.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:49340 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbaLRMBS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:18 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so1284535pab.21
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:17 -0800 (PST)
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_stats_update() needs only 'stat' pointer for its use and nothing else.
Currently it works fine as we have a per-cpu variable for storing stats. But
later commits would remove it and hence we better pass 'stat' to
cpufreq_stats_update().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 62b6133f06aa..ebd9e4c5c124 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -38,14 +38,11 @@ struct cpufreq_stats_attribute {
 	ssize_t(*show) (struct cpufreq_stats *, char *);
 };
 
-static int cpufreq_stats_update(unsigned int cpu)
+static int cpufreq_stats_update(struct cpufreq_stats *stat)
 {
-	struct cpufreq_stats *stat;
-	unsigned long long cur_time;
+	unsigned long long cur_time = get_jiffies_64();
 
-	cur_time = get_jiffies_64();
 	spin_lock(&cpufreq_stats_lock);
-	stat = per_cpu(cpufreq_stats_table, cpu);
 	if (stat->time_in_state)
 		stat->time_in_state[stat->last_index] +=
 			cur_time - stat->last_time;
@@ -70,7 +67,7 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
 	if (!stat)
 		return 0;
-	cpufreq_stats_update(stat->cpu);
+	cpufreq_stats_update(stat);
 	for (i = 0; i < stat->state_num; i++) {
 		len += sprintf(buf + len, "%u %llu\n", stat->freq_table[i],
 			(unsigned long long)
@@ -88,7 +85,7 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	struct cpufreq_stats *stat = per_cpu(cpufreq_stats_table, policy->cpu);
 	if (!stat)
 		return 0;
-	cpufreq_stats_update(stat->cpu);
+	cpufreq_stats_update(stat);
 	len += snprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "         : ");
 	for (i = 0; i < stat->state_num; i++) {
@@ -313,7 +310,7 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 	if (old_index == -1 || new_index == -1)
 		return 0;
 
-	cpufreq_stats_update(freq->cpu);
+	cpufreq_stats_update(stat);
 
 	if (old_index == new_index)
 		return 0;
-- 
2.2.0


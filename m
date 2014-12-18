From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 13/13] cpufreq: stats: call cpufreq_stats_update() with locks held
Date: Thu, 18 Dec 2014 17:30:30 +0530
Message-ID: <298a359b291b5d867e1c14ba7f9f7caeb64e81c7.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:39184 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbaLRMBx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:53 -0500
Received: by mail-pd0-f178.google.com with SMTP id r10so1285047pdi.23
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:53 -0800 (PST)
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_stats_update() has only two callers, one of them is already taking locks
and other one don't.

To make locking efficient for cpufreq_stat_notifier_trans(), lets call
cpufreq_stats_update() from within locks. Also update show_time_in_state() to
call cpufreq_stats_update() after taking locks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index e18735816908..955abb54f9ec 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -39,12 +39,10 @@ static int cpufreq_stats_update(struct cpufreq_stats *stat)
 {
 	unsigned long long cur_time = get_jiffies_64();
 
-	spin_lock(&cpufreq_stats_lock);
 	if (stat->time_in_state)
 		stat->time_in_state[stat->last_index] +=
 			cur_time - stat->last_time;
 	stat->last_time = cur_time;
-	spin_unlock(&cpufreq_stats_lock);
 	return 0;
 }
 
@@ -61,7 +59,10 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i;
 
+	spin_lock(&cpufreq_stats_lock);
 	cpufreq_stats_update(stat);
+	spin_unlock(&cpufreq_stats_lock);
+
 	for (i = 0; i < stat->state_num; i++) {
 		len += sprintf(buf + len, "%u %llu\n", stat->freq_table[i],
 			(unsigned long long)
@@ -302,9 +303,9 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 	if (old_index == new_index)
 		return 0;
 
+	spin_lock(&cpufreq_stats_lock);
 	cpufreq_stats_update(stat);
 
-	spin_lock(&cpufreq_stats_lock);
 	stat->last_index = new_index;
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	stat->trans_table[old_index * stat->max_state + new_index]++;
-- 
2.2.0


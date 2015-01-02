From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 14/14] cpufreq: stats: call cpufreq_stats_update() with locks held
Date: Fri,  2 Jan 2015 11:16:51 +0530
Message-ID: <98184387b402a80ba58e9b727c4dacd95abdd8d4.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:56847 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbABFrz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 00:47:55 -0500
Received: by mail-pd0-f175.google.com with SMTP id g10so23096192pdj.6
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 21:47:55 -0800 (PST)
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_stats_update() has only two callers, one of them is already taking locks
and other one don't.

To make locking efficient for cpufreq_stat_notifier_trans(), lets call
cpufreq_stats_update() from within locks. Also update show_time_in_state() to
call cpufreq_stats_update() after taking locks.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 95867985ea02..f1b234a09f66 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -40,12 +40,10 @@ static int cpufreq_stats_update(struct cpufreq_stats *stat)
 {
 	unsigned long long cur_time = get_jiffies_64();
 
-	mutex_lock(&cpufreq_stats_lock);
 	if (stat->time_in_state)
 		stat->time_in_state[stat->last_index] +=
 			cur_time - stat->last_time;
 	stat->last_time = cur_time;
-	mutex_unlock(&cpufreq_stats_lock);
 	return 0;
 }
 
@@ -62,7 +60,10 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i;
 
+	mutex_lock(&cpufreq_stats_lock);
 	cpufreq_stats_update(stat);
+	mutex_unlock(&cpufreq_stats_lock);
+
 	for (i = 0; i < stat->state_num; i++) {
 		len += sprintf(buf + len, "%u %llu\n", stat->freq_table[i],
 			(unsigned long long)
@@ -303,9 +304,9 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 	if (old_index == new_index)
 		return 0;
 
+	mutex_lock(&cpufreq_stats_lock);
 	cpufreq_stats_update(stat);
 
-	mutex_lock(&cpufreq_stats_lock);
 	stat->last_index = new_index;
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	stat->trans_table[old_index * stat->max_state + new_index]++;
-- 
2.2.0


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 16/16] cpufreq: stats: drop unnecessary locking
Date: Tue,  6 Jan 2015 21:09:15 +0530
Message-ID: <2de6e2482211a493d61f4a77e38f60686fc5fc84.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:55360 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755479AbbAFPk3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:40:29 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so31244814pab.2
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:40:29 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

There is no possibility of any race on updating last_index, trans_table or
total_trans as these are updated only by cpufreq_stat_notifier_trans() which
will be called sequentially.

The only place where locking is still relevant is: cpufreq_stats_update(), which
updates time_in_state and last_time. This can be called by two thread in
parallel, that may result in races.

The two threads being:
- sysfs read of time_in_state
- and frequency transition that calls cpufreq_stat_notifier_trans().

Remove locking from the first case mentioned above.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 71fcc7c198a1..bce255568123 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -207,12 +207,10 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	cpufreq_for_each_valid_entry(pos, table)
 		if (freq_table_get_index(stats, pos->frequency) == -1)
 			stats->freq_table[i++] = pos->frequency;
-	stats->state_num = i;
 
-	spin_lock(&cpufreq_stats_lock);
+	stats->state_num = i;
 	stats->last_time = get_jiffies_64();
 	stats->last_index = freq_table_get_index(stats, policy->cur);
-	spin_unlock(&cpufreq_stats_lock);
 
 	policy->stats = stats;
 	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
@@ -294,13 +292,11 @@ static int cpufreq_stat_notifier_trans(struct notifier_block *nb,
 
 	cpufreq_stats_update(stats);
 
-	spin_lock(&cpufreq_stats_lock);
 	stats->last_index = new_index;
 #ifdef CONFIG_CPU_FREQ_STAT_DETAILS
 	stats->trans_table[old_index * stats->max_state + new_index]++;
 #endif
 	stats->total_trans++;
-	spin_unlock(&cpufreq_stats_lock);
 
 put_policy:
 	cpufreq_cpu_put(policy);
-- 
2.2.0


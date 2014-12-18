From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/13] cpufreq: stats: Fix locking
Date: Thu, 18 Dec 2014 17:30:29 +0530
Message-ID: <6277a557b0102524ca317bf0aa94d7b479375d6e.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48747 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbaLRMBu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:50 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so1280058pdb.8
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:49 -0800 (PST)
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1418902789.git.viresh.kumar@linaro.org>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Locking wasn't handled properly at places and this patch is an attempt to fix
it. Specially while creating/removing stat tables.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 7701532b32c8..e18735816908 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -149,10 +149,12 @@ static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
 
 	pr_debug("%s: Free stat table\n", __func__);
 
+	spin_lock(&cpufreq_stats_lock);
 	sysfs_remove_group(&policy->kobj, &stats_attr_group);
 	kfree(stat->time_in_state);
 	kfree(stat);
 	policy->stats_data = NULL;
+	spin_unlock(&cpufreq_stats_lock);
 }
 
 static void cpufreq_stats_free_table(unsigned int cpu)
@@ -181,13 +183,17 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	if (unlikely(!table))
 		return 0;
 
+	spin_lock(&cpufreq_stats_lock);
+
 	/* stats already initialized */
-	if (policy->stats_data)
-		return -EEXIST;
+	if (policy->stats_data) {
+		ret = -EEXIST;
+		goto unlock;
+	}
 
 	stat = kzalloc(sizeof(*stat), GFP_KERNEL);
 	if (!stat)
-		return -ENOMEM;
+		goto unlock;
 
 	/* Find total allocation size */
 	cpufreq_for_each_valid_entry(pos, table)
@@ -218,21 +224,21 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 			stat->freq_table[i++] = pos->frequency;
 	stat->state_num = i;
 
-	spin_lock(&cpufreq_stats_lock);
 	stat->last_time = get_jiffies_64();
 	stat->last_index = freq_table_get_index(stat, policy->cur);
-	spin_unlock(&cpufreq_stats_lock);
 
 	policy->stats_data = stat;
 	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
 	if (!ret)
-		return 0;
+		goto unlock;
 
 	/* We failed, release resources */
 	policy->stats_data = NULL;
 	kfree(stat->time_in_state);
 free_stat:
 	kfree(stat);
+unlock:
+	spin_unlock(&cpufreq_stats_lock);
 
 	return ret;
 }
-- 
2.2.0


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 13/14] cpufreq: stats: Fix locking
Date: Fri,  2 Jan 2015 11:16:50 +0530
Message-ID: <0447fedc2d07cd35eed66d7de97ad4e0940b6110.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38214 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbABFrv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 00:47:51 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so23231955pdb.38
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 21:47:51 -0800 (PST)
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Locking wasn't handled properly at places and this patch is an attempt to fix
it. Specially while creating/removing stat tables.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index de55ca86b6f1..95867985ea02 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -150,10 +150,12 @@ static void __cpufreq_stats_free_table(struct cpufreq_policy *policy)
 
 	pr_debug("%s: Free stat table\n", __func__);
 
+	mutex_lock(&cpufreq_stats_lock);
 	sysfs_remove_group(&policy->kobj, &stats_attr_group);
 	kfree(stat->time_in_state);
 	kfree(stat);
 	policy->stats_data = NULL;
+	mutex_unlock(&cpufreq_stats_lock);
 }
 
 static void cpufreq_stats_free_table(unsigned int cpu)
@@ -182,13 +184,17 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	if (unlikely(!table))
 		return 0;
 
+	mutex_lock(&cpufreq_stats_lock);
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
@@ -219,21 +225,21 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 			stat->freq_table[i++] = pos->frequency;
 	stat->state_num = i;
 
-	mutex_lock(&cpufreq_stats_lock);
 	stat->last_time = get_jiffies_64();
 	stat->last_index = freq_table_get_index(stat, policy->cur);
-	mutex_unlock(&cpufreq_stats_lock);
 
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
+	mutex_unlock(&cpufreq_stats_lock);
 
 	return ret;
 }
-- 
2.2.0


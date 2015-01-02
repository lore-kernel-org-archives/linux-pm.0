From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 07/14] cpufreq: stats: remove cpufreq_stats_update_policy_cpu()
Date: Fri,  2 Jan 2015 11:16:44 +0530
Message-ID: <53e8e4e9a40d2759ebdecfe4649f9ecee112a330.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:56276 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbbABFr2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 00:47:28 -0500
Received: by mail-pa0-f41.google.com with SMTP id rd3so23665169pab.28
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 21:47:28 -0800 (PST)
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420177186.git.viresh.kumar@linaro.org>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_stats_update_policy_cpu() doesn't do any useful stuff anymore and must
be removed. Along with it, also remove 'cpu' field from 'struct cpufreq_stats'
as that isn't used as well.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 106c89ccef30..f458fdbc5bfd 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -18,7 +18,6 @@
 static spinlock_t cpufreq_stats_lock;
 
 struct cpufreq_stats {
-	unsigned int cpu;
 	unsigned int total_trans;
 	unsigned long long last_time;
 	unsigned int max_state;
@@ -194,7 +193,6 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	if (ret)
 		goto error_out;
 
-	stat->cpu = cpu;
 	policy->stats_data = stat;
 
 	cpufreq_for_each_valid_entry(pos, table)
@@ -251,24 +249,12 @@ static void cpufreq_stats_create_table(unsigned int cpu)
 	cpufreq_cpu_put(policy);
 }
 
-static void cpufreq_stats_update_policy_cpu(struct cpufreq_policy *policy)
-{
-	struct cpufreq_stats *stat = policy->stats_data;
-
-	stat->cpu = policy->cpu;
-}
-
 static int cpufreq_stat_notifier_policy(struct notifier_block *nb,
 		unsigned long val, void *data)
 {
 	int ret = 0;
 	struct cpufreq_policy *policy = data;
 
-	if (val == CPUFREQ_UPDATE_POLICY_CPU) {
-		cpufreq_stats_update_policy_cpu(policy);
-		return 0;
-	}
-
 	if (val == CPUFREQ_CREATE_POLICY)
 		ret = __cpufreq_stats_create_table(policy);
 	else if (val == CPUFREQ_REMOVE_POLICY)
-- 
2.2.0


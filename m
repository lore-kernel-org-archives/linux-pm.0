From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 10/16] cpufreq: stats: drop 'cpu' field of struct cpufreq_stats
Date: Tue,  6 Jan 2015 21:09:09 +0530
Message-ID: <5ed14ea85604f072ba8545ab82720a85b5747f31.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:62185 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388AbbAFPkG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:40:06 -0500
Received: by mail-pd0-f182.google.com with SMTP id p10so30680704pdj.27
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:40:05 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

'cpu' field of struct cpufreq_stats isn't used anymore and so can be dropped.
This change makes cpufreq_stats_update_policy_cpu() empty and so that is removed
as well.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index ca3d5b71e828..1ed703a3e21e 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -18,7 +18,6 @@
 static spinlock_t cpufreq_stats_lock;
 
 struct cpufreq_stats {
-	unsigned int cpu;
 	unsigned int total_trans;
 	unsigned long long last_time;
 	unsigned int max_state;
@@ -187,7 +186,6 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	if (ret)
 		goto error_out;
 
-	stats->cpu = cpu;
 	policy->stats = stats;
 
 	cpufreq_for_each_valid_entry(pos, table)
@@ -244,22 +242,12 @@ static void cpufreq_stats_create_table(unsigned int cpu)
 	cpufreq_cpu_put(policy);
 }
 
-static void cpufreq_stats_update_policy_cpu(struct cpufreq_policy *policy)
-{
-	policy->stats->cpu = policy->cpu;
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


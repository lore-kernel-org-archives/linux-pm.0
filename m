From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 10/13] cpufreq: governor: No need to manage state machine now
Date: Mon,  8 Feb 2016 17:09:24 +0530
Message-ID: <20ec06049bffdf0a41c89bbe9679a181f8def4cf.1454931189.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34582 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbcBHLkv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 06:40:51 -0500
Received: by mail-pa0-f48.google.com with SMTP id uo6so73851643pac.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 03:40:51 -0800 (PST)
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454931188.git.viresh.kumar@linaro.org>
References: <cover.1454931188.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq core now guarantees that policy->rwsem wouldn't get dropped
while calling CPUFREQ_GOV_POLICY_EXIT governor event and will be kept
acquired until the complete sequence of governor state changes has
finished.

And so we can remove the state machine checks that were put in place
earlier.

This also means that policy_dbs->policy can be initialized while
policy_dbs is allocated, to move all initialization together.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 27 +++++----------------------
 drivers/cpufreq/cpufreq_ondemand.c |  6 +++---
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 5403f863b14d..ee3c2d92da53 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -332,8 +332,10 @@ static inline void gov_clear_update_util(struct cpufreq_policy *policy)
 	synchronize_rcu();
 }
 
-static void gov_cancel_work(struct policy_dbs_info *policy_dbs)
+static void gov_cancel_work(struct cpufreq_policy *policy)
 {
+	struct policy_dbs_info *policy_dbs = policy->governor_data;
+
 	/* Tell dbs_update_util_handler() to skip queuing up work items. */
 	atomic_inc(&policy_dbs->skip_work);
 	/*
@@ -429,6 +431,7 @@ static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *poli
 	if (!policy_dbs)
 		return NULL;
 
+	policy_dbs->policy = policy;
 	mutex_init(&policy_dbs->timer_mutex);
 	atomic_set(&policy_dbs->skip_work, 0);
 	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
@@ -551,10 +554,6 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 
-	/* State should be equivalent to INIT */
-	if (policy_dbs->policy)
-		return -EBUSY;
-
 	if (!--dbs_data->usage_count) {
 		kobject_put(&dbs_data->kobj);
 
@@ -585,10 +584,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy)
 	if (!policy->cur)
 		return -EINVAL;
 
-	/* State should be equivalent to INIT */
-	if (policy_dbs->policy)
-		return -EBUSY;
-
 	sampling_rate = dbs_data->sampling_rate;
 	ignore_nice = dbs_data->ignore_nice_load;
 
@@ -613,7 +608,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy)
 		if (ignore_nice)
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 	}
-	policy_dbs->policy = policy;
 
 	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_cpu_dbs_info_s *cs_dbs_info =
@@ -636,14 +630,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy)
 
 static int cpufreq_governor_stop(struct cpufreq_policy *policy)
 {
-	struct policy_dbs_info *policy_dbs = policy->governor_data;
-
-	/* State should be equivalent to START */
-	if (!policy_dbs->policy)
-		return -EBUSY;
-
-	gov_cancel_work(policy_dbs);
-	policy_dbs->policy = NULL;
+	gov_cancel_work(policy);
 
 	return 0;
 }
@@ -652,10 +639,6 @@ static int cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
-	/* State should be equivalent to START */
-	if (!policy_dbs->policy)
-		return -EBUSY;
-
 	mutex_lock(&policy_dbs->timer_mutex);
 	if (policy->max < policy->cur)
 		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index ccc3419d43f3..745290d7f6a2 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -258,10 +258,10 @@ static void update_sampling_rate(struct dbs_data *dbs_data)
 		policy_dbs = cdbs->policy_dbs;
 
 		/*
-		 * A valid policy_dbs and policy_dbs->policy means governor
-		 * hasn't stopped or exited yet.
+		 * A valid policy_dbs means governor hasn't stopped or exited
+		 * yet.
 		 */
-		if (!policy_dbs || !policy_dbs->policy)
+		if (!policy_dbs)
 			continue;
 
 		policy = policy_dbs->policy;
-- 
2.7.1.370.gb2aa7f8


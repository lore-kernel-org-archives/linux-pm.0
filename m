From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 5/7] cpufreq: governor: No need to manage state machine now
Date: Tue,  9 Feb 2016 09:16:17 +0530
Message-ID: <9b7ac57013a525863d6c0c5e86419744d37879a4.1454988792.git.viresh.kumar@linaro.org>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454988792.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1454988792.git.viresh.kumar@linaro.org>
References: <cover.1454988792.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

cpufreq core now guarantees that policy->rwsem wouldn't get dropped
while calling CPUFREQ_GOV_POLICY_EXIT governor event and will be kept
acquired until the complete sequence of governor state changes has
finished.

And so we can remove the state machine checks that were put in place
earlier.

This also means that policy_dbs->policy can be initialized while
policy_dbs is allocated, to move all initialization together.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/cpufreq_governor.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 7038ada3915d..464f346815e0 100644
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
@@ -560,10 +563,6 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	int count;
 
-	/* State should be equivalent to INIT */
-	if (policy_dbs->policy)
-		return -EBUSY;
-
 	mutex_lock(&dbs_data->mutex);
 	list_del(&policy_dbs->list);
 	count = dbs_data->usage_count--;
@@ -599,10 +598,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy)
 	if (!policy->cur)
 		return -EINVAL;
 
-	/* State should be equivalent to INIT */
-	if (policy_dbs->policy)
-		return -EBUSY;
-
 	sampling_rate = dbs_data->sampling_rate;
 	ignore_nice = dbs_data->ignore_nice_load;
 
@@ -627,7 +622,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy)
 		if (ignore_nice)
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 	}
-	policy_dbs->policy = policy;
 
 	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_cpu_dbs_info_s *cs_dbs_info =
@@ -650,14 +644,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy)
 
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
@@ -666,10 +653,6 @@ static int cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
 	struct policy_dbs_info *policy_dbs = policy->governor_data;
 
-	/* State should be equivalent to START */
-	if (!policy_dbs->policy)
-		return -EBUSY;
-
 	mutex_lock(&policy_dbs->timer_mutex);
 	if (policy->max < policy->cur)
 		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
-- 
2.7.1.370.gb2aa7f8

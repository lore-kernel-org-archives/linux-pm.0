From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 4/6] cpufreq: governor: No need to manage state machine now
Date: Thu, 11 Feb 2016 17:31:14 +0530
Message-ID: <36f3adcb78ff16deeab8db5104f25dfd96b3a631.1455191663.git.viresh.kumar@linaro.org>
References: <cover.1455191663.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455191663.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1455191663.git.viresh.kumar@linaro.org>
References: <cover.1455191663.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

The cpufreq core now guarantees that policy->rwsem won't be dropped
while running the ->governor callback for the CPUFREQ_GOV_POLICY_EXIT
event and will be held acquired until the complete sequence of governor
state changes has finished.

This allows governor state machine checks to be dropped from multiple
functions in cpufreq_governor.c.

This also means that policy_dbs->policy can be initialized upfront, so
the entire initialization of struct policy_dbs is carried out in one
place.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Juri Lelli <juri.lelli@arm.com>
Tested-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpufreq/cpufreq_governor.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 3a9dab752148..481585611097 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -233,8 +233,10 @@ static inline void gov_clear_update_util(struct cpufreq_policy *policy)
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
@@ -330,6 +332,7 @@ static struct policy_dbs_info *alloc_policy_dbs_info(struct cpufreq_policy *poli
 	if (!policy_dbs)
 		return NULL;
 
+	policy_dbs->policy = policy;
 	mutex_init(&policy_dbs->timer_mutex);
 	atomic_set(&policy_dbs->skip_work, 0);
 	init_irq_work(&policy_dbs->irq_work, dbs_irq_work);
@@ -460,10 +463,6 @@ static int cpufreq_governor_exit(struct cpufreq_policy *policy)
 	struct dbs_data *dbs_data = policy_dbs->dbs_data;
 	int count;
 
-	/* State should be equivalent to INIT */
-	if (policy_dbs->policy)
-		return -EBUSY;
-
 	mutex_lock(&dbs_data->mutex);
 	list_del(&policy_dbs->list);
 	count = --dbs_data->usage_count;
@@ -499,10 +498,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy)
 	if (!policy->cur)
 		return -EINVAL;
 
-	/* State should be equivalent to INIT */
-	if (policy_dbs->policy)
-		return -EBUSY;
-
 	sampling_rate = dbs_data->sampling_rate;
 	ignore_nice = dbs_data->ignore_nice_load;
 
@@ -527,7 +522,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy)
 		if (ignore_nice)
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 	}
-	policy_dbs->policy = policy;
 
 	if (gov->governor == GOV_CONSERVATIVE) {
 		struct cs_cpu_dbs_info_s *cs_dbs_info =
@@ -550,14 +544,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy)
 
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
@@ -566,10 +553,6 @@ static int cpufreq_governor_limits(struct cpufreq_policy *policy)
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

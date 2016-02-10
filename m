From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5 1/3] cpufreq: governor: No need to manage state machine now
Date: Wed, 10 Feb 2016 12:30:11 +0530
Message-ID: <8ddf5eb44eebba01062234d9aed931e3b6882a2b.1455087379.git.viresh.kumar@linaro.org>
References: <CAJZ5v0jtUdjq362zeN1139m_2-Vb9yHjAB0ixMQTuCFv2C+dnA@mail.gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35400 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533AbcBJHAW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Feb 2016 02:00:22 -0500
Received: by mail-pa0-f45.google.com with SMTP id ho8so7282828pac.2
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 23:00:22 -0800 (PST)
In-Reply-To: <CAJZ5v0jtUdjq362zeN1139m_2-Vb9yHjAB0ixMQTuCFv2C+dnA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, open list <linux-kernel@vger.kernel.org>

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
Rafael,

The 4th patch is dropped and 5-7 are updated on top of that.

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


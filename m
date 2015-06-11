From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 08/12] cpufreq: governor: synchronize work-handler with governor callbacks
Date: Thu, 11 Jun 2015 16:21:51 +0530
Message-ID: <c8e5037760d45b96e059bf6fd150e2e23205ff76.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34478 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbFKKwo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 06:52:44 -0400
Received: by payr10 with SMTP id r10so2308318pay.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 03:52:44 -0700 (PDT)
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Currently the work-handler's for all the CPUs are synchronized with one
another but not with cpufreq_governor_dbs(). Both work-handlers and
cpufreq_governor_dbs() enqueue work. And these not being in sync is an
open invitation to all kind of races to come in.

So, this patch replaces 'timer_mutex' with 'cdata->mutex' so that both
work-handler and callback are in sync.

Also in update_sampling_rate() we are dropping the mutex while
canceling delayed-work. There is no need to do that, keep lock active
for the entire length of routine as that also enqueues works.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 14 +++-----------
 drivers/cpufreq/cpufreq_governor.h |  6 ------
 drivers/cpufreq/cpufreq_ondemand.c | 13 ++++---------
 3 files changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 08bb67225b85..aa24aa9a9eb3 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -228,13 +228,12 @@ static void dbs_timer(struct work_struct *work)
 {
 	struct cpu_dbs_info *cdbs = container_of(work, struct cpu_dbs_info,
 						 dwork.work);
-	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
-	struct cpufreq_policy *policy = ccdbs->policy;
+	struct cpufreq_policy *policy = cdbs->ccdbs->policy;
 	struct dbs_data *dbs_data = policy->governor_data;
 	unsigned int sampling_rate, delay;
 	bool modify_all = true;
 
-	mutex_lock(&ccdbs->timer_mutex);
+	mutex_lock(&dbs_data->cdata->mutex);
 
 	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
@@ -252,7 +251,7 @@ static void dbs_timer(struct work_struct *work)
 	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, modify_all);
 	gov_queue_work(dbs_data, policy, delay, modify_all);
 
-	mutex_unlock(&ccdbs->timer_mutex);
+	mutex_unlock(&dbs_data->cdata->mutex);
 }
 
 static void set_sampling_rate(struct dbs_data *dbs_data,
@@ -424,7 +423,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 	}
 
 	ccdbs->time_stamp = ktime_get();
-	mutex_init(&ccdbs->timer_mutex);
 
 	for_each_cpu(j, policy->cpus) {
 		struct cpu_dbs_info *j_cdbs = cdata->get_cpu_cdbs(j);
@@ -470,8 +468,6 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
-	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
-	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
 
 	gov_cancel_work(dbs_data, policy);
 
@@ -481,8 +477,6 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 
 		cs_dbs_info->enable = 0;
 	}
-
-	mutex_destroy(&ccdbs->timer_mutex);
 }
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy,
@@ -495,7 +489,6 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 	if (!cdbs->ccdbs)
 		return;
 
-	mutex_lock(&cdbs->ccdbs->timer_mutex);
 	if (policy->max < cdbs->ccdbs->policy->cur)
 		__cpufreq_driver_target(cdbs->ccdbs->policy, policy->max,
 					CPUFREQ_RELATION_H);
@@ -503,7 +496,6 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 		__cpufreq_driver_target(cdbs->ccdbs->policy, policy->min,
 					CPUFREQ_RELATION_L);
 	dbs_check_cpu(dbs_data, cpu);
-	mutex_unlock(&cdbs->ccdbs->timer_mutex);
 }
 
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 2125c299c602..2b2884f91fe7 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -131,12 +131,6 @@ static void *get_cpu_dbs_info_s(int cpu)				\
 /* Common to all CPUs of a policy */
 struct cpu_common_dbs_info {
 	struct cpufreq_policy *policy;
-	/*
-	 * percpu mutex that serializes governor limit change with dbs_timer
-	 * invocation. We do not want dbs_timer to run when user is changing
-	 * the governor or limits.
-	 */
-	struct mutex timer_mutex;
 	ktime_t time_stamp;
 };
 
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 11db20079fc6..87813830e169 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -249,6 +249,8 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	int cpu;
 
+	mutex_lock(&dbs_data->cdata->mutex);
+
 	od_tuners->sampling_rate = new_rate = max(new_rate,
 			dbs_data->min_sampling_rate);
 
@@ -267,28 +269,21 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 		cpufreq_cpu_put(policy);
 
-		mutex_lock(&dbs_info->cdbs.ccdbs->timer_mutex);
-
-		if (!delayed_work_pending(&dbs_info->cdbs.dwork)) {
-			mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
+		if (!delayed_work_pending(&dbs_info->cdbs.dwork))
 			continue;
-		}
 
 		next_sampling = jiffies + usecs_to_jiffies(new_rate);
 		appointed_at = dbs_info->cdbs.dwork.timer.expires;
 
 		if (time_before(next_sampling, appointed_at)) {
 
-			mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
 			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
-			mutex_lock(&dbs_info->cdbs.ccdbs->timer_mutex);
-
 			gov_queue_work(dbs_data, policy,
 				       usecs_to_jiffies(new_rate), true);
 
 		}
-		mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
 	}
+	mutex_unlock(&dbs_data->cdata->mutex);
 }
 
 static ssize_t store_sampling_rate(struct dbs_data *dbs_data, const char *buf,
-- 
2.4.0


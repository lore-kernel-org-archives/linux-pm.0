From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/12] cpufreq: governor: Avoid invalid states with additional checks
Date: Thu, 11 Jun 2015 16:21:52 +0530
Message-ID: <280186b68a8b906365316876a7b6d9eafb28296b.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32872 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbbFKKws (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 06:52:48 -0400
Received: by padev16 with SMTP id ev16so2330755pad.0
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 03:52:48 -0700 (PDT)
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

There can be races where the request has come to a wrong state. For
example INIT followed by STOP (instead of START) or START followed by
EXIT (instead of STOP).

Also make sure, once we have started canceling queued works, we don't
queue any new works. That can lead to the case where the work-handler
finds many data structures are freed and so NULL pointer exceptions.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 56 ++++++++++++++++++++++++++++++--------
 drivers/cpufreq/cpufreq_governor.h |  1 +
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index aa24aa9a9eb3..ee2e19a1218a 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -169,8 +169,12 @@ static inline void __gov_queue_work(int cpu, struct dbs_data *dbs_data,
 void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
 		unsigned int delay, bool all_cpus)
 {
+	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(policy->cpu);
 	int i;
 
+	if (!cdbs->ccdbs->enabled)
+		return;
+
 	mutex_lock(&cpufreq_governor_lock);
 	if (!policy->governor_enabled)
 		goto out_unlock;
@@ -234,6 +238,8 @@ static void dbs_timer(struct work_struct *work)
 	bool modify_all = true;
 
 	mutex_lock(&dbs_data->cdata->mutex);
+	if (!cdbs->ccdbs->enabled)
+		goto unlock;
 
 	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
@@ -251,6 +257,7 @@ static void dbs_timer(struct work_struct *work)
 	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, modify_all);
 	gov_queue_work(dbs_data, policy, delay, modify_all);
 
+unlock:
 	mutex_unlock(&dbs_data->cdata->mutex);
 }
 
@@ -376,10 +383,15 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 	return ret;
 }
 
-static void cpufreq_governor_exit(struct cpufreq_policy *policy,
-				  struct dbs_data *dbs_data)
+static int cpufreq_governor_exit(struct cpufreq_policy *policy,
+				 struct dbs_data *dbs_data)
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
+	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(policy->cpu);
+
+	/* STOP should have been called by now */
+	if (cdbs->ccdbs->enabled)
+		return -EBUSY;
 
 	policy->governor_data = NULL;
 	if (!--dbs_data->usage_count) {
@@ -395,6 +407,8 @@ static void cpufreq_governor_exit(struct cpufreq_policy *policy,
 		free_ccdbs(policy, cdata);
 		kfree(dbs_data);
 	}
+
+	return 0;
 }
 
 static int cpufreq_governor_start(struct cpufreq_policy *policy,
@@ -409,6 +423,10 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 	if (!policy->cur)
 		return -EINVAL;
 
+	/* START shouldn't be already called */
+	if (ccdbs->enabled)
+		return -EBUSY;
+
 	if (cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
@@ -458,17 +476,25 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		od_ops->powersave_bias_init_cpu(cpu);
 	}
 
+	ccdbs->enabled = true;
 	gov_queue_work(dbs_data, policy, delay_for_sampling_rate(sampling_rate),
 		       true);
 	return 0;
 }
 
-static void cpufreq_governor_stop(struct cpufreq_policy *policy,
-				  struct dbs_data *dbs_data)
+static int cpufreq_governor_stop(struct cpufreq_policy *policy,
+				 struct dbs_data *dbs_data)
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
+	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
+
+	/* Shouldn't be already stopped */
+	if (!ccdbs->enabled)
+		return -EBUSY;
 
+	ccdbs->enabled = false;
 	gov_cancel_work(dbs_data, policy);
 
 	if (cdata->governor == GOV_CONSERVATIVE) {
@@ -477,17 +503,19 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 
 		cs_dbs_info->enable = 0;
 	}
+
+	return 0;
 }
 
-static void cpufreq_governor_limits(struct cpufreq_policy *policy,
-				    struct dbs_data *dbs_data)
+static int cpufreq_governor_limits(struct cpufreq_policy *policy,
+				   struct dbs_data *dbs_data)
 {
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
 
-	if (!cdbs->ccdbs)
-		return;
+	if (!cdbs->ccdbs->enabled)
+		return -EBUSY;
 
 	if (policy->max < cdbs->ccdbs->policy->cur)
 		__cpufreq_driver_target(cdbs->ccdbs->policy, policy->max,
@@ -496,13 +524,15 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 		__cpufreq_driver_target(cdbs->ccdbs->policy, policy->min,
 					CPUFREQ_RELATION_L);
 	dbs_check_cpu(dbs_data, cpu);
+
+	return 0;
 }
 
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 			 struct common_dbs_data *cdata, unsigned int event)
 {
 	struct dbs_data *dbs_data;
-	int ret = 0;
+	int ret;
 
 	/* Lock governor to block concurrent initialization of governor */
 	mutex_lock(&cdata->mutex);
@@ -522,17 +552,19 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		ret = cpufreq_governor_init(policy, dbs_data, cdata);
 		break;
 	case CPUFREQ_GOV_POLICY_EXIT:
-		cpufreq_governor_exit(policy, dbs_data);
+		ret = cpufreq_governor_exit(policy, dbs_data);
 		break;
 	case CPUFREQ_GOV_START:
 		ret = cpufreq_governor_start(policy, dbs_data);
 		break;
 	case CPUFREQ_GOV_STOP:
-		cpufreq_governor_stop(policy, dbs_data);
+		ret = cpufreq_governor_stop(policy, dbs_data);
 		break;
 	case CPUFREQ_GOV_LIMITS:
-		cpufreq_governor_limits(policy, dbs_data);
+		ret = cpufreq_governor_limits(policy, dbs_data);
 		break;
+	default:
+		ret = -EINVAL;
 	}
 
 unlock:
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 2b2884f91fe7..7da5aedb8174 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -130,6 +130,7 @@ static void *get_cpu_dbs_info_s(int cpu)				\
 
 /* Common to all CPUs of a policy */
 struct cpu_common_dbs_info {
+	bool enabled;
 	struct cpufreq_policy *policy;
 	ktime_t time_stamp;
 };
-- 
2.4.0


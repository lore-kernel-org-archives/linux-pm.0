From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/12] cpufreq: governor: rename cur_policy as policy
Date: Thu, 11 Jun 2015 16:21:48 +0530
Message-ID: <fcb0238e0129700cd090f6199b44fbf3edc0b63b.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35174 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbbFKKwb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 06:52:31 -0400
Received: by pacyx8 with SMTP id yx8so2269386pac.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 03:52:31 -0700 (PDT)
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Just call it 'policy', cur_policy is unnecessarily long and doesn't
have any special meaning.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 10 +++++-----
 drivers/cpufreq/cpufreq_governor.c     | 18 +++++++++---------
 drivers/cpufreq/cpufreq_governor.h     |  2 +-
 drivers/cpufreq/cpufreq_ondemand.c     | 19 ++++++++++---------
 4 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 0e3ec1d968d9..af47d322679e 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -47,7 +47,7 @@ static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
 static void cs_check_cpu(int cpu, unsigned int load)
 {
 	struct cs_cpu_dbs_info_s *dbs_info = &per_cpu(cs_cpu_dbs_info, cpu);
-	struct cpufreq_policy *policy = dbs_info->cdbs.cur_policy;
+	struct cpufreq_policy *policy = dbs_info->cdbs.policy;
 	struct dbs_data *dbs_data = policy->governor_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
@@ -106,10 +106,10 @@ static void cs_dbs_timer(struct work_struct *work)
 {
 	struct cs_cpu_dbs_info_s *dbs_info = container_of(work,
 			struct cs_cpu_dbs_info_s, cdbs.dwork.work);
-	unsigned int cpu = dbs_info->cdbs.cur_policy->cpu;
+	unsigned int cpu = dbs_info->cdbs.policy->cpu;
 	struct cs_cpu_dbs_info_s *core_dbs_info = &per_cpu(cs_cpu_dbs_info,
 			cpu);
-	struct dbs_data *dbs_data = dbs_info->cdbs.cur_policy->governor_data;
+	struct dbs_data *dbs_data = dbs_info->cdbs.policy->governor_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	int delay = delay_for_sampling_rate(cs_tuners->sampling_rate);
 	bool modify_all = true;
@@ -120,7 +120,7 @@ static void cs_dbs_timer(struct work_struct *work)
 	else
 		dbs_check_cpu(dbs_data, cpu);
 
-	gov_queue_work(dbs_data, dbs_info->cdbs.cur_policy, delay, modify_all);
+	gov_queue_work(dbs_data, dbs_info->cdbs.policy, delay, modify_all);
 	mutex_unlock(&core_dbs_info->cdbs.timer_mutex);
 }
 
@@ -135,7 +135,7 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 	if (!dbs_info->enable)
 		return 0;
 
-	policy = dbs_info->cdbs.cur_policy;
+	policy = dbs_info->cdbs.policy;
 
 	/*
 	 * we only care if our internally tracked freq moves outside the 'valid'
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 4ea13f182154..c0566f86caed 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -60,7 +60,7 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 		ignore_nice = cs_tuners->ignore_nice_load;
 	}
 
-	policy = cdbs->cur_policy;
+	policy = cdbs->policy;
 
 	/* Get Absolute Load */
 	for_each_cpu(j, policy->cpus) {
@@ -211,7 +211,7 @@ static inline void gov_cancel_work(struct dbs_data *dbs_data,
 /* Will return if we need to evaluate cpu load again or not */
 bool need_load_eval(struct cpu_dbs_info *cdbs, unsigned int sampling_rate)
 {
-	if (policy_is_shared(cdbs->cur_policy)) {
+	if (policy_is_shared(cdbs->policy)) {
 		ktime_t time_now = ktime_get();
 		s64 delta_us = ktime_us_delta(time_now, cdbs->time_stamp);
 
@@ -352,7 +352,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		struct cpu_dbs_info *j_cdbs = cdata->get_cpu_cdbs(j);
 		unsigned int prev_load;
 
-		j_cdbs->cur_policy = policy;
+		j_cdbs->policy = policy;
 		j_cdbs->prev_cpu_idle =
 			get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall, io_busy);
 
@@ -409,7 +409,7 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 	gov_cancel_work(dbs_data, policy);
 
 	mutex_destroy(&cdbs->timer_mutex);
-	cdbs->cur_policy = NULL;
+	cdbs->policy = NULL;
 }
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy,
@@ -419,15 +419,15 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
 
-	if (!cdbs->cur_policy)
+	if (!cdbs->policy)
 		return;
 
 	mutex_lock(&cdbs->timer_mutex);
-	if (policy->max < cdbs->cur_policy->cur)
-		__cpufreq_driver_target(cdbs->cur_policy, policy->max,
+	if (policy->max < cdbs->policy->cur)
+		__cpufreq_driver_target(cdbs->policy, policy->max,
 					CPUFREQ_RELATION_H);
-	else if (policy->min > cdbs->cur_policy->cur)
-		__cpufreq_driver_target(cdbs->cur_policy, policy->min,
+	else if (policy->min > cdbs->policy->cur)
+		__cpufreq_driver_target(cdbs->policy, policy->min,
 					CPUFREQ_RELATION_L);
 	dbs_check_cpu(dbs_data, cpu);
 	mutex_unlock(&cdbs->timer_mutex);
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 6b5e33f68064..a0f8eb79ee6d 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -140,7 +140,7 @@ struct cpu_dbs_info {
 	 * wake-up from idle.
 	 */
 	unsigned int prev_load;
-	struct cpufreq_policy *cur_policy;
+	struct cpufreq_policy *policy;
 	struct delayed_work dwork;
 	/*
 	 * percpu mutex that serializes governor limit change with gov_dbs_timer
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 830aef1db8c3..d29c6f9c6e3e 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -155,7 +155,7 @@ static void dbs_freq_increase(struct cpufreq_policy *policy, unsigned int freq)
 static void od_check_cpu(int cpu, unsigned int load)
 {
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
-	struct cpufreq_policy *policy = dbs_info->cdbs.cur_policy;
+	struct cpufreq_policy *policy = dbs_info->cdbs.policy;
 	struct dbs_data *dbs_data = policy->governor_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
@@ -195,10 +195,10 @@ static void od_dbs_timer(struct work_struct *work)
 {
 	struct od_cpu_dbs_info_s *dbs_info =
 		container_of(work, struct od_cpu_dbs_info_s, cdbs.dwork.work);
-	unsigned int cpu = dbs_info->cdbs.cur_policy->cpu;
+	unsigned int cpu = dbs_info->cdbs.policy->cpu;
 	struct od_cpu_dbs_info_s *core_dbs_info = &per_cpu(od_cpu_dbs_info,
 			cpu);
-	struct dbs_data *dbs_data = dbs_info->cdbs.cur_policy->governor_data;
+	struct dbs_data *dbs_data = dbs_info->cdbs.policy->governor_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	int delay = 0, sample_type = core_dbs_info->sample_type;
 	bool modify_all = true;
@@ -213,8 +213,9 @@ static void od_dbs_timer(struct work_struct *work)
 	core_dbs_info->sample_type = OD_NORMAL_SAMPLE;
 	if (sample_type == OD_SUB_SAMPLE) {
 		delay = core_dbs_info->freq_lo_jiffies;
-		__cpufreq_driver_target(core_dbs_info->cdbs.cur_policy,
-				core_dbs_info->freq_lo, CPUFREQ_RELATION_H);
+		__cpufreq_driver_target(core_dbs_info->cdbs.policy,
+					core_dbs_info->freq_lo,
+					CPUFREQ_RELATION_H);
 	} else {
 		dbs_check_cpu(dbs_data, cpu);
 		if (core_dbs_info->freq_lo) {
@@ -229,7 +230,7 @@ static void od_dbs_timer(struct work_struct *work)
 		delay = delay_for_sampling_rate(od_tuners->sampling_rate
 				* core_dbs_info->rate_mult);
 
-	gov_queue_work(dbs_data, dbs_info->cdbs.cur_policy, delay, modify_all);
+	gov_queue_work(dbs_data, dbs_info->cdbs.policy, delay, modify_all);
 	mutex_unlock(&core_dbs_info->cdbs.timer_mutex);
 }
 
@@ -289,8 +290,8 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
 			mutex_lock(&dbs_info->cdbs.timer_mutex);
 
-			gov_queue_work(dbs_data, dbs_info->cdbs.cur_policy,
-					usecs_to_jiffies(new_rate), true);
+			gov_queue_work(dbs_data, dbs_info->cdbs.policy,
+				       usecs_to_jiffies(new_rate), true);
 
 		}
 		mutex_unlock(&dbs_info->cdbs.timer_mutex);
@@ -559,7 +560,7 @@ static void od_set_powersave_bias(unsigned int powersave_bias)
 		if (cpumask_test_cpu(cpu, &done))
 			continue;
 
-		policy = per_cpu(od_cpu_dbs_info, cpu).cdbs.cur_policy;
+		policy = per_cpu(od_cpu_dbs_info, cpu).cdbs.policy;
 		if (!policy)
 			continue;
 
-- 
2.4.0


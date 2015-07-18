From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/5] cpufreq: governor: split out common part of {cs|od}_dbs_timer()
Date: Sat, 18 Jul 2015 11:31:00 +0530
Message-ID: <d04132b633c0474eb6a2c433a96951f39b087780.1437199001.git.viresh.kumar@linaro.org>
References: <2874468.iRvuV1Y9DI@vostro.rjw.lan>
 <cover.1437199001.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437199001.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437199001.git.viresh.kumar@linaro.org>
References: <cover.1437199001.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Some part of cs_dbs_timer() and od_dbs_timer() is exactly same and is
unnecessarily duplicated.

Create the real work-handler in cpufreq_governor.c and put the common
code in this routine (dbs_timer()).

Shouldn't make any functional change.

Reviewed-and-tested-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 27 +++++++-----------------
 drivers/cpufreq/cpufreq_governor.c     | 38 ++++++++++++++++++++++++++++++----
 drivers/cpufreq/cpufreq_governor.h     | 10 ++++-----
 drivers/cpufreq/cpufreq_ondemand.c     | 36 +++++++++++++-------------------
 4 files changed, 60 insertions(+), 51 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index d21c3cff9056..84a1506950a7 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -102,28 +102,15 @@ static void cs_check_cpu(int cpu, unsigned int load)
 	}
 }
 
-static void cs_dbs_timer(struct work_struct *work)
+static unsigned int cs_dbs_timer(struct cpu_dbs_info *cdbs,
+				 struct dbs_data *dbs_data, bool modify_all)
 {
-	struct cs_cpu_dbs_info_s *dbs_info = container_of(work,
-			struct cs_cpu_dbs_info_s, cdbs.dwork.work);
-	struct cpufreq_policy *policy = dbs_info->cdbs.shared->policy;
-	unsigned int cpu = policy->cpu;
-	struct cs_cpu_dbs_info_s *core_dbs_info = &per_cpu(cs_cpu_dbs_info,
-			cpu);
-	struct dbs_data *dbs_data = policy->governor_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
-	int delay = delay_for_sampling_rate(cs_tuners->sampling_rate);
-	bool modify_all = true;
-
-	mutex_lock(&core_dbs_info->cdbs.shared->timer_mutex);
-	if (!need_load_eval(core_dbs_info->cdbs.shared,
-			    cs_tuners->sampling_rate))
-		modify_all = false;
-	else
-		dbs_check_cpu(dbs_data, cpu);
-
-	gov_queue_work(dbs_data, policy, delay, modify_all);
-	mutex_unlock(&core_dbs_info->cdbs.shared->timer_mutex);
+
+	if (modify_all)
+		dbs_check_cpu(dbs_data, cdbs->shared->policy->cpu);
+
+	return delay_for_sampling_rate(cs_tuners->sampling_rate);
 }
 
 static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index b01cb729104b..7ed0ec2ac853 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -207,8 +207,8 @@ static inline void gov_cancel_work(struct dbs_data *dbs_data,
 }
 
 /* Will return if we need to evaluate cpu load again or not */
-bool need_load_eval(struct cpu_common_dbs_info *shared,
-		    unsigned int sampling_rate)
+static bool need_load_eval(struct cpu_common_dbs_info *shared,
+			   unsigned int sampling_rate)
 {
 	if (policy_is_shared(shared->policy)) {
 		ktime_t time_now = ktime_get();
@@ -223,7 +223,37 @@ bool need_load_eval(struct cpu_common_dbs_info *shared,
 
 	return true;
 }
-EXPORT_SYMBOL_GPL(need_load_eval);
+
+static void dbs_timer(struct work_struct *work)
+{
+	struct cpu_dbs_info *cdbs = container_of(work, struct cpu_dbs_info,
+						 dwork.work);
+	struct cpu_common_dbs_info *shared = cdbs->shared;
+	struct cpufreq_policy *policy = shared->policy;
+	struct dbs_data *dbs_data = policy->governor_data;
+	unsigned int sampling_rate, delay;
+	bool modify_all = true;
+
+	mutex_lock(&shared->timer_mutex);
+
+	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
+		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
+
+		sampling_rate = cs_tuners->sampling_rate;
+	} else {
+		struct od_dbs_tuners *od_tuners = dbs_data->tuners;
+
+		sampling_rate = od_tuners->sampling_rate;
+	}
+
+	if (!need_load_eval(cdbs->shared, sampling_rate))
+		modify_all = false;
+
+	delay = dbs_data->cdata->gov_dbs_timer(cdbs, dbs_data, modify_all);
+	gov_queue_work(dbs_data, policy, delay, modify_all);
+
+	mutex_unlock(&shared->timer_mutex);
+}
 
 static void set_sampling_rate(struct dbs_data *dbs_data,
 		unsigned int sampling_rate)
@@ -411,7 +441,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		if (ignore_nice)
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 
-		INIT_DEFERRABLE_WORK(&j_cdbs->dwork, cdata->gov_dbs_timer);
+		INIT_DEFERRABLE_WORK(&j_cdbs->dwork, dbs_timer);
 	}
 
 	if (cdata->governor == GOV_CONSERVATIVE) {
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 8e4a25f0730c..50f171796632 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -132,8 +132,8 @@ static void *get_cpu_dbs_info_s(int cpu)				\
 struct cpu_common_dbs_info {
 	struct cpufreq_policy *policy;
 	/*
-	 * percpu mutex that serializes governor limit change with gov_dbs_timer
-	 * invocation. We do not want gov_dbs_timer to run when user is changing
+	 * percpu mutex that serializes governor limit change with dbs_timer
+	 * invocation. We do not want dbs_timer to run when user is changing
 	 * the governor or limits.
 	 */
 	struct mutex timer_mutex;
@@ -210,7 +210,9 @@ struct common_dbs_data {
 
 	struct cpu_dbs_info *(*get_cpu_cdbs)(int cpu);
 	void *(*get_cpu_dbs_info_s)(int cpu);
-	void (*gov_dbs_timer)(struct work_struct *work);
+	unsigned int (*gov_dbs_timer)(struct cpu_dbs_info *cdbs,
+				      struct dbs_data *dbs_data,
+				      bool modify_all);
 	void (*gov_check_cpu)(int cpu, unsigned int load);
 	int (*init)(struct dbs_data *dbs_data, bool notify);
 	void (*exit)(struct dbs_data *dbs_data, bool notify);
@@ -269,8 +271,6 @@ static ssize_t show_sampling_rate_min_gov_pol				\
 extern struct mutex cpufreq_governor_lock;
 
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
-bool need_load_eval(struct cpu_common_dbs_info *shared,
-		    unsigned int sampling_rate);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		struct common_dbs_data *cdata, unsigned int event);
 void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 14d7e86e7f94..1fa9088c84a8 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -191,48 +191,40 @@ static void od_check_cpu(int cpu, unsigned int load)
 	}
 }
 
-static void od_dbs_timer(struct work_struct *work)
+static unsigned int od_dbs_timer(struct cpu_dbs_info *cdbs,
+				 struct dbs_data *dbs_data, bool modify_all)
 {
-	struct od_cpu_dbs_info_s *dbs_info =
-		container_of(work, struct od_cpu_dbs_info_s, cdbs.dwork.work);
-	struct cpufreq_policy *policy = dbs_info->cdbs.shared->policy;
+	struct cpufreq_policy *policy = cdbs->shared->policy;
 	unsigned int cpu = policy->cpu;
-	struct od_cpu_dbs_info_s *core_dbs_info = &per_cpu(od_cpu_dbs_info,
+	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info,
 			cpu);
-	struct dbs_data *dbs_data = policy->governor_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
-	int delay = 0, sample_type = core_dbs_info->sample_type;
-	bool modify_all = true;
+	int delay = 0, sample_type = dbs_info->sample_type;
 
-	mutex_lock(&core_dbs_info->cdbs.shared->timer_mutex);
-	if (!need_load_eval(core_dbs_info->cdbs.shared,
-			    od_tuners->sampling_rate)) {
-		modify_all = false;
+	if (!modify_all)
 		goto max_delay;
-	}
 
 	/* Common NORMAL_SAMPLE setup */
-	core_dbs_info->sample_type = OD_NORMAL_SAMPLE;
+	dbs_info->sample_type = OD_NORMAL_SAMPLE;
 	if (sample_type == OD_SUB_SAMPLE) {
-		delay = core_dbs_info->freq_lo_jiffies;
-		__cpufreq_driver_target(policy, core_dbs_info->freq_lo,
+		delay = dbs_info->freq_lo_jiffies;
+		__cpufreq_driver_target(policy, dbs_info->freq_lo,
 					CPUFREQ_RELATION_H);
 	} else {
 		dbs_check_cpu(dbs_data, cpu);
-		if (core_dbs_info->freq_lo) {
+		if (dbs_info->freq_lo) {
 			/* Setup timer for SUB_SAMPLE */
-			core_dbs_info->sample_type = OD_SUB_SAMPLE;
-			delay = core_dbs_info->freq_hi_jiffies;
+			dbs_info->sample_type = OD_SUB_SAMPLE;
+			delay = dbs_info->freq_hi_jiffies;
 		}
 	}
 
 max_delay:
 	if (!delay)
 		delay = delay_for_sampling_rate(od_tuners->sampling_rate
-				* core_dbs_info->rate_mult);
+				* dbs_info->rate_mult);
 
-	gov_queue_work(dbs_data, policy, delay, modify_all);
-	mutex_unlock(&core_dbs_info->cdbs.shared->timer_mutex);
+	return delay;
 }
 
 /************************** sysfs interface ************************/
-- 
2.4.0

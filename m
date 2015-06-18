From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 06/12] cpufreq: governor: Keep single copy of information
 common to policy->cpus
Date: Thu, 18 Jun 2015 11:29:41 +0530
Message-ID: <20150618055941.GA3410@linux>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
 <ca16538aebad3c886092c11dc3cc22e1385f2415.1434019473.git.viresh.kumar@linaro.org>
 <557E6D6E.1070200@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35057 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbbFRF7v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 01:59:51 -0400
Received: by pacyx8 with SMTP id yx8so53608477pac.2
        for <linux-pm@vger.kernel.org>; Wed, 17 Jun 2015 22:59:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <557E6D6E.1070200@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, ke.wang@spreadtrum.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 15-06-15, 11:45, Preeti U Murthy wrote:
> On 06/11/2015 04:21 PM, Viresh Kumar wrote:
> This is a per-policy data structure, so why free it only when all the
> users of the governor are gone ? We should be freeing it when a policy
> is asked to exit, which is independent of references to this governor by
> other policy cpus. This would mean freeing it outside this if condition.

Okay, based on review here is the diff from earlier patch:


diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 0ebff6fd0a0b..72a92fa71ba5 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -248,8 +248,6 @@ static int alloc_ccdbs(struct cpufreq_policy *policy,
 	if (!ccdbs)
 		return -ENOMEM;
 
-	ccdbs->policy = policy;
-
 	/* Set ccdbs for all CPUs, online+offline */
 	for_each_cpu(j, policy->related_cpus)
 		cdata->get_cpu_cdbs(j)->ccdbs = ccdbs;
@@ -363,9 +361,10 @@ static void cpufreq_governor_exit(struct cpufreq_policy *policy,
 		}
 
 		cdata->exit(dbs_data, policy->governor->initialized == 1);
-		free_ccdbs(policy, cdata);
 		kfree(dbs_data);
 	}
+
+	free_ccdbs(policy, cdata);
 }
 
 static int cpufreq_governor_start(struct cpufreq_policy *policy,
@@ -393,6 +392,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		io_busy = od_tuners->io_is_busy;
 	}
 
+	ccdbs->policy = policy;
 	ccdbs->time_stamp = ktime_get();
 	mutex_init(&ccdbs->timer_mutex);
 
@@ -452,6 +452,7 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 		cs_dbs_info->enable = 0;
 	}
 
+	ccdbs->policy = NULL;
 	mutex_destroy(&ccdbs->timer_mutex);
 }
 
@@ -462,7 +463,7 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
 
-	if (!cdbs->ccdbs)
+	if (!cdbs->ccdbs || !cdbs->ccdbs->policy)
 		return;
 
 	mutex_lock(&cdbs->ccdbs->timer_mutex);




And here is the complete patch which you can Ack :)

------------8<---------------

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 5 Jun 2015 13:09:45 +0530
Subject: [PATCH] cpufreq: governor: Keep single copy of information common to
 policy->cpus

Some information is common to all CPUs belonging to a policy, but are
kept on per-cpu basis. Lets keep that in another structure common to all
policy->cpus. That will make updates/reads to that less complex and less
error prone.

The memory for ccdbs is allocated/freed at INIT/EXIT, so that it we
don't reallocate it for STOP/START sequence. It will be also be used (in
next patch) while the governor is stopped and so must not be freed that
early.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_conservative.c | 18 ++++---
 drivers/cpufreq/cpufreq_governor.c     | 92 +++++++++++++++++++++++++---------
 drivers/cpufreq/cpufreq_governor.h     | 24 +++++----
 drivers/cpufreq/cpufreq_ondemand.c     | 38 +++++++-------
 4 files changed, 114 insertions(+), 58 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index af47d322679e..5b5c01ca556c 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -47,7 +47,7 @@ static inline unsigned int get_freq_target(struct cs_dbs_tuners *cs_tuners,
 static void cs_check_cpu(int cpu, unsigned int load)
 {
 	struct cs_cpu_dbs_info_s *dbs_info = &per_cpu(cs_cpu_dbs_info, cpu);
-	struct cpufreq_policy *policy = dbs_info->cdbs.policy;
+	struct cpufreq_policy *policy = dbs_info->cdbs.ccdbs->policy;
 	struct dbs_data *dbs_data = policy->governor_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
@@ -106,22 +106,24 @@ static void cs_dbs_timer(struct work_struct *work)
 {
 	struct cs_cpu_dbs_info_s *dbs_info = container_of(work,
 			struct cs_cpu_dbs_info_s, cdbs.dwork.work);
-	unsigned int cpu = dbs_info->cdbs.policy->cpu;
+	struct cpufreq_policy *policy = dbs_info->cdbs.ccdbs->policy;
+	unsigned int cpu = policy->cpu;
 	struct cs_cpu_dbs_info_s *core_dbs_info = &per_cpu(cs_cpu_dbs_info,
 			cpu);
-	struct dbs_data *dbs_data = dbs_info->cdbs.policy->governor_data;
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 	int delay = delay_for_sampling_rate(cs_tuners->sampling_rate);
 	bool modify_all = true;
 
-	mutex_lock(&core_dbs_info->cdbs.timer_mutex);
-	if (!need_load_eval(&core_dbs_info->cdbs, cs_tuners->sampling_rate))
+	mutex_lock(&core_dbs_info->cdbs.ccdbs->timer_mutex);
+	if (!need_load_eval(core_dbs_info->cdbs.ccdbs,
+			    cs_tuners->sampling_rate))
 		modify_all = false;
 	else
 		dbs_check_cpu(dbs_data, cpu);
 
-	gov_queue_work(dbs_data, dbs_info->cdbs.policy, delay, modify_all);
-	mutex_unlock(&core_dbs_info->cdbs.timer_mutex);
+	gov_queue_work(dbs_data, policy, delay, modify_all);
+	mutex_unlock(&core_dbs_info->cdbs.ccdbs->timer_mutex);
 }
 
 static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
@@ -135,7 +137,7 @@ static int dbs_cpufreq_notifier(struct notifier_block *nb, unsigned long val,
 	if (!dbs_info->enable)
 		return 0;
 
-	policy = dbs_info->cdbs.policy;
+	policy = dbs_info->cdbs.ccdbs->policy;
 
 	/*
 	 * we only care if our internally tracked freq moves outside the 'valid'
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index c0566f86caed..72a92fa71ba5 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -35,7 +35,7 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 	struct cpu_dbs_info *cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
-	struct cpufreq_policy *policy;
+	struct cpufreq_policy *policy = cdbs->ccdbs->policy;
 	unsigned int sampling_rate;
 	unsigned int max_load = 0;
 	unsigned int ignore_nice;
@@ -60,8 +60,6 @@ void dbs_check_cpu(struct dbs_data *dbs_data, int cpu)
 		ignore_nice = cs_tuners->ignore_nice_load;
 	}
 
-	policy = cdbs->policy;
-
 	/* Get Absolute Load */
 	for_each_cpu(j, policy->cpus) {
 		struct cpu_dbs_info *j_cdbs;
@@ -209,17 +207,18 @@ static inline void gov_cancel_work(struct dbs_data *dbs_data,
 }
 
 /* Will return if we need to evaluate cpu load again or not */
-bool need_load_eval(struct cpu_dbs_info *cdbs, unsigned int sampling_rate)
+bool need_load_eval(struct cpu_common_dbs_info *ccdbs,
+		    unsigned int sampling_rate)
 {
-	if (policy_is_shared(cdbs->policy)) {
+	if (policy_is_shared(ccdbs->policy)) {
 		ktime_t time_now = ktime_get();
-		s64 delta_us = ktime_us_delta(time_now, cdbs->time_stamp);
+		s64 delta_us = ktime_us_delta(time_now, ccdbs->time_stamp);
 
 		/* Do nothing if we recently have sampled */
 		if (delta_us < (s64)(sampling_rate / 2))
 			return false;
 		else
-			cdbs->time_stamp = time_now;
+			ccdbs->time_stamp = time_now;
 	}
 
 	return true;
@@ -238,6 +237,37 @@ static void set_sampling_rate(struct dbs_data *dbs_data,
 	}
 }
 
+static int alloc_ccdbs(struct cpufreq_policy *policy,
+		       struct common_dbs_data *cdata)
+{
+	struct cpu_common_dbs_info *ccdbs;
+	int j;
+
+	/* Allocate memory for the common information for policy->cpus */
+	ccdbs = kzalloc(sizeof(*ccdbs), GFP_KERNEL);
+	if (!ccdbs)
+		return -ENOMEM;
+
+	/* Set ccdbs for all CPUs, online+offline */
+	for_each_cpu(j, policy->related_cpus)
+		cdata->get_cpu_cdbs(j)->ccdbs = ccdbs;
+
+	return 0;
+}
+
+static void free_ccdbs(struct cpufreq_policy *policy,
+		       struct common_dbs_data *cdata)
+{
+	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(policy->cpu);
+	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
+	int j;
+
+	for_each_cpu(j, policy->cpus)
+		cdata->get_cpu_cdbs(j)->ccdbs = NULL;
+
+	kfree(ccdbs);
+}
+
 static int cpufreq_governor_init(struct cpufreq_policy *policy,
 				 struct dbs_data *dbs_data,
 				 struct common_dbs_data *cdata)
@@ -248,6 +278,11 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 	if (dbs_data) {
 		if (WARN_ON(have_governor_per_policy()))
 			return -EINVAL;
+
+		ret = alloc_ccdbs(policy, cdata);
+		if (ret)
+			return ret;
+
 		dbs_data->usage_count++;
 		policy->governor_data = dbs_data;
 		return 0;
@@ -257,12 +292,16 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 	if (!dbs_data)
 		return -ENOMEM;
 
+	ret = alloc_ccdbs(policy, cdata);
+	if (ret)
+		goto free_dbs_data;
+
 	dbs_data->cdata = cdata;
 	dbs_data->usage_count = 1;
 
 	ret = cdata->init(dbs_data, !policy->governor->initialized);
 	if (ret)
-		goto free_dbs_data;
+		goto free_ccdbs;
 
 	/* policy latency is in ns. Convert it to us first */
 	latency = policy->cpuinfo.transition_latency / 1000;
@@ -299,6 +338,8 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy,
 	}
 cdata_exit:
 	cdata->exit(dbs_data, !policy->governor->initialized);
+free_ccdbs:
+	free_ccdbs(policy, cdata);
 free_dbs_data:
 	kfree(dbs_data);
 	return ret;
@@ -322,6 +363,8 @@ static void cpufreq_governor_exit(struct cpufreq_policy *policy,
 		cdata->exit(dbs_data, policy->governor->initialized == 1);
 		kfree(dbs_data);
 	}
+
+	free_ccdbs(policy, cdata);
 }
 
 static int cpufreq_governor_start(struct cpufreq_policy *policy,
@@ -330,6 +373,7 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
 	int io_busy = 0;
 
 	if (!policy->cur)
@@ -348,11 +392,14 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		io_busy = od_tuners->io_is_busy;
 	}
 
+	ccdbs->policy = policy;
+	ccdbs->time_stamp = ktime_get();
+	mutex_init(&ccdbs->timer_mutex);
+
 	for_each_cpu(j, policy->cpus) {
 		struct cpu_dbs_info *j_cdbs = cdata->get_cpu_cdbs(j);
 		unsigned int prev_load;
 
-		j_cdbs->policy = policy;
 		j_cdbs->prev_cpu_idle =
 			get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall, io_busy);
 
@@ -364,7 +411,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		if (ignore_nice)
 			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 
-		mutex_init(&j_cdbs->timer_mutex);
 		INIT_DEFERRABLE_WORK(&j_cdbs->dwork, cdata->gov_dbs_timer);
 	}
 
@@ -384,9 +430,6 @@ static int cpufreq_governor_start(struct cpufreq_policy *policy,
 		od_ops->powersave_bias_init_cpu(cpu);
 	}
 
-	/* Initiate timer time stamp */
-	cdbs->time_stamp = ktime_get();
-
 	gov_queue_work(dbs_data, policy, delay_for_sampling_rate(sampling_rate),
 		       true);
 	return 0;
@@ -398,6 +441,9 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 	struct common_dbs_data *cdata = dbs_data->cdata;
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
+	struct cpu_common_dbs_info *ccdbs = cdbs->ccdbs;
+
+	gov_cancel_work(dbs_data, policy);
 
 	if (cdata->governor == GOV_CONSERVATIVE) {
 		struct cs_cpu_dbs_info_s *cs_dbs_info =
@@ -406,10 +452,8 @@ static void cpufreq_governor_stop(struct cpufreq_policy *policy,
 		cs_dbs_info->enable = 0;
 	}
 
-	gov_cancel_work(dbs_data, policy);
-
-	mutex_destroy(&cdbs->timer_mutex);
-	cdbs->policy = NULL;
+	ccdbs->policy = NULL;
+	mutex_destroy(&ccdbs->timer_mutex);
 }
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy,
@@ -419,18 +463,18 @@ static void cpufreq_governor_limits(struct cpufreq_policy *policy,
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info *cdbs = cdata->get_cpu_cdbs(cpu);
 
-	if (!cdbs->policy)
+	if (!cdbs->ccdbs || !cdbs->ccdbs->policy)
 		return;
 
-	mutex_lock(&cdbs->timer_mutex);
-	if (policy->max < cdbs->policy->cur)
-		__cpufreq_driver_target(cdbs->policy, policy->max,
+	mutex_lock(&cdbs->ccdbs->timer_mutex);
+	if (policy->max < cdbs->ccdbs->policy->cur)
+		__cpufreq_driver_target(cdbs->ccdbs->policy, policy->max,
 					CPUFREQ_RELATION_H);
-	else if (policy->min > cdbs->policy->cur)
-		__cpufreq_driver_target(cdbs->policy, policy->min,
+	else if (policy->min > cdbs->ccdbs->policy->cur)
+		__cpufreq_driver_target(cdbs->ccdbs->policy, policy->min,
 					CPUFREQ_RELATION_L);
 	dbs_check_cpu(dbs_data, cpu);
-	mutex_unlock(&cdbs->timer_mutex);
+	mutex_unlock(&cdbs->ccdbs->timer_mutex);
 }
 
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index a0f8eb79ee6d..153412cafb05 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -128,6 +128,18 @@ static void *get_cpu_dbs_info_s(int cpu)				\
  * cs_*: Conservative governor
  */
 
+/* Common to all CPUs of a policy */
+struct cpu_common_dbs_info {
+	struct cpufreq_policy *policy;
+	/*
+	 * percpu mutex that serializes governor limit change with gov_dbs_timer
+	 * invocation. We do not want gov_dbs_timer to run when user is changing
+	 * the governor or limits.
+	 */
+	struct mutex timer_mutex;
+	ktime_t time_stamp;
+};
+
 /* Per cpu structures */
 struct cpu_dbs_info {
 	u64 prev_cpu_idle;
@@ -140,15 +152,8 @@ struct cpu_dbs_info {
 	 * wake-up from idle.
 	 */
 	unsigned int prev_load;
-	struct cpufreq_policy *policy;
 	struct delayed_work dwork;
-	/*
-	 * percpu mutex that serializes governor limit change with gov_dbs_timer
-	 * invocation. We do not want gov_dbs_timer to run when user is changing
-	 * the governor or limits.
-	 */
-	struct mutex timer_mutex;
-	ktime_t time_stamp;
+	struct cpu_common_dbs_info *ccdbs;
 };
 
 struct od_cpu_dbs_info_s {
@@ -264,7 +269,8 @@ static ssize_t show_sampling_rate_min_gov_pol				\
 extern struct mutex cpufreq_governor_lock;
 
 void dbs_check_cpu(struct dbs_data *dbs_data, int cpu);
-bool need_load_eval(struct cpu_dbs_info *cdbs, unsigned int sampling_rate);
+bool need_load_eval(struct cpu_common_dbs_info *ccdbs,
+		    unsigned int sampling_rate);
 int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 		struct common_dbs_data *cdata, unsigned int event);
 void gov_queue_work(struct dbs_data *dbs_data, struct cpufreq_policy *policy,
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index d29c6f9c6e3e..651677cfa581 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -155,7 +155,7 @@ static void dbs_freq_increase(struct cpufreq_policy *policy, unsigned int freq)
 static void od_check_cpu(int cpu, unsigned int load)
 {
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
-	struct cpufreq_policy *policy = dbs_info->cdbs.policy;
+	struct cpufreq_policy *policy = dbs_info->cdbs.ccdbs->policy;
 	struct dbs_data *dbs_data = policy->governor_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 
@@ -195,16 +195,18 @@ static void od_dbs_timer(struct work_struct *work)
 {
 	struct od_cpu_dbs_info_s *dbs_info =
 		container_of(work, struct od_cpu_dbs_info_s, cdbs.dwork.work);
-	unsigned int cpu = dbs_info->cdbs.policy->cpu;
+	struct cpufreq_policy *policy = dbs_info->cdbs.ccdbs->policy;
+	unsigned int cpu = policy->cpu;
 	struct od_cpu_dbs_info_s *core_dbs_info = &per_cpu(od_cpu_dbs_info,
 			cpu);
-	struct dbs_data *dbs_data = dbs_info->cdbs.policy->governor_data;
+	struct dbs_data *dbs_data = policy->governor_data;
 	struct od_dbs_tuners *od_tuners = dbs_data->tuners;
 	int delay = 0, sample_type = core_dbs_info->sample_type;
 	bool modify_all = true;
 
-	mutex_lock(&core_dbs_info->cdbs.timer_mutex);
-	if (!need_load_eval(&core_dbs_info->cdbs, od_tuners->sampling_rate)) {
+	mutex_lock(&core_dbs_info->cdbs.ccdbs->timer_mutex);
+	if (!need_load_eval(core_dbs_info->cdbs.ccdbs,
+			    od_tuners->sampling_rate)) {
 		modify_all = false;
 		goto max_delay;
 	}
@@ -213,8 +215,7 @@ static void od_dbs_timer(struct work_struct *work)
 	core_dbs_info->sample_type = OD_NORMAL_SAMPLE;
 	if (sample_type == OD_SUB_SAMPLE) {
 		delay = core_dbs_info->freq_lo_jiffies;
-		__cpufreq_driver_target(core_dbs_info->cdbs.policy,
-					core_dbs_info->freq_lo,
+		__cpufreq_driver_target(policy, core_dbs_info->freq_lo,
 					CPUFREQ_RELATION_H);
 	} else {
 		dbs_check_cpu(dbs_data, cpu);
@@ -230,8 +231,8 @@ static void od_dbs_timer(struct work_struct *work)
 		delay = delay_for_sampling_rate(od_tuners->sampling_rate
 				* core_dbs_info->rate_mult);
 
-	gov_queue_work(dbs_data, dbs_info->cdbs.policy, delay, modify_all);
-	mutex_unlock(&core_dbs_info->cdbs.timer_mutex);
+	gov_queue_work(dbs_data, policy, delay, modify_all);
+	mutex_unlock(&core_dbs_info->cdbs.ccdbs->timer_mutex);
 }
 
 /************************** sysfs interface ************************/
@@ -274,10 +275,10 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 		dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 		cpufreq_cpu_put(policy);
 
-		mutex_lock(&dbs_info->cdbs.timer_mutex);
+		mutex_lock(&dbs_info->cdbs.ccdbs->timer_mutex);
 
 		if (!delayed_work_pending(&dbs_info->cdbs.dwork)) {
-			mutex_unlock(&dbs_info->cdbs.timer_mutex);
+			mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
 			continue;
 		}
 
@@ -286,15 +287,15 @@ static void update_sampling_rate(struct dbs_data *dbs_data,
 
 		if (time_before(next_sampling, appointed_at)) {
 
-			mutex_unlock(&dbs_info->cdbs.timer_mutex);
+			mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
 			cancel_delayed_work_sync(&dbs_info->cdbs.dwork);
-			mutex_lock(&dbs_info->cdbs.timer_mutex);
+			mutex_lock(&dbs_info->cdbs.ccdbs->timer_mutex);
 
-			gov_queue_work(dbs_data, dbs_info->cdbs.policy,
+			gov_queue_work(dbs_data, policy,
 				       usecs_to_jiffies(new_rate), true);
 
 		}
-		mutex_unlock(&dbs_info->cdbs.timer_mutex);
+		mutex_unlock(&dbs_info->cdbs.ccdbs->timer_mutex);
 	}
 }
 
@@ -557,13 +558,16 @@ static void od_set_powersave_bias(unsigned int powersave_bias)
 
 	get_online_cpus();
 	for_each_online_cpu(cpu) {
+		struct cpu_common_dbs_info *ccdbs;
+
 		if (cpumask_test_cpu(cpu, &done))
 			continue;
 
-		policy = per_cpu(od_cpu_dbs_info, cpu).cdbs.policy;
-		if (!policy)
+		ccdbs = per_cpu(od_cpu_dbs_info, cpu).cdbs.ccdbs;
+		if (!ccdbs)
 			continue;
 
+		policy = ccdbs->policy;
 		cpumask_or(&done, &done, policy->cpus);
 
 		if (policy->governor != &cpufreq_gov_ondemand)

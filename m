From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/3] cpufreq: governor: split cpufreq_governor_dbs()
Date: Thu,  4 Jun 2015 16:43:27 +0530
Message-ID: <875e7e0f1b1f1f9d60f307fb55211df80294d766.1433416191.git.viresh.kumar@linaro.org>
References: <6880bd7b6e6e7968f008d6328ab15353d99ccd57.1433326032.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35484 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbbFDLNi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 07:13:38 -0400
Received: by pdbnf5 with SMTP id nf5so28928062pdb.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2015 04:13:38 -0700 (PDT)
In-Reply-To: <6880bd7b6e6e7968f008d6328ab15353d99ccd57.1433326032.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_governor_dbs() is hardly readable, it is just too big and
complicated. Lets make it more readable by splitting out event specific
routines.

Order of statements is changed at few places, but that shouldn't bring
any functional change.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2: Return errors after hitting WARN_ON. (Preeti)

 drivers/cpufreq/cpufreq_governor.c | 329 +++++++++++++++++++++----------------
 1 file changed, 189 insertions(+), 140 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index d64a82e6481a..ccf6ce7e5983 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -239,195 +239,244 @@ static void set_sampling_rate(struct dbs_data *dbs_data,
 	}
 }
 
-int cpufreq_governor_dbs(struct cpufreq_policy *policy,
-		struct common_dbs_data *cdata, unsigned int event)
+static int cpufreq_governor_init(struct cpufreq_policy *policy,
+				 struct dbs_data *dbs_data,
+				 struct common_dbs_data *cdata)
 {
-	struct dbs_data *dbs_data;
-	struct od_cpu_dbs_info_s *od_dbs_info = NULL;
-	struct cs_cpu_dbs_info_s *cs_dbs_info = NULL;
-	struct od_ops *od_ops = NULL;
-	struct od_dbs_tuners *od_tuners = NULL;
-	struct cs_dbs_tuners *cs_tuners = NULL;
-	struct cpu_dbs_common_info *cpu_cdbs;
-	unsigned int sampling_rate, latency, ignore_nice, j, cpu = policy->cpu;
-	int io_busy = 0;
-	int rc;
+	unsigned int latency;
+	int ret;
 
-	if (have_governor_per_policy())
-		dbs_data = policy->governor_data;
-	else
-		dbs_data = cdata->gdbs_data;
+	if (dbs_data) {
+		if (WARN_ON(have_governor_per_policy()))
+			return -EINVAL;
+		dbs_data->usage_count++;
+		policy->governor_data = dbs_data;
+		return 0;
+	}
 
-	WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT));
+	dbs_data = kzalloc(sizeof(*dbs_data), GFP_KERNEL);
+	if (!dbs_data)
+		return -ENOMEM;
 
-	switch (event) {
-	case CPUFREQ_GOV_POLICY_INIT:
-		if (have_governor_per_policy()) {
-			WARN_ON(dbs_data);
-		} else if (dbs_data) {
-			dbs_data->usage_count++;
-			policy->governor_data = dbs_data;
-			return 0;
-		}
+	dbs_data->cdata = cdata;
+	dbs_data->usage_count = 1;
 
-		dbs_data = kzalloc(sizeof(*dbs_data), GFP_KERNEL);
-		if (!dbs_data) {
-			pr_err("%s: POLICY_INIT: kzalloc failed\n", __func__);
-			return -ENOMEM;
-		}
+	ret = cdata->init(dbs_data, !policy->governor->initialized);
+	if (ret)
+		goto free_dbs_data;
 
-		dbs_data->cdata = cdata;
-		dbs_data->usage_count = 1;
-		rc = cdata->init(dbs_data, !policy->governor->initialized);
-		if (rc) {
-			pr_err("%s: POLICY_INIT: init() failed\n", __func__);
-			kfree(dbs_data);
-			return rc;
-		}
+	/* policy latency is in ns. Convert it to us first */
+	latency = policy->cpuinfo.transition_latency / 1000;
+	if (latency == 0)
+		latency = 1;
 
-		if (!have_governor_per_policy())
-			WARN_ON(cpufreq_get_global_kobject());
+	/* Bring kernel and HW constraints together */
+	dbs_data->min_sampling_rate = max(dbs_data->min_sampling_rate,
+					  MIN_LATENCY_MULTIPLIER * latency);
+	set_sampling_rate(dbs_data, max(dbs_data->min_sampling_rate,
+					latency * LATENCY_MULTIPLIER));
 
-		rc = sysfs_create_group(get_governor_parent_kobj(policy),
-				get_sysfs_attr(dbs_data));
-		if (rc) {
-			cdata->exit(dbs_data, !policy->governor->initialized);
-			kfree(dbs_data);
-			return rc;
+	if (!have_governor_per_policy()) {
+		if (WARN_ON(cpufreq_get_global_kobject())) {
+			ret = -EINVAL;
+			goto cdata_exit;
 		}
+		cdata->gdbs_data = dbs_data;
+	}
 
-		policy->governor_data = dbs_data;
+	ret = sysfs_create_group(get_governor_parent_kobj(policy),
+				 get_sysfs_attr(dbs_data));
+	if (ret)
+		goto put_kobj;
 
-		/* policy latency is in ns. Convert it to us first */
-		latency = policy->cpuinfo.transition_latency / 1000;
-		if (latency == 0)
-			latency = 1;
+	policy->governor_data = dbs_data;
 
-		/* Bring kernel and HW constraints together */
-		dbs_data->min_sampling_rate = max(dbs_data->min_sampling_rate,
-				MIN_LATENCY_MULTIPLIER * latency);
-		set_sampling_rate(dbs_data, max(dbs_data->min_sampling_rate,
-					latency * LATENCY_MULTIPLIER));
+	return 0;
 
-		if (!have_governor_per_policy())
-			cdata->gdbs_data = dbs_data;
+put_kobj:
+	if (!have_governor_per_policy()) {
+		cdata->gdbs_data = NULL;
+		cpufreq_put_global_kobject();
+	}
+cdata_exit:
+	cdata->exit(dbs_data, !policy->governor->initialized);
+free_dbs_data:
+	kfree(dbs_data);
+	return ret;
+}
 
-		return 0;
-	case CPUFREQ_GOV_POLICY_EXIT:
-		if (!--dbs_data->usage_count) {
-			sysfs_remove_group(get_governor_parent_kobj(policy),
-					get_sysfs_attr(dbs_data));
+static void cpufreq_governor_exit(struct cpufreq_policy *policy,
+				  struct dbs_data *dbs_data)
+{
+	struct common_dbs_data *cdata = dbs_data->cdata;
 
-			if (!have_governor_per_policy())
-				cpufreq_put_global_kobject();
+	policy->governor_data = NULL;
+	if (!--dbs_data->usage_count) {
+		sysfs_remove_group(get_governor_parent_kobj(policy),
+				   get_sysfs_attr(dbs_data));
 
-			cdata->exit(dbs_data, policy->governor->initialized == 1);
-			kfree(dbs_data);
+		if (!have_governor_per_policy()) {
 			cdata->gdbs_data = NULL;
+			cpufreq_put_global_kobject();
 		}
 
-		policy->governor_data = NULL;
-		return 0;
+		cdata->exit(dbs_data, policy->governor->initialized == 1);
+		kfree(dbs_data);
 	}
+}
 
-	cpu_cdbs = dbs_data->cdata->get_cpu_cdbs(cpu);
+static int cpufreq_governor_start(struct cpufreq_policy *policy,
+				  struct dbs_data *dbs_data)
+{
+	struct common_dbs_data *cdata = dbs_data->cdata;
+	unsigned int sampling_rate, ignore_nice, j, cpu = policy->cpu;
+	struct cpu_dbs_common_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
+	int io_busy = 0;
+
+	if (!policy->cur)
+		return -EINVAL;
+
+	if (cdata->governor == GOV_CONSERVATIVE) {
+		struct cs_dbs_tuners *cs_tuners = dbs_data->tuners;
 
-	if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
-		cs_tuners = dbs_data->tuners;
-		cs_dbs_info = dbs_data->cdata->get_cpu_dbs_info_s(cpu);
 		sampling_rate = cs_tuners->sampling_rate;
 		ignore_nice = cs_tuners->ignore_nice_load;
 	} else {
-		od_tuners = dbs_data->tuners;
-		od_dbs_info = dbs_data->cdata->get_cpu_dbs_info_s(cpu);
+		struct od_dbs_tuners *od_tuners = dbs_data->tuners;
+
 		sampling_rate = od_tuners->sampling_rate;
 		ignore_nice = od_tuners->ignore_nice_load;
-		od_ops = dbs_data->cdata->gov_ops;
 		io_busy = od_tuners->io_is_busy;
 	}
 
-	switch (event) {
-	case CPUFREQ_GOV_START:
-		if (!policy->cur)
-			return -EINVAL;
+	mutex_lock(&dbs_data->mutex);
 
-		mutex_lock(&dbs_data->mutex);
+	for_each_cpu(j, policy->cpus) {
+		struct cpu_dbs_common_info *j_cdbs = cdata->get_cpu_cdbs(j);
+		unsigned int prev_load;
 
-		for_each_cpu(j, policy->cpus) {
-			struct cpu_dbs_common_info *j_cdbs =
-				dbs_data->cdata->get_cpu_cdbs(j);
-			unsigned int prev_load;
+		j_cdbs->cpu = j;
+		j_cdbs->cur_policy = policy;
+		j_cdbs->prev_cpu_idle =
+			get_cpu_idle_time(j, &j_cdbs->prev_cpu_wall, io_busy);
 
-			j_cdbs->cpu = j;
-			j_cdbs->cur_policy = policy;
-			j_cdbs->prev_cpu_idle = get_cpu_idle_time(j,
-					       &j_cdbs->prev_cpu_wall, io_busy);
+		prev_load = (unsigned int)(j_cdbs->prev_cpu_wall -
+					    j_cdbs->prev_cpu_idle);
+		j_cdbs->prev_load = 100 * prev_load /
+				    (unsigned int)j_cdbs->prev_cpu_wall;
 
-			prev_load = (unsigned int)
-				(j_cdbs->prev_cpu_wall - j_cdbs->prev_cpu_idle);
-			j_cdbs->prev_load = 100 * prev_load /
-					(unsigned int) j_cdbs->prev_cpu_wall;
+		if (ignore_nice)
+			j_cdbs->prev_cpu_nice = kcpustat_cpu(j).cpustat[CPUTIME_NICE];
 
-			if (ignore_nice)
-				j_cdbs->prev_cpu_nice =
-					kcpustat_cpu(j).cpustat[CPUTIME_NICE];
+		mutex_init(&j_cdbs->timer_mutex);
+		INIT_DEFERRABLE_WORK(&j_cdbs->work, cdata->gov_dbs_timer);
+	}
 
-			mutex_init(&j_cdbs->timer_mutex);
-			INIT_DEFERRABLE_WORK(&j_cdbs->work,
-					     dbs_data->cdata->gov_dbs_timer);
-		}
+	if (cdata->governor == GOV_CONSERVATIVE) {
+		struct cs_cpu_dbs_info_s *cs_dbs_info =
+			cdata->get_cpu_dbs_info_s(cpu);
 
-		if (dbs_data->cdata->governor == GOV_CONSERVATIVE) {
-			cs_dbs_info->down_skip = 0;
-			cs_dbs_info->enable = 1;
-			cs_dbs_info->requested_freq = policy->cur;
-		} else {
-			od_dbs_info->rate_mult = 1;
-			od_dbs_info->sample_type = OD_NORMAL_SAMPLE;
-			od_ops->powersave_bias_init_cpu(cpu);
-		}
+		cs_dbs_info->down_skip = 0;
+		cs_dbs_info->enable = 1;
+		cs_dbs_info->requested_freq = policy->cur;
+	} else {
+		struct od_ops *od_ops = cdata->gov_ops;
+		struct od_cpu_dbs_info_s *od_dbs_info = cdata->get_cpu_dbs_info_s(cpu);
 
-		mutex_unlock(&dbs_data->mutex);
+		od_dbs_info->rate_mult = 1;
+		od_dbs_info->sample_type = OD_NORMAL_SAMPLE;
+		od_ops->powersave_bias_init_cpu(cpu);
+	}
 
-		/* Initiate timer time stamp */
-		cpu_cdbs->time_stamp = ktime_get();
+	mutex_unlock(&dbs_data->mutex);
 
-		gov_queue_work(dbs_data, policy,
-				delay_for_sampling_rate(sampling_rate), true);
-		break;
+	/* Initiate timer time stamp */
+	cpu_cdbs->time_stamp = ktime_get();
 
-	case CPUFREQ_GOV_STOP:
-		if (dbs_data->cdata->governor == GOV_CONSERVATIVE)
-			cs_dbs_info->enable = 0;
+	gov_queue_work(dbs_data, policy, delay_for_sampling_rate(sampling_rate),
+		       true);
+	return 0;
+}
+
+static void cpufreq_governor_stop(struct cpufreq_policy *policy,
+				  struct dbs_data *dbs_data)
+{
+	struct common_dbs_data *cdata = dbs_data->cdata;
+	unsigned int cpu = policy->cpu;
+	struct cpu_dbs_common_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
+
+	if (cdata->governor == GOV_CONSERVATIVE) {
+		struct cs_cpu_dbs_info_s *cs_dbs_info =
+			cdata->get_cpu_dbs_info_s(cpu);
 
-		gov_cancel_work(dbs_data, policy);
+		cs_dbs_info->enable = 0;
+	}
+
+	gov_cancel_work(dbs_data, policy);
+
+	mutex_lock(&dbs_data->mutex);
+	mutex_destroy(&cpu_cdbs->timer_mutex);
+	cpu_cdbs->cur_policy = NULL;
+	mutex_unlock(&dbs_data->mutex);
+}
 
-		mutex_lock(&dbs_data->mutex);
-		mutex_destroy(&cpu_cdbs->timer_mutex);
-		cpu_cdbs->cur_policy = NULL;
+static void cpufreq_governor_limits(struct cpufreq_policy *policy,
+				    struct dbs_data *dbs_data)
+{
+	struct common_dbs_data *cdata = dbs_data->cdata;
+	unsigned int cpu = policy->cpu;
+	struct cpu_dbs_common_info *cpu_cdbs = cdata->get_cpu_cdbs(cpu);
 
+	mutex_lock(&dbs_data->mutex);
+	if (!cpu_cdbs->cur_policy) {
 		mutex_unlock(&dbs_data->mutex);
+		return;
+	}
 
-		break;
+	mutex_lock(&cpu_cdbs->timer_mutex);
+	if (policy->max < cpu_cdbs->cur_policy->cur)
+		__cpufreq_driver_target(cpu_cdbs->cur_policy, policy->max,
+					CPUFREQ_RELATION_H);
+	else if (policy->min > cpu_cdbs->cur_policy->cur)
+		__cpufreq_driver_target(cpu_cdbs->cur_policy, policy->min,
+					CPUFREQ_RELATION_L);
+	dbs_check_cpu(dbs_data, cpu);
+	mutex_unlock(&cpu_cdbs->timer_mutex);
+
+	mutex_unlock(&dbs_data->mutex);
+}
 
+int cpufreq_governor_dbs(struct cpufreq_policy *policy,
+			 struct common_dbs_data *cdata, unsigned int event)
+{
+	struct dbs_data *dbs_data;
+	int ret = 0;
+
+	if (have_governor_per_policy())
+		dbs_data = policy->governor_data;
+	else
+		dbs_data = cdata->gdbs_data;
+
+	WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT));
+
+	switch (event) {
+	case CPUFREQ_GOV_POLICY_INIT:
+		ret = cpufreq_governor_init(policy, dbs_data, cdata);
+		break;
+	case CPUFREQ_GOV_POLICY_EXIT:
+		cpufreq_governor_exit(policy, dbs_data);
+		break;
+	case CPUFREQ_GOV_START:
+		ret = cpufreq_governor_start(policy, dbs_data);
+		break;
+	case CPUFREQ_GOV_STOP:
+		cpufreq_governor_stop(policy, dbs_data);
+		break;
 	case CPUFREQ_GOV_LIMITS:
-		mutex_lock(&dbs_data->mutex);
-		if (!cpu_cdbs->cur_policy) {
-			mutex_unlock(&dbs_data->mutex);
-			break;
-		}
-		mutex_lock(&cpu_cdbs->timer_mutex);
-		if (policy->max < cpu_cdbs->cur_policy->cur)
-			__cpufreq_driver_target(cpu_cdbs->cur_policy,
-					policy->max, CPUFREQ_RELATION_H);
-		else if (policy->min > cpu_cdbs->cur_policy->cur)
-			__cpufreq_driver_target(cpu_cdbs->cur_policy,
-					policy->min, CPUFREQ_RELATION_L);
-		dbs_check_cpu(dbs_data, cpu);
-		mutex_unlock(&cpu_cdbs->timer_mutex);
-		mutex_unlock(&dbs_data->mutex);
+		cpufreq_governor_limits(policy, dbs_data);
 		break;
 	}
-	return 0;
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(cpufreq_governor_dbs);
-- 
2.4.0


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 11/17] thermal: cpu_cooling: get rid of 'allowed_cpus'
Date: Wed, 19 Apr 2017 10:59:06 +0530
Message-ID: <4da549d2565a75420633850b6963fe50b3f02bad.1492579345.git.viresh.kumar@linaro.org>
References: <cover.1492579345.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34550 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759928AbdDSFbM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 01:31:12 -0400
Received: by mail-pf0-f170.google.com with SMTP id c198so6999066pfc.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2017 22:31:12 -0700 (PDT)
In-Reply-To: <cover.1492579345.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492579345.git.viresh.kumar@linaro.org>
References: <cover.1492579345.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

'allowed_cpus' is a copy of policy->related_cpus and can be replaced by
it directly. At some places we are only concerned about online CPUs and
policy->cpus can be used there.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 77 ++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 56 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ce387f62c93e..1097162f7f8a 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -74,7 +74,6 @@ struct power_table {
  *	frequency.
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
- * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
  * @node: list_head to link all cpufreq_cooling_device together.
  * @last_load: load measured by the latest call to cpufreq_get_requested_power()
  * @time_in_idle: previous reading of the absolute time that this cpu was idle
@@ -97,7 +96,6 @@ struct cpufreq_cooling_device {
 	unsigned int clipped_freq;
 	unsigned int max_level;
 	unsigned int *freq_table;	/* In descending order */
-	struct cpumask allowed_cpus;
 	struct list_head node;
 	u32 last_load;
 	u64 *time_in_idle;
@@ -161,7 +159,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 
 	mutex_lock(&cooling_list_lock);
 	list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
-		if (!cpumask_test_cpu(policy->cpu, &cpufreq_cdev->allowed_cpus))
+		if (policy != cpufreq_cdev->policy)
 			continue;
 
 		/*
@@ -304,7 +302,7 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
  * get_load() - get load for a cpu since last updated
  * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
  * @cpu:	cpu number
- * @cpu_idx:	index of the cpu in cpufreq_cdev->allowed_cpus
+ * @cpu_idx:	index of the cpu in time_in_idle*
  *
  * Return: The average load of cpu @cpu in percentage since this
  * function was last called.
@@ -351,7 +349,7 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_cdev,
 {
 	struct dev_pm_opp *opp;
 	unsigned long voltage;
-	struct cpumask *cpumask = &cpufreq_cdev->allowed_cpus;
+	struct cpumask *cpumask = cpufreq_cdev->policy->related_cpus;
 	unsigned long freq_hz = freq * 1000;
 
 	if (!cpufreq_cdev->plat_get_static_power || !cpufreq_cdev->cpu_dev) {
@@ -468,7 +466,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	cpufreq_cdev->cpufreq_state = state;
 	cpufreq_cdev->clipped_freq = clip_freq;
 
-	cpufreq_update_policy(cpumask_any(&cpufreq_cdev->allowed_cpus));
+	cpufreq_update_policy(cpufreq_cdev->policy->cpu);
 
 	return 0;
 }
@@ -504,28 +502,18 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	int i = 0, cpu, ret;
 	u32 static_power, dynamic_power, total_load = 0;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	struct cpufreq_policy *policy = cpufreq_cdev->policy;
 	u32 *load_cpu = NULL;
 
-	cpu = cpumask_any_and(&cpufreq_cdev->allowed_cpus, cpu_online_mask);
-
-	/*
-	 * All the CPUs are offline, thus the requested power by
-	 * the cdev is 0
-	 */
-	if (cpu >= nr_cpu_ids) {
-		*power = 0;
-		return 0;
-	}
-
-	freq = cpufreq_quick_get(cpu);
+	freq = cpufreq_quick_get(policy->cpu);
 
 	if (trace_thermal_power_cpu_get_power_enabled()) {
-		u32 ncpus = cpumask_weight(&cpufreq_cdev->allowed_cpus);
+		u32 ncpus = cpumask_weight(policy->related_cpus);
 
 		load_cpu = kcalloc(ncpus, sizeof(*load_cpu), GFP_KERNEL);
 	}
 
-	for_each_cpu(cpu, &cpufreq_cdev->allowed_cpus) {
+	for_each_cpu(cpu, policy->related_cpus) {
 		u32 load;
 
 		if (cpu_online(cpu))
@@ -550,9 +538,9 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	}
 
 	if (load_cpu) {
-		trace_thermal_power_cpu_get_power(
-			&cpufreq_cdev->allowed_cpus,
-			freq, load_cpu, i, dynamic_power, static_power);
+		trace_thermal_power_cpu_get_power(policy->related_cpus, freq,
+						  load_cpu, i, dynamic_power,
+						  static_power);
 
 		kfree(load_cpu);
 	}
@@ -581,38 +569,22 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 			       unsigned long state, u32 *power)
 {
 	unsigned int freq, num_cpus;
-	cpumask_var_t cpumask;
 	u32 static_power, dynamic_power;
 	int ret;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 
-	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
-		return -ENOMEM;
-
-	cpumask_and(cpumask, &cpufreq_cdev->allowed_cpus, cpu_online_mask);
-	num_cpus = cpumask_weight(cpumask);
-
-	/* None of our cpus are online, so no power */
-	if (num_cpus == 0) {
-		*power = 0;
-		ret = 0;
-		goto out;
-	}
+	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
 
 	freq = cpufreq_cdev->freq_table[state];
-	if (!freq) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!freq)
+		return -EINVAL;
 
 	dynamic_power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
 	ret = get_static_power(cpufreq_cdev, tz, freq, &static_power);
 	if (ret)
-		goto out;
+		return ret;
 
 	*power = static_power + dynamic_power;
-out:
-	free_cpumask_var(cpumask);
 	return ret;
 }
 
@@ -640,19 +612,14 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 			       struct thermal_zone_device *tz, u32 power,
 			       unsigned long *state)
 {
-	unsigned int cpu, cur_freq, target_freq;
+	unsigned int cur_freq, target_freq;
 	int ret;
 	s32 dyn_power;
 	u32 last_load, normalised_power, static_power;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	struct cpufreq_policy *policy = cpufreq_cdev->policy;
 
-	cpu = cpumask_any_and(&cpufreq_cdev->allowed_cpus, cpu_online_mask);
-
-	/* None of our cpus are online */
-	if (cpu >= nr_cpu_ids)
-		return -ENODEV;
-
-	cur_freq = cpufreq_quick_get(cpu);
+	cur_freq = cpufreq_quick_get(policy->cpu);
 	ret = get_static_power(cpufreq_cdev, tz, cur_freq, &static_power);
 	if (ret)
 		return ret;
@@ -667,12 +634,12 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	if (*state == THERMAL_CSTATE_INVALID) {
 		dev_err_ratelimited(&cdev->device,
 				    "Failed to convert %dKHz for cpu %d into a cdev state\n",
-				    target_freq, cpu);
+				    target_freq, policy->cpu);
 		return -EINVAL;
 	}
 
-	trace_thermal_power_cpu_limit(&cpufreq_cdev->allowed_cpus,
-				      target_freq, *state, power);
+	trace_thermal_power_cpu_limit(policy->related_cpus, target_freq, *state,
+				      power);
 	return 0;
 }
 
@@ -786,8 +753,6 @@ __cpufreq_cooling_register(struct device_node *np,
 		goto free_time_in_idle_timestamp;
 	}
 
-	cpumask_copy(&cpufreq_cdev->allowed_cpus, policy->related_cpus);
-
 	if (capacitance) {
 		cpufreq_cdev->plat_get_static_power = plat_static_func;
 
-- 
2.12.0.432.g71c3a4f4ba37

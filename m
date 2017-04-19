From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 03/17] thermal: cpu_cooling: Name cpufreq cooling devices as cpufreq_cdev
Date: Wed, 19 Apr 2017 10:58:58 +0530
Message-ID: <323c25bfc9454e54102b0956bae049365f1ba2bb.1492579345.git.viresh.kumar@linaro.org>
References: <cover.1492579345.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33497 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759832AbdDSFap (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Apr 2017 01:30:45 -0400
Received: by mail-pg0-f41.google.com with SMTP id 63so7407818pgh.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Apr 2017 22:30:44 -0700 (PDT)
In-Reply-To: <cover.1492579345.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492579345.git.viresh.kumar@linaro.org>
References: <cover.1492579345.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

Objects of "struct cpufreq_cooling_device" are named a bit
inconsistently. Lets use cpufreq_cdev everywhere. Also note that the
lists containing such devices is renamed similarly too.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 248 +++++++++++++++++++++---------------------
 1 file changed, 124 insertions(+), 124 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ce94aafed25d..80a46a80817b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -108,27 +108,27 @@ struct cpufreq_cooling_device {
 
 static DEFINE_IDA(cpufreq_ida);
 static DEFINE_MUTEX(cooling_list_lock);
-static LIST_HEAD(cpufreq_dev_list);
+static LIST_HEAD(cpufreq_cdev_list);
 
 /* Below code defines functions to be used for cpufreq as cooling device */
 
 /**
  * get_level: Find the level for a particular frequency
- * @cpufreq_dev: cpufreq_dev for which the property is required
+ * @cpufreq_cdev: cpufreq_cdev for which the property is required
  * @freq: Frequency
  *
  * Return: level on success, THERMAL_CSTATE_INVALID on error.
  */
-static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_dev,
+static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 			       unsigned int freq)
 {
 	unsigned long level;
 
-	for (level = 0; level <= cpufreq_dev->max_level; level++) {
-		if (freq == cpufreq_dev->freq_table[level])
+	for (level = 0; level <= cpufreq_cdev->max_level; level++) {
+		if (freq == cpufreq_cdev->freq_table[level])
 			return level;
 
-		if (freq > cpufreq_dev->freq_table[level])
+		if (freq > cpufreq_cdev->freq_table[level])
 			break;
 	}
 
@@ -148,12 +148,12 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_dev,
  */
 unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
 {
-	struct cpufreq_cooling_device *cpufreq_dev;
+	struct cpufreq_cooling_device *cpufreq_cdev;
 
 	mutex_lock(&cooling_list_lock);
-	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
-		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
-			unsigned long level = get_level(cpufreq_dev, freq);
+	list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
+		if (cpumask_test_cpu(cpu, &cpufreq_cdev->allowed_cpus)) {
+			unsigned long level = get_level(cpufreq_cdev, freq);
 
 			mutex_unlock(&cooling_list_lock);
 			return level;
@@ -183,14 +183,14 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 {
 	struct cpufreq_policy *policy = data;
 	unsigned long clipped_freq;
-	struct cpufreq_cooling_device *cpufreq_dev;
+	struct cpufreq_cooling_device *cpufreq_cdev;
 
 	if (event != CPUFREQ_ADJUST)
 		return NOTIFY_DONE;
 
 	mutex_lock(&cooling_list_lock);
-	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
-		if (!cpumask_test_cpu(policy->cpu, &cpufreq_dev->allowed_cpus))
+	list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
+		if (!cpumask_test_cpu(policy->cpu, &cpufreq_cdev->allowed_cpus))
 			continue;
 
 		/*
@@ -204,7 +204,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 		 * But, if clipped_freq is greater than policy->max, we don't
 		 * need to do anything.
 		 */
-		clipped_freq = cpufreq_dev->clipped_freq;
+		clipped_freq = cpufreq_cdev->clipped_freq;
 
 		if (policy->max > clipped_freq)
 			cpufreq_verify_within_limits(policy, 0, clipped_freq);
@@ -217,11 +217,11 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 
 /**
  * build_dyn_power_table() - create a dynamic power to frequency table
- * @cpufreq_device:	the cpufreq cooling device in which to store the table
+ * @cpufreq_cdev:	the cpufreq cooling device in which to store the table
  * @capacitance: dynamic power coefficient for these cpus
  *
  * Build a dynamic power to frequency table for this cpu and store it
- * in @cpufreq_device.  This table will be used in cpu_power_to_freq() and
+ * in @cpufreq_cdev.  This table will be used in cpu_power_to_freq() and
  * cpu_freq_to_power() to convert between power and frequency
  * efficiently.  Power is stored in mW, frequency in KHz.  The
  * resulting table is in ascending order.
@@ -230,7 +230,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
  * -ENOMEM if we run out of memory or -EAGAIN if an OPP was
  * added/enabled while the function was executing.
  */
-static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
+static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_cdev,
 				 u32 capacitance)
 {
 	struct power_table *power_table;
@@ -239,10 +239,10 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 	int num_opps = 0, cpu, i, ret = 0;
 	unsigned long freq;
 
-	for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
+	for_each_cpu(cpu, &cpufreq_cdev->allowed_cpus) {
 		dev = get_cpu_device(cpu);
 		if (!dev) {
-			dev_warn(&cpufreq_device->cool_dev->device,
+			dev_warn(&cpufreq_cdev->cool_dev->device,
 				 "No cpu device for cpu %d\n", cpu);
 			continue;
 		}
@@ -295,9 +295,9 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 		goto free_power_table;
 	}
 
-	cpufreq_device->cpu_dev = dev;
-	cpufreq_device->dyn_power_table = power_table;
-	cpufreq_device->dyn_power_table_entries = i;
+	cpufreq_cdev->cpu_dev = dev;
+	cpufreq_cdev->dyn_power_table = power_table;
+	cpufreq_cdev->dyn_power_table_entries = i;
 
 	return 0;
 
@@ -307,26 +307,26 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 	return ret;
 }
 
-static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_device,
+static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 freq)
 {
 	int i;
-	struct power_table *pt = cpufreq_device->dyn_power_table;
+	struct power_table *pt = cpufreq_cdev->dyn_power_table;
 
-	for (i = 1; i < cpufreq_device->dyn_power_table_entries; i++)
+	for (i = 1; i < cpufreq_cdev->dyn_power_table_entries; i++)
 		if (freq < pt[i].frequency)
 			break;
 
 	return pt[i - 1].power;
 }
 
-static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_device,
+static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
 			     u32 power)
 {
 	int i;
-	struct power_table *pt = cpufreq_device->dyn_power_table;
+	struct power_table *pt = cpufreq_cdev->dyn_power_table;
 
-	for (i = 1; i < cpufreq_device->dyn_power_table_entries; i++)
+	for (i = 1; i < cpufreq_cdev->dyn_power_table_entries; i++)
 		if (power < pt[i].power)
 			break;
 
@@ -335,37 +335,37 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_device,
 
 /**
  * get_load() - get load for a cpu since last updated
- * @cpufreq_device:	&struct cpufreq_cooling_device for this cpu
+ * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
  * @cpu:	cpu number
- * @cpu_idx:	index of the cpu in cpufreq_device->allowed_cpus
+ * @cpu_idx:	index of the cpu in cpufreq_cdev->allowed_cpus
  *
  * Return: The average load of cpu @cpu in percentage since this
  * function was last called.
  */
-static u32 get_load(struct cpufreq_cooling_device *cpufreq_device, int cpu,
+static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 		    int cpu_idx)
 {
 	u32 load;
 	u64 now, now_idle, delta_time, delta_idle;
 
 	now_idle = get_cpu_idle_time(cpu, &now, 0);
-	delta_idle = now_idle - cpufreq_device->time_in_idle[cpu_idx];
-	delta_time = now - cpufreq_device->time_in_idle_timestamp[cpu_idx];
+	delta_idle = now_idle - cpufreq_cdev->time_in_idle[cpu_idx];
+	delta_time = now - cpufreq_cdev->time_in_idle_timestamp[cpu_idx];
 
 	if (delta_time <= delta_idle)
 		load = 0;
 	else
 		load = div64_u64(100 * (delta_time - delta_idle), delta_time);
 
-	cpufreq_device->time_in_idle[cpu_idx] = now_idle;
-	cpufreq_device->time_in_idle_timestamp[cpu_idx] = now;
+	cpufreq_cdev->time_in_idle[cpu_idx] = now_idle;
+	cpufreq_cdev->time_in_idle_timestamp[cpu_idx] = now;
 
 	return load;
 }
 
 /**
  * get_static_power() - calculate the static power consumed by the cpus
- * @cpufreq_device:	struct &cpufreq_cooling_device for this cpu cdev
+ * @cpufreq_cdev:	struct &cpufreq_cooling_device for this cpu cdev
  * @tz:		thermal zone device in which we're operating
  * @freq:	frequency in KHz
  * @power:	pointer in which to store the calculated static power
@@ -378,25 +378,24 @@ static u32 get_load(struct cpufreq_cooling_device *cpufreq_device, int cpu,
  *
  * Return: 0 on success, -E* on failure.
  */
-static int get_static_power(struct cpufreq_cooling_device *cpufreq_device,
+static int get_static_power(struct cpufreq_cooling_device *cpufreq_cdev,
 			    struct thermal_zone_device *tz, unsigned long freq,
 			    u32 *power)
 {
 	struct dev_pm_opp *opp;
 	unsigned long voltage;
-	struct cpumask *cpumask = &cpufreq_device->allowed_cpus;
+	struct cpumask *cpumask = &cpufreq_cdev->allowed_cpus;
 	unsigned long freq_hz = freq * 1000;
 
-	if (!cpufreq_device->plat_get_static_power ||
-	    !cpufreq_device->cpu_dev) {
+	if (!cpufreq_cdev->plat_get_static_power || !cpufreq_cdev->cpu_dev) {
 		*power = 0;
 		return 0;
 	}
 
-	opp = dev_pm_opp_find_freq_exact(cpufreq_device->cpu_dev, freq_hz,
+	opp = dev_pm_opp_find_freq_exact(cpufreq_cdev->cpu_dev, freq_hz,
 					 true);
 	if (IS_ERR(opp)) {
-		dev_warn_ratelimited(cpufreq_device->cpu_dev,
+		dev_warn_ratelimited(cpufreq_cdev->cpu_dev,
 				     "Failed to find OPP for frequency %lu: %ld\n",
 				     freq_hz, PTR_ERR(opp));
 		return -EINVAL;
@@ -406,31 +405,31 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_device,
 	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
-		dev_err_ratelimited(cpufreq_device->cpu_dev,
+		dev_err_ratelimited(cpufreq_cdev->cpu_dev,
 				    "Failed to get voltage for frequency %lu\n",
 				    freq_hz);
 		return -EINVAL;
 	}
 
-	return cpufreq_device->plat_get_static_power(cpumask, tz->passive_delay,
-						     voltage, power);
+	return cpufreq_cdev->plat_get_static_power(cpumask, tz->passive_delay,
+						  voltage, power);
 }
 
 /**
  * get_dynamic_power() - calculate the dynamic power
- * @cpufreq_device:	&cpufreq_cooling_device for this cdev
+ * @cpufreq_cdev:	&cpufreq_cooling_device for this cdev
  * @freq:	current frequency
  *
  * Return: the dynamic power consumed by the cpus described by
- * @cpufreq_device.
+ * @cpufreq_cdev.
  */
-static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_device,
+static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_cdev,
 			     unsigned long freq)
 {
 	u32 raw_cpu_power;
 
-	raw_cpu_power = cpu_freq_to_power(cpufreq_device, freq);
-	return (raw_cpu_power * cpufreq_device->last_load) / 100;
+	raw_cpu_power = cpu_freq_to_power(cpufreq_cdev, freq);
+	return (raw_cpu_power * cpufreq_cdev->last_load) / 100;
 }
 
 /* cpufreq cooling device callback functions are defined below */
@@ -448,9 +447,9 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_device,
 static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 
-	*state = cpufreq_device->max_level;
+	*state = cpufreq_cdev->max_level;
 	return 0;
 }
 
@@ -467,9 +466,9 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 
-	*state = cpufreq_device->cpufreq_state;
+	*state = cpufreq_cdev->cpufreq_state;
 
 	return 0;
 }
@@ -487,21 +486,21 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
 static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
-	unsigned int cpu = cpumask_any(&cpufreq_device->allowed_cpus);
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+	unsigned int cpu = cpumask_any(&cpufreq_cdev->allowed_cpus);
 	unsigned int clip_freq;
 
 	/* Request state should be less than max_level */
-	if (WARN_ON(state > cpufreq_device->max_level))
+	if (WARN_ON(state > cpufreq_cdev->max_level))
 		return -EINVAL;
 
 	/* Check if the old cooling action is same as new cooling action */
-	if (cpufreq_device->cpufreq_state == state)
+	if (cpufreq_cdev->cpufreq_state == state)
 		return 0;
 
-	clip_freq = cpufreq_device->freq_table[state];
-	cpufreq_device->cpufreq_state = state;
-	cpufreq_device->clipped_freq = clip_freq;
+	clip_freq = cpufreq_cdev->freq_table[state];
+	cpufreq_cdev->cpufreq_state = state;
+	cpufreq_cdev->clipped_freq = clip_freq;
 
 	cpufreq_update_policy(cpu);
 
@@ -538,10 +537,10 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	unsigned long freq;
 	int i = 0, cpu, ret;
 	u32 static_power, dynamic_power, total_load = 0;
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	u32 *load_cpu = NULL;
 
-	cpu = cpumask_any_and(&cpufreq_device->allowed_cpus, cpu_online_mask);
+	cpu = cpumask_any_and(&cpufreq_cdev->allowed_cpus, cpu_online_mask);
 
 	/*
 	 * All the CPUs are offline, thus the requested power by
@@ -555,16 +554,16 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	freq = cpufreq_quick_get(cpu);
 
 	if (trace_thermal_power_cpu_get_power_enabled()) {
-		u32 ncpus = cpumask_weight(&cpufreq_device->allowed_cpus);
+		u32 ncpus = cpumask_weight(&cpufreq_cdev->allowed_cpus);
 
 		load_cpu = kcalloc(ncpus, sizeof(*load_cpu), GFP_KERNEL);
 	}
 
-	for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
+	for_each_cpu(cpu, &cpufreq_cdev->allowed_cpus) {
 		u32 load;
 
 		if (cpu_online(cpu))
-			load = get_load(cpufreq_device, cpu, i);
+			load = get_load(cpufreq_cdev, cpu, i);
 		else
 			load = 0;
 
@@ -575,10 +574,10 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 		i++;
 	}
 
-	cpufreq_device->last_load = total_load;
+	cpufreq_cdev->last_load = total_load;
 
-	dynamic_power = get_dynamic_power(cpufreq_device, freq);
-	ret = get_static_power(cpufreq_device, tz, freq, &static_power);
+	dynamic_power = get_dynamic_power(cpufreq_cdev, freq);
+	ret = get_static_power(cpufreq_cdev, tz, freq, &static_power);
 	if (ret) {
 		kfree(load_cpu);
 		return ret;
@@ -586,7 +585,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 
 	if (load_cpu) {
 		trace_thermal_power_cpu_get_power(
-			&cpufreq_device->allowed_cpus,
+			&cpufreq_cdev->allowed_cpus,
 			freq, load_cpu, i, dynamic_power, static_power);
 
 		kfree(load_cpu);
@@ -619,12 +618,12 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 	cpumask_var_t cpumask;
 	u32 static_power, dynamic_power;
 	int ret;
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 
 	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
-	cpumask_and(cpumask, &cpufreq_device->allowed_cpus, cpu_online_mask);
+	cpumask_and(cpumask, &cpufreq_cdev->allowed_cpus, cpu_online_mask);
 	num_cpus = cpumask_weight(cpumask);
 
 	/* None of our cpus are online, so no power */
@@ -634,14 +633,14 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 		goto out;
 	}
 
-	freq = cpufreq_device->freq_table[state];
+	freq = cpufreq_cdev->freq_table[state];
 	if (!freq) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	dynamic_power = cpu_freq_to_power(cpufreq_device, freq) * num_cpus;
-	ret = get_static_power(cpufreq_device, tz, freq, &static_power);
+	dynamic_power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
+	ret = get_static_power(cpufreq_cdev, tz, freq, &static_power);
 	if (ret)
 		goto out;
 
@@ -679,24 +678,24 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	int ret;
 	s32 dyn_power;
 	u32 last_load, normalised_power, static_power;
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 
-	cpu = cpumask_any_and(&cpufreq_device->allowed_cpus, cpu_online_mask);
+	cpu = cpumask_any_and(&cpufreq_cdev->allowed_cpus, cpu_online_mask);
 
 	/* None of our cpus are online */
 	if (cpu >= nr_cpu_ids)
 		return -ENODEV;
 
 	cur_freq = cpufreq_quick_get(cpu);
-	ret = get_static_power(cpufreq_device, tz, cur_freq, &static_power);
+	ret = get_static_power(cpufreq_cdev, tz, cur_freq, &static_power);
 	if (ret)
 		return ret;
 
 	dyn_power = power - static_power;
 	dyn_power = dyn_power > 0 ? dyn_power : 0;
-	last_load = cpufreq_device->last_load ?: 1;
+	last_load = cpufreq_cdev->last_load ?: 1;
 	normalised_power = (dyn_power * 100) / last_load;
-	target_freq = cpu_power_to_freq(cpufreq_device, normalised_power);
+	target_freq = cpu_power_to_freq(cpufreq_cdev, normalised_power);
 
 	*state = cpufreq_cooling_get_level(cpu, target_freq);
 	if (*state == THERMAL_CSTATE_INVALID) {
@@ -706,7 +705,7 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 		return -EINVAL;
 	}
 
-	trace_thermal_power_cpu_limit(&cpufreq_device->allowed_cpus,
+	trace_thermal_power_cpu_limit(&cpufreq_cdev->allowed_cpus,
 				      target_freq, *state, power);
 	return 0;
 }
@@ -771,7 +770,7 @@ __cpufreq_cooling_register(struct device_node *np,
 {
 	struct cpufreq_policy *policy;
 	struct thermal_cooling_device *cool_dev;
-	struct cpufreq_cooling_device *cpufreq_dev;
+	struct cpufreq_cooling_device *cpufreq_cdev;
 	char dev_name[THERMAL_NAME_LENGTH];
 	struct cpufreq_frequency_table *pos, *table;
 	cpumask_var_t temp_mask;
@@ -798,49 +797,49 @@ __cpufreq_cooling_register(struct device_node *np,
 		goto put_policy;
 	}
 
-	cpufreq_dev = kzalloc(sizeof(*cpufreq_dev), GFP_KERNEL);
-	if (!cpufreq_dev) {
+	cpufreq_cdev = kzalloc(sizeof(*cpufreq_cdev), GFP_KERNEL);
+	if (!cpufreq_cdev) {
 		cool_dev = ERR_PTR(-ENOMEM);
 		goto put_policy;
 	}
 
 	num_cpus = cpumask_weight(clip_cpus);
-	cpufreq_dev->time_in_idle = kcalloc(num_cpus,
-					    sizeof(*cpufreq_dev->time_in_idle),
+	cpufreq_cdev->time_in_idle = kcalloc(num_cpus,
+					    sizeof(*cpufreq_cdev->time_in_idle),
 					    GFP_KERNEL);
-	if (!cpufreq_dev->time_in_idle) {
+	if (!cpufreq_cdev->time_in_idle) {
 		cool_dev = ERR_PTR(-ENOMEM);
 		goto free_cdev;
 	}
 
-	cpufreq_dev->time_in_idle_timestamp =
-		kcalloc(num_cpus, sizeof(*cpufreq_dev->time_in_idle_timestamp),
+	cpufreq_cdev->time_in_idle_timestamp =
+		kcalloc(num_cpus, sizeof(*cpufreq_cdev->time_in_idle_timestamp),
 			GFP_KERNEL);
-	if (!cpufreq_dev->time_in_idle_timestamp) {
+	if (!cpufreq_cdev->time_in_idle_timestamp) {
 		cool_dev = ERR_PTR(-ENOMEM);
 		goto free_time_in_idle;
 	}
 
 	/* Find max levels */
 	cpufreq_for_each_valid_entry(pos, table)
-		cpufreq_dev->max_level++;
+		cpufreq_cdev->max_level++;
 
-	cpufreq_dev->freq_table = kmalloc(sizeof(*cpufreq_dev->freq_table) *
-					  cpufreq_dev->max_level, GFP_KERNEL);
-	if (!cpufreq_dev->freq_table) {
+	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev->freq_table) *
+					  cpufreq_cdev->max_level, GFP_KERNEL);
+	if (!cpufreq_cdev->freq_table) {
 		cool_dev = ERR_PTR(-ENOMEM);
 		goto free_time_in_idle_timestamp;
 	}
 
 	/* max_level is an index, not a counter */
-	cpufreq_dev->max_level--;
+	cpufreq_cdev->max_level--;
 
-	cpumask_copy(&cpufreq_dev->allowed_cpus, clip_cpus);
+	cpumask_copy(&cpufreq_cdev->allowed_cpus, clip_cpus);
 
 	if (capacitance) {
-		cpufreq_dev->plat_get_static_power = plat_static_func;
+		cpufreq_cdev->plat_get_static_power = plat_static_func;
 
-		ret = build_dyn_power_table(cpufreq_dev, capacitance);
+		ret = build_dyn_power_table(cpufreq_cdev, capacitance);
 		if (ret) {
 			cool_dev = ERR_PTR(ret);
 			goto free_table;
@@ -856,12 +855,12 @@ __cpufreq_cooling_register(struct device_node *np,
 		cool_dev = ERR_PTR(ret);
 		goto free_power_table;
 	}
-	cpufreq_dev->id = ret;
+	cpufreq_cdev->id = ret;
 
 	/* Fill freq-table in descending order of frequencies */
-	for (i = 0, freq = -1; i <= cpufreq_dev->max_level; i++) {
+	for (i = 0, freq = -1; i <= cpufreq_cdev->max_level; i++) {
 		freq = find_next_max(table, freq);
-		cpufreq_dev->freq_table[i] = freq;
+		cpufreq_cdev->freq_table[i] = freq;
 
 		/* Warn for duplicate entries */
 		if (!freq)
@@ -871,20 +870,21 @@ __cpufreq_cooling_register(struct device_node *np,
 	}
 
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
-		 cpufreq_dev->id);
+		 cpufreq_cdev->id);
 
-	cool_dev = thermal_of_cooling_device_register(np, dev_name, cpufreq_dev,
+	cool_dev = thermal_of_cooling_device_register(np, dev_name,
+						      cpufreq_cdev,
 						      cooling_ops);
 	if (IS_ERR(cool_dev))
 		goto remove_ida;
 
-	cpufreq_dev->clipped_freq = cpufreq_dev->freq_table[0];
-	cpufreq_dev->cool_dev = cool_dev;
+	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0];
+	cpufreq_cdev->cool_dev = cool_dev;
 
 	mutex_lock(&cooling_list_lock);
 	/* Register the notifier for first cpufreq cooling device */
-	first = list_empty(&cpufreq_dev_list);
-	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
+	first = list_empty(&cpufreq_cdev_list);
+	list_add(&cpufreq_cdev->node, &cpufreq_cdev_list);
 	mutex_unlock(&cooling_list_lock);
 
 	if (first)
@@ -894,17 +894,17 @@ __cpufreq_cooling_register(struct device_node *np,
 	goto put_policy;
 
 remove_ida:
-	ida_simple_remove(&cpufreq_ida, cpufreq_dev->id);
+	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 free_power_table:
-	kfree(cpufreq_dev->dyn_power_table);
+	kfree(cpufreq_cdev->dyn_power_table);
 free_table:
-	kfree(cpufreq_dev->freq_table);
+	kfree(cpufreq_cdev->freq_table);
 free_time_in_idle_timestamp:
-	kfree(cpufreq_dev->time_in_idle_timestamp);
+	kfree(cpufreq_cdev->time_in_idle_timestamp);
 free_time_in_idle:
-	kfree(cpufreq_dev->time_in_idle);
+	kfree(cpufreq_cdev->time_in_idle);
 free_cdev:
-	kfree(cpufreq_dev);
+	kfree(cpufreq_cdev);
 put_policy:
 	cpufreq_cpu_put(policy);
 free_cpumask:
@@ -1029,30 +1029,30 @@ EXPORT_SYMBOL(of_cpufreq_power_cooling_register);
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
-	struct cpufreq_cooling_device *cpufreq_dev;
+	struct cpufreq_cooling_device *cpufreq_cdev;
 	bool last;
 
 	if (!cdev)
 		return;
 
-	cpufreq_dev = cdev->devdata;
+	cpufreq_cdev = cdev->devdata;
 
 	mutex_lock(&cooling_list_lock);
-	list_del(&cpufreq_dev->node);
+	list_del(&cpufreq_cdev->node);
 	/* Unregister the notifier for the last cpufreq cooling device */
-	last = list_empty(&cpufreq_dev_list);
+	last = list_empty(&cpufreq_cdev_list);
 	mutex_unlock(&cooling_list_lock);
 
 	if (last)
 		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
 					    CPUFREQ_POLICY_NOTIFIER);
 
-	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
-	ida_simple_remove(&cpufreq_ida, cpufreq_dev->id);
-	kfree(cpufreq_dev->dyn_power_table);
-	kfree(cpufreq_dev->time_in_idle_timestamp);
-	kfree(cpufreq_dev->time_in_idle);
-	kfree(cpufreq_dev->freq_table);
-	kfree(cpufreq_dev);
+	thermal_cooling_device_unregister(cpufreq_cdev->cool_dev);
+	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
+	kfree(cpufreq_cdev->dyn_power_table);
+	kfree(cpufreq_cdev->time_in_idle_timestamp);
+	kfree(cpufreq_cdev->time_in_idle);
+	kfree(cpufreq_cdev->freq_table);
+	kfree(cpufreq_cdev);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
-- 
2.12.0.432.g71c3a4f4ba37

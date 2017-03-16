From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/17] thermal: cpu_cooling: Replace cpufreq_device with cpufreq_dev
Date: Thu, 16 Mar 2017 10:59:38 +0530
Message-ID: <1ebaf8113e79154e9b8e7696c4e1c70791d26e14.1489640000.git.viresh.kumar@linaro.org>
References: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Objects of "struct cpufreq_cooling_device" are named a bit
inconsistently. Lets use cpufreq_dev everywhere.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 133 +++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 67 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 7ce73eee866f..7a19033d7f79 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -218,11 +218,11 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 
 /**
  * build_dyn_power_table() - create a dynamic power to frequency table
- * @cpufreq_device:	the cpufreq cooling device in which to store the table
+ * @cpufreq_dev:	the cpufreq cooling device in which to store the table
  * @capacitance: dynamic power coefficient for these cpus
  *
  * Build a dynamic power to frequency table for this cpu and store it
- * in @cpufreq_device.  This table will be used in cpu_power_to_freq() and
+ * in @cpufreq_dev.  This table will be used in cpu_power_to_freq() and
  * cpu_freq_to_power() to convert between power and frequency
  * efficiently.  Power is stored in mW, frequency in KHz.  The
  * resulting table is in ascending order.
@@ -231,7 +231,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
  * -ENOMEM if we run out of memory or -EAGAIN if an OPP was
  * added/enabled while the function was executing.
  */
-static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
+static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_dev,
 				 u32 capacitance)
 {
 	struct power_table *power_table;
@@ -240,10 +240,10 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 	int num_opps = 0, cpu, i, ret = 0;
 	unsigned long freq;
 
-	for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
+	for_each_cpu(cpu, &cpufreq_dev->allowed_cpus) {
 		dev = get_cpu_device(cpu);
 		if (!dev) {
-			dev_warn(&cpufreq_device->cool_dev->device,
+			dev_warn(&cpufreq_dev->cool_dev->device,
 				 "No cpu device for cpu %d\n", cpu);
 			continue;
 		}
@@ -296,9 +296,9 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 		goto free_power_table;
 	}
 
-	cpufreq_device->cpu_dev = dev;
-	cpufreq_device->dyn_power_table = power_table;
-	cpufreq_device->dyn_power_table_entries = i;
+	cpufreq_dev->cpu_dev = dev;
+	cpufreq_dev->dyn_power_table = power_table;
+	cpufreq_dev->dyn_power_table_entries = i;
 
 	return 0;
 
@@ -308,26 +308,26 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_device,
 	return ret;
 }
 
-static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_device,
+static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_dev,
 			     u32 freq)
 {
 	int i;
-	struct power_table *pt = cpufreq_device->dyn_power_table;
+	struct power_table *pt = cpufreq_dev->dyn_power_table;
 
-	for (i = 1; i < cpufreq_device->dyn_power_table_entries; i++)
+	for (i = 1; i < cpufreq_dev->dyn_power_table_entries; i++)
 		if (freq < pt[i].frequency)
 			break;
 
 	return pt[i - 1].power;
 }
 
-static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_device,
+static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_dev,
 			     u32 power)
 {
 	int i;
-	struct power_table *pt = cpufreq_device->dyn_power_table;
+	struct power_table *pt = cpufreq_dev->dyn_power_table;
 
-	for (i = 1; i < cpufreq_device->dyn_power_table_entries; i++)
+	for (i = 1; i < cpufreq_dev->dyn_power_table_entries; i++)
 		if (power < pt[i].power)
 			break;
 
@@ -336,37 +336,37 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_device,
 
 /**
  * get_load() - get load for a cpu since last updated
- * @cpufreq_device:	&struct cpufreq_cooling_device for this cpu
+ * @cpufreq_dev:	&struct cpufreq_cooling_device for this cpu
  * @cpu:	cpu number
- * @cpu_idx:	index of the cpu in cpufreq_device->allowed_cpus
+ * @cpu_idx:	index of the cpu in cpufreq_dev->allowed_cpus
  *
  * Return: The average load of cpu @cpu in percentage since this
  * function was last called.
  */
-static u32 get_load(struct cpufreq_cooling_device *cpufreq_device, int cpu,
+static u32 get_load(struct cpufreq_cooling_device *cpufreq_dev, int cpu,
 		    int cpu_idx)
 {
 	u32 load;
 	u64 now, now_idle, delta_time, delta_idle;
 
 	now_idle = get_cpu_idle_time(cpu, &now, 0);
-	delta_idle = now_idle - cpufreq_device->time_in_idle[cpu_idx];
-	delta_time = now - cpufreq_device->time_in_idle_timestamp[cpu_idx];
+	delta_idle = now_idle - cpufreq_dev->time_in_idle[cpu_idx];
+	delta_time = now - cpufreq_dev->time_in_idle_timestamp[cpu_idx];
 
 	if (delta_time <= delta_idle)
 		load = 0;
 	else
 		load = div64_u64(100 * (delta_time - delta_idle), delta_time);
 
-	cpufreq_device->time_in_idle[cpu_idx] = now_idle;
-	cpufreq_device->time_in_idle_timestamp[cpu_idx] = now;
+	cpufreq_dev->time_in_idle[cpu_idx] = now_idle;
+	cpufreq_dev->time_in_idle_timestamp[cpu_idx] = now;
 
 	return load;
 }
 
 /**
  * get_static_power() - calculate the static power consumed by the cpus
- * @cpufreq_device:	struct &cpufreq_cooling_device for this cpu cdev
+ * @cpufreq_dev:	struct &cpufreq_cooling_device for this cpu cdev
  * @tz:		thermal zone device in which we're operating
  * @freq:	frequency in KHz
  * @power:	pointer in which to store the calculated static power
@@ -379,25 +379,24 @@ static u32 get_load(struct cpufreq_cooling_device *cpufreq_device, int cpu,
  *
  * Return: 0 on success, -E* on failure.
  */
-static int get_static_power(struct cpufreq_cooling_device *cpufreq_device,
+static int get_static_power(struct cpufreq_cooling_device *cpufreq_dev,
 			    struct thermal_zone_device *tz, unsigned long freq,
 			    u32 *power)
 {
 	struct dev_pm_opp *opp;
 	unsigned long voltage;
-	struct cpumask *cpumask = &cpufreq_device->allowed_cpus;
+	struct cpumask *cpumask = &cpufreq_dev->allowed_cpus;
 	unsigned long freq_hz = freq * 1000;
 
-	if (!cpufreq_device->plat_get_static_power ||
-	    !cpufreq_device->cpu_dev) {
+	if (!cpufreq_dev->plat_get_static_power || !cpufreq_dev->cpu_dev) {
 		*power = 0;
 		return 0;
 	}
 
-	opp = dev_pm_opp_find_freq_exact(cpufreq_device->cpu_dev, freq_hz,
+	opp = dev_pm_opp_find_freq_exact(cpufreq_dev->cpu_dev, freq_hz,
 					 true);
 	if (IS_ERR(opp)) {
-		dev_warn_ratelimited(cpufreq_device->cpu_dev,
+		dev_warn_ratelimited(cpufreq_dev->cpu_dev,
 				     "Failed to find OPP for frequency %lu: %ld\n",
 				     freq_hz, PTR_ERR(opp));
 		return -EINVAL;
@@ -407,31 +406,31 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_device,
 	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
-		dev_err_ratelimited(cpufreq_device->cpu_dev,
+		dev_err_ratelimited(cpufreq_dev->cpu_dev,
 				    "Failed to get voltage for frequency %lu\n",
 				    freq_hz);
 		return -EINVAL;
 	}
 
-	return cpufreq_device->plat_get_static_power(cpumask, tz->passive_delay,
-						     voltage, power);
+	return cpufreq_dev->plat_get_static_power(cpumask, tz->passive_delay,
+						  voltage, power);
 }
 
 /**
  * get_dynamic_power() - calculate the dynamic power
- * @cpufreq_device:	&cpufreq_cooling_device for this cdev
+ * @cpufreq_dev:	&cpufreq_cooling_device for this cdev
  * @freq:	current frequency
  *
  * Return: the dynamic power consumed by the cpus described by
- * @cpufreq_device.
+ * @cpufreq_dev.
  */
-static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_device,
+static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_dev,
 			     unsigned long freq)
 {
 	u32 raw_cpu_power;
 
-	raw_cpu_power = cpu_freq_to_power(cpufreq_device, freq);
-	return (raw_cpu_power * cpufreq_device->last_load) / 100;
+	raw_cpu_power = cpu_freq_to_power(cpufreq_dev, freq);
+	return (raw_cpu_power * cpufreq_dev->last_load) / 100;
 }
 
 /* cpufreq cooling device callback functions are defined below */
@@ -449,9 +448,9 @@ static u32 get_dynamic_power(struct cpufreq_cooling_device *cpufreq_device,
 static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	struct cpufreq_cooling_device *cpufreq_dev = cdev->devdata;
 
-	*state = cpufreq_device->max_level;
+	*state = cpufreq_dev->max_level;
 	return 0;
 }
 
@@ -468,9 +467,9 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	struct cpufreq_cooling_device *cpufreq_dev = cdev->devdata;
 
-	*state = cpufreq_device->cpufreq_state;
+	*state = cpufreq_dev->cpufreq_state;
 
 	return 0;
 }
@@ -488,21 +487,21 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
 static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
-	unsigned int cpu = cpumask_any(&cpufreq_device->allowed_cpus);
+	struct cpufreq_cooling_device *cpufreq_dev = cdev->devdata;
+	unsigned int cpu = cpumask_any(&cpufreq_dev->allowed_cpus);
 	unsigned int clip_freq;
 
 	/* Request state should be less than max_level */
-	if (WARN_ON(state > cpufreq_device->max_level))
+	if (WARN_ON(state > cpufreq_dev->max_level))
 		return -EINVAL;
 
 	/* Check if the old cooling action is same as new cooling action */
-	if (cpufreq_device->cpufreq_state == state)
+	if (cpufreq_dev->cpufreq_state == state)
 		return 0;
 
-	clip_freq = cpufreq_device->freq_table[state];
-	cpufreq_device->cpufreq_state = state;
-	cpufreq_device->clipped_freq = clip_freq;
+	clip_freq = cpufreq_dev->freq_table[state];
+	cpufreq_dev->cpufreq_state = state;
+	cpufreq_dev->clipped_freq = clip_freq;
 
 	cpufreq_update_policy(cpu);
 
@@ -539,10 +538,10 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	unsigned long freq;
 	int i = 0, cpu, ret;
 	u32 static_power, dynamic_power, total_load = 0;
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	struct cpufreq_cooling_device *cpufreq_dev = cdev->devdata;
 	u32 *load_cpu = NULL;
 
-	cpu = cpumask_any_and(&cpufreq_device->allowed_cpus, cpu_online_mask);
+	cpu = cpumask_any_and(&cpufreq_dev->allowed_cpus, cpu_online_mask);
 
 	/*
 	 * All the CPUs are offline, thus the requested power by
@@ -556,16 +555,16 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 	freq = cpufreq_quick_get(cpu);
 
 	if (trace_thermal_power_cpu_get_power_enabled()) {
-		u32 ncpus = cpumask_weight(&cpufreq_device->allowed_cpus);
+		u32 ncpus = cpumask_weight(&cpufreq_dev->allowed_cpus);
 
 		load_cpu = kcalloc(ncpus, sizeof(*load_cpu), GFP_KERNEL);
 	}
 
-	for_each_cpu(cpu, &cpufreq_device->allowed_cpus) {
+	for_each_cpu(cpu, &cpufreq_dev->allowed_cpus) {
 		u32 load;
 
 		if (cpu_online(cpu))
-			load = get_load(cpufreq_device, cpu, i);
+			load = get_load(cpufreq_dev, cpu, i);
 		else
 			load = 0;
 
@@ -576,10 +575,10 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 		i++;
 	}
 
-	cpufreq_device->last_load = total_load;
+	cpufreq_dev->last_load = total_load;
 
-	dynamic_power = get_dynamic_power(cpufreq_device, freq);
-	ret = get_static_power(cpufreq_device, tz, freq, &static_power);
+	dynamic_power = get_dynamic_power(cpufreq_dev, freq);
+	ret = get_static_power(cpufreq_dev, tz, freq, &static_power);
 	if (ret) {
 		kfree(load_cpu);
 		return ret;
@@ -587,7 +586,7 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 
 	if (load_cpu) {
 		trace_thermal_power_cpu_get_power(
-			&cpufreq_device->allowed_cpus,
+			&cpufreq_dev->allowed_cpus,
 			freq, load_cpu, i, dynamic_power, static_power);
 
 		kfree(load_cpu);
@@ -620,12 +619,12 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 	cpumask_var_t cpumask;
 	u32 static_power, dynamic_power;
 	int ret;
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	struct cpufreq_cooling_device *cpufreq_dev = cdev->devdata;
 
 	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
-	cpumask_and(cpumask, &cpufreq_device->allowed_cpus, cpu_online_mask);
+	cpumask_and(cpumask, &cpufreq_dev->allowed_cpus, cpu_online_mask);
 	num_cpus = cpumask_weight(cpumask);
 
 	/* None of our cpus are online, so no power */
@@ -635,14 +634,14 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 		goto out;
 	}
 
-	freq = cpufreq_device->freq_table[state];
+	freq = cpufreq_dev->freq_table[state];
 	if (!freq) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	dynamic_power = cpu_freq_to_power(cpufreq_device, freq) * num_cpus;
-	ret = get_static_power(cpufreq_device, tz, freq, &static_power);
+	dynamic_power = cpu_freq_to_power(cpufreq_dev, freq) * num_cpus;
+	ret = get_static_power(cpufreq_dev, tz, freq, &static_power);
 	if (ret)
 		goto out;
 
@@ -680,24 +679,24 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	int ret;
 	s32 dyn_power;
 	u32 last_load, normalised_power, static_power;
-	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	struct cpufreq_cooling_device *cpufreq_dev = cdev->devdata;
 
-	cpu = cpumask_any_and(&cpufreq_device->allowed_cpus, cpu_online_mask);
+	cpu = cpumask_any_and(&cpufreq_dev->allowed_cpus, cpu_online_mask);
 
 	/* None of our cpus are online */
 	if (cpu >= nr_cpu_ids)
 		return -ENODEV;
 
 	cur_freq = cpufreq_quick_get(cpu);
-	ret = get_static_power(cpufreq_device, tz, cur_freq, &static_power);
+	ret = get_static_power(cpufreq_dev, tz, cur_freq, &static_power);
 	if (ret)
 		return ret;
 
 	dyn_power = power - static_power;
 	dyn_power = dyn_power > 0 ? dyn_power : 0;
-	last_load = cpufreq_device->last_load ?: 1;
+	last_load = cpufreq_dev->last_load ?: 1;
 	normalised_power = (dyn_power * 100) / last_load;
-	target_freq = cpu_power_to_freq(cpufreq_device, normalised_power);
+	target_freq = cpu_power_to_freq(cpufreq_dev, normalised_power);
 
 	*state = cpufreq_cooling_get_level(cpu, target_freq);
 	if (*state == THERMAL_CSTATE_INVALID) {
@@ -707,7 +706,7 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 		return -EINVAL;
 	}
 
-	trace_thermal_power_cpu_limit(&cpufreq_device->allowed_cpus,
+	trace_thermal_power_cpu_limit(&cpufreq_dev->allowed_cpus,
 				      target_freq, *state, power);
 	return 0;
 }
-- 
2.7.1.410.g6faf27b

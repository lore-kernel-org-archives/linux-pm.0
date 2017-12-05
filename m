From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/4] cpu_cooling: Drop static-power related stuff
Date: Tue,  5 Dec 2017 11:02:46 +0530
Message-ID: <55020cb5e2701942b0613c12bd0c911662df643e.1512451487.git.viresh.kumar@linaro.org>
References: <cover.1512451487.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36095 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751934AbdLEFhJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 00:37:09 -0500
Received: by mail-pf0-f195.google.com with SMTP id p84so10421805pfd.3
        for <linux-pm@vger.kernel.org>; Mon, 04 Dec 2017 21:37:08 -0800 (PST)
In-Reply-To: <cover.1512451487.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1512451487.git.viresh.kumar@linaro.org>
References: <cover.1512451487.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, edubezval@gmail.com
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, javi.merino@kernel.org, amit.kachhap@gmail.com, rui.zhang@intel.com, ionela.voinescu@arm.com

No one has used it for the last two and half years (since it was
introduced by commit c36cf0717631 ("thermal: cpu_cooling: implement the
power cooling device API")), get rid of it.

Cc: Javi Merino <javi.merino@arm.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>
Acked-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c  | 106 +++++------------------------------------
 include/linux/cpu_cooling.h    |   3 --
 include/trace/events/thermal.h |  10 ++--
 3 files changed, 16 insertions(+), 103 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 3371caf3095c..dfd23245f778 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -88,7 +88,6 @@ struct time_in_idle {
  * @policy: cpufreq policy.
  * @node: list_head to link all cpufreq_cooling_device together.
  * @idle_time: idle time stats
- * @plat_get_static_power: callback to calculate the static power
  *
  * This structure is required for keeping information of each registered
  * cpufreq_cooling_device.
@@ -104,7 +103,6 @@ struct cpufreq_cooling_device {
 	struct cpufreq_policy *policy;
 	struct list_head node;
 	struct time_in_idle *idle_time;
-	get_static_t plat_get_static_power;
 };
 
 static DEFINE_IDA(cpufreq_ida);
@@ -319,60 +317,6 @@ static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 }
 
 /**
- * get_static_power() - calculate the static power consumed by the cpus
- * @cpufreq_cdev:	struct &cpufreq_cooling_device for this cpu cdev
- * @tz:		thermal zone device in which we're operating
- * @freq:	frequency in KHz
- * @power:	pointer in which to store the calculated static power
- *
- * Calculate the static power consumed by the cpus described by
- * @cpu_actor running at frequency @freq.  This function relies on a
- * platform specific function that should have been provided when the
- * actor was registered.  If it wasn't, the static power is assumed to
- * be negligible.  The calculated static power is stored in @power.
- *
- * Return: 0 on success, -E* on failure.
- */
-static int get_static_power(struct cpufreq_cooling_device *cpufreq_cdev,
-			    struct thermal_zone_device *tz, unsigned long freq,
-			    u32 *power)
-{
-	struct dev_pm_opp *opp;
-	unsigned long voltage;
-	struct cpufreq_policy *policy = cpufreq_cdev->policy;
-	struct cpumask *cpumask = policy->related_cpus;
-	unsigned long freq_hz = freq * 1000;
-	struct device *dev;
-
-	if (!cpufreq_cdev->plat_get_static_power) {
-		*power = 0;
-		return 0;
-	}
-
-	dev = get_cpu_device(policy->cpu);
-	WARN_ON(!dev);
-
-	opp = dev_pm_opp_find_freq_exact(dev, freq_hz, true);
-	if (IS_ERR(opp)) {
-		dev_warn_ratelimited(dev, "Failed to find OPP for frequency %lu: %ld\n",
-				     freq_hz, PTR_ERR(opp));
-		return -EINVAL;
-	}
-
-	voltage = dev_pm_opp_get_voltage(opp);
-	dev_pm_opp_put(opp);
-
-	if (voltage == 0) {
-		dev_err_ratelimited(dev, "Failed to get voltage for frequency %lu\n",
-				    freq_hz);
-		return -EINVAL;
-	}
-
-	return cpufreq_cdev->plat_get_static_power(cpumask, tz->passive_delay,
-						  voltage, power);
-}
-
-/**
  * get_dynamic_power() - calculate the dynamic power
  * @cpufreq_cdev:	&cpufreq_cooling_device for this cdev
  * @freq:	current frequency
@@ -491,8 +435,8 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 				       u32 *power)
 {
 	unsigned long freq;
-	int i = 0, cpu, ret;
-	u32 static_power, dynamic_power, total_load = 0;
+	int i = 0, cpu;
+	u32 total_load = 0;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	struct cpufreq_policy *policy = cpufreq_cdev->policy;
 	u32 *load_cpu = NULL;
@@ -522,22 +466,15 @@ static int cpufreq_get_requested_power(struct thermal_cooling_device *cdev,
 
 	cpufreq_cdev->last_load = total_load;
 
-	dynamic_power = get_dynamic_power(cpufreq_cdev, freq);
-	ret = get_static_power(cpufreq_cdev, tz, freq, &static_power);
-	if (ret) {
-		kfree(load_cpu);
-		return ret;
-	}
+	*power = get_dynamic_power(cpufreq_cdev, freq);
 
 	if (load_cpu) {
 		trace_thermal_power_cpu_get_power(policy->related_cpus, freq,
-						  load_cpu, i, dynamic_power,
-						  static_power);
+						  load_cpu, i, *power);
 
 		kfree(load_cpu);
 	}
 
-	*power = static_power + dynamic_power;
 	return 0;
 }
 
@@ -561,8 +498,6 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 			       unsigned long state, u32 *power)
 {
 	unsigned int freq, num_cpus;
-	u32 static_power, dynamic_power;
-	int ret;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 
 	/* Request state should be less than max_level */
@@ -572,13 +507,9 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 	num_cpus = cpumask_weight(cpufreq_cdev->policy->cpus);
 
 	freq = cpufreq_cdev->freq_table[state].frequency;
-	dynamic_power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
-	ret = get_static_power(cpufreq_cdev, tz, freq, &static_power);
-	if (ret)
-		return ret;
+	*power = cpu_freq_to_power(cpufreq_cdev, freq) * num_cpus;
 
-	*power = static_power + dynamic_power;
-	return ret;
+	return 0;
 }
 
 /**
@@ -606,21 +537,14 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 			       unsigned long *state)
 {
 	unsigned int cur_freq, target_freq;
-	int ret;
-	s32 dyn_power;
-	u32 last_load, normalised_power, static_power;
+	u32 last_load, normalised_power;
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	struct cpufreq_policy *policy = cpufreq_cdev->policy;
 
 	cur_freq = cpufreq_quick_get(policy->cpu);
-	ret = get_static_power(cpufreq_cdev, tz, cur_freq, &static_power);
-	if (ret)
-		return ret;
-
-	dyn_power = power - static_power;
-	dyn_power = dyn_power > 0 ? dyn_power : 0;
+	power = power > 0 ? power : 0;
 	last_load = cpufreq_cdev->last_load ?: 1;
-	normalised_power = (dyn_power * 100) / last_load;
+	normalised_power = (power * 100) / last_load;
 	target_freq = cpu_power_to_freq(cpufreq_cdev, normalised_power);
 
 	*state = get_level(cpufreq_cdev, target_freq);
@@ -671,8 +595,6 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
  * @policy: cpufreq policy
  * Normally this should be same as cpufreq policy->related_cpus.
  * @capacitance: dynamic power coefficient for these cpus
- * @plat_static_func: function to calculate the static power consumed by these
- *                    cpus (optional)
  *
  * This interface function registers the cpufreq cooling device with the name
  * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
@@ -684,8 +606,7 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
  */
 static struct thermal_cooling_device *
 __cpufreq_cooling_register(struct device_node *np,
-			struct cpufreq_policy *policy, u32 capacitance,
-			get_static_t plat_static_func)
+			struct cpufreq_policy *policy, u32 capacitance)
 {
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
@@ -755,8 +676,6 @@ __cpufreq_cooling_register(struct device_node *np,
 	}
 
 	if (capacitance) {
-		cpufreq_cdev->plat_get_static_power = plat_static_func;
-
 		ret = update_freq_table(cpufreq_cdev, capacitance);
 		if (ret) {
 			cdev = ERR_PTR(ret);
@@ -813,7 +732,7 @@ __cpufreq_cooling_register(struct device_node *np,
 struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
-	return __cpufreq_cooling_register(NULL, policy, 0, NULL);
+	return __cpufreq_cooling_register(NULL, policy, 0);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
 
@@ -853,8 +772,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 		of_property_read_u32(np, "dynamic-power-coefficient",
 				     &capacitance);
 
-		cdev = __cpufreq_cooling_register(np, policy, capacitance,
-						  NULL);
+		cdev = __cpufreq_cooling_register(np, policy, capacitance);
 		if (IS_ERR(cdev)) {
 			pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
 			       policy->cpu, PTR_ERR(cdev));
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index fd0ea8ddca93..de0dafb9399d 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -30,9 +30,6 @@
 
 struct cpufreq_policy;
 
-typedef int (*get_static_t)(cpumask_t *cpumask, int interval,
-			    unsigned long voltage, u32 *power);
-
 #ifdef CONFIG_CPU_THERMAL
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index 78946640fe03..135e5421f003 100644
--- a/include/trace/events/thermal.h
+++ b/include/trace/events/thermal.h
@@ -94,9 +94,9 @@ TRACE_EVENT(thermal_zone_trip,
 #ifdef CONFIG_CPU_THERMAL
 TRACE_EVENT(thermal_power_cpu_get_power,
 	TP_PROTO(const struct cpumask *cpus, unsigned long freq, u32 *load,
-		size_t load_len, u32 dynamic_power, u32 static_power),
+		size_t load_len, u32 dynamic_power),
 
-	TP_ARGS(cpus, freq, load, load_len, dynamic_power, static_power),
+	TP_ARGS(cpus, freq, load, load_len, dynamic_power),
 
 	TP_STRUCT__entry(
 		__bitmask(cpumask, num_possible_cpus())
@@ -104,7 +104,6 @@ TRACE_EVENT(thermal_power_cpu_get_power,
 		__dynamic_array(u32,   load, load_len)
 		__field(size_t,        load_len      )
 		__field(u32,           dynamic_power )
-		__field(u32,           static_power  )
 	),
 
 	TP_fast_assign(
@@ -115,13 +114,12 @@ TRACE_EVENT(thermal_power_cpu_get_power,
 			load_len * sizeof(*load));
 		__entry->load_len = load_len;
 		__entry->dynamic_power = dynamic_power;
-		__entry->static_power = static_power;
 	),
 
-	TP_printk("cpus=%s freq=%lu load={%s} dynamic_power=%d static_power=%d",
+	TP_printk("cpus=%s freq=%lu load={%s} dynamic_power=%d",
 		__get_bitmask(cpumask), __entry->freq,
 		__print_array(__get_dynamic_array(load), __entry->load_len, 4),
-		__entry->dynamic_power, __entry->static_power)
+		__entry->dynamic_power)
 );
 
 TRACE_EVENT(thermal_power_cpu_limit,
-- 
2.11.0

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 12/17] thermal: cpu_cooling: merge frequency and power tables
Date: Thu, 16 Mar 2017 10:59:47 +0530
Message-ID: <22479b0dd7726d0d9fd7e9284bfa6b776ff08b39.1489640000.git.viresh.kumar@linaro.org>
References: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

The cpu_cooling driver keeps two tables:

- freq_table: table of frequencies in descending order, built from
  policy->freq_table.

- power_table: table of frequencies and power in ascending order, built
  from OPP table.

If the OPPs are used for the CPU device then both these tables are
actually built using the OPP core and should have the same frequency
entries. And there is no need to keep separate tables for this.

Lets merge them both.

Note that the new table is in descending order of frequencies and so the
'for' loops were required to be fixed at few places to make it work.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 123 ++++++++++++++++++------------------------
 1 file changed, 52 insertions(+), 71 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index b7b193cb0e7a..960135d85a71 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -49,14 +49,14 @@
  */
 
 /**
- * struct power_table - frequency to power conversion
+ * struct freq_table - frequency table along with power entries
  * @frequency:	frequency in KHz
  * @power:	power in mW
  *
  * This structure is built when the cooling device registers and helps
- * in translating frequency to power and viceversa.
+ * in translating frequency to power and vice versa.
  */
-struct power_table {
+struct freq_table {
 	u32 frequency;
 	u32 power;
 };
@@ -79,9 +79,6 @@ struct power_table {
  * @time_in_idle: previous reading of the absolute time that this cpu was idle
  * @time_in_idle_timestamp: wall time of the last invocation of
  *	get_cpu_idle_time_us()
- * @dyn_power_table: array of struct power_table for frequency to power
- *	conversion, sorted in ascending order.
- * @dyn_power_table_entries: number of entries in the @dyn_power_table array
  * @cpu_dev: the cpu_device of policy->cpu.
  * @plat_get_static_power: callback to calculate the static power
  *
@@ -95,13 +92,11 @@ struct cpufreq_cooling_device {
 	unsigned int cpufreq_state;
 	unsigned int clipped_freq;
 	unsigned int max_level;
-	unsigned int *freq_table;	/* In descending order */
+	struct freq_table *freq_table;	/* In descending order */
 	struct list_head node;
 	u32 last_load;
 	u64 *time_in_idle;
 	u64 *time_in_idle_timestamp;
-	struct power_table *dyn_power_table;
-	int dyn_power_table_entries;
 	struct device *cpu_dev;
 	get_static_t plat_get_static_power;
 };
@@ -126,10 +121,10 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_dev,
 	unsigned long level;
 
 	for (level = 0; level <= cpufreq_dev->max_level; level++) {
-		if (freq == cpufreq_dev->freq_table[level])
+		if (freq == cpufreq_dev->freq_table[level].frequency)
 			return level;
 
-		if (freq > cpufreq_dev->freq_table[level])
+		if (freq > cpufreq_dev->freq_table[level].frequency)
 			break;
 	}
 
@@ -186,28 +181,25 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 }
 
 /**
- * build_dyn_power_table() - create a dynamic power to frequency table
- * @cpufreq_dev:	the cpufreq cooling device in which to store the table
+ * update_freq_table() - Update the freq table with power numbers
+ * @cpufreq_dev:	the cpufreq cooling device in which to update the table
  * @capacitance: dynamic power coefficient for these cpus
  *
- * Build a dynamic power to frequency table for this cpu and store it
- * in @cpufreq_dev.  This table will be used in cpu_power_to_freq() and
- * cpu_freq_to_power() to convert between power and frequency
- * efficiently.  Power is stored in mW, frequency in KHz.  The
- * resulting table is in ascending order.
+ * Update the freq table with power numbers.  This table will be used in
+ * cpu_power_to_freq() and cpu_freq_to_power() to convert between power and
+ * frequency efficiently.  Power is stored in mW, frequency in KHz.  The
+ * resulting table is in descending order.
  *
  * Return: 0 on success, -EINVAL if there are no OPPs for any CPUs,
- * -ENOMEM if we run out of memory or -EAGAIN if an OPP was
- * added/enabled while the function was executing.
+ * or -ENOMEM if we run out of memory.
  */
-static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_dev,
-				 u32 capacitance)
+static int update_freq_table(struct cpufreq_cooling_device *cpufreq_dev,
+			     u32 capacitance)
 {
-	struct power_table *power_table;
+	struct freq_table *freq_table = cpufreq_dev->freq_table;
 	struct dev_pm_opp *opp;
 	struct device *dev = NULL;
-	int num_opps = 0, cpu = cpufreq_dev->policy->cpu, i, ret = 0;
-	unsigned long freq;
+	int num_opps = 0, cpu = cpufreq_dev->policy->cpu, i;
 
 	dev = get_cpu_device(cpu);
 	if (unlikely(!dev)) {
@@ -220,25 +212,32 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_dev,
 	if (num_opps < 0)
 		return num_opps;
 
-	if (num_opps == 0)
+	/*
+	 * The cpufreq table is also built from the OPP table and so the count
+	 * should match.
+	 */
+	if (num_opps != cpufreq_dev->max_level + 1) {
+		dev_warn(dev, "Number of OPPs not matching with max_levels\n");
 		return -EINVAL;
+	}
 
-	power_table = kcalloc(num_opps, sizeof(*power_table), GFP_KERNEL);
-	if (!power_table)
-		return -ENOMEM;
-
-	for (freq = 0, i = 0;
-	     opp = dev_pm_opp_find_freq_ceil(dev, &freq), !IS_ERR(opp);
-	     freq++, i++) {
-		u32 freq_mhz, voltage_mv;
+	for (i = 0; i < cpufreq_dev->max_level; i++) {
+		unsigned long freq = freq_table[i].frequency * 1000;
+		u32 freq_mhz = freq_table[i].frequency / 1000;
 		u64 power;
+		u32 voltage_mv;
 
-		if (i >= num_opps) {
-			ret = -EAGAIN;
-			goto free_power_table;
+		/*
+		 * Find ceil frequency as 'freq' may be slightly lower than OPP
+		 * freq due to truncation while converting to kHz.
+		 */
+		opp = dev_pm_opp_find_freq_ceil(dev, &freq);
+		if (IS_ERR(opp)) {
+			dev_err(dev, "failed to get opp for %lu frequency\n",
+				freq);
+			return -EINVAL;
 		}
 
-		freq_mhz = freq / 1000000;
 		voltage_mv = dev_pm_opp_get_voltage(opp) / 1000;
 		dev_pm_opp_put(opp);
 
@@ -249,54 +248,39 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_dev,
 		power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
 		do_div(power, 1000000000);
 
-		/* frequency is stored in power_table in KHz */
-		power_table[i].frequency = freq / 1000;
-
 		/* power is stored in mW */
-		power_table[i].power = power;
-	}
-
-	if (i != num_opps) {
-		ret = PTR_ERR(opp);
-		goto free_power_table;
+		freq_table[i].power = power;
 	}
 
 	cpufreq_dev->cpu_dev = dev;
-	cpufreq_dev->dyn_power_table = power_table;
-	cpufreq_dev->dyn_power_table_entries = i;
 
 	return 0;
-
-free_power_table:
-	kfree(power_table);
-
-	return ret;
 }
 
 static u32 cpu_freq_to_power(struct cpufreq_cooling_device *cpufreq_dev,
 			     u32 freq)
 {
 	int i;
-	struct power_table *pt = cpufreq_dev->dyn_power_table;
+	struct freq_table *freq_table = cpufreq_dev->freq_table;
 
-	for (i = 1; i < cpufreq_dev->dyn_power_table_entries; i++)
-		if (freq < pt[i].frequency)
+	for (i = 1; i < cpufreq_dev->max_level; i++)
+		if (freq > freq_table[i].frequency)
 			break;
 
-	return pt[i - 1].power;
+	return freq_table[i - 1].power;
 }
 
 static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_dev,
 			     u32 power)
 {
 	int i;
-	struct power_table *pt = cpufreq_dev->dyn_power_table;
+	struct freq_table *freq_table = cpufreq_dev->freq_table;
 
-	for (i = 1; i < cpufreq_dev->dyn_power_table_entries; i++)
-		if (power < pt[i].power)
+	for (i = 1; i < cpufreq_dev->max_level; i++)
+		if (power > freq_table[i].power)
 			break;
 
-	return pt[i - 1].frequency;
+	return freq_table[i - 1].frequency;
 }
 
 /**
@@ -463,7 +447,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	if (cpufreq_dev->cpufreq_state == state)
 		return 0;
 
-	clip_freq = cpufreq_dev->freq_table[state];
+	clip_freq = cpufreq_dev->freq_table[state].frequency;
 	cpufreq_dev->cpufreq_state = state;
 	cpufreq_dev->clipped_freq = clip_freq;
 
@@ -576,7 +560,7 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 
 	num_cpus = cpumask_weight(cpufreq_dev->policy->cpus);
 
-	freq = cpufreq_dev->freq_table[state];
+	freq = cpufreq_dev->freq_table[state].frequency;
 	if (!freq)
 		return -EINVAL;
 
@@ -750,7 +734,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (capacitance) {
 		cpufreq_dev->plat_get_static_power = plat_static_func;
 
-		ret = build_dyn_power_table(cpufreq_dev, capacitance);
+		ret = update_freq_table(cpufreq_dev, capacitance);
 		if (ret) {
 			cdev = ERR_PTR(ret);
 			goto free_table;
@@ -764,14 +748,14 @@ __cpufreq_cooling_register(struct device_node *np,
 	ret = ida_simple_get(&cpufreq_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		cdev = ERR_PTR(ret);
-		goto free_power_table;
+		goto free_table;
 	}
 	cpufreq_dev->id = ret;
 
 	/* Fill freq-table in descending order of frequencies */
 	for (i = 0, freq = -1; i <= cpufreq_dev->max_level; i++) {
 		freq = find_next_max(policy->freq_table, freq);
-		cpufreq_dev->freq_table[i] = freq;
+		cpufreq_dev->freq_table[i].frequency = freq;
 
 		/* Warn for duplicate entries */
 		if (!freq)
@@ -788,7 +772,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (IS_ERR(cdev))
 		goto remove_ida;
 
-	cpufreq_dev->clipped_freq = cpufreq_dev->freq_table[0];
+	cpufreq_dev->clipped_freq = cpufreq_dev->freq_table[0].frequency;
 	cpufreq_dev->cdev = cdev;
 	cpufreq_dev->policy = policy;
 
@@ -805,8 +789,6 @@ __cpufreq_cooling_register(struct device_node *np,
 
 remove_ida:
 	ida_simple_remove(&cpufreq_ida, cpufreq_dev->id);
-free_power_table:
-	kfree(cpufreq_dev->dyn_power_table);
 free_table:
 	kfree(cpufreq_dev->freq_table);
 free_time_in_idle_timestamp:
@@ -953,7 +935,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(cpufreq_dev->cdev);
 	ida_simple_remove(&cpufreq_ida, cpufreq_dev->id);
-	kfree(cpufreq_dev->dyn_power_table);
 	kfree(cpufreq_dev->time_in_idle_timestamp);
 	kfree(cpufreq_dev->time_in_idle);
 	kfree(cpufreq_dev->freq_table);
-- 
2.7.1.410.g6faf27b

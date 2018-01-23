From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 8/8] thermal/drivers/cpu_cooling: Add the combo cpu cooling device
Date: Tue, 23 Jan 2018 16:34:31 +0100
Message-ID: <1516721671-16360-9-git-send-email-daniel.lezcano@linaro.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The cpu cooling device has two strategies to cool down a SoC. The
first one decreases the OPP, the second one forces the cpus to enter a
cluster power down state during an amount of time.

The first cooling device has the benefit to simply decrease the OPP
until the temperature goes below the threshold and then increases the
OPP again. The change of the OPP back and forth allows to keep the cpu
temperature around the specified threshold. Unfortunately, in some
cases, the gap between the OPPs is high and decreasing the OPP makes
the cpu performance unoptimal.

The second cooling device keeps injecting more and more idle cycles
until the temperature stabilizes around the specified threshold. That
is simple and efficient in terms of cooling effect but with the
drawback of increasing the latency.

This new cooling device combines the cooling effect of both the
cpuidle and the cpufreq cooling devices by injecting idle cycle at the
upper OPP boundary of the power interval. When the power of the OPP
minus the idle injection time is equal to the OPP beneath, the cooling
device decreases the OPP and resets the idle injection cycles.

By this way, we can artifically create intermediate OPP by using the
power information found in the DT where we sum the benefit of both
cooling effects without the drawbacks.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/Kconfig       |   7 +
 drivers/thermal/cpu_cooling.c | 475 +++++++++++++++++++++++++++++++++++++-----
 include/linux/cpu_cooling.h   |  21 +-
 3 files changed, 438 insertions(+), 65 deletions(-)

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index 4bd4be7..200e1f49 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -176,6 +176,13 @@ config CPU_IDLE_THERMAL
 	 will enter idle synchronously to reach the deepest idle
 	 state.
 
+config CPU_THERMAL_COMBO
+	bool "CPU idle/freq combo cooling strategy"
+	depends on CPU_IDLE && CPU_FREQ
+	help
+	  The cpu combo cooling device combines the cooling effect of the
+	  cpufreq and the cpuidle cooling devices.
+
 endchoice
 
 config CLOCK_THERMAL
diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 916a627..a2459d6 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -8,6 +8,8 @@
  *
  *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
  *		Viresh Kumar <viresh.kumar@linaro.org>
+ *		Daniel Lezcano <daniel.lezcano@linaro.org>
+ *		Kevin WangTao <kevin.wangtao@linaro.org>
  *
  */
 #undef DEBUG
@@ -36,7 +38,7 @@
 
 #include <uapi/linux/sched/types.h>
 
-#ifdef CONFIG_CPU_FREQ_THERMAL
+#if defined(CONFIG_CPU_FREQ_THERMAL) || defined (CONFIG_CPU_THERMAL_COMBO)
 /*
  * Cooling state <-> CPUFreq frequency
  *
@@ -441,10 +443,9 @@ static int cpufreq_get_cur_state(struct thermal_cooling_device *cdev,
  *
  * Return: 0 on success, an error code otherwise.
  */
-static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
-				 unsigned long state)
+static int __cpufreq_set_cur_state(struct cpufreq_cooling_device *cpufreq_cdev,
+				   unsigned long state)
 {
-	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	unsigned int clip_freq;
 
 	/* Request state should be less than max_level */
@@ -464,6 +465,14 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
+static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
+				 unsigned long state)
+{
+	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
+
+	return __cpufreq_set_cur_state(cpufreq_cdev, state);
+}
+
 /**
  * cpufreq_get_requested_power() - get the current power
  * @cdev:	&thermal_cooling_device pointer
@@ -666,6 +675,25 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
 	return max;
 }
 
+#ifdef CONFIG_CPU_FREQ_THERMAL
+static struct thermal_cooling_device *
+__cpufreq_cooling_thermal_register(struct device_node *np, char *dev_name,
+				   struct cpufreq_cooling_device *cpufreq_cdev,
+				   struct thermal_cooling_device_ops *ops)
+{
+	return thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
+						  ops);
+}
+#else
+static inline struct thermal_cooling_device *
+__cpufreq_cooling_thermal_register(struct device_node *np, char *dev_name,
+				   struct cpufreq_cooling_device *cpufreq_cdev,
+				   struct thermal_cooling_device_ops *ops)
+{
+	return NULL;
+}
+#endif
+
 /**
  * __cpufreq_cooling_register - helper function to create cpufreq cooling device
  * @np: a valid struct device_node to the cooling device device tree node
@@ -769,7 +797,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		cooling_ops = &cpufreq_cooling_ops;
 	}
 
-	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
+	cdev = __cpufreq_cooling_thermal_register(np, dev_name, cpufreq_cdev,
 						  cooling_ops);
 	if (IS_ERR(cdev))
 		goto remove_ida;
@@ -944,7 +972,7 @@ EXPORT_SYMBOL_GPL(cpufreq_cooling_unregister);
 
 #endif /* CPU_FREQ_THERMAL */
 
-#ifdef CONFIG_CPU_IDLE_THERMAL
+#if defined(CONFIG_CPU_IDLE_THERMAL) || defined(CONFIG_CPU_THERMAL_COMBO)
 /*
  * The idle duration injection. As we don't have yet a way to specify
  * from the DT configuration, let's default to a tick duration.
@@ -1130,6 +1158,60 @@ static int cpuidle_cooling_injection_thread(void *arg)
 }
 
 /**
+ * cpuidle_cooling_set_cur_state - Set the current cooling state
+ * @cdev: the thermal cooling device
+ * @state: the target state
+ *
+ * The function checks first if we are initiating the mitigation which
+ * in turn wakes up all the idle injection tasks belonging to the idle
+ * cooling device. In any case, it updates the internal state for the
+ * cooling device.
+ *
+ * The function can not fail, it returns always zero.
+ */
+static int
+__cpuidle_cooling_set_cur_state(struct cpuidle_cooling_device *idle_cdev,
+				unsigned long state)
+{
+	unsigned long current_state = idle_cdev->state;
+
+	idle_cdev->state = state;
+
+	if (current_state == 0 && state > 0) {
+		pr_debug("Starting cooling cpus '%*pbl'\n",
+			 cpumask_pr_args(idle_cdev->cpumask));
+		cpuidle_cooling_wakeup(idle_cdev);
+	} else if (current_state > 0 && !state)  {
+		pr_debug("Stopping cooling cpus '%*pbl'\n",
+			 cpumask_pr_args(idle_cdev->cpumask));
+	}
+
+	return 0;
+}
+
+/**
+ * cpuidle_cooling_release - Kref based release helper
+ * @kref: a pointer to the kref structure
+ *
+ * This function is automatically called by the kref_put function when
+ * the idle cooling device refcount reaches zero. At this point, we
+ * have the guarantee the structure is no longer in use and we can
+ * safely release all the ressources.
+ */
+static void __init cpuidle_cooling_release(struct kref *kref)
+{
+	struct cpuidle_cooling_device *idle_cdev =
+		container_of(kref, struct cpuidle_cooling_device, kref);
+
+	thermal_cooling_device_unregister(idle_cdev->cdev);
+	kfree(idle_cdev->waitq);
+	kfree(idle_cdev->tsk);
+	kfree(idle_cdev);
+}
+
+#ifdef CONFIG_CPU_IDLE_THERMAL
+
+/**
  * cpuidle_cooling_get_max_state - Get the maximum state
  * @cdev  : the thermal cooling device
  * @state : a pointer to the state variable to be filled
@@ -1178,36 +1260,12 @@ static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
-/**
- * cpuidle_cooling_set_cur_state - Set the current cooling state
- * @cdev: the thermal cooling device
- * @state: the target state
- *
- * The function checks first if we are initiating the mitigation which
- * in turn wakes up all the idle injection tasks belonging to the idle
- * cooling device. In any case, it updates the internal state for the
- * cooling device.
- *
- * The function can not fail, it returns always zero.
- */
 static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
 					 unsigned long state)
 {
 	struct cpuidle_cooling_device *idle_cdev = cdev->devdata;
-	unsigned long current_state = idle_cdev->state;
-
-	idle_cdev->state = state;
-
-	if (current_state == 0 && state > 0) {
-		pr_debug("Starting cooling cpus '%*pbl'\n",
-			 cpumask_pr_args(idle_cdev->cpumask));
-		cpuidle_cooling_wakeup(idle_cdev);
-	} else if (current_state > 0 && !state)  {
-		pr_debug("Stopping cooling cpus '%*pbl'\n",
-			 cpumask_pr_args(idle_cdev->cpumask));
-	}
 
-	return 0;
+	return __cpuidle_cooling_set_cur_state(idle_cdev, state);
 }
 
 /**
@@ -1219,25 +1277,30 @@ static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
 	.set_cur_state = cpuidle_cooling_set_cur_state,
 };
 
-/**
- * cpuidle_cooling_release - Kref based release helper
- * @kref: a pointer to the kref structure
- *
- * This function is automatically called by the kref_put function when
- * the idle cooling device refcount reaches zero. At this point, we
- * have the guarantee the structure is no longer in use and we can
- * safely release all the ressources.
- */
-static void __init cpuidle_cooling_release(struct kref *kref)
+static int __cpuidle_cooling_thermal_register(struct device_node *np,
+					      struct cpuidle_cooling_device *idle_cdev,
+					      char *dev_name)
 {
-	struct cpuidle_cooling_device *idle_cdev =
-		container_of(kref, struct cpuidle_cooling_device, kref);
+	struct thermal_cooling_device *cdev;
 
-	thermal_cooling_device_unregister(idle_cdev->cdev);
-	kfree(idle_cdev->waitq);
-	kfree(idle_cdev->tsk);
-	kfree(idle_cdev);
+	cdev = thermal_of_cooling_device_register(np, dev_name,
+						  idle_cdev,
+						  &cpuidle_cooling_ops);
+	if (IS_ERR(cdev))
+		return PTR_ERR(cdev);
+
+	idle_cdev->cdev = cdev;
+
+	return 0;
 }
+#else
+static inline int __cpuidle_cooling_thermal_register(struct device_node *np,
+						     struct cpuidle_cooling_device *idle_cdev,
+						     char *dev_name)
+{
+	return 0;
+}
+#endif
 
 /**
  * cpuidle_cooling_register - Idle cooling device initialization function
@@ -1256,7 +1319,6 @@ static void __init cpuidle_cooling_release(struct kref *kref)
 int cpuidle_cooling_register(void)
 {
 	struct cpuidle_cooling_device *idle_cdev = NULL;
-	struct thermal_cooling_device *cdev;
 	struct task_struct *tsk;
 	struct device_node *np;
 	cpumask_t *cpumask;
@@ -1319,15 +1381,10 @@ int cpuidle_cooling_register(void)
 			 * The thermal cooling device name
 			 */
 			snprintf(dev_name, sizeof(dev_name), "thermal-idle-%d", index++);
-			cdev = thermal_of_cooling_device_register(np, dev_name,
-								  idle_cdev,
-								  &cpuidle_cooling_ops);
-			if (IS_ERR(cdev)) {
-				ret = PTR_ERR(cdev);
-				goto out_fail;
-			}
 
-			idle_cdev->cdev = cdev;
+			ret = __cpuidle_cooling_thermal_register(np, idle_cdev, dev_name);
+			if (ret)
+				goto out_fail;
 
 			idle_cdev->cpumask = cpumask;
 
@@ -1397,3 +1454,309 @@ int cpuidle_cooling_register(void)
 	return ret;
 }
 #endif
+
+#ifdef CONFIG_CPU_THERMAL_COMBO
+/**
+ * struct cpu_cooling_device - the cpu cooling device
+ * @cpuidle_cdev: a pointer to the instanciated cpuidle cooling device
+ * @cpufreq_cdev: a pointer to the instanciated cpufreq cooling device
+ * @max_power: the maximum power managed by the cooling device
+ * @state: the current cooling device state
+ *
+ * The SoC could have different designs. If the SoC is a single
+ * cluster, we have a single clock line for cpufreq and single cluster
+ * powerdown state. If the SoC is a dual cluster we can have a single
+ * clock line for cpufreq and a cluster power down, hence two cpuidle
+ * cooling device. Alternatively, we can have two clock lines.
+ *
+ * 1 cluster - 1 clock line (eg. db410c): There is one cpuidle cooling
+ * device and one cpufreq cooling device. Consequently, there is one
+ * cpu cooling device where the cpuidle_cdev and the cpufreq_cdev
+ * pointers point to the corresponding cooling device instances.
+ *
+ * 2 clusters - 1 clock line (eg. hi6220) : There are two cpuidle
+ * cooling devices and one cpufreq cooling device. It results in two
+ * cpu cooling devices where the cpuidle_cdev points to the cpuidle
+ * instance and the cpufreq_cdev contains a shared pointer to the
+ * cpufreq cooling device. This configuration makes the power
+ * computation to be ponderated by the number of cpus managed by the
+ * cpuidle cooling device.
+ *
+ * 2 clusters - 2 clock lines (eg. hi3660): There are two cpuidle
+ * cooling devices, two cpufreq cooling devices and two cpu cooling
+ * devices.
+ */
+struct cpu_cooling_device {
+	struct cpuidle_cooling_device *cpuidle_cdev;
+	struct cpufreq_cooling_device *cpufreq_cdev;
+	u32 max_power;
+	int state;
+};
+
+/*
+ * The combo CPU cooling device combines the OPP states and the idle
+ * injection cycles in order to provide an intermediate state where we
+ * meet the power budget but without decreasing the OPP. That allows
+ * to keep a higher OPP while reducing the dissipated power. For
+ * example, using the cpufreq cooling device only, we may have to
+ * downgrade the OPP because the current one dissipates too much power
+ * but by downgrading the OPP, we still have room for more power. So
+ * the perfect match would have be in between these two OPPs.
+ *
+ * For example, let's imagine we have 4 cores ruled by a cpufreq
+ * driver with 2 OPPs consuming respectively 250mW and 500mW per
+ * core. With all CPUs loaded at 100%, at the highest OPP, we have
+ * 2000mW of dissipated power for the cluster. Now the thermal
+ * framework allocates 1500mW of power budget. We can decrease to the
+ * other OPP where we end up consuming 1000mW but we still have room
+ * for 500mw. Alternatively, we can stay at the highest OPP but force
+ * to be idle 25% of the time (2000 - 1500) / 1500.
+ *
+ * By inserting idle cycles at a specific OPP, we can reduce the power
+ * without decreasing the OPP, which results on a better power /
+ * performance trade-off.
+ *
+ * The combo CPU cooling device works in a percentile way, the states
+ * represent the percentage of power we want to save. The combo device
+ * is in charge of setting the state for the idle injection cooling
+ * device and the cpufreq cooling device, as well as sorting out when
+ * to go to a specific OPP or/and insert idle cycles.
+ */
+
+/**
+ * cpu_cooling_get_max_state - Return the maximum number of states
+ * @cdev  : the thermal cooling device
+ * @state : a pointer to the state variable to be filled
+ *
+ * The function gives always 100 as a percentage of the maximum power
+ * on the thermal zone.
+ *
+ * The function can not fail, it returns always zero.
+ */
+static int cpu_cooling_get_max_state(struct thermal_cooling_device *cdev,
+				     unsigned long *state)
+{
+	*state = 100;
+	return 0;
+}
+
+/**
+ * cpu_cooling_power_opp - Find the upper OPP for a specific power
+ * @cpufreq_cdev: the cpufreq cooling device
+ * @num_cpus: the number of cpus managed by the idle cooling device
+ * @power: the requested power
+ *
+ * The function returns the OPP which is the upper limit of the power
+ * interval between two OPPs. It is imposible the requested power is
+ * greater than the maximum power of the cluster.
+ *
+ * Returns an index in the freq_table on success, -EINVAL if the
+ * requested power is invalid (zero or greater than the maximum
+ * cluster power).
+ */
+static int cpu_cooling_power_opp(struct cpufreq_cooling_device *cpufreq_cdev,
+				 int num_cpus, u32 power)
+{
+	struct freq_table *freq_table = cpufreq_cdev->freq_table;
+	int i;
+
+	if (!power || power > freq_table[0].power * num_cpus)
+		return -EINVAL;
+
+	for (i = 0; i < cpufreq_cdev->max_level - 1; i++) {
+
+		if (power <= (freq_table[i].power * num_cpus) &&
+		    power > (freq_table[i + 1].power * num_cpus))
+			break;
+	}
+
+	return i;
+}
+
+/**
+ * cpu_cooling_set_cur_state - Sets a percentage of the max power
+ * @cdev: the thermal cooling device
+ * @state: the target state representing a ratio
+ *
+ * The function computes the power ratio of the OPP and the
+ * corresponding idle ratio to reach the requested state. The state is
+ * a percentage of the maximum power.
+ *
+ * The function returns zero on success, -EINVAL if the ratio
+ * computation fails any reason, < 0 for the set_cur_state subcalls
+ * failure on the cpuidle / cpufreq cooling devices.
+ */
+static int cpu_cooling_set_cur_state(struct thermal_cooling_device *cdev,
+				     unsigned long state)
+{
+	struct cpu_cooling_device *cpu_cdev = cdev->devdata;
+	struct cpuidle_cooling_device *cpuidle_cdev = cpu_cdev->cpuidle_cdev;
+	struct cpufreq_cooling_device *cpufreq_cdev = cpu_cdev->cpufreq_cdev;
+	int num_cpus = cpumask_weight(cpuidle_cdev->cpumask);
+	int opp_index, idle_state, ret;
+	u32 power, opp_power;
+
+	/*
+	 * The state gives the percentage of the maximum power on the
+	 * thermal zone the cooling device is handling.
+	 *
+	 * In order to find out which OPP must be selected and the
+	 * percentage of idle time to be injected, we must compute
+	 * first how much power represents the requested percentage.
+	 *
+	 * For this we apply a simple ratio:
+	 *
+	 * requested_power = (max_power * pct) / 100
+	 */
+	power = (cpu_cdev->max_power * (100 - state)) / 100;
+
+	/*
+	 * The second step is to sort out which OPP it does apply and
+	 * how much power it represents. We must convert in a CPU
+	 * basis to browse the freq table.
+	 *
+	 * Pitfall: Don't compare in the function with power /
+	 * num_cpus but with opp.power * num_cpus. Otherwise, because
+	 * of the rounding effect, we end up with a power lesser than
+	 * the opp power and then with a negative value in the idle
+	 * ratio computation a few lines below.
+	 */
+	opp_index = cpu_cooling_power_opp(cpufreq_cdev, num_cpus, power);
+	if (opp_index < 0)
+		return opp_index;
+
+	/*
+	 * The third step is to compute the percentage of idle time
+	 * regarding the dissipated power for the selected OPP above.
+	 */
+	opp_power = cpufreq_cdev->freq_table[opp_index].power * num_cpus;
+
+	idle_state = ((opp_power - power) * 100) / power;
+
+	/*
+	 * Catch unexpected situation where we are out of bound of the
+	 * idle state percentage values.
+	 */
+	if (WARN_ON_ONCE(idle_state < 0 || idle_state > 100))
+		return -EINVAL;
+
+	/*
+	 * Set the cpufreq OPP state
+	 */
+	ret = __cpufreq_set_cur_state(cpufreq_cdev, opp_index);
+	if (ret)
+		return ret;
+
+	/*
+	 * And inject idle cycles to reduce the power
+	 */
+	ret = __cpuidle_cooling_set_cur_state(cpuidle_cdev, idle_state);
+	if (ret)
+		return ret;
+
+	cpu_cdev->state = state;
+
+	return 0;
+}
+
+/**
+ * cpu_cooling_get_cur_state - Gets the percentage of the max power
+ * @cdev  : the thermal cooling device
+ * @state : a pointer to the state variable to be filled
+ *
+ * Fill the state pointer variable with the current state of the cpu
+ * cooling device, the value is between 0 and 100 (included).
+ *
+ * The function never fails and returns zero.
+ */
+static int cpu_cooling_get_cur_state(struct thermal_cooling_device *cdev,
+				     unsigned long *state)
+{
+        struct cpu_cooling_device *cpu_cdev = cdev->devdata;
+
+	*state = cpu_cdev->state;
+
+	return 0;
+}
+
+/**
+ * cpu_cooling_ops - thermal cooling device ops
+ */
+static struct thermal_cooling_device_ops cpu_cooling_ops = {
+	.get_max_state = cpu_cooling_get_max_state,
+	.get_cur_state = cpu_cooling_get_cur_state,
+	.set_cur_state = cpu_cooling_set_cur_state,
+};
+
+static int __init cpu_cooling_init(void)
+{
+	struct thermal_cooling_device *cdev;
+	struct cpu_cooling_device *cpu_cdev;
+	struct cpuidle_cooling_device *cpuidle_cdev;
+	struct cpufreq_cooling_device *cpufreq_cdev;
+	struct device_node *np;
+	cpumask_t *cpumask;
+	char dev_name[THERMAL_NAME_LENGTH];
+	int cpu, index = 0;
+
+	for_each_possible_cpu(cpu) {
+
+		cpumask = topology_core_cpumask(cpu);
+
+		if (cpu != cpumask_first(cpumask))
+			continue;
+
+		np = of_cpu_device_node_get(cpu);
+
+		cpu_cdev = kzalloc(sizeof(*cpu_cdev), GFP_KERNEL);
+		if (!cpu_cdev)
+			return -ENOMEM;
+
+		list_for_each_entry(cpuidle_cdev,
+				    &cpuidle_cdev_list, node) {
+
+			cpumask = cpuidle_cdev->cpumask;
+			if (!cpumask_test_cpu(cpu, cpumask))
+				continue;
+
+			cpu_cdev->cpuidle_cdev = cpuidle_cdev;
+			break;
+		}
+
+		list_for_each_entry(cpufreq_cdev,
+				    &cpufreq_cdev_list, node) {
+
+			cpumask = cpufreq_cdev->policy->related_cpus;
+			if (!cpumask_test_cpu(cpu, cpumask))
+				continue;
+
+			cpu_cdev->cpufreq_cdev = cpufreq_cdev;
+			break;
+		}
+
+		if (!cpu_cdev->cpuidle_cdev || !cpu_cdev->cpufreq_cdev) {
+			pr_err("Something is going wrong with the CPU cooling device\n");
+			return -EINVAL;
+		}
+
+		if (!cpufreq_cdev->freq_table[0].power) {
+			pr_err("No power number for the platform\n");
+			return -EINVAL;
+		}
+
+		cpu_cdev->max_power = cpufreq_cdev->freq_table[0].power;
+		cpu_cdev->max_power *= cpumask_weight(cpuidle_cdev->cpumask);
+
+		snprintf(dev_name, sizeof(dev_name),
+			 "thermal-cpu-%d", index++);
+		cdev = thermal_of_cooling_device_register(np, dev_name,
+							  cpu_cdev,
+							  &cpu_cooling_ops);
+		if (IS_ERR(cdev))
+			return PTR_ERR(cdev);
+	}
+
+	return 0;
+}
+late_initcall(cpu_cooling_init);
+#endif
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index 2b5950b..308a914 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -33,7 +33,16 @@ struct cpufreq_policy;
 typedef int (*get_static_t)(cpumask_t *cpumask, int interval,
 			    unsigned long voltage, u32 *power);
 
-#ifdef CONFIG_CPU_THERMAL
+#if defined(CONFIG_CPU_IDLE_THERMAL) || defined(CONFIG_CPU_THERMAL_COMBO)
+extern int cpuidle_cooling_register(void);
+#else
+static inline int cpuidle_cooling_register(void)
+{
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_CPU_FREQ_THERMAL) || defined(CONFIG_CPU_THERMAL_COMBO)
 /**
  * cpufreq_cooling_register - function to create cpufreq cooling device.
  * @policy: cpufreq policy.
@@ -45,7 +54,6 @@ struct thermal_cooling_device *
 cpufreq_power_cooling_register(struct cpufreq_policy *policy,
 			       u32 capacitance, get_static_t plat_static_func);
 
-extern int cpuidle_cooling_register(void);
 /**
  * of_cpufreq_cooling_register - create cpufreq cooling device based on DT.
  * @np: a valid struct device_node to the cooling device device tree node.
@@ -85,7 +93,7 @@ of_cpufreq_power_cooling_register(struct device_node *np,
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 
-#else /* !CONFIG_CPU_THERMAL */
+#else /* !CONFIG_CPU_FREQ_THERMAL */
 static inline struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
@@ -119,11 +127,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	return;
 }
-
-static inline int cpuidle_cooling_register(void)
-{
-	return 0;
-}
-#endif	/* CONFIG_CPU_THERMAL */
+#endif	/* CONFIG_CPU_FREQ_THERMAL */
 
 #endif /* __CPU_COOLING_H__ */
-- 
2.7.4

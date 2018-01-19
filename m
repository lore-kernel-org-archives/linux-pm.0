From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v3 2/2] thermal: cpu_cooling: use power models from the OPP library
Date: Fri, 19 Jan 2018 09:45:49 +0000
Message-ID: <20180119094549.5468-3-quentin.perret@arm.com>
References: <20180119094549.5468-1-quentin.perret@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36560 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754973AbeASJqI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jan 2018 04:46:08 -0500
In-Reply-To: <20180119094549.5468-1-quentin.perret@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, vireshk@kernel.org, nm@ti.com, sboyd@codeaurora.org, sudeep.holla@arm.com, amit.kachhap@gmail.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, matthias.bgg@gmail.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, patrick.bellasi@arm.com, ionela.voinescu@arm.com, joelaf@google.com, tkjos@google.com, Quentin Perret <quentin.perret@arm.com>

Now that the OPP library features a power estimator, the existing code
in IPA can be modified to rely only on dev_pm_opp_get_power() without
having to care about the dynamic-power-coefficient DT binding.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 drivers/thermal/cpu_cooling.c | 56 ++++++++++++++++---------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfd23245f778..8eda2de2a20d 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -187,7 +187,8 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 /**
  * update_freq_table() - Update the freq table with power numbers
  * @cpufreq_cdev:	the cpufreq cooling device in which to update the table
- * @capacitance: dynamic power coefficient for these cpus
+ * @found_power:	boolean indicating if a power model was available for
+ *			the cooling device
  *
  * Update the freq table with power numbers.  This table will be used in
  * cpu_power_to_freq() and cpu_freq_to_power() to convert between power and
@@ -198,7 +199,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
  * or -ENOMEM if we run out of memory.
  */
 static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
-			     u32 capacitance)
+			     bool *found_power)
 {
 	struct freq_table *freq_table = cpufreq_cdev->freq_table;
 	struct dev_pm_opp *opp;
@@ -225,11 +226,10 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
 		return -EINVAL;
 	}
 
+	*found_power = true;
+
 	for (i = 0; i <= cpufreq_cdev->max_level; i++) {
-		unsigned long freq = freq_table[i].frequency * 1000;
-		u32 freq_mhz = freq_table[i].frequency / 1000;
-		u64 power;
-		u32 voltage_mv;
+		unsigned long power, freq = freq_table[i].frequency * 1000;
 
 		/*
 		 * Find ceil frequency as 'freq' may be slightly lower than OPP
@@ -242,18 +242,12 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
 			return -EINVAL;
 		}
 
-		voltage_mv = dev_pm_opp_get_voltage(opp) / 1000;
-		dev_pm_opp_put(opp);
-
-		/*
-		 * Do the multiplication with MHz and millivolt so as
-		 * to not overflow.
-		 */
-		power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
-		do_div(power, 1000000000);
-
 		/* power is stored in mW */
+		power = dev_pm_opp_get_power(opp) / 1000;
+		dev_pm_opp_put(opp);
 		freq_table[i].power = power;
+		if (!power)
+			*found_power = false;
 	}
 
 	return 0;
@@ -594,7 +588,6 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
  * @np: a valid struct device_node to the cooling device device tree node
  * @policy: cpufreq policy
  * Normally this should be same as cpufreq policy->related_cpus.
- * @capacitance: dynamic power coefficient for these cpus
  *
  * This interface function registers the cpufreq cooling device with the name
  * "thermal-cpufreq-%x". This api can support multiple instances of cpufreq
@@ -606,7 +599,7 @@ static unsigned int find_next_max(struct cpufreq_frequency_table *table,
  */
 static struct thermal_cooling_device *
 __cpufreq_cooling_register(struct device_node *np,
-			struct cpufreq_policy *policy, u32 capacitance)
+			struct cpufreq_policy *policy)
 {
 	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
@@ -614,7 +607,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	unsigned int freq, i, num_cpus;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
-	bool first;
+	bool first, found_power;
 
 	if (IS_ERR_OR_NULL(policy)) {
 		pr_err("%s: cpufreq policy isn't valid: %p\n", __func__, policy);
@@ -675,18 +668,15 @@ __cpufreq_cooling_register(struct device_node *np,
 			pr_debug("%s: freq:%u KHz\n", __func__, freq);
 	}
 
-	if (capacitance) {
-		ret = update_freq_table(cpufreq_cdev, capacitance);
-		if (ret) {
-			cdev = ERR_PTR(ret);
-			goto remove_ida;
-		}
-
-		cooling_ops = &cpufreq_power_cooling_ops;
-	} else {
-		cooling_ops = &cpufreq_cooling_ops;
+	ret = update_freq_table(cpufreq_cdev, &found_power);
+	if (ret) {
+		cdev = ERR_PTR(ret);
+		goto remove_ida;
 	}
 
+	cooling_ops = found_power ? &cpufreq_power_cooling_ops :
+				    &cpufreq_cooling_ops;
+
 	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
 						  cooling_ops);
 	if (IS_ERR(cdev))
@@ -732,7 +722,7 @@ __cpufreq_cooling_register(struct device_node *np,
 struct thermal_cooling_device *
 cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
-	return __cpufreq_cooling_register(NULL, policy, 0);
+	return __cpufreq_cooling_register(NULL, policy);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cooling_register);
 
@@ -760,7 +750,6 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 {
 	struct device_node *np = of_get_cpu_node(policy->cpu, NULL);
 	struct thermal_cooling_device *cdev = NULL;
-	u32 capacitance = 0;
 
 	if (!np) {
 		pr_err("cpu_cooling: OF node not available for cpu%d\n",
@@ -769,10 +758,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 	}
 
 	if (of_find_property(np, "#cooling-cells", NULL)) {
-		of_property_read_u32(np, "dynamic-power-coefficient",
-				     &capacitance);
-
-		cdev = __cpufreq_cooling_register(np, policy, capacitance);
+		cdev = __cpufreq_cooling_register(np, policy);
 		if (IS_ERR(cdev)) {
 			pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
 			       policy->cpu, PTR_ERR(cdev));
-- 
2.15.1

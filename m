From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/17] thermal: cpu_cooling: replace cool_dev with cdev
Date: Thu, 16 Mar 2017 10:59:39 +0530
Message-ID: <7fd9ac075f06fb673c2e18b3c5aab9e41910ed12.1489640000.git.viresh.kumar@linaro.org>
References: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Objects of "struct thermal_cooling_device" are named a bit
inconsistently. Lets use cdev everywhere.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 7a19033d7f79..e2931c20c309 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -65,7 +65,7 @@ struct power_table {
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
  * @id: unique integer value corresponding to each cpufreq_cooling_device
  *	registered.
- * @cool_dev: thermal_cooling_device pointer to keep track of the
+ * @cdev: thermal_cooling_device pointer to keep track of the
  *	registered cooling device.
  * @cpufreq_state: integer value representing the current state of cpufreq
  *	cooling	devices.
@@ -90,7 +90,7 @@ struct power_table {
  */
 struct cpufreq_cooling_device {
 	int id;
-	struct thermal_cooling_device *cool_dev;
+	struct thermal_cooling_device *cdev;
 	unsigned int cpufreq_state;
 	unsigned int clipped_freq;
 	unsigned int max_level;
@@ -243,7 +243,7 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_dev,
 	for_each_cpu(cpu, &cpufreq_dev->allowed_cpus) {
 		dev = get_cpu_device(cpu);
 		if (!dev) {
-			dev_warn(&cpufreq_dev->cool_dev->device,
+			dev_warn(&cpufreq_dev->cdev->device,
 				 "No cpu device for cpu %d\n", cpu);
 			continue;
 		}
@@ -770,7 +770,7 @@ __cpufreq_cooling_register(struct device_node *np,
 			get_static_t plat_static_func)
 {
 	struct cpufreq_policy *policy;
-	struct thermal_cooling_device *cool_dev;
+	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_dev;
 	char dev_name[THERMAL_NAME_LENGTH];
 	struct cpufreq_frequency_table *pos, *table;
@@ -786,20 +786,20 @@ __cpufreq_cooling_register(struct device_node *np,
 	policy = cpufreq_cpu_get(cpumask_first(temp_mask));
 	if (!policy) {
 		pr_debug("%s: CPUFreq policy not found\n", __func__);
-		cool_dev = ERR_PTR(-EPROBE_DEFER);
+		cdev = ERR_PTR(-EPROBE_DEFER);
 		goto free_cpumask;
 	}
 
 	table = policy->freq_table;
 	if (!table) {
 		pr_debug("%s: CPUFreq table not found\n", __func__);
-		cool_dev = ERR_PTR(-ENODEV);
+		cdev = ERR_PTR(-ENODEV);
 		goto put_policy;
 	}
 
 	cpufreq_dev = kzalloc(sizeof(*cpufreq_dev), GFP_KERNEL);
 	if (!cpufreq_dev) {
-		cool_dev = ERR_PTR(-ENOMEM);
+		cdev = ERR_PTR(-ENOMEM);
 		goto put_policy;
 	}
 
@@ -808,7 +808,7 @@ __cpufreq_cooling_register(struct device_node *np,
 					    sizeof(*cpufreq_dev->time_in_idle),
 					    GFP_KERNEL);
 	if (!cpufreq_dev->time_in_idle) {
-		cool_dev = ERR_PTR(-ENOMEM);
+		cdev = ERR_PTR(-ENOMEM);
 		goto free_cdev;
 	}
 
@@ -816,7 +816,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		kcalloc(num_cpus, sizeof(*cpufreq_dev->time_in_idle_timestamp),
 			GFP_KERNEL);
 	if (!cpufreq_dev->time_in_idle_timestamp) {
-		cool_dev = ERR_PTR(-ENOMEM);
+		cdev = ERR_PTR(-ENOMEM);
 		goto free_time_in_idle;
 	}
 
@@ -827,7 +827,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	cpufreq_dev->freq_table = kmalloc(sizeof(*cpufreq_dev->freq_table) *
 					  cpufreq_dev->max_level, GFP_KERNEL);
 	if (!cpufreq_dev->freq_table) {
-		cool_dev = ERR_PTR(-ENOMEM);
+		cdev = ERR_PTR(-ENOMEM);
 		goto free_time_in_idle_timestamp;
 	}
 
@@ -841,7 +841,7 @@ __cpufreq_cooling_register(struct device_node *np,
 
 		ret = build_dyn_power_table(cpufreq_dev, capacitance);
 		if (ret) {
-			cool_dev = ERR_PTR(ret);
+			cdev = ERR_PTR(ret);
 			goto free_table;
 		}
 
@@ -852,7 +852,7 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	ret = ida_simple_get(&cpufreq_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
-		cool_dev = ERR_PTR(ret);
+		cdev = ERR_PTR(ret);
 		goto free_power_table;
 	}
 	cpufreq_dev->id = ret;
@@ -872,13 +872,13 @@ __cpufreq_cooling_register(struct device_node *np,
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
 		 cpufreq_dev->id);
 
-	cool_dev = thermal_of_cooling_device_register(np, dev_name, cpufreq_dev,
-						      cooling_ops);
-	if (IS_ERR(cool_dev))
+	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_dev,
+						  cooling_ops);
+	if (IS_ERR(cdev))
 		goto remove_ida;
 
 	cpufreq_dev->clipped_freq = cpufreq_dev->freq_table[0];
-	cpufreq_dev->cool_dev = cool_dev;
+	cpufreq_dev->cdev = cdev;
 
 	mutex_lock(&cooling_list_lock);
 	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
@@ -907,7 +907,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	cpufreq_cpu_put(policy);
 free_cpumask:
 	free_cpumask_var(temp_mask);
-	return cool_dev;
+	return cdev;
 }
 
 /**
@@ -1043,7 +1043,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 	list_del(&cpufreq_dev->node);
 	mutex_unlock(&cooling_list_lock);
 
-	thermal_cooling_device_unregister(cpufreq_dev->cool_dev);
+	thermal_cooling_device_unregister(cpufreq_dev->cdev);
 	ida_simple_remove(&cpufreq_ida, cpufreq_dev->id);
 	kfree(cpufreq_dev->dyn_power_table);
 	kfree(cpufreq_dev->time_in_idle_timestamp);
-- 
2.7.1.410.g6faf27b

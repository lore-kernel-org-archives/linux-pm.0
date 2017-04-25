From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 04/17] thermal: cpu_cooling: replace cool_dev with cdev
Date: Tue, 25 Apr 2017 15:57:11 +0530
Message-ID: <0f1d7f8ebc3915c46b8fa7656a972bee75c79ba4.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:33373 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1429521AbdDYK1n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Apr 2017 06:27:43 -0400
Received: by mail-pg0-f42.google.com with SMTP id 63so26529843pgh.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Apr 2017 03:27:42 -0700 (PDT)
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

Objects of "struct thermal_cooling_device" are named a bit
inconsistently. Lets use cdev everywhere.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpu_cooling.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 80a46a80817b..f1e784c22c5a 100644
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
@@ -242,7 +242,7 @@ static int build_dyn_power_table(struct cpufreq_cooling_device *cpufreq_cdev,
 	for_each_cpu(cpu, &cpufreq_cdev->allowed_cpus) {
 		dev = get_cpu_device(cpu);
 		if (!dev) {
-			dev_warn(&cpufreq_cdev->cool_dev->device,
+			dev_warn(&cpufreq_cdev->cdev->device,
 				 "No cpu device for cpu %d\n", cpu);
 			continue;
 		}
@@ -769,7 +769,7 @@ __cpufreq_cooling_register(struct device_node *np,
 			get_static_t plat_static_func)
 {
 	struct cpufreq_policy *policy;
-	struct thermal_cooling_device *cool_dev;
+	struct thermal_cooling_device *cdev;
 	struct cpufreq_cooling_device *cpufreq_cdev;
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
 
 	cpufreq_cdev = kzalloc(sizeof(*cpufreq_cdev), GFP_KERNEL);
 	if (!cpufreq_cdev) {
-		cool_dev = ERR_PTR(-ENOMEM);
+		cdev = ERR_PTR(-ENOMEM);
 		goto put_policy;
 	}
 
@@ -808,7 +808,7 @@ __cpufreq_cooling_register(struct device_node *np,
 					    sizeof(*cpufreq_cdev->time_in_idle),
 					    GFP_KERNEL);
 	if (!cpufreq_cdev->time_in_idle) {
-		cool_dev = ERR_PTR(-ENOMEM);
+		cdev = ERR_PTR(-ENOMEM);
 		goto free_cdev;
 	}
 
@@ -816,7 +816,7 @@ __cpufreq_cooling_register(struct device_node *np,
 		kcalloc(num_cpus, sizeof(*cpufreq_cdev->time_in_idle_timestamp),
 			GFP_KERNEL);
 	if (!cpufreq_cdev->time_in_idle_timestamp) {
-		cool_dev = ERR_PTR(-ENOMEM);
+		cdev = ERR_PTR(-ENOMEM);
 		goto free_time_in_idle;
 	}
 
@@ -827,7 +827,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	cpufreq_cdev->freq_table = kmalloc(sizeof(*cpufreq_cdev->freq_table) *
 					  cpufreq_cdev->max_level, GFP_KERNEL);
 	if (!cpufreq_cdev->freq_table) {
-		cool_dev = ERR_PTR(-ENOMEM);
+		cdev = ERR_PTR(-ENOMEM);
 		goto free_time_in_idle_timestamp;
 	}
 
@@ -841,7 +841,7 @@ __cpufreq_cooling_register(struct device_node *np,
 
 		ret = build_dyn_power_table(cpufreq_cdev, capacitance);
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
 	cpufreq_cdev->id = ret;
@@ -872,14 +872,13 @@ __cpufreq_cooling_register(struct device_node *np,
 	snprintf(dev_name, sizeof(dev_name), "thermal-cpufreq-%d",
 		 cpufreq_cdev->id);
 
-	cool_dev = thermal_of_cooling_device_register(np, dev_name,
-						      cpufreq_cdev,
-						      cooling_ops);
-	if (IS_ERR(cool_dev))
+	cdev = thermal_of_cooling_device_register(np, dev_name, cpufreq_cdev,
+						  cooling_ops);
+	if (IS_ERR(cdev))
 		goto remove_ida;
 
 	cpufreq_cdev->clipped_freq = cpufreq_cdev->freq_table[0];
-	cpufreq_cdev->cool_dev = cool_dev;
+	cpufreq_cdev->cdev = cdev;
 
 	mutex_lock(&cooling_list_lock);
 	/* Register the notifier for first cpufreq cooling device */
@@ -909,7 +908,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	cpufreq_cpu_put(policy);
 free_cpumask:
 	free_cpumask_var(temp_mask);
-	return cool_dev;
+	return cdev;
 }
 
 /**
@@ -1047,7 +1046,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 		cpufreq_unregister_notifier(&thermal_cpufreq_notifier_block,
 					    CPUFREQ_POLICY_NOTIFIER);
 
-	thermal_cooling_device_unregister(cpufreq_cdev->cool_dev);
+	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 	kfree(cpufreq_cdev->dyn_power_table);
 	kfree(cpufreq_cdev->time_in_idle_timestamp);
-- 
2.12.0.432.g71c3a4f4ba37

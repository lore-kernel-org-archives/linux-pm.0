From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 13/17] thermal: cpu_cooling: create structure for idle time stats
Date: Mon, 17 Apr 2017 11:31:58 +0530
Message-ID: <84851c4b126392ad353388a3413941476644f1a0.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

We keep two arrays for idle time stats and allocate memory for them
separately. It would be much easier to follow if we create an array of
idle stats structure instead and allocate it once.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 53 ++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 4702a9821c1e..fa29f830fdc0 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -62,6 +62,16 @@ struct freq_table {
 };
 
 /**
+ * struct time_in_idle - Idle time stats
+ * @time: previous reading of the absolute time that this cpu was idle
+ * @timestamp: wall time of the last invocation of get_cpu_idle_time_us()
+ */
+struct time_in_idle {
+	u64 time;
+	u64 timestamp;
+};
+
+/**
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
  * @id: unique integer value corresponding to each cpufreq_cooling_device
  *	registered.
@@ -76,9 +86,7 @@ struct freq_table {
  *	cpufreq frequencies.
  * @node: list_head to link all cpufreq_cooling_device together.
  * @last_load: load measured by the latest call to cpufreq_get_requested_power()
- * @time_in_idle: previous reading of the absolute time that this cpu was idle
- * @time_in_idle_timestamp: wall time of the last invocation of
- *	get_cpu_idle_time_us()
+ * @idle_time: idle time stats
  * @cpu_dev: the cpu_device of policy->cpu.
  * @plat_get_static_power: callback to calculate the static power
  *
@@ -95,8 +103,7 @@ struct cpufreq_cooling_device {
 	struct freq_table *freq_table;	/* In descending order */
 	struct list_head node;
 	u32 last_load;
-	u64 *time_in_idle;
-	u64 *time_in_idle_timestamp;
+	struct time_in_idle *idle_time;
 	struct device *cpu_dev;
 	get_static_t plat_get_static_power;
 };
@@ -296,18 +303,19 @@ static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
 {
 	u32 load;
 	u64 now, now_idle, delta_time, delta_idle;
+	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
 
 	now_idle = get_cpu_idle_time(cpu, &now, 0);
-	delta_idle = now_idle - cpufreq_cdev->time_in_idle[cpu_idx];
-	delta_time = now - cpufreq_cdev->time_in_idle_timestamp[cpu_idx];
+	delta_idle = now_idle - idle_time->time;
+	delta_time = now - idle_time->timestamp;
 
 	if (delta_time <= delta_idle)
 		load = 0;
 	else
 		load = div64_u64(100 * (delta_time - delta_idle), delta_time);
 
-	cpufreq_cdev->time_in_idle[cpu_idx] = now_idle;
-	cpufreq_cdev->time_in_idle_timestamp[cpu_idx] = now;
+	idle_time->time = now_idle;
+	idle_time->timestamp = now;
 
 	return load;
 }
@@ -705,22 +713,14 @@ __cpufreq_cooling_register(struct device_node *np,
 		return ERR_PTR(-ENOMEM);
 
 	num_cpus = cpumask_weight(policy->related_cpus);
-	cpufreq_cdev->time_in_idle = kcalloc(num_cpus,
-					    sizeof(*cpufreq_cdev->time_in_idle),
-					    GFP_KERNEL);
-	if (!cpufreq_cdev->time_in_idle) {
+	cpufreq_cdev->idle_time = kcalloc(num_cpus,
+					 sizeof(*cpufreq_cdev->idle_time),
+					 GFP_KERNEL);
+	if (!cpufreq_cdev->idle_time) {
 		cdev = ERR_PTR(-ENOMEM);
 		goto free_cdev;
 	}
 
-	cpufreq_cdev->time_in_idle_timestamp =
-		kcalloc(num_cpus, sizeof(*cpufreq_cdev->time_in_idle_timestamp),
-			GFP_KERNEL);
-	if (!cpufreq_cdev->time_in_idle_timestamp) {
-		cdev = ERR_PTR(-ENOMEM);
-		goto free_time_in_idle;
-	}
-
 	/* max_level is an index, not a counter */
 	cpufreq_cdev->max_level = i - 1;
 
@@ -728,7 +728,7 @@ __cpufreq_cooling_register(struct device_node *np,
 					  GFP_KERNEL);
 	if (!cpufreq_cdev->freq_table) {
 		cdev = ERR_PTR(-ENOMEM);
-		goto free_time_in_idle_timestamp;
+		goto free_idle_time;
 	}
 
 	if (capacitance) {
@@ -792,10 +792,8 @@ __cpufreq_cooling_register(struct device_node *np,
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
 free_table:
 	kfree(cpufreq_cdev->freq_table);
-free_time_in_idle_timestamp:
-	kfree(cpufreq_cdev->time_in_idle_timestamp);
-free_time_in_idle:
-	kfree(cpufreq_cdev->time_in_idle);
+free_idle_time:
+	kfree(cpufreq_cdev->idle_time);
 free_cdev:
 	kfree(cpufreq_cdev);
 	return cdev;
@@ -938,8 +936,7 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 
 	thermal_cooling_device_unregister(cpufreq_cdev->cdev);
 	ida_simple_remove(&cpufreq_ida, cpufreq_cdev->id);
-	kfree(cpufreq_cdev->time_in_idle_timestamp);
-	kfree(cpufreq_cdev->time_in_idle);
+	kfree(cpufreq_cdev->idle_time);
 	kfree(cpufreq_cdev->freq_table);
 	kfree(cpufreq_cdev);
 }
-- 
2.12.0.432.g71c3a4f4ba37

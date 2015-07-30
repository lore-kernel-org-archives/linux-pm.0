From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/6] thermal/cpu_cooling: rename cpufreq_val as clipped_freq
Date: Thu, 30 Jul 2015 12:40:33 +0530
Message-ID: <beb6d3cfab692bf4c07f50305f8e0d44d4e27868.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, radivoje.jovanovic@linux.intel.com, punit.agrawal@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

That's what it is for, lets name it properly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index bf2673bb3cf5..61ee726ede34 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -68,7 +68,7 @@ struct power_table {
  *	registered cooling device.
  * @cpufreq_state: integer value representing the current state of cpufreq
  *	cooling	devices.
- * @cpufreq_val: integer value representing the absolute value of the clipped
+ * @clipped_freq: integer value representing the absolute value of the clipped
  *	frequency.
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
@@ -91,7 +91,7 @@ struct cpufreq_cooling_device {
 	int id;
 	struct thermal_cooling_device *cool_dev;
 	unsigned int cpufreq_state;
-	unsigned int cpufreq_val;
+	unsigned int clipped_freq;
 	unsigned int max_level;
 	unsigned int *freq_table;	/* In descending order */
 	struct cpumask allowed_cpus;
@@ -226,7 +226,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 		if (!cpumask_test_cpu(policy->cpu, &cpufreq_dev->allowed_cpus))
 			continue;
 
-		max_freq = cpufreq_dev->cpufreq_val;
+		max_freq = cpufreq_dev->clipped_freq;
 
 		if (policy->max != max_freq)
 			cpufreq_verify_within_limits(policy, 0, max_freq);
@@ -514,7 +514,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 
 	clip_freq = cpufreq_device->freq_table[state];
 	cpufreq_device->cpufreq_state = state;
-	cpufreq_device->cpufreq_val = clip_freq;
+	cpufreq_device->clipped_freq = clip_freq;
 
 	cpufreq_update_policy(cpu);
 
@@ -856,7 +856,7 @@ __cpufreq_cooling_register(struct device_node *np,
 			pr_debug("%s: freq:%u KHz\n", __func__, freq);
 	}
 
-	cpufreq_dev->cpufreq_val = cpufreq_dev->freq_table[0];
+	cpufreq_dev->clipped_freq = cpufreq_dev->freq_table[0];
 	cpufreq_dev->cool_dev = cool_dev;
 
 	mutex_lock(&cooling_cpufreq_lock);
-- 
2.4.0

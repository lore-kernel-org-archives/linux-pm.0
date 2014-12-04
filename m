From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 20/26] thermal: cpu_cooling: find max level during device registration
Date: Thu,  4 Dec 2014 09:42:02 +0530
Message-ID: <2deba357b8ab9cead52eba262a294b0b33e29691.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:48398 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaLDEOC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:14:02 -0500
Received: by mail-pd0-f179.google.com with SMTP id w10so16922944pde.38
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:14:02 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

CPU frequency tables don't update after the driver is registered and so we don't
need to iterate over them to find total number of states every time
cpufreq_get_max_state() is called. Do it once at boot time.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 2c4c485..d34cc5b 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -52,6 +52,8 @@
  *	cooling	devices.
  * @cpufreq_val: integer value representing the absolute value of the clipped
  *	frequency.
+ * @max_level: maximum cooling level. One less than total number of valid
+ *	cpufreq frequencies.
  * @allowed_cpus: all the cpus involved for this cpufreq_cooling_device.
  *
  * This structure is required for keeping information of each registered
@@ -62,6 +64,7 @@ struct cpufreq_cooling_device {
 	struct thermal_cooling_device *cool_dev;
 	unsigned int cpufreq_state;
 	unsigned int cpufreq_val;
+	unsigned int max_level;
 	struct cpumask allowed_cpus;
 	struct list_head node;
 };
@@ -283,19 +286,9 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
-	struct cpumask *mask = &cpufreq_device->allowed_cpus;
-	unsigned int cpu;
-	unsigned int count = 0;
-	int ret;
-
-	cpu = cpumask_any(mask);
-
-	ret = get_property(cpu, 0, &count, GET_MAXL);
-
-	if (count > 0)
-		*state = count;
 
-	return ret;
+	*state = cpufreq_device->max_level;
+	return 0;
 }
 
 /**
@@ -385,9 +378,11 @@ __cpufreq_cooling_register(struct device_node *np,
 	struct thermal_cooling_device *cool_dev;
 	struct cpufreq_cooling_device *cpufreq_dev;
 	char dev_name[THERMAL_NAME_LENGTH];
+	struct cpufreq_frequency_table *pos, *table;
 	int ret;
 
-	if (!cpufreq_frequency_get_table(cpumask_first(clip_cpus))) {
+	table = cpufreq_frequency_get_table(cpumask_first(clip_cpus));
+	if (!table) {
 		pr_debug("%s: CPUFreq table not found\n", __func__);
 		return ERR_PTR(-EPROBE_DEFER);
 	}
@@ -404,6 +399,13 @@ __cpufreq_cooling_register(struct device_node *np,
 		goto free_cdev;
 	}
 
+	/* Find max levels */
+	cpufreq_for_each_valid_entry(pos, table)
+		cpufreq_dev->max_level++;
+
+	/* max_level is an index, not a counter */
+	cpufreq_dev->max_level--;
+
 	cpumask_copy(&cpufreq_dev->allowed_cpus, clip_cpus);
 
 	ret = get_idr(&cpufreq_idr, &cpufreq_dev->id);
-- 
2.0.3.693.g996b0fd


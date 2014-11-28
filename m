From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 19/26] cpu_cooling: find max level during device registration
Date: Fri, 28 Nov 2014 15:14:13 +0530
Message-ID: <e2cb864949d833ab30c24b2bf039c682c8820040.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:64386 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbaK1Jpt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:49 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so6518635pad.31
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:49 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

CPU frequency tables don't update after the driver is registered and so we don't
need to iterate over them to find total number of states every time
cpufreq_get_max_state() is called. Do it once at boot time.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 5815abf..05712d5 100644
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
 };
 static DEFINE_IDR(cpufreq_idr);
@@ -246,19 +249,9 @@ static int cpufreq_get_max_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
-	struct cpumask *mask = &cpufreq_device->allowed_cpus;
-	unsigned int cpu;
-	unsigned int count = 0;
-	int ret;
 
-	cpu = cpumask_any(mask);
-
-	ret = get_property(cpu, 0, &count, GET_MAXL);
-
-	if (count > 0)
-		*state = count;
-
-	return ret;
+	*state = cpufreq_device->max_level;
+	return 0;
 }
 
 /**
@@ -351,11 +344,25 @@ __cpufreq_cooling_register(struct device_node *np,
 	struct thermal_cooling_device *cool_dev;
 	struct cpufreq_cooling_device *cpufreq_dev;
 	char dev_name[THERMAL_NAME_LENGTH];
+	struct cpufreq_frequency_table *pos, *table;
+
+	table = cpufreq_frequency_get_table(cpumask_first(clip_cpus));
+	if (!table) {
+		pr_debug("%s: CPUFreq table not found\n", __func__);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	cpufreq_dev = kzalloc(sizeof(*cool_dev), GFP_KERNEL);
 	if (!cpufreq_dev)
 		return ERR_PTR(-ENOMEM);
 
+	/* Find max levels */
+	cpufreq_for_each_valid_entry(pos, table)
+		cpufreq_dev->max_level++;
+
+	/* max_level is an index, not a counter */
+	cpufreq_dev->max_level--;
+
 	cpumask_copy(&cpufreq_dev->allowed_cpus, clip_cpus);
 
 	cpufreq_dev->id = idr_alloc(&cpufreq_idr, NULL, 0, 0, GFP_KERNEL);
-- 
2.0.3.693.g996b0fd


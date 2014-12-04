From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 18/26] thermal: cpu_cooling: Merge cpufreq_apply_cooling() into cpufreq_set_cur_state()
Date: Thu,  4 Dec 2014 09:42:00 +0530
Message-ID: <0d5df172b71fae0d9becd9389f7cf3c74163b7e9.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:57367 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbaLDENy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:54 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so17124729pab.35
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:54 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_apply_cooling() has a single caller, cpufreq_set_cur_state() and
cpufreq_set_cur_state() is an unnecessary wrapper over cpufreq_apply_cooling().

Get rid of it by merging both routines.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 52 +++++++++++++------------------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 86bcf8d..a3dd74f 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -254,41 +254,6 @@ static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
 }
 
 /**
- * cpufreq_apply_cooling - function to apply frequency clipping.
- * @cpufreq_device: cpufreq_cooling_device pointer containing frequency
- *	clipping data.
- * @cooling_state: value of the cooling state.
- *
- * Function used to make sure the cpufreq layer is aware of current thermal
- * limits. The limits are applied by updating the cpufreq policy.
- *
- * Return: 0 on success, an error code otherwise (-EINVAL in case wrong
- * cooling state).
- */
-static int cpufreq_apply_cooling(struct cpufreq_cooling_device *cpufreq_device,
-				 unsigned long cooling_state)
-{
-	unsigned int clip_freq;
-	struct cpumask *mask = &cpufreq_device->allowed_cpus;
-	unsigned int cpu = cpumask_any(mask);
-
-	/* Check if the old cooling action is same as new cooling action */
-	if (cpufreq_device->cpufreq_state == cooling_state)
-		return 0;
-
-	clip_freq = get_cpu_frequency(cpu, cooling_state);
-	if (!clip_freq)
-		return -EINVAL;
-
-	cpufreq_device->cpufreq_state = cooling_state;
-	cpufreq_device->cpufreq_val = clip_freq;
-
-	cpufreq_update_policy(cpu);
-
-	return 0;
-}
-
-/**
  * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
  * @nb:	struct notifier_block * with callback info.
  * @event: value showing cpufreq event for which this function invoked.
@@ -391,8 +356,23 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	unsigned int cpu = cpumask_any(&cpufreq_device->allowed_cpus);
+	unsigned int clip_freq;
+
+	/* Check if the old cooling action is same as new cooling action */
+	if (cpufreq_device->cpufreq_state == state)
+		return 0;
 
-	return cpufreq_apply_cooling(cpufreq_device, state);
+	clip_freq = get_cpu_frequency(cpu, state);
+	if (!clip_freq)
+		return -EINVAL;
+
+	cpufreq_device->cpufreq_state = state;
+	cpufreq_device->cpufreq_val = clip_freq;
+
+	cpufreq_update_policy(cpu);
+
+	return 0;
 }
 
 /* Bind cpufreq callbacks to thermal cooling device ops */
-- 
2.0.3.693.g996b0fd


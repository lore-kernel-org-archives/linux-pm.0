From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 17/26] cpu_cooling: Merge cpufreq_apply_cooling() into cpufreq_set_cur_state()
Date: Fri, 28 Nov 2014 15:14:11 +0530
Message-ID: <24d76b5957d9c9c54f372f1ba8cc5cee8faf0d64.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:55558 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaK1Jpl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:41 -0500
Received: by mail-pd0-f178.google.com with SMTP id g10so6460358pdj.9
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:41 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

cpufreq_apply_cooling() has a single caller, cpufreq_set_cur_state() and
cpufreq_set_cur_state() is an unnecessary wrapper over cpufreq_apply_cooling().

Get rid of it by merging both routines.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 58 ++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ca8f1bb..9673b48 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -219,44 +219,6 @@ static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
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
-	notify_device = cpufreq_device;
-
-	cpufreq_update_policy(cpu);
-
-	notify_device = NOTIFY_INVALID;
-
-	return 0;
-}
-
-/**
  * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
  * @nb:	struct notifier_block * with callback info.
  * @event: value showing cpufreq event for which this function invoked.
@@ -357,8 +319,26 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long state)
 {
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
+	unsigned int cpu = cpumask_any(&cpufreq_device->allowed_cpus);
+	unsigned int clip_freq;
 
-	return cpufreq_apply_cooling(cpufreq_device, state);
+	/* Check if the old cooling action is same as new cooling action */
+	if (cpufreq_device->cpufreq_state == state)
+		return 0;
+
+	clip_freq = get_cpu_frequency(cpu, state);
+	if (!clip_freq)
+		return -EINVAL;
+
+	cpufreq_device->cpufreq_state = state;
+	cpufreq_device->cpufreq_val = clip_freq;
+	notify_device = cpufreq_device;
+
+	cpufreq_update_policy(cpu);
+
+	notify_device = NOTIFY_INVALID;
+
+	return 0;
 }
 
 /* Bind cpufreq callbacks to thermal cooling device ops */
-- 
2.0.3.693.g996b0fd


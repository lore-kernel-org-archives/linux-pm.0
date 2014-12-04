From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 19/26] thermal: cpu_cooling: remove unnecessary wrapper get_cpu_frequency()
Date: Thu,  4 Dec 2014 09:42:01 +0530
Message-ID: <eca055b9c876acf115e53b2e571c2fedaa248cd2.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:47757 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752582AbaLDEN6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 23:13:58 -0500
Received: by mail-pa0-f43.google.com with SMTP id kx10so17218346pab.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 20:13:58 -0800 (PST)
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417664938.git.viresh.kumar@linaro.org>
References: <cover.1417664938.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, amit.daniel@samsung.com, javi.merino@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

get_cpu_frequency() isn't doing much by itself, just calling get_property(). And
so this wrapper isn't required at all. Get rid of it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 40 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index a3dd74f..2c4c485 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -230,30 +230,6 @@ unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
 EXPORT_SYMBOL_GPL(cpufreq_cooling_get_level);
 
 /**
- * get_cpu_frequency - get the absolute value of frequency from level.
- * @cpu: cpu for which frequency is fetched.
- * @level: cooling level
- *
- * This function matches cooling level with frequency. Based on a cooling level
- * of frequency, equals cooling state of cpu cooling device, it will return
- * the corresponding frequency.
- *	e.g level=0 --> 1st MAX FREQ, level=1 ---> 2nd MAX FREQ, .... etc
- *
- * Return: 0 on error, the corresponding frequency otherwise.
- */
-static unsigned int get_cpu_frequency(unsigned int cpu, unsigned long level)
-{
-	int ret = 0;
-	unsigned int freq;
-
-	ret = get_property(cpu, level, &freq, GET_FREQ);
-	if (ret)
-		return 0;
-
-	return freq;
-}
-
-/**
  * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
  * @nb:	struct notifier_block * with callback info.
  * @event: value showing cpufreq event for which this function invoked.
@@ -358,14 +334,15 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
 	unsigned int cpu = cpumask_any(&cpufreq_device->allowed_cpus);
 	unsigned int clip_freq;
+	int ret;
 
 	/* Check if the old cooling action is same as new cooling action */
 	if (cpufreq_device->cpufreq_state == state)
 		return 0;
 
-	clip_freq = get_cpu_frequency(cpu, state);
-	if (!clip_freq)
-		return -EINVAL;
+	ret = get_property(cpu, state, &clip_freq, GET_FREQ);
+	if (ret)
+		return ret;
 
 	cpufreq_device->cpufreq_state = state;
 	cpufreq_device->cpufreq_val = clip_freq;
@@ -419,10 +396,11 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (!cpufreq_dev)
 		return ERR_PTR(-ENOMEM);
 
-	cpufreq_dev->cpufreq_val = get_cpu_frequency(cpumask_any(clip_cpus), 0);
-	if (!cpufreq_dev->cpufreq_val) {
-		pr_err("%s: Failed to get frequency", __func__);
-		cool_dev = ERR_PTR(-EINVAL);
+	ret = get_property(cpumask_any(clip_cpus), 0, &cpufreq_dev->cpufreq_val,
+			   GET_FREQ);
+	if (ret) {
+		pr_err("%s: Failed to get frequency: %d", __func__, ret);
+		cool_dev = ERR_PTR(ret);
 		goto free_cdev;
 	}
 
-- 
2.0.3.693.g996b0fd


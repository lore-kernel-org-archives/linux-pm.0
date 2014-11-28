From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 18/26] cpu_cooling: Merge get_cpu_frequency() into cpufreq_set_cur_state()
Date: Fri, 28 Nov 2014 15:14:12 +0530
Message-ID: <7b0ee76e42a06e915d4699b2ff83fdf12f7b1543.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:43741 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaK1Jpp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 04:45:45 -0500
Received: by mail-pd0-f170.google.com with SMTP id fp1so6432625pdb.1
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 01:45:45 -0800 (PST)
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1417167599.git.viresh.kumar@linaro.org>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

get_cpu_frequency() is used from only one place, i.e. cpufreq_set_cur_state().
And there is no need to have this extra level of function calls. Merge them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 9673b48..5815abf 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -195,30 +195,6 @@ unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
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
@@ -321,14 +297,15 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
 	unsigned int cpu = cpumask_any(&cpufreq_device->allowed_cpus);
 	unsigned int clip_freq;
+	int ret = 0;
 
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
-- 
2.0.3.693.g996b0fd


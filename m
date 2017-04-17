From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 14/17] thermal: cpu_cooling: get_level() can't fail
Date: Mon, 17 Apr 2017 11:31:59 +0530
Message-ID: <97570bba76733addd028e3292d02d70035a029c4.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36808 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932989AbdDQGDc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Apr 2017 02:03:32 -0400
Received: by mail-pg0-f43.google.com with SMTP id g2so67324276pge.3
        for <linux-pm@vger.kernel.org>; Sun, 16 Apr 2017 23:03:32 -0700 (PDT)
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

The frequency passed to get_level() is returned by cpu_power_to_freq()
and it is guaranteed that get_level() can't fail.

Get rid of error code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index fa29f830fdc0..4ec9234488c6 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -119,22 +119,19 @@ static LIST_HEAD(cpufreq_cdev_list);
  * @cpufreq_cdev: cpufreq_cdev for which the property is required
  * @freq: Frequency
  *
- * Return: level on success, THERMAL_CSTATE_INVALID on error.
+ * Return: level corresponding to the frequency.
  */
 static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 			       unsigned int freq)
 {
+	struct freq_table *freq_table = cpufreq_cdev->freq_table;
 	unsigned long level;
 
-	for (level = 0; level <= cpufreq_cdev->max_level; level++) {
-		if (freq == cpufreq_cdev->freq_table[level].frequency)
-			return level;
-
-		if (freq > cpufreq_cdev->freq_table[level].frequency)
+	for (level = 1; level < cpufreq_cdev->max_level; level++)
+		if (freq > freq_table[level].frequency)
 			break;
-	}
 
-	return THERMAL_CSTATE_INVALID;
+	return level - 1;
 }
 
 /**
@@ -623,13 +620,6 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	target_freq = cpu_power_to_freq(cpufreq_cdev, normalised_power);
 
 	*state = get_level(cpufreq_cdev, target_freq);
-	if (*state == THERMAL_CSTATE_INVALID) {
-		dev_err_ratelimited(&cdev->device,
-				    "Failed to convert %dKHz for cpu %d into a cdev state\n",
-				    target_freq, policy->cpu);
-		return -EINVAL;
-	}
-
 	trace_thermal_power_cpu_limit(policy->related_cpus, target_freq, *state,
 				      power);
 	return 0;
-- 
2.12.0.432.g71c3a4f4ba37

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 14/17] thermal: cpu_cooling: get_level() can't fail
Date: Thu, 16 Mar 2017 10:59:49 +0530
Message-ID: <670bd7723463c1a8e45bb9fb1c40b7a6e3ee73e0.1489640000.git.viresh.kumar@linaro.org>
References: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

The frequency passed to get_level() is returned by cpu_power_to_freq()
and it is guaranteed that get_level() can't fail.

Get rid of error code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 69388a903706..fd84802d2e8e 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -120,22 +120,19 @@ static LIST_HEAD(cpufreq_dev_list);
  * @cpufreq_dev: cpufreq_dev for which the property is required
  * @freq: Frequency
  *
- * Return: level on success, THERMAL_CSTATE_INVALID on error.
+ * Return: level corresponding to the frequency.
  */
 static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_dev,
 			       unsigned int freq)
 {
+	struct freq_table *freq_table = cpufreq_dev->freq_table;
 	unsigned long level;
 
-	for (level = 0; level <= cpufreq_dev->max_level; level++) {
-		if (freq == cpufreq_dev->freq_table[level].frequency)
-			return level;
-
-		if (freq > cpufreq_dev->freq_table[level].frequency)
+	for (level = 1; level < cpufreq_dev->max_level; level++)
+		if (freq > freq_table[level].frequency)
 			break;
-	}
 
-	return THERMAL_CSTATE_INVALID;
+	return level - 1;
 }
 
 /**
@@ -624,13 +621,6 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	target_freq = cpu_power_to_freq(cpufreq_dev, normalised_power);
 
 	*state = get_level(cpufreq_dev, target_freq);
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
2.7.1.410.g6faf27b

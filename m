From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 05/17] thermal: cpu_cooling: remove cpufreq_cooling_get_level()
Date: Tue, 25 Apr 2017 15:57:12 +0530
Message-ID: <04010983e89a99ad35fd754d3ca0577139ab8759.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

There is only one user of cpufreq_cooling_get_level() and that already
has pointer to the cpufreq_cdev structure. It can directly call
get_level() instead and we can get rid of cpufreq_cooling_get_level().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpu_cooling.c | 33 +--------------------------------
 include/linux/cpu_cooling.h   |  6 ------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index f1e784c22c5a..1f4b6a719d05 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -136,37 +136,6 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_cdev,
 }
 
 /**
- * cpufreq_cooling_get_level - for a given cpu, return the cooling level.
- * @cpu: cpu for which the level is required
- * @freq: the frequency of interest
- *
- * This function will match the cooling level corresponding to the
- * requested @freq and return it.
- *
- * Return: The matched cooling level on success or THERMAL_CSTATE_INVALID
- * otherwise.
- */
-unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
-{
-	struct cpufreq_cooling_device *cpufreq_cdev;
-
-	mutex_lock(&cooling_list_lock);
-	list_for_each_entry(cpufreq_cdev, &cpufreq_cdev_list, node) {
-		if (cpumask_test_cpu(cpu, &cpufreq_cdev->allowed_cpus)) {
-			unsigned long level = get_level(cpufreq_cdev, freq);
-
-			mutex_unlock(&cooling_list_lock);
-			return level;
-		}
-	}
-	mutex_unlock(&cooling_list_lock);
-
-	pr_err("%s: cpu:%d not part of any cooling device\n", __func__, cpu);
-	return THERMAL_CSTATE_INVALID;
-}
-EXPORT_SYMBOL_GPL(cpufreq_cooling_get_level);
-
-/**
  * cpufreq_thermal_notifier - notifier callback for cpufreq policy change.
  * @nb:	struct notifier_block * with callback info.
  * @event: value showing cpufreq event for which this function invoked.
@@ -697,7 +666,7 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	normalised_power = (dyn_power * 100) / last_load;
 	target_freq = cpu_power_to_freq(cpufreq_cdev, normalised_power);
 
-	*state = cpufreq_cooling_get_level(cpu, target_freq);
+	*state = get_level(cpufreq_cdev, target_freq);
 	if (*state == THERMAL_CSTATE_INVALID) {
 		dev_err_ratelimited(&cdev->device,
 				    "Failed to convert %dKHz for cpu %d into a cdev state\n",
diff --git a/include/linux/cpu_cooling.h b/include/linux/cpu_cooling.h
index c156f5082758..96c5e4c2f9c8 100644
--- a/include/linux/cpu_cooling.h
+++ b/include/linux/cpu_cooling.h
@@ -82,7 +82,6 @@ of_cpufreq_power_cooling_register(struct device_node *np,
  */
 void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev);
 
-unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq);
 #else /* !CONFIG_CPU_THERMAL */
 static inline struct thermal_cooling_device *
 cpufreq_cooling_register(const struct cpumask *clip_cpus)
@@ -117,11 +116,6 @@ void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
 {
 	return;
 }
-static inline
-unsigned long cpufreq_cooling_get_level(unsigned int cpu, unsigned int freq)
-{
-	return THERMAL_CSTATE_INVALID;
-}
 #endif	/* CONFIG_CPU_THERMAL */
 
 #endif /* __CPU_COOLING_H__ */
-- 
2.12.0.432.g71c3a4f4ba37

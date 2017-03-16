From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 05/17] thermal: cpu_cooling: remove cpufreq_cooling_get_level()
Date: Thu, 16 Mar 2017 10:59:40 +0530
Message-ID: <707918c88ce650ea11d160e31965482cdebc9a39.1489640000.git.viresh.kumar@linaro.org>
References: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33964 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdCPFaX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Mar 2017 01:30:23 -0400
Received: by mail-pg0-f54.google.com with SMTP id 141so19596182pgd.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2017 22:30:22 -0700 (PDT)
In-Reply-To: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

There is only one user of cpufreq_cooling_get_level() and that already
has pointer to the cpufreq_dev structure. It can directly call
get_level() instead and we can get rid of cpufreq_cooling_get_level().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 33 +--------------------------------
 include/linux/cpu_cooling.h   |  6 ------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index e2931c20c309..99dc6833de75 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -137,37 +137,6 @@ static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_dev,
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
-	struct cpufreq_cooling_device *cpufreq_dev;
-
-	mutex_lock(&cooling_list_lock);
-	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
-		if (cpumask_test_cpu(cpu, &cpufreq_dev->allowed_cpus)) {
-			unsigned long level = get_level(cpufreq_dev, freq);
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
@@ -698,7 +667,7 @@ static int cpufreq_power2state(struct thermal_cooling_device *cdev,
 	normalised_power = (dyn_power * 100) / last_load;
 	target_freq = cpu_power_to_freq(cpufreq_dev, normalised_power);
 
-	*state = cpufreq_cooling_get_level(cpu, target_freq);
+	*state = get_level(cpufreq_dev, target_freq);
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
2.7.1.410.g6faf27b

From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] thermal: use cpumask_var_t for on-stack cpu masks
Date: Thu,  2 Feb 2017 15:46:26 +0100
Message-ID: <20170202144821.3721926-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Putting a bare cpumask structure on the stack produces a warning on
large SMP configurations:

drivers/thermal/cpu_cooling.c: In function 'cpufreq_state2power':
drivers/thermal/cpu_cooling.c:644:1: warning: the frame size of 1056 bytes is larger than 1024 bytes [-Wframe-larger-than=]
drivers/thermal/cpu_cooling.c: In function '__cpufreq_cooling_register':
drivers/thermal/cpu_cooling.c:898:1: warning: the frame size of 1104 bytes is larger than 1024 bytes [-Wframe-larger-than=]

The recommended workaround is to use cpumask_var_t, which behaves just like
a normal cpu mask in most cases, but turns into a dynamic allocation
when CONFIG_CPUMASK_OFFSTACK is set.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thermal/cpu_cooling.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index ca7ddaea450c..1d7f7e85f669 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -609,31 +609,39 @@ static int cpufreq_state2power(struct thermal_cooling_device *cdev,
 			       unsigned long state, u32 *power)
 {
 	unsigned int freq, num_cpus;
-	cpumask_t cpumask;
+	cpumask_var_t cpumask;
 	u32 static_power, dynamic_power;
 	int ret;
 	struct cpufreq_cooling_device *cpufreq_device = cdev->devdata;
 
-	cpumask_and(&cpumask, &cpufreq_device->allowed_cpus, cpu_online_mask);
-	num_cpus = cpumask_weight(&cpumask);
+	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
+		return -ENOMEM;
+
+	cpumask_and(cpumask, &cpufreq_device->allowed_cpus, cpu_online_mask);
+	num_cpus = cpumask_weight(cpumask);
 
 	/* None of our cpus are online, so no power */
 	if (num_cpus == 0) {
 		*power = 0;
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
 	freq = cpufreq_device->freq_table[state];
-	if (!freq)
-		return -EINVAL;
+	if (!freq) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	dynamic_power = cpu_freq_to_power(cpufreq_device, freq) * num_cpus;
 	ret = get_static_power(cpufreq_device, tz, freq, &static_power);
 	if (ret)
-		return ret;
+		goto out;
 
 	*power = static_power + dynamic_power;
-	return 0;
+out:
+	free_cpumask_var(cpumask);
+	return ret;;
 }
 
 /**
@@ -759,16 +767,20 @@ __cpufreq_cooling_register(struct device_node *np,
 	struct cpufreq_cooling_device *cpufreq_dev;
 	char dev_name[THERMAL_NAME_LENGTH];
 	struct cpufreq_frequency_table *pos, *table;
-	struct cpumask temp_mask;
+	cpumask_var_t temp_mask;
 	unsigned int freq, i, num_cpus;
 	int ret;
 	struct thermal_cooling_device_ops *cooling_ops;
 
-	cpumask_and(&temp_mask, clip_cpus, cpu_online_mask);
-	policy = cpufreq_cpu_get(cpumask_first(&temp_mask));
+	if (!alloc_cpumask_var(&temp_mask, GFP_KERNEL))
+		return ERR_PTR(-ENOMEM);
+
+	cpumask_and(temp_mask, clip_cpus, cpu_online_mask);
+	policy = cpufreq_cpu_get(cpumask_first(temp_mask));
 	if (!policy) {
 		pr_debug("%s: CPUFreq policy not found\n", __func__);
-		return ERR_PTR(-EPROBE_DEFER);
+		cool_dev = ERR_PTR(-EPROBE_DEFER);
+		goto free_cpumask;
 	}
 
 	table = policy->freq_table;
@@ -886,7 +898,8 @@ __cpufreq_cooling_register(struct device_node *np,
 	kfree(cpufreq_dev);
 put_policy:
 	cpufreq_cpu_put(policy);
-
+free_cpumask:
+	free_cpumask_var(temp_mask);
 	return cool_dev;
 }
 
-- 
2.9.0

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 15/17] thermal: cpu_cooling: don't store cpu_dev in cpufreq_cdev
Date: Tue, 25 Apr 2017 15:57:22 +0530
Message-ID: <95fe301b41364b0b5316ab270698a40e88b7fc66.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

'cpu_dev' is used by only one function, get_static_power(), and it
wouldn't be time consuming to get the cpu device structure within it.
This would help removing cpu_dev from struct cpufreq_cooling_device.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpu_cooling.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 2c2d76ac04c3..bfa9731e7cdb 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -87,7 +87,6 @@ struct time_in_idle {
  * @node: list_head to link all cpufreq_cooling_device together.
  * @last_load: load measured by the latest call to cpufreq_get_requested_power()
  * @idle_time: idle time stats
- * @cpu_dev: the cpu_device of policy->cpu.
  * @plat_get_static_power: callback to calculate the static power
  *
  * This structure is required for keeping information of each registered
@@ -104,7 +103,6 @@ struct cpufreq_cooling_device {
 	struct list_head node;
 	u32 last_load;
 	struct time_in_idle *idle_time;
-	struct device *cpu_dev;
 	get_static_t plat_get_static_power;
 };
 
@@ -259,8 +257,6 @@ static int update_freq_table(struct cpufreq_cooling_device *cpufreq_cdev,
 		freq_table[i].power = power;
 	}
 
-	cpufreq_cdev->cpu_dev = dev;
-
 	return 0;
 }
 
@@ -342,19 +338,22 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_cdev,
 {
 	struct dev_pm_opp *opp;
 	unsigned long voltage;
-	struct cpumask *cpumask = cpufreq_cdev->policy->related_cpus;
+	struct cpufreq_policy *policy = cpufreq_cdev->policy;
+	struct cpumask *cpumask = policy->related_cpus;
 	unsigned long freq_hz = freq * 1000;
+	struct device *dev;
 
-	if (!cpufreq_cdev->plat_get_static_power || !cpufreq_cdev->cpu_dev) {
+	if (!cpufreq_cdev->plat_get_static_power) {
 		*power = 0;
 		return 0;
 	}
 
-	opp = dev_pm_opp_find_freq_exact(cpufreq_cdev->cpu_dev, freq_hz,
-					 true);
+	dev = get_cpu_device(policy->cpu);
+	WARN_ON(!dev);
+
+	opp = dev_pm_opp_find_freq_exact(dev, freq_hz, true);
 	if (IS_ERR(opp)) {
-		dev_warn_ratelimited(cpufreq_cdev->cpu_dev,
-				     "Failed to find OPP for frequency %lu: %ld\n",
+		dev_warn_ratelimited(dev, "Failed to find OPP for frequency %lu: %ld\n",
 				     freq_hz, PTR_ERR(opp));
 		return -EINVAL;
 	}
@@ -363,8 +362,7 @@ static int get_static_power(struct cpufreq_cooling_device *cpufreq_cdev,
 	dev_pm_opp_put(opp);
 
 	if (voltage == 0) {
-		dev_err_ratelimited(cpufreq_cdev->cpu_dev,
-				    "Failed to get voltage for frequency %lu\n",
+		dev_err_ratelimited(dev, "Failed to get voltage for frequency %lu\n",
 				    freq_hz);
 		return -EINVAL;
 	}
-- 
2.12.0.432.g71c3a4f4ba37

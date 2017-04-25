From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 09/17] thermal: cpu_cooling: store cpufreq policy
Date: Tue, 25 Apr 2017 15:57:16 +0530
Message-ID: <c8872d737bc26de900801543acdddfb14d4cc7d8.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1493115651.git.viresh.kumar@linaro.org>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Lukasz Luba <lukasz.luba@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>
List-Id: linux-pm@vger.kernel.org

The cpufreq policy can be used by the cpu_cooling driver, lets store it
in the cpufreq_cooling_device structure.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpu_cooling.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 55ff45c1e917..7dddc7443f5d 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -67,6 +67,7 @@ struct power_table {
  *	registered.
  * @cdev: thermal_cooling_device pointer to keep track of the
  *	registered cooling device.
+ * @policy: cpufreq policy.
  * @cpufreq_state: integer value representing the current state of cpufreq
  *	cooling	devices.
  * @clipped_freq: integer value representing the absolute value of the clipped
@@ -91,6 +92,7 @@ struct power_table {
 struct cpufreq_cooling_device {
 	int id;
 	struct thermal_cooling_device *cdev;
+	struct cpufreq_policy *policy;
 	unsigned int cpufreq_state;
 	unsigned int clipped_freq;
 	unsigned int max_level;
@@ -760,6 +762,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (!cpufreq_cdev)
 		return ERR_PTR(-ENOMEM);
 
+	cpufreq_cdev->policy = policy;
 	num_cpus = cpumask_weight(policy->related_cpus);
 	cpufreq_cdev->time_in_idle = kcalloc(num_cpus,
 					    sizeof(*cpufreq_cdev->time_in_idle),
-- 
2.12.0.432.g71c3a4f4ba37

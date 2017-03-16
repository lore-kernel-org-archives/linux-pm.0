From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 09/17] thermal: cpu_cooling: store cpufreq policy
Date: Thu, 16 Mar 2017 10:59:44 +0530
Message-ID: <b0cd786d25afc980003827eb25e497a1d0a23609.1489640000.git.viresh.kumar@linaro.org>
References: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

The cpufreq policy can be used by the cpu_cooling driver, lets store it
in the cpufreq_cooling_device structure.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 2c169fee693e..7590279bf1de 100644
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
@@ -827,6 +829,7 @@ __cpufreq_cooling_register(struct device_node *np,
 
 	cpufreq_dev->clipped_freq = cpufreq_dev->freq_table[0];
 	cpufreq_dev->cdev = cdev;
+	cpufreq_dev->policy = policy;
 
 	mutex_lock(&cooling_list_lock);
 	list_add(&cpufreq_dev->node, &cpufreq_dev_list);
-- 
2.7.1.410.g6faf27b

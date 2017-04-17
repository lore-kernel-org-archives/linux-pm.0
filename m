From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 17/17] thermal: cpu_cooling: Rearrange struct cpufreq_cooling_device
Date: Mon, 17 Apr 2017 11:32:02 +0530
Message-ID: <908063832c268f8add94afd2695b2567bc0912ea.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

This shrinks the size of the structure on arm64 by 8 bytes by avoiding
padding of 4 bytes at two places.

Also add missing doc comment for freq_table

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfc3638ea939..99ffd9f6cbb9 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -75,17 +75,18 @@ struct time_in_idle {
  * struct cpufreq_cooling_device - data for cooling device with cpufreq
  * @id: unique integer value corresponding to each cpufreq_cooling_device
  *	registered.
- * @cdev: thermal_cooling_device pointer to keep track of the
- *	registered cooling device.
- * @policy: cpufreq policy.
+ * @last_load: load measured by the latest call to cpufreq_get_requested_power()
  * @cpufreq_state: integer value representing the current state of cpufreq
  *	cooling	devices.
  * @clipped_freq: integer value representing the absolute value of the clipped
  *	frequency.
  * @max_level: maximum cooling level. One less than total number of valid
  *	cpufreq frequencies.
+ * @freq_table: Freq table in descending order of frequencies
+ * @cdev: thermal_cooling_device pointer to keep track of the
+ *	registered cooling device.
+ * @policy: cpufreq policy.
  * @node: list_head to link all cpufreq_cooling_device together.
- * @last_load: load measured by the latest call to cpufreq_get_requested_power()
  * @idle_time: idle time stats
  * @plat_get_static_power: callback to calculate the static power
  *
@@ -94,14 +95,14 @@ struct time_in_idle {
  */
 struct cpufreq_cooling_device {
 	int id;
-	struct thermal_cooling_device *cdev;
-	struct cpufreq_policy *policy;
+	u32 last_load;
 	unsigned int cpufreq_state;
 	unsigned int clipped_freq;
 	unsigned int max_level;
 	struct freq_table *freq_table;	/* In descending order */
+	struct thermal_cooling_device *cdev;
+	struct cpufreq_policy *policy;
 	struct list_head node;
-	u32 last_load;
 	struct time_in_idle *idle_time;
 	get_static_t plat_get_static_power;
 };
-- 
2.12.0.432.g71c3a4f4ba37

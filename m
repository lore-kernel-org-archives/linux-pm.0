From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/6] thermal/cpu_cooling: convert 'switch' block to 'if' block in notifier
Date: Thu, 30 Jul 2015 12:40:32 +0530
Message-ID: <46d2492a9e665e05ec03124ffcebbe663846ff37.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, radivoje.jovanovic@linux.intel.com, punit.agrawal@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We just need to take care of single event here and there is no need to
increase indentation level of most of the code (which causes lines
longer that 80 columns to break).

Kill the switch block.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 276cec5a1fb7..bf2673bb3cf5 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -218,27 +218,21 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 	unsigned long max_freq;
 	struct cpufreq_cooling_device *cpufreq_dev;
 
-	switch (event) {
+	if (event != CPUFREQ_ADJUST)
+		return NOTIFY_DONE;
 
-	case CPUFREQ_ADJUST:
-		mutex_lock(&cooling_cpufreq_lock);
-		list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
-			if (!cpumask_test_cpu(policy->cpu,
-					      &cpufreq_dev->allowed_cpus))
-				continue;
+	mutex_lock(&cooling_cpufreq_lock);
+	list_for_each_entry(cpufreq_dev, &cpufreq_dev_list, node) {
+		if (!cpumask_test_cpu(policy->cpu, &cpufreq_dev->allowed_cpus))
+			continue;
 
-			max_freq = cpufreq_dev->cpufreq_val;
+		max_freq = cpufreq_dev->cpufreq_val;
 
-			if (policy->max != max_freq)
-				cpufreq_verify_within_limits(policy, 0,
-							     max_freq);
-			break;
-		}
-		mutex_unlock(&cooling_cpufreq_lock);
+		if (policy->max != max_freq)
+			cpufreq_verify_within_limits(policy, 0, max_freq);
 		break;
-	default:
-		return NOTIFY_DONE;
 	}
+	mutex_unlock(&cooling_cpufreq_lock);
 
 	return NOTIFY_OK;
 }
-- 
2.4.0

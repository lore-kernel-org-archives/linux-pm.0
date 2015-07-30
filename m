From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 5/6] thermal/cpu_cooling: rename max_freq as clipped_freq in notifier
Date: Thu, 30 Jul 2015 12:40:34 +0530
Message-ID: <dbe7ebabd04a3ebd529eca17a80a4572a1606c72.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, radivoje.jovanovic@linux.intel.com, punit.agrawal@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

That's what it is for, lets name it properly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 61ee726ede34..9209c324a7fc 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -215,7 +215,7 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 				    unsigned long event, void *data)
 {
 	struct cpufreq_policy *policy = data;
-	unsigned long max_freq;
+	unsigned long clipped_freq;
 	struct cpufreq_cooling_device *cpufreq_dev;
 
 	if (event != CPUFREQ_ADJUST)
@@ -226,10 +226,10 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 		if (!cpumask_test_cpu(policy->cpu, &cpufreq_dev->allowed_cpus))
 			continue;
 
-		max_freq = cpufreq_dev->clipped_freq;
+		clipped_freq = cpufreq_dev->clipped_freq;
 
-		if (policy->max != max_freq)
-			cpufreq_verify_within_limits(policy, 0, max_freq);
+		if (policy->max != clipped_freq)
+			cpufreq_verify_within_limits(policy, 0, clipped_freq);
 		break;
 	}
 	mutex_unlock(&cooling_cpufreq_lock);
-- 
2.4.0

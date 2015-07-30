From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 6/6] thermal/cpu_cooling: update policy limits if clipped_freq < policy->max
Date: Thu, 30 Jul 2015 12:40:35 +0530
Message-ID: <5a3411e7341a4208d0d67c0c5ea2208a4c5ee658.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1438239727.git.viresh.kumar@linaro.org>
References: <cover.1438239727.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, radivoje.jovanovic@linux.intel.com, punit.agrawal@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

policy->max is the maximum allowed frequency defined by user and
clipped_freq is the maximum that thermal constraints allow.

If clipped_freq is lower than policy->max, then we need to readjust
policy->max.

But, if clipped_freq is greater than policy->max, we don't need to do
anything. We used to call cpufreq_verify_within_limits() in this case,
but it doesn't change anything in this case.

Lets skip this unnecessary call and write a comment that explains this.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 9209c324a7fc..d9a603588cb5 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -226,9 +226,20 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 		if (!cpumask_test_cpu(policy->cpu, &cpufreq_dev->allowed_cpus))
 			continue;
 
+		/*
+		 * policy->max is the maximum allowed frequency defined by user
+		 * and clipped_freq is the maximum that thermal constraints
+		 * allow.
+		 *
+		 * If clipped_freq is lower than policy->max, then we need to
+		 * readjust policy->max.
+		 *
+		 * But, if clipped_freq is greater than policy->max, we don't
+		 * need to do anything.
+		 */
 		clipped_freq = cpufreq_dev->clipped_freq;
 
-		if (policy->max != clipped_freq)
+		if (policy->max > clipped_freq)
 			cpufreq_verify_within_limits(policy, 0, clipped_freq);
 		break;
 	}
-- 
2.4.0

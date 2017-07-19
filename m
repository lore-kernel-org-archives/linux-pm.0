From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 5/9] cpufreq: arm_big_little: Make ->get_transition_latency() mandatory
Date: Wed, 19 Jul 2017 15:42:45 +0530
Message-ID: <da680563ea23908903e13a07e455be4e35ceec56.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux@dominikbrodowski.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

All users of arm_big_little driver are defining it and there is no need
to keep it optional.

Make it mandatory to remove the always true conditional statement.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/arm_big_little.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index ea6d62547b10..17504129fd77 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -483,11 +483,8 @@ static int bL_cpufreq_init(struct cpufreq_policy *policy)
 		return ret;
 	}
 
-	if (arm_bL_ops->get_transition_latency)
-		policy->cpuinfo.transition_latency =
-			arm_bL_ops->get_transition_latency(cpu_dev);
-	else
-		policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	policy->cpuinfo.transition_latency =
+				arm_bL_ops->get_transition_latency(cpu_dev);
 
 	if (is_bL_switching_enabled())
 		per_cpu(cpu_last_req_freq, policy->cpu) = clk_get_cpu_rate(policy->cpu);
@@ -622,7 +619,8 @@ int bL_cpufreq_register(struct cpufreq_arm_bL_ops *ops)
 		return -EBUSY;
 	}
 
-	if (!ops || !strlen(ops->name) || !ops->init_opp_table) {
+	if (!ops || !strlen(ops->name) || !ops->init_opp_table ||
+	    !ops->get_transition_latency) {
 		pr_err("%s: Invalid arm_bL_ops, exiting\n", __func__);
 		return -ENODEV;
 	}
-- 
2.13.0.71.gd7076ec9c9cb

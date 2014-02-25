From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/3] cpufreq: Initialize policy before making it available for others to use
Date: Tue, 25 Feb 2014 14:20:10 +0530
Message-ID: <57b8ab66ba21f42c91311641319cec16d2c8923d.1393318100.git.viresh.kumar@linaro.org>
References: <9f9546137135103556c69815c72b81ed93cc1ca2.1393318100.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9f9546137135103556c69815c72b81ed93cc1ca2.1393318100.git.viresh.kumar@linaro.org>
In-Reply-To: <9f9546137135103556c69815c72b81ed93cc1ca2.1393318100.git.viresh.kumar@linaro.org>
References: <9f9546137135103556c69815c72b81ed93cc1ca2.1393318100.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, skannan@codeaurora.org
Cc: linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Policy must be fully initialized before it is being made available for use by
others. This patch moves some initialization code before making policy available
for others.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index cc4f244..110c0cd 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1116,6 +1116,20 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 		goto err_set_policy_cpu;
 	}
 
+	/* related cpus should atleast have policy->cpus */
+	cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
+
+	/*
+	 * affected cpus must always be the one, which are online. We aren't
+	 * managing offline cpus here.
+	 */
+	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
+
+	if (!frozen) {
+		policy->user_policy.min = policy->min;
+		policy->user_policy.max = policy->max;
+	}
+
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	for_each_cpu(j, policy->cpus)
 		per_cpu(cpufreq_cpu_data, j) = policy;
@@ -1169,20 +1183,6 @@ static int __cpufreq_add_dev(struct device *dev, struct subsys_interface *sif,
 		}
 	}
 
-	/* related cpus should atleast have policy->cpus */
-	cpumask_or(policy->related_cpus, policy->related_cpus, policy->cpus);
-
-	/*
-	 * affected cpus must always be the one, which are online. We aren't
-	 * managing offline cpus here.
-	 */
-	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
-
-	if (!frozen) {
-		policy->user_policy.min = policy->min;
-		policy->user_policy.max = policy->max;
-	}
-
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				     CPUFREQ_START, policy);
 
-- 
1.7.12.rc2.18.g61b472e

From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 32/44] cpufreq: ppc-corenet: Use generic cpufreq routines
Date: Sat, 10 Aug 2013 12:14:28 +0530
Message-ID: <bb407454672c6771748a93f869d3818ec45b190c.1376116345.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 5716b44..befd489 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -252,14 +252,6 @@ static int __exit corenet_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int corenet_cpufreq_verify(struct cpufreq_policy *policy)
-{
-	struct cpufreq_frequency_table *table =
-		per_cpu(cpu_data, policy->cpu)->table;
-
-	return cpufreq_frequency_table_verify(policy, table);
-}
-
 static int corenet_cpufreq_target(struct cpufreq_policy *policy,
 		unsigned int target_freq, unsigned int relation)
 {
@@ -292,20 +284,15 @@ static int corenet_cpufreq_target(struct cpufreq_policy *policy,
 	return ret;
 }
 
-static struct freq_attr *corenet_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver ppc_corenet_cpufreq_driver = {
 	.name		= "ppc_cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.init		= corenet_cpufreq_cpu_init,
 	.exit		= __exit_p(corenet_cpufreq_cpu_exit),
-	.verify		= corenet_cpufreq_verify,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= corenet_cpufreq_target,
 	.get		= corenet_cpufreq_get_speed,
-	.attr		= corenet_cpufreq_attr,
+	.attr		= cpufreq_generic_attr,
 };
 
 static const struct of_device_id node_matches[] __initdata = {
-- 
1.7.12.rc2.18.g61b472e

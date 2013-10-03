From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 25/92] cpufreq: ppc_cbe: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:19 +0530
Message-ID: <5c5a71b25d99d54f534ea8d44bd9cb1b4484db89.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ppc_cbe_cpufreq.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index 6c5be63..38540d1 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -128,17 +128,6 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_table_validate_and_show(policy, cbe_freqs);
 }
 
-static int cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-static int cbe_cpufreq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, cbe_freqs);
-}
-
 static int cbe_cpufreq_target(struct cpufreq_policy *policy,
 			      unsigned int target_freq,
 			      unsigned int relation)
@@ -174,10 +163,10 @@ static int cbe_cpufreq_target(struct cpufreq_policy *policy,
 }
 
 static struct cpufreq_driver cbe_cpufreq_driver = {
-	.verify		= cbe_cpufreq_verify,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= cbe_cpufreq_target,
 	.init		= cbe_cpufreq_cpu_init,
-	.exit		= cbe_cpufreq_cpu_exit,
+	.exit		= cpufreq_generic_exit,
 	.name		= "cbe-cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
 };
-- 
1.7.12.rc2.18.g61b472e


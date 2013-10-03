From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 04/92] cpufreq: at32ap: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:27:58 +0530
Message-ID: <8e8fd0e0e3d7933d6a02b3c982e0ce41616ebb0e.1380783079.git.viresh.kumar@linaro.org>
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

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/at32ap-cpufreq.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c
index 1d19fa5..788f7e7 100644
--- a/drivers/cpufreq/at32ap-cpufreq.c
+++ b/drivers/cpufreq/at32ap-cpufreq.c
@@ -24,16 +24,6 @@
 static struct clk *cpuclk;
 static struct cpufreq_frequency_table *freq_table;
 
-static int at32_verify_speed(struct cpufreq_policy *policy)
-{
-	if (policy->cpu != 0)
-		return -EINVAL;
-
-	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-			policy->cpuinfo.max_freq);
-	return 0;
-}
-
 static unsigned int at32_get_speed(unsigned int cpu)
 {
 	/* No SMP support */
@@ -152,7 +142,7 @@ out_err:
 static struct cpufreq_driver at32_driver = {
 	.name		= "at32ap",
 	.init		= at32_cpufreq_driver_init,
-	.verify		= at32_verify_speed,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= at32_set_target,
 	.get		= at32_get_speed,
 	.flags		= CPUFREQ_STICKY,
-- 
1.7.12.rc2.18.g61b472e


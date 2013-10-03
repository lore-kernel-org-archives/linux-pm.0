From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 18/92] cpufreq: maple: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:12 +0530
Message-ID: <bcb4dca88d2fe130c2e2e0507502309e60616286.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
List-Id: linux-pm@vger.kernel.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/maple-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index b3fb661..b23d1d8 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -64,11 +64,6 @@ static struct cpufreq_frequency_table maple_cpu_freqs[] = {
 	{0,			CPUFREQ_TABLE_END},
 };
 
-static struct freq_attr *maple_cpu_freqs_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 /* Power mode data is an array of the 32 bits PCR values to use for
  * the various frequencies, retrieved from the device-tree
  */
@@ -135,11 +130,6 @@ static int maple_scom_query_freq(void)
  * Common interface to the cpufreq core
  */
 
-static int maple_cpufreq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, maple_cpu_freqs);
-}
-
 static int maple_cpufreq_target(struct cpufreq_policy *policy,
 	unsigned int target_freq, unsigned int relation)
 {
@@ -190,10 +180,10 @@ static struct cpufreq_driver maple_cpufreq_driver = {
 	.name		= "maple",
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.init		= maple_cpufreq_cpu_init,
-	.verify		= maple_cpufreq_verify,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= maple_cpufreq_target,
 	.get		= maple_cpufreq_get_speed,
-	.attr		= maple_cpu_freqs_attr,
+	.attr		= cpufreq_generic_attr,
 };
 
 static int __init maple_cpufreq_init(void)
-- 
1.7.12.rc2.18.g61b472e


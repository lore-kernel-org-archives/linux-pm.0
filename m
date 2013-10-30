From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 16/16] cpufreq: unicore2: use cpufreq_generic_get() routine
Date: Thu, 31 Oct 2013 04:22:14 +0530
Message-ID: <6878a643df82272c18233c5e0328007f88cec024.1383173230.git.viresh.kumar@linaro.org>
References: <cover.1383173230.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1383173230.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1383173230.git.viresh.kumar@linaro.org>
References: <cover.1383173230.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, viresh.kumar@linaro.org
List-Id: linux-pm@vger.kernel.org

We have common infrastructure available with us for getting a CPUs clk rate.
Lets use it for this driver.

We also do clk_get() once instead of doing it again and again in target & init.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/unicore2-cpufreq.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unicore2-cpufreq.c
index 653ae29..951152f 100644
--- a/drivers/cpufreq/unicore2-cpufreq.c
+++ b/drivers/cpufreq/unicore2-cpufreq.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/init.h>
@@ -33,26 +34,16 @@ static int ucv2_verify_speed(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static unsigned int ucv2_getspeed(unsigned int cpu)
-{
-	struct clk *mclk = clk_get(NULL, "MAIN_CLK");
-
-	if (cpu)
-		return 0;
-	return clk_get_rate(mclk)/1000;
-}
-
 static int ucv2_target(struct cpufreq_policy *policy,
 			 unsigned int target_freq,
 			 unsigned int relation)
 {
-	unsigned int cur = ucv2_getspeed(0);
+	unsigned int cur = policy->cur;
 	struct cpufreq_freqs freqs;
-	struct clk *mclk = clk_get(NULL, "MAIN_CLK");
 
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
-	if (!clk_set_rate(mclk, target_freq * 1000)) {
+	if (!clk_set_rate(policy->clk, target_freq * 1000)) {
 		freqs.old = cur;
 		freqs.new = target_freq;
 	}
@@ -66,9 +57,13 @@ static int __init ucv2_cpu_init(struct cpufreq_policy *policy)
 {
 	if (policy->cpu != 0)
 		return -EINVAL;
+
 	policy->min = policy->cpuinfo.min_freq = 250000;
 	policy->max = policy->cpuinfo.max_freq = 1000000;
 	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	policy->clk = clk_get(NULL, "MAIN_CLK");
+	if (IS_ERR(policy->clk))
+		return PTR_ERR(policy->clk);
 	return 0;
 }
 
@@ -76,7 +71,7 @@ static struct cpufreq_driver ucv2_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= ucv2_verify_speed,
 	.target		= ucv2_target,
-	.get		= ucv2_getspeed,
+	.get		= cpufreq_generic_get,
 	.init		= ucv2_cpu_init,
 	.name		= "UniCore-II",
 };
-- 
1.7.12.rc2.18.g61b472e

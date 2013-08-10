From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 43/44] cpufreq: unicore2: Use generic cpufreq routines
Date: Sat, 10 Aug 2013 12:14:39 +0530
Message-ID: <d518dd39781933a497d44253205b0c039965c718.1376116345.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>
List-Id: linux-pm@vger.kernel.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/unicore2-cpufreq.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unicore2-cpufreq.c
index 12fc904..b9f693c 100644
--- a/drivers/cpufreq/unicore2-cpufreq.c
+++ b/drivers/cpufreq/unicore2-cpufreq.c
@@ -21,20 +21,6 @@
 
 static struct cpufreq_driver ucv2_driver;
 
-/* make sure that only the "userspace" governor is run
- * -- anything else wouldn't make sense on this platform, anyway.
- */
-int ucv2_verify_speed(struct cpufreq_policy *policy)
-{
-	if (policy->cpu)
-		return -EINVAL;
-
-	cpufreq_verify_within_limits(policy,
-			policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
-
-	return 0;
-}
-
 static unsigned int ucv2_getspeed(unsigned int cpu)
 {
 	struct clk *mclk = clk_get(NULL, "MAIN_CLK");
@@ -77,7 +63,7 @@ static int __init ucv2_cpu_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver ucv2_driver = {
 	.flags		= CPUFREQ_STICKY,
-	.verify		= ucv2_verify_speed,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= ucv2_target,
 	.get		= ucv2_getspeed,
 	.init		= ucv2_cpu_init,
-- 
1.7.12.rc2.18.g61b472e

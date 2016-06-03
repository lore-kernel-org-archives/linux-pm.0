From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 8/8] cpufreq: davinci: Reuse cpufreq_generic_frequency_table_verify()
Date: Fri,  3 Jun 2016 10:58:52 +0530
Message-ID: <61f2d54a1921509ad38e0ea69cc06af6cacb4c0a.1464931080.git.viresh.kumar@linaro.org>
References: <cover.1464931080.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1464931080.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464931080.git.viresh.kumar@linaro.org>
References: <cover.1464931080.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-pm@vger.kernel.org

policy->freq_table will always be valid for this platform, otherwise
driver's probe() would fail. And so this routine will *always* return
after calling cpufreq_frequency_table_verify().

This can be done using the generic callback provided by core, lets use
it instead.

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 7e336d20c184..b95a872800ec 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -38,26 +38,6 @@ struct davinci_cpufreq {
 };
 static struct davinci_cpufreq cpufreq;
 
-static int davinci_verify_speed(struct cpufreq_policy *policy)
-{
-	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
-	struct cpufreq_frequency_table *freq_table = pdata->freq_table;
-	struct clk *armclk = cpufreq.armclk;
-
-	if (freq_table)
-		return cpufreq_frequency_table_verify(policy, freq_table);
-
-	if (policy->cpu)
-		return -EINVAL;
-
-	cpufreq_verify_within_cpu_limits(policy);
-	policy->min = clk_round_rate(armclk, policy->min * 1000) / 1000;
-	policy->max = clk_round_rate(armclk, policy->max * 1000) / 1000;
-	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-						policy->cpuinfo.max_freq);
-	return 0;
-}
-
 static int davinci_target(struct cpufreq_policy *policy, unsigned int idx)
 {
 	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
@@ -121,7 +101,7 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver davinci_driver = {
 	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
-	.verify		= davinci_verify_speed,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= davinci_target,
 	.get		= cpufreq_generic_get,
 	.init		= davinci_cpu_init,
-- 
2.7.1.410.g6faf27b

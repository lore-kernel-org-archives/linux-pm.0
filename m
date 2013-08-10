From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 21/44] cpufreq: imx6q: Use generic cpufreq routines
Date: Sat, 10 Aug 2013 12:14:17 +0530
Message-ID: <6d7504823a31aea1e4773998f60720494fb0e6b6.1376116345.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index e6f40fa..81d1727 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -34,11 +34,6 @@ static struct device *cpu_dev;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int transition_latency;
 
-static int imx6q_verify_speed(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, freq_table);
-}
-
 static unsigned int imx6q_get_speed(unsigned int cpu)
 {
 	return clk_get_rate(arm_clk) / 1000;
@@ -190,25 +185,14 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-static struct freq_attr *imx6q_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver imx6q_cpufreq_driver = {
-	.verify = imx6q_verify_speed,
+	.verify = cpufreq_generic_frequency_table_verify,
 	.target = imx6q_set_target,
 	.get = imx6q_get_speed,
 	.init = imx6q_cpufreq_init,
-	.exit = imx6q_cpufreq_exit,
+	.exit = cpufreq_generic_exit,
 	.name = "imx6q-cpufreq",
-	.attr = imx6q_cpufreq_attr,
+	.attr = cpufreq_generic_attr,
 };
 
 static int imx6q_cpufreq_probe(struct platform_device *pdev)
-- 
1.7.12.rc2.18.g61b472e

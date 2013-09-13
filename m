From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 220/228] cpufreq: imx6q: use cpufreq_generic_get() routine
Date: Fri, 13 Sep 2013 18:32:46 +0530
Message-ID: <f5cad684acf2949d3cbb70db56c935d3659c1eb7.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

We have common infrastructure available with us for getting a CPUs clk rate.
Lets use it for this driver.

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index a3829a0..6993f0d 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -34,11 +34,6 @@ static struct device *cpu_dev;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int transition_latency;
 
-static unsigned int imx6q_get_speed(unsigned int cpu)
-{
-	return clk_get_rate(arm_clk) / 1000;
-}
-
 static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct opp *opp;
@@ -133,13 +128,14 @@ static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 {
+	policy->clk = arm_clk;
 	return cpufreq_generic_init(policy, freq_table, transition_latency);
 }
 
 static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = imx6q_set_target,
-	.get = imx6q_get_speed,
+	.get = cpufreq_generic_get,
 	.init = imx6q_cpufreq_init,
 	.exit = cpufreq_generic_exit,
 	.name = "imx6q-cpufreq",
-- 
1.7.12.rc2.18.g61b472e

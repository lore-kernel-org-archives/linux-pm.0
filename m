From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 03/16] cpufreq: cpu0: use cpufreq_generic_get() routine
Date: Thu, 31 Oct 2013 04:22:01 +0530
Message-ID: <bcd82142b14cb445e9fbae0aa87f7da469c2d6bd.1383173230.git.viresh.kumar@linaro.org>
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

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index d4585ce..73f5485 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -30,11 +30,6 @@ static struct clk *cpu_clk;
 static struct regulator *cpu_reg;
 static struct cpufreq_frequency_table *freq_table;
 
-static unsigned int cpu0_get_speed(unsigned int cpu)
-{
-	return clk_get_rate(cpu_clk) / 1000;
-}
-
 static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct dev_pm_opp *opp;
@@ -100,6 +95,7 @@ static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 
 static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 {
+	policy->clk = cpu_clk;
 	return cpufreq_generic_init(policy, freq_table, transition_latency);
 }
 
@@ -107,7 +103,7 @@ static struct cpufreq_driver cpu0_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY,
 	.verify = cpufreq_generic_frequency_table_verify,
 	.target_index = cpu0_set_target,
-	.get = cpu0_get_speed,
+	.get = cpufreq_generic_get,
 	.init = cpu0_cpufreq_init,
 	.exit = cpufreq_generic_exit,
 	.name = "generic_cpu0",
-- 
1.7.12.rc2.18.g61b472e

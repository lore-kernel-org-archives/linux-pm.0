From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 92/92] cpufreq: tegra: use cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:42:11 +0530
Message-ID: <444c9a0fe61d10b7eb9a1dd710dd2915bbd7c001.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
 <854d6e8fa69d7d7d6dcd3c5461deaeed8d0f9b5b.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <854d6e8fa69d7d7d6dcd3c5461deaeed8d0f9b5b.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra-cpufreq.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
index 9c32b23..32483ef 100644
--- a/drivers/cpufreq/tegra-cpufreq.c
+++ b/drivers/cpufreq/tegra-cpufreq.c
@@ -204,19 +204,23 @@ static struct notifier_block tegra_cpu_pm_notifier = {
 
 static int tegra_cpu_init(struct cpufreq_policy *policy)
 {
+	int ret;
+
 	if (policy->cpu >= NUM_CPUS)
 		return -EINVAL;
 
 	clk_prepare_enable(emc_clk);
 	clk_prepare_enable(cpu_clk);
 
-	cpufreq_table_validate_and_show(policy, freq_table);
 	target_cpu_speed[policy->cpu] = tegra_getspeed(policy->cpu);
 
 	/* FIXME: what's the actual transition time? */
-	policy->cpuinfo.transition_latency = 300 * 1000;
-
-	cpumask_copy(policy->cpus, cpu_possible_mask);
+	ret = cpufreq_generic_init(policy, freq_table, 300 * 1000);
+	if (ret) {
+		clk_disable_unprepare(cpu_clk);
+		clk_disable_unprepare(emc_clk);
+		return ret;
+	}
 
 	if (policy->cpu == 0)
 		register_pm_notifier(&tegra_cpu_pm_notifier);
@@ -227,6 +231,7 @@ static int tegra_cpu_init(struct cpufreq_policy *policy)
 static int tegra_cpu_exit(struct cpufreq_policy *policy)
 {
 	cpufreq_frequency_table_put_attr(policy->cpu);
+	clk_disable_unprepare(cpu_clk);
 	clk_disable_unprepare(emc_clk);
 	return 0;
 }
-- 
1.7.12.rc2.18.g61b472e


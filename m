From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 06/31] cpufreq: cpu0: Covert to light weight ->target() routine
Date: Mon, 12 Aug 2013 23:18:42 +0530
Message-ID: <95102d862a31eaa0c2dd41ed424ace84e8669b42.1376329128.git.viresh.kumar@linaro.org>
References: <cover.1376329128.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1376329128.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376329128.git.viresh.kumar@linaro.org>
References: <cover.1376329128.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch converts existing .target_old() to newly defined light weight
.target() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-cpu0.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-cpu0.c b/drivers/cpufreq/cpufreq-cpu0.c
index b4c25cce..f90cd8c 100644
--- a/drivers/cpufreq/cpufreq-cpu0.c
+++ b/drivers/cpufreq/cpufreq-cpu0.c
@@ -34,24 +34,14 @@ static unsigned int cpu0_get_speed(unsigned int cpu)
 	return clk_get_rate(cpu_clk) / 1000;
 }
 
-static int cpu0_set_target(struct cpufreq_policy *policy,
-			   unsigned int target_freq, unsigned int relation)
+static int cpu0_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct cpufreq_freqs freqs;
 	struct opp *opp;
 	unsigned long volt = 0, volt_old = 0, tol = 0;
 	long freq_Hz, freq_exact;
-	unsigned int index;
 	int ret;
 
-	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
-					     relation, &index);
-	if (ret) {
-		pr_err("failed to match target freqency %d: %d\n",
-		       target_freq, ret);
-		return ret;
-	}
-
 	freq_Hz = clk_round_rate(cpu_clk, freq_table[index].frequency * 1000);
 	if (freq_Hz < 0)
 		freq_Hz = freq_table[index].frequency * 1000;
@@ -59,9 +49,6 @@ static int cpu0_set_target(struct cpufreq_policy *policy,
 	freqs.new = freq_Hz / 1000;
 	freqs.old = clk_get_rate(cpu_clk) / 1000;
 
-	if (freqs.old == freqs.new)
-		return 0;
-
 	cpufreq_notify_transition(policy, &freqs, CPUFREQ_PRECHANGE);
 
 	if (cpu_reg) {
@@ -145,7 +132,7 @@ static int cpu0_cpufreq_init(struct cpufreq_policy *policy)
 static struct cpufreq_driver cpu0_cpufreq_driver = {
 	.flags = CPUFREQ_STICKY,
 	.verify = cpufreq_generic_frequency_table_verify,
-	.target_old = cpu0_set_target,
+	.target = cpu0_set_target,
 	.get = cpu0_get_speed,
 	.init = cpu0_cpufreq_init,
 	.exit = cpufreq_generic_exit,
-- 
1.7.12.rc2.18.g61b472e


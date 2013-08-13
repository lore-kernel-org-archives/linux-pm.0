From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 15/35] cpufreq: imx6q: Covert to light weight ->target_index() routine
Date: Tue, 13 Aug 2013 19:02:28 +0530
Message-ID: <217701887d98cb7b71b91a095c9ca30cb35d95b4.1376392602.git.viresh.kumar@linaro.org>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1376392602.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376392602.git.viresh.kumar@linaro.org>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>
List-Id: linux-pm@vger.kernel.org

This patch converts existing .target() to newly defined light weight
.target_index() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 81d1727..f6f877c 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -39,30 +39,17 @@ static unsigned int imx6q_get_speed(unsigned int cpu)
 	return clk_get_rate(arm_clk) / 1000;
 }
 
-static int imx6q_set_target(struct cpufreq_policy *policy,
-			    unsigned int target_freq, unsigned int relation)
+static int imx6q_set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct cpufreq_freqs freqs;
 	struct opp *opp;
 	unsigned long freq_hz, volt, volt_old;
-	unsigned int index;
 	int ret;
 
-	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
-					     relation, &index);
-	if (ret) {
-		dev_err(cpu_dev, "failed to match target frequency %d: %d\n",
-			target_freq, ret);
-		return ret;
-	}
-
 	freqs.new = freq_table[index].frequency;
 	freq_hz = freqs.new * 1000;
 	freqs.old = clk_get_rate(arm_clk) / 1000;
 
-	if (freqs.old == freqs.new)
-		return 0;
-
 	rcu_read_lock();
 	opp = opp_find_freq_ceil(cpu_dev, &freq_hz);
 	if (IS_ERR(opp)) {
@@ -187,7 +174,7 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.verify = cpufreq_generic_frequency_table_verify,
-	.target = imx6q_set_target,
+	.target_index = imx6q_set_target,
 	.get = imx6q_get_speed,
 	.init = imx6q_cpufreq_init,
 	.exit = cpufreq_generic_exit,
-- 
1.7.12.rc2.18.g61b472e

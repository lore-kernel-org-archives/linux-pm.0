From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 222/228] cpufreq: omap: use cpufreq_generic_get() routine
Date: Fri, 13 Sep 2013 18:32:48 +0530
Message-ID: <60f6566be07a8b7c45fdce1757cca35499a95685.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-pm@vger.kernel.org

We have common infrastructure available with us for getting a CPUs clk rate.
Lets use it for this driver.

We don't need a global variable to hold clock anymore.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/omap-cpufreq.c | 32 ++++++++++----------------------
 1 file changed, 10 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index e92d72e..a94c4ef 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -36,21 +36,9 @@
 
 static struct cpufreq_frequency_table *freq_table;
 static atomic_t freq_table_users = ATOMIC_INIT(0);
-static struct clk *mpu_clk;
 static struct device *mpu_dev;
 static struct regulator *mpu_reg;
 
-static unsigned int omap_getspeed(unsigned int cpu)
-{
-	unsigned long rate;
-
-	if (cpu >= NR_CPUS)
-		return 0;
-
-	rate = clk_get_rate(mpu_clk) / 1000;
-	return rate;
-}
-
 static int omap_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	int r, ret;
@@ -58,11 +46,11 @@ static int omap_target(struct cpufreq_policy *policy, unsigned int index)
 	unsigned long freq, volt = 0, volt_old = 0, tol = 0;
 	unsigned int old_freq, new_freq;
 
-	old_freq = omap_getspeed(policy->cpu);
+	old_freq = policy->cur;
 	new_freq = freq_table[index].frequency;
 
 	freq = new_freq * 1000;
-	ret = clk_round_rate(mpu_clk, freq);
+	ret = clk_round_rate(policy->clk, freq);
 	if (IS_ERR_VALUE(ret)) {
 		dev_warn(mpu_dev,
 			 "CPUfreq: Cannot find matching frequency for %lu\n",
@@ -100,7 +88,7 @@ static int omap_target(struct cpufreq_policy *policy, unsigned int index)
 		}
 	}
 
-	ret = clk_set_rate(mpu_clk, new_freq * 1000);
+	ret = clk_set_rate(policy->clk, new_freq * 1000);
 
 	/* scaling down?  scale voltage after frequency */
 	if (mpu_reg && (new_freq < old_freq)) {
@@ -108,7 +96,7 @@ static int omap_target(struct cpufreq_policy *policy, unsigned int index)
 		if (r < 0) {
 			dev_warn(mpu_dev, "%s: unable to scale voltage down.\n",
 				 __func__);
-			clk_set_rate(mpu_clk, old_freq * 1000);
+			clk_set_rate(policy->clk, old_freq * 1000);
 			return r;
 		}
 	}
@@ -126,9 +114,9 @@ static int omap_cpu_init(struct cpufreq_policy *policy)
 {
 	int result;
 
-	mpu_clk = clk_get(NULL, "cpufreq_ck");
-	if (IS_ERR(mpu_clk))
-		return PTR_ERR(mpu_clk);
+	policy->clk = clk_get(NULL, "cpufreq_ck");
+	if (IS_ERR(policy->clk))
+		return PTR_ERR(policy->clk);
 
 	if (!freq_table) {
 		result = opp_init_cpufreq_table(mpu_dev, &freq_table);
@@ -149,7 +137,7 @@ static int omap_cpu_init(struct cpufreq_policy *policy)
 
 	freq_table_free();
 fail:
-	clk_put(mpu_clk);
+	clk_put(policy->clk);
 	return result;
 }
 
@@ -157,7 +145,7 @@ static int omap_cpu_exit(struct cpufreq_policy *policy)
 {
 	cpufreq_frequency_table_put_attr(policy->cpu);
 	freq_table_free();
-	clk_put(mpu_clk);
+	clk_put(policy->clk);
 	return 0;
 }
 
@@ -165,7 +153,7 @@ static struct cpufreq_driver omap_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= omap_target,
-	.get		= omap_getspeed,
+	.get		= cpufreq_generic_get,
 	.init		= omap_cpu_init,
 	.exit		= omap_cpu_exit,
 	.name		= "omap",
-- 
1.7.12.rc2.18.g61b472e

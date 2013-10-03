From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 19/92] cpufreq: omap: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:13 +0530
Message-ID: <ef6938e35adaf7738bb5aa8d75469648c7d42572.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-pm@vger.kernel.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/omap-cpufreq.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 091f233..48020b5 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -40,13 +40,6 @@ static struct clk *mpu_clk;
 static struct device *mpu_dev;
 static struct regulator *mpu_reg;
 
-static int omap_verify_speed(struct cpufreq_policy *policy)
-{
-	if (!freq_table)
-		return -EINVAL;
-	return cpufreq_frequency_table_verify(policy, freq_table);
-}
-
 static unsigned int omap_getspeed(unsigned int cpu)
 {
 	unsigned long rate;
@@ -227,20 +220,15 @@ static int omap_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static struct freq_attr *omap_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver omap_driver = {
 	.flags		= CPUFREQ_STICKY,
-	.verify		= omap_verify_speed,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= omap_target,
 	.get		= omap_getspeed,
 	.init		= omap_cpu_init,
 	.exit		= omap_cpu_exit,
 	.name		= "omap",
-	.attr		= omap_cpufreq_attr,
+	.attr		= cpufreq_generic_attr,
 };
 
 static int omap_cpufreq_probe(struct platform_device *pdev)
-- 
1.7.12.rc2.18.g61b472e


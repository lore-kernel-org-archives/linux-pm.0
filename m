From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 33/92] cpufreq: spear: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:27 +0530
Message-ID: <d8c2639d7c1c7d3773ddc881d9e2e63907a257d2.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, spear-devel@list.st.com
List-Id: linux-pm@vger.kernel.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: spear-devel@list.st.com
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/spear-cpufreq.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 9ff05d4..796b1db 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -30,11 +30,6 @@ static struct {
 	u32 cnt;
 } spear_cpufreq;
 
-static int spear_cpufreq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, spear_cpufreq.freq_tbl);
-}
-
 static unsigned int spear_cpufreq_get(unsigned int cpu)
 {
 	return clk_get_rate(spear_cpufreq.clk) / 1000;
@@ -192,26 +187,15 @@ static int spear_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int spear_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-static struct freq_attr *spear_cpufreq_attr[] = {
-	 &cpufreq_freq_attr_scaling_available_freqs,
-	 NULL,
-};
-
 static struct cpufreq_driver spear_cpufreq_driver = {
 	.name		= "cpufreq-spear",
 	.flags		= CPUFREQ_STICKY,
-	.verify		= spear_cpufreq_verify,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= spear_cpufreq_target,
 	.get		= spear_cpufreq_get,
 	.init		= spear_cpufreq_init,
-	.exit		= spear_cpufreq_exit,
-	.attr		= spear_cpufreq_attr,
+	.exit		= cpufreq_generic_exit,
+	.attr		= cpufreq_generic_attr,
 };
 
 static int spear_cpufreq_driver_init(void)
-- 
1.7.12.rc2.18.g61b472e


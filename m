From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 063/228] cpufreq: dbx500: Use generic cpufreq routines
Date: Fri, 13 Sep 2013 18:30:09 +0530
Message-ID: <a3970f9a04fd061a7ad476f983e10a8768c89fd0.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
List-Id: linux-pm@vger.kernel.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 8a484e9..2d70637 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -19,16 +19,6 @@
 static struct cpufreq_frequency_table *freq_table;
 static struct clk *armss_clk;
 
-static struct freq_attr *dbx500_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
-static int dbx500_cpufreq_verify_speed(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, freq_table);
-}
-
 static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 				unsigned int target_freq,
 				unsigned int relation)
@@ -113,12 +103,12 @@ static int dbx500_cpufreq_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver dbx500_cpufreq_driver = {
 	.flags  = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS,
-	.verify = dbx500_cpufreq_verify_speed,
+	.verify = cpufreq_generic_frequency_table_verify,
 	.target = dbx500_cpufreq_target,
 	.get    = dbx500_cpufreq_getspeed,
 	.init   = dbx500_cpufreq_init,
 	.name   = "DBX500",
-	.attr   = dbx500_cpufreq_attr,
+	.attr   = cpufreq_generic_attr,
 };
 
 static int dbx500_cpufreq_probe(struct platform_device *pdev)
-- 
1.7.12.rc2.18.g61b472e

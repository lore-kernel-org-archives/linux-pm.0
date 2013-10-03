From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 10/92] cpufreq: e_powersaver: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:04 +0530
Message-ID: <d918330c30d493409ee4b6e4657ba0f4b8148a7d.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/e_powersaver.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/e_powersaver.c b/drivers/cpufreq/e_powersaver.c
index c1b7c99..a8cbbd0 100644
--- a/drivers/cpufreq/e_powersaver.c
+++ b/drivers/cpufreq/e_powersaver.c
@@ -198,12 +198,6 @@ static int eps_target(struct cpufreq_policy *policy,
 	return ret;
 }
 
-static int eps_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy,
-			&eps_cpu[policy->cpu]->freq_table[0]);
-}
-
 static int eps_cpu_init(struct cpufreq_policy *policy)
 {
 	unsigned int i;
@@ -423,19 +417,14 @@ static int eps_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static struct freq_attr *eps_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver eps_driver = {
-	.verify		= eps_verify,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= eps_target,
 	.init		= eps_cpu_init,
 	.exit		= eps_cpu_exit,
 	.get		= eps_get,
 	.name		= "e_powersaver",
-	.attr		= eps_attr,
+	.attr		= cpufreq_generic_attr,
 };
 
 
-- 
1.7.12.rc2.18.g61b472e


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 075/228] cpufreq: pasemi: Use generic cpufreq routines
Date: Fri, 13 Sep 2013 18:30:21 +0530
Message-ID: <8a76fece462a8b3c8aa7aad94e0e20dffd227e97.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/pasemi-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 23bc8a82..16f2508 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -69,11 +69,6 @@ static struct cpufreq_frequency_table pas_freqs[] = {
 	{0,	CPUFREQ_TABLE_END},
 };
 
-static struct freq_attr *pas_cpu_freqs_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 /*
  * hardware specific functions
  */
@@ -251,11 +246,6 @@ static int pas_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int pas_cpufreq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, pas_freqs);
-}
-
 static int pas_cpufreq_target(struct cpufreq_policy *policy,
 			      unsigned int target_freq,
 			      unsigned int relation)
@@ -298,9 +288,9 @@ static struct cpufreq_driver pas_cpufreq_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS,
 	.init		= pas_cpufreq_cpu_init,
 	.exit		= pas_cpufreq_cpu_exit,
-	.verify		= pas_cpufreq_verify,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= pas_cpufreq_target,
-	.attr		= pas_cpu_freqs_attr,
+	.attr		= cpufreq_generic_attr,
 };
 
 /*
-- 
1.7.12.rc2.18.g61b472e


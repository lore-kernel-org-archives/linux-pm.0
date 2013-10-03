From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 27/92] cpufreq: s3cx4xx: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:21 +0530
Message-ID: <d43483a3c36ca89e75975485762f7ae9f75c8538.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:38842 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab3JCPC1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:02:27 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so2586542pde.24
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:02:26 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s3c2416-cpufreq.c | 19 ++-----------------
 drivers/cpufreq/s3c24xx-cpufreq.c |  9 ---------
 drivers/cpufreq/s3c64xx-cpufreq.c | 10 +---------
 3 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
index a7a4c61..8c57f10 100644
--- a/drivers/cpufreq/s3c2416-cpufreq.c
+++ b/drivers/cpufreq/s3c2416-cpufreq.c
@@ -87,16 +87,6 @@ static struct cpufreq_frequency_table s3c2450_freq_table[] = {
 	{ 0, CPUFREQ_TABLE_END },
 };
 
-static int s3c2416_cpufreq_verify_speed(struct cpufreq_policy *policy)
-{
-	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
-
-	if (policy->cpu != 0)
-		return -EINVAL;
-
-	return cpufreq_frequency_table_verify(policy, s3c_freq->freq_table);
-}
-
 static unsigned int s3c2416_cpufreq_get_speed(unsigned int cpu)
 {
 	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
@@ -516,19 +506,14 @@ err_hclk:
 	return ret;
 }
 
-static struct freq_attr *s3c2416_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver s3c2416_cpufreq_driver = {
 	.flags          = 0,
-	.verify		= s3c2416_cpufreq_verify_speed,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= s3c2416_cpufreq_set_target,
 	.get		= s3c2416_cpufreq_get_speed,
 	.init		= s3c2416_cpufreq_driver_init,
 	.name		= "s3c2416",
-	.attr		= s3c2416_cpufreq_attr,
+	.attr		= cpufreq_generic_attr,
 };
 
 static int __init s3c2416_cpufreq_init(void)
diff --git a/drivers/cpufreq/s3c24xx-cpufreq.c b/drivers/cpufreq/s3c24xx-cpufreq.c
index 73856d1..027dec1 100644
--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -416,14 +416,6 @@ static int __init s3c_cpufreq_initclks(void)
 	return 0;
 }
 
-static int s3c_cpufreq_verify(struct cpufreq_policy *policy)
-{
-	if (policy->cpu != 0)
-		return -EINVAL;
-
-	return 0;
-}
-
 #ifdef CONFIG_PM
 static struct cpufreq_frequency_table suspend_pll;
 static unsigned int suspend_freq;
@@ -473,7 +465,6 @@ static int s3c_cpufreq_resume(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver s3c24xx_driver = {
 	.flags		= CPUFREQ_STICKY,
-	.verify		= s3c_cpufreq_verify,
 	.target		= s3c_cpufreq_target,
 	.get		= s3c_cpufreq_get,
 	.init		= s3c_cpufreq_init,
diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index 872f74d..99fbc49 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -54,14 +54,6 @@ static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 };
 #endif
 
-static int s3c64xx_cpufreq_verify_speed(struct cpufreq_policy *policy)
-{
-	if (policy->cpu != 0)
-		return -EINVAL;
-
-	return cpufreq_frequency_table_verify(policy, s3c64xx_freq_table);
-}
-
 static unsigned int s3c64xx_cpufreq_get_speed(unsigned int cpu)
 {
 	if (cpu != 0)
@@ -264,7 +256,7 @@ static int s3c64xx_cpufreq_driver_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver s3c64xx_cpufreq_driver = {
 	.flags          = 0,
-	.verify		= s3c64xx_cpufreq_verify_speed,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= s3c64xx_cpufreq_set_target,
 	.get		= s3c64xx_cpufreq_get_speed,
 	.init		= s3c64xx_cpufreq_driver_init,
-- 
1.7.12.rc2.18.g61b472e


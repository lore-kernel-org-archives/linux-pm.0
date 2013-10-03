From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 12/92] cpufreq: exynos: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:06 +0530
Message-ID: <f633ecaf509543ca3ea22c7952a470eccd5ec7ae.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:46396 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab3JCPBA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:01:00 -0400
Received: by mail-pd0-f171.google.com with SMTP id g10so2589389pdj.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:01:00 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Acked-By: Amit Daniel Kachhap <amit.daniel@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos-cpufreq.c     | 23 +++--------------------
 drivers/cpufreq/exynos5440-cpufreq.c | 16 ++--------------
 2 files changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 954baed..08338d4 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -31,12 +31,6 @@ static unsigned int locking_frequency;
 static bool frequency_locked;
 static DEFINE_MUTEX(cpufreq_lock);
 
-static int exynos_verify_speed(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy,
-					      exynos_info->freq_table);
-}
-
 static unsigned int exynos_getspeed(unsigned int cpu)
 {
 	return clk_get_rate(exynos_info->cpu_clk) / 1000;
@@ -257,26 +251,15 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_table_validate_and_show(policy, exynos_info->freq_table);
 }
 
-static int exynos_cpufreq_cpu_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-static struct freq_attr *exynos_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver exynos_driver = {
 	.flags		= CPUFREQ_STICKY,
-	.verify		= exynos_verify_speed,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= exynos_target,
 	.get		= exynos_getspeed,
 	.init		= exynos_cpufreq_cpu_init,
-	.exit		= exynos_cpufreq_cpu_exit,
+	.exit		= cpufreq_generic_exit,
 	.name		= "exynos_cpufreq",
-	.attr		= exynos_cpufreq_attr,
+	.attr		= cpufreq_generic_attr,
 #ifdef CONFIG_PM
 	.suspend	= exynos_cpufreq_suspend,
 	.resume		= exynos_cpufreq_resume,
diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index 24df155..bce6f74 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -209,12 +209,6 @@ static void exynos_enable_dvfs(void)
 				dvfs_info->base + XMU_DVFS_CTRL);
 }
 
-static int exynos_verify_speed(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy,
-					      dvfs_info->freq_table);
-}
-
 static unsigned int exynos_getspeed(unsigned int cpu)
 {
 	return dvfs_info->cur_frequency;
@@ -339,19 +333,13 @@ static int exynos_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int exynos_cpufreq_cpu_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
 static struct cpufreq_driver exynos_driver = {
 	.flags		= CPUFREQ_STICKY,
-	.verify		= exynos_verify_speed,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= exynos_target,
 	.get		= exynos_getspeed,
 	.init		= exynos_cpufreq_cpu_init,
-	.exit		= exynos_cpufreq_cpu_exit,
+	.exit		= cpufreq_generic_exit,
 	.name		= CPUFREQ_NAME,
 };
 
-- 
1.7.12.rc2.18.g61b472e


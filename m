From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 21/92] cpufreq: pasemi: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:15 +0530
Message-ID: <036307d29a5417ca3e64fba301a2e16f96afdaa1.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:53720 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab3JCPBv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:01:51 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so2610336pde.9
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:01:51 -0700 (PDT)
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


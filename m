From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 33/44] cpufreq: ppc_cbe: Use generic cpufreq routines
Date: Sat, 10 Aug 2013 12:14:29 +0530
Message-ID: <bea0ff11fbea4e8d65e088698623851ec12e1f68.1376116345.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:46544 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031965Ab3HJGvt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2013 02:51:49 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so5702652pad.16
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2013 23:51:48 -0700 (PDT)
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1376116344.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ppc_cbe_cpufreq.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/ppc_cbe_cpufreq.c b/drivers/cpufreq/ppc_cbe_cpufreq.c
index 6c5be63..38540d1 100644
--- a/drivers/cpufreq/ppc_cbe_cpufreq.c
+++ b/drivers/cpufreq/ppc_cbe_cpufreq.c
@@ -128,17 +128,6 @@ static int cbe_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_table_validate_and_show(policy, cbe_freqs);
 }
 
-static int cbe_cpufreq_cpu_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-static int cbe_cpufreq_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, cbe_freqs);
-}
-
 static int cbe_cpufreq_target(struct cpufreq_policy *policy,
 			      unsigned int target_freq,
 			      unsigned int relation)
@@ -174,10 +163,10 @@ static int cbe_cpufreq_target(struct cpufreq_policy *policy,
 }
 
 static struct cpufreq_driver cbe_cpufreq_driver = {
-	.verify		= cbe_cpufreq_verify,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= cbe_cpufreq_target,
 	.init		= cbe_cpufreq_cpu_init,
-	.exit		= cbe_cpufreq_cpu_exit,
+	.exit		= cpufreq_generic_exit,
 	.name		= "cbe-cpufreq",
 	.flags		= CPUFREQ_CONST_LOOPS,
 };
-- 
1.7.12.rc2.18.g61b472e


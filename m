From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 29/44] cpufreq: pcc: Use generic cpufreq routines
Date: Sat, 10 Aug 2013 12:14:25 +0530
Message-ID: <707070e59966ed3982ee52b367991e0b175e0319.1376116345.git.viresh.kumar@linaro.org>
References: <cover.1376116344.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33219 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968432Ab3HJGvW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 10 Aug 2013 02:51:22 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so5677138pad.30
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2013 23:51:21 -0700 (PDT)
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
 drivers/cpufreq/pcc-cpufreq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index d81c4e5..90aa385 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -109,13 +109,6 @@ struct pcc_cpu {
 
 static struct pcc_cpu __percpu *pcc_cpu_info;
 
-static int pcc_cpufreq_verify(struct cpufreq_policy *policy)
-{
-	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-				     policy->cpuinfo.max_freq);
-	return 0;
-}
-
 static inline void pcc_cmd(void)
 {
 	u64 doorbell_value;
@@ -582,7 +575,7 @@ static int pcc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 static struct cpufreq_driver pcc_cpufreq_driver = {
 	.flags = CPUFREQ_CONST_LOOPS,
 	.get = pcc_get_freq,
-	.verify = pcc_cpufreq_verify,
+	.verify = cpufreq_generic_frequency_table_verify,
 	.target = pcc_cpufreq_target,
 	.init = pcc_cpufreq_cpu_init,
 	.exit = pcc_cpufreq_cpu_exit,
-- 
1.7.12.rc2.18.g61b472e


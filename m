From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 05/92] cpufreq: blackfin: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:27:59 +0530
Message-ID: <d5ac0ff75ef623addd8f68151e46d0fdada275ba.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:63007 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965Ab3JCPAH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:00:07 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so2681946pdj.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:00:05 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Steven Miao <realmz6@gmail.com>

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Steven Miao <realmz6@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/blackfin-cpufreq.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
index 0e76c09..48888cf 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -191,11 +191,6 @@ static int bfin_target(struct cpufreq_policy *policy,
 	return ret;
 }
 
-static int bfin_verify_speed(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, bfin_freq_table);
-}
-
 static int __bfin_cpu_init(struct cpufreq_policy *policy)
 {
 
@@ -213,26 +208,14 @@ static int __bfin_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_table_validate_and_show(policy, bfin_freq_table);
 }
 
-static int __bfin_cpu_exit(struct cpufreq_policy *policy)
-{
-
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-static struct freq_attr *bfin_freq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver bfin_driver = {
-	.verify = bfin_verify_speed,
+	.verify = cpufreq_generic_frequency_table_verify,
 	.target = bfin_target,
 	.get = bfin_getfreq_khz,
 	.init = __bfin_cpu_init,
-	.exit = __bfin_cpu_exit,
+	.exit = cpufreq_generic_exit,
 	.name = "bfin cpufreq",
-	.attr = bfin_freq_attr,
+	.attr = cpufreq_generic_attr,
 };
 
 static int __init bfin_cpu_init(void)
-- 
1.7.12.rc2.18.g61b472e


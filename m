From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 16/92] cpufreq: longhaul: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:10 +0530
Message-ID: <fa12aab964c4470b0e44a2fc715fa54a9d9e34ea.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:55171 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754326Ab3JCPBX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:01:23 -0400
Received: by mail-pa0-f48.google.com with SMTP id bj1so2734447pad.35
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:01:22 -0700 (PDT)
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
 drivers/cpufreq/longhaul.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index 70b66fd..57d7b02 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -625,12 +625,6 @@ static void longhaul_setup_voltagescaling(void)
 }
 
 
-static int longhaul_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, longhaul_table);
-}
-
-
 static int longhaul_target(struct cpufreq_policy *policy,
 			    unsigned int target_freq, unsigned int relation)
 {
@@ -924,25 +918,14 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
 	return cpufreq_table_validate_and_show(policy, longhaul_table);
 }
 
-static int longhaul_cpu_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-static struct freq_attr *longhaul_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver longhaul_driver = {
-	.verify	= longhaul_verify,
+	.verify	= cpufreq_generic_frequency_table_verify,
 	.target	= longhaul_target,
 	.get	= longhaul_get,
 	.init	= longhaul_cpu_init,
-	.exit	= longhaul_cpu_exit,
+	.exit	= cpufreq_generic_exit,
 	.name	= "longhaul",
-	.attr	= longhaul_attr,
+	.attr	= cpufreq_generic_attr,
 };
 
 static const struct x86_cpu_id longhaul_id[] = {
-- 
1.7.12.rc2.18.g61b472e


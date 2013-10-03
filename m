From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 20/92] cpufreq: p4-clockmod: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:14 +0530
Message-ID: <b9d0668b8f2c0fbe462c8d1011343f756a29aa25.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:37477 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279Ab3JCPBq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:01:46 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so2746060pad.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:01:45 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "David S. Miller" <davem@davemloft.net>

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/p4-clockmod.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 03478bf..4fe6d4c 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -140,12 +140,6 @@ static int cpufreq_p4_target(struct cpufreq_policy *policy,
 }
 
 
-static int cpufreq_p4_verify(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, &p4clockmod_table[0]);
-}
-
-
 static unsigned int cpufreq_p4_get_frequency(struct cpuinfo_x86 *c)
 {
 	if (c->x86 == 0x06) {
@@ -242,12 +236,6 @@ static int cpufreq_p4_cpu_init(struct cpufreq_policy *policy)
 }
 
 
-static int cpufreq_p4_cpu_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
 static unsigned int cpufreq_p4_get(unsigned int cpu)
 {
 	u32 l, h;
@@ -266,19 +254,14 @@ static unsigned int cpufreq_p4_get(unsigned int cpu)
 	return stock_freq;
 }
 
-static struct freq_attr *p4clockmod_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver p4clockmod_driver = {
-	.verify		= cpufreq_p4_verify,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target		= cpufreq_p4_target,
 	.init		= cpufreq_p4_cpu_init,
-	.exit		= cpufreq_p4_cpu_exit,
+	.exit		= cpufreq_generic_exit,
 	.get		= cpufreq_p4_get,
 	.name		= "p4-clockmod",
-	.attr		= p4clockmod_attr,
+	.attr		= cpufreq_generic_attr,
 };
 
 static const struct x86_cpu_id cpufreq_p4_id[] = {
-- 
1.7.12.rc2.18.g61b472e


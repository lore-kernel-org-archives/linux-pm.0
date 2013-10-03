From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 09/92] cpufreq: dbx500: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:03 +0530
Message-ID: <da2fbf08c7e7844d668552e08296918fca7ad361.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:48205 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab3JCPAm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:00:42 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so2596109pbc.15
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:00:42 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>

Most of the CPUFreq drivers do similar things in .exit() and .verify() routines
and .attr. So its better if we have generic routines for them which can be used
by cpufreq drivers then.

This patch uses these generic routines for this driver.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/dbx500-cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 8a484e9..2d70637 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -19,16 +19,6 @@
 static struct cpufreq_frequency_table *freq_table;
 static struct clk *armss_clk;
 
-static struct freq_attr *dbx500_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
-static int dbx500_cpufreq_verify_speed(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, freq_table);
-}
-
 static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 				unsigned int target_freq,
 				unsigned int relation)
@@ -113,12 +103,12 @@ static int dbx500_cpufreq_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver dbx500_cpufreq_driver = {
 	.flags  = CPUFREQ_STICKY | CPUFREQ_CONST_LOOPS,
-	.verify = dbx500_cpufreq_verify_speed,
+	.verify = cpufreq_generic_frequency_table_verify,
 	.target = dbx500_cpufreq_target,
 	.get    = dbx500_cpufreq_getspeed,
 	.init   = dbx500_cpufreq_init,
 	.name   = "DBX500",
-	.attr   = dbx500_cpufreq_attr,
+	.attr   = cpufreq_generic_attr,
 };
 
 static int dbx500_cpufreq_probe(struct platform_device *pdev)
-- 
1.7.12.rc2.18.g61b472e


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 14/92] cpufreq: imx6q: Use generic cpufreq routines
Date: Thu,  3 Oct 2013 20:28:08 +0530
Message-ID: <d31a827f1d8929a31f91a05b7c4fcf271b9b9648.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:37766 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691Ab3JCPBM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:01:12 -0400
Received: by mail-pb0-f49.google.com with SMTP id xb4so2574167pbc.36
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:01:12 -0700 (PDT)
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

Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index af0e202..d839657 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -35,11 +35,6 @@ static struct device *cpu_dev;
 static struct cpufreq_frequency_table *freq_table;
 static unsigned int transition_latency;
 
-static int imx6q_verify_speed(struct cpufreq_policy *policy)
-{
-	return cpufreq_frequency_table_verify(policy, freq_table);
-}
-
 static unsigned int imx6q_get_speed(unsigned int cpu)
 {
 	return clk_get_rate(arm_clk) / 1000;
@@ -174,25 +169,14 @@ static int imx6q_cpufreq_init(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static int imx6q_cpufreq_exit(struct cpufreq_policy *policy)
-{
-	cpufreq_frequency_table_put_attr(policy->cpu);
-	return 0;
-}
-
-static struct freq_attr *imx6q_cpufreq_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-
 static struct cpufreq_driver imx6q_cpufreq_driver = {
-	.verify = imx6q_verify_speed,
+	.verify = cpufreq_generic_frequency_table_verify,
 	.target = imx6q_set_target,
 	.get = imx6q_get_speed,
 	.init = imx6q_cpufreq_init,
-	.exit = imx6q_cpufreq_exit,
+	.exit = cpufreq_generic_exit,
 	.name = "imx6q-cpufreq",
-	.attr = imx6q_cpufreq_attr,
+	.attr = cpufreq_generic_attr,
 };
 
 static int imx6q_cpufreq_probe(struct platform_device *pdev)
-- 
1.7.12.rc2.18.g61b472e


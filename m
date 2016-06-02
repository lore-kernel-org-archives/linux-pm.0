From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/11] cpufreq: davinci: Reuse cpufreq_generic_frequency_table_verify()
Date: Thu,  2 Jun 2016 19:49:02 +0530
Message-ID: <c3b29621bf1caddf63abae91cd69646d6ca9d25a.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33951 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932867AbcFBOT0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 10:19:26 -0400
Received: by mail-pf0-f173.google.com with SMTP id 62so31937599pfd.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jun 2016 07:19:26 -0700 (PDT)
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464876460.git.viresh.kumar@linaro.org>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>

policy->freq_table will always be valid for this platform, otherwise
driver's probe() would fail. And so this routine will *always* return
after calling cpufreq_frequency_table_verify().

This can be done using the generic callback provided by core, lets use
it instead.

Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/davinci-cpufreq.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/cpufreq/davinci-cpufreq.c b/drivers/cpufreq/davinci-cpufreq.c
index 7e336d20c184..b95a872800ec 100644
--- a/drivers/cpufreq/davinci-cpufreq.c
+++ b/drivers/cpufreq/davinci-cpufreq.c
@@ -38,26 +38,6 @@ struct davinci_cpufreq {
 };
 static struct davinci_cpufreq cpufreq;
 
-static int davinci_verify_speed(struct cpufreq_policy *policy)
-{
-	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
-	struct cpufreq_frequency_table *freq_table = pdata->freq_table;
-	struct clk *armclk = cpufreq.armclk;
-
-	if (freq_table)
-		return cpufreq_frequency_table_verify(policy, freq_table);
-
-	if (policy->cpu)
-		return -EINVAL;
-
-	cpufreq_verify_within_cpu_limits(policy);
-	policy->min = clk_round_rate(armclk, policy->min * 1000) / 1000;
-	policy->max = clk_round_rate(armclk, policy->max * 1000) / 1000;
-	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-						policy->cpuinfo.max_freq);
-	return 0;
-}
-
 static int davinci_target(struct cpufreq_policy *policy, unsigned int idx)
 {
 	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
@@ -121,7 +101,7 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
 
 static struct cpufreq_driver davinci_driver = {
 	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK,
-	.verify		= davinci_verify_speed,
+	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= davinci_target,
 	.get		= cpufreq_generic_get,
 	.init		= davinci_cpu_init,
-- 
2.7.1.410.g6faf27b


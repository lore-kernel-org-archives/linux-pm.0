From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 89/92] cpufreq: s5pv210: use cpufreq_generic_init() routine
Date: Thu,  3 Oct 2013 20:29:23 +0530
Message-ID: <802380c71397b83bce659fb36e06c7ba1100ba93.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:56504 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754371Ab3JCPIm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Oct 2013 11:08:42 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so2587971pdj.36
        for <linux-pm@vger.kernel.org>; Thu, 03 Oct 2013 08:08:41 -0700 (PDT)
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1380783079.git.viresh.kumar@linaro.org>
References: <cover.1380783079.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Use generic cpufreq_generic_init() routine instead of replicating the same code
here.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 30d9bb7..600b4f4 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -543,9 +543,7 @@ static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
 	s5pv210_dram_conf[1].refresh = (__raw_readl(S5P_VA_DMC1 + 0x30) * 1000);
 	s5pv210_dram_conf[1].freq = clk_get_rate(dmc1_clk);
 
-	policy->cpuinfo.transition_latency = 40000;
-
-	return cpufreq_table_validate_and_show(policy, s5pv210_freq_table);
+	return cpufreq_generic_init(policy, s5pv210_freq_table, 40000);
 
 out_dmc1:
 	clk_put(dmc0_clk);
-- 
1.7.12.rc2.18.g61b472e


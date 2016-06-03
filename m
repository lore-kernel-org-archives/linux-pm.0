From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 2/9] cpufreq: blackfin: Use 'index' only to index into policy->freq_table
Date: Fri,  3 Jun 2016 19:05:08 +0530
Message-ID: <9d97ad7c5eb1263cfa27778ed0f30ba564d969c8.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:32820 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932909AbcFCNfg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2016 09:35:36 -0400
Received: by mail-pf0-f169.google.com with SMTP id b124so43926694pfb.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Jun 2016 06:35:35 -0700 (PDT)
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, Steven Miao <realmz6@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Shawn Guo <shawn.guo@freescale.com>

Later patches would make changes in cpufreq core, after which
policy->freq_table may be reordered by cpufreq core and it wouldn't be
safe anymore to use 'index' for any other local arrays.

To prepare for that, use policy->freq_table[index].driver_data for other
driver specific usage of 'index'. The 'driver_data' fields are already
set properly by the driver.

Cc: Steven Miao <realmz6@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/blackfin-cpufreq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
index 1650c213f465..101daa851c81 100644
--- a/drivers/cpufreq/blackfin-cpufreq.c
+++ b/drivers/cpufreq/blackfin-cpufreq.c
@@ -135,6 +135,7 @@ static int bfin_target(struct cpufreq_policy *policy, unsigned int index)
 	static unsigned long lpj_ref;
 	static unsigned int  lpj_ref_freq;
 	unsigned int old_freq, new_freq;
+	int dpm_index;
 	int ret = 0;
 
 #if defined(CONFIG_CYCLES_CLOCKSOURCE)
@@ -144,8 +145,14 @@ static int bfin_target(struct cpufreq_policy *policy, unsigned int index)
 	old_freq = bfin_getfreq_khz(0);
 	new_freq = policy->freq_table[index].frequency;
 
+	/*
+	 * policy->freq_table may be sorted differently, get the index value we
+	 * are concerned about.
+	 */
+	dpm_index = policy->freq_table[index].driver_data;
+
 #ifndef CONFIG_BF60x
-	plldiv = (bfin_read_PLL_DIV() & SSEL) | dpm_state_table[index].csel;
+	plldiv = (bfin_read_PLL_DIV() & SSEL) | dpm_state_table[dpm_index].csel;
 	bfin_write_PLL_DIV(plldiv);
 #else
 	ret = cpu_set_cclk(policy->cpu, new_freq * 1000);
@@ -154,13 +161,13 @@ static int bfin_target(struct cpufreq_policy *policy, unsigned int index)
 		return ret;
 	}
 #endif
-	on_each_cpu(bfin_adjust_core_timer, &index, 1);
+	on_each_cpu(bfin_adjust_core_timer, &dpm_index, 1);
 #if defined(CONFIG_CYCLES_CLOCKSOURCE)
 	cycles = get_cycles();
 	SSYNC();
 	cycles += 10; /* ~10 cycles we lose after get_cycles() */
-	__bfin_cycles_off += (cycles << __bfin_cycles_mod) - (cycles << index);
-	__bfin_cycles_mod = index;
+	__bfin_cycles_off += (cycles << __bfin_cycles_mod) - (cycles << dpm_index);
+	__bfin_cycles_mod = dpm_index;
 #endif
 	if (!lpj_ref_freq) {
 		lpj_ref = loops_per_jiffy;
-- 
2.7.1.410.g6faf27b


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/2] cpufreq: drivers: don't check range of target freq in .target()
Date: Sun, 24 Mar 2013 20:59:42 +0530
Message-ID: <2ece6d9fe8dfb6882a1c83a1cb2404bacc40b22d.1364138740.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57721 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408Ab3CXP36 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Mar 2013 11:29:58 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx1so169336pab.28
        for <linux-pm@vger.kernel.org>; Sun, 24 Mar 2013 08:29:57 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Sekhar Nori <nsekhar@ti.com>, Linus Walleij <linus.walleij@linaro.org>

Cpufreq core checks the range of target_freq before calling driver->target() and
so we don't need to do it again.

Remove it.

Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/mach-davinci/cpufreq.c  | 9 ---------
 drivers/cpufreq/dbx500-cpufreq.c | 6 ------
 2 files changed, 15 deletions(-)

diff --git a/arch/arm/mach-davinci/cpufreq.c b/arch/arm/mach-davinci/cpufreq.c
index 55eb870..8fb0c2a 100644
--- a/arch/arm/mach-davinci/cpufreq.c
+++ b/arch/arm/mach-davinci/cpufreq.c
@@ -79,15 +79,6 @@ static int davinci_target(struct cpufreq_policy *policy,
 	struct davinci_cpufreq_config *pdata = cpufreq.dev->platform_data;
 	struct clk *armclk = cpufreq.armclk;
 
-	/*
-	 * Ensure desired rate is within allowed range.  Some govenors
-	 * (ondemand) will just pass target_freq=0 to get the minimum.
-	 */
-	if (target_freq < policy->cpuinfo.min_freq)
-		target_freq = policy->cpuinfo.min_freq;
-	if (target_freq > policy->cpuinfo.max_freq)
-		target_freq = policy->cpuinfo.max_freq;
-
 	freqs.old = davinci_getspeed(0);
 	freqs.new = clk_round_rate(armclk, target_freq * 1000) / 1000;
 
diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
index 7192a6d..15ed367 100644
--- a/drivers/cpufreq/dbx500-cpufreq.c
+++ b/drivers/cpufreq/dbx500-cpufreq.c
@@ -37,12 +37,6 @@ static int dbx500_cpufreq_target(struct cpufreq_policy *policy,
 	unsigned int idx;
 	int ret;
 
-	/* scale the target frequency to one of the extremes supported */
-	if (target_freq < policy->cpuinfo.min_freq)
-		target_freq = policy->cpuinfo.min_freq;
-	if (target_freq > policy->cpuinfo.max_freq)
-		target_freq = policy->cpuinfo.max_freq;
-
 	/* Lookup the next frequency */
 	if (cpufreq_frequency_table_target(policy, freq_table, target_freq,
 					relation, &idx))
-- 
1.7.12.rc2.18.g61b472e


From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 165/228] cpufreq: omap: Convert to light weight ->target_index() routine
Date: Fri, 13 Sep 2013 18:31:51 +0530
Message-ID: <802719c38c9051e0ade847081f29b01d47c546aa.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34639 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096Ab3IMNWj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 09:22:39 -0400
Received: by mail-pa0-f45.google.com with SMTP id bg4so2525495pad.4
        for <linux-pm@vger.kernel.org>; Fri, 13 Sep 2013 06:22:38 -0700 (PDT)
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch converts existing .target() to newly defined light weight
.target_index() routine for this driver.

CPUFreq core will call cpufreq_frequency_table_target() before calling this
routine and will pass index to it.

Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/omap-cpufreq.c | 31 +++----------------------------
 1 file changed, 3 insertions(+), 28 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 58b2200..0653887 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -51,40 +51,15 @@ static unsigned int omap_getspeed(unsigned int cpu)
 	return rate;
 }
 
-static int omap_target(struct cpufreq_policy *policy,
-		       unsigned int target_freq,
-		       unsigned int relation)
+static int omap_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned int i;
 	int r, ret = 0;
 	struct cpufreq_freqs freqs;
 	struct opp *opp;
 	unsigned long freq, volt = 0, volt_old = 0, tol = 0;
 
-	if (!freq_table) {
-		dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
-				policy->cpu);
-		return -EINVAL;
-	}
-
-	ret = cpufreq_frequency_table_target(policy, freq_table, target_freq,
-			relation, &i);
-	if (ret) {
-		dev_dbg(mpu_dev, "%s: cpu%d: no freq match for %d(ret=%d)\n",
-			__func__, policy->cpu, target_freq, ret);
-		return ret;
-	}
-	freqs.new = freq_table[i].frequency;
-	if (!freqs.new) {
-		dev_err(mpu_dev, "%s: cpu%d: no match for freq %d\n", __func__,
-			policy->cpu, target_freq);
-		return -EINVAL;
-	}
-
 	freqs.old = omap_getspeed(policy->cpu);
-
-	if (freqs.old == freqs.new && policy->cur == freqs.new)
-		return ret;
+	freqs.new = freq_table[index].frequency;
 
 	freq = freqs.new * 1000;
 	ret = clk_round_rate(mpu_clk, freq);
@@ -200,7 +175,7 @@ static int omap_cpu_exit(struct cpufreq_policy *policy)
 static struct cpufreq_driver omap_driver = {
 	.flags		= CPUFREQ_STICKY,
 	.verify		= cpufreq_generic_frequency_table_verify,
-	.target		= omap_target,
+	.target_index	= omap_target,
 	.get		= omap_getspeed,
 	.init		= omap_cpu_init,
 	.exit		= omap_cpu_exit,
-- 
1.7.12.rc2.18.g61b472e


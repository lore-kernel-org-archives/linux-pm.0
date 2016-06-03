From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 4/9] cpufreq: exynos: Use 'index' only to index into policy->freq_table
Date: Fri,  3 Jun 2016 19:05:10 +0530
Message-ID: <e6621408b2a7748d6b984eb6c97d8ee13be96ad5.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34024 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422640AbcFCNfm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jun 2016 09:35:42 -0400
Received: by mail-pa0-f44.google.com with SMTP id bz2so14804266pad.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jun 2016 06:35:42 -0700 (PDT)
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1464960877.git.viresh.kumar@linaro.org>
References: <cover.1464960877.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Shawn Guo <shawn.guo@freescale.com>, Steven Miao <realmz6@gmail.com>

Later patches would make changes in cpufreq core, after which
policy->freq_table may be reordered by cpufreq core and it wouldn't be
safe anymore to use 'index' for any other local arrays.

To prepare for that, use policy->freq_table[index].driver_data for other
driver specific usage of 'index'. The 'driver_data' fields are already
set properly by the driver.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/exynos5440-cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/exynos5440-cpufreq.c b/drivers/cpufreq/exynos5440-cpufreq.c
index 085f07d31ef0..6138cbb7594e 100644
--- a/drivers/cpufreq/exynos5440-cpufreq.c
+++ b/drivers/cpufreq/exynos5440-cpufreq.c
@@ -210,7 +210,7 @@ static void exynos_enable_dvfs(unsigned int cur_frequency)
 
 static int exynos_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned int tmp;
+	unsigned int tmp, rindex;
 	int i;
 
 	mutex_lock(&cpufreq_lock);
@@ -218,13 +218,19 @@ static int exynos_target(struct cpufreq_policy *policy, unsigned int index)
 	freqs.old = policy->cur;
 	freqs.new = policy->freq_table[index].frequency;
 
+	/*
+	 * policy->freq_table may be sorted differently, get the index value we
+	 * are concerned about.
+	 */
+	rindex = policy->freq_table[index].driver_data;
+
 	cpufreq_freq_transition_begin(policy, &freqs);
 
 	/* Set the target frequency in all C0_3_PSTATE register */
 	for_each_cpu(i, policy->cpus) {
 		tmp = __raw_readl(dvfs_info->base + XMU_C0_3_PSTATE + i * 4);
 		tmp &= ~(P_VALUE_MASK << C0_3_PSTATE_NEW_SHIFT);
-		tmp |= (index << C0_3_PSTATE_NEW_SHIFT);
+		tmp |= (rindex << C0_3_PSTATE_NEW_SHIFT);
 
 		__raw_writel(tmp, dvfs_info->base + XMU_C0_3_PSTATE + i * 4);
 	}
-- 
2.7.1.410.g6faf27b


From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 03/14] cpufreq: exynos4210: use devm_clk_get
Date: Mon,  2 Feb 2015 16:58:06 -0400
Message-ID: <1422910697-5920-4-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:52032 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965055AbbBBU6y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Feb 2015 15:58:54 -0500
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org

Switch to managed clk_get to properly release resources when
they are not needed.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/cpufreq/exynos4210-cpufreq.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/exynos4210-cpufreq.c b/drivers/cpufreq/exynos4210-cpufreq.c
index 8a25dce..fc02a39 100644
--- a/drivers/cpufreq/exynos4210-cpufreq.c
+++ b/drivers/cpufreq/exynos4210-cpufreq.c
@@ -142,23 +142,23 @@ int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
 		return -EFAULT;
 	}
 
-	cpu_clk = clk_get(NULL, "armclk");
+	cpu_clk = devm_clk_get(info->dev, "armclk");
 	if (IS_ERR(cpu_clk))
-		return PTR_ERR(cpu_clk);
+		goto err;
 
-	moutcore = clk_get(NULL, "moutcore");
+	moutcore = devm_clk_get(info->dev, "moutcore");
 	if (IS_ERR(moutcore))
-		goto err_moutcore;
+		goto err;
 
-	mout_mpll = clk_get(NULL, "mout_mpll");
+	mout_mpll = devm_clk_get(info->dev, "mout_mpll");
 	if (IS_ERR(mout_mpll))
-		goto err_mout_mpll;
+		goto err;
 
 	rate = clk_get_rate(mout_mpll) / 1000;
 
-	mout_apll = clk_get(NULL, "mout_apll");
+	mout_apll = devm_clk_get(info->dev, "mout_apll");
 	if (IS_ERR(mout_apll))
-		goto err_mout_apll;
+		goto err;
 
 	info->mpll_freq_khz = rate;
 	/* 800Mhz */
@@ -173,13 +173,7 @@ int exynos4210_cpufreq_init(struct exynos_dvfs_info *info)
 
 	return 0;
 
-err_mout_apll:
-	clk_put(mout_mpll);
-err_mout_mpll:
-	clk_put(moutcore);
-err_moutcore:
-	clk_put(cpu_clk);
-
+err:
 	iounmap(info->cmu_regs);
 	of_node_put(np);
 	pr_debug("%s: failed initialization\n", __func__);
-- 
2.1.3


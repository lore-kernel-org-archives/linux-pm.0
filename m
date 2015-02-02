From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 06/14] cpufreq: exynos4x12: use devm_clk_get
Date: Mon,  2 Feb 2015 16:58:09 -0400
Message-ID: <1422910697-5920-7-git-send-email-edubezval@gmail.com>
References: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1422910697-5920-1-git-send-email-edubezval@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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
 drivers/cpufreq/exynos4x12-cpufreq.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/cpufreq/exynos4x12-cpufreq.c b/drivers/cpufreq/exynos4x12-cpufreq.c
index 3da36baf..7e0dd2a 100644
--- a/drivers/cpufreq/exynos4x12-cpufreq.c
+++ b/drivers/cpufreq/exynos4x12-cpufreq.c
@@ -189,23 +189,23 @@ int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
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
 
 	if (info->type == EXYNOS_SOC_4212)
 		apll_freq_4x12 = apll_freq_4212;
@@ -225,13 +225,7 @@ int exynos4x12_cpufreq_init(struct exynos_dvfs_info *info)
 
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

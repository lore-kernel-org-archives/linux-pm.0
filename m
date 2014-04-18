From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/2] cpufreq: exynos: Use dev_err/info function instead of
 pr_err/info
Date: Fri, 18 Apr 2014 11:20:33 +0900
Message-ID: <1397787634-9334-2-git-send-email-cw00.choi@samsung.com>
References: <1397787634-9334-1-git-send-email-cw00.choi@samsung.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1397787634-9334-1-git-send-email-cw00.choi@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: kgene.kim@samsung.com, kyungmin.park@samsung.com, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch uses dev_err/info function to show accurate log message with device name
instead of pr_err/info function.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/cpufreq/exynos-cpufreq.c | 21 ++++++++++++---------
 drivers/cpufreq/exynos-cpufreq.h |  1 +
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index f99cfe2..8b4bb4a 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -49,6 +49,7 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
 	unsigned int arm_volt, safe_arm_volt = 0;
 	unsigned int mpll_freq_khz = exynos_info->mpll_freq_khz;
+	struct device *dev = exynos_info->dev;
 	unsigned int old_freq;
 	int index, old_index;
 	int ret = 0;
@@ -90,8 +91,8 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 		/* Firstly, voltage up to increase frequency */
 		ret = regulator_set_voltage(arm_regulator, arm_volt, arm_volt);
 		if (ret) {
-			pr_err("%s: failed to set cpu voltage to %d\n",
-				__func__, arm_volt);
+			dev_err(dev, "failed to set cpu voltage to %d\n",
+				arm_volt);
 			return ret;
 		}
 	}
@@ -100,8 +101,8 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 		ret = regulator_set_voltage(arm_regulator, safe_arm_volt,
 				      safe_arm_volt);
 		if (ret) {
-			pr_err("%s: failed to set cpu voltage to %d\n",
-				__func__, safe_arm_volt);
+			dev_err(dev, "failed to set cpu voltage to %d\n",
+				safe_arm_volt);
 			return ret;
 		}
 	}
@@ -115,8 +116,8 @@ static int exynos_cpufreq_scale(unsigned int target_freq)
 		ret = regulator_set_voltage(arm_regulator, arm_volt,
 				arm_volt);
 		if (ret) {
-			pr_err("%s: failed to set cpu voltage to %d\n",
-				__func__, arm_volt);
+			dev_err(dev, "failed to set cpu voltage to %d\n",
+				arm_volt);
 			goto out;
 		}
 	}
@@ -163,6 +164,8 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	if (!exynos_info)
 		return -ENOMEM;
 
+	exynos_info->dev = &pdev->dev;
+
 	if (soc_is_exynos4210())
 		ret = exynos4210_cpufreq_init(exynos_info);
 	else if (soc_is_exynos4212() || soc_is_exynos4412())
@@ -176,13 +179,13 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 		goto err_vdd_arm;
 
 	if (exynos_info->set_freq == NULL) {
-		pr_err("%s: No set_freq function (ERR)\n", __func__);
+		dev_err(&pdev->dev, "No set_freq function (ERR)\n");
 		goto err_vdd_arm;
 	}
 
 	arm_regulator = regulator_get(NULL, "vdd_arm");
 	if (IS_ERR(arm_regulator)) {
-		pr_err("%s: failed to get resource vdd_arm\n", __func__);
+		dev_err(&pdev->dev, "failed to get resource vdd_arm\n");
 		goto err_vdd_arm;
 	}
 
@@ -192,7 +195,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	if (!cpufreq_register_driver(&exynos_driver))
 		return 0;
 
-	pr_err("%s: failed to register cpufreq driver\n", __func__);
+	dev_err(&pdev->dev, "failed to register cpufreq driver\n");
 	regulator_put(arm_regulator);
 err_vdd_arm:
 	kfree(exynos_info);
diff --git a/drivers/cpufreq/exynos-cpufreq.h b/drivers/cpufreq/exynos-cpufreq.h
index 3ddade8..b72ff10 100644
--- a/drivers/cpufreq/exynos-cpufreq.h
+++ b/drivers/cpufreq/exynos-cpufreq.h
@@ -34,6 +34,7 @@ struct apll_freq {
 };
 
 struct exynos_dvfs_info {
+	struct device	*dev;
 	unsigned long	mpll_freq_khz;
 	unsigned int	pll_safe_idx;
 	struct clk	*cpu_clk;
-- 
1.8.0


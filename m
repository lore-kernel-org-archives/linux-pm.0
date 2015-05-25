From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] cpufreq:exynos-cpufreq - Fix for memory leak in case SOC name does not match.
Date: Mon, 25 May 2015 07:39:40 +0530
Message-ID: <1432519780-2910-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>
List-Id: linux-pm@vger.kernel.org

During probe free the memory allocated to "exynos_info" in case of
unknown SOC type.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/cpufreq/exynos-cpufreq.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 82d2fbb..8682378 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -182,7 +182,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 		ret = exynos5250_cpufreq_init(exynos_info);
 	} else {
 		pr_err("%s: Unknown SoC type\n", __func__);
-		return -ENODEV;
+		ret = -ENODEV;
 	}
 
 	if (ret)
@@ -190,12 +190,14 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 
 	if (exynos_info->set_freq == NULL) {
 		dev_err(&pdev->dev, "No set_freq function (ERR)\n");
+		ret = -EINVAL;
 		goto err_vdd_arm;
 	}
 
 	arm_regulator = regulator_get(NULL, "vdd_arm");
 	if (IS_ERR(arm_regulator)) {
 		dev_err(&pdev->dev, "failed to get resource vdd_arm\n");
+		ret = -EINVAL;
 		goto err_vdd_arm;
 	}
 
@@ -227,7 +229,7 @@ err_cpufreq_reg:
 	regulator_put(arm_regulator);
 err_vdd_arm:
 	kfree(exynos_info);
-	return -EINVAL;
+	return ret;
 }
 
 static struct platform_driver exynos_cpufreq_platdrv = {
-- 
1.7.9.5

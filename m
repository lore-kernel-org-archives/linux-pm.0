From: Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] cpufreq:exynos-cpufreq - Fix for memory leak in case SOC name does not match.
Date: Sat, 23 May 2015 08:32:51 +0530
Message-ID: <1432350171-2414-1-git-send-email-shailendra.capricorn@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:33589 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756159AbbEWDDG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2015 23:03:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Shailendra Verma <shailendra.capricorn@gmail.com>

During probe free the memory allocated to "exynos_info" in case of
unknown SOC type.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/cpufreq/exynos-cpufreq.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index 82d2fbb..5b57a0f 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -182,20 +182,25 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 		ret = exynos5250_cpufreq_init(exynos_info);
 	} else {
 		pr_err("%s: Unknown SoC type\n", __func__);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err_vdd_arm;
 	}
 
-	if (ret)
+	if (ret) {
+		ret = -EINVAL;
 		goto err_vdd_arm;
+	}
 
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
 
@@ -203,8 +208,10 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 	locking_frequency = clk_get_rate(exynos_info->cpu_clk) / 1000;
 
 	ret = cpufreq_register_driver(&exynos_driver);
-	if (ret)
+	if (ret) {
+		ret = -EINVAL;
 		goto err_cpufreq_reg;
+	}
 
 	cpu0 = of_get_cpu_node(0, NULL);
 	if (!cpu0) {
@@ -227,7 +234,7 @@ err_cpufreq_reg:
 	regulator_put(arm_regulator);
 err_vdd_arm:
 	kfree(exynos_info);
-	return -EINVAL;
+	return ret;
 }
 
 static struct platform_driver exynos_cpufreq_platdrv = {
-- 
1.7.9.5


From: Kukjin Kim <kgene@kernel.org>
Subject: [PATCH] cpufreq: exynos: Fix for memory leak in case SoC name does not
 match
Date: Tue, 04 Aug 2015 16:45:16 +0900
Message-ID: <04f401d0ce89$81073900$8315ab00$@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34263 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbbHDHpT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 03:45:19 -0400
Content-language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, shailendra.capricorn@gmail.com

From: Shailendra Verma <shailendra.capricorn@gmail.com>

During probe free the memory allocated to "exynos_info" in case of
unknown SoC type.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Lukasz Majewski <l.majewski@samsung.com>
[k.kozlowski: Rebased the patch around if(of_machine_is_compatible)]
Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Kukjin Kim <kgene@kernel.org>
---
Hi Rafael and Viresh,

Since this is a fix to prevent memory leak, it would be better if
this could be sent to linus during -rc via cpufreq tree.

Thanks,
Kukjin

 drivers/cpufreq/exynos-cpufreq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
index ae5b2bd..fa3dd84 100644
--- a/drivers/cpufreq/exynos-cpufreq.c
+++ b/drivers/cpufreq/exynos-cpufreq.c
@@ -180,7 +180,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 		ret = exynos5250_cpufreq_init(exynos_info);
 	} else {
 		pr_err("%s: Unknown SoC type\n", __func__);
-		return -ENODEV;
+		ret = -ENODEV;
 	}
 
 	if (ret)
@@ -188,12 +188,14 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
 
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
 
@@ -225,7 +227,7 @@ err_cpufreq_reg:
 	regulator_put(arm_regulator);
 err_vdd_arm:
 	kfree(exynos_info);
-	return -EINVAL;
+	return ret;
 }
 
 static struct platform_driver exynos_cpufreq_platdrv = {
-- 
2.0.0


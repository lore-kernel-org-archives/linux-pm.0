From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/2] Thermal: exynos: Add clk_{un}prepare APIs
Date: Thu, 18 Apr 2013 17:07:58 +0530
Message-ID: <1366285079-10395-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:58017 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967170Ab3DRLuT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 07:50:19 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so1328036dal.12
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2013 04:50:18 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, eduardo.valentin@ti.com, sachin.kamat@linaro.org, kgene.kim@samsung.com, patches@linaro.org, Amit Daniel Kachhap <amit.daniel@samsung.com>

clk_{un}prepare APIs are required to migrate to common
clock framework. While at it convert to use devm_clk_get as
it removes some cleanup code.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/exynos_thermal.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index e34d842..9df96e5 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -937,12 +937,16 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	data->clk = clk_get(NULL, "tmu_apbif");
+	data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
 	if (IS_ERR(data->clk)) {
 		dev_err(&pdev->dev, "Failed to get clock\n");
 		return  PTR_ERR(data->clk);
 	}
 
+	ret = clk_prepare(data->clk);
+	if (ret)
+		return ret;
+
 	if (pdata->type == SOC_ARCH_EXYNOS ||
 				pdata->type == SOC_ARCH_EXYNOS4210)
 		data->soc = pdata->type;
@@ -994,7 +998,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	return 0;
 err_clk:
 	platform_set_drvdata(pdev, NULL);
-	clk_put(data->clk);
+	clk_unprepare(data->clk);
 	return ret;
 }
 
@@ -1006,7 +1010,7 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 	exynos_unregister_thermal();
 
-	clk_put(data->clk);
+	clk_unprepare(data->clk);
 
 	platform_set_drvdata(pdev, NULL);
 
-- 
1.7.9.5


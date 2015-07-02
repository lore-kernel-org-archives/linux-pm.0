From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 2/2] thermal: exynos: Remove unused code related to
 platform_data on probe()
Date: Thu, 02 Jul 2015 15:40:01 +0900
Message-ID: <1435819201-30729-3-git-send-email-cw00.choi@samsung.com>
References: <1435819201-30729-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1435819201-30729-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: l.majewski@samsung.com, eduardo.valentin@ti.com, rui.zhang@intel.com
Cc: kgene@kernel.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

This patch removes the unused code related to struct exynos_tmu_platform_data
because exynos_tmu_probe() don't handle the struct exynos_tmu_platform_data *pdata.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 531f4b179871..10e46a1a4bb3 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1296,7 +1296,6 @@ static struct thermal_zone_of_device_ops exynos_sensor_ops = {
 
 static int exynos_tmu_probe(struct platform_device *pdev)
 {
-	struct exynos_tmu_platform_data *pdata;
 	struct exynos_tmu_data *data;
 	int ret;
 
@@ -1318,8 +1317,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_sensor;
 
-	pdata = data->pdata;
-
 	INIT_WORK(&data->irq_work, exynos_tmu_work);
 
 	data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
-- 
1.8.5.5

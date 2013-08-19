From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] thermal: exynos: Clean up non-DT remnants
Date: Mon, 19 Aug 2013 11:58:43 +0530
Message-ID: <1376893723-22138-3-git-send-email-sachin.kamat@linaro.org>
References: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:38400 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab3HSGqE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Aug 2013 02:46:04 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so4591156pbc.39
        for <linux-pm@vger.kernel.org>; Sun, 18 Aug 2013 23:46:04 -0700 (PDT)
In-Reply-To: <1376893723-22138-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: jonghwa3.lee@samsung.com, eduardo.valentin@ti.com, rui.zhang@intel.com, amit.daniel@samsung.com, sachin.kamat@linaro.org, patches@linaro.org

Commit 1cd1ecb6 ("thermal: exynos: Remove non DT based support")
cleaned up some non-DT code. However, there were few more things
needed for complete cleanup to make this driver DT only.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/thermal/samsung/Kconfig      |    2 +-
 drivers/thermal/samsung/exynos_tmu.c |   30 ++++++++++++------------------
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/samsung/Kconfig b/drivers/thermal/samsung/Kconfig
index 92492e4..f760389 100644
--- a/drivers/thermal/samsung/Kconfig
+++ b/drivers/thermal/samsung/Kconfig
@@ -1,6 +1,6 @@
 config EXYNOS_THERMAL
 	tristate "Exynos thermal management unit driver"
-	depends on ARCH_HAS_BANDGAP
+	depends on ARCH_HAS_BANDGAP && OF
 	help
 	  If you say yes here you get support for the TMU (Thermal Management
 	  Unit) driver for SAMSUNG EXYNOS series of SoCs. This driver initialises
diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a033dbb..b43afda 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -481,7 +481,6 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id exynos_tmu_match[] = {
 	{
 		.compatible = "samsung,exynos4210-tmu",
@@ -502,27 +501,22 @@ static const struct of_device_id exynos_tmu_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, exynos_tmu_match);
-#endif
 
 static inline struct  exynos_tmu_platform_data *exynos_get_driver_data(
 			struct platform_device *pdev, int id)
 {
-#ifdef CONFIG_OF
 	struct  exynos_tmu_init_data *data_table;
 	struct exynos_tmu_platform_data *tmu_data;
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_node(exynos_tmu_match, pdev->dev.of_node);
-		if (!match)
-			return NULL;
-		data_table = (struct exynos_tmu_init_data *) match->data;
-		if (!data_table || id >= data_table->tmu_count)
-			return NULL;
-		tmu_data = data_table->tmu_data;
-		return (struct exynos_tmu_platform_data *) (tmu_data + id);
-	}
-#endif
-	return NULL;
+	const struct of_device_id *match;
+
+	match = of_match_node(exynos_tmu_match, pdev->dev.of_node);
+	if (!match)
+		return NULL;
+	data_table = (struct exynos_tmu_init_data *) match->data;
+	if (!data_table || id >= data_table->tmu_count)
+		return NULL;
+	tmu_data = data_table->tmu_data;
+	return (struct exynos_tmu_platform_data *) (tmu_data + id);
 }
 
 static int exynos_map_dt_data(struct platform_device *pdev)
@@ -532,7 +526,7 @@ static int exynos_map_dt_data(struct platform_device *pdev)
 	struct resource res;
 	int ret;
 
-	if (!data)
+	if (!data || !pdev->dev.of_node)
 		return -ENODEV;
 
 	/*
@@ -754,7 +748,7 @@ static struct platform_driver exynos_tmu_driver = {
 		.name   = "exynos-tmu",
 		.owner  = THIS_MODULE,
 		.pm     = EXYNOS_TMU_PM,
-		.of_match_table = of_match_ptr(exynos_tmu_match),
+		.of_match_table = exynos_tmu_match,
 	},
 	.probe = exynos_tmu_probe,
 	.remove	= exynos_tmu_remove,
-- 
1.7.9.5


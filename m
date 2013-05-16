From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 20/33] drivers/thermal: don't check resource with devm_ioremap_resource
Date: Thu, 16 May 2013 13:15:48 +0200
Message-ID: <1368702961-4325-21-git-send-email-wsa@the-dreams.de>
References: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368702961-4325-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

devm_ioremap_resource does sanity checks on the given resource. No need to
duplicate this in the driver.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/thermal/armada_thermal.c |   10 ----------
 drivers/thermal/dove_thermal.c   |    4 ----
 drivers/thermal/exynos_thermal.c |    5 -----
 3 files changed, 19 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index 5b4d75f..54ffd64 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -169,21 +169,11 @@ static int armada_thermal_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get platform resource\n");
-		return -ENODEV;
-	}
-
 	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->sensor))
 		return PTR_ERR(priv->sensor);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get platform resource\n");
-		return -ENODEV;
-	}
-
 	priv->control = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->control))
 		return PTR_ERR(priv->control);
diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 4b15a5f..a088d13 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -149,10 +149,6 @@ static int dove_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->sensor);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res) {
-		dev_err(&pdev->dev, "Failed to get platform resource\n");
-		return -ENODEV;
-	}
 	priv->control = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->control))
 		return PTR_ERR(priv->control);
diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
index d20ce9e..788b1dd 100644
--- a/drivers/thermal/exynos_thermal.c
+++ b/drivers/thermal/exynos_thermal.c
@@ -925,11 +925,6 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	INIT_WORK(&data->irq_work, exynos_tmu_work);
 
 	data->mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!data->mem) {
-		dev_err(&pdev->dev, "Failed to get platform resource\n");
-		return -ENOENT;
-	}
-
 	data->base = devm_ioremap_resource(&pdev->dev, data->mem);
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
-- 
1.7.10.4

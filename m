From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 21/34] thermal: rcar_thermal: remove explicitly used devm_kfree/iounap()
Date: Sun,  2 Dec 2012 22:44:55 +0800
Message-ID: <1354459508-3707-21-git-send-email-rui.zhang@intel.com>
References: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29043 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752975Ab2LBOpm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 2 Dec 2012 09:45:42 -0500
In-Reply-To: <1354459508-3707-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

devm_kfree and devm_iounmap should not have to be explicitly used

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/rcar_thermal.c |   18 ++----------------
 1 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 762f637..81dce23 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -185,7 +185,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	struct thermal_zone_device *zone;
 	struct rcar_thermal_priv *priv;
 	struct resource *res;
-	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
@@ -206,16 +205,14 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 					  res->start, resource_size(res));
 	if (!priv->base) {
 		dev_err(&pdev->dev, "Unable to ioremap thermal register\n");
-		ret = -ENOMEM;
-		goto error_free_priv;
+		return -ENOMEM;
 	}
 
 	zone = thermal_zone_device_register("rcar_thermal", 0, 0, priv,
 				    &rcar_thermal_zone_ops, NULL, 0, 0);
 	if (IS_ERR(zone)) {
 		dev_err(&pdev->dev, "thermal zone device is NULL\n");
-		ret = PTR_ERR(zone);
-		goto error_iounmap;
+		return PTR_ERR(zone);
 	}
 
 	platform_set_drvdata(pdev, zone);
@@ -223,26 +220,15 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "proved\n");
 
 	return 0;
-
-error_iounmap:
-	devm_iounmap(&pdev->dev, priv->base);
-error_free_priv:
-	devm_kfree(&pdev->dev, priv);
-
-	return ret;
 }
 
 static int rcar_thermal_remove(struct platform_device *pdev)
 {
 	struct thermal_zone_device *zone = platform_get_drvdata(pdev);
-	struct rcar_thermal_priv *priv = zone->devdata;
 
 	thermal_zone_device_unregister(zone);
 	platform_set_drvdata(pdev, NULL);
 
-	devm_iounmap(&pdev->dev, priv->base);
-	devm_kfree(&pdev->dev, priv);
-
 	return 0;
 }
 
-- 
1.7.7.6


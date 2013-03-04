From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] Thermal: dove: Convert to devm_ioremap_resource()
Date: Mon,  4 Mar 2013 12:15:32 +0530
Message-ID: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:64218 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab3CDG4C (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 01:56:02 -0500
Received: by mail-da0-f50.google.com with SMTP id h15so2363239dan.23
        for <linux-pm@vger.kernel.org>; Sun, 03 Mar 2013 22:56:01 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, thierry.reding@avionic-design.de, sachin.kamat@linaro.org, Andrew Lunn <andrew@lunn.ch>

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 drivers/thermal/dove_thermal.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/dove_thermal.c b/drivers/thermal/dove_thermal.c
index 7b0bfa0..3078c40 100644
--- a/drivers/thermal/dove_thermal.c
+++ b/drivers/thermal/dove_thermal.c
@@ -143,22 +143,18 @@ static int dove_thermal_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
-	if (!priv->sensor) {
-		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
-		return -EADDRNOTAVAIL;
-	}
+	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->sensor))
+		return PTR_ERR(priv->sensor);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	if (!res) {
 		dev_err(&pdev->dev, "Failed to get platform resource\n");
 		return -ENODEV;
 	}
-	priv->control = devm_request_and_ioremap(&pdev->dev, res);
-	if (!priv->control) {
-		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
-		return -EADDRNOTAVAIL;
-	}
+	priv->control = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv->control))
+		return PTR_ERR(priv->control);
 
 	ret = dove_init_sensor(priv);
 	if (ret) {
-- 
1.7.4.1


From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] Thermal: kirkwood: Convert to devm_ioremap_resource()
Date: Mon,  4 Mar 2013 12:15:34 +0530
Message-ID: <1362379534-30662-3-git-send-email-sachin.kamat@linaro.org>
References: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:49979 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805Ab3CDG4I (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 01:56:08 -0500
Received: by mail-da0-f54.google.com with SMTP id p1so2396254dad.13
        for <linux-pm@vger.kernel.org>; Sun, 03 Mar 2013 22:56:07 -0800 (PST)
In-Reply-To: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, thierry.reding@avionic-design.de, sachin.kamat@linaro.org, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/thermal/kirkwood_thermal.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/kirkwood_thermal.c b/drivers/thermal/kirkwood_thermal.c
index 65cb4f0..e5500ed 100644
--- a/drivers/thermal/kirkwood_thermal.c
+++ b/drivers/thermal/kirkwood_thermal.c
@@ -85,11 +85,9 @@ static int kirkwood_thermal_probe(struct platform_device *pdev)
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
 
 	thermal = thermal_zone_device_register("kirkwood_thermal", 0, 0,
 					       priv, &ops, NULL, 0, 0);
-- 
1.7.4.1


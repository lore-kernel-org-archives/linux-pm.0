From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] Thermal: rcar: Convert to devm_ioremap_resource()
Date: Mon,  4 Mar 2013 12:15:33 +0530
Message-ID: <1362379534-30662-2-git-send-email-sachin.kamat@linaro.org>
References: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:50097 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727Ab3CDG4F (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 01:56:05 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so2417206dak.16
        for <linux-pm@vger.kernel.org>; Sun, 03 Mar 2013 22:56:05 -0800 (PST)
In-Reply-To: <1362379534-30662-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, thierry.reding@avionic-design.de, sachin.kamat@linaro.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/thermal/rcar_thermal.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 28f0919..b28990a 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -399,11 +399,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		/*
 		 * rcar_has_irq_support() will be enabled
 		 */
-		common->base = devm_request_and_ioremap(dev, res);
-		if (!common->base) {
-			dev_err(dev, "Unable to ioremap thermal register\n");
-			return -ENOMEM;
-		}
+		common->base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(common->base))
+			return PTR_ERR(common->base);
 
 		/* enable temperature comparation */
 		rcar_thermal_common_write(common, ENR, 0x00030303);
@@ -422,11 +420,9 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			return -ENOMEM;
 		}
 
-		priv->base = devm_request_and_ioremap(dev, res);
-		if (!priv->base) {
-			dev_err(dev, "Unable to ioremap priv register\n");
-			return -ENOMEM;
-		}
+		priv->base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(priv->base))
+			return PTR_ERR(priv->base);
 
 		priv->common = common;
 		priv->id = i;
-- 
1.7.4.1


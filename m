From: Devendra Naga <devendra.aaru@gmail.com>
Subject: [PATCH 1/2] thermal: rcar_thermal: propagate return value of thermal_zone_device_register
Date: Mon,  4 Mar 2013 11:52:47 -0500
Message-ID: <1362415968-2210-1-git-send-email-devendra.aaru@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:33957 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756359Ab3CDQw7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Mar 2013 11:52:59 -0500
Received: by mail-pb0-f50.google.com with SMTP id up1so3184442pbc.9
        for <linux-pm@vger.kernel.org>; Mon, 04 Mar 2013 08:52:58 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc: Devendra Naga <devendra.aaru@gmail.com>

thermal_zone_device_register returns a value contained in the pointer itself
use PTR_ERR to obtain the address and return it at the end.

Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
---
 drivers/thermal/rcar_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 28f0919..f1726c9 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -363,6 +363,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	struct resource *res, *irq;
 	int mres = 0;
 	int i;
+	int ret = -ENODEV;
 	int idle = IDLE_INTERVAL;
 
 	common = devm_kzalloc(dev, sizeof(*common), GFP_KERNEL);
@@ -441,6 +442,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 						idle);
 		if (IS_ERR(priv->zone)) {
 			dev_err(dev, "can't register thermal zone\n");
+			ret = PTR_ERR(priv->zone);
 			goto error_unregister;
 		}
 
@@ -460,7 +462,7 @@ error_unregister:
 	rcar_thermal_for_each_priv(priv, common)
 		thermal_zone_device_unregister(priv->zone);
 
-	return -ENODEV;
+	return ret;
 }
 
 static int rcar_thermal_remove(struct platform_device *pdev)
-- 
1.8.1.2


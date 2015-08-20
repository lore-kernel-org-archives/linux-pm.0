From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] power: wm831x_power: Convert to devm_kzalloc()
Date: Thu, 20 Aug 2015 15:12:43 -0700
Message-ID: <1440108763-14776-1-git-send-email-broonie@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:54355 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbbHTWRw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Aug 2015 18:17:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, Mark Brown <broonie@kernel.org>

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/power/wm831x_power.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/power/wm831x_power.c b/drivers/power/wm831x_power.c
index db11ae6..c826c83 100644
--- a/drivers/power/wm831x_power.c
+++ b/drivers/power/wm831x_power.c
@@ -499,7 +499,8 @@ static int wm831x_power_probe(struct platform_device *pdev)
 	struct wm831x_power *power;
 	int ret, irq, i;
 
-	power = kzalloc(sizeof(struct wm831x_power), GFP_KERNEL);
+	power = devm_kzalloc(&pdev->dev, sizeof(struct wm831x_power),
+			     GFP_KERNEL);
 	if (power == NULL)
 		return -ENOMEM;
 
@@ -536,7 +537,7 @@ static int wm831x_power_probe(struct platform_device *pdev)
 					    NULL);
 	if (IS_ERR(power->wall)) {
 		ret = PTR_ERR(power->wall);
-		goto err_kmalloc;
+		goto err;
 	}
 
 	power->usb_desc.name = power->usb_name,
@@ -626,8 +627,7 @@ err_usb:
 	power_supply_unregister(power->usb);
 err_wall:
 	power_supply_unregister(power->wall);
-err_kmalloc:
-	kfree(power);
+err:
 	return ret;
 }
 
@@ -654,7 +654,6 @@ static int wm831x_power_remove(struct platform_device *pdev)
 		power_supply_unregister(wm831x_power->battery);
 	power_supply_unregister(wm831x_power->wall);
 	power_supply_unregister(wm831x_power->usb);
-	kfree(wm831x_power);
 	return 0;
 }
 
-- 
2.5.0


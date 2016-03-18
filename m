From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] power/max8925: freeing wrong variable
Date: Fri, 18 Mar 2016 08:40:16 +0300
Message-ID: <20160318054016.GD2111@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19379 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbcCRFlD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 01:41:03 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

We were freeing "info->battery" instead of "info->usb", which leads to
an OOps and a resource leak.

The labels were wonky, "out_battery" did release the battery but out_usb
did not release usb.  I was introducing a call to free usb so it sort
conflicted with existing misleading name.  I renamed them.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/power/max8925_power.c b/drivers/power/max8925_power.c
index 57eb5c2..3b94620 100644
--- a/drivers/power/max8925_power.c
+++ b/drivers/power/max8925_power.c
@@ -540,14 +540,14 @@ static int max8925_power_probe(struct platform_device *pdev)
 	info->usb = power_supply_register(&pdev->dev, &usb_desc, &psy_cfg);
 	if (IS_ERR(info->usb)) {
 		ret = PTR_ERR(info->usb);
-		goto out_usb;
+		goto out_unregister_ac;
 	}
 	info->usb->dev.parent = &pdev->dev;
 
 	info->battery = power_supply_register(&pdev->dev, &battery_desc, NULL);
 	if (IS_ERR(info->battery)) {
 		ret = PTR_ERR(info->battery);
-		goto out_battery;
+		goto out_unregister_usb;
 	}
 	info->battery->dev.parent = &pdev->dev;
 
@@ -560,9 +560,9 @@ static int max8925_power_probe(struct platform_device *pdev)
 
 	max8925_init_charger(chip, info);
 	return 0;
-out_battery:
-	power_supply_unregister(info->battery);
-out_usb:
+out_unregister_usb:
+	power_supply_unregister(info->usb);
+out_unregister_ac:
 	power_supply_unregister(info->ac);
 out:
 	return ret;

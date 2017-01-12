From: "Gustavo A. R. Silva" <silvagustavosilva@gmail.com>
Subject: [PATCH] drivers: power: supply: Compress return logic into one line.
Date: Wed, 11 Jan 2017 20:45:57 -0600
Message-ID: <20170112024557.GA23047@embeddedgus>
Reply-To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36422 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750739AbdALCqA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Jan 2017 21:46:00 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Simplify return logic to avoid unnecessary variable assignments.
These issues were detected using Coccinelle and the following semantic patch:

@@
local idexpression ret;
expression e;
@@

-ret =
+return
     e;
-return ret;

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/power/supply/pcf50633-charger.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/power/supply/pcf50633-charger.c b/drivers/power/supply/pcf50633-charger.c
index d05597b..b3c1873 100644
--- a/drivers/power/supply/pcf50633-charger.c
+++ b/drivers/power/supply/pcf50633-charger.c
@@ -393,7 +393,6 @@ static int pcf50633_mbc_probe(struct platform_device *pdev)
 {
 	struct power_supply_config psy_cfg = {};
 	struct pcf50633_mbc *mbc;
-	int ret;
 	int i;
 	u8 mbcs1;
 
@@ -419,8 +418,7 @@ static int pcf50633_mbc_probe(struct platform_device *pdev)
 					     &psy_cfg);
 	if (IS_ERR(mbc->adapter)) {
 		dev_err(mbc->pcf->dev, "failed to register adapter\n");
-		ret = PTR_ERR(mbc->adapter);
-		return ret;
+		return PTR_ERR(mbc->adapter);
 	}
 
 	mbc->usb = power_supply_register(&pdev->dev, &pcf50633_mbc_usb_desc,
@@ -428,8 +426,7 @@ static int pcf50633_mbc_probe(struct platform_device *pdev)
 	if (IS_ERR(mbc->usb)) {
 		dev_err(mbc->pcf->dev, "failed to register usb\n");
 		power_supply_unregister(mbc->adapter);
-		ret = PTR_ERR(mbc->usb);
-		return ret;
+		return PTR_ERR(mbc->usb);
 	}
 
 	mbc->ac = power_supply_register(&pdev->dev, &pcf50633_mbc_ac_desc,
@@ -438,12 +435,10 @@ static int pcf50633_mbc_probe(struct platform_device *pdev)
 		dev_err(mbc->pcf->dev, "failed to register ac\n");
 		power_supply_unregister(mbc->adapter);
 		power_supply_unregister(mbc->usb);
-		ret = PTR_ERR(mbc->ac);
-		return ret;
+		return PTR_ERR(mbc->ac);
 	}
 
-	ret = sysfs_create_group(&pdev->dev.kobj, &mbc_attr_group);
-	if (ret)
+	if (sysfs_create_group(&pdev->dev.kobj, &mbc_attr_group))
 		dev_err(mbc->pcf->dev, "failed to create sysfs entries\n");
 
 	mbcs1 = pcf50633_reg_read(mbc->pcf, PCF50633_REG_MBCS1);
-- 
2.5.0


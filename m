From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 1/3] drivers:power:twl4030-charger: don't check if battery is present
Date: Fri, 14 Apr 2017 20:25:55 +0200
Message-ID: <442f66835ab6e1359540a3a4c9bb9718d31b40bb.1492194356.git.hns@goldelico.com>
References: <cover.1492194356.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:15511 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbdDNS0J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 14:26:09 -0400
In-Reply-To: <cover.1492194356.git.hns@goldelico.com>
In-Reply-To: <cover.1492194356.git.hns@goldelico.com>
References: <cover.1492194356.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

We can't assume that the battery is or stays present after probing
on devices with replaceable battery.

On some devices (e.g. GTA04 or OpenPanodra) it can be removed
and even be hot swapped by the user while device continues to operate
through external AC or USB power (as long as system power consumption
remains below ca. 500mA as provided by USB).

So it makes no sense to check for this situation during probe and make
the charger driver (and its status reports) completely non-operational if
the battery can be inserted later.

Tested on: GTA04 and OpenPandora.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/twl4030_charger.c | 36 ----------------------------------
 1 file changed, 36 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 7bcff1c1..34e389d 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -206,35 +206,6 @@ static int twl4030bci_read_adc_val(u8 reg)
 }
 
 /*
- * Check if Battery Pack was present
- */
-static int twl4030_is_battery_present(struct twl4030_bci *bci)
-{
-	int ret;
-	u8 val = 0;
-
-	/* Battery presence in Main charge? */
-	ret = twl_i2c_read_u8(TWL_MODULE_MAIN_CHARGE, &val, TWL4030_BCIMFSTS3);
-	if (ret)
-		return ret;
-	if (val & TWL4030_BATSTSMCHG)
-		return 0;
-
-	/*
-	 * OK, It could be that bootloader did not enable main charger,
-	 * pre-charge is h/w auto. So, Battery presence in Pre-charge?
-	 */
-	ret = twl_i2c_read_u8(TWL4030_MODULE_PRECHARGE, &val,
-			      TWL4030_BCIMFSTS1);
-	if (ret)
-		return ret;
-	if (val & TWL4030_BATSTSPCHG)
-		return 0;
-
-	return -ENODEV;
-}
-
-/*
  * TI provided formulas:
  * CGAIN == 0: ICHG = (BCIICHG * 1.7) / (2^10 - 1) - 0.85
  * CGAIN == 1: ICHG = (BCIICHG * 3.4) / (2^10 - 1) - 1.7
@@ -1011,13 +982,6 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 	bci->irq_chg = platform_get_irq(pdev, 0);
 	bci->irq_bci = platform_get_irq(pdev, 1);
 
-	/* Only proceed further *IF* battery is physically present */
-	ret = twl4030_is_battery_present(bci);
-	if  (ret) {
-		dev_crit(&pdev->dev, "Battery was not detected:%d\n", ret);
-		return ret;
-	}
-
 	if (bci->dev->of_node) {
 		struct device_node *phynode;
 
-- 
2.7.3

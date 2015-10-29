From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 2/2] drivers:power:twl4030-charger: don't check if battery is present
Date: Thu, 29 Oct 2015 18:01:28 +0100
Message-ID: <72eab67d8ae1e25803a78a4636c8da78b7a0d32f.1446138086.git.hns@goldelico.com>
References: <cover.1446138086.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:15039 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757048AbbJ2RBi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 Oct 2015 13:01:38 -0400
In-Reply-To: <cover.1446138086.git.hns@goldelico.com>
In-Reply-To: <cover.1446138086.git.hns@goldelico.com>
References: <cover.1446138086.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Gra=C5=BEvydas=20Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, gta04-owner@goldelico.com, "H. Nikolaus Schaller" <hns@goldelico.com>

We can't assume that the battery is present after probing (it can
usually be removed while device is operated through external AC
or USB power). So it makes no sense to check for it during probe.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/twl4030_charger.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 859991f..e232453 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -1008,13 +1008,6 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 	bci->irq_chg = platform_get_irq(pdev, 0);
 	bci->irq_bci = platform_get_irq(pdev, 1);
 
-	/* Only proceed further *IF* battery is physically present */
-	ret = twl4030_is_battery_present(bci);
-	if  (ret) {
-		dev_crit(&pdev->dev, "Battery was not detected:%d\n", ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, bci);
 
 	bci->ac = devm_power_supply_register(&pdev->dev, &twl4030_bci_ac_desc,
-- 
2.5.1


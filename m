From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 3/3] drivers:power:twl4030-charger: don't check if battery is present
Date: Mon,  2 Nov 2015 12:27:36 +0100
Message-ID: <79898642236850cd9d69d908a66ddcd778548eaf.1446463654.git.hns@goldelico.com>
References: <cover.1446463652.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446463652.git.hns@goldelico.com>
In-Reply-To: <cover.1446463652.git.hns@goldelico.com>
References: <cover.1446463652.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Gra=C5=BEvydas=20Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: linux-pm@vger.kernel.org, gta04-owner@goldelico.com, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-pm@vger.kernel.org

We can't assume that the battery is present after probing (it can
sometimes be removed/hot swapped by the user while device
(e.g. GTA04 or OpenPanodra) is operated through external AC
or USB power).

So it makes no sense to check for this situation (only) during probe.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/twl4030_charger.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 05d693d..6fbdf24 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -1006,13 +1006,6 @@ static int twl4030_bci_probe(struct platform_device *pdev)
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

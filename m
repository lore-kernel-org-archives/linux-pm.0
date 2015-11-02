From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 2/3] drivers:power:twl4030-charger: don't return after allocating irq
Date: Mon,  2 Nov 2015 12:27:35 +0100
Message-ID: <650004ea1e42a1ef7b39a609a1b5c45f9b5926d6.1446463653.git.hns@goldelico.com>
References: <cover.1446463652.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:37215 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbbKBL1m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Nov 2015 06:27:42 -0500
In-Reply-To: <cover.1446463652.git.hns@goldelico.com>
In-Reply-To: <cover.1446463652.git.hns@goldelico.com>
References: <cover.1446463652.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Gra=C5=BEvydas=20Ignotas?= <notasas@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Andreas Kemnade <andreas@kemnade.info>
Cc: linux-pm@vger.kernel.org, gta04-owner@goldelico.com, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

It appears that simply returning with error status (especially
-EPROBE_DEFER) is very dangerous *after* allocating devm managed
interrupts.

See discussion of potential issues: https://lkml.org/lkml/2013/2/22/65

The result is that the boot process hangs if both, phy-twl4030-usb and this
twl4030_charger driver are compiled as modules. This has been observed
on gta04 and openpandora boards.

So we move the search and check that the twl4030-phy transceiver link is
available before we request to set up the interrupts.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/twl4030_charger.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/power/twl4030_charger.c b/drivers/power/twl4030_charger.c
index 00697e9..05d693d 100644
--- a/drivers/power/twl4030_charger.c
+++ b/drivers/power/twl4030_charger.c
@@ -1031,23 +1031,6 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_request_threaded_irq(&pdev->dev, bci->irq_chg, NULL,
-			twl4030_charger_interrupt, IRQF_ONESHOT, pdev->name,
-			bci);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not request irq %d, status %d\n",
-			bci->irq_chg, ret);
-		return ret;
-	}
-
-	ret = devm_request_threaded_irq(&pdev->dev, bci->irq_bci, NULL,
-			twl4030_bci_interrupt, IRQF_ONESHOT, pdev->name, bci);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not request irq %d, status %d\n",
-			bci->irq_bci, ret);
-		return ret;
-	}
-
 	INIT_WORK(&bci->work, twl4030_bci_usb_work);
 	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
 
@@ -1066,6 +1049,23 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = devm_request_threaded_irq(&pdev->dev, bci->irq_chg, NULL,
+			twl4030_charger_interrupt, IRQF_ONESHOT, pdev->name,
+			bci);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not request irq %d, status %d\n",
+			bci->irq_chg, ret);
+		return ret;
+	}
+
+	ret = devm_request_threaded_irq(&pdev->dev, bci->irq_bci, NULL,
+			twl4030_bci_interrupt, IRQF_ONESHOT, pdev->name, bci);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "could not request irq %d, status %d\n",
+			bci->irq_bci, ret);
+		return ret;
+	}
+
 	/* Enable interrupts now. */
 	reg = ~(u32)(TWL4030_ICHGLOW | TWL4030_ICHGEOC | TWL4030_TBATOR2 |
 		TWL4030_TBATOR1 | TWL4030_BATSTS);
-- 
2.5.1


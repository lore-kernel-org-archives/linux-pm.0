From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 1/5] power: supply: tps65217: Move IRQ related operation into single function
Date: Tue, 15 Nov 2016 22:18:51 +0900
Message-ID: <20161115131855.4175-2-woogyom.kim@gmail.com>
References: <20161115131855.4175-1-woogyom.kim@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33537 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754566AbcKONTT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2016 08:19:19 -0500
In-Reply-To: <20161115131855.4175-1-woogyom.kim@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>

TPS65217 charger driver handles the charger interrupt through the IRQ or
polling. Both cases can be requested in single function.

Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 70 ++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 9fd019f..04f8322 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -195,12 +195,48 @@ static const struct power_supply_desc tps65217_charger_desc = {
 	.num_properties		= ARRAY_SIZE(tps65217_ac_props),
 };
 
+static int tps65217_charger_request_interrupt(struct platform_device *pdev)
+{
+	struct tps65217_charger *charger = platform_get_drvdata(pdev);
+	int irq;
+	int ret;
+
+	irq = platform_get_irq_byname(pdev, "AC");
+	if (irq < 0)
+		irq = -ENXIO;
+
+	charger->irq = irq;
+
+	if (irq != -ENXIO) {
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						tps65217_charger_irq, 0,
+						"tps65217-charger", charger);
+		if (ret) {
+			dev_err(charger->dev,
+				"Unable to register irq %d err %d\n", irq, ret);
+			return ret;
+		}
+
+		/* Check current state */
+		tps65217_charger_irq(irq, charger);
+		return 0;
+	}
+
+	charger->poll_task = kthread_run(tps65217_charger_poll_task, charger,
+					 "ktps65217charger");
+	if (IS_ERR(charger->poll_task)) {
+		ret = PTR_ERR(charger->poll_task);
+		dev_err(charger->dev, "Unable to run kthread err %d\n", ret);
+	}
+
+	return 0;
+}
+
 static int tps65217_charger_probe(struct platform_device *pdev)
 {
 	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
 	struct tps65217_charger *charger;
 	struct power_supply_config cfg = {};
-	int irq;
 	int ret;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
@@ -224,43 +260,13 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(charger->ac);
 	}
 
-	irq = platform_get_irq_byname(pdev, "AC");
-	if (irq < 0)
-		irq = -ENXIO;
-	charger->irq = irq;
-
 	ret = tps65217_config_charger(charger);
 	if (ret < 0) {
 		dev_err(charger->dev, "charger config failed, err %d\n", ret);
 		return ret;
 	}
 
-	if (irq != -ENXIO) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-						tps65217_charger_irq,
-						0, "tps65217-charger",
-						charger);
-		if (ret) {
-			dev_err(charger->dev,
-				"Unable to register irq %d err %d\n", irq,
-				ret);
-			return ret;
-		}
-
-		/* Check current state */
-		tps65217_charger_irq(irq, charger);
-	} else {
-		charger->poll_task = kthread_run(tps65217_charger_poll_task,
-						charger, "ktps65217charger");
-		if (IS_ERR(charger->poll_task)) {
-			ret = PTR_ERR(charger->poll_task);
-			dev_err(charger->dev,
-				"Unable to run kthread err %d\n", ret);
-			return ret;
-		}
-	}
-
-	return 0;
+	return tps65217_charger_request_interrupt(pdev);
 }
 
 static int tps65217_charger_remove(struct platform_device *pdev)
-- 
2.9.3


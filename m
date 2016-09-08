From: Georges Savoundararadj <savoundg@gmail.com>
Subject: [PATCH 1/1] power: bq24257: Fix use of uninitialized pointer bq->charger
Date: Wed,  7 Sep 2016 18:38:15 -0700
Message-ID: <20160908013815.9904-1-savoundg@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35304 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbcIHBjJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Sep 2016 21:39:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id n24so1720299pfb.2
        for <linux-pm@vger.kernel.org>; Wed, 07 Sep 2016 18:39:08 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Georges Savoundararadj <savoundg@gmail.com>, Aurelien Chanot <chanot.a@gmail.com>, Andreas Dannenberg <dannenberg@ti.com>, Sebastian Reichel <sre@kernel.org>, David Woodhouse <dwmw2@infradead.org>

bq->charger is initialized in bq24257_power_supply_init.
Therefore, bq24257_power_supply_init should be called before the
registration of the IRQ handler bq24257_irq_handler_thread that calls
power_supply_changed(bq->charger).

Signed-off-by: Georges Savoundararadj <savoundg@gmail.com>
Cc: Aurelien Chanot <chanot.a@gmail.com>
Cc: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>
---
 drivers/power/bq24257_charger.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 1fea2c7..6fc31bd 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -1068,6 +1068,12 @@ static int bq24257_probe(struct i2c_client *client,
 		return ret;
 	}
 
+	ret = bq24257_power_supply_init(bq);
+	if (ret < 0) {
+		dev_err(dev, "Failed to register power supply\n");
+		return ret;
+	}
+
 	ret = devm_request_threaded_irq(dev, client->irq, NULL,
 					bq24257_irq_handler_thread,
 					IRQF_TRIGGER_FALLING |
@@ -1078,12 +1084,6 @@ static int bq24257_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	ret = bq24257_power_supply_init(bq);
-	if (ret < 0) {
-		dev_err(dev, "Failed to register power supply\n");
-		return ret;
-	}
-
 	ret = sysfs_create_group(&bq->charger->dev.kobj, &bq24257_attr_group);
 	if (ret < 0) {
 		dev_err(dev, "Can't create sysfs entries\n");
-- 
2.9.3


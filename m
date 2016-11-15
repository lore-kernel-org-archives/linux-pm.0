From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 5/5] power: supply: tps65217: Use generic name for power supply structures
Date: Tue, 15 Nov 2016 22:18:55 +0900
Message-ID: <20161115131855.4175-6-woogyom.kim@gmail.com>
References: <20161115131855.4175-1-woogyom.kim@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33572 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936175AbcKONT1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Nov 2016 08:19:27 -0500
In-Reply-To: <20161115131855.4175-1-woogyom.kim@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>

AC and USB charger are supported, so generic names are preferred.

  ac in tps65217_charger -> psy
  tps65217_ac_props -> tps65217_charger_props
  tps65217_ac_get_property -> tps65217_charger_get_property
  tps65217-ac -> tps65217-charger

Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 8b7ce61..4e3f5cb 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -42,7 +42,7 @@
 struct tps65217_charger {
 	struct tps65217 *tps;
 	struct device *dev;
-	struct power_supply *ac;
+	struct power_supply *psy;
 
 	int	online;
 	int	prev_online;
@@ -50,7 +50,7 @@ struct tps65217_charger {
 	struct task_struct	*poll_task;
 };
 
-static enum power_supply_property tps65217_ac_props[] = {
+static enum power_supply_property tps65217_charger_props[] = {
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
@@ -115,9 +115,9 @@ static int tps65217_enable_charging(struct tps65217_charger *charger)
 	return 0;
 }
 
-static int tps65217_ac_get_property(struct power_supply *psy,
-			enum power_supply_property psp,
-			union power_supply_propval *val)
+static int tps65217_charger_get_property(struct power_supply *psy,
+					 enum power_supply_property psp,
+					 union power_supply_propval *val)
 {
 	struct tps65217_charger *charger = power_supply_get_drvdata(psy);
 
@@ -157,7 +157,7 @@ static irqreturn_t tps65217_charger_irq(int irq, void *dev)
 	}
 
 	if (charger->prev_online != charger->online)
-		power_supply_changed(charger->ac);
+		power_supply_changed(charger->psy);
 
 	ret = tps65217_reg_read(charger->tps, TPS65217_REG_CHGCONFIG0, &val);
 	if (ret < 0) {
@@ -188,11 +188,11 @@ static int tps65217_charger_poll_task(void *data)
 }
 
 static const struct power_supply_desc tps65217_charger_desc = {
-	.name			= "tps65217-ac",
+	.name			= "tps65217-charger",
 	.type			= POWER_SUPPLY_TYPE_MAINS,
-	.get_property		= tps65217_ac_get_property,
-	.properties		= tps65217_ac_props,
-	.num_properties		= ARRAY_SIZE(tps65217_ac_props),
+	.get_property		= tps65217_charger_get_property,
+	.properties		= tps65217_charger_props,
+	.num_properties		= ARRAY_SIZE(tps65217_charger_props),
 };
 
 static int tps65217_charger_request_interrupt(struct platform_device *pdev)
@@ -260,12 +260,11 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	cfg.of_node = pdev->dev.of_node;
 	cfg.drv_data = charger;
 
-	charger->ac = devm_power_supply_register(&pdev->dev,
-						 &tps65217_charger_desc,
-						 &cfg);
-	if (IS_ERR(charger->ac)) {
+	charger->psy = devm_power_supply_register(&pdev->dev,
+						  &tps65217_charger_desc, &cfg);
+	if (IS_ERR(charger->psy)) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
-		return PTR_ERR(charger->ac);
+		return PTR_ERR(charger->psy);
 	}
 
 	ret = tps65217_config_charger(charger);
-- 
2.9.3


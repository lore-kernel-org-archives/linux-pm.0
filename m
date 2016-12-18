From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v3 4/7] power: supply: tps65217: Use generic name for power supply structure
Date: Sun, 18 Dec 2016 11:54:29 +0900
Message-ID: <20161218025432.20780-5-woogyom.kim@gmail.com>
References: <20161218025432.20780-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161218025432.20780-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-pm@vger.kernel.org

Replace 'ac' of tps65217_charger structure with 'psy'.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 424a6d32bb6c..5daf36192b8c 100644
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
@@ -157,7 +157,7 @@ static irqreturn_t tps65217_charger_irq(int irq, void *dev)
 	}
 
 	if (charger->prev_online != charger->online)
-		power_supply_changed(charger->ac);
+		power_supply_changed(charger->psy);
 
 	ret = tps65217_reg_read(charger->tps, TPS65217_REG_CHGCONFIG0, &val);
 	if (ret < 0) {
@@ -218,12 +218,12 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	cfg.of_node = pdev->dev.of_node;
 	cfg.drv_data = charger;
 
-	charger->ac = devm_power_supply_register(&pdev->dev,
-						 &tps65217_charger_desc,
-						 &cfg);
-	if (IS_ERR(charger->ac)) {
+	charger->psy = devm_power_supply_register(&pdev->dev,
+						  &tps65217_charger_desc,
+						  &cfg);
+	if (IS_ERR(charger->psy)) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
-		return PTR_ERR(charger->ac);
+		return PTR_ERR(charger->psy);
 	}
 
 	irq[0] = platform_get_irq_byname(pdev, "USB");
-- 
2.11.0

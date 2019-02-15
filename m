From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: [PATCH 1/2] power: supply: max14656: fix potential use-before-alloc
Date: Fri, 15 Feb 2019 16:43:02 -0500
Message-ID: <20190215214303.7274-1-TheSven73@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Kurz <akurz@blala.de>
List-Id: linux-pm@vger.kernel.org

Call order on probe():
- max14656_hw_init() enables interrupts on the chip
- devm_request_irq() starts processing interrupts, isr
  could be called immediately
-    isr: schedules delayed work (irq_work)
-    irq_work: calls power_supply_changed()
- devm_power_supply_register() registers the power supply

Depending on timing, it's possible that power_supply_changed()
is called on an unregistered power supply structure.

Fix by registering the power supply before requesting the irq.

Cc: Alexander Kurz <akurz@blala.de>
Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/power/supply/max14656_charger_detector.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/max14656_charger_detector.c b/drivers/power/supply/max14656_charger_detector.c
index b91b1d2999dc..d19307f791c6 100644
--- a/drivers/power/supply/max14656_charger_detector.c
+++ b/drivers/power/supply/max14656_charger_detector.c
@@ -280,6 +280,13 @@ static int max14656_probe(struct i2c_client *client,
 
 	INIT_DELAYED_WORK(&chip->irq_work, max14656_irq_worker);
 
+	chip->detect_psy = devm_power_supply_register(dev,
+		       &chip->psy_desc, &psy_cfg);
+	if (IS_ERR(chip->detect_psy)) {
+		dev_err(dev, "power_supply_register failed\n");
+		return -EINVAL;
+	}
+
 	ret = devm_request_irq(dev, chip->irq, max14656_irq,
 			       IRQF_TRIGGER_FALLING,
 			       MAX14656_NAME, chip);
@@ -289,13 +296,6 @@ static int max14656_probe(struct i2c_client *client,
 	}
 	enable_irq_wake(chip->irq);
 
-	chip->detect_psy = devm_power_supply_register(dev,
-		       &chip->psy_desc, &psy_cfg);
-	if (IS_ERR(chip->detect_psy)) {
-		dev_err(dev, "power_supply_register failed\n");
-		return -EINVAL;
-	}
-
 	schedule_delayed_work(&chip->irq_work, msecs_to_jiffies(2000));
 
 	return 0;
-- 
2.17.1

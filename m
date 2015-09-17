From: Vaishali Thakkar <vthakkar1994@gmail.com>
Subject: [PATCH] power: max17042_battery: Convert to using managed resources
Date: Thu, 17 Sep 2015 18:27:52 +0530
Message-ID: <20150917125752.GA26658@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use managed resource functions devm_request_threaded_irq and
devm_power_supply_register to simplify error handling.

Also, remove max17042_remove as it is now redundant.

Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
---
 drivers/power/max17042_battery.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/power/max17042_battery.c b/drivers/power/max17042_battery.c
index e892557..9c65f13 100644
--- a/drivers/power/max17042_battery.c
+++ b/drivers/power/max17042_battery.c
@@ -909,18 +909,21 @@ static int max17042_probe(struct i2c_client *client,
 		regmap_write(chip->regmap, MAX17042_LearnCFG, 0x0007);
 	}
 
-	chip->battery = power_supply_register(&client->dev, max17042_desc,
-						&psy_cfg);
+	chip->battery = devm_power_supply_register(&client->dev, max17042_desc,
+						   &psy_cfg);
 	if (IS_ERR(chip->battery)) {
 		dev_err(&client->dev, "failed: power supply register\n");
 		return PTR_ERR(chip->battery);
 	}
 
 	if (client->irq) {
-		ret = request_threaded_irq(client->irq, NULL,
-					max17042_thread_handler,
-					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					chip->battery->desc->name, chip);
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL,
+						max17042_thread_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						chip->battery->desc->name,
+						chip);
 		if (!ret) {
 			regmap_update_bits(chip->regmap, MAX17042_CONFIG,
 					CONFIG_ALRT_BIT_ENBL,
@@ -944,16 +947,6 @@ static int max17042_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int max17042_remove(struct i2c_client *client)
-{
-	struct max17042_chip *chip = i2c_get_clientdata(client);
-
-	if (client->irq)
-		free_irq(client->irq, chip);
-	power_supply_unregister(chip->battery);
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int max17042_suspend(struct device *dev)
 {
@@ -1014,7 +1007,6 @@ static struct i2c_driver max17042_i2c_driver = {
 		.pm	= &max17042_pm_ops,
 	},
 	.probe		= max17042_probe,
-	.remove		= max17042_remove,
 	.id_table	= max17042_id,
 };
 module_i2c_driver(max17042_i2c_driver);
-- 
1.9.1

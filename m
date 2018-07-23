From: Matheus Castello <matheus@castello.eng.br>
Subject: [PATCH 1/4] power: supply: max17040: Add IRQ handler for low SOC alert
Date: Mon, 23 Jul 2018 00:08:13 -0400
Message-ID: <20180723040816.19455-2-matheus@castello.eng.br>
References: <20180723040816.19455-1-matheus@castello.eng.br>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723040816.19455-1-matheus@castello.eng.br>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Matheus Castello <matheus@castello.eng.br>
List-Id: linux-pm@vger.kernel.org

According datasheet max17040 has a pin for alert host for low SOC.
This pin can be used as external interrupt, so we need to check for
interrupts assigned for device and handle it.

In hadler we are checking and storing fuel gauge registers values
and send an uevent to notificate user space, so user space can decide
save work or turn off since the alert demonstrate that the battery may
no have the power to keep the system turned on for much longer.

Signed-off-by: Matheus Castello <matheus@castello.eng.br>
---
 drivers/power/supply/max17040_battery.c | 51 +++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 33c40f79d23d..6e54e58814a9 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/power_supply.h>
 #include <linux/max17040_battery.h>
 #include <linux/slab.h>
@@ -179,6 +180,24 @@ static void max17040_work(struct work_struct *work)
 			   MAX17040_DELAY);
 }
 
+static irqreturn_t max17040_thread_handler(int id, void *dev)
+{
+	struct max17040_chip *chip = dev;
+	struct i2c_client *client = chip->client;
+
+	dev_warn(&client->dev, "IRQ: Alert battery low level");
+	/* read registers */
+	max17040_get_vcell(chip->client);
+	max17040_get_soc(chip->client);
+	max17040_get_online(chip->client);
+	max17040_get_status(chip->client);
+
+	/* send uevent */
+	power_supply_changed(chip->battery);
+
+	return IRQ_HANDLED;
+}
+
 static enum power_supply_property max17040_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
@@ -200,6 +219,8 @@ static int max17040_probe(struct i2c_client *client,
 	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	struct power_supply_config psy_cfg = {};
 	struct max17040_chip *chip;
+	int ret;
+	unsigned int flags;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE))
 		return -EIO;
@@ -221,6 +242,24 @@ static int max17040_probe(struct i2c_client *client,
 		return PTR_ERR(chip->battery);
 	}
 
+	/* check interrupt */
+	if (client->irq) {
+		dev_info(&client->dev, "IRQ: enabled\n");
+		flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;
+
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL,
+						max17040_thread_handler, flags,
+						chip->battery->desc->name,
+						chip);
+		if (ret) {
+			client->irq = 0;
+			if (ret != -EBUSY)
+				dev_warn(&client->dev,
+					"Failed to get IRQ err %d \n", ret);
+		}
+	}
+
 	max17040_reset(client);
 	max17040_get_version(client);
 
@@ -248,6 +287,12 @@ static int max17040_suspend(struct device *dev)
 	struct max17040_chip *chip = i2c_get_clientdata(client);
 
 	cancel_delayed_work(&chip->work);
+
+	if (chip->client->irq) {
+		disable_irq(chip->client->irq);
+		enable_irq_wake(chip->client->irq);
+	}
+
 	return 0;
 }
 
@@ -258,6 +303,12 @@ static int max17040_resume(struct device *dev)
 
 	queue_delayed_work(system_power_efficient_wq, &chip->work,
 			   MAX17040_DELAY);
+
+	if (chip->client->irq) {
+		disable_irq_wake(chip->client->irq);
+		enable_irq(chip->client->irq);
+	}
+
 	return 0;
 }
 
-- 
2.13.3

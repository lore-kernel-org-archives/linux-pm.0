From: Peter Rosin <peda@axentia.se>
Subject: [PATCH 2/3] power: supply: bq24735-charger: optionally poll the ac-detect gpio
Date: Mon, 12 Dec 2016 12:00:23 +0100
Message-ID: <1481540424-19293-3-git-send-email-peda@axentia.se>
References: <1481540424-19293-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481540424-19293-1-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

If the ac-detect gpio does not support interrupts, provide a fallback
to poll the gpio at a configurable interval.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../bindings/power/supply/ti,bq24735.txt           |  2 +
 drivers/power/supply/bq24735-charger.c             | 50 +++++++++++++++++++---
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
index 3bf55757ceec..59c4dde589cf 100644
--- a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
+++ b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
@@ -25,6 +25,8 @@ Optional properties :
  - ti,external-control : Indicates that the charger is configured externally
    and that the host should not attempt to enable/disable charging or set the
    charge voltage/current.
+ - ti,poll-interval-ms : In case there is no interrupts specified, poll AC
+   presense on the ti,ac-detect-gpios GPIO with this interval.
 
 Example:
 
diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 1d5c9206e0ed..3765806d5d46 100644
--- a/drivers/power/supply/bq24735-charger.c
+++ b/drivers/power/supply/bq24735-charger.c
@@ -50,6 +50,8 @@ struct bq24735 {
 	struct bq24735_platform		*pdata;
 	struct mutex			lock;
 	struct gpio_desc		*status_gpio;
+	struct delayed_work		poll;
+	u32				poll_interval;
 	bool				charging;
 };
 
@@ -209,11 +211,8 @@ static int bq24735_charger_is_charging(struct bq24735 *charger)
 	return !(ret & BQ24735_CHG_OPT_CHARGE_DISABLE);
 }
 
-static irqreturn_t bq24735_charger_isr(int irq, void *devid)
+static void bq24735_update(struct bq24735 *charger)
 {
-	struct power_supply *psy = devid;
-	struct bq24735 *charger = to_bq24735(psy);
-
 	mutex_lock(&charger->lock);
 
 	if (charger->charging && bq24735_charger_is_present(charger))
@@ -223,11 +222,29 @@ static irqreturn_t bq24735_charger_isr(int irq, void *devid)
 
 	mutex_unlock(&charger->lock);
 
-	power_supply_changed(psy);
+	power_supply_changed(charger->charger);
+}
+
+static irqreturn_t bq24735_charger_isr(int irq, void *devid)
+{
+	struct power_supply *psy = devid;
+	struct bq24735 *charger = to_bq24735(psy);
+
+	bq24735_update(charger);
 
 	return IRQ_HANDLED;
 }
 
+static void bq24735_poll(struct work_struct *work)
+{
+	struct bq24735 *charger = container_of(work, struct bq24735, poll.work);
+
+	bq24735_update(charger);
+
+	schedule_delayed_work(&charger->poll,
+			      msecs_to_jiffies(charger->poll_interval));
+}
+
 static int bq24735_charger_get_property(struct power_supply *psy,
 					enum power_supply_property psp,
 					union power_supply_propval *val)
@@ -455,11 +472,33 @@ static int bq24735_charger_probe(struct i2c_client *client,
 				client->irq, ret);
 			return ret;
 		}
+	} else if (charger->status_gpio) {
+		ret = of_property_read_u32(client->dev.of_node,
+					   "ti,poll-interval-ms",
+					   &charger->poll_interval);
+		if (ret)
+			return 0;
+		if (!charger->poll_interval)
+			return 0;
+
+		INIT_DELAYED_WORK(&charger->poll, bq24735_poll);
+		schedule_delayed_work(&charger->poll,
+				      msecs_to_jiffies(charger->poll_interval));
 	}
 
 	return 0;
 }
 
+static int bq24735_charger_remove(struct i2c_client *client)
+{
+	struct bq24735 *charger = i2c_get_clientdata(client);
+
+	if (charger->poll_interval)
+		cancel_delayed_work_sync(&charger->poll);
+
+	return 0;
+}
+
 static const struct i2c_device_id bq24735_charger_id[] = {
 	{ "bq24735-charger", 0 },
 	{}
@@ -478,6 +517,7 @@ static struct i2c_driver bq24735_charger_driver = {
 		.of_match_table = bq24735_match_ids,
 	},
 	.probe = bq24735_charger_probe,
+	.remove = bq24735_charger_remove,
 	.id_table = bq24735_charger_id,
 };
 
-- 
2.1.4

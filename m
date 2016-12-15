From: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
Subject: [PATCH v3] power: supply: bq24735-charger: optionally poll the ac-detect gpio
Date: Thu, 15 Dec 2016 10:28:46 +0100
Message-ID: <1481794126-5670-1-git-send-email-peda@axentia.se>
References: <20161214151026.5q6goxlfscv53tol@earth>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161214151026.5q6goxlfscv53tol@earth>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

If the ac-detect gpio does not support interrupts, provide a fallback
to poll the gpio at a configurable interval.

Signed-off-by: Peter Rosin <peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org>
---

v2 -> v3 changes:
- use device_property_read_u32 instead of of_property_read_u32

v1 -> v2 changes:
- use poll-interval instead of ti,poll-interval-ms in the bindings

Cheers,
peda

 .../bindings/power/supply/ti,bq24735.txt           |  2 +
 drivers/power/supply/bq24735-charger.c             | 49 +++++++++++++++++++---
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
index 3bf55757ceec..799d0e5d6f26 100644
--- a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
+++ b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
@@ -25,6 +25,8 @@ Optional properties :
  - ti,external-control : Indicates that the charger is configured externally
    and that the host should not attempt to enable/disable charging or set the
    charge voltage/current.
+ - poll-interval : In case 'interrupts' is not specified, poll AC presence
+   on the ti,ac-detect-gpios GPIO with this interval (milliseconds).
 
 Example:
 
diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/supply/bq24735-charger.c
index 1d5c9206e0ed..8a0242c13b7e 100644
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
@@ -455,11 +472,32 @@ static int bq24735_charger_probe(struct i2c_client *client,
 				client->irq, ret);
 			return ret;
 		}
+	} else if (charger->status_gpio) {
+		ret = device_property_read_u32(&client->dev, "poll-interval",
+					       &charger->poll_interval);
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
@@ -478,6 +516,7 @@ static struct i2c_driver bq24735_charger_driver = {
 		.of_match_table = bq24735_match_ids,
 	},
 	.probe = bq24735_charger_probe,
+	.remove = bq24735_charger_remove,
 	.id_table = bq24735_charger_id,
 };
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

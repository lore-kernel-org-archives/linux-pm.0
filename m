From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] bq24735_charger: add status property to view/enable/disable charging
Date: Tue, 12 Jan 2016 21:30:59 +0100
Message-ID: <1452630659-4935-1-git-send-email-peda@lysator.liu.se>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.lysator.liu.se ([130.236.254.3]:38755 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbcALUb2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2016 15:31:28 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, Peter Rosin <peda@lysator.liu.se>

From: Peter Rosin <peda@axentia.se>

Signed-off-by: Peter Rosin <peda@axentia.se>
---

Hi!

The hw I have tested this on does not have the IRQ line of the
charger connected, so I have not actually tested how setting the
chargeing status interacts with the threaded interrupt handler.

I hope it's ok to grab a mutex in a threaded interrupt handler?

Cheers,
Peter

 drivers/power/bq24735-charger.c | 90 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/power/bq24735-charger.c b/drivers/power/bq24735-charger.c
index eb2b3689de97..079d1c6c2a8f 100644
--- a/drivers/power/bq24735-charger.c
+++ b/drivers/power/bq24735-charger.c
@@ -48,6 +48,8 @@ struct bq24735 {
 	struct power_supply_desc	charger_desc;
 	struct i2c_client		*client;
 	struct bq24735_platform		*pdata;
+	struct mutex			lock;
+	bool				charging;
 };
 
 static inline struct bq24735 *to_bq24735(struct power_supply *psy)
@@ -56,9 +58,23 @@ static inline struct bq24735 *to_bq24735(struct power_supply *psy)
 }
 
 static enum power_supply_property bq24735_charger_properties[] = {
+	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 };
 
+static int bq24735_charger_property_is_writeable(struct power_supply *psy,
+						 enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		return 1;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static inline int bq24735_write_word(struct i2c_client *client, u8 reg,
 				     u16 value)
 {
@@ -174,16 +190,30 @@ static bool bq24735_charger_is_present(struct bq24735 *charger)
 	return false;
 }
 
+static int bq24735_charger_is_charging(struct bq24735 *charger)
+{
+	int ret = bq24735_read_word(charger->client, BQ24735_CHG_OPT);
+
+	if (ret < 0)
+		return ret;
+
+	return !(ret & BQ24735_CHG_OPT_CHARGE_DISABLE);
+}
+
 static irqreturn_t bq24735_charger_isr(int irq, void *devid)
 {
 	struct power_supply *psy = devid;
 	struct bq24735 *charger = to_bq24735(psy);
 
-	if (bq24735_charger_is_present(charger))
+	mutex_lock(&charger->lock);
+
+	if (charger->charging && bq24735_charger_is_present(charger))
 		bq24735_enable_charging(charger);
 	else
 		bq24735_disable_charging(charger);
 
+	mutex_unlock(&charger->lock);
+
 	power_supply_changed(psy);
 
 	return IRQ_HANDLED;
@@ -199,6 +229,19 @@ static int bq24735_charger_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_ONLINE:
 		val->intval = bq24735_charger_is_present(charger) ? 1 : 0;
 		break;
+	case POWER_SUPPLY_PROP_STATUS:
+		switch (bq24735_charger_is_charging(charger)) {
+		case 1:
+			val->intval = POWER_SUPPLY_STATUS_CHARGING;
+			break;
+		case 0:
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
+			break;
+		default:
+			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
+			break;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -206,6 +249,46 @@ static int bq24735_charger_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int bq24735_charger_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct bq24735 *charger = to_bq24735(psy);
+	int ret;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_STATUS:
+		switch (val->intval) {
+		case POWER_SUPPLY_STATUS_CHARGING:
+			mutex_lock(&charger->lock);
+			charger->charging = true;
+			ret = bq24735_enable_charging(charger);
+			mutex_unlock(&charger->lock);
+			if (ret)
+				return ret;
+			bq24735_config_charger(charger);
+			break;
+		case POWER_SUPPLY_STATUS_DISCHARGING:
+		case POWER_SUPPLY_STATUS_NOT_CHARGING:
+			mutex_lock(&charger->lock);
+			charger->charging = false;
+			ret = bq24735_disable_charging(charger);
+			mutex_unlock(&charger->lock);
+			if (ret)
+				return ret;
+			break;
+		default:
+			return -EINVAL;
+		}
+		power_supply_changed(psy);
+		break;
+	default:
+		return -EPERM;
+	}
+
+	return 0;
+}
+
 static struct bq24735_platform *bq24735_parse_dt_data(struct i2c_client *client)
 {
 	struct bq24735_platform *pdata;
@@ -255,6 +338,8 @@ static int bq24735_charger_probe(struct i2c_client *client,
 	if (!charger)
 		return -ENOMEM;
 
+	mutex_init(&charger->lock);
+	charger->charging = true;
 	charger->pdata = client->dev.platform_data;
 
 	if (IS_ENABLED(CONFIG_OF) && !charger->pdata && client->dev.of_node)
@@ -285,6 +370,9 @@ static int bq24735_charger_probe(struct i2c_client *client,
 	supply_desc->properties = bq24735_charger_properties;
 	supply_desc->num_properties = ARRAY_SIZE(bq24735_charger_properties);
 	supply_desc->get_property = bq24735_charger_get_property;
+	supply_desc->set_property = bq24735_charger_set_property;
+	supply_desc->property_is_writeable =
+				bq24735_charger_property_is_writeable;
 
 	psy_cfg.supplied_to = charger->pdata->supplied_to;
 	psy_cfg.num_supplicants = charger->pdata->num_supplicants;
-- 
2.1.4


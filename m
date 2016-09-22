From: Matt Ranostay <mranostay@gmail.com>
Subject: [RFC 2/2] power: bq27xxx_battery: add poll interval property query
Date: Wed, 21 Sep 2016 22:52:24 -0700
Message-ID: <1474523544-3064-3-git-send-email-matt@ranostay.consulting>
References: <1474523544-3064-1-git-send-email-matt@ranostay.consulting>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474523544-3064-1-git-send-email-matt@ranostay.consulting>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <len.brown@intel.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-pm@vger.kernel.org

Add POWER_SUPPLY_PROP_POLL_INTERVAL property to query and set the
polling interval of the fuel gauge.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/power/bq27xxx_battery.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/power/bq27xxx_battery.c b/drivers/power/bq27xxx_battery.c
index 9cdca31ef3b2..ec6419007921 100644
--- a/drivers/power/bq27xxx_battery.c
+++ b/drivers/power/bq27xxx_battery.c
@@ -274,6 +274,7 @@ static enum power_supply_property bq27000_battery_props[] = {
 	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_POLL_INTERVAL,
 };
 
 static enum power_supply_property bq27010_battery_props[] = {
@@ -294,6 +295,7 @@ static enum power_supply_property bq27010_battery_props[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_POLL_INTERVAL,
 };
 
 static enum power_supply_property bq27500_battery_props[] = {
@@ -312,6 +314,7 @@ static enum power_supply_property bq27500_battery_props[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_POLL_INTERVAL,
 };
 
 static enum power_supply_property bq27530_battery_props[] = {
@@ -330,6 +333,7 @@ static enum power_supply_property bq27530_battery_props[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_POLL_INTERVAL,
 };
 
 static enum power_supply_property bq27541_battery_props[] = {
@@ -349,6 +353,7 @@ static enum power_supply_property bq27541_battery_props[] = {
 	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_POLL_INTERVAL,
 };
 
 static enum power_supply_property bq27545_battery_props[] = {
@@ -367,6 +372,7 @@ static enum power_supply_property bq27545_battery_props[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_POLL_INTERVAL,
 };
 
 static enum power_supply_property bq27421_battery_props[] = {
@@ -382,6 +388,7 @@ static enum power_supply_property bq27421_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_POLL_INTERVAL,
 };
 
 #define BQ27XXX_PROP(_id, _prop)		\
@@ -969,6 +976,9 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = BQ27XXX_MANUFACTURER;
 		break;
+	case POWER_SUPPLY_PROP_POLL_INTERVAL:
+		val->intval = poll_interval;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -976,6 +986,31 @@ static int bq27xxx_battery_get_property(struct power_supply *psy,
 	return ret;
 }
 
+static int bq27xxx_battery_set_property(struct power_supply *psy,
+					enum power_supply_property psp,
+					const union power_supply_propval *val)
+{
+	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
+
+	if (psp != POWER_SUPPLY_PROP_POLL_INTERVAL)
+		return -EINVAL;
+
+	poll_interval = val->intval;
+	cancel_delayed_work_sync(&di->work);
+	schedule_delayed_work(&di->work, 0);
+
+	return 0;
+}
+
+static int bq27xxx_property_is_writeable(struct power_supply *psy,
+					 enum power_supply_property psp)
+{
+	if (psp == POWER_SUPPLY_PROP_POLL_INTERVAL)
+		return 1;
+
+	return 0;
+}
+
 static void bq27xxx_external_power_changed(struct power_supply *psy)
 {
 	struct bq27xxx_device_info *di = power_supply_get_drvdata(psy);
@@ -1002,6 +1037,8 @@ int bq27xxx_battery_setup(struct bq27xxx_device_info *di)
 	psy_desc->properties = bq27xxx_battery_props[di->chip].props;
 	psy_desc->num_properties = bq27xxx_battery_props[di->chip].size;
 	psy_desc->get_property = bq27xxx_battery_get_property;
+	psy_desc->set_property = bq27xxx_battery_set_property;
+	psy_desc->property_is_writeable = bq27xxx_property_is_writeable;
 	psy_desc->external_power_changed = bq27xxx_external_power_changed;
 
 	di->bat = power_supply_register_no_ws(di->dev, psy_desc, &psy_cfg);
-- 
2.7.4

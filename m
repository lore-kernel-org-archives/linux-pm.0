From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 09/13] power: bq24257: Add charge type setting support
Date: Mon, 31 Aug 2015 21:10:31 -0500
Message-ID: <1441073435-12349-10-git-send-email-dannenberg@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37595 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754790AbbIACLu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 22:11:50 -0400
In-Reply-To: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

The bq2425x devices support charging with a configurable charge current
i_chg or a specific fixed low-current in what's called Low Charge mode.
This patch exposes access to the Low Charge mode through a POWER_
SUPPLY_PROP_CHARGE_TYPE sysfs property value of POWER_SUPPLY_CHARGE_
TYPE_TRICKLE. It also allows to completely disable charging if desired
by setting the property to POWER_SUPPLY_CHARGE_TYPE_NONE. Normal
charging with the configured i_chg current is activated through
POWER_SUPPLY_CHARGE_TYPE_FAST (default).

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 90 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index ad3fd2d..7b66030 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -262,6 +262,56 @@ enum bq24257_fault {
 	FAULT_INPUT_LDO_LOW,
 };
 
+static int bq24257_get_charge_type(struct bq24257_device *bq,
+		union power_supply_propval *val)
+{
+	int ret;
+
+	ret = bq24257_field_read(bq, F_CE);
+	if (ret < 0)
+		return ret;
+
+	/* Charge Enable is active-low */
+	if (ret) {
+		val->intval = POWER_SUPPLY_CHARGE_TYPE_NONE;
+		return 0;
+	}
+
+	/* Low Charge means a fixed low-current is used instead of i_chg */
+	ret = bq24257_field_read(bq, F_LOW_CHG);
+	if (ret < 0)
+		return ret;
+
+	val->intval = ret ? POWER_SUPPLY_CHARGE_TYPE_TRICKLE :
+			POWER_SUPPLY_CHARGE_TYPE_FAST;
+
+	return 0;
+}
+
+static int bq24257_set_charge_type(struct bq24257_device *bq,
+		const union power_supply_propval *val)
+{
+	int ret;
+
+	switch (val->intval) {
+	case POWER_SUPPLY_CHARGE_TYPE_NONE:
+		return bq24257_field_write(bq, F_CE, 1);
+	case POWER_SUPPLY_CHARGE_TYPE_TRICKLE:
+		ret = bq24257_field_write(bq, F_LOW_CHG, 1);
+		break;
+	case POWER_SUPPLY_CHARGE_TYPE_FAST:
+		ret = bq24257_field_write(bq, F_LOW_CHG, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return bq24257_field_write(bq, F_CE, 0);
+}
+
 static int bq24257_power_supply_get_property(struct power_supply *psy,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
@@ -287,6 +337,10 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		break;
 
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = bq24257_get_charge_type(bq, val);
+		break;
+
 	case POWER_SUPPLY_PROP_MANUFACTURER:
 		val->strval = BQ24257_MANUFACTURER;
 		break;
@@ -359,6 +413,39 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 	return ret;
 }
 
+static int bq24257_power_supply_set_property(struct power_supply *psy,
+		enum power_supply_property prop,
+		const union power_supply_propval *val)
+{
+	struct bq24257_device *bq = power_supply_get_drvdata(psy);
+	int ret;
+
+	mutex_lock(&bq->lock);
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		ret = bq24257_set_charge_type(bq, val);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	mutex_unlock(&bq->lock);
+
+	return ret;
+}
+
+static int bq24257_power_supply_property_is_writeable(struct power_supply *psy,
+		enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int bq24257_get_chip_state(struct bq24257_device *bq,
 				  struct bq24257_state *state)
 {
@@ -684,6 +771,7 @@ static enum power_supply_property bq24257_power_supply_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
@@ -703,6 +791,8 @@ static const struct power_supply_desc bq24257_power_supply_desc = {
 	.properties = bq24257_power_supply_props,
 	.num_properties = ARRAY_SIZE(bq24257_power_supply_props),
 	.get_property = bq24257_power_supply_get_property,
+	.set_property = bq24257_power_supply_set_property,
+	.property_is_writeable	= bq24257_power_supply_property_is_writeable
 };
 
 static ssize_t bq24257_show_ovp_voltage(struct device *dev,
-- 
1.9.1


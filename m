From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v3 08/10] power: bq24257: Allow input current limit sysfs access
Date: Fri, 11 Sep 2015 15:26:40 -0500
Message-ID: <1442003202-1430-9-git-send-email-dannenberg@ti.com>
References: <1442003202-1430-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38455 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877AbbIKU2K (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 11 Sep 2015 16:28:10 -0400
In-Reply-To: <1442003202-1430-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

This patch allows reading (and writing, if the D+/D- USB signal-based
charger type detection is disabled) of the input current limit through
the POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT sysfs property. This allows
userspace to see what charger was detected and to re-configure the
maximum current drawn from the external supply at runtime based on
system-level knowledge or user input.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 84a8945..517a522 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -265,6 +265,42 @@ enum bq24257_fault {
 	FAULT_INPUT_LDO_LOW,
 };
 
+static int bq24257_get_input_current_limit(struct bq24257_device *bq,
+					   union power_supply_propval *val)
+{
+	int ret;
+
+	ret = bq24257_field_read(bq, F_IILIMIT);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * The "External ILIM" and "Production & Test" modes are not exposed
+	 * through this driver and not being covered by the lookup table.
+	 * Should such a mode have become active let's return an error rather
+	 * than exceeding the bounds of the lookup table and returning
+	 * garbage.
+	 */
+	if (ret >= BQ24257_IILIMIT_MAP_SIZE)
+		return -ENODATA;
+
+	val->intval = bq24257_iilimit_map[ret];
+
+	return 0;
+}
+
+static int bq24257_set_input_current_limit(struct bq24257_device *bq,
+					const union power_supply_propval *val)
+{
+	if (!bq->in_ilimit_autoset_disable)
+		return -EPERM;
+
+	return bq24257_field_write(bq, F_IILIMIT,
+				   bq24257_find_idx(val->intval,
+						    bq24257_iilimit_map,
+						    BQ24257_IILIMIT_MAP_SIZE));
+}
+
 static int bq24257_power_supply_get_property(struct power_supply *psy,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
@@ -349,6 +385,9 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq24257_iterm_map[bq->init_data.iterm];
 		break;
 
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return bq24257_get_input_current_limit(bq, val);
+
 	default:
 		return -EINVAL;
 	}
@@ -356,6 +395,31 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int bq24257_power_supply_set_property(struct power_supply *psy,
+					enum power_supply_property prop,
+					const union power_supply_propval *val)
+{
+	struct bq24257_device *bq = power_supply_get_drvdata(psy);
+
+	switch (prop) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return bq24257_set_input_current_limit(bq, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bq24257_power_supply_property_is_writeable(struct power_supply *psy,
+					enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static int bq24257_get_chip_state(struct bq24257_device *bq,
 				  struct bq24257_state *state)
 {
@@ -691,6 +755,7 @@ static enum power_supply_property bq24257_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
 static char *bq24257_charger_supplied_to[] = {
@@ -703,6 +768,8 @@ static const struct power_supply_desc bq24257_power_supply_desc = {
 	.properties = bq24257_power_supply_props,
 	.num_properties = ARRAY_SIZE(bq24257_power_supply_props),
 	.get_property = bq24257_power_supply_get_property,
+	.set_property = bq24257_power_supply_set_property,
+	.property_is_writeable = bq24257_power_supply_property_is_writeable,
 };
 
 static ssize_t bq24257_show_ovp_voltage(struct device *dev,
-- 
1.9.1


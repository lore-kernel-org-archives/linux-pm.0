From: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 09/11] power: bq24257: Allow input current limit sysfs access
Date: Fri, 18 Sep 2015 16:39:57 -0500
Message-ID: <1442612399-341-10-git-send-email-dannenberg@ti.com>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1442612399-341-1-git-send-email-dannenberg-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Ramakrishna Pallala <ramakrishna.pallala-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This patch allows reading (and writing, if the D+/D- USB signal-based
charger type detection is disabled) of the input current limit through
the power supply's input_current_limit sysfs property. This allows
userspace to see what charger was detected and to re-configure the
maximum current drawn from the external supply at runtime based on
system-level knowledge or user input.

Signed-off-by: Andreas Dannenberg <dannenberg-l0cyMroinI0@public.gmane.org>
---
 drivers/power/bq24257_charger.c | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 615624c..66867d5 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -269,6 +269,42 @@ enum bq24257_fault {
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
+	if (bq->iilimit_autoset_enable)
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
@@ -353,6 +389,9 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq24257_iterm_map[bq->init_data.iterm];
 		break;
 
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return bq24257_get_input_current_limit(bq, val);
+
 	default:
 		return -EINVAL;
 	}
@@ -360,6 +399,31 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
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
@@ -694,6 +758,7 @@ static enum power_supply_property bq24257_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
 static char *bq24257_charger_supplied_to[] = {
@@ -706,6 +771,8 @@ static const struct power_supply_desc bq24257_power_supply_desc = {
 	.properties = bq24257_power_supply_props,
 	.num_properties = ARRAY_SIZE(bq24257_power_supply_props),
 	.get_property = bq24257_power_supply_get_property,
+	.set_property = bq24257_power_supply_set_property,
+	.property_is_writeable = bq24257_power_supply_property_is_writeable,
 };
 
 static ssize_t bq24257_show_ovp_voltage(struct device *dev,
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

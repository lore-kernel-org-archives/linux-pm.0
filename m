From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v2 09/13] power: bq24257: Allow input current limit sysfs access
Date: Tue, 8 Sep 2015 19:12:33 -0500
Message-ID: <1441757557-7266-10-git-send-email-dannenberg@ti.com>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45820 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbbIIAOD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 20:14:03 -0400
In-Reply-To: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

This patch allows reading (and writing, if the D+/D- USB signal-based
charger type detection is disabled) of the input current limit through
the POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT sysfs property. This allows
userspace to see what charger was detected and to re-configure the
maximum current drawn from the external supply at runtime based on
system-level knowledge or user input.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 886040c..f0602b3 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -315,6 +315,41 @@ static int bq24257_set_charge_type(struct bq24257_device *bq,
 	return bq24257_field_write(bq, F_CE, 0);
 }
 
+static int bq24257_get_input_current_limit(struct bq24257_device *bq,
+		union power_supply_propval *val)
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
+		const union power_supply_propval *val)
+{
+	if (!bq->in_ilimit_autoset_disable)
+		return -EPERM;
+
+	return bq24257_field_write(bq, F_IILIMIT, bq24257_find_idx(
+			val->intval, bq24257_iilimit_map,
+			BQ24257_IILIMIT_MAP_SIZE));
+}
+
 static int bq24257_power_supply_get_property(struct power_supply *psy,
 					     enum power_supply_property psp,
 					     union power_supply_propval *val)
@@ -403,6 +438,10 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq24257_iterm_map[bq->init_data.iterm];
 		break;
 
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq24257_get_input_current_limit(bq, val);
+		break;
+
 	default:
 		ret = -EINVAL;
 	}
@@ -425,6 +464,9 @@ static int bq24257_power_supply_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
 		ret = bq24257_set_charge_type(bq, val);
 		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq24257_set_input_current_limit(bq, val);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -439,6 +481,7 @@ static int bq24257_power_supply_property_is_writeable(struct power_supply *psy,
 {
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return true;
 	default:
 		return false;
@@ -778,6 +821,7 @@ static enum power_supply_property bq24257_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
 static char *bq24257_charger_supplied_to[] = {
-- 
1.9.1


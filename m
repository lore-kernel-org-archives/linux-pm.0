From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 10/13] power: bq24257: Add in_ilimit setting support
Date: Mon, 31 Aug 2015 21:10:32 -0500
Message-ID: <1441073435-12349-11-git-send-email-dannenberg@ti.com>
References: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55512 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754794AbbIACLu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 22:11:50 -0400
In-Reply-To: <1441073435-12349-1-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Andreas Dannenberg <dannenberg@ti.com>

This patch allows reading (and writing, if the the automatic setting
of in_ilimit is disabled) the input current limit through the
POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT sysfs property. This property is
being exposed as writable in order to allow userspace to re-configure
the charge current at runtime based on system-level knowledge or user
input.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
---
 drivers/power/bq24257_charger.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/power/bq24257_charger.c b/drivers/power/bq24257_charger.c
index 7b66030..42cc6fe 100644
--- a/drivers/power/bq24257_charger.c
+++ b/drivers/power/bq24257_charger.c
@@ -312,6 +312,41 @@ static int bq24257_set_charge_type(struct bq24257_device *bq,
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
@@ -404,6 +439,10 @@ static int bq24257_power_supply_get_property(struct power_supply *psy,
 		val->intval = bq24257_iterm_map[bq->init_data.iterm];
 		break;
 
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq24257_get_input_current_limit(bq, val);
+		break;
+
 	default:
 		ret = -EINVAL;
 	}
@@ -426,6 +465,9 @@ static int bq24257_power_supply_set_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
 		ret = bq24257_set_charge_type(bq, val);
 		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = bq24257_set_input_current_limit(bq, val);
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -440,6 +482,7 @@ static int bq24257_power_supply_property_is_writeable(struct power_supply *psy,
 {
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CHARGE_TYPE:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		return true;
 	default:
 		return false;
@@ -779,6 +822,7 @@ static enum power_supply_property bq24257_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
 static char *bq24257_charger_supplied_to[] = {
-- 
1.9.1


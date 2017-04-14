From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 2/3] drivers:power:twl4030-charger: add INPUT_CURRENT_LIMIT property and make it writeable
Date: Fri, 14 Apr 2017 20:25:56 +0200
Message-ID: <ed229ae8e6a4a9bd040e389d101b5257296d54ff.1492194356.git.hns@goldelico.com>
References: <cover.1492194356.git.hns@goldelico.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:29909 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbdDNS0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Apr 2017 14:26:10 -0400
In-Reply-To: <cover.1492194356.git.hns@goldelico.com>
In-Reply-To: <cover.1492194356.git.hns@goldelico.com>
References: <cover.1492194356.git.hns@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Andreas Kemnade <andreas@kemnade.info>, linux-pm@vger.kernel.org, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>

Currently, the twl4030 charger defines its own max_current by directly
creating sysfs nodes. It should use the input_current_limit property
which is e.g. used by the bq24257 driver.

This patch adds the input_current_property with the same semantics as
the max_current property. The code to manage the max_current property
is removed by a separate patch.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/twl4030_charger.c | 59 ++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 34e389d..e70c4ed 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -893,6 +893,28 @@ static int twl4030_bci_get_property(struct power_supply *psy,
 			twl4030_bci_state_to_status(state) !=
 				POWER_SUPPLY_STATUS_NOT_CHARGING;
 		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		val->intval = -1;
+		if (psy->desc->type != POWER_SUPPLY_TYPE_USB) {
+			if (!bci->ac_is_active)
+				val->intval = bci->ac_cur;
+		} else {
+			if (bci->ac_is_active)
+				val->intval = bci->usb_cur_target;
+		}
+		if (val->intval < 0) {
+			u8 bcictl1;
+
+			val->intval = twl4030bci_read_adc_val(TWL4030_BCIIREF1);
+			if (val->intval < 0)
+				return val->intval;
+			ret = twl4030_bci_read(TWL4030_BCICTL1, &bcictl1);
+			if (ret < 0)
+				return ret;
+			val->intval = regval2ua(val->intval, bcictl1 &
+							TWL4030_CGAIN);
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -900,11 +922,44 @@ static int twl4030_bci_get_property(struct power_supply *psy,
 	return 0;
 }
 
+static int twl4030_bci_set_property(struct power_supply *psy,
+				    enum power_supply_property psp,
+				    const union power_supply_propval *val)
+{
+	struct twl4030_bci *bci = dev_get_drvdata(psy->dev.parent);
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		if (psy->desc->type == POWER_SUPPLY_TYPE_USB)
+			bci->usb_cur_target = val->intval;
+		else
+			bci->ac_cur = val->intval;
+		twl4030_charger_update_current(bci);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int twl4030_bci_property_is_writeable(struct power_supply *psy,
+				      enum power_supply_property psp)
+{
+	switch (psp) {
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static enum power_supply_property twl4030_charger_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
 #ifdef CONFIG_OF
@@ -941,6 +996,8 @@ static const struct power_supply_desc twl4030_bci_ac_desc = {
 	.properties	= twl4030_charger_props,
 	.num_properties	= ARRAY_SIZE(twl4030_charger_props),
 	.get_property	= twl4030_bci_get_property,
+	.set_property	= twl4030_bci_set_property,
+	.property_is_writeable	= twl4030_bci_property_is_writeable,
 };
 
 static const struct power_supply_desc twl4030_bci_usb_desc = {
@@ -949,6 +1006,8 @@ static const struct power_supply_desc twl4030_bci_usb_desc = {
 	.properties	= twl4030_charger_props,
 	.num_properties	= ARRAY_SIZE(twl4030_charger_props),
 	.get_property	= twl4030_bci_get_property,
+	.set_property	= twl4030_bci_set_property,
+	.property_is_writeable	= twl4030_bci_property_is_writeable,
 };
 
 static int twl4030_bci_probe(struct platform_device *pdev)
-- 
2.7.3

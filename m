From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 09/16] power: supply: axp288_charger: Use the right property for the input current limit
Date: Tue, 26 Dec 2017 13:59:07 +0100
Message-ID: <20171226125914.10235-9-hdegoede@redhat.com>
References: <20171226125914.10235-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdLZM70 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 26 Dec 2017 07:59:26 -0500
In-Reply-To: <20171226125914.10235-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org

Use the right property for the input current limit and make it writable.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_charger.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index fdca0a4a1c8e..8f4ac2d38b3f 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -378,6 +378,11 @@ static int axp288_charger_usb_set_property(struct power_supply *psy,
 		if (ret < 0)
 			dev_warn(&info->pdev->dev, "set charge voltage failed\n");
 		break;
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
+		ret = axp288_charger_set_vbus_inlmt(info, val->intval);
+		if (ret < 0)
+			dev_warn(&info->pdev->dev, "set input current limit failed\n");
+		break;
 	default:
 		ret = -EINVAL;
 	}
@@ -430,7 +435,7 @@ static int axp288_charger_usb_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
 		val->intval = info->max_cv * 1000;
 		break;
-	case POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		ret = axp288_charger_get_vbus_inlmt(info);
 		if (ret < 0)
 			return ret;
@@ -451,6 +456,7 @@ static int axp288_charger_property_is_writeable(struct power_supply *psy,
 	switch (psp) {
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
 	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
+	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
 		ret = 1;
 		break;
 	default:
@@ -469,7 +475,7 @@ static enum power_supply_property axp288_usb_props[] = {
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
 	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
-	POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT,
+	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
 };
 
 static const struct power_supply_desc axp288_charger_desc = {
-- 
2.14.3

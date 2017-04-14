From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 12/14] power: max17042_battery: Add support for the CHARGE_NOW property
Date: Fri, 14 Apr 2017 20:32:57 +0200
Message-ID: <20170414183259.24382-12-hdegoede@redhat.com>
References: <20170414183259.24382-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753329AbdDNSdR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 14:33:17 -0400
In-Reply-To: <20170414183259.24382-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

Atleast upower prefers the more precise charge_now sysfs value over
capacity and the max17042 has the info, so lets export it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Take r_sns value into account when converting the register value to uAh
---
 drivers/power/supply/max17042_battery.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 39b0f86..e80ff90 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -89,6 +89,7 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_TEMP,
 	POWER_SUPPLY_PROP_TEMP_ALERT_MIN,
@@ -324,6 +325,15 @@ static int max17042_get_property(struct power_supply *psy,
 		do_div(data64, chip->pdata->r_sns);
 		val->intval = data64;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		ret = regmap_read(map, MAX17042_RepCap, &data);
+		if (ret < 0)
+			return ret;
+
+		data64 = data * 5000000ll;
+		do_div(data64, chip->pdata->r_sns);
+		val->intval = data64;
+		break;
 	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
 		ret = regmap_read(map, MAX17042_QH, &data);
 		if (ret < 0)
-- 
2.9.3

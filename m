From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 10/13] power: max17042_battery: Add support for the CHARGE_FULL_DESIGN property
Date: Fri, 14 Apr 2017 14:59:16 +0200
Message-ID: <20170414125919.25771-10-hdegoede@redhat.com>
References: <20170414125919.25771-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51282 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751739AbdDNM7f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 08:59:35 -0400
In-Reply-To: <20170414125919.25771-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

The info is there, lets export it as a property.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/max17042_battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index 770e188..56cfff7 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -90,6 +90,7 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_VOLTAGE_AVG,
 	POWER_SUPPLY_PROP_VOLTAGE_OCV,
 	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_COUNTER,
 	POWER_SUPPLY_PROP_TEMP,
@@ -307,6 +308,13 @@ static int max17042_get_property(struct power_supply *psy,
 
 		val->intval = data >> 8;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
+		ret = regmap_read(map, MAX17042_DesignCap, &data);
+		if (ret < 0)
+			return ret;
+
+		val->intval = data * 1000 / 2;
+		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = regmap_read(map, MAX17042_FullCAP, &data);
 		if (ret < 0)
-- 
2.9.3

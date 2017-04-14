From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 09/14] power: max17042_battery: Add support for the VOLT_MIN property
Date: Fri, 14 Apr 2017 20:32:54 +0200
Message-ID: <20170414183259.24382-9-hdegoede@redhat.com>
References: <20170414183259.24382-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753329AbdDNSdN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 14:33:13 -0400
In-Reply-To: <20170414183259.24382-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

The info is there, so lets export it, like we already do for VOLT_MAX.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/max17042_battery.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index c51847a..0ce6c65 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -81,6 +81,7 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX,
+	POWER_SUPPLY_PROP_VOLTAGE_MIN,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
 	POWER_SUPPLY_PROP_VOLTAGE_AVG,
@@ -257,6 +258,13 @@ static int max17042_get_property(struct power_supply *psy,
 		val->intval = data >> 8;
 		val->intval *= 20000; /* Units of LSB = 20mV */
 		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
+		ret = regmap_read(map, MAX17042_MinMaxVolt, &data);
+		if (ret < 0)
+			return ret;
+
+		val->intval = (data & 0xff) * 20000; /* Units of 20mV */
+		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
 		if (chip->chip_type == MAXIM_DEVICE_TYPE_MAX17042)
 			ret = regmap_read(map, MAX17042_V_empty, &data);
-- 
2.9.3

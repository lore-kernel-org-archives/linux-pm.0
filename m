From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 08/13] power: max17042_battery: Add support for the TECHNOLOGY attribute
Date: Fri, 14 Apr 2017 14:59:14 +0200
Message-ID: <20170414125919.25771-8-hdegoede@redhat.com>
References: <20170414125919.25771-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752257AbdDNM7c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 08:59:32 -0400
In-Reply-To: <20170414125919.25771-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

The max17042 is intended for LiOn or LiPo batteries, add a TECHNOLOGY
attribute to reflect this. Note this is hardcoded to LiOn as there is
no way to tell the difference, this is done by many drivers and is
better then not providing any technology info at all.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/max17042_battery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index e4288b5..1b2ff16 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -81,6 +81,7 @@ struct max17042_chip {
 static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_PRESENT,
+	POWER_SUPPLY_PROP_TECHNOLOGY,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
@@ -241,6 +242,9 @@ static int max17042_get_property(struct power_supply *psy,
 		else
 			val->intval = 1;
 		break;
+	case POWER_SUPPLY_PROP_TECHNOLOGY:
+		val->intval = POWER_SUPPLY_TECHNOLOGY_LION;
+		break;
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
 		ret = regmap_read(map, MAX17042_Cycles, &data);
 		if (ret < 0)
-- 
2.9.3

From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 12/13] power: max17042_battery: Add support for SCOPE property
Date: Fri, 14 Apr 2017 14:59:18 +0200
Message-ID: <20170414125919.25771-12-hdegoede@redhat.com>
References: <20170414125919.25771-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751739AbdDNM7i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Apr 2017 08:59:38 -0400
In-Reply-To: <20170414125919.25771-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org

Add support for the SCOPE property, always return SCOPE_SYSTEM,
as the max170xx is used for the main battery on all known systems
with a max170xx.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/max17042_battery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index fab4b95..ce6f38c 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -100,6 +100,7 @@ static enum power_supply_property max17042_battery_props[] = {
 	POWER_SUPPLY_PROP_TEMP_MIN,
 	POWER_SUPPLY_PROP_TEMP_MAX,
 	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CURRENT_AVG,
 };
@@ -367,6 +368,9 @@ static int max17042_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 		break;
+	case POWER_SUPPLY_PROP_SCOPE:
+		val->intval = POWER_SUPPLY_SCOPE_SYSTEM;
+		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		if (chip->pdata->enable_current_sense) {
 			ret = regmap_read(map, MAX17042_Current, &data);
-- 
2.9.3

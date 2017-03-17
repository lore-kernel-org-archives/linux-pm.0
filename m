From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 09/15] power: supply: bq24190_charger: Add voltage_max_design prop to battery
Date: Fri, 17 Mar 2017 10:55:21 +0100
Message-ID: <20170317095527.10487-10-hdegoede@redhat.com>
References: <20170317095527.10487-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751057AbdCQJ4t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 17 Mar 2017 05:56:49 -0400
In-Reply-To: <20170317095527.10487-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

When combined with an external fuel-gauge, upower needs voltage_max_design
as it internally does all its calculations in Watts and converts the
charge_foo properties from A to Watts by using voltage_max_design.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq24190_charger.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 9fe69a5..82cb33d 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1103,6 +1103,13 @@ static int bq24190_battery_get_property(struct power_supply *psy,
 		val->intval = POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 		ret = 0;
 		break;
+	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
+		/*
+		 * Report charger configured voltage as max design voltage,
+		 * not entirely correct, but userspace needs something here.
+		 */
+		ret = bq24190_charger_get_voltage(bdi, val);
+		break;
 	case POWER_SUPPLY_PROP_TEMP_ALERT_MAX:
 		ret = bq24190_battery_get_temp_alert_max(bdi, val);
 		break;
@@ -1169,6 +1176,7 @@ static enum power_supply_property bq24190_battery_properties[] = {
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
 	POWER_SUPPLY_PROP_TEMP_ALERT_MAX,
 	POWER_SUPPLY_PROP_SCOPE,
 	/* Begin of extended battery properties */
@@ -1186,7 +1194,7 @@ static const struct power_supply_desc bq24190_battery_desc = {
 	.name			= "bq24190-battery",
 	.type			= POWER_SUPPLY_TYPE_BATTERY,
 	.properties		= bq24190_battery_properties,
-	.num_properties		= 6,
+	.num_properties		= 7,
 	.get_property		= bq24190_battery_get_property,
 	.set_property		= bq24190_battery_set_property,
 	.property_is_writeable	= bq24190_battery_property_is_writeable,
-- 
2.9.3

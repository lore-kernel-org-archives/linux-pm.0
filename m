From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/8] power: bq27x00_battery: Add manufacturer property
Date: Wed, 22 Jul 2015 16:51:53 -0500
Message-ID: <1437601920-13045-2-git-send-email-afd@ti.com>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33993 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751654AbbGVWAp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Jul 2015 18:00:45 -0400
In-Reply-To: <1437601920-13045-1-git-send-email-afd@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F. Davis" <afd@ti.com>

Add the manufacturer property to the bq27x00 driver.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/power/bq27x00_battery.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_battery.c
index b6b9837..2257bd4 100644
--- a/drivers/power/bq27x00_battery.c
+++ b/drivers/power/bq27x00_battery.c
@@ -41,6 +41,8 @@
 
 #define DRIVER_VERSION			"1.2.0"
 
+#define BQ27XXX_MANUFACTURER	"Texas Instruments"
+
 #define BQ27x00_REG_TEMP		0x06
 #define BQ27x00_REG_VOLT		0x08
 #define BQ27x00_REG_AI			0x14
@@ -142,6 +144,7 @@ static enum power_supply_property bq27x00_battery_props[] = {
 	POWER_SUPPLY_PROP_ENERGY_NOW,
 	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
 static enum power_supply_property bq27425_battery_props[] = {
@@ -156,6 +159,7 @@ static enum power_supply_property bq27425_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
 static enum power_supply_property bq27742_battery_props[] = {
@@ -174,6 +178,7 @@ static enum power_supply_property bq27742_battery_props[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
 static enum power_supply_property bq27510_battery_props[] = {
@@ -192,6 +197,7 @@ static enum power_supply_property bq27510_battery_props[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_POWER_AVG,
 	POWER_SUPPLY_PROP_HEALTH,
+	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
 static unsigned int poll_interval = 360;
@@ -749,6 +755,9 @@ static int bq27x00_battery_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_HEALTH:
 		ret = bq27x00_simple_value(di->cache.health, val);
 		break;
+	case POWER_SUPPLY_PROP_MANUFACTURER:
+		val->strval = BQ27XXX_MANUFACTURER;
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
1.9.1


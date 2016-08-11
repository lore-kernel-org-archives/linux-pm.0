From: Joshua Clayton <stillcompiling@gmail.com>
Subject: [PATCH 1/1] sbs-battery: add ability to get battery capacity
Date: Thu, 11 Aug 2016 09:59:12 -0700
Message-ID: <1470934752-22719-1-git-send-email-stillcompiling@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joshua Clayton <stillcompiling@gmail.com>
List-Id: linux-pm@vger.kernel.org

Battery capacity level is a standard feature of sbs battery
That can be used to tell what the remainig battery capacity is, and
can tell if the battery has not been calibrated/initialized, which makes
the capacity and charging/discharging percentages invalid.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 drivers/power/sbs-battery.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sbs-battery.c b/drivers/power/sbs-battery.c
index 768b9fc..4f913b6 100644
--- a/drivers/power/sbs-battery.c
+++ b/drivers/power/sbs-battery.c
@@ -41,6 +41,7 @@ enum {
 	REG_TIME_TO_EMPTY,
 	REG_TIME_TO_FULL,
 	REG_STATUS,
+	REG_CAPACITY_LEVEL,
 	REG_CYCLE_COUNT,
 	REG_SERIAL_NUMBER,
 	REG_REMAINING_CAPACITY,
@@ -68,6 +69,7 @@ enum sbs_battery_mode {
 #define MANUFACTURER_ACCESS_SLEEP	0x0011
 
 /* battery status value bits */
+#define BATTERY_INITIALIZED		0x80
 #define BATTERY_DISCHARGING		0x40
 #define BATTERY_FULL_CHARGED		0x20
 #define BATTERY_FULL_DISCHARGED		0x10
@@ -110,6 +112,8 @@ static const struct chip_data {
 		SBS_DATA(POWER_SUPPLY_PROP_TIME_TO_FULL_AVG, 0x13, 0, 65535),
 	[REG_STATUS] =
 		SBS_DATA(POWER_SUPPLY_PROP_STATUS, 0x16, 0, 65535),
+	[REG_CAPACITY_LEVEL] =
+		SBS_DATA(POWER_SUPPLY_PROP_CAPACITY_LEVEL, 0x16, 0, 65535),
 	[REG_CYCLE_COUNT] =
 		SBS_DATA(POWER_SUPPLY_PROP_CYCLE_COUNT, 0x17, 0, 65535),
 	[REG_DESIGN_CAPACITY] =
@@ -131,6 +135,7 @@ static const struct chip_data {
 
 static enum power_supply_property sbs_properties[] = {
 	POWER_SUPPLY_PROP_STATUS,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 	POWER_SUPPLY_PROP_HEALTH,
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
@@ -377,8 +382,23 @@ static int sbs_get_battery_property(struct i2c_client *client,
 	if (ret >= sbs_data[reg_offset].min_value &&
 	    ret <= sbs_data[reg_offset].max_value) {
 		val->intval = ret;
-		if (psp != POWER_SUPPLY_PROP_STATUS)
+		if (psp == POWER_SUPPLY_PROP_CAPACITY_LEVEL) {
+			if (!(ret & BATTERY_INITIALIZED))
+				val->intval =
+					POWER_SUPPLY_CAPACITY_LEVEL_UNKNOWN;
+			else if (ret & BATTERY_FULL_CHARGED)
+				val->intval =
+					POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+			else if (ret & BATTERY_FULL_DISCHARGED)
+				val->intval =
+					POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+			else
+				val->intval =
+					POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
 			return 0;
+		} else if (psp != POWER_SUPPLY_PROP_STATUS) {
+			return 0;
+		}
 
 		if (ret & BATTERY_FULL_CHARGED)
 			val->intval = POWER_SUPPLY_STATUS_FULL;
@@ -590,6 +610,7 @@ static int sbs_get_property(struct power_supply *psy,
 		break;
 
 	case POWER_SUPPLY_PROP_STATUS:
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
 	case POWER_SUPPLY_PROP_CYCLE_COUNT:
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-- 
2.7.4

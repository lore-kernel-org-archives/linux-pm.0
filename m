From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/4] ACPI battery: introduce support for POWER_SUPPLY_PROP_CAPACITY_LEVEL
Date: Wed, 28 May 2014 15:23:36 +0800
Message-ID: <1401261818-2978-3-git-send-email-rui.zhang@intel.com>
References: <1401261818-2978-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40127 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbaE1HXq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 May 2014 03:23:46 -0400
In-Reply-To: <1401261818-2978-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, anton@enomsg.org, Zhang Rui <rui.zhang@intel.com>

ACPI battery device receives notifications when
1. the remaining battery capacity becomes critical low
2. the trip point set by the _BTP (Design capacity of Warning by default)
   is reached or crossed.

So it is able to support POWER_SUPPLY_PROP_CAPACITY_LEVEL to report
        POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL,
        POWER_SUPPLY_CAPACITY_LEVEL_LOW,
        POWER_SUPPLY_CAPACITY_LEVEL_NORMAL,
        POWER_SUPPLY_CAPACITY_LEVEL_FULL,
capacity levels to power supply core and user space.

Introduce support for POWER_SUPPLY_PROP_CAPACITY_LEVEL in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/battery.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9a2c63b..b508bd0 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -50,6 +50,10 @@
 /* Battery power unit: 0 means mW, 1 means mA */
 #define ACPI_BATTERY_POWER_UNIT_MA	1
 
+#define ACPI_BATTERY_STATE_DISCHARGING	0x1
+#define ACPI_BATTERY_STATE_CHARGING	0x2
+#define ACPI_BATTERY_STATE_CRITICAL	0x4
+
 #define _COMPONENT		ACPI_BATTERY_COMPONENT
 
 ACPI_MODULE_NAME("battery");
@@ -150,7 +154,7 @@ static int acpi_battery_get_state(struct acpi_battery *battery);
 
 static int acpi_battery_is_charged(struct acpi_battery *battery)
 {
-	/* either charging or discharging */
+	/* charging, discharging or critical low */
 	if (battery->state != 0)
 		return 0;
 
@@ -185,9 +189,9 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		return -ENODEV;
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
-		if (battery->state & 0x01)
+		if (battery->state & ACPI_BATTERY_STATE_DISCHARGING)
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
-		else if (battery->state & 0x02)
+		else if (battery->state & ACPI_BATTERY_STATE_CHARGING)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else if (acpi_battery_is_charged(battery))
 			val->intval = POWER_SUPPLY_STATUS_FULL;
@@ -250,6 +254,17 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		else
 			val->intval = 0;
 		break;
+	case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
+		if (battery->state & ACPI_BATTERY_STATE_CRITICAL)
+			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL;
+		else if (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
+			(battery->capacity_now <= battery->alarm))
+			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_LOW;
+		else if (acpi_battery_is_charged(battery))
+			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_FULL;
+		else
+			val->intval = POWER_SUPPLY_CAPACITY_LEVEL_NORMAL;
+		break;
 	case POWER_SUPPLY_PROP_MODEL_NAME:
 		val->strval = battery->model_number;
 		break;
@@ -277,6 +292,7 @@ static enum power_supply_property charge_battery_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
@@ -294,6 +310,7 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_ENERGY_FULL,
 	POWER_SUPPLY_PROP_ENERGY_NOW,
 	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
 	POWER_SUPPLY_PROP_MODEL_NAME,
 	POWER_SUPPLY_PROP_MANUFACTURER,
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
-- 
1.8.3.2


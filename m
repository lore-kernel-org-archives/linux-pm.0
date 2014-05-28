From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/4] ACPI battery: wakeup the system only when necessary
Date: Wed, 28 May 2014 15:23:38 +0800
Message-ID: <1401261818-2978-5-git-send-email-rui.zhang@intel.com>
References: <1401261818-2978-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40127 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752006AbaE1HXv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 May 2014 03:23:51 -0400
In-Reply-To: <1401261818-2978-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rafael.j.wysocki@intel.com, anton@enomsg.org, Zhang Rui <rui.zhang@intel.com>

ACPI Battery device receives notifications from firmware frequently,
and most of these notifications are some general events, like battery
remaining capacity change, etc, which should not wake the system up
if the system is in suspend/hibernate state.

This causes a problem that the system wakes up from suspend to freeze
shortly, because there is an ACPI battery notification every 10 seconds.
https://bugzilla.kernel.org/show_bug.cgi?id=76221

Fix the problem in this patch by registering ACPI battery device'
own wakeup source, and waking up the system only when the battery remaining
capacity is critical low, or lower than the alarm capacity set via _BTP.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/battery.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b508bd0..e6afe28 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -595,7 +595,8 @@ static int sysfs_add_battery(struct acpi_battery *battery)
 	battery->bat.type = POWER_SUPPLY_TYPE_BATTERY;
 	battery->bat.get_property = acpi_battery_get_property;
 
-	result = power_supply_register(&battery->device->dev, &battery->bat);
+	result = power_supply_register_no_ws(&battery->device->dev, &battery->bat);
+
 	if (result)
 		return result;
 	return device_create_file(battery->bat.dev, &alarm_attr);
@@ -710,7 +711,19 @@ static int acpi_battery_update(struct acpi_battery *battery)
 			return result;
 	}
 	result = acpi_battery_get_state(battery);
+	if (result)
+		return result;
 	acpi_battery_quirks(battery);
+
+	/*
+	 * Wakeup the system if battery is critical low
+	 * or lower than the alarm level
+	 */
+	if ((battery->state & ACPI_BATTERY_STATE_CRITICAL) ||
+	    (test_bit(ACPI_BATTERY_ALARM_PRESENT, &battery->flags) &&
+            (battery->capacity_now <= battery->alarm)))
+		pm_wakeup_event(&battery->device->dev, 0);
+
 	return result;
 }
 
@@ -815,6 +828,8 @@ static int acpi_battery_add(struct acpi_device *device)
 	battery->pm_nb.notifier_call = battery_notify;
 	register_pm_notifier(&battery->pm_nb);
 
+	device_init_wakeup(&device->dev, 1);
+
 	return result;
 
 fail:
@@ -831,6 +846,7 @@ static int acpi_battery_remove(struct acpi_device *device)
 
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
+	device_init_wakeup(&device->dev, 0);
 	battery = acpi_driver_data(device);
 	unregister_pm_notifier(&battery->pm_nb);
 	sysfs_remove_battery(battery);
-- 
1.8.3.2


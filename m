From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v7 3/5] ACPI: battery: Add a blacklist with PMIC ACPI HIDs with a native battery driver
Date: Wed, 19 Apr 2017 14:02:10 +0200
Message-ID: <20170419120212.24949-4-hdegoede@redhat.com>
References: <20170419120212.24949-1-hdegoede@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762821AbdDSMDS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 19 Apr 2017 08:03:18 -0400
In-Reply-To: <20170419120212.24949-1-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org

On some systems we have a native PMIC driver which provides battery
monitoring, while the ACPI battery driver is broken on these systems
due to bad DSDTs or because we do not support the proprietary and
undocumented ACPI opregions these ACPI battery devices rely on
(e.g. BMOP opregion).

This leads to there being 2 battery power_supply-s registed like this:

~$ acpi
Battery 0: Charging, 84%, 00:49:39 until charged
Battery 1: Unknown, 0%, rate information unavailable

Even if the ACPI battery where to function fine (which on systems
where we have a native PMIC driver it often doesn't) we still do not
want to export the same battery to userspace twice.

This commit adds a blacklist with PMIC ACPI HIDs for which we've a
native battery driver and makes the ACPI battery driver not register
itself when a PMIC on this list is present.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=194811
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch-set replacing:
 "ACPI: battery: Add acpi_battery_unregister() function"
 "power: supply: axp288_fuel_gauge: Unregister duplicate ACPI battery supply"
Changes in v7:
-Some minor code style tweaks based on review from Andy Shevchenko
---
 drivers/acpi/battery.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b35fca4..d42eeef 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -94,6 +94,11 @@ static const struct acpi_device_id battery_device_ids[] = {
 
 MODULE_DEVICE_TABLE(acpi, battery_device_ids);
 
+/* Lists of PMIC ACPI HIDs with an (often better) native battery driver */
+static const char * const acpi_battery_blacklist[] = {
+	"INT33F4", /* X-Powers AXP288 PMIC */
+};
+
 enum {
 	ACPI_BATTERY_ALARM_PRESENT,
 	ACPI_BATTERY_XINFO_PRESENT,
@@ -1316,8 +1321,17 @@ static struct acpi_driver acpi_battery_driver = {
 
 static void __init acpi_battery_init_async(void *unused, async_cookie_t cookie)
 {
+	unsigned int i;
 	int result;
 
+	for (i = 0; i < ARRAY_SIZE(acpi_battery_blacklist); i++)
+		if (acpi_dev_present(acpi_battery_blacklist[i], "1", -1)) {
+			pr_info(PREFIX ACPI_BATTERY_DEVICE_NAME
+				": found native %s PMIC, not loading\n",
+				acpi_battery_blacklist[i]);
+			return;
+		}
+
 	dmi_check_system(bat_dmi_table);
 
 #ifdef CONFIG_ACPI_PROCFS_POWER
-- 
2.9.3

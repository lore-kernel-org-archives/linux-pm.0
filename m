From: Ognjen Galic <smclt30p@gmail.com>
Subject: [PATCH v13 4/4] battery: Add the ThinkPad "Not Charging" quirk
Date: Wed, 7 Feb 2018 15:59:36 +0100
Message-ID: <20180207145936.ockmmkipxtwkdsot@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

The EC/ACPI firmware on Lenovo ThinkPads used to report a status
of "Unknown" when the battery is between the charge start and
charge stop thresholds. On Windows, it reports "Not Charging"
so the quirk has been added to also report correctly.

Now the "status" attribute returns "Not Charging" when the
battery on ThinkPads is not physicaly charging.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
---

Notes:
    v7:
    * Added all the style changes as suggested by Rafael
    * Re-ordered the series to make this a post-implement
    bugfix
    
    v8:
    * No changes in this patch in v8
    
    v9:
    * No changes in this patch in v9
    
    v10:
    * No changes in this patch in v10
    
    v11:
    * Fix formatting of changelog
    
    v12:
    * No changes in this patch in v12
    
    v13:
    * No changes in this patch in v13

 drivers/acpi/battery.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 3fab2cb9e..e4b23738c 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -74,6 +74,7 @@ static async_cookie_t async_cookie;
 static bool battery_driver_registered;
 static int battery_bix_broken_package;
 static int battery_notification_delay_ms;
+static int battery_quirk_notcharging;
 static int battery_full_discharging;
 static unsigned int cache_time = 1000;
 module_param(cache_time, uint, 0644);
@@ -229,6 +230,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
 		else if (acpi_battery_is_charged(battery))
 			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else if (battery_quirk_notcharging)
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		else
 			val->intval = POWER_SUPPLY_STATUS_UNKNOWN;
 		break;
@@ -707,7 +710,7 @@ EXPORT_SYMBOL_GPL(battery_hook_register);
  * This function gets called right after the battery sysfs
  * attributes have been added, so that the drivers that
  * define custom sysfs attributes can add their own.
-*/
+ */
 static void battery_hook_add_battery(struct acpi_battery *battery)
 {
 	struct acpi_battery_hook *hook_node;
@@ -1315,6 +1318,12 @@ static int __init battery_full_discharging_quirk(const struct dmi_system_id *d)
 	return 0;
 }
 
+static int __init battery_quirk_not_charging(const struct dmi_system_id *d)
+{
+	battery_quirk_notcharging = 1;
+	return 0;
+}
+
 static const struct dmi_system_id bat_dmi_table[] __initconst = {
 	{
 		.callback = battery_bix_broken_package_quirk,
@@ -1348,6 +1357,19 @@ static const struct dmi_system_id bat_dmi_table[] __initconst = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "UX305LA"),
 		},
 	},
+	{
+		/*
+		 * On Lenovo ThinkPads the BIOS specification defines
+		 * a state when the bits for charging and discharging
+		 * are both set to 0. That state is "Not Charging".
+		 */
+		.callback = battery_quirk_not_charging,
+		.ident = "Lenovo ThinkPad",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad"),
+		},
+	},
 	{},
 };
 
-- 
2.14.1

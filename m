From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [Resend][PATCH 3/3] ACPI / PM: Drop acpi_power_nocheck
Date: Sat, 11 Dec 2010 23:45:30 +0100
Message-ID: <201012112345.30224.rjw__40541.5673660629$1292107638$gmane$org@sisk.pl>
References: <201012112339.53105.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012112339.53105.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since acpi_bus_set_power() should not use __acpi_bus_get_power() to
update the device's device->power.state field before changing its
power state (this may cause device->power.state to be inconsistent
with the device power resources' reference counters), remove this
call from it.  In consequence, the acpi_power_nocheck variable is not
necessary any more, so it can be dropped along with the DMI table
used for setting that variable for HP Pavilion 05.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/bus.c      |   39 ---------------------------------------
 drivers/acpi/internal.h |    1 -
 drivers/acpi/power.c    |    3 ---
 3 files changed, 43 deletions(-)

Index: linux-2.6/drivers/acpi/bus.c
===================================================================
--- linux-2.6.orig/drivers/acpi/bus.c
+++ linux-2.6/drivers/acpi/bus.c
@@ -52,22 +52,6 @@ EXPORT_SYMBOL(acpi_root_dir);
 
 #define STRUCT_TO_INT(s)	(*((int*)&s))
 
-static int set_power_nocheck(const struct dmi_system_id *id)
-{
-	printk(KERN_NOTICE PREFIX "%s detected - "
-		"disable power check in power transition\n", id->ident);
-	acpi_power_nocheck = 1;
-	return 0;
-}
-static struct dmi_system_id __cpuinitdata power_nocheck_dmi_table[] = {
-	{
-	set_power_nocheck, "HP Pavilion 05", {
-	DMI_MATCH(DMI_BIOS_VENDOR, "Phoenix Technologies LTD"),
-	DMI_MATCH(DMI_SYS_VENDOR, "HP Pavilion 05"),
-	DMI_MATCH(DMI_PRODUCT_VERSION, "2001211RE101GLEND") }, NULL},
-	{},
-};
-
 
 #ifdef CONFIG_X86
 static int set_copy_dsdt(const struct dmi_system_id *id)
@@ -333,23 +317,6 @@ int acpi_bus_set_power(acpi_handle handl
 		return -ENODEV;
 	}
 
-	/*
-	 * Get device's current power state
-	 */
-	if (!acpi_power_nocheck) {
-		/*
-		 * Maybe the incorrect power state is returned on the bogus
-		 * bios, which is different with the real power state.
-		 * For example: the bios returns D0 state and the real power
-		 * state is D3. OS expects to set the device to D0 state. In
-		 * such case if OS uses the power state returned by the BIOS,
-		 * the device can't be transisted to the correct power state.
-		 * So if the acpi_power_nocheck is set, it is unnecessary to
-		 * get the power state by calling acpi_bus_get_power.
-		 */
-		__acpi_bus_get_power(device, &device->power.state);
-	}
-
 	return __acpi_bus_set_power(device, state);
 }
 EXPORT_SYMBOL(acpi_bus_set_power);
@@ -1072,12 +1039,6 @@ static int __init acpi_init(void)
 	if (acpi_disabled)
 		return result;
 
-	/*
-	 * If the laptop falls into the DMI check table, the power state check
-	 * will be disabled in the course of device power transition.
-	 */
-	dmi_check_system(power_nocheck_dmi_table);
-
 	acpi_scan_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
Index: linux-2.6/drivers/acpi/internal.h
===================================================================
--- linux-2.6.orig/drivers/acpi/internal.h
+++ linux-2.6/drivers/acpi/internal.h
@@ -45,7 +45,6 @@ int acpi_power_get_inferred_state(struct
 int acpi_power_on_resources(struct acpi_device *device, int state);
 int acpi_power_transition(struct acpi_device *device, int state);
 int acpi_bus_init_power(struct acpi_device *device);
-extern int acpi_power_nocheck;
 
 int acpi_wakeup_device_init(void);
 void acpi_early_processor_set_pdc(void);
Index: linux-2.6/drivers/acpi/power.c
===================================================================
--- linux-2.6.orig/drivers/acpi/power.c
+++ linux-2.6/drivers/acpi/power.c
@@ -56,9 +56,6 @@ ACPI_MODULE_NAME("power");
 #define ACPI_POWER_RESOURCE_STATE_ON	0x01
 #define ACPI_POWER_RESOURCE_STATE_UNKNOWN 0xFF
 
-int acpi_power_nocheck;
-module_param_named(power_nocheck, acpi_power_nocheck, bool, 000);
-
 static int acpi_power_add(struct acpi_device *device);
 static int acpi_power_remove(struct acpi_device *device, int type);
 static int acpi_power_resume(struct acpi_device *device);

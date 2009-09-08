From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/5] ACPI PM: Replace wakeup.prepared with
	reference counter
Date: Tue, 8 Sep 2009 23:15:31 +0200
Message-ID: <200909082315.31115.rjw__7220.64919905296$1252445011$gmane$org@sisk.pl>
References: <200908300041.14541.rjw@sisk.pl> <200909040002.02562.rjw@sisk.pl>
	<200909082311.48366.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200909082311.48366.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ykzhao <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The wakeup.prepared flag is used for marking devices that have the
wake-up power already enabled, so that the wake-up power is not
enabled twice in a row for the same device.  This assumes, however,
that device wake-up power will only be enabled once, while the device
is being prepared for a system-wide sleep transition, and the second
attempt is made by acpi_enable_wakeup_device_prep().

With the upcoming PCI wake-up rework this assumption will not hold
any more for PCI bridges and the root bridge whose wake-up power
may be enabled as a result of wake-up enable propagation from other
devices (eg. add-on devices that are not associated with any GPEs).
Thus, there may be many attempts to enable wake-up power on a PCI
bridge or the root bridge during a system power state transition
and it's better to replace wakeup.prepared with a reference counter.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/power.c    |   58 ++++++++++++++++++++++++++++--------------------
 drivers/acpi/scan.c     |    1 
 drivers/acpi/wakeup.c   |    4 +--
 include/acpi/acpi_bus.h |    2 -
 4 files changed, 39 insertions(+), 26 deletions(-)

Index: linux-2.6/drivers/acpi/scan.c
===================================================================
--- linux-2.6.orig/drivers/acpi/scan.c
+++ linux-2.6/drivers/acpi/scan.c
@@ -781,6 +781,7 @@ static int acpi_bus_get_wakeup_device_fl
 	kfree(buffer.pointer);
 
 	device->wakeup.flags.valid = 1;
+	device->wakeup.prepare_count = 0;
 	/* Call _PSW/_DSW object to disable its ability to wake the sleeping
 	 * system for the ACPI device with the _PRW object.
 	 * The _PSW object is depreciated in ACPI 3.0 and is replaced by _DSW.
Index: linux-2.6/include/acpi/acpi_bus.h
===================================================================
--- linux-2.6.orig/include/acpi/acpi_bus.h
+++ linux-2.6/include/acpi/acpi_bus.h
@@ -248,7 +248,6 @@ struct acpi_device_perf {
 /* Wakeup Management */
 struct acpi_device_wakeup_flags {
 	u8 valid:1;		/* Can successfully enable wakeup? */
-	u8 prepared:1;		/* Has the wake-up capability been enabled? */
 	u8 run_wake:1;		/* Run-Wake GPE devices */
 };
 
@@ -263,6 +262,7 @@ struct acpi_device_wakeup {
 	struct acpi_handle_list resources;
 	struct acpi_device_wakeup_state state;
 	struct acpi_device_wakeup_flags flags;
+	int prepare_count;
 };
 
 /* Device */
Index: linux-2.6/drivers/acpi/power.c
===================================================================
--- linux-2.6.orig/drivers/acpi/power.c
+++ linux-2.6/drivers/acpi/power.c
@@ -44,6 +44,8 @@
 #include <acpi/acpi_bus.h>
 #include <acpi/acpi_drivers.h>
 
+#include "sleep.h"
+
 #define _COMPONENT			ACPI_POWER_COMPONENT
 ACPI_MODULE_NAME("power");
 #define ACPI_POWER_CLASS		"power_resource"
@@ -361,17 +363,15 @@ int acpi_device_sleep_wake(struct acpi_d
  */
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state)
 {
-	int i, err;
+	int i, err = 0;
 
 	if (!dev || !dev->wakeup.flags.valid)
 		return -EINVAL;
 
-	/*
-	 * Do not execute the code below twice in a row without calling
-	 * acpi_disable_wakeup_device_power() in between for the same device
-	 */
-	if (dev->wakeup.flags.prepared)
-		return 0;
+	mutex_lock(&acpi_device_lock);
+
+	if (dev->wakeup.prepare_count++)
+		goto out;
 
 	/* Open power resource */
 	for (i = 0; i < dev->wakeup.resources.count; i++) {
@@ -379,7 +379,8 @@ int acpi_enable_wakeup_device_power(stru
 		if (ret) {
 			printk(KERN_ERR PREFIX "Transition power state\n");
 			dev->wakeup.flags.valid = 0;
-			return -ENODEV;
+			err = -ENODEV;
+			goto err_out;
 		}
 	}
 
@@ -388,9 +389,13 @@ int acpi_enable_wakeup_device_power(stru
 	 * in arbitrary power state afterwards.
 	 */
 	err = acpi_device_sleep_wake(dev, 1, sleep_state, 3);
-	if (!err)
-		dev->wakeup.flags.prepared = 1;
 
+ err_out:
+	if (err)
+		dev->wakeup.prepare_count = 0;
+
+ out:
+	mutex_unlock(&acpi_device_lock);
 	return err;
 }
 
@@ -402,35 +407,42 @@ int acpi_enable_wakeup_device_power(stru
  */
 int acpi_disable_wakeup_device_power(struct acpi_device *dev)
 {
-	int i, ret;
+	int i, err = 0;
 
 	if (!dev || !dev->wakeup.flags.valid)
 		return -EINVAL;
 
+	mutex_lock(&acpi_device_lock);
+
+	if (--dev->wakeup.prepare_count > 0)
+		goto out;
+
 	/*
-	 * Do not execute the code below twice in a row without calling
-	 * acpi_enable_wakeup_device_power() in between for the same device
+	 * Executing the code below even if prepare_count is already zero when
+	 * the function is called may be useful, for example for initialisation.
 	 */
-	if (!dev->wakeup.flags.prepared)
-		return 0;
+	if (dev->wakeup.prepare_count < 0)
+		dev->wakeup.prepare_count = 0;
 
-	dev->wakeup.flags.prepared = 0;
-
-	ret = acpi_device_sleep_wake(dev, 0, 0, 0);
-	if (ret)
-		return ret;
+	err = acpi_device_sleep_wake(dev, 0, 0, 0);
+	if (err)
+		goto out;
 
 	/* Close power resource */
 	for (i = 0; i < dev->wakeup.resources.count; i++) {
-		ret = acpi_power_off_device(dev->wakeup.resources.handles[i], dev);
+		int ret = acpi_power_off_device(
+				dev->wakeup.resources.handles[i], dev);
 		if (ret) {
 			printk(KERN_ERR PREFIX "Transition power state\n");
 			dev->wakeup.flags.valid = 0;
-			return -ENODEV;
+			err = -ENODEV;
+			goto out;
 		}
 	}
 
-	return ret;
+ out:
+	mutex_unlock(&acpi_device_lock);
+	return err;
 }
 
 /* --------------------------------------------------------------------------
Index: linux-2.6/drivers/acpi/wakeup.c
===================================================================
--- linux-2.6.orig/drivers/acpi/wakeup.c
+++ linux-2.6/drivers/acpi/wakeup.c
@@ -68,7 +68,7 @@ void acpi_enable_wakeup_device(u8 sleep_
 		/* If users want to disable run-wake GPE,
 		 * we only disable it for wake and leave it for runtime
 		 */
-		if ((!dev->wakeup.state.enabled && !dev->wakeup.flags.prepared)
+		if ((!dev->wakeup.state.enabled && !dev->wakeup.prepare_count)
 		    || sleep_state > (u32) dev->wakeup.sleep_state) {
 			if (dev->wakeup.flags.run_wake) {
 				/* set_gpe_type will disable GPE, leave it like that */
@@ -100,7 +100,7 @@ void acpi_disable_wakeup_device(u8 sleep
 		if (!dev->wakeup.flags.valid)
 			continue;
 
-		if ((!dev->wakeup.state.enabled && !dev->wakeup.flags.prepared)
+		if ((!dev->wakeup.state.enabled && !dev->wakeup.prepare_count)
 		    || sleep_state > (u32) dev->wakeup.sleep_state) {
 			if (dev->wakeup.flags.run_wake) {
 				acpi_set_gpe_type(dev->wakeup.gpe_device,

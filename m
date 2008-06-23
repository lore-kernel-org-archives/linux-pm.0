From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 04/11] ACPI: Introduce acpi_device_sleep_wake
	function
Date: Mon, 23 Jun 2008 19:45:39 +0200
Message-ID: <200806231945.39951.rjw__38845.3145431869$1214245380$gmane$org@sisk.pl>
References: <200806231934.08565.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806231934.08565.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

ACPI: Introduce acpi_device_sleep_wake function

The currect ACPI code attempts to execute _PSW at three different
places and in one of them only it tries to execute _DSW before _PSW,
which is inconsistent with the other two cases.

Move the execution of _DSW and _PSW into a separate function called
acpi_device_sleep_wake() and call it wherever appropriate instead of
executing _DSW and/or _PSW directly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/power.c        |  118 ++++++++++++++++++++++++++++++--------------
 drivers/acpi/scan.c         |   42 ++-------------
 drivers/acpi/sleep/wakeup.c |    2 
 include/acpi/acpi_drivers.h |    4 +
 4 files changed, 92 insertions(+), 74 deletions(-)

Index: linux-next/drivers/acpi/power.c
===================================================================
--- linux-next.orig/drivers/acpi/power.c
+++ linux-next/drivers/acpi/power.c
@@ -292,69 +292,115 @@ static int acpi_power_off_device(acpi_ha
 	return 0;
 }
 
+/**
+ * acpi_device_sleep_wake - execute _DSW (Device Sleep Wake) or (deprecated in
+ *                          ACPI 3.0) _PSW (Power State Wake)
+ * @dev: Device to handle.
+ * @enable: 0 - disable, 1 - enable the wake capabilities of the device.
+ * @sleep_state: Target sleep state of the system.
+ * @dev_state: Target power state of the device.
+ *
+ * Execute _DSW (Device Sleep Wake) or (deprecated in ACPI 3.0) _PSW (Power
+ * State Wake) for the device, if present.  On failure reset the device's
+ * wakeup.flags.valid flag.
+ *
+ * RETURN VALUE:
+ * 0 if either _DSW or _PSW has been successfully executed
+ * 0 if neither _DSW nor _PSW has been found
+ * -ENODEV if the execution of either _DSW or _PSW has failed
+ */
+int acpi_device_sleep_wake(struct acpi_device *dev,
+                           int enable, int sleep_state, int dev_state)
+{
+	union acpi_object in_arg[3];
+	struct acpi_object_list arg_list = { 3, in_arg };
+	acpi_status status = AE_OK;
+
+	/*
+	 * Try to execute _DSW first.
+	 *
+	 * Three agruments are needed for the _DSW object:
+	 * Argument 0: enable/disable the wake capabilities
+	 * Argument 1: target system state
+	 * Argument 2: target device state
+	 * When _DSW object is called to disable the wake capabilities, maybe
+	 * the first argument is filled. The values of the other two agruments
+	 * are meaningless.
+	 */
+	in_arg[0].type = ACPI_TYPE_INTEGER;
+	in_arg[0].integer.value = enable;
+	in_arg[1].type = ACPI_TYPE_INTEGER;
+	in_arg[1].integer.value = sleep_state;
+	in_arg[2].type = ACPI_TYPE_INTEGER;
+	in_arg[2].integer.value = dev_state;
+	status = acpi_evaluate_object(dev->handle, "_DSW", &arg_list, NULL);
+	if (ACPI_SUCCESS(status)) {
+		return 0;
+	} else if (status != AE_NOT_FOUND) {
+		printk(KERN_ERR PREFIX "_DSW execution failed\n");
+		dev->wakeup.flags.valid = 0;
+		return -ENODEV;
+	}
+
+	/* Execute _PSW */
+	arg_list.count = 1;
+	in_arg[0].integer.value = enable;
+	status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
+	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
+		printk(KERN_ERR PREFIX "_PSW execution failed\n");
+		dev->wakeup.flags.valid = 0;
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 /*
  * Prepare a wakeup device, two steps (Ref ACPI 2.0:P229):
  * 1. Power on the power resources required for the wakeup device 
- * 2. Enable _PSW (power state wake) for the device if present
+ * 2. Execute _DSW (Device Sleep Wake) or (deprecated in ACPI 3.0) _PSW (Power
+ *    State Wake) for the device, if present
  */
-int acpi_enable_wakeup_device_power(struct acpi_device *dev)
+int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state)
 {
-	union acpi_object arg = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list arg_list = { 1, &arg };
-	acpi_status status = AE_OK;
 	int i;
-	int ret = 0;
 
 	if (!dev || !dev->wakeup.flags.valid)
-		return -1;
+		return -EINVAL;
 
-	arg.integer.value = 1;
 	/* Open power resource */
 	for (i = 0; i < dev->wakeup.resources.count; i++) {
-		ret = acpi_power_on(dev->wakeup.resources.handles[i], dev);
+		int ret = acpi_power_on(dev->wakeup.resources.handles[i], dev);
 		if (ret) {
 			printk(KERN_ERR PREFIX "Transition power state\n");
 			dev->wakeup.flags.valid = 0;
-			return -1;
+			return -ENODEV;
 		}
 	}
 
-	/* Execute PSW */
-	status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
-	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
-		printk(KERN_ERR PREFIX "Evaluate _PSW\n");
-		dev->wakeup.flags.valid = 0;
-		ret = -1;
-	}
-
-	return ret;
+	/*
+	 * Passing 3 as the third argument below means the device may be placed
+	 * in arbitrary power state afterwards.
+	 */
+	return acpi_device_sleep_wake(dev, 1, sleep_state, 3);
 }
 
 /*
  * Shutdown a wakeup device, counterpart of above method
- * 1. Disable _PSW (power state wake)
+ * 1. Execute _DSW (Device Sleep Wake) or (deprecated in ACPI 3.0) _PSW (Power
+ *    State Wake) for the device, if present
  * 2. Shutdown down the power resources
  */
 int acpi_disable_wakeup_device_power(struct acpi_device *dev)
 {
-	union acpi_object arg = { ACPI_TYPE_INTEGER };
-	struct acpi_object_list arg_list = { 1, &arg };
-	acpi_status status = AE_OK;
-	int i;
-	int ret = 0;
-
+	int i, ret;
 
 	if (!dev || !dev->wakeup.flags.valid)
-		return -1;
+		return -EINVAL;
 
-	arg.integer.value = 0;
-	/* Execute PSW */
-	status = acpi_evaluate_object(dev->handle, "_PSW", &arg_list, NULL);
-	if (ACPI_FAILURE(status) && (status != AE_NOT_FOUND)) {
-		printk(KERN_ERR PREFIX "Evaluate _PSW\n");
-		dev->wakeup.flags.valid = 0;
-		return -1;
-	}
+	ret = acpi_device_sleep_wake(dev, 0, 0, 0);
+	if (ret)
+		return ret;
 
 	/* Close power resource */
 	for (i = 0; i < dev->wakeup.resources.count; i++) {
@@ -362,7 +408,7 @@ int acpi_disable_wakeup_device_power(str
 		if (ret) {
 			printk(KERN_ERR PREFIX "Transition power state\n");
 			dev->wakeup.flags.valid = 0;
-			return -1;
+			return -ENODEV;
 		}
 	}
 
Index: linux-next/drivers/acpi/sleep/wakeup.c
===================================================================
--- linux-next.orig/drivers/acpi/sleep/wakeup.c
+++ linux-next/drivers/acpi/sleep/wakeup.c
@@ -42,7 +42,7 @@ void acpi_enable_wakeup_device_prep(u8 s
 			continue;
 
 		spin_unlock(&acpi_device_lock);
-		acpi_enable_wakeup_device_power(dev);
+		acpi_enable_wakeup_device_power(dev, sleep_state);
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);
Index: linux-next/include/acpi/acpi_drivers.h
===================================================================
--- linux-next.orig/include/acpi/acpi_drivers.h
+++ linux-next/include/acpi/acpi_drivers.h
@@ -87,7 +87,9 @@ struct pci_bus *pci_acpi_scan_root(struc
    -------------------------------------------------------------------------- */
 
 #ifdef CONFIG_ACPI_POWER
-int acpi_enable_wakeup_device_power(struct acpi_device *dev);
+int acpi_device_sleep_wake(struct acpi_device *dev,
+                           int enable, int sleep_state, int dev_state);
+int acpi_enable_wakeup_device_power(struct acpi_device *dev, int sleep_state);
 int acpi_disable_wakeup_device_power(struct acpi_device *dev);
 int acpi_power_get_inferred_state(struct acpi_device *device);
 int acpi_power_transition(struct acpi_device *device, int state);
Index: linux-next/drivers/acpi/scan.c
===================================================================
--- linux-next.orig/drivers/acpi/scan.c
+++ linux-next/drivers/acpi/scan.c
@@ -703,9 +703,7 @@ static int acpi_bus_get_wakeup_device_fl
 	acpi_status status = 0;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *package = NULL;
-	union acpi_object in_arg[3];
-	struct acpi_object_list arg_list = { 3, in_arg };
-	acpi_status psw_status = AE_OK;
+	int psw_error;
 
 	struct acpi_device_id button_device_ids[] = {
 		{"PNP0C0D", 0},
@@ -737,39 +735,11 @@ static int acpi_bus_get_wakeup_device_fl
 	 * So it is necessary to call _DSW object first. Only when it is not
 	 * present will the _PSW object used.
 	 */
-	/*
-	 * Three agruments are needed for the _DSW object.
-	 * Argument 0: enable/disable the wake capabilities
-	 * When _DSW object is called to disable the wake capabilities, maybe
-	 * the first argument is filled. The value of the other two agruments
-	 * is meaningless.
-	 */
-	in_arg[0].type = ACPI_TYPE_INTEGER;
-	in_arg[0].integer.value = 0;
-	in_arg[1].type = ACPI_TYPE_INTEGER;
-	in_arg[1].integer.value = 0;
-	in_arg[2].type = ACPI_TYPE_INTEGER;
-	in_arg[2].integer.value = 0;
-	psw_status = acpi_evaluate_object(device->handle, "_DSW",
-						&arg_list, NULL);
-	if (ACPI_FAILURE(psw_status) && (psw_status != AE_NOT_FOUND))
-		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "error in evaluate _DSW\n"));
-	/*
-	 * When the _DSW object is not present, OSPM will call _PSW object.
-	 */
-	if (psw_status == AE_NOT_FOUND) {
-		/*
-		 * Only one agruments is required for the _PSW object.
-		 * agrument 0: enable/disable the wake capabilities
-		 */
-		arg_list.count = 1;
-		in_arg[0].integer.value = 0;
-		psw_status = acpi_evaluate_object(device->handle, "_PSW",
-						&arg_list, NULL);
-		if (ACPI_FAILURE(psw_status) && (psw_status != AE_NOT_FOUND))
-			ACPI_DEBUG_PRINT((ACPI_DB_INFO, "error in "
-						"evaluate _PSW\n"));
-	}
+	psw_error = acpi_device_sleep_wake(device, 0, 0, 0);
+	if (psw_error)
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+				"error in _DSW or _PSW evaluation\n"));
+
 	/* Power button, Lid switch always enable wakeup */
 	if (!acpi_match_device_ids(device, button_device_ids))
 		device->wakeup.flags.run_wake = 1;

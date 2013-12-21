From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] Thermal: ACPI INT3403 thermal driver
Date: Sat, 21 Dec 2013 12:11:05 -0800
Message-ID: <1387656665-18989-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11106 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755723Ab3LUULn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 21 Dec 2013 15:11:43 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, eduardo.valentin@ti.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

The ACPI INT3403 device objects present on some systems can be used to retrieve
temperature data from thermal sensors. Add a driver registering each INT3403
device object as a thermal zone device and exposing its _TMP, PATx and GTSH
method via the standard thermal control interface under /sys/class/thermal/.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/Kconfig           |   7 ++
 drivers/thermal/Makefile          |   1 +
 drivers/thermal/int3403_thermal.c | 248 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)
 create mode 100644 drivers/thermal/int3403_thermal.c

diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
index f35a1f7..8928e64 100644
--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -192,6 +192,13 @@ config X86_PKG_TEMP_THERMAL
 	  two trip points which can be set by user to get notifications via thermal
 	  notification methods.
 
+config ACPI_INT3403_THERMAL
+	tristate "ACPI INT3403 thermal driver"
+	depends on X86 && ACPI
+	help
+	  This driver uses ACPI INT3403 device objects. If present, it will
+	  register each INT3403 thermal sensor as a thermal zone.
+
 menu "Texas Instruments thermal drivers"
 source "drivers/thermal/ti-soc-thermal/Kconfig"
 endmenu
diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
index 584b363..aa1bba9 100644
--- a/drivers/thermal/Makefile
+++ b/drivers/thermal/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_DB8500_CPUFREQ_COOLING)	+= db8500_cpufreq_cooling.o
 obj-$(CONFIG_INTEL_POWERCLAMP)	+= intel_powerclamp.o
 obj-$(CONFIG_X86_PKG_TEMP_THERMAL)	+= x86_pkg_temp_thermal.o
 obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-thermal/
+obj-$(CONFIG_ACPI_INT3403_THERMAL)	+= int3403_thermal.o
diff --git a/drivers/thermal/int3403_thermal.c b/drivers/thermal/int3403_thermal.c
new file mode 100644
index 0000000..9efa1cb
--- /dev/null
+++ b/drivers/thermal/int3403_thermal.c
@@ -0,0 +1,248 @@
+/*
+ * ACPI INT3403 thermal driver
+ * Copyright (c) 2013, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/acpi.h>
+#include <linux/thermal.h>
+
+#define INT3403_TYPE_SENSOR		0x03
+#define INT3403_PERF_CHANGED_EVENT	0x80
+#define INT3403_THERMAL_EVENT		0x90
+
+#define KELVIN_TO_MILLICELSIUS(t, off) (((t) - (off)) * 100)
+#define KELVIN_OFFSET	2732
+#define MILLICELSIUS_TO_KELVIN(t, off) (((t) / 100) + (off))
+
+#define ACPI_INT3403_CLASS		"int3403"
+#define ACPI_INT3403_FILE_STATE		"state"
+
+struct int3403_sensor {
+	struct thermal_zone_device *tzone;
+	unsigned long *thresholds;
+};
+
+static int sys_get_curr_temp(struct thermal_zone_device *tzone,
+				unsigned long *temp)
+{
+	struct acpi_device *device = tzone->devdata;
+	unsigned long long tmp;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(device->handle, "_TMP", NULL, &tmp);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	*temp = KELVIN_TO_MILLICELSIUS(tmp, KELVIN_OFFSET);
+
+	return 0;
+}
+
+static int sys_get_trip_hyst(struct thermal_zone_device *tzone,
+		int trip, unsigned long *temp)
+{
+	struct acpi_device *device = tzone->devdata;
+	unsigned long long hyst;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(device->handle, "GTSH", NULL, &hyst);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	*temp = KELVIN_TO_MILLICELSIUS(hyst, KELVIN_OFFSET);
+
+	return 0;
+}
+
+static int sys_get_trip_temp(struct thermal_zone_device *tzone,
+		int trip, unsigned long *temp)
+{
+	struct acpi_device *device = tzone->devdata;
+	struct int3403_sensor *obj = acpi_driver_data(device);
+
+	/*
+	* get_trip_temp is a mandatory callback but
+	* PATx method doesn't return any value, so return
+	* cached value, which was last set from user space.
+	*/
+	*temp = obj->thresholds[trip];
+
+	return 0;
+}
+
+static int sys_get_trip_type(struct thermal_zone_device *thermal,
+		int trip, enum thermal_trip_type *type)
+{
+	/* Mandatory callback, may not mean much here */
+	*type = THERMAL_TRIP_PASSIVE;
+
+	return 0;
+}
+
+int sys_set_trip_temp(struct thermal_zone_device *tzone, int trip,
+							unsigned long temp)
+{
+	struct acpi_device *device = tzone->devdata;
+	acpi_status status;
+	char *name;
+	int ret = 0;
+	struct int3403_sensor *obj = acpi_driver_data(device);
+
+	name = kasprintf(GFP_KERNEL, "PAT%d", trip);
+	if (acpi_has_method(device->handle, name)) {
+		status = acpi_execute_simple_method(device->handle, name,
+				MILLICELSIUS_TO_KELVIN(temp, KELVIN_OFFSET));
+		if (ACPI_FAILURE(status))
+			ret = -EIO;
+		else
+			obj->thresholds[trip] = temp;
+	} else {
+		ret = -EIO;
+		dev_err(&device->dev, "sys_set_trip_temp: method not found\n");
+	}
+	kfree(name);
+
+	return ret;
+}
+
+static struct thermal_zone_device_ops tzone_ops = {
+	.get_temp = sys_get_curr_temp,
+	.get_trip_temp = sys_get_trip_temp,
+	.get_trip_type = sys_get_trip_type,
+	.set_trip_temp = sys_set_trip_temp,
+	.get_trip_hyst =  sys_get_trip_hyst,
+};
+
+static void acpi_thermal_notify(struct acpi_device *device, u32 event)
+{
+	struct int3403_sensor *obj;
+
+	if (!device)
+		return;
+
+	obj = acpi_driver_data(device);
+	if (!obj)
+		return;
+
+	switch (event) {
+	case INT3403_PERF_CHANGED_EVENT:
+		break;
+	case INT3403_THERMAL_EVENT:
+		thermal_zone_device_update(obj->tzone);
+		break;
+	default:
+		dev_err(&device->dev, "Unsupported event [0x%x]\n", event);
+		break;
+	}
+}
+
+static int acpi_int3403_add(struct acpi_device *device)
+{
+	int result = 0;
+	unsigned long long ptyp;
+	acpi_status status;
+	struct int3403_sensor *obj;
+	unsigned long long trip_cnt;
+	int trip_mask = 0;
+
+	if (!device)
+		return -EINVAL;
+
+	status = acpi_evaluate_integer(device->handle, "PTYP", NULL, &ptyp);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	if (ptyp != INT3403_TYPE_SENSOR)
+		return -EINVAL;
+
+	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
+	if (!obj)
+		return -ENOMEM;
+
+	device->driver_data = obj;
+
+	status = acpi_evaluate_integer(device->handle, "PATC", NULL,
+						&trip_cnt);
+	if (ACPI_FAILURE(status))
+		trip_cnt = 0;
+
+	if (trip_cnt) {
+		/* We have to cache, thresholds can't be readback */
+		obj->thresholds = kzalloc(sizeof(*obj->thresholds) * trip_cnt,
+						GFP_KERNEL);
+		if (!obj->thresholds) {
+			result = -ENOMEM;
+			goto err_thres;
+		}
+		trip_mask = BIT(trip_cnt) - 1;
+	}
+	obj->tzone = thermal_zone_device_register(acpi_device_bid(device),
+				trip_cnt, trip_mask, device, &tzone_ops,
+				NULL, 0, 0);
+	if (IS_ERR(obj->tzone)) {
+		result = PTR_ERR(obj->tzone);
+		goto err_zone;
+	}
+
+	strcpy(acpi_device_name(device), "INT3403");
+	strcpy(acpi_device_class(device), ACPI_INT3403_CLASS);
+
+	return 0;
+err_zone:
+	kfree(obj->thresholds);
+err_thres:
+	kfree(obj);
+	return result;
+}
+
+static int acpi_int3403_remove(struct acpi_device *device)
+{
+	struct int3403_sensor *obj;
+
+	if (!device)
+		return -EINVAL;
+
+	obj = acpi_driver_data(device);
+	thermal_zone_device_unregister(obj->tzone);
+	kfree(obj->thresholds);
+	kfree(obj);
+
+	return 0;
+}
+
+ACPI_MODULE_NAME("int3403");
+static const struct acpi_device_id int3403_device_ids[] = {
+	{"INT3403", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
+
+static struct acpi_driver acpi_int3403_driver = {
+	.name = "INT3403",
+	.class = ACPI_INT3403_CLASS,
+	.ids = int3403_device_ids,
+	.ops = {
+		.add = acpi_int3403_add,
+		.remove = acpi_int3403_remove,
+		.notify = acpi_thermal_notify,
+		},
+};
+
+module_acpi_driver(acpi_int3403_driver);
+
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ACPI INT3403 thermal driver");
-- 
1.8.3.1


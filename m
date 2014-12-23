From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/4] Thermal/int340x: Add common thermal zone handler
Date: Tue, 23 Dec 2014 15:27:27 -0800
Message-ID: <1419377250-13869-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24262 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755068AbaLWX2G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Dec 2014 18:28:06 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Most of the processing for each int340x driver to add a thermal zone
is very similar and every driver has to duplicate code.
Created a common module, which exports API to add and remove zones.
In this way, we not only avoid duplicate code but also helps in
bug fixes and enhancements.
If for some driver default processing for thermal zone callback is
not enough they can overide individual callback.
The code for this driver is primarily copied from int3402_thermal.c
with bug fixes.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/Makefile           |   1 +
 .../thermal/int340x_thermal/int340x_thermal_zone.c | 255 +++++++++++++++++++++
 .../thermal/int340x_thermal/int340x_thermal_zone.h |  65 ++++++
 3 files changed, 321 insertions(+)
 create mode 100644 drivers/thermal/int340x_thermal/int340x_thermal_zone.c
 create mode 100644 drivers/thermal/int340x_thermal/int340x_thermal_zone.h

diff --git a/drivers/thermal/int340x_thermal/Makefile b/drivers/thermal/int340x_thermal/Makefile
index d441369..ba77a34 100644
--- a/drivers/thermal/int340x_thermal/Makefile
+++ b/drivers/thermal/int340x_thermal/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_INT340X_THERMAL)	+= int3400_thermal.o
+obj-$(CONFIG_INT340X_THERMAL)	+= int340x_thermal_zone.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3402_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= int3403_thermal.o
 obj-$(CONFIG_INT340X_THERMAL)	+= processor_thermal_device.o
diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
new file mode 100644
index 0000000..afd03ef
--- /dev/null
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
@@ -0,0 +1,255 @@
+/*
+ * int340x_thermal_zone.c
+ * Copyright (c) 2014, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/acpi.h>
+#include <linux/thermal.h>
+#include "int340x_thermal_zone.h"
+
+static int int340x_thermal_get_zone_temp(struct thermal_zone_device *zone,
+					 unsigned long *temp)
+{
+	struct int34x_thermal_zone *d = zone->devdata;
+	unsigned long long tmp;
+	acpi_status status;
+
+	if (d->override_ops && d->override_ops->get_temp)
+		return d->override_ops->get_temp(zone, temp);
+
+	status = acpi_evaluate_integer(d->adev->handle, "_TMP", NULL, &tmp);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	/* _TMP returns the temperature in tenths of degrees Kelvin */
+	*temp = DECI_KELVIN_TO_MILLICELSIUS(tmp);
+
+	return 0;
+}
+
+static int int340x_thermal_get_trip_temp(struct thermal_zone_device *zone,
+					 int trip, unsigned long *temp)
+{
+	struct int34x_thermal_zone *d = zone->devdata;
+	int i;
+
+	if (d->override_ops && d->override_ops->get_trip_temp)
+		return d->override_ops->get_trip_temp(zone, trip, temp);
+
+	if (trip < d->aux_trip_nr)
+		*temp = d->aux_trips[trip];
+	else if (trip == d->crt_trip_id)
+		*temp = d->crt_temp;
+	else if (trip == d->psv_trip_id)
+		*temp = d->psv_temp;
+	else if (trip == d->hot_trip_id)
+		*temp = d->hot_temp;
+	else {
+		for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
+			if (d->act_trips[i].valid &&
+			    d->act_trips[i].id == trip) {
+				*temp = d->act_trips[i].temp;
+				break;
+			}
+		}
+		if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int int340x_thermal_get_trip_type(struct thermal_zone_device *zone,
+					 int trip,
+					 enum thermal_trip_type *type)
+{
+	struct int34x_thermal_zone *d = zone->devdata;
+	int i;
+
+	if (d->override_ops && d->override_ops->get_trip_type)
+		return d->override_ops->get_trip_type(zone, trip, type);
+
+	if (trip < d->aux_trip_nr)
+		*type = THERMAL_TRIP_PASSIVE;
+	else if (trip == d->crt_trip_id)
+		*type = THERMAL_TRIP_CRITICAL;
+	else if (trip == d->hot_trip_id)
+		*type = THERMAL_TRIP_HOT;
+	else if (trip == d->psv_trip_id)
+		*type = THERMAL_TRIP_PASSIVE;
+	else {
+		for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
+			if (d->act_trips[i].valid &&
+			    d->act_trips[i].id == trip) {
+				*type = THERMAL_TRIP_ACTIVE;
+				break;
+			}
+		}
+		if (i == INT340X_THERMAL_MAX_ACT_TRIP_COUNT)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int int340x_thermal_set_trip_temp(struct thermal_zone_device *zone,
+				      int trip, unsigned long temp)
+{
+	struct int34x_thermal_zone *d = zone->devdata;
+	acpi_status status;
+	char name[10];
+
+	if (d->override_ops && d->override_ops->set_trip_temp)
+		return d->override_ops->set_trip_temp(zone, trip, temp);
+
+	snprintf(name, sizeof(name), "PAT%d", trip);
+	status = acpi_execute_simple_method(d->adev->handle, name,
+			MILLICELSIUS_TO_DECI_KELVIN(temp));
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	d->aux_trips[trip] = temp;
+
+	return 0;
+}
+
+
+static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
+		int trip, unsigned long *temp)
+{
+	struct int34x_thermal_zone *d = zone->devdata;
+	acpi_status status;
+	unsigned long long hyst;
+
+	if (d->override_ops && d->override_ops->get_trip_hyst)
+		return d->override_ops->get_trip_hyst(zone, trip, temp);
+
+	status = acpi_evaluate_integer(d->adev->handle, "GTSH", NULL, &hyst);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	*temp = hyst * 100;
+
+	return 0;
+}
+
+static struct thermal_zone_device_ops int340x_thermal_zone_ops = {
+	.get_temp       = int340x_thermal_get_zone_temp,
+	.get_trip_temp	= int340x_thermal_get_trip_temp,
+	.get_trip_type	= int340x_thermal_get_trip_type,
+	.set_trip_temp	= int340x_thermal_set_trip_temp,
+	.get_trip_hyst =  int340x_thermal_get_trip_hyst,
+};
+
+static int int340x_thermal_get_trip_config(acpi_handle handle, char *name,
+				      unsigned long *temp)
+{
+	unsigned long long r;
+	acpi_status status;
+
+	status = acpi_evaluate_integer(handle, name, NULL, &r);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	*temp = DECI_KELVIN_TO_MILLICELSIUS(r);
+
+	return 0;
+}
+
+static struct thermal_zone_params int340x_thermal_params = {
+	.governor_name = "user_space",
+	.no_hwmon = true,
+};
+
+struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *adev,
+				struct thermal_zone_device_ops *override_ops)
+{
+	struct int34x_thermal_zone *int34x_thermal_zone;
+	acpi_status status;
+	unsigned long long trip_cnt;
+	int trip_mask = 0, i;
+
+	int34x_thermal_zone = kzalloc(sizeof(*int34x_thermal_zone),
+				      GFP_KERNEL);
+	if (!int34x_thermal_zone)
+		return ERR_PTR(-ENOMEM);
+
+	int34x_thermal_zone->adev = adev;
+	int34x_thermal_zone->override_ops = override_ops;
+
+	status = acpi_evaluate_integer(adev->handle, "PATC", NULL, &trip_cnt);
+	if (ACPI_FAILURE(status))
+		trip_cnt = 0;
+	else {
+		int34x_thermal_zone->aux_trips = kzalloc(
+				sizeof(*int34x_thermal_zone->aux_trips) *
+				trip_cnt, GFP_KERNEL);
+		if (!int34x_thermal_zone->aux_trips)
+			goto free_mem;
+		trip_mask = BIT(trip_cnt) - 1;
+		int34x_thermal_zone->aux_trip_nr = trip_cnt;
+	}
+
+	int34x_thermal_zone->crt_trip_id = -1;
+	if (!int340x_thermal_get_trip_config(adev->handle, "_CRT",
+					     &int34x_thermal_zone->crt_temp))
+		int34x_thermal_zone->crt_trip_id = trip_cnt++;
+	int34x_thermal_zone->hot_trip_id = -1;
+	if (!int340x_thermal_get_trip_config(adev->handle, "_HOT",
+					     &int34x_thermal_zone->hot_temp))
+		int34x_thermal_zone->hot_trip_id = trip_cnt++;
+	int34x_thermal_zone->psv_trip_id = -1;
+	if (!int340x_thermal_get_trip_config(adev->handle, "_PSV",
+					     &int34x_thermal_zone->psv_temp))
+		int34x_thermal_zone->psv_trip_id = trip_cnt++;
+	for (i = 0; i < INT340X_THERMAL_MAX_ACT_TRIP_COUNT; i++) {
+		char name[5] = { '_', 'A', 'C', '0' + i, '\0' };
+
+		if (int340x_thermal_get_trip_config(adev->handle, name,
+				&int34x_thermal_zone->act_trips[i].temp))
+			break;
+
+		int34x_thermal_zone->act_trips[i].id = trip_cnt++;
+		int34x_thermal_zone->act_trips[i].valid = true;
+	}
+
+	int34x_thermal_zone->zone = thermal_zone_device_register(
+						acpi_device_bid(adev),
+						trip_cnt,
+						trip_mask, int34x_thermal_zone,
+						&int340x_thermal_zone_ops,
+						&int340x_thermal_params,
+						0, 0);
+
+	return int34x_thermal_zone;
+
+free_mem:
+	kfree(int34x_thermal_zone);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(int340x_thermal_zone_add);
+
+void int340x_thermal_zone_remove(struct int34x_thermal_zone
+				 *int34x_thermal_zone)
+{
+	thermal_zone_device_unregister(int34x_thermal_zone->zone);
+	kfree(int34x_thermal_zone);
+}
+EXPORT_SYMBOL_GPL(int340x_thermal_zone_remove);
+
+MODULE_AUTHOR("Aaron Lu <aaron.lu@intel.com>");
+MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
+MODULE_DESCRIPTION("Intel INT340x common thermal zone handler");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.h b/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
new file mode 100644
index 0000000..d1406ce
--- /dev/null
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.h
@@ -0,0 +1,65 @@
+/*
+ * int340x_thermal_zone.h
+ * Copyright (c) 2014, Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ */
+
+#ifndef __INT340X_THERMAL_ZONE_H__
+#define __INT340X_THERMAL_ZONE_H__
+
+#define INT340X_THERMAL_MAX_ACT_TRIP_COUNT	10
+
+struct active_trip {
+	unsigned long temp;
+	int id;
+	bool valid;
+};
+
+struct int34x_thermal_zone {
+	struct acpi_device *adev;
+	struct active_trip act_trips[INT340X_THERMAL_MAX_ACT_TRIP_COUNT];
+	unsigned long *aux_trips;
+	int aux_trip_nr;
+	unsigned long psv_temp;
+	int psv_trip_id;
+	unsigned long crt_temp;
+	int crt_trip_id;
+	unsigned long hot_temp;
+	int hot_trip_id;
+	struct thermal_zone_device *zone;
+	struct thermal_zone_device_ops *override_ops;
+	void *priv_data;
+};
+
+struct int34x_thermal_zone *int340x_thermal_zone_add(struct acpi_device *,
+				struct thermal_zone_device_ops *override_ops);
+void int340x_thermal_zone_remove(struct int34x_thermal_zone *);
+
+static inline void int340x_thermal_zone_set_priv_data(
+			struct int34x_thermal_zone *tzone, void *priv_data)
+{
+	tzone->priv_data = priv_data;
+}
+
+static inline void *int340x_thermal_zone_get_priv_data(
+			struct int34x_thermal_zone *tzone)
+{
+	return tzone->priv_data;
+}
+
+static inline void int340x_thermal_zone_device_update(
+			struct int34x_thermal_zone *tzone)
+{
+	thermal_zone_device_update(tzone->zone);
+}
+
+#endif
-- 
1.9.3


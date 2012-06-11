From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 8/12] thermal: rename
 thermal_zone_device.cooling_devices to thermal_zone_device.instances
Date: Mon, 11 Jun 2012 11:20:26 +0800
Message-ID: <1339384826.1492.162.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, eduardo <eduardo.valentin@ti.com>, "R, Durgadoss" <durgadoss.r@intel.com>, "Len, Brown" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org


Rename
thermal_zone_device.cooling_devices to thermal_zone_device.instances.

thermal_zone_device.cooling_devices is not accurate
as this is a list for thermal instances, rather than cooling devices.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   18 +++++++++---------
 include/linux/thermal.h       |    4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

Index: rtd3/drivers/thermal/thermal_sys.c
===================================================================
--- rtd3.orig/drivers/thermal/thermal_sys.c
+++ rtd3/drivers/thermal/thermal_sys.c
@@ -704,7 +704,7 @@ static void thermal_zone_device_passive(
 
 		/* Heating up? */
 		if (trend > 0) {
-			list_for_each_entry(instance, &tz->cooling_devices,
+			list_for_each_entry(instance, &tz->instances,
 					    node) {
 				if (instance->trip != trip)
 					continue;
@@ -715,7 +715,7 @@ static void thermal_zone_device_passive(
 					cdev->ops->set_cur_state(cdev, state);
 			}
 		} else if (trend < 0) { /* Cooling off? */
-			list_for_each_entry(instance, &tz->cooling_devices,
+			list_for_each_entry(instance, &tz->instances,
 					    node) {
 				if (instance->trip != trip)
 					continue;
@@ -736,7 +736,7 @@ static void thermal_zone_device_passive(
 	 * and avoid thrashing around the passive trip point.  Note that we
 	 * assume symmetry.
 	 */
-	list_for_each_entry(instance, &tz->cooling_devices, node) {
+	list_for_each_entry(instance, &tz->instances, node) {
 		if (instance->trip != trip)
 			continue;
 		cdev = instance->cdev;
@@ -833,13 +833,13 @@ int thermal_zone_bind_cooling_device(str
 		goto remove_symbol_link;
 
 	mutex_lock(&tz->lock);
-	list_for_each_entry(pos, &tz->cooling_devices, node)
+	list_for_each_entry(pos, &tz->instances, node)
 	    if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 		result = -EEXIST;
 		break;
 	}
 	if (!result)
-		list_add_tail(&dev->node, &tz->cooling_devices);
+		list_add_tail(&dev->node, &tz->instances);
 	mutex_unlock(&tz->lock);
 
 	if (!result)
@@ -872,7 +872,7 @@ int thermal_zone_unbind_cooling_device(s
 	struct thermal_instance *pos, *next;
 
 	mutex_lock(&tz->lock);
-	list_for_each_entry_safe(pos, next, &tz->cooling_devices, node) {
+	list_for_each_entry_safe(pos, next, &tz->instances, node) {
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->node);
 			mutex_unlock(&tz->lock);
@@ -1066,7 +1066,7 @@ static void thermal_zone_trip_update(str
 	if (temp >= trip_temp) {
 		thermal_get_trend(tz, trip, &trend);
 
-		list_for_each_entry(instance, &tz->cooling_devices, node) {
+		list_for_each_entry(instance, &tz->instances, node) {
 			if (instance->trip != trip)
 				continue;
 
@@ -1085,7 +1085,7 @@ static void thermal_zone_trip_update(str
 			cdev->ops->set_cur_state(cdev, cur_state);
 		}
 	} else {	/* below trip */
-		list_for_each_entry(instance, &tz->cooling_devices, node) {
+		list_for_each_entry(instance, &tz->instances, node) {
 			if (instance->trip != trip)
 				continue;
 
@@ -1210,7 +1210,7 @@ struct thermal_zone_device *thermal_zone
 	if (!tz)
 		return ERR_PTR(-ENOMEM);
 
-	INIT_LIST_HEAD(&tz->cooling_devices);
+	INIT_LIST_HEAD(&tz->instances);
 	idr_init(&tz->idr);
 	mutex_init(&tz->lock);
 	result = get_idr(&thermal_tz_idr, &thermal_idr_lock, &tz->id);
Index: rtd3/include/linux/thermal.h
===================================================================
--- rtd3.orig/include/linux/thermal.h
+++ rtd3/include/linux/thermal.h
@@ -106,9 +106,9 @@ struct thermal_zone_device {
 	bool passive;
 	unsigned int forced_passive;
 	const struct thermal_zone_device_ops *ops;
-	struct list_head cooling_devices;
+	struct list_head instances;
 	struct idr idr;
-	struct mutex lock;	/* protect cooling devices list */
+	struct mutex lock;	/* protect instances list */
 	struct list_head node;
 	struct delayed_work poll_queue;
 };



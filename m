From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 9/12] thermal: rename thermal_instance.node to
 thermal_instance.tz_node
Date: Mon, 11 Jun 2012 11:20:30 +0800
Message-ID: <1339384830.1492.163.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, "R, Durgadoss" <durgadoss.r@intel.com>, eduardo <eduardo.valentin@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Garrett <mjg59@srcf.ucam.org>, "Len, Brown" <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org


Rename thermal_instance.node to thermal_instance.tz_node.

thermal_instance should be referenced by both thermal zone devices
and thermal cooling devices.

Rename thermal_instance.node to thermal_instance.tz_node in this patch
and thermal_instanace.cdev_node will be introduced in next patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: rtd3/drivers/thermal/thermal_sys.c
===================================================================
--- rtd3.orig/drivers/thermal/thermal_sys.c
+++ rtd3/drivers/thermal/thermal_sys.c
@@ -56,7 +56,7 @@ struct thermal_instance {
 	unsigned long lower;	/* Lowest cooling state for this trip point */
 	char attr_name[THERMAL_NAME_LENGTH];
 	struct device_attribute attr;
-	struct list_head node;
+	struct list_head tz_node; /* node in tz->instances */
 };
 
 static DEFINE_IDR(thermal_tz_idr);
@@ -705,7 +705,7 @@ static void thermal_zone_device_passive(
 		/* Heating up? */
 		if (trend > 0) {
 			list_for_each_entry(instance, &tz->instances,
-					    node) {
+					    tz_node) {
 				if (instance->trip != trip)
 					continue;
 				cdev = instance->cdev;
@@ -716,7 +716,7 @@ static void thermal_zone_device_passive(
 			}
 		} else if (trend < 0) { /* Cooling off? */
 			list_for_each_entry(instance, &tz->instances,
-					    node) {
+					    tz_node) {
 				if (instance->trip != trip)
 					continue;
 				cdev = instance->cdev;
@@ -736,7 +736,7 @@ static void thermal_zone_device_passive(
 	 * and avoid thrashing around the passive trip point.  Note that we
 	 * assume symmetry.
 	 */
-	list_for_each_entry(instance, &tz->instances, node) {
+	list_for_each_entry(instance, &tz->instances, tz_node) {
 		if (instance->trip != trip)
 			continue;
 		cdev = instance->cdev;
@@ -832,13 +832,13 @@ int thermal_zone_bind_cooling_device(str
 		goto remove_symbol_link;
 
 	mutex_lock(&tz->lock);
-	list_for_each_entry(pos, &tz->instances, node)
+	list_for_each_entry(pos, &tz->instances, tz_node)
 	    if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 		result = -EEXIST;
 		break;
 	}
 	if (!result)
-		list_add_tail(&dev->node, &tz->instances);
+		list_add_tail(&dev->tz_node, &tz->instances);
 	mutex_unlock(&tz->lock);
 
 	if (!result)
@@ -871,9 +871,9 @@ int thermal_zone_unbind_cooling_device(s
 	struct thermal_instance *pos, *next;
 
 	mutex_lock(&tz->lock);
-	list_for_each_entry_safe(pos, next, &tz->instances, node) {
+	list_for_each_entry_safe(pos, next, &tz->instances, tz_node) {
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
-			list_del(&pos->node);
+			list_del(&pos->tz_node);
 			mutex_unlock(&tz->lock);
 			goto unbind;
 		}
@@ -1065,7 +1065,7 @@ static void thermal_zone_trip_update(str
 	if (temp >= trip_temp) {
 		thermal_get_trend(tz, trip, &trend);
 
-		list_for_each_entry(instance, &tz->instances, node) {
+		list_for_each_entry(instance, &tz->instances, tz_node) {
 			if (instance->trip != trip)
 				continue;
 
@@ -1084,7 +1084,7 @@ static void thermal_zone_trip_update(str
 			cdev->ops->set_cur_state(cdev, cur_state);
 		}
 	} else {	/* below trip */
-		list_for_each_entry(instance, &tz->instances, node) {
+		list_for_each_entry(instance, &tz->instances, tz_node) {
 			if (instance->trip != trip)
 				continue;
 



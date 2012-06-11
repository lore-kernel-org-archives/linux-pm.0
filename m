From: Zhang Rui <rui.zhang@intel.com>
Subject: [ RFC PATCH 2/12] thermal: Introduce cooling states
 range support for a certain trip point
Date: Mon, 11 Jun 2012 11:19:53 +0800
Message-ID: <1339384793.1492.155.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


Introduce cooling states range support for a certain trip point.

As the active cooling devices can have multiple cooling states,
we may want only several cooling states for a certain trip point,
and other cooling states for other active trip points.

To do this, we should be able to describe the cooling device
behavior for a certain trip point, rather than for the entire thermal zone.
And when updating thermal zone, we need to check the upper and lower limit
to make sure the cooling device is set to the proper cooling state.

Note that this patch will not bring any different behavior as
upper limit is set to max_state and lower limit is set to 0
in this patch, for now.

Next patch will set these to real values.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

Index: rtd3/drivers/thermal/thermal_sys.c
===================================================================
--- rtd3.orig/drivers/thermal/thermal_sys.c
+++ rtd3/drivers/thermal/thermal_sys.c
@@ -41,12 +41,19 @@ MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
 MODULE_LICENSE("GPL");
 
+/*
+ * This structure is used to describe the behavior of
+ * a certain cooling device on a certain trip point
+ * in a certain thermal zone
+ */
 struct thermal_cooling_device_instance {
 	int id;
 	char name[THERMAL_NAME_LENGTH];
 	struct thermal_zone_device *tz;
 	struct thermal_cooling_device *cdev;
 	int trip;
+	unsigned long upper;	/* Highest cooling state for this trip point */
+	unsigned long lower;	/* Lowest cooling state for this trip point */
 	char attr_name[THERMAL_NAME_LENGTH];
 	struct device_attribute attr;
 	struct list_head node;
@@ -759,6 +766,7 @@ int thermal_zone_bind_cooling_device(str
 	struct thermal_cooling_device_instance *pos;
 	struct thermal_zone_device *pos1;
 	struct thermal_cooling_device *pos2;
+	unsigned long max_state;
 	int result;
 
 	if (trip >= tz->trips || (trip < 0 && trip != THERMAL_TRIPS_NONE))
@@ -783,6 +791,11 @@ int thermal_zone_bind_cooling_device(str
 	dev->tz = tz;
 	dev->cdev = cdev;
 	dev->trip = trip;
+
+	cdev->ops->get_max_state(dev, &max_state);
+	dev->upper = max_state;
+	dev->lower = 0;
+
 	result = get_idr(&tz->idr, &tz->lock, &dev->id);
 	if (result)
 		goto free_mem;
@@ -1062,11 +1075,15 @@ void thermal_zone_device_update(struct t
 				cdev->ops->get_max_state(cdev, &max_state);
 
 				if (temp >= trip_temp)
-					cur_state = cur_state < max_state ?
-						(cur_state + 1) : max_state;
+					cur_state =
+						cur_state < instance->upper ?
+						(cur_state + 1) :
+						instance->upper;
 				else
-					cur_state = cur_state > 0 ?
-						(cur_state - 1) : 0;
+					cur_state =
+						cur_state > instance->lower ?
+						(cur_state - 1) :
+						instance->lower;
 
 				cdev->ops->set_cur_state(cdev, cur_state);
 			}

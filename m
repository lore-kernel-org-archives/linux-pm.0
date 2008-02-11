From: "Thomas, Sujith" <sujith.thomas@intel.com>
Subject: [Bug-fix]:2.6.25-rc0 Generic thermal management [Patch
	1/2]: validating input parameters
Date: Mon, 11 Feb 2008 15:57:06 +0530
Message-ID: <05B550FD4BD2014E841D83547B62600802A3A1B0__17367.7994207994$1202726629$gmane$org@bgsmsx411.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Thomas Sujith <sujith.thomas@intel.com>

Added sanity checks for interface functions in thermal with
other modules such as fan, processor, video etc..

Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
---
drivers/thermal/thermal.c |   69
+++++++++++++++++++++++++++++-----------------
 1 files changed, 44 insertions(+), 25 deletions(-)

Index: linux-2.6.24-rc3/drivers/thermal/thermal.c
===================================================================
--- linux-2.6.24-rc3.orig/drivers/thermal/thermal.c
+++ linux-2.6.24-rc3/drivers/thermal/thermal.c
@@ -301,13 +301,27 @@ int thermal_zone_bind_cooling_device(str
 {
 	struct thermal_cooling_device_instance *dev;
 	struct thermal_cooling_device_instance *pos;
+	struct thermal_zone_device *pos1;
+	struct thermal_cooling_device *pos2;
 	int result;
 
+	if (!tz || !cdev)
+		return -EINVAL;
+
 	if (trip >= tz->trips ||
 	    (trip < 0 && trip != THERMAL_TRIPS_NONE))
 		return -EINVAL;
 
-	if (!tz || !cdev)
+	list_for_each_entry(pos1, &thermal_tz_list, node) {
+		if (pos1 == tz)
+			break;
+	}
+	list_for_each_entry(pos2, &thermal_cdev_list, node) {
+		if (pos2 == cdev)
+			break;
+	}
+
+	if (tz != pos1 || cdev != pos2)
 		return -EINVAL;
 
 	dev =
@@ -373,6 +387,9 @@ int thermal_zone_unbind_cooling_device(s
 {
 	struct thermal_cooling_device_instance *pos, *next;
 
+	if (!tz || !cdev)
+		return -EINVAL;
+
 	mutex_lock(&tz->lock);
 	list_for_each_entry_safe(pos, next, &tz->cooling_devices, node)
{
 		if (pos->tz == tz && pos->trip == trip
@@ -427,21 +444,24 @@ struct thermal_cooling_device *thermal_c
 	struct thermal_zone_device *pos;
 	int result;
 
+	if (!type)
+		return ERR_PTR(-EINVAL);
+
 	if (strlen(type) >= THERMAL_NAME_LENGTH)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	if (!ops || !ops->get_max_state || !ops->get_cur_state ||
 		!ops->set_cur_state)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	cdev = kzalloc(sizeof(struct thermal_cooling_device),
GFP_KERNEL);
 	if (!cdev)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	result = get_idr(&thermal_cdev_idr, &thermal_idr_lock,
&cdev->id);
 	if (result) {
 		kfree(cdev);
-		return NULL;
+		return ERR_PTR(result);
 	}
 
 	strcpy(cdev->type, type);
@@ -453,16 +473,14 @@ struct thermal_cooling_device *thermal_c
 	if (result) {
 		release_idr(&thermal_cdev_idr, &thermal_idr_lock,
cdev->id);
 		kfree(cdev);
-		return NULL;
+		return 	ERR_PTR(result);
 	}
 
 	/* sys I/F */
-	if (type) {
-		result = device_create_file(&cdev->device,
-					    &dev_attr_cdev_type);
-		if (result)
-			goto unregister;
-	}
+	result = device_create_file(&cdev->device,
+				    &dev_attr_cdev_type);
+	if (result)
+		goto unregister;
 
 	result = device_create_file(&cdev->device, &dev_attr_max_state);
 	if (result)
@@ -490,7 +508,7 @@ struct thermal_cooling_device *thermal_c
       unregister:
 	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
 	device_unregister(&cdev->device);
-	return NULL;
+	return ERR_PTR(result);
 }
 EXPORT_SYMBOL(thermal_cooling_device_register);
 
@@ -559,18 +577,21 @@ struct thermal_zone_device *thermal_zone
 	int result;
 	int count;
 
+	if (!type)
+		return ERR_PTR(-EINVAL);
+
 	if (strlen(type) >= THERMAL_NAME_LENGTH)
-		return NULL;
+		return  ERR_PTR(-EINVAL);
 
 	if (trips > THERMAL_MAX_TRIPS || trips < 0)
-		return NULL;
+		return  ERR_PTR(-EINVAL);
 
 	if (!ops || !ops->get_temp)
-		return NULL;
+		return  ERR_PTR(-EINVAL);
 
 	tz = kzalloc(sizeof(struct thermal_zone_device), GFP_KERNEL);
 	if (!tz)
-		return NULL;
+		return  ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&tz->cooling_devices);
 	idr_init(&tz->idr);
@@ -578,7 +599,7 @@ struct thermal_zone_device *thermal_zone
 	result = get_idr(&thermal_tz_idr, &thermal_idr_lock, &tz->id);
 	if (result) {
 		kfree(tz);
-		return NULL;
+		return  ERR_PTR(result);
 	}
 
 	strcpy(tz->type, type);
@@ -591,15 +612,13 @@ struct thermal_zone_device *thermal_zone
 	if (result) {
 		release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 		kfree(tz);
-		return NULL;
+		return  ERR_PTR(result);
 	}
 
 	/* sys I/F */
-	if (type) {
-		result = device_create_file(&tz->device,
&dev_attr_type);
-		if (result)
-			goto unregister;
-	}
+	result = device_create_file(&tz->device, &dev_attr_type);
+	if (result)
+		goto unregister;
 
 	result = device_create_file(&tz->device, &dev_attr_temp);
 	if (result)
@@ -633,7 +652,7 @@ struct thermal_zone_device *thermal_zone
       unregister:
 	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
 	device_unregister(&tz->device);
-	return NULL;
+	return ERR_PTR(result);
 }
 EXPORT_SYMBOL(thermal_zone_device_register);

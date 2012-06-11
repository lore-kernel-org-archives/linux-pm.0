From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 10/12] thermal: reference thermal instances in
 thermal_cooling_device
Date: Mon, 11 Jun 2012 11:20:34 +0800
Message-ID: <1339384834.1492.164.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-pm <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: Amit Kachhap <amit.kachhap@linaro.org>, eduardo <eduardo.valentin@ti.com>, "R, Durgadoss" <durgadoss.r@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Len, Brown" <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org


reference thermal instances in thermal_cooling_device.

so that cooling device can know the cooling state requirement
of all the thermal instances.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sys.c |    7 ++++++-
 include/linux/thermal.h       |    1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

Index: rtd3/include/linux/thermal.h
===================================================================
--- rtd3.orig/include/linux/thermal.h
+++ rtd3/include/linux/thermal.h
@@ -86,6 +86,7 @@ struct thermal_cooling_device {
 	struct device device;
 	void *devdata;
 	const struct thermal_cooling_device_ops *ops;
+	struct list_head instances;
 	struct list_head node;
 };
 
Index: rtd3/drivers/thermal/thermal_sys.c
===================================================================
--- rtd3.orig/drivers/thermal/thermal_sys.c
+++ rtd3/drivers/thermal/thermal_sys.c
@@ -57,6 +57,7 @@ struct thermal_instance {
 	char attr_name[THERMAL_NAME_LENGTH];
 	struct device_attribute attr;
 	struct list_head tz_node; /* node in tz->instances */
+	struct list_head cdev_node; /* node in cdev->instances */
 };
 
 static DEFINE_IDR(thermal_tz_idr);
@@ -837,8 +838,10 @@ int thermal_zone_bind_cooling_device(str
 		result = -EEXIST;
 		break;
 	}
-	if (!result)
+	if (!result) {
 		list_add_tail(&dev->tz_node, &tz->instances);
+		list_add_tail(&dev->cdev_node, &cdev->instances);
+	}
 	mutex_unlock(&tz->lock);
 
 	if (!result)
@@ -874,6 +877,7 @@ int thermal_zone_unbind_cooling_device(s
 	list_for_each_entry_safe(pos, next, &tz->instances, tz_node) {
 		if (pos->tz == tz && pos->trip == trip && pos->cdev == cdev) {
 			list_del(&pos->tz_node);
+			list_del(&pos->cdev_node);
 			mutex_unlock(&tz->lock);
 			goto unbind;
 		}
@@ -943,6 +947,7 @@ thermal_cooling_device_register(char *ty
 	}
 
 	strcpy(cdev->type, type);
+	INIT_LIST_HEAD(&cdev->instances);
 	cdev->ops = ops;
 	cdev->device.class = &thermal_class;
 	cdev->devdata = devdata;



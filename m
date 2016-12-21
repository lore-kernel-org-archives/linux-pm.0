From: Matthew Wilcox <mawilcox@linuxonhyperv.com>
Subject: [PATCH 1/4] thermal core: convert ID allocation to IDA
Date: Wed, 21 Dec 2016 09:47:03 -0800
Message-ID: <1482342426-30520-2-git-send-email-mawilcox@linuxonhyperv.com>
References: <1482342426-30520-1-git-send-email-mawilcox@linuxonhyperv.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from p3plsmtps2ded01.prod.phx3.secureserver.net ([208.109.80.58]:60880
        "EHLO p3plsmtps2ded01.prod.phx3.secureserver.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933692AbcLUPvG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Dec 2016 10:51:06 -0500
In-Reply-To: <1482342426-30520-1-git-send-email-mawilcox@linuxonhyperv.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-pm@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

The thermal core does not use the ability to look up pointers by ID, so
convert it from using an IDR to the more space-efficient IDA.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/thermal/thermal_core.c | 75 +++++++++++++++---------------------------
 include/linux/thermal.h        |  4 +--
 2 files changed, 28 insertions(+), 51 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 641faab6e24b..f2a0cd119e22 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -36,9 +36,8 @@ MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
 MODULE_LICENSE("GPL v2");
 
-static DEFINE_IDR(thermal_tz_idr);
-static DEFINE_IDR(thermal_cdev_idr);
-static DEFINE_MUTEX(thermal_idr_lock);
+static DEFINE_IDA(thermal_tz_ida);
+static DEFINE_IDA(thermal_cdev_ida);
 
 static LIST_HEAD(thermal_tz_list);
 static LIST_HEAD(thermal_cdev_list);
@@ -589,29 +588,6 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
  * - thermal zone devices lifecycle: registration, unregistration,
  *				     binding, and unbinding.
  */
-static int get_idr(struct idr *idr, struct mutex *lock, int *id)
-{
-	int ret;
-
-	if (lock)
-		mutex_lock(lock);
-	ret = idr_alloc(idr, NULL, 0, 0, GFP_KERNEL);
-	if (lock)
-		mutex_unlock(lock);
-	if (unlikely(ret < 0))
-		return ret;
-	*id = ret;
-	return 0;
-}
-
-static void release_idr(struct idr *idr, struct mutex *lock, int id)
-{
-	if (lock)
-		mutex_lock(lock);
-	idr_remove(idr, id);
-	if (lock)
-		mutex_unlock(lock);
-}
 
 /**
  * thermal_zone_bind_cooling_device() - bind a cooling device to a thermal zone
@@ -685,15 +661,16 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	dev->target = THERMAL_NO_TARGET;
 	dev->weight = weight;
 
-	result = get_idr(&tz->idr, &tz->lock, &dev->id);
-	if (result)
+	result = ida_simple_get(&tz->ida, 0, 0, GFP_KERNEL);
+	if (result < 0)
 		goto free_mem;
 
+	dev->id = result;
 	sprintf(dev->name, "cdev%d", dev->id);
 	result =
 	    sysfs_create_link(&tz->device.kobj, &cdev->device.kobj, dev->name);
 	if (result)
-		goto release_idr;
+		goto release_ida;
 
 	sprintf(dev->attr_name, "cdev%d_trip_point", dev->id);
 	sysfs_attr_init(&dev->attr.attr);
@@ -737,8 +714,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	device_remove_file(&tz->device, &dev->attr);
 remove_symbol_link:
 	sysfs_remove_link(&tz->device.kobj, dev->name);
-release_idr:
-	release_idr(&tz->idr, &tz->lock, dev->id);
+release_ida:
+	ida_simple_remove(&tz->ida, dev->id);
 free_mem:
 	kfree(dev);
 	return result;
@@ -785,7 +762,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 	device_remove_file(&tz->device, &pos->weight_attr);
 	device_remove_file(&tz->device, &pos->attr);
 	sysfs_remove_link(&tz->device.kobj, pos->name);
-	release_idr(&tz->idr, &tz->lock, pos->id);
+	ida_simple_remove(&tz->ida, pos->id);
 	kfree(pos);
 	return 0;
 }
@@ -920,12 +897,13 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
-	result = get_idr(&thermal_cdev_idr, &thermal_idr_lock, &cdev->id);
-	if (result) {
+	result = ida_simple_get(&thermal_cdev_ida, 0, 0, GFP_KERNEL);
+	if (result < 0) {
 		kfree(cdev);
 		return ERR_PTR(result);
 	}
 
+	cdev->id = result;
 	strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
 	mutex_init(&cdev->lock);
 	INIT_LIST_HEAD(&cdev->thermal_instances);
@@ -938,7 +916,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	result = device_register(&cdev->device);
 	if (result) {
-		release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
+		ida_simple_remove(&thermal_cdev_ida, cdev->id);
 		kfree(cdev);
 		return ERR_PTR(result);
 	}
@@ -1065,7 +1043,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&thermal_list_lock);
 
-	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
+	ida_simple_remove(&thermal_cdev_ida, cdev->id);
 	device_unregister(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
@@ -1167,14 +1145,15 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&tz->thermal_instances);
-	idr_init(&tz->idr);
+	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
-	result = get_idr(&thermal_tz_idr, &thermal_idr_lock, &tz->id);
-	if (result) {
+	result = ida_simple_get(&thermal_tz_ida, 0, 0, GFP_KERNEL);
+	if (result < 0) {
 		kfree(tz);
 		return ERR_PTR(result);
 	}
 
+	tz->id = result;
 	strlcpy(tz->type, type, sizeof(tz->type));
 	tz->ops = ops;
 	tz->tzp = tzp;
@@ -1196,7 +1175,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	result = device_register(&tz->device);
 	if (result) {
-		release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
+		ida_simple_remove(&thermal_tz_ida, tz->id);
 		kfree(tz);
 		return ERR_PTR(result);
 	}
@@ -1250,7 +1229,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	return tz;
 
 unregister:
-	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
+	ida_simple_remove(&thermal_tz_ida, tz->id);
 	device_unregister(&tz->device);
 	return ERR_PTR(result);
 }
@@ -1312,8 +1291,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_set_governor(tz, NULL);
 
 	thermal_remove_hwmon_sysfs(tz);
-	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
-	idr_destroy(&tz->idr);
+	ida_simple_remove(&thermal_tz_ida, tz->id);
+	ida_destroy(&tz->ida);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
 	kfree(tz->device.groups);
@@ -1514,9 +1493,8 @@ static int __init thermal_init(void)
 unregister_governors:
 	thermal_unregister_governors();
 error:
-	idr_destroy(&thermal_tz_idr);
-	idr_destroy(&thermal_cdev_idr);
-	mutex_destroy(&thermal_idr_lock);
+	ida_destroy(&thermal_tz_ida);
+	ida_destroy(&thermal_cdev_ida);
 	mutex_destroy(&thermal_list_lock);
 	mutex_destroy(&thermal_governor_lock);
 	return result;
@@ -1529,9 +1507,8 @@ static void __exit thermal_exit(void)
 	genetlink_exit();
 	class_unregister(&thermal_class);
 	thermal_unregister_governors();
-	idr_destroy(&thermal_tz_idr);
-	idr_destroy(&thermal_cdev_idr);
-	mutex_destroy(&thermal_idr_lock);
+	ida_destroy(&thermal_tz_ida);
+	ida_destroy(&thermal_cdev_ida);
 	mutex_destroy(&thermal_list_lock);
 	mutex_destroy(&thermal_governor_lock);
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e275e98bdceb..dab11f97e1c6 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -194,7 +194,7 @@ struct thermal_attr {
  * @governor:	pointer to the governor for this thermal zone
  * @governor_data:	private pointer for governor data
  * @thermal_instances:	list of &struct thermal_instance of this thermal zone
- * @idr:	&struct idr to generate unique id for this zone's cooling
+ * @ida:	&struct ida to generate unique id for this zone's cooling
  *		devices
  * @lock:	lock to protect thermal_instances list
  * @node:	node in thermal_tz_list (in thermal_core.c)
@@ -227,7 +227,7 @@ struct thermal_zone_device {
 	struct thermal_governor *governor;
 	void *governor_data;
 	struct list_head thermal_instances;
-	struct idr idr;
+	struct ida ida;
 	struct mutex lock;
 	struct list_head node;
 	struct delayed_work poll_queue;
-- 
2.11.0


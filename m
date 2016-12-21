From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 1/5] thermal: core: convert ID allocation to IDA
Date: Wed, 21 Dec 2016 10:04:11 +0800
Message-ID: <1482285855-2974-2-git-send-email-rui.zhang@intel.com>
References: <1482285855-2974-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65334 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752226AbcLUCET (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Dec 2016 21:04:19 -0500
In-Reply-To: <1482285855-2974-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Zhang Rui <rui.zhang@intel.com>

thermal core currently uses IDRs to allocate IDs, but it only needs
to know whether IDs are in use or not; the ID to pointer functionality
of the IDR is unused. That means it can use the more space-efficient IDA.

CC: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.c | 75 +++++++++++++++++++++---------------------
 include/linux/thermal.h        |  4 +--
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 641faab..1b6fde2 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -36,9 +36,9 @@ MODULE_AUTHOR("Zhang Rui");
 MODULE_DESCRIPTION("Generic thermal management sysfs support");
 MODULE_LICENSE("GPL v2");
 
-static DEFINE_IDR(thermal_tz_idr);
-static DEFINE_IDR(thermal_cdev_idr);
-static DEFINE_MUTEX(thermal_idr_lock);
+static DEFINE_IDA(thermal_tz_ida);
+static DEFINE_IDA(thermal_cdev_ida);
+static DEFINE_MUTEX(thermal_ida_lock);
 
 static LIST_HEAD(thermal_tz_list);
 static LIST_HEAD(thermal_cdev_list);
@@ -589,28 +589,29 @@ void thermal_zone_device_unbind_exception(struct thermal_zone_device *tz,
  * - thermal zone devices lifecycle: registration, unregistration,
  *				     binding, and unbinding.
  */
-static int get_idr(struct idr *idr, struct mutex *lock, int *id)
+static int get_ida(struct ida *ida, struct mutex *lock, int *id)
 {
 	int ret;
 
-	if (lock)
+	if (!ida || !lock || !id)
+		return -EINVAL;
+	do {
+		if (!ida_pre_get(ida, GFP_KERNEL))
+			return -ENOMEM;
 		mutex_lock(lock);
-	ret = idr_alloc(idr, NULL, 0, 0, GFP_KERNEL);
-	if (lock)
+		ret = ida_get_new(ida, id);
 		mutex_unlock(lock);
-	if (unlikely(ret < 0))
-		return ret;
-	*id = ret;
-	return 0;
+	} while (ret == -EAGAIN);
+	return ret;
 }
 
-static void release_idr(struct idr *idr, struct mutex *lock, int id)
+static void release_ida(struct ida *ida, struct mutex *lock, int id)
 {
-	if (lock)
-		mutex_lock(lock);
-	idr_remove(idr, id);
-	if (lock)
-		mutex_unlock(lock);
+	if (!ida || !lock)
+		return;
+	mutex_lock(lock);
+	ida_remove(ida, id);
+	mutex_unlock(lock);
 }
 
 /**
@@ -685,7 +686,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	dev->target = THERMAL_NO_TARGET;
 	dev->weight = weight;
 
-	result = get_idr(&tz->idr, &tz->lock, &dev->id);
+	result = get_ida(&tz->ida, &tz->lock, &dev->id);
 	if (result)
 		goto free_mem;
 
@@ -693,7 +694,7 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	result =
 	    sysfs_create_link(&tz->device.kobj, &cdev->device.kobj, dev->name);
 	if (result)
-		goto release_idr;
+		goto release_ida;
 
 	sprintf(dev->attr_name, "cdev%d_trip_point", dev->id);
 	sysfs_attr_init(&dev->attr.attr);
@@ -737,8 +738,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	device_remove_file(&tz->device, &dev->attr);
 remove_symbol_link:
 	sysfs_remove_link(&tz->device.kobj, dev->name);
-release_idr:
-	release_idr(&tz->idr, &tz->lock, dev->id);
+release_ida:
+	release_ida(&tz->ida, &tz->lock, dev->id);
 free_mem:
 	kfree(dev);
 	return result;
@@ -785,7 +786,7 @@ int thermal_zone_unbind_cooling_device(struct thermal_zone_device *tz,
 	device_remove_file(&tz->device, &pos->weight_attr);
 	device_remove_file(&tz->device, &pos->attr);
 	sysfs_remove_link(&tz->device.kobj, pos->name);
-	release_idr(&tz->idr, &tz->lock, pos->id);
+	release_ida(&tz->ida, &tz->lock, pos->id);
 	kfree(pos);
 	return 0;
 }
@@ -920,7 +921,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	if (!cdev)
 		return ERR_PTR(-ENOMEM);
 
-	result = get_idr(&thermal_cdev_idr, &thermal_idr_lock, &cdev->id);
+	result = get_ida(&thermal_cdev_ida, &thermal_ida_lock, &cdev->id);
 	if (result) {
 		kfree(cdev);
 		return ERR_PTR(result);
@@ -938,7 +939,7 @@ __thermal_cooling_device_register(struct device_node *np,
 	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	result = device_register(&cdev->device);
 	if (result) {
-		release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
+		release_ida(&thermal_cdev_ida, &thermal_ida_lock, cdev->id);
 		kfree(cdev);
 		return ERR_PTR(result);
 	}
@@ -1065,7 +1066,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
 
 	mutex_unlock(&thermal_list_lock);
 
-	release_idr(&thermal_cdev_idr, &thermal_idr_lock, cdev->id);
+	release_ida(&thermal_cdev_ida, &thermal_ida_lock, cdev->id);
 	device_unregister(&cdev->device);
 }
 EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
@@ -1167,9 +1168,9 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&tz->thermal_instances);
-	idr_init(&tz->idr);
+	ida_init(&tz->ida);
 	mutex_init(&tz->lock);
-	result = get_idr(&thermal_tz_idr, &thermal_idr_lock, &tz->id);
+	result = get_ida(&thermal_tz_ida, &thermal_ida_lock, &tz->id);
 	if (result) {
 		kfree(tz);
 		return ERR_PTR(result);
@@ -1196,7 +1197,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	dev_set_name(&tz->device, "thermal_zone%d", tz->id);
 	result = device_register(&tz->device);
 	if (result) {
-		release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
+		release_ida(&thermal_tz_ida, &thermal_ida_lock, tz->id);
 		kfree(tz);
 		return ERR_PTR(result);
 	}
@@ -1250,7 +1251,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
 	return tz;
 
 unregister:
-	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
+	release_ida(&thermal_tz_ida, &thermal_ida_lock, tz->id);
 	device_unregister(&tz->device);
 	return ERR_PTR(result);
 }
@@ -1312,8 +1313,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 	thermal_set_governor(tz, NULL);
 
 	thermal_remove_hwmon_sysfs(tz);
-	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
-	idr_destroy(&tz->idr);
+	release_ida(&thermal_tz_ida, &thermal_ida_lock, tz->id);
+	ida_destroy(&tz->ida);
 	mutex_destroy(&tz->lock);
 	device_unregister(&tz->device);
 	kfree(tz->device.groups);
@@ -1514,9 +1515,9 @@ static int __init thermal_init(void)
 unregister_governors:
 	thermal_unregister_governors();
 error:
-	idr_destroy(&thermal_tz_idr);
-	idr_destroy(&thermal_cdev_idr);
-	mutex_destroy(&thermal_idr_lock);
+	ida_destroy(&thermal_tz_ida);
+	ida_destroy(&thermal_cdev_ida);
+	mutex_destroy(&thermal_ida_lock);
 	mutex_destroy(&thermal_list_lock);
 	mutex_destroy(&thermal_governor_lock);
 	return result;
@@ -1529,9 +1530,9 @@ static void __exit thermal_exit(void)
 	genetlink_exit();
 	class_unregister(&thermal_class);
 	thermal_unregister_governors();
-	idr_destroy(&thermal_tz_idr);
-	idr_destroy(&thermal_cdev_idr);
-	mutex_destroy(&thermal_idr_lock);
+	ida_destroy(&thermal_tz_ida);
+	ida_destroy(&thermal_cdev_ida);
+	mutex_destroy(&thermal_ida_lock);
 	mutex_destroy(&thermal_list_lock);
 	mutex_destroy(&thermal_governor_lock);
 }
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e275e98..dab11f9 100644
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
2.7.4


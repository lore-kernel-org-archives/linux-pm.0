From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCH 3/3] drivers/base: clean up unused devices_kset_move_*() functions
Date: Mon, 20 Aug 2018 17:18:37 +0800
Message-ID: <1534756717-25553-4-git-send-email-kernelfans@gmail.com>
References: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Now, shutdown seq is unified with PM, and there is no need to maintain the
"parent <- child" or "supplier <- consumer" order in devices_kset any more,
hence removing the corresponding routines

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/base.h |  1 -
 drivers/base/core.c | 56 -----------------------------------------------------
 2 files changed, 57 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 7a419a7..fcb213b 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -133,7 +133,6 @@ extern void device_unblock_probing(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
-extern void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
 extern void module_add_driver(struct module *mod, struct device_driver *drv);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7c83384..99fdc57 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -127,13 +127,6 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
 {
 	struct device_link *link;
 
-	/*
-	 * Devices that have not been registered yet will be put to the ends
-	 * of the lists during the registration, so skip them here.
-	 */
-	if (device_is_registered(dev))
-		devices_kset_move_last(dev);
-
 	if (device_pm_initialized(dev))
 		device_pm_move_last(dev);
 
@@ -1316,52 +1309,6 @@ static DEVICE_ATTR_RO(dev);
 struct kset *devices_kset;
 
 /**
- * devices_kset_move_before - Move device in the devices_kset's list.
- * @deva: Device to move.
- * @devb: Device @deva should come before.
- */
-static void devices_kset_move_before(struct device *deva, struct device *devb)
-{
-	if (!devices_kset)
-		return;
-	pr_debug("devices_kset: Moving %s before %s\n",
-		 dev_name(deva), dev_name(devb));
-	spin_lock(&devices_kset->list_lock);
-	list_move_tail(&deva->kobj.entry, &devb->kobj.entry);
-	spin_unlock(&devices_kset->list_lock);
-}
-
-/**
- * devices_kset_move_after - Move device in the devices_kset's list.
- * @deva: Device to move
- * @devb: Device @deva should come after.
- */
-static void devices_kset_move_after(struct device *deva, struct device *devb)
-{
-	if (!devices_kset)
-		return;
-	pr_debug("devices_kset: Moving %s after %s\n",
-		 dev_name(deva), dev_name(devb));
-	spin_lock(&devices_kset->list_lock);
-	list_move(&deva->kobj.entry, &devb->kobj.entry);
-	spin_unlock(&devices_kset->list_lock);
-}
-
-/**
- * devices_kset_move_last - move the device to the end of devices_kset's list.
- * @dev: device to move
- */
-void devices_kset_move_last(struct device *dev)
-{
-	if (!devices_kset)
-		return;
-	pr_debug("devices_kset: Moving %s to end of list\n", dev_name(dev));
-	spin_lock(&devices_kset->list_lock);
-	list_move_tail(&dev->kobj.entry, &devices_kset->list);
-	spin_unlock(&devices_kset->list_lock);
-}
-
-/**
  * device_create_file - create sysfs attribute file for device.
  * @dev: device.
  * @attr: device attribute descriptor.
@@ -2834,15 +2781,12 @@ int device_move(struct device *dev, struct device *new_parent,
 		break;
 	case DPM_ORDER_DEV_AFTER_PARENT:
 		device_pm_move_after(dev, new_parent);
-		devices_kset_move_after(dev, new_parent);
 		break;
 	case DPM_ORDER_PARENT_BEFORE_DEV:
 		device_pm_move_before(new_parent, dev);
-		devices_kset_move_before(new_parent, dev);
 		break;
 	case DPM_ORDER_DEV_LAST:
 		device_pm_move_last(dev);
-		devices_kset_move_last(dev);
 		break;
 	}
 
-- 
2.7.4

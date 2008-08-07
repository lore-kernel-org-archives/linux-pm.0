From: <gregkh@suse.de>
Subject: patch
	pm-don-t-skip-device-pm-init-when-config_pm_sleep-isn-t-set-and-config_pm-is-set.patch
	added to gregkh-2.6 tree
Date: Thu, 07 Aug 2008 15:21:47 -0700
Message-ID: <12181477074191@kroah.org>
References: <Pine.LNX.4.44L0.0808071305210.2598-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0808071305210.2598-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu, gregkh@suse.de, greg@kroah.com, linux-pm@lists.linux-foundation.org, rjw@sisk.pl, romit@ti.com
List-Id: linux-pm@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    Subject: PM: don't skip device PM init when CONFIG_PM_SLEEP isn't set and CONFIG_PM is set

to my gregkh-2.6 tree.  Its filename is

    pm-don-t-skip-device-pm-init-when-config_pm_sleep-isn-t-set-and-config_pm-is-set.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From stern@rowland.harvard.edu  Thu Aug  7 15:06:36 2008
From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 7 Aug 2008 13:06:12 -0400 (EDT)
Subject: PM: don't skip device PM init when CONFIG_PM_SLEEP isn't set and CONFIG_PM is set
To: Greg KH <greg@kroah.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
Message-ID: <Pine.LNX.4.44L0.0808071305210.2598-100000@iolanthe.rowland.org>


This patch (as1124) fixes a couple of bugs in the PM core.  The new
dev->power.status field should be initialized regardless of whether
CONFIG_PM_SLEEP is enabled, and similarly dpm_sysfs_add() should be
called whenever CONFIG_PM is enabled.

The patch separates out the call to dpm_sysfs_add() from the call to
device_pm_add().  As a result device_pm_add() can no longer return an
error, so its return type is changed to void.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Tested-by: Romit Dasgupta <romit@ti.com>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/base/core.c        |    9 ++++++---
 drivers/base/power/main.c  |   13 +++----------
 drivers/base/power/power.h |    9 +++++++--
 3 files changed, 16 insertions(+), 15 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -542,6 +542,7 @@ void device_initialize(struct device *de
 	spin_lock_init(&dev->devres_lock);
 	INIT_LIST_HEAD(&dev->devres_head);
 	device_init_wakeup(dev, 0);
+	device_pm_init(dev);
 	set_dev_node(dev, -1);
 }
 
@@ -898,9 +899,10 @@ int device_add(struct device *dev)
 	error = bus_add_device(dev);
 	if (error)
 		goto BusError;
-	error = device_pm_add(dev);
+	error = dpm_sysfs_add(dev);
 	if (error)
-		goto PMError;
+		goto DPMError;
+	device_pm_add(dev);
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
 	bus_attach_device(dev);
 	if (parent)
@@ -921,7 +923,7 @@ int device_add(struct device *dev)
  Done:
 	put_device(dev);
 	return error;
- PMError:
+ DPMError:
 	bus_remove_device(dev);
  BusError:
 	if (dev->bus)
@@ -1008,6 +1010,7 @@ void device_del(struct device *dev)
 	struct class_interface *class_intf;
 
 	device_pm_remove(dev);
+	dpm_sysfs_remove(dev);
 	if (parent)
 		klist_del(&dev->knode_parent);
 	if (MAJOR(dev->devt)) {
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -67,10 +67,8 @@ void device_pm_unlock(void)
  *	device_pm_add - add a device to the list of active devices
  *	@dev:	Device to be added to the list
  */
-int device_pm_add(struct device *dev)
+void device_pm_add(struct device *dev)
 {
-	int error;
-
 	pr_debug("PM: Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus",
 		 kobject_name(&dev->kobj));
@@ -89,13 +87,9 @@ int device_pm_add(struct device *dev)
 		 */
 		WARN_ON(true);
 	}
-	error = dpm_sysfs_add(dev);
-	if (!error) {
-		dev->power.status = DPM_ON;
-		list_add_tail(&dev->power.entry, &dpm_list);
-	}
+
+	list_add_tail(&dev->power.entry, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
-	return error;
 }
 
 /**
@@ -110,7 +104,6 @@ void device_pm_remove(struct device *dev
 		 dev->bus ? dev->bus->name : "No Bus",
 		 kobject_name(&dev->kobj));
 	mutex_lock(&dpm_list_mtx);
-	dpm_sysfs_remove(dev);
 	list_del_init(&dev->power.entry);
 	mutex_unlock(&dpm_list_mtx);
 }
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -1,3 +1,8 @@
+static inline void device_pm_init(struct device *dev)
+{
+	dev->power.status = DPM_ON;
+}
+
 #ifdef CONFIG_PM_SLEEP
 
 /*
@@ -11,12 +16,12 @@ static inline struct device *to_device(s
 	return container_of(entry, struct device, power.entry);
 }
 
-extern int device_pm_add(struct device *);
+extern void device_pm_add(struct device *);
 extern void device_pm_remove(struct device *);
 
 #else /* CONFIG_PM_SLEEP */
 
-static inline int device_pm_add(struct device *dev) { return 0; }
+static inline void device_pm_add(struct device *dev) {}
 static inline void device_pm_remove(struct device *dev) {}
 
 #endif


Patches currently in gregkh-2.6 which might be from stern@rowland.harvard.edu are

usb.current/usb-add-missing-kerneldoc-line-for-needs_binding.patch
usb.current/usb-core-driver-fix-warning.patch
usb.current/usb-extend-poisoning-to-anchors.patch
usb.current/usb-fix-interface-unregistration-logic.patch
usb.current/usb-fix-usb-boot-crash-ecm_do_notify-list_add-corruption.-prev-next-should-be-next.patch
usb.current/usb-kill-urbs-permanently.patch
usb.current/usb-ohci-fix-system-hang-caused-by-earlier-patch.patch
usb.current/usb-serial-don-t-release-unregistered-minors.patch
usb.current/usb-storage-automatically-recognize-bad-residues.patch
usb.current/usb-storage-unusual_devs-entries-for-iriver-t10-and-datafab-cf-sm-reader.patch
usb.current/usb-usb-storage-quirk-around-v1.11-firmware-on-nikon-d4.patch
usb.current/usb-isp1760-don-t-be-noisy-about-short-packets.patch
usb.current/usb-ohci-make-distrust_firmware-a-quirk.patch
usb.current/usb-quirk-pll-power-down-mode.patch
usb.current/usb-update-to-documentation.patch
usb.current/usb-fix-compiler-warning-fix.patch
usb.current/usb-storage-unusual_devs-entry-for-nokia-5300.patch
driver-core.current/pm-don-t-skip-device-pm-init-when-config_pm_sleep-isn-t-set-and-config_pm-is-set.patch

From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] [PM] Fixes missing PM entries in sysfs
 without CONFIG_PM_SLEEP
Date: Mon, 4 Aug 2008 11:45:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0808041143350.3818-100000__29858.6201890886$1217864825$gmane$org@iolanthe.rowland.org>
References: <200808041724.24016.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808041724.24016.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, David Engraf <david.engraf@netcom.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 4 Aug 2008, Rafael J. Wysocki wrote:

> > Do you think we will want to make device_pm_add() return an error at 
> > some point in the future?
> 
> Well, maybe, but not any time soon. :-)

Okay, here's the updated patch.  Awaiting comments from the testers...

Alan Stern



Index: usb-2.6/drivers/base/power/power.h
===================================================================
--- usb-2.6.orig/drivers/base/power/power.h
+++ usb-2.6/drivers/base/power/power.h
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
Index: usb-2.6/drivers/base/core.c
===================================================================
--- usb-2.6.orig/drivers/base/core.c
+++ usb-2.6/drivers/base/core.c
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
 		goto PMError;
+	device_pm_add(dev);
 	kobject_uevent(&dev->kobj, KOBJ_ADD);
 	bus_attach_device(dev);
 	if (parent)
@@ -1008,6 +1010,7 @@ void device_del(struct device *dev)
 	struct class_interface *class_intf;
 
 	device_pm_remove(dev);
+	dpm_sysfs_remove(dev);
 	if (parent)
 		klist_del(&dev->knode_parent);
 	if (MAJOR(dev->devt)) {
Index: usb-2.6/drivers/base/power/main.c
===================================================================
--- usb-2.6.orig/drivers/base/power/main.c
+++ usb-2.6/drivers/base/power/main.c
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

From: Daniel Drake <dsd@gentoo.org>
Subject: [PATCH] create /sys/.../power when CONFIG_PM is set
Date: Wed,  7 Nov 2007 10:10:43 +0000 (GMT)
Message-ID: <20071107101043.2E64C9D4ECC__28164.3614791848$1194430324$gmane$org@zog.reactivated.net>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: rjw@sisk.pl
Cc: linux-hotplug-devel@lists.sourceforge.net, kay.sievers@vrfy.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, oneukum@suse.de
List-Id: linux-pm@vger.kernel.org

The CONFIG_SUSPEND changes in 2.6.23 caused a regression under certain
configuration conditions (SUSPEND=n, USB_AUTOSUSPEND=y) where all USB device
attributes in sysfs (idVendor, idProduct, ...) silently disappeared, causing
udev breakage and more.

The cause of this is that the /sys/.../power subdirectory is now only created
when CONFIG_PM_SLEEP is set, however, it should be created whenever CONFIG_PM
is set to handle the above situation. The following patch fixes the
regression.

Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux-2.6.24-rc1-git14/drivers/base/core.c
===================================================================
--- linux-2.6.24-rc1-git14.orig/drivers/base/core.c
+++ linux-2.6.24-rc1-git14/drivers/base/core.c
@@ -770,9 +770,10 @@ int device_add(struct device *dev)
 	error = device_add_attrs(dev);
 	if (error)
 		goto AttrsError;
-	error = device_pm_add(dev);
+	error = dpm_sysfs_add(dev);
 	if (error)
 		goto PMError;
+	device_pm_add(dev);
 	error = bus_add_device(dev);
 	if (error)
 		goto BusError;
@@ -797,6 +798,7 @@ int device_add(struct device *dev)
 	return error;
  BusError:
 	device_pm_remove(dev);
+	dpm_sysfs_remove(dev);
  PMError:
 	if (dev->bus)
 		blocking_notifier_call_chain(&dev->bus->bus_notifier,
Index: linux-2.6.24-rc1-git14/drivers/base/power/Makefile
===================================================================
--- linux-2.6.24-rc1-git14.orig/drivers/base/power/Makefile
+++ linux-2.6.24-rc1-git14/drivers/base/power/Makefile
@@ -1,5 +1,6 @@
 obj-y			:= shutdown.o
-obj-$(CONFIG_PM_SLEEP)	+= main.o sysfs.o
+obj-$(CONFIG_PM)	+= sysfs.o
+obj-$(CONFIG_PM_SLEEP)	+= main.o
 obj-$(CONFIG_PM_TRACE)	+= trace.o
 
 ifeq ($(CONFIG_DEBUG_DRIVER),y)
Index: linux-2.6.24-rc1-git14/drivers/base/power/power.h
===================================================================
--- linux-2.6.24-rc1-git14.orig/drivers/base/power/power.h
+++ linux-2.6.24-rc1-git14/drivers/base/power/power.h
@@ -18,9 +18,24 @@ static inline struct device * to_device(
 	return container_of(entry, struct device, power.entry);
 }
 
-extern int device_pm_add(struct device *);
+extern void device_pm_add(struct device *);
 extern void device_pm_remove(struct device *);
 
+#else /* CONFIG_PM_SLEEP */
+
+
+static inline void device_pm_add(struct device * dev)
+{
+}
+static inline void device_pm_remove(struct device * dev)
+{
+
+}
+
+#endif
+
+#ifdef CONFIG_PM
+
 /*
  * sysfs.c
  */
@@ -28,16 +43,16 @@ extern void device_pm_remove(struct devi
 extern int dpm_sysfs_add(struct device *);
 extern void dpm_sysfs_remove(struct device *);
 
-#else /* CONFIG_PM_SLEEP */
+#else /* CONFIG_PM */
 
-
-static inline int device_pm_add(struct device * dev)
+static inline int dpm_sysfs_add(struct device * dev)
 {
 	return 0;
 }
-static inline void device_pm_remove(struct device * dev)
+static inline void dpm_sysfs_remove(struct device * dev)
 {
 
 }
 
-#endif
+#endif /* CONFIG_PM */
+
Index: linux-2.6.24-rc1-git14/drivers/base/power/main.c
===================================================================
--- linux-2.6.24-rc1-git14.orig/drivers/base/power/main.c
+++ linux-2.6.24-rc1-git14/drivers/base/power/main.c
@@ -38,20 +38,14 @@ static DEFINE_MUTEX(dpm_list_mtx);
 int (*platform_enable_wakeup)(struct device *dev, int is_on);
 
 
-int device_pm_add(struct device *dev)
+void device_pm_add(struct device *dev)
 {
-	int error;
-
 	pr_debug("PM: Adding info for %s:%s\n",
 		 dev->bus ? dev->bus->name : "No Bus",
 		 kobject_name(&dev->kobj));
 	mutex_lock(&dpm_list_mtx);
 	list_add_tail(&dev->power.entry, &dpm_active);
-	error = dpm_sysfs_add(dev);
-	if (error)
-		list_del(&dev->power.entry);
 	mutex_unlock(&dpm_list_mtx);
-	return error;
 }
 
 void device_pm_remove(struct device *dev)

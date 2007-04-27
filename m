From: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: [RFC/PATCH 2/2] driver core: power management debugging
Date: Fri, 27 Apr 2007 15:25:46 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0704271525071.11149@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
To: linux-pm@lists.osdl.org
Cc: nigel@nigel.suspend2.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

From: Nigel Cunningham <nigel@nigel.suspend2.net>

Add power management related debugging into driver core. Make the
kernel complain if a device driver lacks bus and class support for
resume or if a PCI or USB driver does not have a driver specific
resume function.

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---
 drivers/base/core.c       |   13 +++++++++++++
 drivers/pci/pci-driver.c  |    6 ++++++
 drivers/usb/core/driver.c |    6 ++++++
 include/linux/device.h    |    1 +
 4 files changed, 26 insertions(+)

Index: 2.6/drivers/base/core.c
===================================================================
--- 2.6.orig/drivers/base/core.c	2007-04-27 14:42:13.000000000 +0300
+++ 2.6/drivers/base/core.c	2007-04-27 14:43:14.000000000 +0300
@@ -652,6 +652,18 @@ int device_add(struct device *dev)
 				class_intf->add_dev(dev, class_intf);
 		up(&dev->class->sem);
 	}
+
+#ifdef CONFIG_PM
+	if (!((dev->class && dev->class->resume) ||
+	      (dev->bus && (dev->bus->resume || dev->bus->resume_early))) &&
+	    !dev->pm_safe) {
+		printk(KERN_WARNING "Device driver %s lacks bus and class "
+				    "support for being resumed.\n",
+				    kobject_name(&dev->kobj));
+		dump_stack();
+	}
+#endif
+
  Done:
  	kfree(class_name);
 	put_device(dev);
@@ -989,6 +1001,7 @@ struct device *device_create(struct clas
 	dev->class = class;
 	dev->parent = parent;
 	dev->release = device_create_release;
+	dev->pm_safe = 1;
 
 	va_start(args, fmt);
 	vsnprintf(dev->bus_id, BUS_ID_SIZE, fmt, args);
Index: 2.6/drivers/pci/pci-driver.c
===================================================================
--- 2.6.orig/drivers/pci/pci-driver.c	2007-04-27 14:42:13.000000000 +0300
+++ 2.6/drivers/pci/pci-driver.c	2007-04-27 14:43:14.000000000 +0300
@@ -451,6 +451,12 @@ int __pci_register_driver(struct pci_dri
 	if (error)
 		driver_unregister(&drv->driver);
 
+#ifdef CONFIG_PM
+	if (!drv->resume)
+		printk(KERN_WARNING "PCI driver %s lacks driver specific "
+				    "resume support.\n", drv->name);
+#endif
+
 	return error;
 }
 
Index: 2.6/drivers/usb/core/driver.c
===================================================================
--- 2.6.orig/drivers/usb/core/driver.c	2007-04-27 14:42:13.000000000 +0300
+++ 2.6/drivers/usb/core/driver.c	2007-04-27 14:43:14.000000000 +0300
@@ -721,6 +721,12 @@ 	int retval = 0;
 		pr_info("%s: registered new device driver %s\n",
 			usbcore_name, new_udriver->name);
 		usbfs_update_special();
+#ifdef CONFIG_PM
+		if (!new_udriver->resume)
+			printk(KERN_WARNING "USB driver %s lacks driver "
+					    "specific resume support.\n",
+					    new_udriver->name);
+#endif
 	} else {
 		printk(KERN_ERR "%s: error %d registering device "
 			"	driver %s\n",
Index: 2.6/include/linux/device.h
===================================================================
--- 2.6.orig/include/linux/device.h	2007-04-27 14:42:13.000000000 +0300
+++ 2.6/include/linux/device.h	2007-04-27 14:43:14.000000000 +0300
@@ -401,6 +401,7 @@ struct device {
 	char	bus_id[BUS_ID_SIZE];	/* position on parent bus */
 	struct device_type	*type;
 	unsigned		is_registered:1;
+	unsigned		pm_safe:1; /* no resume function is safe */
 	struct device_attribute uevent_attr;
 	struct device_attribute *devt_attr;
 

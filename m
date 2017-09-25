From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / core: Drop legacy class suspend/resume operations
Date: Mon, 25 Sep 2017 14:56:44 +0200
Message-ID: <6823681.sfkuFdUyaG@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There are no classes using the legacy suspend/resume operations in
the tree any more, so drop these operations and update the code
referring to them accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   32 +++++++++-----------------------
 include/linux/device.h    |    5 -----
 2 files changed, 9 insertions(+), 28 deletions(-)

Index: linux-pm/include/linux/device.h
===================================================================
--- linux-pm.orig/include/linux/device.h
+++ linux-pm/include/linux/device.h
@@ -372,9 +372,6 @@ int subsys_virtual_register(struct bus_t
  * @devnode:	Callback to provide the devtmpfs.
  * @class_release: Called to release this class.
  * @dev_release: Called to release the device.
- * @suspend:	Used to put the device to sleep mode, usually to a low power
- *		state.
- * @resume:	Used to bring the device from the sleep mode.
  * @shutdown_pre: Called at shut-down time before driver shutdown.
  * @ns_type:	Callbacks so sysfs can detemine namespaces.
  * @namespace:	Namespace of the device belongs to this class.
@@ -402,8 +399,6 @@ struct class {
 	void (*class_release)(struct class *class);
 	void (*dev_release)(struct device *dev);
 
-	int (*suspend)(struct device *dev, pm_message_t state);
-	int (*resume)(struct device *dev);
 	int (*shutdown_pre)(struct device *dev);
 
 	const struct kobj_ns_type_operations *ns_type;
Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -848,16 +848,10 @@ static int device_resume(struct device *
 		goto Driver;
 	}
 
-	if (dev->class) {
-		if (dev->class->pm) {
-			info = "class ";
-			callback = pm_op(dev->class->pm, state);
-			goto Driver;
-		} else if (dev->class->resume) {
-			info = "legacy class ";
-			callback = dev->class->resume;
-			goto End;
-		}
+	if (dev->class && dev->class->pm) {
+		info = "class ";
+		callback = pm_op(dev->class->pm, state);
+		goto Driver;
 	}
 
 	if (dev->bus) {
@@ -1508,17 +1502,10 @@ static int __device_suspend(struct devic
 		goto Run;
 	}
 
-	if (dev->class) {
-		if (dev->class->pm) {
-			info = "class ";
-			callback = pm_op(dev->class->pm, state);
-			goto Run;
-		} else if (dev->class->suspend) {
-			pm_dev_dbg(dev, state, "legacy class ");
-			error = legacy_suspend(dev, state, dev->class->suspend,
-						"legacy class ");
-			goto End;
-		}
+	if (dev->class && dev->class->pm) {
+		info = "class ";
+		callback = pm_op(dev->class->pm, state);
+		goto Run;
 	}
 
 	if (dev->bus) {
@@ -1862,8 +1849,7 @@ void device_pm_check_callbacks(struct de
 	dev->power.no_pm_callbacks =
 		(!dev->bus || (pm_ops_is_empty(dev->bus->pm) &&
 		 !dev->bus->suspend && !dev->bus->resume)) &&
-		(!dev->class || (pm_ops_is_empty(dev->class->pm) &&
-		 !dev->class->suspend && !dev->class->resume)) &&
+		(!dev->class || pm_ops_is_empty(dev->class->pm)) &&
 		(!dev->type || pm_ops_is_empty(dev->type->pm)) &&
 		(!dev->pm_domain || pm_ops_is_empty(&dev->pm_domain->ops)) &&
 		(!dev->driver || (pm_ops_is_empty(dev->driver->pm) &&

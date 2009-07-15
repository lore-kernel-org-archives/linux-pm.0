From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 3/8] hook device async mechanism in device core
Date: Wed, 15 Jul 2009 15:38:37 +0800
Message-ID: <1247643517.26272.78.camel__16888.5412662805$1247643814$gmane$org@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, "Van De Ven,
	Arjan" <arjan.van.de.ven@intel.com>
List-Id: linux-pm@vger.kernel.org


Hook the device async mechanism in driver core.
A device inherits its parent's async domain when it's created.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/base/async_dev.c |   22 ++++++++++++++++++----
 drivers/base/core.c      |    9 +++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/base/core.c
===================================================================
--- linux-2.6.orig/drivers/base/core.c
+++ linux-2.6/drivers/base/core.c
@@ -899,6 +899,13 @@ int device_add(struct device *dev)
 	if (parent)
 		set_dev_node(dev, dev_to_node(parent));
 
+	/* inherit parent's async domain */
+	if (parent && parent->dev_async)
+		if (!dev->dev_async)
+			dev->dev_async = parent->dev_async;
+		else
+			dev_err(dev, "multiple dev async actions registered\n");
+
 	/* first, register with generic layer. */
 	/* we require the name to be set before, and pass NULL */
 	error = kobject_add(&dev->kobj, dev->kobj.parent, NULL);
@@ -984,6 +991,7 @@ done:
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);
  Error:
+	dev->dev_async = NULL;
 	cleanup_device_parent(dev);
 	if (parent)
 		put_device(parent);
@@ -1100,6 +1108,7 @@ void device_del(struct device *dev)
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
+	dev->dev_async = NULL;
 	cleanup_device_parent(dev);
 	kobject_del(&dev->kobj);
 	put_device(parent);
Index: linux-2.6/drivers/base/async_dev.c
===================================================================
--- linux-2.6.orig/drivers/base/async_dev.c
+++ linux-2.6/drivers/base/async_dev.c
@@ -105,6 +105,13 @@ void dev_async_synchronization(void)
 	return;
 }
 
+static int dev_match(struct device *dev, void *data)
+{
+	dev_err(dev->parent, "Child device %s is registered before "
+		"dev->dev_async being initialized", dev_name(dev));
+	return 1;
+}
+
 /**
  * device_async_register - register a device that supports async actions
  * @dev: Device.
@@ -123,12 +130,19 @@ int dev_async_register(struct device *de
 		return -EINVAL;
 
 	if (dev->dev_async) {
-		if (dev->dev_async->dev == dev) {
-			printk(KERN_ERR "device already registered\n");
-			return -EEXIST;
-		}
+		/* multiple async domains for a single device not supported */
+		dev_err(dev, "async domain already registered\n");
+		return -EEXIST;
 	}
 
+	/*
+	 * dev_async_register must be called before any of its child devices
+	 * being registered to the driver model.
+	 */
+	if (dev->p)
+		if (device_find_child(dev, NULL, dev_match))
+			return -EINVAL;
+
 	if (!(DEV_ASYNC_ACTIONS_ALL & type))
 	/* check for unsupported async actions */
 		return -EINVAL;

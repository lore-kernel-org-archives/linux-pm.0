From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [driver-core PATCH v4 4/6] driver core: Probe devices
 asynchronously instead of the driver
Date: Mon, 15 Oct 2018 08:09:26 -0700
Message-ID: <20181015150926.29520.45280.stgit@localhost.localdomain>
References: <20181015150305.29520.86363.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015150305.29520.86363.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc: len.brown@intel.com, rafael@kernel.org, linux-pm@vger.kernel.org, jiangshanlai@gmail.com, pavel@ucw.cz, zwisler@kernel.org, tj@kernel.org, akpm@linux-foundation.org, alexander.h.duyck@linux.intel.com
List-Id: linux-pm@vger.kernel.org

This change makes it so that we probe devices asynchronously instead of the
driver. This results in us seeing the same behavior if the device is
registered before the driver or after. This way we can avoid serializing
the initialization should the driver not be loaded until after the devices
have already been added.

The motivation behind this is that if we have a set of devices that
take a significant amount of time to load we can greatly reduce the time to
load by processing them in parallel instead of one at a time. In addition,
each device can exist on a different node so placing a single thread on one
CPU to initialize all of the devices for a given driver can result in poor
performance on a system with multiple nodes.

I am using the driver_data member of the device struct to store the driver
pointer while we wait on the deferred probe call. This should be safe to do
as the value will either be set to NULL on a failed probe or driver load
followed by unload, or the driver value itself will be set on a successful
driver load.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/base/bus.c     |   23 +++--------------------
 drivers/base/dd.c      |   45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |    4 +++-
 3 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 8a630f9bd880..0cd2eadd0816 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -606,17 +606,6 @@ static ssize_t uevent_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(uevent);
 
-static void driver_attach_async(void *_drv, async_cookie_t cookie)
-{
-	struct device_driver *drv = _drv;
-	int ret;
-
-	ret = driver_attach(drv);
-
-	pr_debug("bus: '%s': driver %s async attach completed: %d\n",
-		 drv->bus->name, drv->name, ret);
-}
-
 /**
  * bus_add_driver - Add a driver to the bus.
  * @drv: driver.
@@ -649,15 +638,9 @@ int bus_add_driver(struct device_driver *drv)
 
 	klist_add_tail(&priv->knode_bus, &bus->p->klist_drivers);
 	if (drv->bus->p->drivers_autoprobe) {
-		if (driver_allows_async_probing(drv)) {
-			pr_debug("bus: '%s': probing driver %s asynchronously\n",
-				drv->bus->name, drv->name);
-			async_schedule(driver_attach_async, drv);
-		} else {
-			error = driver_attach(drv);
-			if (error)
-				goto out_unregister;
-		}
+		error = driver_attach(drv);
+		if (error)
+			goto out_unregister;
 	}
 	module_add_driver(drv->owner, drv);
 
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e845cd2a87af..c33f893ec9d8 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -802,6 +802,7 @@ static int __device_attach(struct device *dev, bool allow_async)
 			ret = 1;
 		else {
 			dev->driver = NULL;
+			dev_set_drvdata(dev, NULL);
 			ret = 0;
 		}
 	} else {
@@ -918,6 +919,31 @@ int device_driver_attach(struct device_driver *drv, struct device *dev)
 	return ret;
 }
 
+static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
+{
+	struct device *dev = _dev;
+
+	__device_driver_lock(dev, dev->parent);
+
+	/*
+	 * If someone attempted to bind a driver either successfully or
+	 * unsuccessfully before we got here we should just skip the driver
+	 * probe call.
+	 */
+	if (!dev->driver) {
+		struct device_driver *drv = dev_get_drvdata(dev);
+
+		if (drv)
+			driver_probe_device(drv, dev);
+	}
+
+	__device_driver_unlock(dev, dev->parent);
+
+	put_device(dev);
+
+	dev_dbg(dev, "async probe completed\n");
+}
+
 static int __driver_attach(struct device *dev, void *data)
 {
 	struct device_driver *drv = data;
@@ -945,6 +971,25 @@ static int __driver_attach(struct device *dev, void *data)
 		return ret;
 	} /* ret > 0 means positive match */
 
+	if (driver_allows_async_probing(drv)) {
+		/*
+		 * Instead of probing the device synchronously we will
+		 * probe it asynchronously to allow for more parallelism.
+		 *
+		 * We only take the device lock here in order to guarantee
+		 * that the dev->driver and driver_data fields are protected
+		 */
+		dev_dbg(dev, "scheduling asynchronous probe\n");
+		device_lock(dev);
+		if (!dev->driver) {
+			get_device(dev);
+			dev_set_drvdata(dev, drv);
+			async_schedule(__driver_attach_async_helper, dev);
+		}
+		device_unlock(dev);
+		return 0;
+	}
+
 	device_driver_attach(drv, dev);
 
 	return 0;
diff --git a/include/linux/device.h b/include/linux/device.h
index 90224e75ade4..b0abb04c29dc 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -906,7 +906,9 @@ struct dev_links_info {
  * 		variants, which GPIO pins act in what additional roles, and so
  * 		on.  This shrinks the "Board Support Packages" (BSPs) and
  * 		minimizes board-specific #ifdefs in drivers.
- * @driver_data: Private pointer for driver specific info.
+ * @driver_data: Private pointer for driver specific info if driver is
+ *		non-NULL. Pointer to deferred driver to be attached if driver
+ *		is NULL.
  * @links:	Links to suppliers and consumers of this device.
  * @power:	For device power management.
  *		See Documentation/driver-api/pm/devices.rst for details.

From: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [driver-core PATCH v9 3/9] driver core: Probe devices
 asynchronously instead of the driver
Date: Wed, 12 Dec 2018 16:45:09 -0800
Message-ID: <154466190918.9126.4731335311548421806.stgit@ahduyck-desk1.jf.intel.com>
References: <154466182249.9126.3905559325944768059.stgit@ahduyck-desk1.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <154466182249.9126.3905559325944768059.stgit-+uVpp3jiz/RcxmDmkzA3yGt3HXsI98Cx0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, bvanassche-HInyCGIudOg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, jiangshanlai-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pavel-+ZI9xUNit7I@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Probe devices asynchronously instead of the driver. This results in us
seeing the same behavior if the device is registered before the driver or
after. This way we can avoid serializing the initialization should the
driver not be loaded until after the devices have already been added.

The motivation behind this is that if we have a set of devices that
take a significant amount of time to load we can greatly reduce the time to
load by processing them in parallel instead of one at a time. In addition,
each device can exist on a different node so placing a single thread on one
CPU to initialize all of the devices for a given driver can result in poor
performance on a system with multiple nodes.

This approach can reduce the time needed to scan SCSI LUNs significantly.
The only way to realize that speedup is by enabling more concurrency which
is what is achieved with this patch.

To achieve this it was necessary to add a new member "async_driver" to the
device_private structure to store the driver pointer while we wait on the
deferred probe call.

Reviewed-by: Bart Van Assche <bvanassche-HInyCGIudOg@public.gmane.org>
Reviewed-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Alexander Duyck <alexander.h.duyck-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/base/base.h |    2 ++
 drivers/base/bus.c  |   23 +++--------------------
 drivers/base/dd.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 3f22ebd6117a..c95384a8e53c 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -64,6 +64,7 @@ struct driver_private {
  *	binding of drivers which were unable to get all the resources needed by
  *	the device; typically because it depends on another driver getting
  *	probed first.
+ * @async_driver - pointer to device driver awaiting probe via async_probe
  * @device - pointer back to the struct device that this structure is
  * associated with.
  *
@@ -75,6 +76,7 @@ struct device_private {
 	struct klist_node knode_driver;
 	struct klist_node knode_bus;
 	struct list_head deferred_probe;
+	struct device_driver *async_driver;
 	struct device *device;
 };
 #define to_device_private_parent(obj)	\
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 74054481007d..be69eb2b07e6 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -608,17 +608,6 @@ static ssize_t uevent_store(struct device_driver *drv, const char *buf,
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
@@ -651,15 +640,9 @@ int bus_add_driver(struct device_driver *drv)
 
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
index f07c16277ed9..3353f654861b 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -925,6 +925,30 @@ int device_driver_attach(struct device_driver *drv, struct device *dev)
 	return ret;
 }
 
+static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie)
+{
+	struct device *dev = _dev;
+	struct device_driver *drv;
+	int ret = 0;
+
+	__device_driver_lock(dev, dev->parent);
+
+	drv = dev->p->async_driver;
+
+	/*
+	 * If device has been removed or someone has already successfully
+	 * bound a driver before us just skip the driver probe call.
+	 */
+	if (!dev->dead && !dev->driver)
+		ret = driver_probe_device(drv, dev);
+
+	__device_driver_unlock(dev, dev->parent);
+
+	dev_dbg(dev, "driver %s async attach completed: %d\n", drv->name, ret);
+
+	put_device(dev);
+}
+
 static int __driver_attach(struct device *dev, void *data)
 {
 	struct device_driver *drv = data;
@@ -952,6 +976,25 @@ static int __driver_attach(struct device *dev, void *data)
 		return ret;
 	} /* ret > 0 means positive match */
 
+	if (driver_allows_async_probing(drv)) {
+		/*
+		 * Instead of probing the device synchronously we will
+		 * probe it asynchronously to allow for more parallelism.
+		 *
+		 * We only take the device lock here in order to guarantee
+		 * that the dev->driver and async_driver fields are protected
+		 */
+		dev_dbg(dev, "probing driver %s asynchronously\n", drv->name);
+		device_lock(dev);
+		if (!dev->driver) {
+			get_device(dev);
+			dev->p->async_driver = drv;
+			async_schedule(__driver_attach_async_helper, dev);
+		}
+		device_unlock(dev);
+		return 0;
+	}
+
 	device_driver_attach(drv, dev);
 
 	return 0;

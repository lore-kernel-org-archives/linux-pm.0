From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 3/8] Driver core: wakeup the parent device before trying probe
Date: Mon, 27 Jul 2015 18:03:58 +0300
Message-ID: <1438009443-55317-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

If the parent is still suspended when driver probe is
attempted, the result may be failure.

For example, if the parent is a PCI MFD device that has been
suspended when we try to probe our device, any register
reads will return 0xffffffff.

To fix the problem, making sure the parent is always awake
before attempting driver probe.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/dd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index a638bbb..2d6df1d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -399,6 +399,8 @@ EXPORT_SYMBOL_GPL(wait_for_device_probe);
  *
  * This function must be called with @dev lock held.  When called for a
  * USB interface, @dev->parent lock must be held as well.
+ *
+ * If the device has a parent, runtime-resume the parent before driver probing.
  */
 int driver_probe_device(struct device_driver *drv, struct device *dev)
 {
@@ -410,10 +412,16 @@ int driver_probe_device(struct device_driver *drv, struct device *dev)
 	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
 		 drv->bus->name, __func__, dev_name(dev), drv->name);
 
+	if (dev->parent)
+		pm_runtime_get_sync(dev->parent);
+
 	pm_runtime_barrier(dev);
 	ret = really_probe(dev, drv);
 	pm_request_idle(dev);
 
+	if (dev->parent)
+		pm_runtime_put(dev->parent);
+
 	return ret;
 }
 
@@ -507,11 +515,17 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 
 	device_lock(dev);
 
+	if (dev->parent)
+		pm_runtime_get_sync(dev->parent);
+
 	bus_for_each_drv(dev->bus, NULL, &data, __device_attach_driver);
 	dev_dbg(dev, "async probe completed\n");
 
 	pm_request_idle(dev);
 
+	if (dev->parent)
+		pm_runtime_put(dev->parent);
+
 	device_unlock(dev);
 
 	put_device(dev);
@@ -541,6 +555,9 @@ static int __device_attach(struct device *dev, bool allow_async)
 			.want_async = false,
 		};
 
+		if (dev->parent)
+			pm_runtime_get_sync(dev->parent);
+
 		ret = bus_for_each_drv(dev->bus, NULL, &data,
 					__device_attach_driver);
 		if (!ret && allow_async && data.have_async) {
@@ -557,6 +574,9 @@ static int __device_attach(struct device *dev, bool allow_async)
 		} else {
 			pm_request_idle(dev);
 		}
+
+		if (dev->parent)
+			pm_runtime_put(dev->parent);
 	}
 out_unlock:
 	device_unlock(dev);
-- 
2.4.6

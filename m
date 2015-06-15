From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 3/8] Driver core: wakeup the parent device before trying probe
Date: Mon, 15 Jun 2015 12:57:31 +0300
Message-ID: <1434362256-239992-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1434362256-239992-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>

If the parent is still suspended when driver probe is
attempted, the result may be failure.

For example, if the parent is a PCI MFD device that has been
suspended when we try to probe our device, any register
reads will return 0xffffffff.

To fix the problem, making sure the parent is always awake
before attempting driver probe.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/dd.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e843fdb..c4c1eaf 100644
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
 
@@ -459,8 +467,14 @@ int device_attach(struct device *dev)
 			ret = 0;
 		}
 	} else {
+		if (dev->parent)
+			pm_runtime_get_sync(dev->parent);
+
 		ret = bus_for_each_drv(dev->bus, NULL, dev, __device_attach);
 		pm_request_idle(dev);
+
+		if (dev->parent)
+			pm_runtime_put(dev->parent);
 	}
 out_unlock:
 	device_unlock(dev);
-- 
2.1.4


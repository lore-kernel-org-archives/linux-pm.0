From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/8] Driver core: wakeup the parent device before trying probe
Date: Mon,  1 Jun 2015 17:47:57 +0300
Message-ID: <1433170082-117462-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1433170082-117462-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1433170082-117462-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mike Turquette <mturquette@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

If the parent is still suspended when driver probe is
attempted, the result may be failure.

For example, if the parent is a PCI MFD device that has been
suspended when we try to probe our device, any register
reads will return 0xffffffff.

To fix the problem, making sure the parent is always awake
before attempting driver probe.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/dd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index e843fdb..cfbeff3 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -399,6 +399,8 @@ EXPORT_SYMBOL_GPL(wait_for_device_probe);
  *
  * This function must be called with @dev lock held.  When called for a
  * USB interface, @dev->parent lock must be held as well.
+ *
+ * If device has a parent it will be powered on during device's probe().
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
+		pm_runtime_put_sync(dev->parent);
+
 	return ret;
 }
 
-- 
2.1.4

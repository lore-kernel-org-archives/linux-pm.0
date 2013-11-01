From: Shuah Khan <shuah.kh@samsung.com>
Subject: [PATCH] power: Add legacy pm ops usage warning
Date: Fri,  1 Nov 2013 09:07:04 -0600
Message-ID: <1383318424-4072-1-git-send-email-shuah.kh@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz, rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org
Cc: Shuah Khan <shuah.kh@samsung.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com
List-Id: linux-pm@vger.kernel.org

Add legacy pm_ops usage checks to device_pm_add() when a device gets added
to PM core's list of active devices. If legacy pm_ops usage is found at its
class, bus, driver level, print warning message to indicate the driver code
needs updating to use dev pm ops interfaces. This will help serve as a way
to track drivers that still use legacy pm ops and fix them.

Signed-off-by: Shuah Khan <shuah.kh@samsung.com>
---
 drivers/base/power/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 9f098a8..4dc26dc 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -112,6 +112,23 @@ void device_pm_unlock(void)
 }
 
 /**
+ * check for lgeacy pm_ops usage and warn
+ */
+static void device_legacy_pm_ops_check(struct device *dev)
+{
+	char *info = "Please update driver to use dev pm_ops";
+
+	if (dev->class && (dev->class->suspend || dev->class->resume))
+		dev_warn(dev, "Driver uses legacy class pm ops - %s\n", info);
+
+	if (dev->bus && (dev->bus->suspend || dev->bus->resume))
+		dev_warn(dev, "Driver uses legacy bus pm ops - %s\n", info);
+
+	if (dev->driver && (dev->driver->suspend || dev->driver->resume))
+		dev_warn(dev, "Driver uses legacy pm ops - %s\n", info);
+}
+
+/**
  * device_pm_add - Add a device to the PM core's list of active devices.
  * @dev: Device to add to the list.
  */
@@ -123,6 +140,7 @@ void device_pm_add(struct device *dev)
 	if (dev->parent && dev->parent->power.is_prepared)
 		dev_warn(dev, "parent %s should not be sleeping\n",
 			dev_name(dev->parent));
+	device_legacy_pm_ops_check(dev);
 	list_add_tail(&dev->power.entry, &dpm_list);
 	mutex_unlock(&dpm_list_mtx);
 }
-- 
1.8.1.2

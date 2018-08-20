From: Pingfan Liu <kernelfans@gmail.com>
Subject: [PATCH 1/3] drivers/base: move device_shutdown() to base/power
Date: Mon, 20 Aug 2018 17:18:35 +0800
Message-ID: <1534756717-25553-2-git-send-email-kernelfans@gmail.com>
References: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Pingfan Liu <kernelfans@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Consider the shutdown as a system state transition, i.e. something like
suspend, hibernate, hence move it under the base/power. (This is a first
step to unify the duplicate code logic on devices_kset and dpm_list.)

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
---
 drivers/base/core.c           | 70 ---------------------------------------
 drivers/base/power/Makefile   |  1 +
 drivers/base/power/shutdown.c | 76 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 70 deletions(-)
 create mode 100644 drivers/base/power/shutdown.c

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 04bbcd7..7c83384 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2854,76 +2854,6 @@ int device_move(struct device *dev, struct device *new_parent,
 }
 EXPORT_SYMBOL_GPL(device_move);
 
-/**
- * device_shutdown - call ->shutdown() on each device to shutdown.
- */
-void device_shutdown(void)
-{
-	struct device *dev, *parent;
-
-	wait_for_device_probe();
-	device_block_probing();
-
-	spin_lock(&devices_kset->list_lock);
-	/*
-	 * Walk the devices list backward, shutting down each in turn.
-	 * Beware that device unplug events may also start pulling
-	 * devices offline, even as the system is shutting down.
-	 */
-	while (!list_empty(&devices_kset->list)) {
-		dev = list_entry(devices_kset->list.prev, struct device,
-				kobj.entry);
-
-		/*
-		 * hold reference count of device's parent to
-		 * prevent it from being freed because parent's
-		 * lock is to be held
-		 */
-		parent = get_device(dev->parent);
-		get_device(dev);
-		/*
-		 * Make sure the device is off the kset list, in the
-		 * event that dev->*->shutdown() doesn't remove it.
-		 */
-		list_del_init(&dev->kobj.entry);
-		spin_unlock(&devices_kset->list_lock);
-
-		/* hold lock to avoid race with probe/release */
-		if (parent)
-			device_lock(parent);
-		device_lock(dev);
-
-		/* Don't allow any more runtime suspends */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_barrier(dev);
-
-		if (dev->class && dev->class->shutdown_pre) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown_pre\n");
-			dev->class->shutdown_pre(dev);
-		}
-		if (dev->bus && dev->bus->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->bus->shutdown(dev);
-		} else if (dev->driver && dev->driver->shutdown) {
-			if (initcall_debug)
-				dev_info(dev, "shutdown\n");
-			dev->driver->shutdown(dev);
-		}
-
-		device_unlock(dev);
-		if (parent)
-			device_unlock(parent);
-
-		put_device(dev);
-		put_device(parent);
-
-		spin_lock(&devices_kset->list_lock);
-	}
-	spin_unlock(&devices_kset->list_lock);
-}
-
 /*
  * Device logging functions
  */
diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index e1bb691..057ddbf 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y	+= shutdown.o
 obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
diff --git a/drivers/base/power/shutdown.c b/drivers/base/power/shutdown.c
new file mode 100644
index 0000000..c405d09
--- /dev/null
+++ b/drivers/base/power/shutdown.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+
+#include "../base.h"
+#include "power.h"
+/**
+ * device_shutdown - call ->shutdown() on each device to shutdown.
+ */
+void device_shutdown(void)
+{
+	struct device *dev, *parent;
+
+	wait_for_device_probe();
+	device_block_probing();
+
+	spin_lock(&devices_kset->list_lock);
+	/*
+	 * Walk the devices list backward, shutting down each in turn.
+	 * Beware that device unplug events may also start pulling
+	 * devices offline, even as the system is shutting down.
+	 */
+	while (!list_empty(&devices_kset->list)) {
+		dev = list_entry(devices_kset->list.prev, struct device,
+				kobj.entry);
+
+		/*
+		 * hold reference count of device's parent to
+		 * prevent it from being freed because parent's
+		 * lock is to be held
+		 */
+		parent = get_device(dev->parent);
+		get_device(dev);
+		/*
+		 * Make sure the device is off the kset list, in the
+		 * event that dev->*->shutdown() doesn't remove it.
+		 */
+		list_del_init(&dev->kobj.entry);
+		spin_unlock(&devices_kset->list_lock);
+
+		/* hold lock to avoid race with probe/release */
+		if (parent)
+			device_lock(parent);
+		device_lock(dev);
+
+		/* Don't allow any more runtime suspends */
+		pm_runtime_get_noresume(dev);
+		pm_runtime_barrier(dev);
+
+		if (dev->class && dev->class->shutdown_pre) {
+			if (initcall_debug)
+				dev_info(dev, "shutdown_pre\n");
+			dev->class->shutdown_pre(dev);
+		}
+		if (dev->bus && dev->bus->shutdown) {
+			if (initcall_debug)
+				dev_info(dev, "shutdown\n");
+			dev->bus->shutdown(dev);
+		} else if (dev->driver && dev->driver->shutdown) {
+			if (initcall_debug)
+				dev_info(dev, "shutdown\n");
+			dev->driver->shutdown(dev);
+		}
+
+		device_unlock(dev);
+		if (parent)
+			device_unlock(parent);
+
+		put_device(dev);
+		put_device(parent);
+
+		spin_lock(&devices_kset->list_lock);
+	}
+	spin_unlock(&devices_kset->list_lock);
+}
-- 
2.7.4

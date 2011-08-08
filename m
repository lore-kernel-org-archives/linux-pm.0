From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/4] PM: Reference counting of power.subsys_data
Date: Tue, 9 Aug 2011 00:31:42 +0200
Message-ID: <201108090031.42691.rjw__8267.15347725457$1312842805$gmane$org@sisk.pl>
References: <201108090028.12698.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108090028.12698.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since the power.subsys_data device field will be used by multiple
filesystems, introduce a reference counting mechanism for it to avoid
freeing it prematurely or changing its value at a wrong time.

Make the PM clocks management code that currently is the only user of
power.subsys_data use the new reference counting.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/base/power/Makefile    |    2 
 drivers/base/power/clock_ops.c |   24 ++---------
 drivers/base/power/common.c    |   86 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pm.h             |    3 +
 4 files changed, 95 insertions(+), 20 deletions(-)

Index: linux-2.6/drivers/base/power/common.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/base/power/common.c
@@ -0,0 +1,86 @@
+/*
+ * drivers/base/power/common.c - Common device power management code.
+ *
+ * Copyright (C) 2011 Rafael J. Wysocki <rjw@sisk.pl>, Renesas Electronics Corp.
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/pm_runtime.h>
+
+/**
+ * dev_pm_get_subsys_data - Create or refcount power.subsys_data for device.
+ * @dev: Device to handle.
+ *
+ * If power.subsys_data is NULL, point it to a new object, otherwise increment
+ * its reference counter.  Return 1 if a new object has been created, otherwise
+ * return 0 or error code.
+ */
+int dev_pm_get_subsys_data(struct device *dev)
+{
+	struct pm_subsys_data *psd;
+	int ret = 0;
+
+	psd = kzalloc(sizeof(*psd), GFP_KERNEL);
+	if (!psd)
+		return -ENOMEM;
+
+	spin_lock_irq(&dev->power.lock);
+
+	if (dev->power.subsys_data) {
+		dev->power.subsys_data->refcount++;
+	} else {
+		mutex_init(&psd->lock);
+		psd->refcount = 1;
+		dev->power.subsys_data = psd;
+		pm_clk_init(dev);
+		psd = NULL;
+		ret = 1;
+	}
+
+	spin_unlock_irq(&dev->power.lock);
+
+	/* kfree() verifies that its argument is nonzero. */
+	kfree(psd);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_get_subsys_data);
+
+/**
+ * dev_pm_put_subsys_data - Drop reference to power.subsys_data.
+ * @dev: Device to handle.
+ *
+ * If the reference counter of power.subsys_data is zero after dropping the
+ * reference, power.subsys_data is removed.  Return 1 if that happens or 0
+ * otherwise.
+ */
+int dev_pm_put_subsys_data(struct device *dev)
+{
+	struct pm_subsys_data *psd;
+	int ret = 0;
+
+	spin_lock_irq(&dev->power.lock);
+
+	psd = dev_to_psd(dev);
+	if (!psd) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (--psd->refcount == 0) {
+		dev->power.subsys_data = NULL;
+		kfree(psd);
+		ret = 1;
+	}
+
+ out:
+	spin_unlock_irq(&dev->power.lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dev_pm_put_subsys_data);
Index: linux-2.6/include/linux/pm.h
===================================================================
--- linux-2.6.orig/include/linux/pm.h
+++ linux-2.6/include/linux/pm.h
@@ -424,6 +424,7 @@ struct wakeup_source;
 
 struct pm_subsys_data {
 	struct mutex lock;
+	unsigned int refcount;
 #ifdef CONFIG_PM_CLK
 	struct list_head clock_list;
 #endif
@@ -474,6 +475,8 @@ struct dev_pm_info {
 };
 
 extern void update_pm_runtime_accounting(struct device *dev);
+extern int dev_pm_get_subsys_data(struct device *dev);
+extern int dev_pm_put_subsys_data(struct device *dev);
 
 /*
  * Power domains provide callbacks that are executed during system suspend,
Index: linux-2.6/drivers/base/power/Makefile
===================================================================
--- linux-2.6.orig/drivers/base/power/Makefile
+++ linux-2.6/drivers/base/power/Makefile
@@ -1,4 +1,4 @@
-obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o
+obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_RUNTIME)	+= runtime.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
Index: linux-2.6/drivers/base/power/clock_ops.c
===================================================================
--- linux-2.6.orig/drivers/base/power/clock_ops.c
+++ linux-2.6/drivers/base/power/clock_ops.c
@@ -140,12 +140,8 @@ void pm_clk_remove(struct device *dev, c
 void pm_clk_init(struct device *dev)
 {
 	struct pm_subsys_data *psd = dev_to_psd(dev);
-
-	if (!psd)
-		return;
-
-	INIT_LIST_HEAD(&psd->clock_list);
-	mutex_init(&psd->lock);
+	if (psd)
+		INIT_LIST_HEAD(&psd->clock_list);
 }
 
 /**
@@ -157,16 +153,8 @@ void pm_clk_init(struct device *dev)
  */
 int pm_clk_create(struct device *dev)
 {
-	struct pm_subsys_data *psd;
-
-	psd = kzalloc(sizeof(*psd), GFP_KERNEL);
-	if (!psd) {
-		dev_err(dev, "Not enough memory for PM clock data.\n");
-		return -ENOMEM;
-	}
-	dev->power.subsys_data = psd;
-	pm_clk_init(dev);
-	return 0;
+	int ret = dev_pm_get_subsys_data(dev);
+	return ret < 0 ? ret : 0;
 }
 
 /**
@@ -185,8 +173,6 @@ void pm_clk_destroy(struct device *dev)
 	if (!psd)
 		return;
 
-	dev->power.subsys_data = NULL;
-
 	mutex_lock(&psd->lock);
 
 	list_for_each_entry_safe_reverse(ce, c, &psd->clock_list, node)
@@ -194,7 +180,7 @@ void pm_clk_destroy(struct device *dev)
 
 	mutex_unlock(&psd->lock);
 
-	kfree(psd);
+	dev_pm_put_subsys_data(dev);
 }
 
 #endif /* CONFIG_PM */

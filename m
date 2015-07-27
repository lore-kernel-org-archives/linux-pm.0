From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 5/8] driver core: implement device_for_each_child_reverse()
Date: Mon, 27 Jul 2015 18:04:00 +0300
Message-ID: <1438009443-55317-6-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Lee Jones <lee.jones@linaro.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The new function device_for_each_child_reverse() is helpful to traverse the
registered devices in a reversed order, e.g. in the case when an operation on
each device should be done first on the last added device, then on one before
last and so on.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c    | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index dafae6d..7d62795 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1252,6 +1252,19 @@ void device_unregister(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_unregister);
 
+static struct device *prev_device(struct klist_iter *i)
+{
+	struct klist_node *n = klist_prev(i);
+	struct device *dev = NULL;
+	struct device_private *p;
+
+	if (n) {
+		p = to_device_private_parent(n);
+		dev = p->device;
+	}
+	return dev;
+}
+
 static struct device *next_device(struct klist_iter *i)
 {
 	struct klist_node *n = klist_next(i);
@@ -1341,6 +1354,36 @@ int device_for_each_child(struct device *parent, void *data,
 EXPORT_SYMBOL_GPL(device_for_each_child);
 
 /**
+ * device_for_each_child_reverse - device child iterator in reversed order.
+ * @parent: parent struct device.
+ * @fn: function to be called for each device.
+ * @data: data for the callback.
+ *
+ * Iterate over @parent's child devices, and call @fn for each,
+ * passing it @data.
+ *
+ * We check the return of @fn each time. If it returns anything
+ * other than 0, we break out and return that value.
+ */
+int device_for_each_child_reverse(struct device *parent, void *data,
+				  int (*fn)(struct device *dev, void *data))
+{
+	struct klist_iter i;
+	struct device *child;
+	int error = 0;
+
+	if (!parent->p)
+		return 0;
+
+	klist_iter_init(&parent->p->klist_children, &i);
+	while ((child = prev_device(&i)) && !error)
+		error = fn(child, data);
+	klist_iter_exit(&i);
+	return error;
+}
+EXPORT_SYMBOL_GPL(device_for_each_child_reverse);
+
+/**
  * device_find_child - device iterator for locating a particular device.
  * @parent: parent struct device
  * @match: Callback function to check device
diff --git a/include/linux/device.h b/include/linux/device.h
index a2b4ea7..9d212fe 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -959,6 +959,8 @@ extern int __must_check device_add(struct device *dev);
 extern void device_del(struct device *dev);
 extern int device_for_each_child(struct device *dev, void *data,
 		     int (*fn)(struct device *dev, void *data));
+extern int device_for_each_child_reverse(struct device *dev, void *data,
+		     int (*fn)(struct device *dev, void *data));
 extern struct device *device_find_child(struct device *dev, void *data,
 				int (*match)(struct device *dev, void *data));
 extern int device_rename(struct device *dev, const char *new_name);
-- 
2.4.6

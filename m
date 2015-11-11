From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V5] PM / OPP: Add debugfs support
Date: Wed, 11 Nov 2015 07:59:01 +0530
Message-ID: <3fd43be545a4da4fb4e78d19e8e37e8e83f1512c.1447208688.git.viresh.kumar@linaro.org>
References: <20151110193603.GA24116@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151110193603.GA24116@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

This patch adds debugfs support to OPP layer to export OPPs and their
properties for all the devices.

This creates a top level directory: /sys/kernel/debug/opp and then
device specific directories (based on device names) inside it. For
example: 'cpu0', 'cpu1', etc..

If multiple devices share the OPP table, then the real directory is
created only for the first device. For all others, links are created to
the real directory.

Inside the device specific directory, a separate directory is created
for each OPP. And within that files per opp property.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V4->V5:
- include more headers
- document new field 'suspend'
- remove useless 'debugfs' comments

 drivers/base/power/opp/Makefile  |   1 +
 drivers/base/power/opp/core.c    |  21 +++-
 drivers/base/power/opp/debugfs.c | 219 +++++++++++++++++++++++++++++++++++++++
 drivers/base/power/opp/opp.h     |  42 ++++++++
 4 files changed, 281 insertions(+), 2 deletions(-)
 create mode 100644 drivers/base/power/opp/debugfs.c

diff --git a/drivers/base/power/opp/Makefile b/drivers/base/power/opp/Makefile
index 33c1e18c41a4..19837ef04d8e 100644
--- a/drivers/base/power/opp/Makefile
+++ b/drivers/base/power/opp/Makefile
@@ -1,2 +1,3 @@
 ccflags-$(CONFIG_DEBUG_DRIVER)	:= -DDEBUG
 obj-y				+= core.o cpu.o
+obj-$(CONFIG_DEBUG_FS)		+= debugfs.o
diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 5e4b1d82b2f8..a3a9ae8fb55f 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -463,6 +463,7 @@ static void _kfree_list_dev_rcu(struct rcu_head *head)
 static void _remove_list_dev(struct device_list_opp *list_dev,
 			     struct device_opp *dev_opp)
 {
+	opp_debug_unregister(list_dev, dev_opp);
 	list_del(&list_dev->node);
 	call_srcu(&dev_opp->srcu_head.srcu, &list_dev->rcu_head,
 		  _kfree_list_dev_rcu);
@@ -472,6 +473,7 @@ struct device_list_opp *_add_list_dev(const struct device *dev,
 				      struct device_opp *dev_opp)
 {
 	struct device_list_opp *list_dev;
+	int ret;
 
 	list_dev = kzalloc(sizeof(*list_dev), GFP_KERNEL);
 	if (!list_dev)
@@ -481,6 +483,12 @@ struct device_list_opp *_add_list_dev(const struct device *dev,
 	list_dev->dev = dev;
 	list_add_rcu(&list_dev->node, &dev_opp->dev_list);
 
+	/* Create debugfs entries for the dev_opp */
+	ret = opp_debug_register(list_dev, dev_opp);
+	if (ret)
+		dev_err(dev, "%s: Failed to register opp debugfs (%d)\n",
+			__func__, ret);
+
 	return list_dev;
 }
 
@@ -596,6 +604,7 @@ static void _opp_remove(struct device_opp *dev_opp,
 	 */
 	if (notify)
 		srcu_notifier_call_chain(&dev_opp->srcu_head, OPP_EVENT_REMOVE, opp);
+	opp_debug_remove_one(opp);
 	list_del_rcu(&opp->node);
 	call_srcu(&dev_opp->srcu_head.srcu, &opp->rcu_head, _kfree_opp_rcu);
 
@@ -673,6 +682,7 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 {
 	struct dev_pm_opp *opp;
 	struct list_head *head = &dev_opp->opp_list;
+	int ret;
 
 	/*
 	 * Insert new OPP in order of increasing frequency and discard if
@@ -703,6 +713,11 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	new_opp->dev_opp = dev_opp;
 	list_add_rcu(&new_opp->node, head);
 
+	ret = opp_debug_create_one(new_opp, dev_opp);
+	if (ret)
+		dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
+			__func__, ret);
+
 	return 0;
 }
 
@@ -889,12 +904,14 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 
 	/* OPP to select on device suspend */
 	if (of_property_read_bool(np, "opp-suspend")) {
-		if (dev_opp->suspend_opp)
+		if (dev_opp->suspend_opp) {
 			dev_warn(dev, "%s: Multiple suspend OPPs found (%lu %lu)\n",
 				 __func__, dev_opp->suspend_opp->rate,
 				 new_opp->rate);
-		else
+		} else {
+			new_opp->suspend = true;
 			dev_opp->suspend_opp = new_opp;
+		}
 	}
 
 	if (new_opp->clock_latency_ns > dev_opp->clock_latency_ns_max)
diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
new file mode 100644
index 000000000000..ddfe4773e922
--- /dev/null
+++ b/drivers/base/power/opp/debugfs.c
@@ -0,0 +1,219 @@
+/*
+ * Generic OPP debugfs interface
+ *
+ * Copyright (C) 2015-2016 Viresh Kumar <viresh.kumar@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/limits.h>
+
+#include "opp.h"
+
+static struct dentry *rootdir;
+
+static void opp_set_dev_name(const struct device *dev, char *name)
+{
+	if (dev->parent)
+		snprintf(name, NAME_MAX, "%s-%s", dev_name(dev->parent),
+			 dev_name(dev));
+	else
+		snprintf(name, NAME_MAX, "%s", dev_name(dev));
+}
+
+void opp_debug_remove_one(struct dev_pm_opp *opp)
+{
+	debugfs_remove_recursive(opp->dentry);
+}
+
+int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_opp)
+{
+	struct dentry *pdentry = dev_opp->dentry;
+	struct dentry *d;
+	char name[25];	/* 20 chars for 64 bit value + 5 (opp:\0) */
+
+	/* Rate is unique to each OPP, use it to give opp-name */
+	snprintf(name, sizeof(name), "opp:%lu", opp->rate);
+
+	/* Create per-opp directory */
+	d = debugfs_create_dir(name, pdentry);
+	if (!d)
+		return -ENOMEM;
+
+	if (!debugfs_create_bool("available", S_IRUGO, d, &opp->available))
+		return -ENOMEM;
+
+	if (!debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic))
+		return -ENOMEM;
+
+	if (!debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo))
+		return -ENOMEM;
+
+	if (!debugfs_create_bool("suspend", S_IRUGO, d, &opp->suspend))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("rate_hz", S_IRUGO, d, &opp->rate))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("u_volt_target", S_IRUGO, d, &opp->u_volt))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("u_volt_min", S_IRUGO, d, &opp->u_volt_min))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("u_volt_max", S_IRUGO, d, &opp->u_volt_max))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("u_amp", S_IRUGO, d, &opp->u_amp))
+		return -ENOMEM;
+
+	if (!debugfs_create_ulong("clock_latency_ns", S_IRUGO, d,
+				  &opp->clock_latency_ns))
+		return -ENOMEM;
+
+	opp->dentry = d;
+	return 0;
+}
+
+static int device_opp_debug_create_dir(struct device_list_opp *list_dev,
+				       struct device_opp *dev_opp)
+{
+	const struct device *dev = list_dev->dev;
+	struct dentry *d;
+
+	opp_set_dev_name(dev, dev_opp->dentry_name);
+
+	/* Create device specific directory */
+	d = debugfs_create_dir(dev_opp->dentry_name, rootdir);
+	if (!d) {
+		dev_err(dev, "%s: Failed to create debugfs dir\n", __func__);
+		return -ENOMEM;
+	}
+
+	list_dev->dentry = d;
+	dev_opp->dentry = d;
+
+	return 0;
+}
+
+static int device_opp_debug_create_link(struct device_list_opp *list_dev,
+					struct device_opp *dev_opp)
+{
+	const struct device *dev = list_dev->dev;
+	char name[NAME_MAX];
+	struct dentry *d;
+
+	opp_set_dev_name(list_dev->dev, name);
+
+	/* Create device specific directory link */
+	d = debugfs_create_symlink(name, rootdir, dev_opp->dentry_name);
+	if (!d) {
+		dev_err(dev, "%s: Failed to create link\n", __func__);
+		return -ENOMEM;
+	}
+
+	list_dev->dentry = d;
+
+	return 0;
+}
+
+/**
+ * opp_debug_register - add a device opp node to the debugfs 'opp' directory
+ * @list_dev: list-dev pointer for device
+ * @dev_opp: the device-opp being added
+ *
+ * Dynamically adds device specific directory in debugfs 'opp' directory. If the
+ * device-opp is shared with other devices, then links will be created for all
+ * devices except the first.
+ *
+ * Return: 0 on success, otherwise negative error.
+ */
+int opp_debug_register(struct device_list_opp *list_dev,
+		       struct device_opp *dev_opp)
+{
+	if (!rootdir) {
+		pr_debug("%s: Uninitialized rootdir\n", __func__);
+		return -EINVAL;
+	}
+
+	if (dev_opp->dentry)
+		return device_opp_debug_create_link(list_dev, dev_opp);
+
+	return device_opp_debug_create_dir(list_dev, dev_opp);
+}
+
+static void opp_migrate_dentry(struct device_list_opp *list_dev,
+			       struct device_opp *dev_opp)
+{
+	struct device_list_opp *new_dev;
+	const struct device *dev;
+	struct dentry *dentry;
+
+	/* Look for next list-dev */
+	list_for_each_entry(new_dev, &dev_opp->dev_list, node)
+		if (new_dev != list_dev)
+			break;
+
+	/* new_dev is guaranteed to be valid here */
+	dev = new_dev->dev;
+	debugfs_remove_recursive(new_dev->dentry);
+
+	opp_set_dev_name(dev, dev_opp->dentry_name);
+
+	dentry = debugfs_rename(rootdir, list_dev->dentry, rootdir,
+				dev_opp->dentry_name);
+	if (!dentry) {
+		dev_err(dev, "%s: Failed to rename link from: %s to %s\n",
+			__func__, dev_name(list_dev->dev), dev_name(dev));
+		return;
+	}
+
+	new_dev->dentry = dentry;
+	dev_opp->dentry = dentry;
+}
+
+/**
+ * opp_debug_unregister - remove a device opp node from debugfs opp directory
+ * @list_dev: list-dev pointer for device
+ * @dev_opp: the device-opp being removed
+ *
+ * Dynamically removes device specific directory from debugfs 'opp' directory.
+ */
+void opp_debug_unregister(struct device_list_opp *list_dev,
+			  struct device_opp *dev_opp)
+{
+	if (list_dev->dentry == dev_opp->dentry) {
+		/* Move the real dentry object under another device */
+		if (!list_is_singular(&dev_opp->dev_list)) {
+			opp_migrate_dentry(list_dev, dev_opp);
+			goto out;
+		}
+		dev_opp->dentry = NULL;
+	}
+
+	debugfs_remove_recursive(list_dev->dentry);
+
+out:
+	list_dev->dentry = NULL;
+}
+
+static int __init opp_debug_init(void)
+{
+	/* Create /sys/kernel/debug/opp directory */
+	rootdir = debugfs_create_dir("opp", NULL);
+	if (!rootdir) {
+		pr_err("%s: Failed to create root directory\n", __func__);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+core_initcall(opp_debug_init);
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 7366b2aa8997..a6bd8d2c2b47 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/limits.h>
 #include <linux/pm_opp.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
@@ -53,6 +54,7 @@ extern struct mutex dev_opp_list_lock;
  * @dynamic:	not-created from static DT entries.
  * @available:	true/false - marks if this OPP as available or not
  * @turbo:	true if turbo (boost) OPP
+ * @suspend:	true if suspend OPP
  * @rate:	Frequency in hertz
  * @u_volt:	Target voltage in microvolts corresponding to this OPP
  * @u_volt_min:	Minimum voltage in microvolts corresponding to this OPP
@@ -63,6 +65,7 @@ extern struct mutex dev_opp_list_lock;
  * @dev_opp:	points back to the device_opp struct this opp belongs to
  * @rcu_head:	RCU callback head used for deferred freeing
  * @np:		OPP's device node.
+ * @dentry:	debugfs dentry pointer (per opp)
  *
  * This structure stores the OPP information for a given device.
  */
@@ -72,6 +75,7 @@ struct dev_pm_opp {
 	bool available;
 	bool dynamic;
 	bool turbo;
+	bool suspend;
 	unsigned long rate;
 
 	unsigned long u_volt;
@@ -84,6 +88,10 @@ struct dev_pm_opp {
 	struct rcu_head rcu_head;
 
 	struct device_node *np;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dentry;
+#endif
 };
 
 /**
@@ -91,6 +99,7 @@ struct dev_pm_opp {
  * @node:	list node
  * @dev:	device to which the struct object belongs
  * @rcu_head:	RCU callback head used for deferred freeing
+ * @dentry:	debugfs dentry pointer (per device)
  *
  * This is an internal data structure maintaining the list of devices that are
  * managed by 'struct device_opp'.
@@ -99,6 +108,10 @@ struct device_list_opp {
 	struct list_head node;
 	const struct device *dev;
 	struct rcu_head rcu_head;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dentry;
+#endif
 };
 
 /**
@@ -114,6 +127,8 @@ struct device_list_opp {
  * @opp_list:	list of opps
  * @np:		struct device_node pointer for opp's DT node.
  * @shared_opp: OPP is shared between multiple devices.
+ * @dentry:	debugfs dentry pointer of the real device directory (not links).
+ * @dentry_name: Name of the real dentry.
  *
  * This is an internal data structure maintaining the link to opps attached to
  * a device. This structure is not meant to be shared to users as it is
@@ -135,6 +150,11 @@ struct device_opp {
 	unsigned long clock_latency_ns_max;
 	bool shared_opp;
 	struct dev_pm_opp *suspend_opp;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *dentry;
+	char dentry_name[NAME_MAX];
+#endif
 };
 
 /* Routines internal to opp core */
@@ -143,4 +163,26 @@ struct device_list_opp *_add_list_dev(const struct device *dev,
 				      struct device_opp *dev_opp);
 struct device_node *_of_get_opp_desc_node(struct device *dev);
 
+#ifdef CONFIG_DEBUG_FS
+void opp_debug_remove_one(struct dev_pm_opp *opp);
+int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_opp);
+int opp_debug_register(struct device_list_opp *list_dev,
+		       struct device_opp *dev_opp);
+void opp_debug_unregister(struct device_list_opp *list_dev,
+			  struct device_opp *dev_opp);
+#else
+static inline void opp_debug_remove_one(struct dev_pm_opp *opp) {}
+
+static inline int opp_debug_create_one(struct dev_pm_opp *opp,
+				       struct device_opp *dev_opp)
+{ return 0; }
+static inline int opp_debug_register(struct device_list_opp *list_dev,
+				     struct device_opp *dev_opp)
+{ return 0; }
+
+static inline void opp_debug_unregister(struct device_list_opp *list_dev,
+					struct device_opp *dev_opp)
+{ }
+#endif		/* DEBUG_FS */
+
 #endif		/* __DRIVER_OPP_H__ */
-- 
2.6.2.198.g614a2ac

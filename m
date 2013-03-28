From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v6 2/8] reset: Add reset controller API
Date: Thu, 28 Mar 2013 17:35:17 +0100
Message-ID: <1364488523-20310-3-git-send-email-p.zabel@pengutronix.de>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:56969 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756504Ab3C1QgH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Mar 2013 12:36:07 -0400
In-Reply-To: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Warren <swarren@wwwdotorg.org>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, kernel@pengutronix.de, devicetree-discuss@lists.ozlabs.org, Mike Turquette <mturquette@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>

This adds a simple API for devices to request being reset
by separate reset controller hardware and implements the
reset signal device tree binding.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Stephen Warren <swarren@nvidia.com>
Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 drivers/Kconfig                  |   2 +
 drivers/Makefile                 |   3 +
 drivers/reset/Kconfig            |  13 ++
 drivers/reset/Makefile           |   1 +
 drivers/reset/core.c             | 297 +++++++++++++++++++++++++++++++++++++++
 include/linux/reset-controller.h |  51 +++++++
 include/linux/reset.h            |  17 +++
 7 files changed, 384 insertions(+)
 create mode 100644 drivers/reset/Kconfig
 create mode 100644 drivers/reset/Makefile
 create mode 100644 drivers/reset/core.c
 create mode 100644 include/linux/reset-controller.h
 create mode 100644 include/linux/reset.h

diff --git a/drivers/Kconfig b/drivers/Kconfig
index 202fa6d..847f8e3 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -162,4 +162,6 @@ source "drivers/irqchip/Kconfig"
 
 source "drivers/ipack/Kconfig"
 
+source "drivers/reset/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index dce39a9..1a64c4c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -37,6 +37,9 @@ obj-$(CONFIG_XEN)		+= xen/
 # regulators early, since some subsystems rely on them to initialize
 obj-$(CONFIG_REGULATOR)		+= regulator/
 
+# reset controllers early, since gpu drivers might rely on them to initialize
+obj-$(CONFIG_RESET_CONTROLLER)	+= reset/
+
 # tty/ comes before char/ so that the VT console is the boot-time
 # default.
 obj-y				+= tty/
diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
new file mode 100644
index 0000000..c9d04f7
--- /dev/null
+++ b/drivers/reset/Kconfig
@@ -0,0 +1,13 @@
+config ARCH_HAS_RESET_CONTROLLER
+	bool
+
+menuconfig RESET_CONTROLLER
+	bool "Reset Controller Support"
+	default y if ARCH_HAS_RESET_CONTROLLER
+	help
+	  Generic Reset Controller support.
+
+	  This framework is designed to abstract reset handling of devices
+	  via GPIOs or SoC-internal reset controller modules.
+
+	  If unsure, say no.
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
new file mode 100644
index 0000000..1e2d83f
--- /dev/null
+++ b/drivers/reset/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_RESET_CONTROLLER) += core.o
diff --git a/drivers/reset/core.c b/drivers/reset/core.c
new file mode 100644
index 0000000..a258277
--- /dev/null
+++ b/drivers/reset/core.c
@@ -0,0 +1,297 @@
+/*
+ * Reset Controller framework
+ *
+ * Copyright 2013 Philipp Zabel, Pengutronix
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/reset.h>
+#include <linux/reset-controller.h>
+#include <linux/slab.h>
+
+static DEFINE_MUTEX(reset_controller_list_mutex);
+static LIST_HEAD(reset_controller_list);
+
+/**
+ * struct reset_control - a reset control
+ * @rcdev: a pointer to the reset controller device
+ *         this reset control belongs to
+ * @id: ID of the reset controller in the reset
+ *      controller device
+ */
+struct reset_control {
+	struct reset_controller_dev *rcdev;
+	struct device *dev;
+	unsigned int id;
+};
+
+/**
+ * of_reset_simple_xlate - translate reset_spec to the reset line number
+ * @rcdev: a pointer to the reset controller device
+ * @reset_spec: reset line specifier as found in the device tree
+ * @flags: a flags pointer to fill in (optional)
+ *
+ * This simple translation function should be used for reset controllers
+ * with 1:1 mapping, where reset lines can be indexed by number without gaps.
+ */
+int of_reset_simple_xlate(struct reset_controller_dev *rcdev,
+			  const struct of_phandle_args *reset_spec)
+{
+	if (WARN_ON(reset_spec->args_count != rcdev->of_reset_n_cells))
+		return -EINVAL;
+
+	if (reset_spec->args[0] >= rcdev->nr_resets)
+		return -EINVAL;
+
+	return reset_spec->args[0];
+}
+EXPORT_SYMBOL_GPL(of_reset_simple_xlate);
+
+/**
+ * reset_controller_register - register a reset controller device
+ * @rcdev: a pointer to the initialized reset controller device
+ */
+int reset_controller_register(struct reset_controller_dev *rcdev)
+{
+	if (!rcdev->of_xlate) {
+		rcdev->of_reset_n_cells = 1;
+		rcdev->of_xlate = of_reset_simple_xlate;
+	}
+
+	mutex_lock(&reset_controller_list_mutex);
+	list_add(&rcdev->list, &reset_controller_list);
+	mutex_unlock(&reset_controller_list_mutex);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reset_controller_register);
+
+/**
+ * reset_controller_unregister - unregister a reset controller device
+ * @rcdev: a pointer to the reset controller device
+ */
+void reset_controller_unregister(struct reset_controller_dev *rcdev)
+{
+	mutex_lock(&reset_controller_list_mutex);
+	list_del(&rcdev->list);
+	mutex_unlock(&reset_controller_list_mutex);
+}
+EXPORT_SYMBOL_GPL(reset_controller_unregister);
+
+/**
+ * reset_control_reset - reset the controlled device
+ * @rstc: reset controller
+ */
+int reset_control_reset(struct reset_control *rstc)
+{
+	if (rstc->rcdev->ops->reset)
+		return rstc->rcdev->ops->reset(rstc->rcdev, rstc->id);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(reset_control_reset);
+
+/**
+ * reset_control_assert - asserts the reset line
+ * @rstc: reset controller
+ */
+int reset_control_assert(struct reset_control *rstc)
+{
+	if (rstc->rcdev->ops->assert)
+		return rstc->rcdev->ops->assert(rstc->rcdev, rstc->id);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(reset_control_assert);
+
+/**
+ * reset_control_deassert - deasserts the reset line
+ * @rstc: reset controller
+ */
+int reset_control_deassert(struct reset_control *rstc)
+{
+	if (rstc->rcdev->ops->deassert)
+		return rstc->rcdev->ops->deassert(rstc->rcdev, rstc->id);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(reset_control_deassert);
+
+/**
+ * reset_control_get - Lookup and obtain a reference to a reset controller.
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ *
+ * Use of id names is optional.
+ */
+struct reset_control *reset_control_get(struct device *dev, const char *id)
+{
+	struct reset_control *rstc = ERR_PTR(-EPROBE_DEFER);
+	struct reset_controller_dev *r, *rcdev;
+	struct of_phandle_args args;
+	int index = 0;
+	int rstc_id;
+	int ret;
+
+	if (!dev)
+		return ERR_PTR(-EINVAL);
+
+	if (id)
+		index = of_property_match_string(dev->of_node,
+						 "reset-names", id);
+	ret = of_parse_phandle_with_args(dev->of_node, "resets", "#reset-cells",
+					 index, &args);
+	if (ret)
+		return ERR_PTR(ret);
+
+	mutex_lock(&reset_controller_list_mutex);
+	rcdev = NULL;
+	list_for_each_entry(r, &reset_controller_list, list) {
+		if (args.np == r->of_node) {
+			rcdev = r;
+			break;
+		}
+	}
+	of_node_put(args.np);
+
+	if (!rcdev) {
+		mutex_unlock(&reset_controller_list_mutex);
+		return ERR_PTR(-ENODEV);
+	}
+
+	rstc_id = rcdev->of_xlate(rcdev, &args);
+	if (rstc_id < 0) {
+		mutex_unlock(&reset_controller_list_mutex);
+		return ERR_PTR(rstc_id);
+	}
+
+	try_module_get(rcdev->owner);
+	mutex_unlock(&reset_controller_list_mutex);
+
+	rstc = kzalloc(sizeof(*rstc), GFP_KERNEL);
+	if (!rstc) {
+		module_put(rstc->rcdev->owner);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	rstc->dev = dev;
+	rstc->rcdev = rcdev;
+	rstc->id = rstc_id;
+
+	return rstc;
+}
+EXPORT_SYMBOL_GPL(reset_control_get);
+
+/**
+ * reset_control_put - free the reset controller
+ * @rstc: reset controller
+ */
+
+void reset_control_put(struct reset_control *rstc)
+{
+	if (IS_ERR(rstc))
+		return;
+
+	module_put(rstc->rcdev->owner);
+	kfree(rstc);
+}
+EXPORT_SYMBOL_GPL(reset_control_put);
+
+static void devm_reset_control_release(struct device *dev, void *res)
+{
+	reset_control_put(*(struct reset_control **)res);
+}
+
+/**
+ * devm_reset_control_get - resource managed reset_control_get()
+ * @dev: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Managed reset_control_get(). For reset controllers returned from this
+ * function, reset_control_put() is called automatically on driver detach.
+ * See reset_control_get() for more information.
+ */
+struct reset_control *devm_reset_control_get(struct device *dev, const char *id)
+{
+	struct reset_control **ptr, *rstc;
+
+	ptr = devres_alloc(devm_reset_control_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	rstc = reset_control_get(dev, id);
+	if (!IS_ERR(rstc)) {
+		*ptr = rstc;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return rstc;
+}
+EXPORT_SYMBOL_GPL(devm_reset_control_get);
+
+static int devm_reset_control_match(struct device *dev, void *res, void *data)
+{
+	struct reset_control **rstc = res;
+	if (WARN_ON(!rstc || !*rstc))
+		return 0;
+	return *rstc == data;
+}
+
+/**
+ * devm_reset_control_put - resource managed reset_control_put()
+ * @rstc: reset controller to free
+ *
+ * Deallocate a reset control allocated withd devm_reset_control_get().
+ * This function will not need to be called normally, as devres will take
+ * care of freeing the resource.
+ */
+void devm_reset_control_put(struct reset_control *rstc)
+{
+	int ret;
+
+	ret = devres_release(rstc->dev, devm_reset_control_release,
+			     devm_reset_control_match, rstc);
+	if (ret)
+		WARN_ON(ret);
+}
+EXPORT_SYMBOL_GPL(devm_reset_control_put);
+
+/**
+ * device_reset - find reset controller associated with the device
+ *                and perform reset
+ * @dev: device to be reset by the controller
+ *
+ * Convenience wrapper for reset_control_get() and reset_control_reset().
+ * This is useful for the common case of devices with single, dedicated reset
+ * lines.
+ */
+int device_reset(struct device *dev)
+{
+	struct reset_control *rstc;
+	int ret;
+
+	rstc = reset_control_get(dev, NULL);
+	if (IS_ERR(rstc))
+		return PTR_ERR(rstc);
+
+	ret = reset_control_reset(rstc);
+
+	reset_control_put(rstc);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(device_reset);
diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
new file mode 100644
index 0000000..2f61311
--- /dev/null
+++ b/include/linux/reset-controller.h
@@ -0,0 +1,51 @@
+#ifndef _LINUX_RESET_CONTROLLER_H_
+#define _LINUX_RESET_CONTROLLER_H_
+
+#include <linux/list.h>
+
+struct reset_controller_dev;
+
+/**
+ * struct reset_control_ops
+ *
+ * @reset: for self-deasserting resets, does all necessary
+ *         things to reset the device
+ * @assert: manually assert the reset line, if supported
+ * @deassert: manually deassert the reset line, if supported
+ */
+struct reset_control_ops {
+	int (*reset)(struct reset_controller_dev *rcdev, unsigned long id);
+	int (*assert)(struct reset_controller_dev *rcdev, unsigned long id);
+	int (*deassert)(struct reset_controller_dev *rcdev, unsigned long id);
+};
+
+struct module;
+struct device_node;
+
+/**
+ * struct reset_controller_dev - reset controller entity that might
+ *                               provide multiple reset controls
+ * @ops: a pointer to device specific struct reset_control_ops
+ * @owner: kernel module of the reset controller driver
+ * @list: internal list of reset controller devices
+ * @of_node: corresponding device tree node as phandle target
+ * @of_reset_n_cells: number of cells in reset line specifiers
+ * @of_xlate: translation function to translate from specifier as found in the
+ *            device tree to id as given to the reset control ops
+ * @nr_resets: number of reset controls in this reset controller device
+ */
+struct reset_controller_dev {
+	struct reset_control_ops *ops;
+	struct module *owner;
+	struct list_head list;
+	struct device_node *of_node;
+	int of_reset_n_cells;
+	int (*of_xlate)(struct reset_controller_dev *rcdev,
+			const struct of_phandle_args *reset_spec);
+	unsigned int nr_resets;
+};
+
+int reset_controller_register(struct reset_controller_dev *rcdev);
+void reset_controller_unregister(struct reset_controller_dev *rcdev);
+
+#endif
diff --git a/include/linux/reset.h b/include/linux/reset.h
new file mode 100644
index 0000000..6082247
--- /dev/null
+++ b/include/linux/reset.h
@@ -0,0 +1,17 @@
+#ifndef _LINUX_RESET_H_
+#define _LINUX_RESET_H_
+
+struct device;
+struct reset_control;
+
+int reset_control_reset(struct reset_control *rstc);
+int reset_control_assert(struct reset_control *rstc);
+int reset_control_deassert(struct reset_control *rstc);
+
+struct reset_control *reset_control_get(struct device *dev, const char *id);
+void reset_control_put(struct reset_control *rstc);
+struct reset_control *devm_reset_control_get(struct device *dev, const char *id);
+
+int device_reset(struct device *dev);
+
+#endif
-- 
1.8.2.rc2


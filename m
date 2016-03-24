From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v8 1/4] gadget: Introduce the usb charger framework
Date: Thu, 24 Mar 2016 20:35:54 +0800
Message-ID: <612d9e7b1444a2a26923ca97ef1eb1312016c8e0.1458822334.git.baolin.wang@linaro.org>
References: <cover.1458822334.git.baolin.wang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36672 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbcCXMgp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 08:36:45 -0400
Received: by mail-pa0-f53.google.com with SMTP id tt10so20672319pab.3
        for <linux-pm@vger.kernel.org>; Thu, 24 Mar 2016 05:36:45 -0700 (PDT)
In-Reply-To: <cover.1458822334.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1458822334.git.baolin.wang@linaro.org>
References: <cover.1458822334.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

This patch introduces the usb charger driver based on usb gadget that
makes an enhancement to a power driver. It works well in practice but
that requires a system with suitable hardware.

The basic conception of the usb charger is that, when one usb charger
is added or removed by reporting from the usb gadget state change or
the extcon device state change, the usb charger will report to power
user to set the current limitation.

The usb charger will register notifiees on the usb gadget or the extcon
device to get notified the usb charger state. It also supplies the
notification mechanism to userspace When the usb charger state is changed.

Power user will register a notifiee on the usb charger to get notified
by status changes from the usb charger. It will report to power user
to set the current limitation when detecting the usb charger is added
or removed from extcon device state or usb gadget state.

This patch doesn't yet integrate with the gadget code, so some functions
which rely on the 'gadget' are not completed, that will be implemented
in the following patches.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/gadget/Kconfig      |    7 +
 drivers/usb/gadget/Makefile     |    1 +
 drivers/usb/gadget/charger.c    |  675 +++++++++++++++++++++++++++++++++++++++
 include/linux/usb/usb_charger.h |  164 ++++++++++
 4 files changed, 847 insertions(+)
 create mode 100644 drivers/usb/gadget/charger.c
 create mode 100644 include/linux/usb/usb_charger.h

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index af5d922..82a5b3c 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -133,6 +133,13 @@ config U_SERIAL_CONSOLE
 	help
 	   It supports the serial gadget can be used as a console.
 
+config USB_CHARGER
+	bool "USB charger support"
+	help
+	  The usb charger driver based on the usb gadget that makes an
+	  enhancement to a power driver which can set the current limitation
+	  when the usb charger is added or removed.
+
 source "drivers/usb/gadget/udc/Kconfig"
 
 #
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 598a67d..1e421c1 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -10,3 +10,4 @@ libcomposite-y			:= usbstring.o config.o epautoconf.o
 libcomposite-y			+= composite.o functions.o configfs.o u_f.o
 
 obj-$(CONFIG_USB_GADGET)	+= udc/ function/ legacy/
+obj-$(CONFIG_USB_CHARGER)	+= charger.o
diff --git a/drivers/usb/gadget/charger.c b/drivers/usb/gadget/charger.c
new file mode 100644
index 0000000..861c144
--- /dev/null
+++ b/drivers/usb/gadget/charger.c
@@ -0,0 +1,675 @@
+/*
+ * charger.c -- USB charger driver
+ *
+ * Copyright (C) 2015 Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/extcon.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/usb_charger.h>
+#include <linux/power_supply.h>
+
+#define DEFAULT_CUR_PROTECT	(50)
+#define DEFAULT_SDP_CUR_LIMIT	(500 - DEFAULT_CUR_PROTECT)
+#define DEFAULT_DCP_CUR_LIMIT	(1500 - DEFAULT_CUR_PROTECT)
+#define DEFAULT_CDP_CUR_LIMIT	(1500 - DEFAULT_CUR_PROTECT)
+#define DEFAULT_ACA_CUR_LIMIT	(1500 - DEFAULT_CUR_PROTECT)
+#define UCHGER_STATE_LENGTH	(50)
+
+static DEFINE_IDA(usb_charger_ida);
+static struct bus_type usb_charger_subsys = {
+	.name           = "usb-charger",
+	.dev_name       = "usb-charger",
+};
+
+static struct usb_charger *dev_to_uchger(struct device *udev)
+{
+	return container_of(udev, struct usb_charger, dev);
+}
+
+/*
+ * Sysfs attributes:
+ *
+ * These sysfs attributes are used for showing and setting different type
+ * (SDP/DCP/CDP/ACA) chargers' current limitation.
+ */
+static ssize_t sdp_limit_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct usb_charger *uchger = dev_to_uchger(dev);
+
+	return sprintf(buf, "%d\n", uchger->cur_limit.sdp_cur_limit);
+}
+
+static ssize_t sdp_limit_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct usb_charger *uchger = dev_to_uchger(dev);
+	unsigned int sdp_limit;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &sdp_limit);
+	if (ret < 0)
+		return ret;
+
+	ret = usb_charger_set_cur_limit_by_type(uchger, SDP_TYPE, sdp_limit);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(sdp_limit);
+
+static ssize_t dcp_limit_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct usb_charger *uchger = dev_to_uchger(dev);
+
+	return sprintf(buf, "%d\n", uchger->cur_limit.dcp_cur_limit);
+}
+
+static ssize_t dcp_limit_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct usb_charger *uchger = dev_to_uchger(dev);
+	unsigned int dcp_limit;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &dcp_limit);
+	if (ret < 0)
+		return ret;
+
+	ret = usb_charger_set_cur_limit_by_type(uchger, DCP_TYPE, dcp_limit);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(dcp_limit);
+
+static ssize_t cdp_limit_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct usb_charger *uchger = dev_to_uchger(dev);
+
+	return sprintf(buf, "%d\n", uchger->cur_limit.cdp_cur_limit);
+}
+
+static ssize_t cdp_limit_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct usb_charger *uchger = dev_to_uchger(dev);
+	unsigned int cdp_limit;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &cdp_limit);
+	if (ret < 0)
+		return ret;
+
+	ret = usb_charger_set_cur_limit_by_type(uchger, CDP_TYPE, cdp_limit);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(cdp_limit);
+
+static ssize_t aca_limit_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct usb_charger *uchger = dev_to_uchger(dev);
+
+	return sprintf(buf, "%d\n", uchger->cur_limit.aca_cur_limit);
+}
+
+static ssize_t aca_limit_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct usb_charger *uchger = dev_to_uchger(dev);
+	unsigned int aca_limit;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &aca_limit);
+	if (ret < 0)
+		return ret;
+
+	ret = usb_charger_set_cur_limit_by_type(uchger, ACA_TYPE, aca_limit);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(aca_limit);
+
+static struct attribute *usb_charger_attrs[] = {
+	&dev_attr_sdp_limit.attr,
+	&dev_attr_dcp_limit.attr,
+	&dev_attr_cdp_limit.attr,
+	&dev_attr_aca_limit.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(usb_charger);
+
+/*
+ * usb_charger_find_by_name - Get the usb charger device by name.
+ * @name - usb charger device name.
+ *
+ * return the instance of usb charger device, the device must be
+ * released with usb_charger_put().
+ */
+struct usb_charger *usb_charger_find_by_name(const char *name)
+{
+	struct device *udev;
+
+	if (!name)
+		return ERR_PTR(-EINVAL);
+
+	udev = bus_find_device_by_name(&usb_charger_subsys, NULL, name);
+	if (!udev)
+		return ERR_PTR(-ENODEV);
+
+	return dev_to_uchger(udev);
+}
+EXPORT_SYMBOL_GPL(usb_charger_find_by_name);
+
+/*
+ * usb_charger_get() - Reference a usb charger.
+ * @uchger - usb charger
+ */
+struct usb_charger *usb_charger_get(struct usb_charger *uchger)
+{
+	return (uchger && get_device(&uchger->dev)) ? uchger : NULL;
+}
+EXPORT_SYMBOL_GPL(usb_charger_get);
+
+/*
+ * usb_charger_put() - Dereference a usb charger.
+ * @uchger - charger to release
+ */
+void usb_charger_put(struct usb_charger *uchger)
+{
+	if (uchger)
+		put_device(&uchger->dev);
+}
+EXPORT_SYMBOL_GPL(usb_charger_put);
+
+/*
+ * usb_charger_register_notify() - Register a notifiee to get notified by
+ * any attach status changes from the usb charger detection.
+ * @uchger - the usb charger device which is monitored.
+ * @nb - a notifier block to be registered.
+ */
+int usb_charger_register_notify(struct usb_charger *uchger,
+				struct notifier_block *nb)
+{
+	int ret;
+
+	if (!uchger || !nb)
+		return -EINVAL;
+
+	mutex_lock(&uchger->lock);
+	ret = raw_notifier_chain_register(&uchger->uchger_nh, nb);
+
+	/* Generate an initial notify so users start in the right state */
+	if (!ret) {
+		usb_charger_detect_type(uchger);
+		raw_notifier_call_chain(&uchger->uchger_nh,
+					usb_charger_get_cur_limit(uchger),
+					uchger);
+	}
+	mutex_unlock(&uchger->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_charger_register_notify);
+
+/*
+ * usb_charger_unregister_notify() - Unregister a notifiee from the usb charger.
+ * @uchger - the usb charger device which is monitored.
+ * @nb - a notifier block to be unregistered.
+ */
+int usb_charger_unregister_notify(struct usb_charger *uchger,
+				  struct notifier_block *nb)
+{
+	int ret;
+
+	if (!uchger || !nb)
+		return -EINVAL;
+
+	mutex_lock(&uchger->lock);
+	ret = raw_notifier_chain_unregister(&uchger->uchger_nh, nb);
+	mutex_unlock(&uchger->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_charger_unregister_notify);
+
+/*
+ * usb_charger_detect_type() - Get the usb charger type by the callback
+ * which is implemented by gadget operations.
+ * @uchger - the usb charger device.
+ *
+ * return the usb charger type.
+ */
+enum usb_charger_type
+usb_charger_detect_type(struct usb_charger *uchger)
+{
+	if (uchger->psy) {
+		union power_supply_propval val;
+
+		power_supply_get_property(uchger->psy,
+					  POWER_SUPPLY_PROP_CHARGE_TYPE,
+					  &val);
+		switch (val.intval) {
+		case POWER_SUPPLY_TYPE_USB:
+			uchger->type = SDP_TYPE;
+			break;
+		case POWER_SUPPLY_TYPE_USB_DCP:
+			uchger->type = DCP_TYPE;
+			break;
+		case POWER_SUPPLY_TYPE_USB_CDP:
+			uchger->type = CDP_TYPE;
+			break;
+		case POWER_SUPPLY_TYPE_USB_ACA:
+			uchger->type = ACA_TYPE;
+			break;
+		default:
+			uchger->type = UNKNOWN_TYPE;
+			break;
+		}
+	} else if (uchger->get_charger_type) {
+		uchger->type = uchger->get_charger_type(uchger);
+	} else {
+		uchger->type = UNKNOWN_TYPE;
+	}
+
+	return uchger->type;
+}
+EXPORT_SYMBOL_GPL(usb_charger_detect_type);
+
+/*
+ * usb_charger_set_cur_limit_by_type() - Set the current limitation
+ * by charger type.
+ * @uchger - the usb charger device.
+ * @type - the usb charger type.
+ * @cur_limit - the current limitation.
+ */
+int usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
+				      enum usb_charger_type type,
+				      unsigned int cur_limit)
+{
+	if (!uchger)
+		return -EINVAL;
+
+	switch (type) {
+	case SDP_TYPE:
+		uchger->cur_limit.sdp_cur_limit = cur_limit;
+		break;
+	case DCP_TYPE:
+		uchger->cur_limit.dcp_cur_limit = cur_limit;
+		break;
+	case CDP_TYPE:
+		uchger->cur_limit.cdp_cur_limit	= cur_limit;
+		break;
+	case ACA_TYPE:
+		uchger->cur_limit.aca_cur_limit	= cur_limit;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_charger_set_cur_limit_by_type);
+
+/*
+ * usb_charger_set_cur_limit() - Set the current limitation.
+ * @uchger - the usb charger device.
+ * @cur_limit_set - the current limitation.
+ */
+int usb_charger_set_cur_limit(struct usb_charger *uchger,
+			      struct usb_charger_cur_limit *cur_limit_set)
+{
+	if (!uchger || !cur_limit_set)
+		return -EINVAL;
+
+	uchger->cur_limit.sdp_cur_limit = cur_limit_set->sdp_cur_limit;
+	uchger->cur_limit.dcp_cur_limit = cur_limit_set->dcp_cur_limit;
+	uchger->cur_limit.cdp_cur_limit = cur_limit_set->cdp_cur_limit;
+	uchger->cur_limit.aca_cur_limit = cur_limit_set->aca_cur_limit;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_charger_set_cur_limit);
+
+/*
+ * usb_charger_get_cur_limit() - Get the current limitation by
+ * different usb charger type.
+ * @uchger - the usb charger device.
+ *
+ * return the current limitation to set.
+ */
+unsigned int
+usb_charger_get_cur_limit(struct usb_charger *uchger)
+{
+	enum usb_charger_type uchger_type = usb_charger_detect_type(uchger);
+	unsigned int cur_limit;
+
+	switch (uchger_type) {
+	case SDP_TYPE:
+		cur_limit = uchger->cur_limit.sdp_cur_limit;
+		break;
+	case DCP_TYPE:
+		cur_limit = uchger->cur_limit.dcp_cur_limit;
+		break;
+	case CDP_TYPE:
+		cur_limit = uchger->cur_limit.cdp_cur_limit;
+		break;
+	case ACA_TYPE:
+		cur_limit = uchger->cur_limit.aca_cur_limit;
+		break;
+	default:
+		return 0;
+	}
+
+	return cur_limit;
+}
+EXPORT_SYMBOL_GPL(usb_charger_get_cur_limit);
+
+/*
+ * usb_charger_notifier_others() - It will notify other device registered
+ * on usb charger when the usb charger state is changed.
+ * @uchger - the usb charger device.
+ * @state - the state of the usb charger.
+ */
+static void
+usb_charger_notify_others(struct usb_charger *uchger,
+			  enum usb_charger_state state)
+{
+	char uchger_state[UCHGER_STATE_LENGTH];
+	char *envp[] = { uchger_state, NULL };
+
+	mutex_lock(&uchger->lock);
+	uchger->state = state;
+
+	switch (state) {
+	case USB_CHARGER_PRESENT:
+		usb_charger_detect_type(uchger);
+		raw_notifier_call_chain(&uchger->uchger_nh,
+			usb_charger_get_cur_limit(uchger),
+			uchger);
+		snprintf(uchger_state, UCHGER_STATE_LENGTH,
+			 "USB_CHARGER_STATE=%s", "USB_CHARGER_PRESENT");
+		break;
+	case USB_CHARGER_REMOVE:
+		uchger->type = UNKNOWN_TYPE;
+		raw_notifier_call_chain(&uchger->uchger_nh, 0, uchger);
+		snprintf(uchger_state, UCHGER_STATE_LENGTH,
+			 "USB_CHARGER_STATE=%s", "USB_CHARGER_REMOVE");
+		break;
+	default:
+		dev_warn(&uchger->dev, "Unknown USB charger state: %d\n",
+			 state);
+		mutex_unlock(&uchger->lock);
+		return;
+	}
+
+	kobject_uevent_env(&uchger->dev.kobj, KOBJ_CHANGE, envp);
+	mutex_unlock(&uchger->lock);
+}
+
+/*
+ * usb_charger_plug_by_extcon() - The notifier call function which is registered
+ * on the extcon device.
+ * @nb - the notifier block that notified by extcon device.
+ * @state - the extcon device state.
+ * @data - here specify a extcon device.
+ *
+ * return the notify flag.
+ */
+static int
+usb_charger_plug_by_extcon(struct notifier_block *nb,
+			   unsigned long state, void *data)
+{
+	struct usb_charger_nb *extcon_nb =
+		container_of(nb, struct usb_charger_nb, nb);
+	struct usb_charger *uchger = extcon_nb->uchger;
+	enum usb_charger_state uchger_state;
+
+	if (!uchger)
+		return NOTIFY_BAD;
+
+	/* Report event to power to setting the current limitation
+	 * for this usb charger when one usb charger is added or removed
+	 * with detecting by extcon device.
+	 */
+	if (state)
+		uchger_state = USB_CHARGER_PRESENT;
+	else
+		uchger_state = USB_CHARGER_REMOVE;
+
+	usb_charger_notify_others(uchger, uchger_state);
+
+	return NOTIFY_OK;
+}
+
+/*
+ * usb_charger_plug_by_gadget() - Set the usb charger current limitation
+ * according to the usb gadget device state.
+ * @gadget - the usb gadget device.
+ * @state - the usb gadget state.
+ */
+int usb_charger_plug_by_gadget(struct usb_gadget *gadget,
+			       unsigned long state)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(usb_charger_plug_by_gadget);
+
+static int devm_uchger_dev_match(struct device *dev, void *res, void *data)
+{
+	struct usb_charger **r = res;
+
+	if (WARN_ON(!r || !*r))
+		return 0;
+
+	return *r == data;
+}
+
+static void usb_charger_release(struct device *dev)
+{
+	struct usb_charger *uchger = dev_get_drvdata(dev);
+
+	kfree(uchger);
+}
+
+/*
+ * usb_charger_unregister() - Unregister a usb charger device.
+ * @uchger - the usb charger to be unregistered.
+ */
+static int usb_charger_unregister(struct usb_charger *uchger)
+{
+	if (!uchger)
+		return -EINVAL;
+
+	device_unregister(&uchger->dev);
+	return 0;
+}
+
+static void devm_uchger_dev_unreg(struct device *dev, void *res)
+{
+	usb_charger_unregister(*(struct usb_charger **)res);
+}
+
+void devm_usb_charger_unregister(struct device *dev,
+				 struct usb_charger *uchger)
+{
+	devres_release(dev, devm_uchger_dev_unreg,
+		       devm_uchger_dev_match, uchger);
+}
+
+/*
+ * usb_charger_register() - Register a new usb charger device
+ * which is created by the usb charger framework.
+ * @parent - the parent device of the new usb charger.
+ * @uchger - the new usb charger device.
+ */
+static int usb_charger_register(struct device *parent,
+				struct usb_charger *uchger)
+{
+	int ret;
+
+	if (!uchger)
+		return -EINVAL;
+
+	uchger->dev.parent = parent;
+	uchger->dev.release = usb_charger_release;
+	uchger->dev.bus = &usb_charger_subsys;
+	uchger->dev.groups = usb_charger_groups;
+
+	ret = ida_simple_get(&usb_charger_ida, 0, 0, GFP_KERNEL);
+	if (ret < 0)
+		goto fail_ida;
+
+	uchger->id = ret;
+	dev_set_name(&uchger->dev, "usb-charger.%d", uchger->id);
+	dev_set_drvdata(&uchger->dev, uchger);
+
+	ret = device_register(&uchger->dev);
+	if (ret)
+		goto fail_register;
+
+	return 0;
+
+fail_register:
+	put_device(&uchger->dev);
+	ida_simple_remove(&usb_charger_ida, uchger->id);
+	uchger->id = -1;
+fail_ida:
+	dev_err(parent, "Failed to register usb charger: %d\n", ret);
+	return ret;
+}
+
+int devm_usb_charger_register(struct device *dev,
+			      struct usb_charger *uchger)
+{
+	struct usb_charger **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_uchger_dev_unreg, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = usb_charger_register(dev, uchger);
+	if (ret) {
+		devres_free(ptr);
+		return ret;
+	}
+
+	*ptr = uchger;
+	devres_add(dev, ptr);
+
+	return 0;
+}
+
+int usb_charger_init(struct usb_gadget *ugadget)
+{
+	struct usb_charger *uchger;
+	struct extcon_dev *edev;
+	struct power_supply *psy;
+	int ret;
+
+	if (!ugadget)
+		return -EINVAL;
+
+	uchger = kzalloc(sizeof(struct usb_charger), GFP_KERNEL);
+	if (!uchger)
+		return -ENOMEM;
+
+	uchger->type = UNKNOWN_TYPE;
+	uchger->state = USB_CHARGER_DEFAULT;
+	uchger->id = -1;
+	uchger->cur_limit.sdp_cur_limit = DEFAULT_SDP_CUR_LIMIT;
+	uchger->cur_limit.dcp_cur_limit = DEFAULT_DCP_CUR_LIMIT;
+	uchger->cur_limit.cdp_cur_limit = DEFAULT_CDP_CUR_LIMIT;
+	uchger->cur_limit.aca_cur_limit = DEFAULT_ACA_CUR_LIMIT;
+	uchger->get_charger_type = NULL;
+
+	mutex_init(&uchger->lock);
+	RAW_INIT_NOTIFIER_HEAD(&uchger->uchger_nh);
+
+	/* register a notifier on a extcon device if it is exsited */
+	edev = extcon_get_edev_by_phandle(ugadget->dev.parent, 0);
+	if (!IS_ERR_OR_NULL(edev)) {
+		uchger->extcon_dev = edev;
+		uchger->extcon_nb.nb.notifier_call = usb_charger_plug_by_extcon;
+		uchger->extcon_nb.uchger = uchger;
+		extcon_register_notifier(edev, EXTCON_USB,
+					 &uchger->extcon_nb.nb);
+	}
+
+	/* to check if the usb charger is link to a power supply */
+	psy = devm_power_supply_get_by_phandle(ugadget->dev.parent,
+					       "power-supplies");
+	if (!IS_ERR_OR_NULL(psy))
+		uchger->psy = psy;
+	else
+		uchger->psy = NULL;
+
+	/* register a notifier on a usb gadget device */
+	uchger->gadget = ugadget;
+	uchger->old_gadget_state = ugadget->state;
+
+	/* register a new usb charger */
+	ret = usb_charger_register(&ugadget->dev, uchger);
+	if (ret)
+		goto fail;
+
+	return 0;
+
+fail:
+	if (uchger->extcon_dev)
+		extcon_unregister_notifier(uchger->extcon_dev,
+					   EXTCON_USB, &uchger->extcon_nb.nb);
+
+	kfree(uchger);
+	return ret;
+}
+
+int usb_charger_exit(struct usb_gadget *ugadget)
+{
+	return 0;
+}
+
+static int __init usb_charger_sysfs_init(void)
+{
+	return subsys_system_register(&usb_charger_subsys, NULL);
+}
+core_initcall(usb_charger_sysfs_init);
+
+MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
+MODULE_DESCRIPTION("USB charger driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/usb/usb_charger.h b/include/linux/usb/usb_charger.h
new file mode 100644
index 0000000..eed422f
--- /dev/null
+++ b/include/linux/usb/usb_charger.h
@@ -0,0 +1,164 @@
+#ifndef __LINUX_USB_CHARGER_H__
+#define __LINUX_USB_CHARGER_H__
+
+#include <uapi/linux/usb/ch9.h>
+
+/* USB charger type:
+ * SDP (Standard Downstream Port)
+ * DCP (Dedicated Charging Port)
+ * CDP (Charging Downstream Port)
+ * ACA (Accessory Charger Adapters)
+ */
+enum usb_charger_type {
+	UNKNOWN_TYPE,
+	SDP_TYPE,
+	DCP_TYPE,
+	CDP_TYPE,
+	ACA_TYPE,
+};
+
+/* USB charger state */
+enum usb_charger_state {
+	USB_CHARGER_DEFAULT,
+	USB_CHARGER_PRESENT,
+	USB_CHARGER_REMOVE,
+};
+
+/* Current limitation by charger type */
+struct usb_charger_cur_limit {
+	unsigned int sdp_cur_limit;
+	unsigned int dcp_cur_limit;
+	unsigned int cdp_cur_limit;
+	unsigned int aca_cur_limit;
+};
+
+struct usb_charger_nb {
+	struct notifier_block	nb;
+	struct usb_charger	*uchger;
+};
+
+struct usb_charger {
+	struct device		dev;
+	struct raw_notifier_head	uchger_nh;
+	/* protect the notifier head */
+	struct mutex		lock;
+	int			id;
+	enum usb_charger_type	type;
+	enum usb_charger_state	state;
+
+	/* for supporting extcon usb gpio */
+	struct extcon_dev	*extcon_dev;
+	struct usb_charger_nb	extcon_nb;
+
+	/* for supporting usb gadget */
+	struct usb_gadget	*gadget;
+	enum usb_device_state	old_gadget_state;
+
+	/* for supporting power supply */
+	struct power_supply	*psy;
+
+	/* user can get charger type by implementing this callback */
+	enum usb_charger_type	(*get_charger_type)(struct usb_charger *);
+
+	/* current limitation */
+	struct usb_charger_cur_limit	cur_limit;
+};
+
+#ifdef CONFIG_USB_CHARGER
+extern struct usb_charger *usb_charger_find_by_name(const char *name);
+
+extern struct usb_charger *usb_charger_get(struct usb_charger *uchger);
+extern void usb_charger_put(struct usb_charger *uchger);
+
+extern int usb_charger_register_notify(struct usb_charger *uchger,
+				       struct notifier_block *nb);
+extern int usb_charger_unregister_notify(struct usb_charger *uchger,
+					 struct notifier_block *nb);
+
+extern int usb_charger_set_cur_limit(struct usb_charger *uchger,
+				struct usb_charger_cur_limit *cur_limit_set);
+extern int usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
+					     enum usb_charger_type type,
+					     unsigned int cur_limit);
+extern unsigned int usb_charger_get_cur_limit(struct usb_charger *uchger);
+
+extern enum usb_charger_type usb_charger_detect_type(struct usb_charger *uchger);
+extern int usb_charger_plug_by_gadget(struct usb_gadget *gadget,
+				      unsigned long state);
+
+extern int usb_charger_init(struct usb_gadget *ugadget);
+extern int usb_charger_exit(struct usb_gadget *ugadget);
+#else
+static inline struct usb_charger *usb_charger_find_by_name(const char *name)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct usb_charger *usb_charger_get(struct usb_charger *uchger)
+{
+	return NULL;
+}
+
+static inline void usb_charger_put(struct usb_charger *uchger)
+{
+}
+
+static inline int
+usb_charger_register_notify(struct usb_charger *uchger,
+			    struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int
+usb_charger_unregister_notify(struct usb_charger *uchger,
+			      struct notifier_block *nb)
+{
+	return 0;
+}
+
+static inline int
+usb_charger_set_cur_limit(struct usb_charger *uchger,
+			  struct usb_charger_cur_limit *cur_limit_set)
+{
+	return 0;
+}
+
+static inline int
+usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
+				  enum usb_charger_type type,
+				  unsigned int cur_limit)
+{
+	return 0;
+}
+
+static inline unsigned int
+usb_charger_get_cur_limit(struct usb_charger *uchger)
+{
+	return 0;
+}
+
+static inline enum usb_charger_type
+usb_charger_detect_type(struct usb_charger *uchger)
+{
+	return UNKNOWN_TYPE;
+}
+
+static inline int
+usb_charger_plug_by_gadget(struct usb_gadget *gadget, unsigned long state)
+{
+	return 0;
+}
+
+static inline int usb_charger_init(struct usb_gadget *ugadget)
+{
+	return 0;
+}
+
+static inline int usb_charger_exit(struct usb_gadget *ugadget)
+{
+	return 0;
+}
+#endif
+
+#endif /* __LINUX_USB_CHARGER_H__ */
-- 
1.7.9.5


From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v3 2/3] gadget: Introduce the usb charger framework
Date: Tue, 18 Aug 2015 19:14:20 +0800
Message-ID: <954d267dd6f98641e9278db9771d19dba86b6f4f.1439866451.git.baolin.wang@linaro.org>
References: <cover.1439866451.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1439866451.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1439866451.git.baolin.wang@linaro.org>
References: <cover.1439866451.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: broonie@kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This patch introduces the usb charger driver based on usb gadget that
makes an enhancement to a power driver. It works well in practice but
that requires a system with suitable hardware.

The basic conception of the usb charger is that, when one usb charger
is added or removed by reporting from the usb gadget state change or
the extcon device state change, the usb charger will report to power
user to set the current limitation.

The usb charger will register notifiees on the usb gadget or the extcon
device to get notified the usb charger state.

Power user will register a notifiee on the usb charger to get notified
by status changes from the usb charger. It will report to power user
to set the current limitation when detecting the usb charger is added
or removed from extcon device state or usb gadget state.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/gadget/Kconfig      |    7 +
 drivers/usb/gadget/Makefile     |    1 +
 drivers/usb/gadget/charger.c    |  538 +++++++++++++++++++++++++++++++++++++++
 include/linux/usb/usb_charger.h |  138 ++++++++++
 4 files changed, 684 insertions(+)
 create mode 100644 drivers/usb/gadget/charger.c
 create mode 100644 include/linux/usb/usb_charger.h

diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index bcf83c0..3d2b959 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -127,6 +127,13 @@ config USB_GADGET_STORAGE_NUM_BUFFERS
 	   a module parameter as well.
 	   If unsure, say 2.
 
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
index 0000000..93fd36f
--- /dev/null
+++ b/drivers/usb/gadget/charger.c
@@ -0,0 +1,538 @@
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
+
+#define DEFAULT_CUR_PROTECT	(50)
+#define DEFAULT_SDP_CUR_LIMIT	(500 - DEFAULT_CUR_PROTECT)
+#define DEFAULT_DCP_CUR_LIMIT	(1500 - DEFAULT_CUR_PROTECT)
+#define DEFAULT_CDP_CUR_LIMIT	(1500 - DEFAULT_CUR_PROTECT)
+#define DEFAULT_ACA_CUR_LIMIT	(1500 - DEFAULT_CUR_PROTECT)
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
+static ssize_t cur_limit_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct usb_charger *uchger = dev_to_uchger(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d %d %d %d\n",
+			 uchger->cur_limit.sdp_cur_limit,
+			 uchger->cur_limit.dcp_cur_limit,
+			 uchger->cur_limit.cdp_cur_limit,
+			 uchger->cur_limit.aca_cur_limit);
+}
+
+static ssize_t cur_limit_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	struct usb_charger *uchger = dev_to_uchger(dev);
+	struct usb_charger_cur_limit cur;
+	int ret;
+
+	ret = sscanf(buf, "%d %d %d %d",
+		     &cur.sdp_cur_limit, &cur.dcp_cur_limit,
+		     &cur.cdp_cur_limit, &cur.aca_cur_limit);
+	if (ret == 0)
+		return -EINVAL;
+
+	ret = usb_charger_set_cur_limit(uchger, &cur);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+static DEVICE_ATTR_RW(cur_limit);
+
+static struct attribute *usb_charger_attrs[] = {
+	&dev_attr_cur_limit.attr,
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
+
+/*
+ * usb_charger_get() - Reference a usb charger.
+ * @uchger - usb charger
+ */
+struct usb_charger *usb_charger_get(struct usb_charger *uchger)
+{
+	return (uchger && get_device(&uchger->dev)) ? uchger : NULL;
+}
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
+	if (uchger->gadget && uchger->gadget->ops
+	    && uchger->gadget->ops->get_charger_type)
+		uchger->type =
+			uchger->gadget->ops->get_charger_type(uchger->gadget);
+	else
+		uchger->type = UNKNOWN_TYPE;
+
+	return uchger->type;
+}
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
+	enum usb_charger_type uchger_type = uchger->type;
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
+	mutex_lock(&uchger->lock);
+	uchger->state = state;
+
+	switch (state) {
+	case USB_CHARGER_PRESENT:
+		usb_charger_detect_type(uchger);
+		raw_notifier_call_chain(&uchger->uchger_nh,
+			usb_charger_get_cur_limit(uchger),
+			uchger);
+		break;
+	case USB_CHARGER_REMOVE:
+		uchger->type = UNKNOWN_TYPE;
+		raw_notifier_call_chain(&uchger->uchger_nh, 0, uchger);
+		break;
+	default:
+		dev_warn(&uchger->dev, "Unknown USB charger state: %d\n",
+			 state);
+		break;
+	}
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
+ * @nb - the notifier block that notified by usb gadget device.
+ * @state - the usb gadget state.
+ * @data - here specify a usb gadget device.
+ */
+static int
+usb_charger_plug_by_gadget(struct notifier_block *nb,
+			   unsigned long state, void *data)
+{
+	struct usb_gadget *gadget = (struct usb_gadget *)data;
+	struct usb_charger *uchger = gadget->uchger;
+	enum usb_charger_state uchger_state;
+
+	if (!uchger)
+		return NOTIFY_BAD;
+
+	/* Report event to power to setting the current limitation
+	 * for this usb charger when one usb charger state is changed
+	 * with detecting by usb gadget state.
+	 */
+	if (uchger->old_gadget_state != state) {
+		uchger->old_gadget_state = state;
+
+		if (state >= USB_STATE_ATTACHED)
+			uchger_state = USB_CHARGER_PRESENT;
+		else if (state == USB_STATE_NOTATTACHED)
+			uchger_state = USB_CHARGER_REMOVE;
+		else
+			uchger_state = USB_CHARGER_DEFAULT;
+
+		usb_charger_notify_others(uchger, uchger_state);
+	}
+
+	return NOTIFY_OK;
+}
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
+		extcon_register_notifier(edev, EXTCON_USB, &uchger->extcon_nb.nb);
+	}
+
+	/* register a notifier on a usb gadget device */
+	uchger->gadget = ugadget;
+	ugadget->uchger = uchger;
+	uchger->old_gadget_state = ugadget->state;
+	uchger->gadget_nb.notifier_call = usb_charger_plug_by_gadget;
+	usb_gadget_register_notify(ugadget, &uchger->gadget_nb);
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
+	usb_gadget_unregister_notify(uchger->gadget, &uchger->gadget_nb);
+	kfree(uchger);
+	return ret;
+}
+
+int usb_charger_exit(struct usb_gadget *ugadget)
+{
+	struct usb_charger *uchger = ugadget->uchger;
+
+	if (!uchger)
+		return -EINVAL;
+
+	if (uchger->extcon_dev)
+		extcon_unregister_notifier(uchger->extcon_dev,
+					   EXTCON_USB, &uchger->extcon_nb.nb);
+
+	usb_gadget_unregister_notify(uchger->gadget, &uchger->gadget_nb);
+	ida_simple_remove(&usb_charger_ida, uchger->id);
+
+	return usb_charger_unregister(uchger);
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
index 0000000..99bc26f
--- /dev/null
+++ b/include/linux/usb/usb_charger.h
@@ -0,0 +1,138 @@
+#ifndef __LINUX_USB_CHARGER_H__
+#define __LINUX_USB_CHARGER_H__
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
+	struct notifier_block	gadget_nb;
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
+extern unsigned int usb_charger_get_cur_limit(struct usb_charger *uchger);
+
+extern enum usb_charger_type usb_charger_detect_type(struct usb_charger *uchger);
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

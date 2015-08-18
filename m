From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v3 1/3] gadget: Support for the usb charger framework
Date: Tue, 18 Aug 2015 19:14:19 +0800
Message-ID: <6a4d68543dcffe76993dc70d94a0a04617ef2257.1439866451.git.baolin.wang@linaro.org>
References: <cover.1439866451.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1439866451.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1439866451.git.baolin.wang@linaro.org>
References: <cover.1439866451.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: broonie@kernel.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The usb charger framework is based on usb gadget, and each usb gadget
can be one usb charger to set the current limitation.

This patch adds a notifier mechanism for usb charger to report to usb
charger when the usb gadget state is changed.

Also we introduce a callback 'get_charger_type' which will implemented
by user for usb gadget operations to get the usb charger type.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/gadget/udc/udc-core.c |   41 ++++++++++++++++++++++++++++++++++++-
 include/linux/usb/gadget.h        |   20 ++++++++++++++++++
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index f660afb..1971218 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -28,6 +28,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb.h>
+#include <linux/usb/usb_charger.h>
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -129,6 +130,32 @@ void usb_gadget_giveback_request(struct usb_ep *ep,
 }
 EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
 
+int usb_gadget_register_notify(struct usb_gadget *gadget,
+			       struct notifier_block *nb)
+{
+	int ret;
+
+	mutex_lock(&gadget->lock);
+	ret = raw_notifier_chain_register(&gadget->nh, nb);
+	mutex_unlock(&gadget->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_register_notify);
+
+int usb_gadget_unregister_notify(struct usb_gadget *gadget,
+				 struct notifier_block *nb)
+{
+	int ret;
+
+	mutex_lock(&gadget->lock);
+	ret = raw_notifier_chain_unregister(&gadget->nh, nb);
+	mutex_unlock(&gadget->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_unregister_notify);
+
 /* ------------------------------------------------------------------------- */
 
 /**
@@ -226,6 +253,10 @@ static void usb_gadget_state_work(struct work_struct *work)
 	struct usb_gadget *gadget = work_to_gadget(work);
 	struct usb_udc *udc = gadget->udc;
 
+	mutex_lock(&gadget->lock);
+	raw_notifier_call_chain(&gadget->nh, gadget->state, gadget);
+	mutex_unlock(&gadget->lock);
+
 	if (udc)
 		sysfs_notify(&udc->dev.kobj, NULL, "state");
 }
@@ -364,6 +395,8 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 
 	dev_set_name(&gadget->dev, "gadget");
 	INIT_WORK(&gadget->work, usb_gadget_state_work);
+	RAW_INIT_NOTIFIER_HEAD(&gadget->nh);
+	mutex_init(&gadget->lock);
 	gadget->dev.parent = parent;
 
 #ifdef	CONFIG_HAS_DMA
@@ -405,8 +438,13 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 
 	mutex_unlock(&udc_lock);
 
-	return 0;
+	ret = usb_charger_init(gadget);
+	if (ret)
+		goto err5;
 
+	return 0;
+err5:
+	device_del(&udc->dev);
 err4:
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
@@ -481,6 +519,7 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
+	usb_charger_exit(gadget);
 	device_unregister(&gadget->dev);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index c14a69b..78cc862 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -537,6 +537,7 @@ struct usb_gadget_ops {
 	struct usb_ep *(*match_ep)(struct usb_gadget *,
 			struct usb_endpoint_descriptor *,
 			struct usb_ss_ep_comp_descriptor *);
+	enum usb_charger_type	(*get_charger_type)(struct usb_gadget *);
 };
 
 /**
@@ -609,6 +610,9 @@ struct usb_gadget {
 	unsigned			out_epnum;
 	unsigned			in_epnum;
 	struct usb_otg_caps		*otg_caps;
+	struct raw_notifier_head	nh;
+	struct usb_charger		*uchger;
+	struct mutex			lock;
 
 	unsigned			sg_supported:1;
 	unsigned			is_otg:1;
@@ -1183,6 +1187,22 @@ extern void usb_gadget_unmap_request(struct usb_gadget *gadget,
 
 /*-------------------------------------------------------------------------*/
 
+/**
+ * Register a notifiee to get notified by any attach status changes from
+ * the usb gadget
+ */
+int usb_gadget_register_notify(struct usb_gadget *gadget,
+			       struct notifier_block *nb);
+
+/*-------------------------------------------------------------------------*/
+
+
+/* Unregister a notifiee from the usb gadget */
+int usb_gadget_unregister_notify(struct usb_gadget *gadget,
+				 struct notifier_block *nb);
+
+/*-------------------------------------------------------------------------*/
+
 /* utility to set gadget state properly */
 
 extern void usb_gadget_set_state(struct usb_gadget *gadget,
-- 
1.7.9.5

From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Thu, 24 Sep 2015 10:39:23 -0700
Message-ID: <e58e4f26028c37877d02907831cf4ae411eaf984.1443057231.git.baolin.wang@linaro.org>
References: <cover.1443057229.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1443057229.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1443057229.git.baolin.wang@linaro.org>
References: <cover.1443057229.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: gregkh@linuxfoundation.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, baolin.wang@linaro.org
List-Id: linux-pm@vger.kernel.org

The usb charger framework is based on usb gadget. The usb charger
need to be notified the state changing of usb gadget to confirm the
usb charger state.

Thus this patch adds a notifier mechanism for usb gadget to report a
event to usb charger when the usb gadget state is changed.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/gadget/udc/udc-core.c | 32 ++++++++++++++++++++++++++++++++
 include/linux/usb/gadget.h        | 18 ++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index f660afb..4238fc3 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -129,6 +129,32 @@ void usb_gadget_giveback_request(struct usb_ep *ep,
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
@@ -226,6 +252,10 @@ static void usb_gadget_state_work(struct work_struct *work)
 	struct usb_gadget *gadget = work_to_gadget(work);
 	struct usb_udc *udc = gadget->udc;
 
+	mutex_lock(&gadget->lock);
+	raw_notifier_call_chain(&gadget->nh, gadget->state, gadget);
+	mutex_unlock(&gadget->lock);
+
 	if (udc)
 		sysfs_notify(&udc->dev.kobj, NULL, "state");
 }
@@ -364,6 +394,8 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 
 	dev_set_name(&gadget->dev, "gadget");
 	INIT_WORK(&gadget->work, usb_gadget_state_work);
+	RAW_INIT_NOTIFIER_HEAD(&gadget->nh);
+	mutex_init(&gadget->lock);
 	gadget->dev.parent = parent;
 
 #ifdef	CONFIG_HAS_DMA
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index c14a69b..755e8bc 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -609,6 +609,8 @@ struct usb_gadget {
 	unsigned			out_epnum;
 	unsigned			in_epnum;
 	struct usb_otg_caps		*otg_caps;
+	struct raw_notifier_head	nh;
+	struct mutex			lock;
 
 	unsigned			sg_supported:1;
 	unsigned			is_otg:1;
@@ -1183,6 +1185,22 @@ extern void usb_gadget_unmap_request(struct usb_gadget *gadget,
 
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
1.9.1

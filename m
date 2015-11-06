From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v5 3/5] gadget: Support for the usb charger framework
Date: Fri,  6 Nov 2015 19:35:12 +0800
Message-ID: <ff4410e184539254039ffa8c7547995841029a67.1446807916.git.baolin.wang@linaro.org>
References: <cover.1446807915.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446807915.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1446807915.git.baolin.wang@linaro.org>
References: <cover.1446807915.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

For supporting the usb charger, it adds the usb_charger_init() and
usb_charger_exit() functions for usb charger initialization and exit.

Introduce a callback 'get_charger_type' which will implemented by
user for usb gadget operations to get the usb charger type.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/gadget/udc/udc-core.c |    8 ++++++++
 include/linux/usb/gadget.h        |    9 +++++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 4238fc3..370376e 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -28,6 +28,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb.h>
+#include <linux/usb/usb_charger.h>
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -437,8 +438,14 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 
 	mutex_unlock(&udc_lock);
 
+	ret = usb_charger_init(gadget);
+	if (ret)
+		goto err5;
+
 	return 0;
 
+err5:
+	device_del(&udc->dev);
 err4:
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
@@ -513,6 +520,7 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
+	usb_charger_exit(gadget);
 	device_unregister(&gadget->dev);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 755e8bc..c2610c4 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/usb/ch9.h>
+#include <linux/usb/usb_charger.h>
 
 struct usb_ep;
 
@@ -537,6 +538,7 @@ struct usb_gadget_ops {
 	struct usb_ep *(*match_ep)(struct usb_gadget *,
 			struct usb_endpoint_descriptor *,
 			struct usb_ss_ep_comp_descriptor *);
+	enum usb_charger_type (*get_charger_type)(struct usb_gadget *);
 };
 
 /**
@@ -611,6 +613,7 @@ struct usb_gadget {
 	struct usb_otg_caps		*otg_caps;
 	struct raw_notifier_head	nh;
 	struct mutex			lock;
+	struct usb_charger		*charger;
 
 	unsigned			sg_supported:1;
 	unsigned			is_otg:1;
@@ -815,10 +818,16 @@ static inline int usb_gadget_vbus_connect(struct usb_gadget *gadget)
  * reporting how much power the device may consume.  For example, this
  * could affect how quickly batteries are recharged.
  *
+ * It will also notify the USB charger how much power the device may
+ * consume if there is a USB charger linking with the gadget.
+ *
  * Returns zero on success, else negative errno.
  */
 static inline int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
+	if (gadget->charger)
+		usb_charger_set_cur_limit_by_type(gadget->charger, mA);
+
 	if (!gadget->ops->vbus_draw)
 		return -EOPNOTSUPP;
 	return gadget->ops->vbus_draw(gadget, mA);
-- 
1.7.9.5

From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v6 2/4] gadget: Support for the usb charger framework
Date: Mon, 16 Nov 2015 14:33:32 +0800
Message-ID: <7919ed1aa73d419b7b422e9545e5c2af2b97c233.1447654606.git.baolin.wang@linaro.org>
References: <cover.1447654605.git.baolin.wang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33695 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543AbbKPGeM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 01:34:12 -0500
Received: by pabfh17 with SMTP id fh17so167181893pab.0
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2015 22:34:11 -0800 (PST)
In-Reply-To: <cover.1447654605.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1447654605.git.baolin.wang@linaro.org>
References: <cover.1447654605.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: balbi@ti.com, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

For supporting the usb charger, it adds the usb_charger_init() and
usb_charger_exit() functions for usb charger initialization and exit.

It will report to the usb charger when the gadget state is changed,
then the usb charger can do the power things.

Introduce a callback 'get_charger_type' which will implemented by
user for usb gadget operations to get the usb charger type.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/gadget/udc/udc-core.c |   11 +++++++++++
 include/linux/usb/gadget.h        |   10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index f660afb..2727f01 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -28,6 +28,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb.h>
+#include <linux/usb/usb_charger.h>
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -226,6 +227,9 @@ static void usb_gadget_state_work(struct work_struct *work)
 	struct usb_gadget *gadget = work_to_gadget(work);
 	struct usb_udc *udc = gadget->udc;
 
+	/* when the gadget state is changed, then report to USB charger */
+	usb_charger_plug_by_gadget(gadget, gadget->state);
+
 	if (udc)
 		sysfs_notify(&udc->dev.kobj, NULL, "state");
 }
@@ -405,8 +409,14 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 
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
@@ -481,6 +491,7 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
+	usb_charger_exit(gadget);
 	device_unregister(&gadget->dev);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 3d583a1..b8a6d38 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/usb/ch9.h>
+#include <linux/usb/usb_charger.h>
 
 struct usb_ep;
 
@@ -560,6 +561,7 @@ struct usb_gadget_ops {
 	struct usb_ep *(*match_ep)(struct usb_gadget *,
 			struct usb_endpoint_descriptor *,
 			struct usb_ss_ep_comp_descriptor *);
+	enum usb_charger_type (*get_charger_type)(struct usb_gadget *);
 };
 
 /**
@@ -632,6 +634,8 @@ struct usb_gadget {
 	unsigned			out_epnum;
 	unsigned			in_epnum;
 	struct usb_otg_caps		*otg_caps;
+	/* negotiate the power with the usb charger */
+	struct usb_charger		*charger;
 
 	unsigned			sg_supported:1;
 	unsigned			is_otg:1;
@@ -836,10 +840,16 @@ static inline int usb_gadget_vbus_connect(struct usb_gadget *gadget)
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


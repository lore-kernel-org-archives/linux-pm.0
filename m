From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v13 2/4] usb: gadget: Support for the usb charger framework
Date: Thu, 23 Jun 2016 16:57:58 +0800
Message-ID: <b3f0eb810a8805cd52ea65130845cc02b46a1a9c.1466671672.git.baolin.wang@linaro.org>
References: <cover.1466671672.git.baolin.wang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36380 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbcFWI6l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jun 2016 04:58:41 -0400
Received: by mail-pa0-f45.google.com with SMTP id wo6so25630527pac.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jun 2016 01:58:41 -0700 (PDT)
In-Reply-To: <cover.1466671672.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1466671672.git.baolin.wang@linaro.org>
References: <cover.1466671672.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

For supporting the usb charger, it adds the usb_charger_init() and
usb_charger_exit() functions for usb charger initialization and exit.

It will report to the usb charger when the gadget state is changed,
then the usb charger can do the power things.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Li Jun <jun.li@nxp.com>
Tested-by: Li Jun <jun.li@nxp.com>
---
 drivers/usb/gadget/udc/udc-core.c |   11 +++++++++++
 include/linux/usb/gadget.h        |   11 +++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 6e8300d..84c098c 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -28,6 +28,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb.h>
+#include <linux/usb/charger.h>
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -242,6 +243,9 @@ static void usb_gadget_state_work(struct work_struct *work)
 	struct usb_gadget *gadget = work_to_gadget(work);
 	struct usb_udc *udc = gadget->udc;
 
+	/* when the gadget state is changed, then report to USB charger */
+	usb_charger_plug_by_gadget(gadget, gadget->state);
+
 	if (udc)
 		sysfs_notify(&udc->dev.kobj, NULL, "state");
 }
@@ -411,6 +415,10 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 	if (ret)
 		goto err4;
 
+	ret = usb_charger_init(gadget);
+	if (ret)
+		goto err5;
+
 	usb_gadget_set_state(gadget, USB_STATE_NOTATTACHED);
 	udc->vbus = true;
 
@@ -431,6 +439,8 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 
 	return 0;
 
+err5:
+	device_del(&udc->dev);
 err4:
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
@@ -539,6 +549,7 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
+	usb_charger_exit(gadget);
 	device_unregister(&gadget->dev);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 457651b..40390ec 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/usb/ch9.h>
+#include <linux/usb/charger.h>
 
 struct usb_ep;
 
@@ -639,6 +640,8 @@ struct usb_gadget {
 	unsigned			out_epnum;
 	unsigned			in_epnum;
 	struct usb_otg_caps		*otg_caps;
+	/* negotiate the power with the usb charger */
+	struct usb_charger		*charger;
 
 	unsigned			sg_supported:1;
 	unsigned			is_otg:1;
@@ -855,10 +858,18 @@ static inline int usb_gadget_vbus_connect(struct usb_gadget *gadget)
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
+		usb_charger_set_cur_limit_by_type(gadget->charger,
+						  gadget->charger->type,
+						  mA);
+
 	if (!gadget->ops->vbus_draw)
 		return -EOPNOTSUPP;
 	return gadget->ops->vbus_draw(gadget, mA);
-- 
1.7.9.5


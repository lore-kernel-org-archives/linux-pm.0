From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v18 3/4] usb: gadget: Integrate with the usb gadget supporting for usb charger
Date: Wed, 19 Oct 2016 10:37:36 +0800
Message-ID: <6e9033e135dbb7b3f9ef23d1ca858f11504acab3.1476780088.git.baolin.wang@linaro.org>
References: <cover.1476780088.git.baolin.wang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34426 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756729AbcJSCiT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2016 22:38:19 -0400
Received: by mail-pf0-f171.google.com with SMTP id r16so6882809pfg.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2016 19:38:19 -0700 (PDT)
In-Reply-To: <cover.1476780088.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1476780088.git.baolin.wang@linaro.org>
References: <cover.1476780088.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

When the usb gadget supporting for usb charger is ready, the usb charger
can implement the usb_charger_plug_by_gadget() function, usb_charger_exit()
function and dev_to_uchger() function by getting 'struct usb_charger' from
'struct gadget'.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Li Jun <jun.li@nxp.com>
Tested-by: Li Jun <jun.li@nxp.com>
---
 drivers/usb/gadget/udc/charger.c |   97 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/charger.c b/drivers/usb/gadget/udc/charger.c
index d885e86..56aee28 100644
--- a/drivers/usb/gadget/udc/charger.c
+++ b/drivers/usb/gadget/udc/charger.c
@@ -38,7 +38,9 @@ static DEFINE_MUTEX(charger_lock);
 
 static struct usb_charger *dev_to_uchger(struct device *dev)
 {
-	return NULL;
+	struct usb_gadget *gadget = container_of(dev, struct usb_gadget, dev);
+
+	return gadget->charger;
 }
 
 /*
@@ -308,6 +310,18 @@ static int __usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
 int usb_charger_set_cur_limit_by_gadget(struct usb_gadget *gadget,
 					unsigned int cur_limit)
 {
+	struct usb_charger *uchger = gadget->charger;
+	int ret;
+
+	if (!uchger)
+		return -EINVAL;
+
+	ret = __usb_charger_set_cur_limit_by_type(uchger, uchger->type,
+						  cur_limit);
+	if (ret)
+		return ret;
+
+	schedule_work(&uchger->work);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usb_charger_set_cur_limit_by_gadget);
@@ -625,11 +639,66 @@ static int usb_charger_plug_by_extcon(struct notifier_block *nb,
 int usb_charger_plug_by_gadget(struct usb_gadget *gadget,
 			       unsigned long state)
 {
+	struct usb_charger *uchger = gadget->charger;
+	enum usb_charger_state uchger_state;
+
+	if (WARN(!uchger, "charger can not be NULL"))
+		return -EINVAL;
+
+	/*
+	 * Report event to power to setting the current limitation
+	 * for this usb charger when one usb charger state is changed
+	 * with detecting by usb gadget state.
+	 */
+	if (uchger->old_gadget_state != state) {
+		uchger->old_gadget_state = state;
+
+		if (state >= USB_STATE_ATTACHED) {
+			uchger_state = USB_CHARGER_PRESENT;
+		} else if (state == USB_STATE_NOTATTACHED) {
+			mutex_lock(&uchger->lock);
+
+			/*
+			 * Need check the charger type to make sure the usb
+			 * cable is removed, in case it just changes the usb
+			 * function with configfs.
+			 */
+			uchger->type = __usb_charger_get_type(uchger);
+			if (uchger->type != UNKNOWN_TYPE) {
+				mutex_unlock(&uchger->lock);
+				return 0;
+			}
+
+			mutex_unlock(&uchger->lock);
+			uchger_state = USB_CHARGER_REMOVE;
+		} else {
+			uchger_state = USB_CHARGER_DEFAULT;
+		}
+
+		usb_charger_notify_state(uchger, uchger_state);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usb_charger_plug_by_gadget);
 
 /*
+ * usb_charger_unregister() - Unregister a usb charger.
+ * @uchger - the usb charger to be unregistered.
+ */
+static int usb_charger_unregister(struct usb_charger *uchger)
+{
+	ida_simple_remove(&usb_charger_ida, uchger->id);
+	sysfs_remove_groups(&uchger->gadget->dev.kobj, usb_charger_groups);
+
+	mutex_lock(&charger_lock);
+	list_del(&uchger->list);
+	mutex_unlock(&charger_lock);
+
+	return 0;
+}
+
+/*
  * usb_charger_register() - Register a new usb charger.
  * @uchger - the new usb charger instance.
  */
@@ -737,6 +806,7 @@ int usb_charger_init(struct usb_gadget *ugadget)
 	}
 
 	uchger->gadget = ugadget;
+	ugadget->charger = uchger;
 	uchger->old_gadget_state = USB_STATE_NOTATTACHED;
 
 	/* Register a new usb charger */
@@ -774,6 +844,31 @@ fail_extcon:
 
 int usb_charger_exit(struct usb_gadget *ugadget)
 {
+	struct usb_charger *uchger = ugadget->charger;
+
+	if (!uchger)
+		return -EINVAL;
+
+	usb_charger_unregister(uchger);
+	ugadget->charger = NULL;
+
+	extcon_unregister_notifier(uchger->extcon_dev,
+				   EXTCON_USB,
+				   &uchger->extcon_nb.nb);
+	extcon_unregister_notifier(uchger->extcon_dev,
+				   EXTCON_CHG_USB_SDP,
+				   &uchger->extcon_type_nb.nb);
+	extcon_unregister_notifier(uchger->extcon_dev,
+				   EXTCON_CHG_USB_CDP,
+				   &uchger->extcon_type_nb.nb);
+	extcon_unregister_notifier(uchger->extcon_dev,
+				   EXTCON_CHG_USB_DCP,
+				   &uchger->extcon_type_nb.nb);
+	extcon_unregister_notifier(uchger->extcon_dev,
+				   EXTCON_CHG_USB_ACA,
+				   &uchger->extcon_type_nb.nb);
+
+	kfree(uchger);
 	return 0;
 }
 
-- 
1.7.9.5


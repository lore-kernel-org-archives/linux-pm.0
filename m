From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v15 3/4] usb: gadget: Integrate with the usb gadget supporting for usb charger
Date: Fri,  1 Jul 2016 14:05:47 +0800
Message-ID: <9e05cbfc9dff2bca09d818c5cadafbd9d666da2a.1467352530.git.baolin.wang@linaro.org>
References: <cover.1467352530.git.baolin.wang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34381 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932102AbcGAGGu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2016 02:06:50 -0400
Received: by mail-pf0-f179.google.com with SMTP id h14so37006650pfe.1
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2016 23:06:49 -0700 (PDT)
In-Reply-To: <cover.1467352530.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1467352530.git.baolin.wang@linaro.org>
References: <cover.1467352530.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

When the usb gadget supporting for usb charger is ready, the usb charger
can implement the usb_charger_plug_by_gadget() function, usb_charger_exit()
function and dev_to_uchger() function by getting 'struct usb_charger' from
'struct gadget'.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Li Jun <jun.li@nxp.com>
Tested-by: Li Jun <jun.li@nxp.com>
---
 drivers/usb/gadget/udc/charger.c |   67 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/charger.c b/drivers/usb/gadget/udc/charger.c
index 54c1712f..57f9fd2 100644
--- a/drivers/usb/gadget/udc/charger.c
+++ b/drivers/usb/gadget/udc/charger.c
@@ -36,7 +36,9 @@ static unsigned int __usb_charger_get_cur_limit(struct usb_charger *uchger);
 
 static struct usb_charger *dev_to_uchger(struct device *dev)
 {
-	return NULL;
+	struct usb_gadget *gadget = container_of(dev, struct usb_gadget, dev);
+
+	return gadget->charger;
 }
 
 /*
@@ -305,7 +307,13 @@ static int __usb_charger_set_cur_limit_by_type(struct usb_charger *uchger,
 int usb_charger_set_cur_limit_by_gadget(struct usb_gadget *gadget,
 					unsigned int cur_limit)
 {
-	return 0;
+	struct usb_charger *uchger = gadget->charger;
+
+	if (!uchger)
+		return -EINVAL;
+
+	return __usb_charger_set_cur_limit_by_type(uchger, uchger->type,
+						   cur_limit);
 }
 EXPORT_SYMBOL_GPL(usb_charger_set_cur_limit_by_gadget);
 
@@ -563,11 +571,52 @@ usb_charger_plug_by_extcon(struct notifier_block *nb,
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
+	kfree(uchger);
+	return 0;
+}
+
+/*
  * usb_charger_register() - Register a new usb charger.
  * @uchger - the new usb charger instance.
  */
@@ -647,6 +696,7 @@ int usb_charger_init(struct usb_gadget *ugadget)
 
 	/* register a notifier on a usb gadget device */
 	uchger->gadget = ugadget;
+	ugadget->charger = uchger;
 	uchger->old_gadget_state = USB_STATE_NOTATTACHED;
 
 	/* register a new usb charger */
@@ -669,7 +719,18 @@ fail:
 
 int usb_charger_exit(struct usb_gadget *ugadget)
 {
-	return 0;
+	struct usb_charger *uchger = ugadget->charger;
+
+	if (!uchger)
+		return -EINVAL;
+
+	ugadget->charger = NULL;
+	if (uchger->extcon_dev)
+		extcon_unregister_notifier(uchger->extcon_dev,
+					   EXTCON_USB,
+					   &uchger->extcon_nb.nb);
+
+	return usb_charger_unregister(uchger);
 }
 
 MODULE_AUTHOR("Baolin Wang <baolin.wang@linaro.org>");
-- 
1.7.9.5


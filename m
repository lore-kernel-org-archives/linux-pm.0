From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v9 3/4] gadget: Integrate with the usb gadget supporting for usb charger
Date: Fri,  1 Apr 2016 15:21:51 +0800
Message-ID: <3d6c7d06725405e48281679de008b06f7550e640.1459494744.git.baolin.wang@linaro.org>
References: <cover.1459494743.git.baolin.wang@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1459494743.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1459494743.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1459494743.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

When the usb gadget supporting for usb charger is ready, the usb charger
should get the type by the 'get_charger_type' callback which is implemented
by the usb gadget operations, and get the usb charger pointer from struct
'usb_gadget'.

Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/usb/gadget/udc/charger.c |   44 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/charger.c b/drivers/usb/gadget/udc/charger.c
index 251f42b..73f0531 100644
--- a/drivers/usb/gadget/udc/charger.c
+++ b/drivers/usb/gadget/udc/charger.c
@@ -272,7 +272,10 @@ usb_charger_get_type_by_others(struct usb_charger *uchger)
 	if (uchger->type != UNKNOWN_TYPE)
 		return uchger->type;
 
-	if (uchger->psy) {
+	if (uchger->gadget->ops && uchger->gadget->ops->get_charger_type) {
+		uchger->type =
+			uchger->gadget->ops->get_charger_type(uchger->gadget);
+	} else if (uchger->psy) {
 		union power_supply_propval val;
 
 		power_supply_get_property(uchger->psy,
@@ -554,6 +557,30 @@ usb_charger_plug_by_extcon(struct notifier_block *nb,
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
@@ -712,6 +739,7 @@ int usb_charger_init(struct usb_gadget *ugadget)
 
 	/* register a notifier on a usb gadget device */
 	uchger->gadget = ugadget;
+	ugadget->charger = uchger;
 	uchger->old_gadget_state = ugadget->state;
 
 	/* register a new usb charger */
@@ -732,7 +760,19 @@ fail:
 
 int usb_charger_exit(struct usb_gadget *ugadget)
 {
-	return 0;
+	struct usb_charger *uchger = ugadget->charger;
+
+	if (WARN(!uchger, "charger can not be NULL"))
+		return -EINVAL;
+
+	if (uchger->extcon_dev)
+		extcon_unregister_notifier(uchger->extcon_dev,
+					   EXTCON_USB,
+					   &uchger->extcon_nb.nb);
+
+	ida_simple_remove(&usb_charger_ida, uchger->id);
+
+	return usb_charger_unregister(uchger);
 }
 
 static int __init usb_charger_class_init(void)
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

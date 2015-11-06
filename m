From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v5 4/5] gadget: Integrate with the usb gadget supporting for usb charger
Date: Fri,  6 Nov 2015 19:35:13 +0800
Message-ID: <8637ed7d0a5214505f26768f8d52e7dc554a8160.1446807916.git.baolin.wang@linaro.org>
References: <cover.1446807915.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446807915.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1446807915.git.baolin.wang@linaro.org>
References: <cover.1446807915.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, baolin.wang@linaro.org, gregkh@linuxfoundation.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When the usb gadget supporting for usb charger is ready, the usb charger
should get the type by the 'get_charger_type' callback which is implemented
by the usb gadget operations, and get the usb charger pointer from struct
'usb_gadget'.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/gadget/charger.c |   45 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/charger.c b/drivers/usb/gadget/charger.c
index 8387820..c260317 100644
--- a/drivers/usb/gadget/charger.c
+++ b/drivers/usb/gadget/charger.c
@@ -183,7 +183,11 @@ int usb_charger_unregister_notify(struct usb_charger *uchger,
 enum usb_charger_type
 usb_charger_detect_type(struct usb_charger *uchger)
 {
-	if (uchger->psy) {
+	if (uchger->gadget && uchger->gadget->ops
+	    && uchger->gadget->ops->get_charger_type) {
+		uchger->type =
+			uchger->gadget->ops->get_charger_type(uchger->gadget);
+	} else if (uchger->psy) {
 		union power_supply_propval val;
 
 		power_supply_get_property(uchger->psy,
@@ -387,6 +391,30 @@ static int
 usb_charger_plug_by_gadget(struct notifier_block *nb,
 			   unsigned long state, void *data)
 {
+	struct usb_gadget *gadget = (struct usb_gadget *)data;
+	struct usb_charger *uchger = gadget->charger;
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
 	return NOTIFY_OK;
 }
 
@@ -542,6 +570,7 @@ int usb_charger_init(struct usb_gadget *ugadget)
 
 	/* register a notifier on a usb gadget device */
 	uchger->gadget = ugadget;
+	ugadget->charger = uchger;
 	uchger->old_gadget_state = ugadget->state;
 	uchger->gadget_nb.notifier_call = usb_charger_plug_by_gadget;
 	usb_gadget_register_notify(ugadget, &uchger->gadget_nb);
@@ -565,7 +594,19 @@ fail:
 
 int usb_charger_exit(struct usb_gadget *ugadget)
 {
-	return 0;
+	struct usb_charger *uchger = ugadget->charger;
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
 }
 
 static int __init usb_charger_sysfs_init(void)
-- 
1.7.9.5

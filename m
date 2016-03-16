From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v7 3/4] gadget: Integrate with the usb gadget supporting for usb charger
Date: Wed, 16 Mar 2016 19:46:07 +0800
Message-ID: <88abb8df5b135975c5ffff1fa5437c4d82f48514.1458128215.git.baolin.wang@linaro.org>
References: <cover.1458128215.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458128215.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1458128215.git.baolin.wang@linaro.org>
References: <cover.1458128215.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When the usb gadget supporting for usb charger is ready, the usb charger
should get the type by the 'get_charger_type' callback which is implemented
by the usb gadget operations, and get the usb charger pointer from struct
'usb_gadget'.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/gadget/charger.c |   43 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/charger.c b/drivers/usb/gadget/charger.c
index 82a9973..76e1a6f 100644
--- a/drivers/usb/gadget/charger.c
+++ b/drivers/usb/gadget/charger.c
@@ -272,7 +272,11 @@ EXPORT_SYMBOL_GPL(usb_charger_unregister_notify);
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
@@ -479,6 +483,29 @@ usb_charger_plug_by_extcon(struct notifier_block *nb,
 int usb_charger_plug_by_gadget(struct usb_gadget *gadget,
 			       unsigned long state)
 {
+	struct usb_charger *uchger = gadget->charger;
+	enum usb_charger_state uchger_state;
+
+	if (!uchger)
+		return -EINVAL;
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
 	return 0;
 }
 EXPORT_SYMBOL_GPL(usb_charger_plug_by_gadget);
@@ -635,6 +662,7 @@ int usb_charger_init(struct usb_gadget *ugadget)
 
 	/* register a notifier on a usb gadget device */
 	uchger->gadget = ugadget;
+	ugadget->charger = uchger;
 	uchger->old_gadget_state = ugadget->state;
 
 	/* register a new usb charger */
@@ -655,7 +683,18 @@ fail:
 
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
+	ida_simple_remove(&usb_charger_ida, uchger->id);
+
+	return usb_charger_unregister(uchger);
 }
 
 static int __init usb_charger_sysfs_init(void)
-- 
1.7.9.5

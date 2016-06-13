From: Baolin Wang <baolin.wang@linaro.org>
Subject: [RESEND PATCH v11 3/4] gadget: Integrate with the usb gadget supporting for usb charger
Date: Mon, 13 Jun 2016 16:46:37 +0800
Message-ID: <f7963d623278ce3141564068866a8b7104bcda6c.1465807514.git.baolin.wang@linaro.org>
References: <cover.1465807514.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1465807514.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1465807514.git.baolin.wang@linaro.org>
References: <cover.1465807514.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When the usb gadget supporting for usb charger is ready, the usb charger
can implement the usb_charger_plug_by_gadget() function and usb_charger_exit()
function by getting 'struct usb_charger' from 'struct gadget'.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/gadget/udc/charger.c |   39 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/charger.c b/drivers/usb/gadget/udc/charger.c
index 7be4c76..949396f 100644
--- a/drivers/usb/gadget/udc/charger.c
+++ b/drivers/usb/gadget/udc/charger.c
@@ -568,6 +568,30 @@ usb_charger_plug_by_extcon(struct notifier_block *nb,
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
@@ -724,6 +748,7 @@ int usb_charger_init(struct usb_gadget *ugadget)
 
 	/* register a notifier on a usb gadget device */
 	uchger->gadget = ugadget;
+	ugadget->charger = uchger;
 	uchger->old_gadget_state = USB_STATE_NOTATTACHED;
 
 	/* register a new usb charger */
@@ -744,7 +769,19 @@ fail:
 
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

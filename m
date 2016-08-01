From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v16 3/4] usb: gadget: Integrate with the usb gadget supporting for usb charger
Date: Mon,  1 Aug 2016 15:09:32 +0800
Message-ID: <b1d2d4b4ebdb324446ba64f305f16cbeb5008523.1470034830.git.baolin.wang@linaro.org>
References: <cover.1470034830.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1470034830.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1470034830.git.baolin.wang@linaro.org>
References: <cover.1470034830.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

When the usb gadget supporting for usb charger is ready, the usb charger
can implement the usb_charger_plug_by_gadget() function, usb_charger_exit()
function and dev_to_uchger() function by getting 'struct usb_charger' from
'struct gadget'.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Li Jun <jun.li@nxp.com>
Tested-by: Li Jun <jun.li@nxp.com>
---
 drivers/usb/gadget/udc/charger.c |   87 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/charger.c b/drivers/usb/gadget/udc/charger.c
index 462faa1..13f53b1 100644
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
@@ -325,6 +327,18 @@ static void usb_charger_notify_work(struct work_struct *work)
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
@@ -582,11 +596,68 @@ usb_charger_plug_by_extcon(struct notifier_block *nb,
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
+			uchger->type = UNKNOWN_TYPE;
+			usb_charger_get_type_by_others(uchger);
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
@@ -667,6 +738,7 @@ int usb_charger_init(struct usb_gadget *ugadget)
 
 	/* register a notifier on a usb gadget device */
 	uchger->gadget = ugadget;
+	ugadget->charger = uchger;
 	uchger->old_gadget_state = USB_STATE_NOTATTACHED;
 
 	/* register a new usb charger */
@@ -689,7 +761,18 @@ fail:
 
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

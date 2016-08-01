From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v16 2/4] usb: gadget: Support for the usb charger framework
Date: Mon,  1 Aug 2016 15:09:31 +0800
Message-ID: <996bd04bc6fa4afef6c0a20fbe2bca6529688fc8.1470034830.git.baolin.wang@linaro.org>
References: <cover.1470034830.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1470034830.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1470034830.git.baolin.wang@linaro.org>
References: <cover.1470034830.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

For supporting the usb charger, it adds the usb_charger_init() and
usb_charger_exit() functions for usb charger initialization and exit.

It will report to the usb charger when the gadget state is changed,
then the usb charger can do the power things.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Li Jun <jun.li@nxp.com>
Tested-by: Li Jun <jun.li@nxp.com>
---
 drivers/usb/gadget/udc/core.c |   17 +++++++++++++++++
 include/linux/usb/gadget.h    |    3 +++
 2 files changed, 20 insertions(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index ff8685e..bdf1874 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -25,6 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/workqueue.h>
 
+#include <linux/usb/charger.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb.h>
@@ -578,12 +579,17 @@ EXPORT_SYMBOL_GPL(usb_gadget_vbus_connect);
  * reporting how much power the device may consume.  For example, this
  * could affect how quickly batteries are recharged.
  *
+ * It will also notify the USB charger how much power the device may
+ * consume if there is a USB charger linking with the gadget.
+ *
  * Returns zero on success, else negative errno.
  */
 int usb_gadget_vbus_draw(struct usb_gadget *gadget, unsigned mA)
 {
 	int ret = 0;
 
+	usb_charger_set_cur_limit_by_gadget(gadget, mA);
+
 	if (!gadget->ops->vbus_draw) {
 		ret = -EOPNOTSUPP;
 		goto out;
@@ -965,6 +971,9 @@ static void usb_gadget_state_work(struct work_struct *work)
 	struct usb_gadget *gadget = work_to_gadget(work);
 	struct usb_udc *udc = gadget->udc;
 
+	/* when the gadget state is changed, then report to USB charger */
+	usb_charger_plug_by_gadget(gadget, gadget->state);
+
 	if (udc)
 		sysfs_notify(&udc->dev.kobj, NULL, "state");
 }
@@ -1134,6 +1143,10 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 	if (ret)
 		goto err4;
 
+	ret = usb_charger_init(gadget);
+	if (ret)
+		goto err5;
+
 	usb_gadget_set_state(gadget, USB_STATE_NOTATTACHED);
 	udc->vbus = true;
 
@@ -1154,6 +1167,9 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 
 	return 0;
 
+err5:
+	device_del(&udc->dev);
+
 err4:
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
@@ -1262,6 +1278,7 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
+	usb_charger_exit(gadget);
 	device_unregister(&gadget->dev);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 612dbdf..c864b51 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <linux/usb/ch9.h>
+#include <linux/usb/charger.h>
 
 #define UDC_TRACE_STR_MAX	512
 
@@ -328,6 +329,7 @@ struct usb_gadget_ops {
  * @in_epnum: last used in ep number
  * @mA: last set mA value
  * @otg_caps: OTG capabilities of this gadget.
+ * @charger: Negotiate the power with the usb charger.
  * @sg_supported: true if we can handle scatter-gather
  * @is_otg: True if the USB device port uses a Mini-AB jack, so that the
  *	gadget driver must provide a USB OTG descriptor.
@@ -385,6 +387,7 @@ struct usb_gadget {
 	unsigned			in_epnum;
 	unsigned			mA;
 	struct usb_otg_caps		*otg_caps;
+	struct usb_charger		*charger;
 
 	unsigned			sg_supported:1;
 	unsigned			is_otg:1;
-- 
1.7.9.5

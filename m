From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Tue, 21 Jun 2016 16:39:13 +0800
Message-ID: <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org>
References: <cover.1466497505.git.baolin.wang@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1466497505.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1466497505.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1466497505.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jun.li-3arQi8VN3Tc@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ruslan.bilovol-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

For supporting the usb charger, it adds the usb_charger_init() and
usb_charger_exit() functions for usb charger initialization and exit.

It will report to the usb charger when the gadget state is changed,
then the usb charger can do the power things.

Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Reviewed-by: Li Jun <jun.li-3arQi8VN3Tc@public.gmane.org>
Tested-by: Li Jun <jun.li-3arQi8VN3Tc@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

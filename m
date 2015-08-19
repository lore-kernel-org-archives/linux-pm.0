From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4 1/5] gadget: Introduce the notifier functions
Date: Wed, 19 Aug 2015 17:13:44 +0800
Message-ID: <acd08255d6535082973a5e432c40433429544dbc.1439974219.git.baolin.wang@linaro.org>
References: <cover.1439974219.git.baolin.wang@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1439974219.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
In-Reply-To: <cover.1439974219.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
References: <cover.1439974219.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, sojka-Knnw/vAvyUalVyrhU4qvOw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

The usb charger framework is based on usb gadget. The usb charger
need to be notified the state changing of usb gadget to confirm the
usb charger state.

Thus this patch adds a notifier mechanism for usb gadget to report a
event to usb charger when the usb gadget state is changed.

Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/usb/gadget/udc/udc-core.c |   32 ++++++++++++++++++++++++++++++++
 include/linux/usb/gadget.h        |   18 ++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index f660afb..4238fc3 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -129,6 +129,32 @@ void usb_gadget_giveback_request(struct usb_ep *ep,
 }
 EXPORT_SYMBOL_GPL(usb_gadget_giveback_request);
 
+int usb_gadget_register_notify(struct usb_gadget *gadget,
+			       struct notifier_block *nb)
+{
+	int ret;
+
+	mutex_lock(&gadget->lock);
+	ret = raw_notifier_chain_register(&gadget->nh, nb);
+	mutex_unlock(&gadget->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_register_notify);
+
+int usb_gadget_unregister_notify(struct usb_gadget *gadget,
+				 struct notifier_block *nb)
+{
+	int ret;
+
+	mutex_lock(&gadget->lock);
+	ret = raw_notifier_chain_unregister(&gadget->nh, nb);
+	mutex_unlock(&gadget->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(usb_gadget_unregister_notify);
+
 /* ------------------------------------------------------------------------- */
 
 /**
@@ -226,6 +252,10 @@ static void usb_gadget_state_work(struct work_struct *work)
 	struct usb_gadget *gadget = work_to_gadget(work);
 	struct usb_udc *udc = gadget->udc;
 
+	mutex_lock(&gadget->lock);
+	raw_notifier_call_chain(&gadget->nh, gadget->state, gadget);
+	mutex_unlock(&gadget->lock);
+
 	if (udc)
 		sysfs_notify(&udc->dev.kobj, NULL, "state");
 }
@@ -364,6 +394,8 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 
 	dev_set_name(&gadget->dev, "gadget");
 	INIT_WORK(&gadget->work, usb_gadget_state_work);
+	RAW_INIT_NOTIFIER_HEAD(&gadget->nh);
+	mutex_init(&gadget->lock);
 	gadget->dev.parent = parent;
 
 #ifdef	CONFIG_HAS_DMA
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index c14a69b..755e8bc 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -609,6 +609,8 @@ struct usb_gadget {
 	unsigned			out_epnum;
 	unsigned			in_epnum;
 	struct usb_otg_caps		*otg_caps;
+	struct raw_notifier_head	nh;
+	struct mutex			lock;
 
 	unsigned			sg_supported:1;
 	unsigned			is_otg:1;
@@ -1183,6 +1185,22 @@ extern void usb_gadget_unmap_request(struct usb_gadget *gadget,
 
 /*-------------------------------------------------------------------------*/
 
+/**
+ * Register a notifiee to get notified by any attach status changes from
+ * the usb gadget
+ */
+int usb_gadget_register_notify(struct usb_gadget *gadget,
+			       struct notifier_block *nb);
+
+/*-------------------------------------------------------------------------*/
+
+
+/* Unregister a notifiee from the usb gadget */
+int usb_gadget_unregister_notify(struct usb_gadget *gadget,
+				 struct notifier_block *nb);
+
+/*-------------------------------------------------------------------------*/
+
 /* utility to set gadget state properly */
 
 extern void usb_gadget_set_state(struct usb_gadget *gadget,
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v4 3/5] gadget: Support for the usb charger framework
Date: Thu, 24 Sep 2015 10:39:25 -0700
Message-ID: <7ee4199f14eb9e84c8ea8d66568e0d4dde193583.1443057232.git.baolin.wang@linaro.org>
References: <cover.1443057229.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1443057229.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1443057229.git.baolin.wang@linaro.org>
References: <cover.1443057229.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: gregkh@linuxfoundation.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, baolin.wang@linaro.org
List-Id: linux-pm@vger.kernel.org

For supporting the usb charger, it adds the usb_charger_init() and
usb_charger_exit() functions for usb charger initialization and exit.

Introduce a callback 'get_charger_type' which will implemented by
user for usb gadget operations to get the usb charger type.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/gadget/udc/udc-core.c | 8 ++++++++
 include/linux/usb/gadget.h        | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/usb/gadget/udc/udc-core.c b/drivers/usb/gadget/udc/udc-core.c
index 4238fc3..370376e 100644
--- a/drivers/usb/gadget/udc/udc-core.c
+++ b/drivers/usb/gadget/udc/udc-core.c
@@ -28,6 +28,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb.h>
+#include <linux/usb/usb_charger.h>
 
 /**
  * struct usb_udc - describes one usb device controller
@@ -437,8 +438,14 @@ int usb_add_gadget_udc_release(struct device *parent, struct usb_gadget *gadget,
 
 	mutex_unlock(&udc_lock);
 
+	ret = usb_charger_init(gadget);
+	if (ret)
+		goto err5;
+
 	return 0;
 
+err5:
+	device_del(&udc->dev);
 err4:
 	list_del(&udc->list);
 	mutex_unlock(&udc_lock);
@@ -513,6 +520,7 @@ void usb_del_gadget_udc(struct usb_gadget *gadget)
 	kobject_uevent(&udc->dev.kobj, KOBJ_REMOVE);
 	flush_work(&gadget->work);
 	device_unregister(&udc->dev);
+	usb_charger_exit(gadget);
 	device_unregister(&gadget->dev);
 }
 EXPORT_SYMBOL_GPL(usb_del_gadget_udc);
diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
index 755e8bc..451ad32 100644
--- a/include/linux/usb/gadget.h
+++ b/include/linux/usb/gadget.h
@@ -537,6 +537,7 @@ struct usb_gadget_ops {
 	struct usb_ep *(*match_ep)(struct usb_gadget *,
 			struct usb_endpoint_descriptor *,
 			struct usb_ss_ep_comp_descriptor *);
+	enum usb_charger_type (*get_charger_type)(struct usb_gadget *);
 };
 
 /**
@@ -611,6 +612,7 @@ struct usb_gadget {
 	struct usb_otg_caps		*otg_caps;
 	struct raw_notifier_head	nh;
 	struct mutex			lock;
+	struct usb_charger		*charger;
 
 	unsigned			sg_supported:1;
 	unsigned			is_otg:1;
-- 
1.9.1

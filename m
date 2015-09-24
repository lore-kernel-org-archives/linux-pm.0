From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v4 4/5] gadget: Integrate with the usb gadget supporting for usb charger
Date: Thu, 24 Sep 2015 10:39:26 -0700
Message-ID: <c74d23e8bb444500e82f3732f51e8ffadb9e3a18.1443057232.git.baolin.wang@linaro.org>
References: <cover.1443057229.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1443057229.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1443057229.git.baolin.wang@linaro.org>
References: <cover.1443057229.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: gregkh@linuxfoundation.org, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, sojka@merica.cz, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, sameo@linux.intel.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, baolin.wang@linaro.org
List-Id: linux-pm@vger.kernel.org

When the usb gadget supporting for usb charger is ready, the usb charger
should get the type by the 'get_charger_type' callback which is implemented
by the usb gadget operations, and get the usb charger pointer from struct
'usb_gadget'.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/usb/gadget/charger.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/charger.c b/drivers/usb/gadget/charger.c
index 35b46c1..a919f38 100644
--- a/drivers/usb/gadget/charger.c
+++ b/drivers/usb/gadget/charger.c
@@ -181,6 +181,13 @@ int usb_charger_unregister_notify(struct usb_charger *uchger,
 enum usb_charger_type
 usb_charger_detect_type(struct usb_charger *uchger)
 {
+	if (uchger->gadget && uchger->gadget->ops
+	    && uchger->gadget->ops->get_charger_type)
+		uchger->type =
+			uchger->gadget->ops->get_charger_type(uchger->gadget);
+	else
+		uchger->type = UNKNOWN_TYPE;
+
 	return uchger->type;
 }
 
@@ -313,7 +320,8 @@ static int
 usb_charger_plug_by_gadget(struct notifier_block *nb,
 			   unsigned long state, void *data)
 {
-	struct usb_charger *uchger = NULL;
+	struct usb_gadget *gadget = (struct usb_gadget *)data;
+	struct usb_charger *uchger = gadget->charger;
 	enum usb_charger_state uchger_state;
 
 	if (!uchger)
@@ -480,6 +488,7 @@ int usb_charger_init(struct usb_gadget *ugadget)
 
 	/* register a notifier on a usb gadget device */
 	uchger->gadget = ugadget;
+	ugadget->charger = uchger;
 	uchger->old_gadget_state = ugadget->state;
 	uchger->gadget_nb.notifier_call = usb_charger_plug_by_gadget;
 	usb_gadget_register_notify(ugadget, &uchger->gadget_nb);
@@ -503,7 +512,7 @@ fail:
 
 int usb_charger_exit(struct usb_gadget *ugadget)
 {
-	struct usb_charger *uchger = NULL;
+	struct usb_charger *uchger = ugadget->charger;
 
 	if (!uchger)
 		return -EINVAL;
-- 
1.9.1

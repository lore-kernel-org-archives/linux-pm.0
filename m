From: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 1/3] include: uapi: usb: Introduce USB charger type and state definition
Date: Tue, 27 Jun 2017 15:49:33 +0800
Message-ID: <54d4a3ae584900a74e04b5cd27157dced44fdfef.1498548022.git.baolin.wang@linaro.org>
References: <cover.1498548022.git.baolin.wang@linaro.org>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1498548022.git.baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: jun.li-3arQi8VN3Tc@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, neilb-IBi9RG/b67k@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, device-mainlining-cunTk1MwBs98uUxBSJOaYoYkZiVZrdSR2LY78lusg7I@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Introducing USB charger type and state definition can help
to support USB charging which will be added in USB phy core.

Signed-off-by: Baolin Wang <baolin.wang-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 include/uapi/linux/usb/charger.h |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 include/uapi/linux/usb/charger.h

diff --git a/include/uapi/linux/usb/charger.h b/include/uapi/linux/usb/charger.h
new file mode 100644
index 0000000..5f72af3
--- /dev/null
+++ b/include/uapi/linux/usb/charger.h
@@ -0,0 +1,31 @@
+/*
+ * This file defines the USB charger type and state that are needed for
+ * USB device APIs.
+ */
+
+#ifndef _UAPI__LINUX_USB_CHARGER_H
+#define _UAPI__LINUX_USB_CHARGER_H
+
+/*
+ * USB charger type:
+ * SDP (Standard Downstream Port)
+ * DCP (Dedicated Charging Port)
+ * CDP (Charging Downstream Port)
+ * ACA (Accessory Charger Adapters)
+ */
+enum usb_charger_type {
+	UNKNOWN_TYPE,
+	SDP_TYPE,
+	DCP_TYPE,
+	CDP_TYPE,
+	ACA_TYPE,
+};
+
+/* USB charger state */
+enum usb_charger_state {
+	USB_CHARGER_DEFAULT,
+	USB_CHARGER_PRESENT,
+	USB_CHARGER_ABSENT,
+};
+
+#endif /* _UAPI__LINUX_USB_CHARGER_H */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

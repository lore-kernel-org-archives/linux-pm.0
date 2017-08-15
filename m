From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v5 1/3] include: uapi: usb: Introduce USB charger type and state definition
Date: Tue, 15 Aug 2017 19:07:53 +0800
Message-ID: <67d041fc5b387696874186f36231b8d696aec6ee.1502794830.git.baolin.wang@linaro.org>
References: <cover.1502794826.git.baolin.wang@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:33956 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751588AbdHOLIi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 15 Aug 2017 07:08:38 -0400
Received: by mail-pg0-f41.google.com with SMTP id u185so4047216pgb.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2017 04:08:38 -0700 (PDT)
In-Reply-To: <cover.1502794826.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1502794826.git.baolin.wang@linaro.org>
References: <cover.1502794826.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org

Introducing USB charger type and state definition can help
to support USB charging which will be added in USB phy core.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
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

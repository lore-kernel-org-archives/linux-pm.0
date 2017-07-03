From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 1/3] include: uapi: usb: Introduce USB charger type and state definition
Date: Mon,  3 Jul 2017 14:07:13 +0800
Message-ID: <54d4a3ae584900a74e04b5cd27157dced44fdfef.1499061617.git.baolin.wang@linaro.org>
References: <cover.1499061617.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1499061617.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1499061617.git.baolin.wang@linaro.org>
References: <cover.1499061617.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org
Cc: jun.li@nxp.com, peter.chen@freescale.com, broonie@kernel.org, john.stultz@linaro.org, neilb@suse.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

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

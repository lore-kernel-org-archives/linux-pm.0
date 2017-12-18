From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v3 2/7] typec: tcpm: Add ADO header for Alert message handling
Date: Mon, 18 Dec 2017 12:41:37 +0000
Message-ID: <025e03a306ab7bfc8d763ae61ca6c97f2fb765de.1513599506.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1513599506.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513599506.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

This commit adds a header providing definitions for handling Alert
messages. Currently the header only focuses on handling incoming
alerts.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 include/linux/usb/pd_ado.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 include/linux/usb/pd_ado.h

diff --git a/include/linux/usb/pd_ado.h b/include/linux/usb/pd_ado.h
new file mode 100644
index 0000000..9aa1cf3
--- /dev/null
+++ b/include/linux/usb/pd_ado.h
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2017 Dialog Semiconductor
+ *
+ * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+ */
+
+#ifndef __LINUX_USB_PD_ADO_H
+#define __LINUX_USB_PD_ADO_H
+
+/* ADO : Alert Data Object */
+#define USB_PD_ADO_TYPE_SHIFT			24
+#define USB_PD_ADO_TYPE_MASK			0xff
+#define USB_PD_ADO_FIXED_BATT_SHIFT		20
+#define USB_PD_ADO_FIXED_BATT_MASK		0xf
+#define USB_PD_ADO_HOT_SWAP_BATT_SHIFT		16
+#define USB_PD_ADO_HOT_SWAP_BATT_MASK		0xf
+
+#define USB_PD_ADO_TYPE_BATT_STATUS_CHANGE	BIT(1)
+#define USB_PD_ADO_TYPE_OCP			BIT(2)
+#define USB_PD_ADO_TYPE_OTP			BIT(3)
+#define USB_PD_ADO_TYPE_OP_COND_CHANGE		BIT(4)
+#define USB_PD_ADO_TYPE_SRC_INPUT_CHANGE	BIT(5)
+#define USB_PD_ADO_TYPE_OVP			BIT(6)
+
+static inline unsigned int usb_pd_ado_type(u32 ado)
+{
+	return (ado >> USB_PD_ADO_TYPE_SHIFT) & USB_PD_ADO_TYPE_MASK;
+}
+
+static inline unsigned int usb_pd_ado_fixed_batt(u32 ado)
+{
+	return (ado >> USB_PD_ADO_FIXED_BATT_SHIFT) &
+	       USB_PD_ADO_FIXED_BATT_MASK;
+}
+
+static inline unsigned int usb_pd_ado_hot_swap_batt(u32 ado)
+{
+	return (ado >> USB_PD_ADO_HOT_SWAP_BATT_SHIFT) &
+	       USB_PD_ADO_HOT_SWAP_BATT_MASK;
+}
+#endif /* __LINUX_USB_PD_ADO_H */
-- 
1.9.1

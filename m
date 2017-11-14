From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v2 2/7] typec: tcpm: Add ADO header for Alert message handling
Date: Tue, 14 Nov 2017 11:44:43 +0000
Message-ID: <7310082fc65e2effa48a065d3e4755d7cd75595c.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1510657748.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Yueyao Zhu <yueyao.zhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rui Miguel Silva <rmfrfs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This commit adds a header providing definitions for handling Alert
messages. Currently the header only focuses on handling incoming
alerts.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
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
+ * Author: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [RFC PATCH 2/7] typec: tcpm: Add ADO header for Alert message handling
Date: Wed, 1 Nov 2017 17:03:10 +0000
Message-ID: <fed055cbecd4666d5a49a19c6a48958720045b40.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

This commit adds a header providing definitions for handling Alert
messages. Currently the header only focuses on handling incoming
alerts.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 include/linux/usb/pd_ado.h | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 include/linux/usb/pd_ado.h

diff --git a/include/linux/usb/pd_ado.h b/include/linux/usb/pd_ado.h
new file mode 100644
index 0000000..edcbcfa
--- /dev/null
+++ b/include/linux/usb/pd_ado.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2017 Dialog Semiconductor
+ *
+ * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __LINUX_USB_PD_ADO_H
+#define __LINUX_USB_PD_ADO_H
+
+/* ADO : Alert Data Object */
+#define ADO_TYPE_SHIFT			24
+#define ADO_TYPE_MASK			0xff
+#define ADO_FIXED_BATT_SHIFT		20
+#define ADO_FIXED_BATT_MASK		0xf
+#define ADO_HOT_SWAP_BATT_SHIFT		16
+#define ADO_HOT_SWAP_BATT_MASK		0xf
+
+#define ADO_TYPE_BATT_STATUS_CHANGE	BIT(1)
+#define ADO_TYPE_OCP			BIT(2)
+#define ADO_TYPE_OTP			BIT(3)
+#define ADO_TYPE_OP_COND_CHANGE		BIT(4)
+#define ADO_TYPE_SRC_INPUT_CHANGE	BIT(5)
+#define ADO_TYPE_OVP			BIT(6)
+
+static inline unsigned int ado_type(u32 ado)
+{
+	return (ado >> ADO_TYPE_SHIFT) & ADO_TYPE_MASK;
+}
+
+static inline unsigned int ado_fixed_batt(u32 ado)
+{
+	return (ado >> ADO_FIXED_BATT_SHIFT) & ADO_FIXED_BATT_MASK;
+}
+
+static inline unsigned int ado_hot_swap_batt(u32 ado)
+{
+	return (ado >> ADO_HOT_SWAP_BATT_SHIFT) & ADO_HOT_SWAP_BATT_MASK;
+}
+#endif /* __LINUX_USB_PD_ADO_H */
-- 
1.9.1

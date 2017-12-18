From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v3 3/7] typec: tcpm: Add SDB header for Status message handling
Date: Mon, 18 Dec 2017 12:41:38 +0000
Message-ID: <72525f372d831f8edf93072a3011c4e35974e8fa.1513599506.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1513599506.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1513599506.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

This commit adds a header providing definitions for handling
Status messages. Currently the header only focuses on handling
incoming Status messages.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 include/linux/usb/pd_ext_sdb.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 include/linux/usb/pd_ext_sdb.h

diff --git a/include/linux/usb/pd_ext_sdb.h b/include/linux/usb/pd_ext_sdb.h
new file mode 100644
index 0000000..0eb83ce
--- /dev/null
+++ b/include/linux/usb/pd_ext_sdb.h
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2017 Dialog Semiconductor
+ *
+ * Author: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+ */
+
+#ifndef __LINUX_USB_PD_EXT_SDB_H
+#define __LINUX_USB_PD_EXT_SDB_H
+
+/* SDB : Status Data Block */
+enum usb_pd_ext_sdb_fields {
+	USB_PD_EXT_SDB_INTERNAL_TEMP = 0,
+	USB_PD_EXT_SDB_PRESENT_INPUT,
+	USB_PD_EXT_SDB_PRESENT_BATT_INPUT,
+	USB_PD_EXT_SDB_EVENT_FLAGS,
+	USB_PD_EXT_SDB_TEMP_STATUS,
+	USB_PD_EXT_SDB_DATA_SIZE,
+};
+
+/* Event Flags */
+#define USB_PD_EXT_SDB_EVENT_OCP		BIT(1)
+#define USB_PD_EXT_SDB_EVENT_OTP		BIT(2)
+#define USB_PD_EXT_SDB_EVENT_OVP		BIT(3)
+#define USB_PD_EXT_SDB_EVENT_CF_CV_MODE		BIT(4)
+
+#define USB_PD_EXT_SDB_PPS_EVENTS	(USB_PD_EXT_SDB_EVENT_OCP |	\
+					 USB_PD_EXT_SDB_EVENT_OTP |	\
+					 USB_PD_EXT_SDB_EVENT_OVP)
+
+#endif /* __LINUX_USB_PD_EXT_SDB_H */
-- 
1.9.1

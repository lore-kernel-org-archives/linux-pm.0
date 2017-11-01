From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [RFC PATCH 3/7] typec: tcpm: Add SDB header for Status message handling
Date: Wed, 1 Nov 2017 17:03:11 +0000
Message-ID: <4199ae7655886b8ba7a436d3a9938220d2e14f0b.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

This commit adds a header providing definitions for handling
Status messages. Currently the header only focuses on handling
incoming Status messages.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 include/linux/usb/pd_ext_sdb.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 include/linux/usb/pd_ext_sdb.h

diff --git a/include/linux/usb/pd_ext_sdb.h b/include/linux/usb/pd_ext_sdb.h
new file mode 100644
index 0000000..6d6da31
--- /dev/null
+++ b/include/linux/usb/pd_ext_sdb.h
@@ -0,0 +1,40 @@
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
+#ifndef __LINUX_USB_PD_EXT_SDB_H
+#define __LINUX_USB_PD_EXT_SDB_H
+
+/* SDB : Status Data Block */
+enum pd_ext_sdb_fields {
+	EXT_SDB_INTERNAL_TEMP = 0,
+	EXT_SDB_PRESENT_INPUT,
+	EXT_SDB_PRESENT_BATT_INPUT,
+	EXT_SDB_EVENT_FLAGS,
+	EXT_SDB_TEMP_STATUS,
+	EXT_SDB_DATA_SIZE,
+};
+
+/* Event Flags */
+#define EXT_SDB_EVENT_OCP			BIT(1)
+#define EXT_SDB_EVENT_OTP			BIT(2)
+#define EXT_SDB_EVENT_OVP			BIT(3)
+#define EXT_SDB_EVENT_CF_CV_MODE		BIT(4)
+
+#define EXT_SDB_PPS_EVENTS	(EXT_SDB_EVENT_OCP |	\
+				 EXT_SDB_EVENT_OTP |	\
+				 EXT_SDB_EVENT_OVP)
+
+#endif /* __LINUX_USB_PD_EXT_SDB_H */
-- 
1.9.1

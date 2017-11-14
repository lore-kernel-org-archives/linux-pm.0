From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v2 3/7] typec: tcpm: Add SDB header for Status message handling
Date: Tue, 14 Nov 2017 11:44:44 +0000
Message-ID: <73a1867b7ef5de11ddd0825827eba6bd1dd0b6ef.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1510657748.git.Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Yueyao Zhu <yueyao.zhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rui Miguel Silva <rmfrfs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This commit adds a header providing definitions for handling
Status messages. Currently the header only focuses on handling
incoming Status messages.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
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
+ * Author: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

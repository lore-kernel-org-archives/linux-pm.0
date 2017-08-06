From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 03/18] staging: typec: tcpm: Split tcpm code into tcpm-core.c and tcpm-helpers.c
Date: Sun,  6 Aug 2017 14:35:40 +0200
Message-ID: <20170806123555.5124-4-hdegoede@redhat.com>
References: <20170806123555.5124-1-hdegoede@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170806123555.5124-1-hdegoede@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org, devel@driverdev.osuosl.org
List-Id: linux-pm@vger.kernel.org

This is a preparation patch for adding more helpers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/staging/typec/Makefile                |  2 +
 drivers/staging/typec/{tcpm.c => tcpm-core.c} | 40 ------------------
 drivers/staging/typec/tcpm-helpers.c          | 60 +++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 40 deletions(-)
 rename drivers/staging/typec/{tcpm.c => tcpm-core.c} (98%)
 create mode 100644 drivers/staging/typec/tcpm-helpers.c

diff --git a/drivers/staging/typec/Makefile b/drivers/staging/typec/Makefile
index 30a7e29cbc9e..bb7472ec04ab 100644
--- a/drivers/staging/typec/Makefile
+++ b/drivers/staging/typec/Makefile
@@ -1,3 +1,5 @@
 obj-$(CONFIG_TYPEC_TCPM)	+= tcpm.o
 obj-$(CONFIG_TYPEC_TCPCI)	+= tcpci.o
 obj-y				+= fusb302/
+
+tcpm-objs			= tcpm-core.o tcpm-helpers.o
\ No newline at end of file
diff --git a/drivers/staging/typec/tcpm.c b/drivers/staging/typec/tcpm-core.c
similarity index 98%
rename from drivers/staging/typec/tcpm.c
rename to drivers/staging/typec/tcpm-core.c
index 06bb0e640bcf..9f5adace4309 100644
--- a/drivers/staging/typec/tcpm.c
+++ b/drivers/staging/typec/tcpm-core.c
@@ -16,7 +16,6 @@
 
 #include <linux/completion.h>
 #include <linux/debugfs.h>
-#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -3533,45 +3532,6 @@ void tcpm_unregister_port(struct tcpm_port *port)
 }
 EXPORT_SYMBOL_GPL(tcpm_unregister_port);
 
-/* Generic (helper) implementations for some tcpc_dev callbacks */
-int tcpm_get_usb2_current_limit_extcon(struct tcpc_dev *tcpc)
-{
-	struct extcon_dev *extcon = tcpc->usb2_extcon;
-	int current_limit = 0;
-	unsigned long timeout;
-
-	if (!extcon)
-		return 0;
-
-	/*
-	 * USB2 Charger detection may still be in progress when we get here,
-	 * this can take upto 600ms, wait 800ms max.
-	 */
-	timeout = jiffies + msecs_to_jiffies(800);
-	do {
-		if (extcon_get_state(extcon, EXTCON_CHG_USB_SDP) == 1) {
-			current_limit = 500;
-			break;
-		}
-
-		if (extcon_get_state(extcon, EXTCON_CHG_USB_CDP) == 1 ||
-		    extcon_get_state(extcon, EXTCON_CHG_USB_ACA) == 1) {
-			current_limit = 1500;
-			break;
-		}
-
-		if (extcon_get_state(extcon, EXTCON_CHG_USB_DCP) == 1) {
-			current_limit = 2000;
-			break;
-		}
-
-		msleep(50);
-	} while (time_before(jiffies, timeout));
-
-	return current_limit;
-}
-EXPORT_SYMBOL_GPL(tcpm_get_usb2_current_limit_extcon);
-
 MODULE_AUTHOR("Guenter Roeck <groeck@chromium.org>");
 MODULE_DESCRIPTION("USB Type-C Port Manager");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/typec/tcpm-helpers.c b/drivers/staging/typec/tcpm-helpers.c
new file mode 100644
index 000000000000..0c87ec9936e1
--- /dev/null
+++ b/drivers/staging/typec/tcpm-helpers.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright 2017 Hans de Goede <hdegoede@redhat.com>
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
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/usb/typec.h>
+
+#include "tcpm.h"
+
+/* Generic (helper) implementations for some tcpc_dev callbacks */
+int tcpm_get_usb2_current_limit_extcon(struct tcpc_dev *tcpc)
+{
+	struct extcon_dev *extcon = tcpc->usb2_extcon;
+	int current_limit = 0;
+	unsigned long timeout;
+
+	if (!extcon)
+		return 0;
+
+	/*
+	 * USB2 Charger detection may still be in progress when we get here,
+	 * this can take upto 600ms, wait 800ms max.
+	 */
+	timeout = jiffies + msecs_to_jiffies(800);
+	do {
+		if (extcon_get_state(extcon, EXTCON_CHG_USB_SDP) == 1) {
+			current_limit = 500;
+			break;
+		}
+
+		if (extcon_get_state(extcon, EXTCON_CHG_USB_CDP) == 1 ||
+		    extcon_get_state(extcon, EXTCON_CHG_USB_ACA) == 1) {
+			current_limit = 1500;
+			break;
+		}
+
+		if (extcon_get_state(extcon, EXTCON_CHG_USB_DCP) == 1) {
+			current_limit = 2000;
+			break;
+		}
+
+		msleep(50);
+	} while (time_before(jiffies, timeout));
+
+	return current_limit;
+}
+EXPORT_SYMBOL_GPL(tcpm_get_usb2_current_limit_extcon);
-- 
2.13.3

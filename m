From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v11 02/10] i2c: i2c-smbus: Move i2c_setup_smbus_alert from i2c-smbus to i2c-core-smbus
Date: Thu, 24 Aug 2017 17:31:02 +0800
Message-ID: <1503567070-115646-3-git-send-email-preid@electromag.com.au>
References: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1503567070-115646-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

In preparation to adding of_i2c_setup_smbus_alert() move
i2c_setup_smbus_alert() to core module. of_i2c_setup_smbus_alert()
will call i2c_setup_smbus_alert() and this avoid module dependecy issues.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---
 drivers/i2c/i2c-core-smbus.c | 33 +++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-smbus.c      | 32 --------------------------------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 10f00a8..7f3ec02 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/i2c-smbus.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/smbus.h>
@@ -592,3 +593,35 @@ s32 i2c_smbus_read_i2c_block_data_or_emulated(const struct i2c_client *client,
 	return i;
 }
 EXPORT_SYMBOL(i2c_smbus_read_i2c_block_data_or_emulated);
+
+/**
+ * i2c_setup_smbus_alert - Setup SMBus alert support
+ * @adapter: the target adapter
+ * @setup: setup data for the SMBus alert handler
+ * Context: can sleep
+ *
+ * Setup handling of the SMBus alert protocol on a given I2C bus segment.
+ *
+ * Handling can be done either through our IRQ handler, or by the
+ * adapter (from its handler, periodic polling, or whatever).
+ *
+ * NOTE that if we manage the IRQ, we *MUST* know if it's level or
+ * edge triggered in order to hand it to the workqueue correctly.
+ * If triggering the alert seems to wedge the system, you probably
+ * should have said it's level triggered.
+ *
+ * This returns the ara client, which should be saved for later use with
+ * i2c_handle_smbus_alert() and ultimately i2c_unregister_device(); or NULL
+ * to indicate an error.
+ */
+struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
+					 struct i2c_smbus_alert_setup *setup)
+{
+	struct i2c_board_info ara_board_info = {
+		I2C_BOARD_INFO("smbus_alert", 0x0c),
+		.platform_data = setup,
+	};
+
+	return i2c_new_device(adapter, &ara_board_info);
+}
+EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index d4af270..d0bb035 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -183,38 +183,6 @@ static int smbalert_remove(struct i2c_client *ara)
 };
 
 /**
- * i2c_setup_smbus_alert - Setup SMBus alert support
- * @adapter: the target adapter
- * @setup: setup data for the SMBus alert handler
- * Context: can sleep
- *
- * Setup handling of the SMBus alert protocol on a given I2C bus segment.
- *
- * Handling can be done either through our IRQ handler, or by the
- * adapter (from its handler, periodic polling, or whatever).
- *
- * NOTE that if we manage the IRQ, we *MUST* know if it's level or
- * edge triggered in order to hand it to the workqueue correctly.
- * If triggering the alert seems to wedge the system, you probably
- * should have said it's level triggered.
- *
- * This returns the ara client, which should be saved for later use with
- * i2c_handle_smbus_alert() and ultimately i2c_unregister_device(); or NULL
- * to indicate an error.
- */
-struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
-					 struct i2c_smbus_alert_setup *setup)
-{
-	struct i2c_board_info ara_board_info = {
-		I2C_BOARD_INFO("smbus_alert", 0x0c),
-		.platform_data = setup,
-	};
-
-	return i2c_new_device(adapter, &ara_board_info);
-}
-EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
-
-/**
  * i2c_handle_smbus_alert - Handle an SMBus alert
  * @ara: the ARA client on the relevant adapter
  * Context: can't sleep
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

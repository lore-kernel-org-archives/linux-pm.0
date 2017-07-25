From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v10 02/10] i2c: i2c-smbus: Move i2c_setup_smbus_alert from i2c-smbus to i2c-core-smbus
Date: Tue, 25 Jul 2017 11:40:16 +0800
Message-ID: <1500954024-6860-3-git-send-email-preid@electromag.com.au>
References: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1500954024-6860-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

In preparation to adding of_i2c_setup_smbus_alert() move
i2c_setup_smbus_alert() to core module. of_i2c_setup_smbus_alert()
will call i2c_setup_smbus_alert() and this avoid module dependecy issues.

Signed-off-by: Phil Reid <preid@electromag.com.au>
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

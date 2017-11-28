From: Phil Reid <preid@electromag.com.au>
Subject: [RFC v2 1/3] i2c: smbus: move of_i2c_setup_smbus_alert declaration to i2c-core.h
Date: Tue, 28 Nov 2017 11:38:27 +0800
Message-ID: <1511840309-37964-2-git-send-email-preid@electromag.com.au>
References: <1511840309-37964-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:54625 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753558AbdK1Dig (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Nov 2017 22:38:36 -0500
In-Reply-To: <1511840309-37964-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: realmz6@gmail.com, wsa@the-dreams.de, sre@kernel.org, preid@electromag.com.au, adi-buildroot-devel@lists.sourceforge.net, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, jdelvare@suse.de, benjamin.tissoires@redhat.com

This declaration isn't used by anything outside of the i2c-core at
present. In preparation for moving the smbus_alert code from it's
own module into the i2c-core move to i2c-core.h

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/i2c-core.h    |  9 +++++++++
 drivers/i2c/i2c-smbus.c   |  3 ++-
 include/linux/i2c-smbus.h | 10 ----------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 3d3d9bf..8ef0402 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -60,3 +60,12 @@ static inline void i2c_acpi_remove_space_handler(struct i2c_adapter *adapter) {
 static inline void of_i2c_register_devices(struct i2c_adapter *adap) { }
 #endif
 extern struct notifier_block i2c_of_notifier;
+
+#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
+int of_i2c_setup_smbus_alert(struct i2c_adapter *adap);
+#else
+static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
+{
+	return 0;
+}
+#endif
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 5a1dd7f..c11a50e 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -25,6 +25,8 @@
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
+#include "i2c-core.h"
+
 struct i2c_smbus_alert {
 	struct work_struct	alert;
 	struct i2c_client	*ara;		/* Alert response address */
@@ -123,7 +125,6 @@ static void smbalert_work(struct work_struct *work)
 	alert = container_of(work, struct i2c_smbus_alert, alert);
 
 	smbus_alert(0, alert);
-
 }
 
 /* Setup SMBALERT# infrastructure */
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index fb0e040..5f16a63 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -26,7 +26,6 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
-
 /**
  * i2c_smbus_alert_setup - platform data for the smbus_alert i2c client
  * @alert_edge_triggered: whether the alert interrupt is edge (1) or level (0)
@@ -49,13 +48,4 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 					 struct i2c_smbus_alert_setup *setup);
 int i2c_handle_smbus_alert(struct i2c_client *ara);
 
-#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
-int of_i2c_setup_smbus_alert(struct i2c_adapter *adap);
-#else
-static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
-{
-	return 0;
-}
-#endif
-
 #endif /* _LINUX_I2C_SMBUS_H */
-- 
1.8.3.1

From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v11 03/10] i2c: i2c-smbus: add of_i2c_setup_smbus_alert
Date: Thu, 24 Aug 2017 17:31:03 +0800
Message-ID: <1503567070-115646-4-git-send-email-preid@electromag.com.au>
References: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy1.45ru.net.au ([203.30.46.145]:33181 "EHLO
        anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751823AbdHXJbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Aug 2017 05:31:20 -0400
In-Reply-To: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org

This commit adds of_i2c_setup_smbus_alert which allows the smbalert
driver to be attached to an i2c adapter via the device tree.

Signed-off-by: Phil Reid <preid@electromag.com.au>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/i2c/i2c.txt |  4 ++--
 drivers/i2c/i2c-core-smbus.c                  | 22 ++++++++++++++++++++++
 drivers/i2c/i2c-smbus.c                       | 10 +++++++++-
 include/linux/i2c-smbus.h                     |  9 +++++++++
 4 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c.txt b/Documentation/devicetree/bindings/i2c/i2c.txt
index cee9d50..1126398 100644
--- a/Documentation/devicetree/bindings/i2c/i2c.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c.txt
@@ -59,8 +59,8 @@ wants to support one of the below features, it should adapt the bindings below.
 	interrupts used by the device.
 
 - interrupt-names
-	"irq" and "wakeup" names are recognized by I2C core, other names are
-	left to individual drivers.
+	"irq", "wakeup" and "smbus_alert" names are recognized by I2C core,
+	other names are	left to individual drivers.
 
 - host-notify
 	device uses SMBus host notify protocol instead of interrupt line.
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 7f3ec02..4bb9927 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -625,3 +625,25 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 	return i2c_new_device(adapter, &ara_board_info);
 }
 EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
+
+#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
+int of_i2c_setup_smbus_alert(struct i2c_adapter *adapter)
+{
+	struct i2c_client *client;
+	int irq;
+
+	irq = of_property_match_string(adapter->dev.of_node, "interrupt-names",
+				       "smbus_alert");
+	if (irq == -EINVAL || irq == -ENODATA)
+		return 0;
+	else if (irq < 0)
+		return irq;
+
+	client = i2c_setup_smbus_alert(adapter, NULL);
+	if (!client)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_i2c_setup_smbus_alert);
+#endif
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index d0bb035..5a1dd7f 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -139,7 +140,14 @@ static int smbalert_probe(struct i2c_client *ara,
 	if (!alert)
 		return -ENOMEM;
 
-	irq = setup->irq;
+	if (setup) {
+		irq = setup->irq;
+	} else {
+		irq = of_irq_get_byname(adapter->dev.of_node, "smbus_alert");
+		if (irq <= 0)
+			return irq;
+	}
+
 	INIT_WORK(&alert->alert, smbalert_work);
 	alert->ara = ara;
 
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index 19efbd1..fb0e040 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -49,4 +49,13 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 					 struct i2c_smbus_alert_setup *setup);
 int i2c_handle_smbus_alert(struct i2c_client *ara);
 
+#if IS_ENABLED(CONFIG_I2C_SMBUS) && IS_ENABLED(CONFIG_OF)
+int of_i2c_setup_smbus_alert(struct i2c_adapter *adap);
+#else
+static inline int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_I2C_SMBUS_H */
-- 
1.8.3.1

From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v6 3/8] i2c: i2c-smbus: add of_i2c_setup_smbus_alert
Date: Tue,  2 May 2017 17:12:21 +0800
Message-ID: <1493716346-58517-4-git-send-email-preid@electromag.com.au>
References: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1493716346-58517-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

This commit adds of_i2c_setup_smbus_alert which allows the smbalert
driver to be attached to an i2c adapter via the device tree.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c.txt |  4 +--
 drivers/i2c/i2c-smbus.c                       | 35 +++++++++++++++++++++++++++
 include/linux/i2c-smbus.h                     |  9 +++++++
 3 files changed, 46 insertions(+), 2 deletions(-)

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
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index df0e2fa..a8f8439 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -21,6 +21,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of_irq.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
 
@@ -238,6 +239,40 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 }
 EXPORT_SYMBOL_GPL(i2c_setup_smbus_alert);
 
+int of_i2c_setup_smbus_alert(struct i2c_adapter *adap)
+{
+	struct i2c_client *client;
+	struct i2c_smbus_alert_setup *setup;
+	struct i2c_board_info info = {
+		I2C_BOARD_INFO("smbus_alert", 0x0c),
+	};
+	int irq;
+
+	if (!adap->dev.of_node)
+		return 0;
+
+	irq = of_irq_get_byname(adap->dev.of_node, "smbus_alert");
+	if (irq == -EINVAL || irq == -ENODATA)
+		return 0;
+	else if (irq < 0)
+		return irq;
+
+	setup = devm_kzalloc(&adap->dev, sizeof(struct i2c_smbus_alert_setup),
+		GFP_KERNEL);
+	if (!setup)
+		return -ENOMEM;
+
+	setup->irq = irq;
+	info.platform_data = setup;
+
+	client = i2c_new_device(adap, &info);
+	if (!client)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_i2c_setup_smbus_alert);
+
 /**
  * i2c_handle_smbus_alert - Handle an SMBus alert
  * @ara: the ARA client on the relevant adapter
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index a138502..4732d09 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -50,4 +50,13 @@ struct i2c_client *i2c_setup_smbus_alert(struct i2c_adapter *adapter,
 					 struct i2c_smbus_alert_setup *setup);
 int i2c_handle_smbus_alert(struct i2c_client *ara);
 
+#if IS_ENABLED(CONFIG_I2C_SMBUS)
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

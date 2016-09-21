From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v5 1/6] I2C: i2c-smbus: add device tree support
Date: Wed, 21 Sep 2016 16:41:09 +0800
Message-ID: <1474447274-90821-2-git-send-email-preid@electromag.com.au>
References: <1474447274-90821-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474447274-90821-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Andrea Merello <andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

According to Documentation/i2c/smbus-protocol, a smbus controller driver
that wants to hook-in smbus extensions support, can call
i2c_setup_smbus_alert(). There are very few drivers that are currently
doing this.

However the i2c-smbus module can also work with any
smbus-extensions-unaware I2C controller, as long as we provide an extra
IRQ line connected to the I2C bus ALARM signal.

This patch makes it possible to go this way via DT. Note that the DT node
will indeed describe a (little) piece of HW, that is the routing of the
ALARM signal to an IRQ line (so it seems a fair DT use to me, but RFC).

Note that AFAICT, by design, i2c-smbus module pretends to be an I2C slave
with address 0x0C (that is the alarm response address), and IMHO this is
quite consistent with usage in the DT as a I2C child node.

Signed-off-by: Andrea Merello <andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---
 Documentation/devicetree/bindings/i2c/i2c-smbus.txt | 20 ++++++++++++++++++++
 drivers/i2c/i2c-smbus.c                             | 20 +++++++++++++++-----
 2 files changed, 35 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-smbus.txt

diff --git a/Documentation/devicetree/bindings/i2c/i2c-smbus.txt b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
new file mode 100644
index 0000000..da83127
--- /dev/null
+++ b/Documentation/devicetree/bindings/i2c/i2c-smbus.txt
@@ -0,0 +1,20 @@
+* i2c-smbus extensions
+
+Required Properties:
+  - compatible: Must contain "smbus_alert"
+  - interrupts: The irq line for smbus ALERT signal
+  - reg: I2C slave address. Set to 0x0C (alert response address).
+
+Note: The i2c-smbus module registers itself as a slave I2C device. Whenever
+a smbus controller directly support smbus extensions (and its driver supports
+this), there is no need to add anything special to the DT. Otherwise, for using
+i2c-smbus with any smbus-extensions-unaware I2C controllers, you need to
+route the smbus ALARM signal to an extra IRQ line, thus you need to describe
+this in the DT.
+
+Example:
+	alert@0x0C {
+		reg = <0x0C>;
+		compatible = "smbus_alert";
+		interrupts = <0 36 IRQ_TYPE_LEVEL_LOW>;
+	};
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index b0d2679..5806db3 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/workqueue.h>
+#include <linux/of_irq.h>
 
 struct i2c_smbus_alert {
 	unsigned int		alert_edge_triggered:1;
@@ -139,20 +140,29 @@ static int smbalert_probe(struct i2c_client *ara,
 	struct i2c_smbus_alert_setup *setup = dev_get_platdata(&ara->dev);
 	struct i2c_smbus_alert *alert;
 	struct i2c_adapter *adapter = ara->adapter;
+	struct device_node *of_node = ara->dev.of_node;
 	int res;
+	int irq_type;
 
 	alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
 			     GFP_KERNEL);
 	if (!alert)
 		return -ENOMEM;
 
-	alert->alert_edge_triggered = setup->alert_edge_triggered;
-	alert->irq = setup->irq;
+	if (setup) {
+		alert->alert_edge_triggered = setup->alert_edge_triggered;
+		alert->irq = setup->irq;
+	} else if (of_node) {
+		alert->irq = irq_of_parse_and_map(of_node, 0);
+		irq_type = irq_get_trigger_type(alert->irq);
+		alert->alert_edge_triggered = (irq_type & IRQ_TYPE_EDGE_BOTH);
+	}
+
 	INIT_WORK(&alert->alert, smbus_alert);
 	alert->ara = ara;
 
-	if (setup->irq > 0) {
-		res = devm_request_irq(&ara->dev, setup->irq, smbalert_irq,
+	if (alert->irq > 0) {
+		res = devm_request_irq(&ara->dev, alert->irq, smbalert_irq,
 				       0, "smbus_alert", alert);
 		if (res)
 			return res;
@@ -160,7 +170,7 @@ static int smbalert_probe(struct i2c_client *ara,
 
 	i2c_set_clientdata(ara, alert);
 	dev_info(&adapter->dev, "supports SMBALERT#, %s trigger\n",
-		 setup->alert_edge_triggered ? "edge" : "level");
+		 alert->alert_edge_triggered ? "edge" : "level");
 
 	return 0;
 }
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

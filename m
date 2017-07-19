From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v9 1/9] i2c: i2c-smbus: Use threaded irq for smbalert
Date: Wed, 19 Jul 2017 10:14:03 +0800
Message-ID: <1500430451-43858-2-git-send-email-preid@electromag.com.au>
References: <1500430451-43858-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500430451-43858-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Prior to this commit the smbalert_irq was handling in the hard irq
context. This change switch to using a thread irq which avoids the need
for the work thread. Using threaded irq also removes the need for the
edge_triggered flag as the enabling / disabling of the hard irq for level
triggered interrupts will be handled by the irq core.

Without this change have an irq connected to something like an i2c gpio
resulted in a null ptr deferences. Specifically handle_nested_irq calls
the threaded irq handler.

There are currently 3 in tree drivers affected by this change.

i2c-parport driver calls i2c_handle_smbus_alert in a hard irq context.
This driver use edge trigger interrupts which skip the enable / disable
calls. But it still need to handle the smbus transaction on a thread. So
the work thread is kept for this driver.

i2c-parport-light & i2c-thunderx-pcidrv provide the irq number in the
setup which will result in the thread irq being used.

i2c-parport-light is edge trigger so the enable / disable call was
skipped as well.

i2c-thunderx-pcidrv is getting the edge / level trigger setting from of
data and was setting the flag as required. However the irq core should
handle this automatically.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/i2c/busses/i2c-parport-light.c   |  1 -
 drivers/i2c/busses/i2c-parport.c         |  1 -
 drivers/i2c/busses/i2c-thunderx-pcidrv.c |  6 -----
 drivers/i2c/i2c-smbus.c                  | 41 +++++++++++++-------------------
 include/linux/i2c-smbus.h                |  1 -
 5 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/i2c/busses/i2c-parport-light.c b/drivers/i2c/busses/i2c-parport-light.c
index faa8fb8..fa41ff7 100644
--- a/drivers/i2c/busses/i2c-parport-light.c
+++ b/drivers/i2c/busses/i2c-parport-light.c
@@ -123,7 +123,6 @@ static int parport_getsda(void *data)
 
 /* SMBus alert support */
 static struct i2c_smbus_alert_setup alert_data = {
-	.alert_edge_triggered	= 1,
 };
 static struct i2c_client *ara;
 static struct lineop parport_ctrl_irq = {
diff --git a/drivers/i2c/busses/i2c-parport.c b/drivers/i2c/busses/i2c-parport.c
index a8e54df..319209a 100644
--- a/drivers/i2c/busses/i2c-parport.c
+++ b/drivers/i2c/busses/i2c-parport.c
@@ -237,7 +237,6 @@ static void i2c_parport_attach(struct parport *port)
 
 	/* Setup SMBus alert if supported */
 	if (adapter_parm[type].smbus_alert) {
-		adapter->alert_data.alert_edge_triggered = 1;
 		adapter->ara = i2c_setup_smbus_alert(&adapter->adapter,
 						     &adapter->alert_data);
 		if (adapter->ara)
diff --git a/drivers/i2c/busses/i2c-thunderx-pcidrv.c b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
index ea35a895..925da84 100644
--- a/drivers/i2c/busses/i2c-thunderx-pcidrv.c
+++ b/drivers/i2c/busses/i2c-thunderx-pcidrv.c
@@ -118,8 +118,6 @@ static void thunder_i2c_clock_disable(struct device *dev, struct clk *clk)
 static int thunder_i2c_smbus_setup_of(struct octeon_i2c *i2c,
 				      struct device_node *node)
 {
-	u32 type;
-
 	if (!node)
 		return -EINVAL;
 
@@ -127,10 +125,6 @@ static int thunder_i2c_smbus_setup_of(struct octeon_i2c *i2c,
 	if (!i2c->alert_data.irq)
 		return -EINVAL;
 
-	type = irqd_get_trigger_type(irq_get_irq_data(i2c->alert_data.irq));
-	i2c->alert_data.alert_edge_triggered =
-		(type & IRQ_TYPE_LEVEL_MASK) ? 1 : 0;
-
 	i2c->ara = i2c_setup_smbus_alert(&i2c->adap, &i2c->alert_data);
 	if (!i2c->ara)
 		return -ENODEV;
diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index f9271c7..d4af270 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -25,8 +25,6 @@
 #include <linux/workqueue.h>
 
 struct i2c_smbus_alert {
-	unsigned int		alert_edge_triggered:1;
-	int			irq;
 	struct work_struct	alert;
 	struct i2c_client	*ara;		/* Alert response address */
 };
@@ -72,13 +70,12 @@ static int smbus_do_alert(struct device *dev, void *addrp)
  * The alert IRQ handler needs to hand work off to a task which can issue
  * SMBus calls, because those sleeping calls can't be made in IRQ context.
  */
-static void smbus_alert(struct work_struct *work)
+static irqreturn_t smbus_alert(int irq, void *d)
 {
-	struct i2c_smbus_alert *alert;
+	struct i2c_smbus_alert *alert = d;
 	struct i2c_client *ara;
 	unsigned short prev_addr = 0;	/* Not a valid address */
 
-	alert = container_of(work, struct i2c_smbus_alert, alert);
 	ara = alert->ara;
 
 	for (;;) {
@@ -115,21 +112,17 @@ static void smbus_alert(struct work_struct *work)
 		prev_addr = data.addr;
 	}
 
-	/* We handled all alerts; re-enable level-triggered IRQs */
-	if (!alert->alert_edge_triggered)
-		enable_irq(alert->irq);
+	return IRQ_HANDLED;
 }
 
-static irqreturn_t smbalert_irq(int irq, void *d)
+static void smbalert_work(struct work_struct *work)
 {
-	struct i2c_smbus_alert *alert = d;
+	struct i2c_smbus_alert *alert;
+
+	alert = container_of(work, struct i2c_smbus_alert, alert);
 
-	/* Disable level-triggered IRQs until we handle them */
-	if (!alert->alert_edge_triggered)
-		disable_irq_nosync(irq);
+	smbus_alert(0, alert);
 
-	schedule_work(&alert->alert);
-	return IRQ_HANDLED;
 }
 
 /* Setup SMBALERT# infrastructure */
@@ -139,28 +132,28 @@ static int smbalert_probe(struct i2c_client *ara,
 	struct i2c_smbus_alert_setup *setup = dev_get_platdata(&ara->dev);
 	struct i2c_smbus_alert *alert;
 	struct i2c_adapter *adapter = ara->adapter;
-	int res;
+	int res, irq;
 
 	alert = devm_kzalloc(&ara->dev, sizeof(struct i2c_smbus_alert),
 			     GFP_KERNEL);
 	if (!alert)
 		return -ENOMEM;
 
-	alert->alert_edge_triggered = setup->alert_edge_triggered;
-	alert->irq = setup->irq;
-	INIT_WORK(&alert->alert, smbus_alert);
+	irq = setup->irq;
+	INIT_WORK(&alert->alert, smbalert_work);
 	alert->ara = ara;
 
-	if (setup->irq > 0) {
-		res = devm_request_irq(&ara->dev, setup->irq, smbalert_irq,
-				       0, "smbus_alert", alert);
+	if (irq > 0) {
+		res = devm_request_threaded_irq(&ara->dev, irq,
+						NULL, smbus_alert,
+						IRQF_SHARED | IRQF_ONESHOT,
+						"smbus_alert", alert);
 		if (res)
 			return res;
 	}
 
 	i2c_set_clientdata(ara, alert);
-	dev_info(&adapter->dev, "supports SMBALERT#, %s trigger\n",
-		 setup->alert_edge_triggered ? "edge" : "level");
+	dev_info(&adapter->dev, "supports SMBALERT#\n");
 
 	return 0;
 }
diff --git a/include/linux/i2c-smbus.h b/include/linux/i2c-smbus.h
index a138502..19efbd1 100644
--- a/include/linux/i2c-smbus.h
+++ b/include/linux/i2c-smbus.h
@@ -42,7 +42,6 @@
  * properly set.
  */
 struct i2c_smbus_alert_setup {
-	unsigned int		alert_edge_triggered:1;
 	int			irq;
 };
 
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

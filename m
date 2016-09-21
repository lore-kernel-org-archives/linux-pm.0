From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v5 2/6] i2c: i2c-smbus: Support threaded irq.
Date: Wed, 21 Sep 2016 16:41:10 +0800
Message-ID: <1474447274-90821-3-git-send-email-preid@electromag.com.au>
References: <1474447274-90821-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1474447274-90821-1-git-send-email-preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, karl-heinz-X5L7DgJ4l23oE99TX8zNy7NAH6kLmebB@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

handle_nested_irq calls the threaded irq handler. So if the smbus_alert
irq is being generated via this an null address is derefenced. Split
IRQ up into separate functions to allow thread / non thread irq to work
correctly.

Signed-off-by: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
---
 drivers/i2c/i2c-smbus.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index 5806db3..b641cc2 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -73,13 +73,12 @@ static int smbus_do_alert(struct device *dev, void *addrp)
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
@@ -116,6 +115,17 @@ static void smbus_alert(struct work_struct *work)
 		prev_addr = data.addr;
 	}
 
+	return IRQ_HANDLED;
+}
+
+static void smbalert_work(struct work_struct *work)
+{
+	struct i2c_smbus_alert *alert;
+
+	alert = container_of(work, struct i2c_smbus_alert, alert);
+
+	smbus_alert(alert->irq, alert);
+
 	/* We handled all alerts; re-enable level-triggered IRQs */
 	if (!alert->alert_edge_triggered)
 		enable_irq(alert->irq);
@@ -158,12 +168,13 @@ static int smbalert_probe(struct i2c_client *ara,
 		alert->alert_edge_triggered = (irq_type & IRQ_TYPE_EDGE_BOTH);
 	}
 
-	INIT_WORK(&alert->alert, smbus_alert);
+	INIT_WORK(&alert->alert, smbalert_work);
 	alert->ara = ara;
 
 	if (alert->irq > 0) {
-		res = devm_request_irq(&ara->dev, alert->irq, smbalert_irq,
-				       0, "smbus_alert", alert);
+		res = devm_request_threaded_irq(&ara->dev, alert->irq,
+						smbalert_irq, smbus_alert,
+						0, "smbus_alert", alert);
 		if (res)
 			return res;
 	}
-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

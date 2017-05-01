From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v5 1/9] i2c: i2c-smbus: Support threaded irqs.
Date: Mon,  1 May 2017 16:49:51 +0800
Message-ID: <1493628599-30552-2-git-send-email-preid@electromag.com.au>
References: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, peda@axentia.se, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

handle_nested_irq calls the threaded irq handler. So if the smbus_alert
irq is being generated via this an null address is dereferenced. Split
irq up into separate functions to allow thread / non thread irq to work
correctly.

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/i2c/i2c-smbus.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/i2c-smbus.c b/drivers/i2c/i2c-smbus.c
index f9271c7..b272493 100644
--- a/drivers/i2c/i2c-smbus.c
+++ b/drivers/i2c/i2c-smbus.c
@@ -72,13 +72,12 @@ static int smbus_do_alert(struct device *dev, void *addrp)
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
@@ -115,6 +114,17 @@ static void smbus_alert(struct work_struct *work)
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
@@ -148,12 +158,14 @@ static int smbalert_probe(struct i2c_client *ara,
 
 	alert->alert_edge_triggered = setup->alert_edge_triggered;
 	alert->irq = setup->irq;
-	INIT_WORK(&alert->alert, smbus_alert);
+	INIT_WORK(&alert->alert, smbalert_work);
 	alert->ara = ara;
 
 	if (setup->irq > 0) {
-		res = devm_request_irq(&ara->dev, setup->irq, smbalert_irq,
-				       0, "smbus_alert", alert);
+		res = devm_request_threaded_irq(&ara->dev, alert->irq,
+						smbalert_irq, smbus_alert,
+						IRQF_SHARED | IRQF_ONESHOT,
+						"smbus_alert", alert);
 		if (res)
 			return res;
 	}
-- 
1.8.3.1

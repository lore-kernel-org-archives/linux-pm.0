From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v3 2/7] power: supply: tps65217: Support USB charger interrupt
Date: Sun, 18 Dec 2016 11:54:27 +0900
Message-ID: <20161218025432.20780-3-woogyom.kim@gmail.com>
References: <20161218025432.20780-1-woogyom.kim@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36375 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932462AbcLRCy6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 17 Dec 2016 21:54:58 -0500
In-Reply-To: <20161218025432.20780-1-woogyom.kim@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>

TPS65217 has two charger interrupts - AC and USB power status change.

Interrupt number in the TPS65217 driver data:
  IRQ number is only used on requesting the interrupt, so no need to keep
  it inside the driver data.

Interrupt handler:
  Check not only AC but also USB charger status.
  In both cases, enable charging operation.

Interrupt request:
  If an interrupt number is invalid, then use legacy polling thread.
  Otherwise, create IRQ threads to handle AC and USB charger event.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 52 ++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 4fe71abe1bd3..482ee9f9edff 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -35,6 +35,8 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps65217.h>
 
+#define CHARGER_STATUS_PRESENT	(TPS65217_STATUS_ACPWR | TPS65217_STATUS_USBPWR)
+#define NUM_CHARGER_IRQS	2
 #define POLL_INTERVAL		(HZ * 2)
 
 struct tps65217_charger {
@@ -46,8 +48,6 @@ struct tps65217_charger {
 	int	prev_ac_online;
 
 	struct task_struct	*poll_task;
-
-	int	irq;
 };
 
 static enum power_supply_property tps65217_ac_props[] = {
@@ -144,8 +144,8 @@ static irqreturn_t tps65217_charger_irq(int irq, void *dev)
 
 	dev_dbg(charger->dev, "%s: 0x%x\n", __func__, val);
 
-	/* check for AC status bit */
-	if (val & TPS65217_STATUS_ACPWR) {
+	/* check for charger status bit */
+	if (val & CHARGER_STATUS_PRESENT) {
 		ret = tps65217_enable_charging(charger);
 		if (ret) {
 			dev_err(charger->dev,
@@ -201,8 +201,9 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	struct tps65217_charger *charger;
 	struct power_supply_config cfg = {};
 	struct task_struct *poll_task;
-	int irq;
+	int irq[NUM_CHARGER_IRQS];
 	int ret;
+	int i;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
@@ -225,10 +226,8 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(charger->ac);
 	}
 
-	irq = platform_get_irq_byname(pdev, "AC");
-	if (irq < 0)
-		irq = -ENXIO;
-	charger->irq = irq;
+	irq[0] = platform_get_irq_byname(pdev, "USB");
+	irq[1] = platform_get_irq_byname(pdev, "AC");
 
 	ret = tps65217_config_charger(charger);
 	if (ret < 0) {
@@ -236,21 +235,8 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (irq != -ENXIO) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-						tps65217_charger_irq,
-						0, "tps65217-charger",
-						charger);
-		if (ret) {
-			dev_err(charger->dev,
-				"Unable to register irq %d err %d\n", irq,
-				ret);
-			return ret;
-		}
-
-		/* Check current state */
-		tps65217_charger_irq(irq, charger);
-	} else {
+	/* Create a polling thread if an interrupt is invalid */
+	if (irq[0] < 0 || irq[1] < 0) {
 		poll_task = kthread_run(tps65217_charger_poll_task,
 					charger, "ktps65217charger");
 		if (IS_ERR(poll_task)) {
@@ -261,6 +247,24 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 		}
 
 		charger->poll_task = poll_task;
+		return 0;
+	}
+
+	/* Create IRQ threads for charger interrupts */
+	for (i = 0; i < NUM_CHARGER_IRQS; i++) {
+		ret = devm_request_threaded_irq(&pdev->dev, irq[i], NULL,
+						tps65217_charger_irq,
+						0, "tps65217-charger",
+						charger);
+		if (ret) {
+			dev_err(charger->dev,
+				"Unable to register irq %d err %d\n", irq[i],
+				ret);
+			return ret;
+		}
+
+		/* Check current state */
+		tps65217_charger_irq(-1, charger);
 	}
 
 	return 0;
-- 
2.11.0


From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH v2 1/8] power: supply: tps65217: Support USB charger interrupt
Date: Fri,  9 Dec 2016 16:48:59 +0900
Message-ID: <20161209074906.27545-2-woogyom.kim@gmail.com>
References: <20161209074906.27545-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161209074906.27545-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-pm@vger.kernel.org

TPS65217 has two charger interrupts - AC or USB power status change.

Interrupt handler:
  Check not only AC but also USB charger status.
  In both cases, enable charging operation.

Interrupt request:
  If an interrupt number is invalid, then use legacy polling thread.
  Otherwise, create IRQ threads to handle AC and USB charger event.

Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 47 +++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 9fd019f..2000e59 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -35,6 +35,8 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps65217.h>
 
+#define CHARGER_STATUS_PRESENT	(TPS65217_STATUS_ACPWR | TPS65217_STATUS_USBPWR)
+#define NUM_CHARGER_IRQS	2
 #define POLL_INTERVAL		(HZ * 2)
 
 struct tps65217_charger {
@@ -144,8 +146,8 @@ static irqreturn_t tps65217_charger_irq(int irq, void *dev)
 
 	dev_dbg(charger->dev, "%s: 0x%x\n", __func__, val);
 
-	/* check for AC status bit */
-	if (val & TPS65217_STATUS_ACPWR) {
+	/* check for charger status bit */
+	if (val & CHARGER_STATUS_PRESENT) {
 		ret = tps65217_enable_charging(charger);
 		if (ret) {
 			dev_err(charger->dev,
@@ -200,8 +202,9 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 	struct tps65217 *tps = dev_get_drvdata(pdev->dev.parent);
 	struct tps65217_charger *charger;
 	struct power_supply_config cfg = {};
-	int irq;
+	int irq[NUM_CHARGER_IRQS];
 	int ret;
+	int i;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
@@ -224,10 +227,8 @@ static int tps65217_charger_probe(struct platform_device *pdev)
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
@@ -235,29 +236,35 @@ static int tps65217_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (irq != -ENXIO) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+	/* Create a polling thread if an interrupt is invalid */
+	if (irq[0] < 0 || irq[1] < 0) {
+		charger->poll_task = kthread_run(tps65217_charger_poll_task,
+						charger, "ktps65217charger");
+		if (IS_ERR(charger->poll_task)) {
+			ret = PTR_ERR(charger->poll_task);
+			dev_err(charger->dev,
+				"Unable to run kthread err %d\n", ret);
+			return ret;
+		}
+
+		return 0;
+	}
+
+	/* Create IRQ threads for charger interrupts */
+	for (i = 0; i < NUM_CHARGER_IRQS; i++) {
+		ret = devm_request_threaded_irq(&pdev->dev, irq[i], NULL,
 						tps65217_charger_irq,
 						0, "tps65217-charger",
 						charger);
 		if (ret) {
 			dev_err(charger->dev,
-				"Unable to register irq %d err %d\n", irq,
+				"Unable to register irq %d err %d\n", irq[i],
 				ret);
 			return ret;
 		}
 
 		/* Check current state */
-		tps65217_charger_irq(irq, charger);
-	} else {
-		charger->poll_task = kthread_run(tps65217_charger_poll_task,
-						charger, "ktps65217charger");
-		if (IS_ERR(charger->poll_task)) {
-			ret = PTR_ERR(charger->poll_task);
-			dev_err(charger->dev,
-				"Unable to run kthread err %d\n", ret);
-			return ret;
-		}
+		tps65217_charger_irq(-1, charger);
 	}
 
 	return 0;
-- 
2.9.3

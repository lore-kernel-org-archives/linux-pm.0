From: Milo Kim <woogyom.kim@gmail.com>
Subject: [PATCH 3/5] power: supply: tps65217: Support USB charger interrupt
Date: Tue, 15 Nov 2016 22:18:53 +0900
Message-ID: <20161115131855.4175-4-woogyom.kim@gmail.com>
References: <20161115131855.4175-1-woogyom.kim@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161115131855.4175-1-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Milo Kim <woogyom.kim@gmail.com>
List-Id: linux-pm@vger.kernel.org

TPS65217 has two charger interrupts - AC or USB power status change.

Interrupt request:
  If an interrupt number is not defined, then use legacy polling thread.
  Otherwise, create IRQ threads to handle AC or USB charger event.

Interrupt handler:
  Check not only AC but also USB charger status.
  In both cases, enable charging operation.

Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
---
 drivers/power/supply/tps65217_charger.c | 52 +++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 55a4f34..2894132 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -35,7 +35,9 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/tps65217.h>
 
+#define CHARGER_STATUS_PRESENT	(TPS65217_STATUS_ACPWR | TPS65217_STATUS_USBPWR)
 #define POLL_INTERVAL		(HZ * 2)
+#define NUM_CHARGER_IRQS	2
 
 struct tps65217_charger {
 	struct tps65217 *tps;
@@ -142,8 +144,8 @@ static irqreturn_t tps65217_charger_irq(int irq, void *dev)
 
 	dev_dbg(charger->dev, "%s: 0x%x\n", __func__, val);
 
-	/* check for AC status bit */
-	if (val & TPS65217_STATUS_ACPWR) {
+	/* check for charger status bit */
+	if (val & CHARGER_STATUS_PRESENT) {
 		ret = tps65217_enable_charging(charger);
 		if (ret) {
 			dev_err(charger->dev,
@@ -197,37 +199,43 @@ static int tps65217_charger_request_interrupt(struct platform_device *pdev)
 {
 	struct tps65217_charger *charger = platform_get_drvdata(pdev);
 	struct task_struct *poll_task;
-	int irq;
+	int irq[NUM_CHARGER_IRQS];
 	int ret;
+	int i;
+
+	irq[0] = platform_get_irq_byname(pdev, "AC");
+	irq[1] = platform_get_irq_byname(pdev, "USB");
+
+	/* Create a polling thread if an interrupt is invalid */
+	if (irq[0] < 0 || irq[1] < 0) {
+		poll_task = kthread_run(tps65217_charger_poll_task, charger,
+					"ktps65217charger");
+		if (IS_ERR(poll_task)) {
+			ret = PTR_ERR(poll_task);
+			dev_err(charger->dev, "Unable to run kthread err %d\n", ret);
+			return ret;
+		}
+
+		charger->poll_task = poll_task;
 
-	irq = platform_get_irq_byname(pdev, "AC");
-	if (irq < 0)
-		irq = -ENXIO;
+		return 0;
+	}
 
-	if (irq != -ENXIO) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+	/* Create IRQ threads for charger interrupts */
+	for (i = 0; i < NUM_CHARGER_IRQS; i++) {
+		ret = devm_request_threaded_irq(&pdev->dev, irq[i], NULL,
 						tps65217_charger_irq, 0,
 						"tps65217-charger", charger);
 		if (ret) {
 			dev_err(charger->dev,
-				"Unable to register irq %d err %d\n", irq, ret);
+				"Unable to register irq %d err %d\n", irq[i],
+				ret);
 			return ret;
 		}
-
-		/* Check current state */
-		tps65217_charger_irq(irq, charger);
-		return 0;
-	}
-
-	poll_task = kthread_run(tps65217_charger_poll_task, charger,
-				"ktps65217charger");
-	if (IS_ERR(poll_task)) {
-		ret = PTR_ERR(poll_task);
-		dev_err(charger->dev, "Unable to run kthread err %d\n", ret);
-		return ret;
 	}
 
-	charger->poll_task = poll_task;
+	/* Check current state */
+	tps65217_charger_irq(-1, charger);
 
 	return 0;
 }
-- 
2.9.3

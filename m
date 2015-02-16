From: Valentin Rothberg <Valentin.Rothberg@lip6.fr>
Subject: [PATCH] ab8500_fg.c: only request threaded IRQs when necessary
Date: Mon, 16 Feb 2015 17:32:48 +0100
Message-ID: <1424104368-11202-1-git-send-email-Valentin.Rothberg@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Rothberg <Valentin.Rothberg@lip6.fr>
List-Id: linux-pm@vger.kernel.org

All 5 IRQ handlers of the driver are requested as threaded interrupt
handlers.  However, only 1 handler can block.  The remaining 4 handlers
defer the actual handling to a workqueue.  Hence, 4 of 5 IRQ handlers
have a considerable overhead, since they are executed in a kernel thread
to schedule another kernel thread (workqueue).

This change splits up the 5 interrupt handlers into top halves (_th) and
bottom halves (_bh) and resolves the aforementioned overhead by only
requesting threaded interrupts (i.e., bottom halves) when necessary.

Signed-off-by: Valentin Rothberg <Valentin.Rothberg@lip6.fr>
---
Due to the lack of hardware I cannot test this change.  

I discovered this issue with scripts/coccinelle/misc/irqf_oneshot.cocci since
the threaded interrupts were not requested with IRQF_ONESHOT.  By looking closer
I saw the issue of this change.
---
 drivers/power/ab8500_fg.c | 46 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index c908658..dcd0901 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -3062,11 +3062,14 @@ static int ab8500_fg_remove(struct platform_device *pdev)
 }
 
 /* ab8500 fg driver interrupts and their respective isr */
-static struct ab8500_fg_interrupts ab8500_fg_irq[] = {
+static struct ab8500_fg_interrupts ab8500_fg_irq_th[] = {
 	{"NCONV_ACCU", ab8500_fg_cc_convend_handler},
 	{"BATT_OVV", ab8500_fg_batt_ovv_handler},
 	{"LOW_BAT_F", ab8500_fg_lowbatf_handler},
 	{"CC_INT_CALIB", ab8500_fg_cc_int_calib_handler},
+};
+
+static struct ab8500_fg_interrupts ab8500_fg_irq_bh[] = {
 	{"CCEOC", ab8500_fg_cc_data_end_handler},
 };
 
@@ -3194,21 +3197,36 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	init_completion(&di->ab8500_fg_started);
 	init_completion(&di->ab8500_fg_complete);
 
-	/* Register interrupts */
-	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq); i++) {
-		irq = platform_get_irq_byname(pdev, ab8500_fg_irq[i].name);
-		ret = request_threaded_irq(irq, NULL, ab8500_fg_irq[i].isr,
-			IRQF_SHARED | IRQF_NO_SUSPEND,
-			ab8500_fg_irq[i].name, di);
+	/* Register primary interrupt handlers */
+	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq_th); i++) {
+		irq = platform_get_irq_byname(pdev, ab8500_fg_irq_th[i].name);
+		ret = request_irq(irq, ab8500_fg_irq_th[i].isr,
+				  IRQF_SHARED | IRQF_NO_SUSPEND,
+				  ab8500_fg_irq_th[i].name, di);
 
 		if (ret != 0) {
-			dev_err(di->dev, "failed to request %s IRQ %d: %d\n"
-				, ab8500_fg_irq[i].name, irq, ret);
+			dev_err(di->dev, "failed to request %s IRQ %d: %d\n",
+				ab8500_fg_irq_th[i].name, irq, ret);
 			goto free_irq;
 		}
 		dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
-			ab8500_fg_irq[i].name, irq, ret);
+			ab8500_fg_irq_th[i].name, irq, ret);
 	}
+
+	/* Register threaded interrupt handler */
+	irq = platform_get_irq_byname(pdev, ab8500_fg_irq_bh[0].name);
+	ret = request_threaded_irq(irq, NULL, ab8500_fg_irq_bh[0].isr,
+				IRQF_SHARED | IRQF_NO_SUSPEND | IRQF_ONESHOT,
+			ab8500_fg_irq_bh[0].name, di);
+
+	if (ret != 0) {
+		dev_err(di->dev, "failed to request %s IRQ %d: %d\n",
+			ab8500_fg_irq_bh[0].name, irq, ret);
+		goto free_irq;
+	}
+	dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
+		ab8500_fg_irq_bh[0].name, irq, ret);
+
 	di->irq = platform_get_irq_byname(pdev, "CCEOC");
 	disable_irq(di->irq);
 	di->nbr_cceoc_irq_cnt = 0;
@@ -3245,11 +3263,13 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 free_irq:
 	power_supply_unregister(&di->fg_psy);
 
-	/* We also have to free all successfully registered irqs */
-	for (i = i - 1; i >= 0; i--) {
-		irq = platform_get_irq_byname(pdev, ab8500_fg_irq[i].name);
+	/* We also have to free all registered irqs */
+	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq_th); i++) {
+		irq = platform_get_irq_byname(pdev, ab8500_fg_irq_th[i].name);
 		free_irq(irq, di);
 	}
+	irq = platform_get_irq_byname(pdev, ab8500_fg_irq_bh[0].name);
+	free_irq(irq, di);
 free_inst_curr_wq:
 	destroy_workqueue(di->fg_wq);
 	return ret;
-- 
2.1.0

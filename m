From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH v1 1/1] thermal: rcar_gen3_thermal: request IRQ after device initialization
Date: Thu, 11 Apr 2019 19:03:52 +0900
Message-ID: <20190411100352.15977-1-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jiada_wang@mentor.com
List-Id: linux-pm@vger.kernel.org

Currently IRQ is remain enabled after .remove, later if device is probed,
IRQ is requested before .thermal_init, this may cause IRQ function be
triggered but not able to clear IRQ status, thus cause system to hang.

this patch by moving request of IRQ after device initialization to
avoid this issue.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/thermal/rcar_gen3_thermal.c | 48 ++++++++++++++++-------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/rcar_gen3_thermal.c b/drivers/thermal/rcar_gen3_thermal.c
index 88fa41cf16e8..4d095d7f9763 100644
--- a/drivers/thermal/rcar_gen3_thermal.c
+++ b/drivers/thermal/rcar_gen3_thermal.c
@@ -375,28 +375,6 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	/*
-	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
-	 * to trigger on the low and high trip points of the current
-	 * temp window at this point.
-	 */
-	for (i = 0; i < 2; i++) {
-		irq = platform_get_irq(pdev, i);
-		if (irq < 0)
-			return irq;
-
-		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
-					 dev_name(dev), i);
-		if (!irqname)
-			return -ENOMEM;
-
-		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
-						rcar_gen3_thermal_irq_thread,
-						IRQF_SHARED, irqname, priv);
-		if (ret)
-			return ret;
-	}
-
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -458,6 +436,32 @@ static int rcar_gen3_thermal_probe(struct platform_device *pdev)
 		goto error_unregister;
 	}
 
+	/*
+	 * Request 2 (of the 3 possible) IRQs, the driver only needs to
+	 * to trigger on the low and high trip points of the current
+	 * temp window at this point.
+	 */
+	for (i = 0; i < 2; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			ret = irq;
+			goto error_unregister;
+		}
+
+		irqname = devm_kasprintf(dev, GFP_KERNEL, "%s:ch%d",
+					 dev_name(dev), i);
+		if (!irqname) {
+			ret = -ENOMEM;
+			goto error_unregister;
+		}
+
+		ret = devm_request_threaded_irq(dev, irq, rcar_gen3_thermal_irq,
+						rcar_gen3_thermal_irq_thread,
+						IRQF_SHARED, irqname, priv);
+		if (ret)
+			goto error_unregister;
+	}
+
 	rcar_thermal_irq_set(priv, true);
 
 	return 0;
-- 
2.19.2

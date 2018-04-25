From: <sean.wang@mediatek.com>
Subject: [PATCH v2 11/17] rtc: mt6397: convert to use device managed functions
Date: Wed, 25 Apr 2018 17:32:37 +0800
Message-ID: <6d203dafedc93496baf27f695d21e00c9564d840.1524646231.git.sean.wang@mediatek.com>
References: <cover.1524646231.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1524646231.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, lee.jones@linaro.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, matthias.bgg@gmail.com, eddie.huang@mediatek.com
Cc: devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Use device managed operation to simplify error handling, reduce source
code size, and reduce the likelyhood of bugs, and remove our removal
callback which contains anything already done by device managed functions.

v1 -> v2:
 - Use devm_rtc_allocate_device() and rtc_register_device instead of
   devm_rtc_device_register.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/rtc/rtc-mt6397.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index 398bae5..91d584a 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -14,6 +14,7 @@
 
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/rtc.h>
@@ -328,10 +329,10 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
-	ret = request_threaded_irq(rtc->irq, NULL,
-				   mtk_rtc_irq_handler_thread,
-				   IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
-				   "mt6397-rtc", rtc);
+	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
+					mtk_rtc_irq_handler_thread,
+					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
+					"mt6397-rtc", rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			rtc->irq, ret);
@@ -340,30 +341,13 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	rtc->rtc_dev = rtc_device_register("mt6397-rtc", &pdev->dev,
-					   &mtk_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc->rtc_dev)) {
-		dev_err(&pdev->dev, "register rtc device failed\n");
-		ret = PTR_ERR(rtc->rtc_dev);
-		goto out_free_irq;
-	}
-
-	return 0;
-
-out_free_irq:
-	free_irq(rtc->irq, rtc->rtc_dev);
-
-	return ret;
-}
+	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc->rtc_dev))
+		return PTR_ERR(rtc->rtc_dev);
 
-static int mtk_rtc_remove(struct platform_device *pdev)
-{
-	struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
+	rtc->rtc_dev->ops = &mtk_rtc_ops;
 
-	rtc_device_unregister(rtc->rtc_dev);
-	free_irq(rtc->irq, rtc->rtc_dev);
-
-	return 0;
+	return rtc_register_device(rtc->rtc_dev);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -405,7 +389,6 @@ static struct platform_driver mtk_rtc_driver = {
 		.pm = &mt6397_pm_ops,
 	},
 	.probe	= mtk_rtc_probe,
-	.remove = mtk_rtc_remove,
 };
 
 module_platform_driver(mtk_rtc_driver);
-- 
2.7.4

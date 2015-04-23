From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC/RFT 6/6] spi: qup: Get rid of clock handling as its done using runtime callbacks
Date: Thu, 23 Apr 2015 14:15:44 +0530
Message-ID: <1429778744-13352-7-git-send-email-rnayak@codeaurora.org>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Remove all clock handling from the driver as this is not handled from
within platform runtime callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/spi/spi-qup.c | 54 ++++++++++-----------------------------------------
 1 file changed, 10 insertions(+), 44 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 810a7fa..a95993b 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -131,7 +131,6 @@ struct spi_qup {
 	void __iomem		*base;
 	struct device		*dev;
 	struct clk		*cclk;	/* core clock */
-	struct clk		*iclk;	/* interface clock */
 	int			irq;
 	spinlock_t		lock;
 
@@ -753,7 +752,7 @@ err_tx:
 static int spi_qup_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
-	struct clk *iclk, *cclk;
+	struct clk *cclk;
 	struct spi_qup *controller;
 	struct resource *res;
 	struct device *dev;
@@ -775,10 +774,6 @@ static int spi_qup_probe(struct platform_device *pdev)
 	if (IS_ERR(cclk))
 		return PTR_ERR(cclk);
 
-	iclk = devm_clk_get(dev, "iface");
-	if (IS_ERR(iclk))
-		return PTR_ERR(iclk);
-
 	/* This is optional parameter */
 	if (of_property_read_u32(dev->of_node, "spi-max-frequency", &max_freq))
 		max_freq = SPI_MAX_RATE;
@@ -788,23 +783,15 @@ static int spi_qup_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 
-	ret = clk_prepare_enable(cclk);
-	if (ret) {
-		dev_err(dev, "cannot enable core clock\n");
-		return ret;
-	}
-
-	ret = clk_prepare_enable(iclk);
-	if (ret) {
-		clk_disable_unprepare(cclk);
-		dev_err(dev, "cannot enable iface clock\n");
-		return ret;
-	}
+	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
 
 	master = spi_alloc_master(dev, sizeof(struct spi_qup));
 	if (!master) {
-		clk_disable_unprepare(cclk);
-		clk_disable_unprepare(iclk);
+		pm_runtime_set_suspended(dev);
+		pm_runtime_disable(dev);
 		dev_err(dev, "cannot allocate master\n");
 		return -ENOMEM;
 	}
@@ -832,7 +819,6 @@ static int spi_qup_probe(struct platform_device *pdev)
 
 	controller->dev = dev;
 	controller->base = base;
-	controller->iclk = iclk;
 	controller->cclk = cclk;
 	controller->irq = irq;
 
@@ -904,24 +890,17 @@ static int spi_qup_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_dma;
 
-	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
 	ret = devm_spi_register_master(dev, master);
 	if (ret)
-		goto disable_pm;
+		goto error_dma;
 
 	return 0;
 
-disable_pm:
-	pm_runtime_disable(&pdev->dev);
 error_dma:
 	spi_qup_release_dma(master);
 error:
-	clk_disable_unprepare(cclk);
-	clk_disable_unprepare(iclk);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 	spi_master_put(master);
 	return ret;
 }
@@ -969,8 +948,6 @@ static int spi_qup_suspend(struct device *device)
 	if (ret)
 		return ret;
 
-	clk_disable_unprepare(controller->cclk);
-	clk_disable_unprepare(controller->iclk);
 	return 0;
 }
 
@@ -980,14 +957,6 @@ static int spi_qup_resume(struct device *device)
 	struct spi_qup *controller = spi_master_get_devdata(master);
 	int ret;
 
-	ret = clk_prepare_enable(controller->iclk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(controller->cclk);
-	if (ret)
-		return ret;
-
 	ret = spi_qup_set_state(controller, QUP_STATE_RESET);
 	if (ret)
 		return ret;
@@ -1012,9 +981,6 @@ static int spi_qup_remove(struct platform_device *pdev)
 
 	spi_qup_release_dma(master);
 
-	clk_disable_unprepare(controller->cclk);
-	clk_disable_unprepare(controller->iclk);
-
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

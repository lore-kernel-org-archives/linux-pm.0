From: Rajendra Nayak <rnayak@codeaurora.org>
Subject: [RFC/RFT 5/6] i2c: qup: Get rid of clock handling as its done using runtime callbacks
Date: Thu, 23 Apr 2015 14:15:43 +0530
Message-ID: <1429778744-13352-6-git-send-email-rnayak@codeaurora.org>
References: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46827 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682AbbDWIqI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Apr 2015 04:46:08 -0400
In-Reply-To: <1429778744-13352-1-git-send-email-rnayak@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>

Remove all clock handling from the driver as this is not handled from
within platform runtime callbacks.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/i2c/busses/i2c-qup.c | 74 ++++++++++----------------------------------
 1 file changed, 16 insertions(+), 58 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index fdcbdab..465a2b2 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -104,7 +104,6 @@ struct qup_i2c_dev {
 	void __iomem		*base;
 	int			irq;
 	struct clk		*clk;
-	struct clk		*pclk;
 	struct i2c_adapter	adap;
 
 	int			clk_ctl;
@@ -532,24 +531,6 @@ static struct i2c_adapter_quirks qup_i2c_quirks = {
 	.max_read_len = QUP_READ_LIMIT,
 };
 
-static void qup_i2c_enable_clocks(struct qup_i2c_dev *qup)
-{
-	clk_prepare_enable(qup->clk);
-	clk_prepare_enable(qup->pclk);
-}
-
-static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
-{
-	u32 config;
-
-	qup_i2c_change_state(qup, QUP_RESET_STATE);
-	clk_disable_unprepare(qup->clk);
-	config = readl(qup->base + QUP_CONFIG);
-	config |= QUP_CLOCK_AUTO_GATE;
-	writel(config, qup->base + QUP_CONFIG);
-	clk_disable_unprepare(qup->pclk);
-}
-
 static int qup_i2c_probe(struct platform_device *pdev)
 {
 	static const int blk_sizes[] = {4, 16, 32};
@@ -596,13 +577,10 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(qup->clk);
 	}
 
-	qup->pclk = devm_clk_get(qup->dev, "iface");
-	if (IS_ERR(qup->pclk)) {
-		dev_err(qup->dev, "Could not get iface clock\n");
-		return PTR_ERR(qup->pclk);
-	}
-
-	qup_i2c_enable_clocks(qup);
+	pm_runtime_set_autosuspend_delay(qup->dev, MSEC_PER_SEC);
+	pm_runtime_use_autosuspend(qup->dev);
+	pm_runtime_enable(qup->dev);
+	pm_runtime_get_sync(qup->dev);
 
 	/*
 	 * Bootloaders might leave a pending interrupt on certain QUP's,
@@ -673,22 +651,15 @@ static int qup_i2c_probe(struct platform_device *pdev)
 	qup->adap.dev.of_node = pdev->dev.of_node;
 	strlcpy(qup->adap.name, "QUP I2C adapter", sizeof(qup->adap.name));
 
-	pm_runtime_set_autosuspend_delay(qup->dev, MSEC_PER_SEC);
-	pm_runtime_use_autosuspend(qup->dev);
-	pm_runtime_set_active(qup->dev);
-	pm_runtime_enable(qup->dev);
-
 	ret = i2c_add_adapter(&qup->adap);
 	if (ret)
-		goto fail_runtime;
+		goto fail;
 
 	return 0;
 
-fail_runtime:
+fail:
 	pm_runtime_disable(qup->dev);
 	pm_runtime_set_suspended(qup->dev);
-fail:
-	qup_i2c_disable_clocks(qup);
 	return ret;
 }
 
@@ -697,7 +668,6 @@ static int qup_i2c_remove(struct platform_device *pdev)
 	struct qup_i2c_dev *qup = platform_get_drvdata(pdev);
 
 	disable_irq(qup->irq);
-	qup_i2c_disable_clocks(qup);
 	i2c_del_adapter(&qup->adap);
 	pm_runtime_disable(qup->dev);
 	pm_runtime_set_suspended(qup->dev);
@@ -707,43 +677,31 @@ static int qup_i2c_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int qup_i2c_pm_suspend_runtime(struct device *device)
 {
+	u32 config;
 	struct qup_i2c_dev *qup = dev_get_drvdata(device);
 
 	dev_dbg(device, "pm_runtime: suspending...\n");
-	qup_i2c_disable_clocks(qup);
+	qup_i2c_change_state(qup, QUP_RESET_STATE);
+	config = readl(qup->base + QUP_CONFIG);
+	config |= QUP_CLOCK_AUTO_GATE;
+	writel(config, qup->base + QUP_CONFIG);
 	return 0;
 }
 
 static int qup_i2c_pm_resume_runtime(struct device *device)
 {
+	u32 config;
 	struct qup_i2c_dev *qup = dev_get_drvdata(device);
 
-	dev_dbg(device, "pm_runtime: resuming...\n");
-	qup_i2c_enable_clocks(qup);
-	return 0;
-}
-#endif
-
-#ifdef CONFIG_PM_SLEEP
-static int qup_i2c_suspend(struct device *device)
-{
-	qup_i2c_pm_suspend_runtime(device);
-	return 0;
-}
-
-static int qup_i2c_resume(struct device *device)
-{
-	qup_i2c_pm_resume_runtime(device);
-	pm_runtime_mark_last_busy(device);
-	pm_request_autosuspend(device);
+	dev_dbg(device, "pm_runtime: suspending...\n");
+	config = readl(qup->base + QUP_CONFIG);
+	config &= ~QUP_CLOCK_AUTO_GATE;
+	writel(config, qup->base + QUP_CONFIG);
 	return 0;
 }
 #endif
 
 static const struct dev_pm_ops qup_i2c_qup_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(
-		qup_i2c_suspend,
-		qup_i2c_resume)
 	SET_RUNTIME_PM_OPS(
 		qup_i2c_pm_suspend_runtime,
 		qup_i2c_pm_resume_runtime,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation


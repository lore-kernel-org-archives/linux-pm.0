From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 1/2] PM: add runtime PM support to core Primecell
	driver
Date: Tue, 23 Aug 2011 11:16:18 +0100
Message-ID: <E1Qvo1q-0000qv-TQ__32239.1822039664$1314094650$gmane$org@rmk-PC.arm.linux.org.uk>
References: <20110823101555.GE19622@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110823101555.GE19622@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Add runtime PM support to the core Primecell driver, following the PCI
model of how this is done.

Rather than having every driver fiddle about with enabling runtime PM,
that's dealt with in the core and instead, drivers just do a put() in
their probe and a balancing get() in their remove function to activate
runtime PM for the device.

As we're dealing with enabling runtime PM in the core, fix up spi-pl022
as it must not enable and disable runtime PM itself anymore.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/amba/bus.c      |   57 +++++++++++++++++++++++++++++++--
 drivers/spi/spi-pl022.c |   80 ++++++++++++++++++++++++++++-------------------
 2 files changed, 102 insertions(+), 35 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d74926e..84bdaac 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -365,6 +365,40 @@ static int amba_pm_restore_noirq(struct device *dev)
 
 #endif /* !CONFIG_HIBERNATE_CALLBACKS */
 
+#ifdef CONFIG_PM_RUNTIME
+/*
+ * Hooks to provide runtime PM of the pclk (bus clock).  It is safe to
+ * enable/disable the bus clock at runtime PM suspend/resume as this
+ * does not result in loss of context.  However, disabling vcore power
+ * would do, so we leave that to the driver.
+ */
+static int amba_pm_runtime_suspend(struct device *dev)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+	int ret = pm_generic_runtime_suspend(dev);
+
+	if (ret == 0 && dev->driver)
+		clk_disable(pcdev->pclk);
+
+	return ret;
+}
+
+static int amba_pm_runtime_resume(struct device *dev)
+{
+	struct amba_device *pcdev = to_amba_device(dev);
+	int ret;
+
+	if (dev->driver) {
+		ret = clk_enable(pcdev->pclk);
+		/* Failure is probably fatal to the system, but... */
+		if (ret)
+			return ret;
+	}
+
+	return pm_generic_runtime_resume(dev);
+}
+#endif
+
 #ifdef CONFIG_PM
 
 static const struct dev_pm_ops amba_pm = {
@@ -383,8 +417,8 @@ static const struct dev_pm_ops amba_pm = {
 	.poweroff_noirq	= amba_pm_poweroff_noirq,
 	.restore_noirq	= amba_pm_restore_noirq,
 	SET_RUNTIME_PM_OPS(
-		pm_generic_runtime_suspend,
-		pm_generic_runtime_resume,
+		amba_pm_runtime_suspend,
+		amba_pm_runtime_resume,
 		pm_generic_runtime_idle
 	)
 };
@@ -494,10 +528,18 @@ static int amba_probe(struct device *dev)
 		if (ret)
 			break;
 
+		pm_runtime_get_noresume(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+
 		ret = pcdrv->probe(pcdev, id);
 		if (ret == 0)
 			break;
 
+		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
+		pm_runtime_put_noidle(dev);
+
 		amba_put_disable_pclk(pcdev);
 		amba_put_disable_vcore(pcdev);
 	} while (0);
@@ -509,7 +551,16 @@ static int amba_remove(struct device *dev)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	struct amba_driver *drv = to_amba_driver(dev->driver);
-	int ret = drv->remove(pcdev);
+	int ret;
+
+	pm_runtime_get_sync(dev);
+	ret = drv->remove(pcdev);
+	pm_runtime_put_noidle(dev);
+
+	/* Undo the runtime PM settings in amba_probe() */
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
 
 	amba_put_disable_pclk(pcdev);
 	amba_put_disable_vcore(pcdev);
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 730b4a3..078338f 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -515,9 +515,6 @@ static void giveback(struct pl022 *pl022)
 	if (msg->complete)
 		msg->complete(msg->context);
 	/* This message is completed, so let's turn off the clocks & power */
-	clk_disable(pl022->clk);
-	amba_pclk_disable(pl022->adev);
-	amba_vcore_disable(pl022->adev);
 	pm_runtime_put(&pl022->adev->dev);
 }
 
@@ -1545,9 +1542,6 @@ static void pump_messages(struct work_struct *work)
 	 * (poll/interrupt/DMA)
 	 */
 	pm_runtime_get_sync(&pl022->adev->dev);
-	amba_vcore_enable(pl022->adev);
-	amba_pclk_enable(pl022->adev);
-	clk_enable(pl022->clk);
 	restore_state(pl022);
 	flush(pl022);
 
@@ -2186,8 +2180,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 	printk(KERN_INFO "pl022: mapped registers from 0x%08x to %p\n",
 	       adev->res.start, pl022->virtbase);
-	pm_runtime_enable(dev);
-	pm_runtime_resume(dev);
 
 	pl022->clk = clk_get(&adev->dev, NULL);
 	if (IS_ERR(pl022->clk)) {
@@ -2195,7 +2187,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		dev_err(&adev->dev, "could not retrieve SSP/SPI bus clock\n");
 		goto err_no_clk;
 	}
-
 	/* Disable SSP */
 	writew((readw(SSP_CR1(pl022->virtbase)) & (~SSP_CR1_MASK_SSE)),
 	       SSP_CR1(pl022->virtbase));
@@ -2235,12 +2226,9 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_spi_register;
 	}
 	dev_dbg(dev, "probe succeeded\n");
-	/*
-	 * Disable the silicon block pclk and any voltage domain and just
-	 * power it up and clock it when it's needed
-	 */
-	amba_pclk_disable(adev);
-	amba_vcore_disable(adev);
+
+	/* let runtime pm put suspend */
+	pm_runtime_put(dev);
 	return 0;
 
  err_spi_register:
@@ -2249,7 +2237,6 @@ pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	destroy_queue(pl022);
 	pl022_dma_remove(pl022);
 	free_irq(adev->irq[0], pl022);
-	pm_runtime_disable(&adev->dev);
  err_no_irq:
 	clk_put(pl022->clk);
  err_no_clk:
@@ -2271,6 +2258,12 @@ pl022_remove(struct amba_device *adev)
 	if (!pl022)
 		return 0;
 
+	/*
+	 * undo pm_runtime_put() in probe.  I assume that we're not
+	 * accessing the primecell here.
+	 */
+	pm_runtime_get_noresume(&adev->dev);
+
 	/* Remove the queue */
 	if (destroy_queue(pl022) != 0)
 		dev_err(&adev->dev, "queue remove failed\n");
@@ -2288,10 +2281,10 @@ pl022_remove(struct amba_device *adev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int pl022_suspend(struct amba_device *adev, pm_message_t state)
+#ifdef CONFIG_SUSPEND
+static int pl011_suspend(struct device *dev)
 {
-	struct pl022 *pl022 = amba_get_drvdata(adev);
+	struct pl022 *pl022 = dev_get_drvdata(dev);
 	int status = 0;
 
 	status = stop_queue(pl022);
@@ -2300,34 +2293,58 @@ static int pl022_suspend(struct amba_device *adev, pm_message_t state)
 		return status;
 	}
 
-	amba_vcore_enable(adev);
-	amba_pclk_enable(adev);
+	amba_vcore_enable(pl022->adev);
+	amba_pclk_enable(pl022->adev);
 	load_ssp_default_config(pl022);
-	amba_pclk_disable(adev);
-	amba_vcore_disable(adev);
+	amba_pclk_disable(pl022->adev);
+	amba_vcore_disable(pl022->adev);
 	dev_dbg(&adev->dev, "suspended\n");
 	return 0;
 }
 
-static int pl022_resume(struct amba_device *adev)
+static int pl022_resume(struct device *dev)
 {
-	struct pl022 *pl022 = amba_get_drvdata(adev);
+	struct pl022 *pl022 = dev_get_drvdata(dev);
 	int status = 0;
 
 	/* Start the queue running */
 	status = start_queue(pl022);
 	if (status)
-		dev_err(&adev->dev, "problem starting queue (%d)\n", status);
+		dev_err(dev, "problem starting queue (%d)\n", status);
 	else
-		dev_dbg(&adev->dev, "resumed\n");
+		dev_dbg(dev, "resumed\n");
 
 	return status;
 }
-#else
-#define pl022_suspend NULL
-#define pl022_resume NULL
 #endif	/* CONFIG_PM */
 
+#ifdef CONFIG_PM_RUNTIME
+static int pl022_runtime_suspend(struct device *dev)
+{
+	struct pl022 *pl022 = dev_get_drvdata(dev);
+
+	clk_disable(pl022->clk);
+	amba_vcore_disable(pl022->adev);
+
+	return 0;
+}
+
+static int pl022_runtime_resume(struct device *dev)
+{
+	struct pl022 *pl022 = dev_get_drvdata(dev);
+
+	amba_vcore_enable(pl022->adev);
+	clk_enable(pl022->clk);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops pl022_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pl022_suspend, pl022_resume)
+	SET_RUNTIME_PM_OPS(pl022_runtime_suspend, pl022_runtime_resume, NULL)
+};
+
 static struct vendor_data vendor_arm = {
 	.fifodepth = 8,
 	.max_bpw = 16,
@@ -2407,12 +2424,11 @@ static struct amba_id pl022_ids[] = {
 static struct amba_driver pl022_driver = {
 	.drv = {
 		.name	= "ssp-pl022",
+		.pm	= &pl022_dev_pm_ops,
 	},
 	.id_table	= pl022_ids,
 	.probe		= pl022_probe,
 	.remove		= __devexit_p(pl022_remove),
-	.suspend        = pl022_suspend,
-	.resume         = pl022_resume,
 };
 
 
-- 
1.7.4.4

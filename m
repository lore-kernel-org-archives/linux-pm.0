From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/04] uio: Runtime PM changes for UIO driver
Date: Fri, 31 Jul 2009 23:02:37 +0900
Message-ID: <20090731140237.11351.48881.sendpatchset__6474.06489956683$1249049313$gmane$org@rx1.opensource.se>
References: <20090731140158.11351.26021.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090731140158.11351.26021.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, gregkh@suse.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch modifies the uio_pdrv_genirq driver to support
Runtime PM. The power management implementation simply
runtime resumes the device at open() time and runtime
suspends it at release() time. The user space driver is
responsible for re-initializing the hardware after open().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/uio/uio_pdrv_genirq.c |   54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

--- 0001/drivers/uio/uio_pdrv_genirq.c
+++ work/drivers/uio/uio_pdrv_genirq.c	2009-07-31 00:54:10.000000000 +0900
@@ -20,6 +20,7 @@
 #include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/stringify.h>
+#include <linux/pm_runtime.h>
 
 #define DRIVER_NAME "uio_pdrv_genirq"
 
@@ -27,8 +28,27 @@ struct uio_pdrv_genirq_platdata {
 	struct uio_info *uioinfo;
 	spinlock_t lock;
 	unsigned long flags;
+	struct platform_device *pdev;
 };
 
+static int uio_pdrv_genirq_open(struct uio_info *info, struct inode *inode)
+{
+	struct uio_pdrv_genirq_platdata *priv = info->priv;
+
+	/* Wait until the Runtime PM code has woken up the device */
+	pm_runtime_get_sync(&priv->pdev->dev);
+	return 0;
+}
+
+static int uio_pdrv_genirq_release(struct uio_info *info, struct inode *inode)
+{
+	struct uio_pdrv_genirq_platdata *priv = info->priv;
+
+	/* Tell the Runtime PM code that the device has become idle */
+	pm_runtime_put_sync(&priv->pdev->dev);
+	return 0;
+}
+
 static irqreturn_t uio_pdrv_genirq_handler(int irq, struct uio_info *dev_info)
 {
 	struct uio_pdrv_genirq_platdata *priv = dev_info->priv;
@@ -97,6 +117,7 @@ static int uio_pdrv_genirq_probe(struct 
 	priv->uioinfo = uioinfo;
 	spin_lock_init(&priv->lock);
 	priv->flags = 0; /* interrupt is enabled to begin with */
+	priv->pdev = pdev;
 
 	uiomem = &uioinfo->mem[0];
 
@@ -136,8 +157,17 @@ static int uio_pdrv_genirq_probe(struct 
 	uioinfo->irq_flags |= IRQF_DISABLED;
 	uioinfo->handler = uio_pdrv_genirq_handler;
 	uioinfo->irqcontrol = uio_pdrv_genirq_irqcontrol;
+	uioinfo->open = uio_pdrv_genirq_open;
+	uioinfo->release = uio_pdrv_genirq_release;
 	uioinfo->priv = priv;
 
+	/* Enable Runtime PM for this device:
+	 * Starts in suspended state to allow the hardware to be turned off
+	 * by default. The Runtime PM bus code will power on the hardware and
+	 * enable clocks at open() during the call to pm_runtime_get_sync().
+	 */
+	pm_runtime_enable(&pdev->dev);
+
 	ret = uio_register_device(&pdev->dev, priv->uioinfo);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register uio device\n");
@@ -157,16 +187,40 @@ static int uio_pdrv_genirq_remove(struct
 	struct uio_pdrv_genirq_platdata *priv = platform_get_drvdata(pdev);
 
 	uio_unregister_device(priv->uioinfo);
+	pm_runtime_disable(&pdev->dev);
 	kfree(priv);
 	return 0;
 }
 
+static int uio_pdrv_genirq_runtime_nop(struct device *dev)
+{
+	/* Runtime PM callback shared between ->runtime_suspend()
+	 * and ->runtime_resume(). Simply returns success.
+	 *
+	 * In this driver pm_runtime_get() and pm_runtime_put_sync()
+	 * are used at open() and release() time. This allows the
+	 * Runtime PM code to turn off power to the device while the
+	 * device is unused, ie before open() and after release().
+	 *
+	 * This Runtime PM callback does not need to save or restore
+	 * any registers since user space will reinitialize all the
+	 * hardware registers after open().
+	 */
+	return 0;
+}
+
+static struct dev_pm_ops uio_pdrv_genirq_dev_pm_ops = {
+	.runtime_suspend = uio_pdrv_genirq_runtime_nop,
+	.runtime_resume = uio_pdrv_genirq_runtime_nop,
+};
+
 static struct platform_driver uio_pdrv_genirq = {
 	.probe = uio_pdrv_genirq_probe,
 	.remove = uio_pdrv_genirq_remove,
 	.driver = {
 		.name = DRIVER_NAME,
 		.owner = THIS_MODULE,
+		.pm = &uio_pdrv_genirq_dev_pm_ops,
 	},
 };
 

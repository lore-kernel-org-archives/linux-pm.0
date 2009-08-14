From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 05/05] uio: Runtime PM for UIO devices
Date: Fri, 14 Aug 2009 19:49:38 +0900
Message-ID: <20090814104938.32396.56126.sendpatchset__16191.2148273133$1250247293$gmane$org@rx1.opensource.se>
References: <20090814104808.32396.50021.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090814104808.32396.50021.sendpatchset@rx1.opensource.se>
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

 Tested with the sh7722 VEU hardware block using the
 mplayer sh_veu vidix user space driver.

 Changes since V2:
 - updated comments

 drivers/uio/uio_pdrv_genirq.c |   54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

--- 0001/drivers/uio/uio_pdrv_genirq.c
+++ work/drivers/uio/uio_pdrv_genirq.c	2009-08-14 18:13:32.000000000 +0900
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
+	 * The device starts in suspended state to allow the hardware to be
+	 * turned off by default. The Runtime PM bus code should power on the
+	 * hardware and enable clocks at open().
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
+	 * In this driver pm_runtime_get_sync() and pm_runtime_put_sync()
+	 * are used at open() and release() time. This allows the
+	 * Runtime PM code to turn off power to the device while the
+	 * device is unused, ie before open() and after release().
+	 *
+	 * This Runtime PM callback does not need to save or restore
+	 * any registers since user space is responsbile for hardware
+	 * register reinitialization after open().
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
 

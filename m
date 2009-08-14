From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 04/05] v4l2: Runtime PM for SuperH Mobile CEU
Date: Fri, 14 Aug 2009 19:49:17 +0900
Message-ID: <20090814104917.32396.63200.sendpatchset__7434.88436933166$1250247286$gmane$org@rx1.opensource.se>
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

This patch modifies the SuperH Mobile CEU driver to support
Runtime PM. Driver callbacks for Runtime PM are empty because
the device registers are always re-initialized after
pm_runtime_get_sync(). The Runtime PM functions replaces the
clock framework module stop bit handling in this driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/media/video/sh_mobile_ceu_camera.c |   41 +++++++++++++++++-----------
 1 file changed, 25 insertions(+), 16 deletions(-)

--- 0001/drivers/media/video/sh_mobile_ceu_camera.c
+++ work/drivers/media/video/sh_mobile_ceu_camera.c	2009-08-14 15:04:05.000000000 +0900
@@ -30,7 +30,7 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/videodev2.h>
-#include <linux/clk.h>
+#include <linux/pm_runtime.h>
 
 #include <media/v4l2-common.h>
 #include <media/v4l2-dev.h>
@@ -86,7 +86,6 @@ struct sh_mobile_ceu_dev {
 
 	unsigned int irq;
 	void __iomem *base;
-	struct clk *clk;
 	unsigned long video_limit;
 
 	/* lock used to protect videobuf */
@@ -364,7 +363,7 @@ static int sh_mobile_ceu_add_device(stru
 	if (ret)
 		goto err;
 
-	clk_enable(pcdev->clk);
+	pm_runtime_get_sync(ici->dev);
 
 	ceu_write(pcdev, CAPSR, 1 << 16); /* reset */
 	while (ceu_read(pcdev, CSTSR) & 1)
@@ -398,7 +397,7 @@ static void sh_mobile_ceu_remove_device(
 	}
 	spin_unlock_irqrestore(&pcdev->lock, flags);
 
-	clk_disable(pcdev->clk);
+	pm_runtime_put_sync(ici->dev);
 
 	icd->ops->release(icd);
 
@@ -801,7 +800,6 @@ static int sh_mobile_ceu_probe(struct pl
 	struct sh_mobile_ceu_dev *pcdev;
 	struct resource *res;
 	void __iomem *base;
-	char clk_name[8];
 	unsigned int irq;
 	int err = 0;
 
@@ -865,13 +863,9 @@ static int sh_mobile_ceu_probe(struct pl
 		goto exit_release_mem;
 	}
 
-	snprintf(clk_name, sizeof(clk_name), "ceu%d", pdev->id);
-	pcdev->clk = clk_get(&pdev->dev, clk_name);
-	if (IS_ERR(pcdev->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
-		err = PTR_ERR(pcdev->clk);
-		goto exit_free_irq;
-	}
+	pm_suspend_ignore_children(&pdev->dev, true);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_resume(&pdev->dev);
 
 	pcdev->ici.priv = pcdev;
 	pcdev->ici.dev = &pdev->dev;
@@ -881,12 +875,10 @@ static int sh_mobile_ceu_probe(struct pl
 
 	err = soc_camera_host_register(&pcdev->ici);
 	if (err)
-		goto exit_free_clk;
+		goto exit_free_irq;
 
 	return 0;
 
-exit_free_clk:
-	clk_put(pcdev->clk);
 exit_free_irq:
 	free_irq(pcdev->irq, pcdev);
 exit_release_mem:
@@ -907,7 +899,6 @@ static int sh_mobile_ceu_remove(struct p
 					struct sh_mobile_ceu_dev, ici);
 
 	soc_camera_host_unregister(soc_host);
-	clk_put(pcdev->clk);
 	free_irq(pcdev->irq, pcdev);
 	if (platform_get_resource(pdev, IORESOURCE_MEM, 1))
 		dma_release_declared_memory(&pdev->dev);
@@ -916,9 +907,27 @@ static int sh_mobile_ceu_remove(struct p
 	return 0;
 }
 
+static int sh_mobile_ceu_runtime_nop(struct device *dev)
+{
+	/* Runtime PM callback shared between ->runtime_suspend()
+	 * and ->runtime_resume(). Simply returns success.
+	 *
+	 * This driver re-initializes all registers after
+	 * pm_runtime_get_sync() anyway so there is no need
+	 * to save and restore registers here.
+	 */
+	return 0;
+}
+
+static struct dev_pm_ops sh_mobile_ceu_dev_pm_ops = {
+	.runtime_suspend = sh_mobile_ceu_runtime_nop,
+	.runtime_resume = sh_mobile_ceu_runtime_nop,
+};
+
 static struct platform_driver sh_mobile_ceu_driver = {
 	.driver 	= {
 		.name	= "sh_mobile_ceu",
+		.pm	= &sh_mobile_ceu_dev_pm_ops,
 	},
 	.probe		= sh_mobile_ceu_probe,
 	.remove		= sh_mobile_ceu_remove,

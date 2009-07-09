From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 06/06] video: Runtime PM for sh_mobile_lcdcfb.c
Date: Fri, 10 Jul 2009 00:20:20 +0900
Message-ID: <20090709152020.8385.83457.sendpatchset__18238.2820909426$1247153105$gmane$org@rx1.opensource.se>
References: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090709151926.8385.92800.sendpatchset@rx1.opensource.se>
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

This patch modifies the SuperH Mobile LCDC framebuffer driver
to support Runtime PM. This patch is very experimental and is
missing context save and restore support.

At this early point it is however already possible to see that
the deferred io clock management strategy pays off since in that
mode the clocks are only turned on for a short period of time to
redraw the screen. When the screen is unchanged the clocks are
disabled and the driver can be in Runtime suspended state.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/sh_mobile_lcdcfb.c |   31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2009-07-09 18:24:22.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/fb.h>
 #include <linux/clk.h>
+#include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
@@ -42,9 +43,9 @@ struct sh_mobile_lcdc_chan {
 struct sh_mobile_lcdc_priv {
 	void __iomem *base;
 	int irq;
-	atomic_t clk_usecnt;
+	atomic_t hw_usecnt;
+	struct device *dev;
 	struct clk *dot_clk;
-	struct clk *clk;
 	unsigned long lddckr;
 	struct sh_mobile_lcdc_chan ch[2];
 	int started;
@@ -185,8 +186,8 @@ struct sh_mobile_lcdc_sys_bus_ops sh_mob
 
 static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 {
-	if (atomic_inc_and_test(&priv->clk_usecnt)) {
-		clk_enable(priv->clk);
+	if (atomic_inc_and_test(&priv->hw_usecnt)) {
+		pm_runtime_resume(priv->dev);
 		if (priv->dot_clk)
 			clk_enable(priv->dot_clk);
 	}
@@ -194,10 +195,10 @@ static void sh_mobile_lcdc_clk_on(struct
 
 static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
 {
-	if (atomic_sub_return(1, &priv->clk_usecnt) == -1) {
+	if (atomic_sub_return(1, &priv->hw_usecnt) == -1) {
 		if (priv->dot_clk)
 			clk_disable(priv->dot_clk);
-		clk_disable(priv->clk);
+		pm_schedule_suspend(priv->dev, 0);
 	}
 }
 
@@ -566,7 +567,6 @@ static int sh_mobile_lcdc_setup_clocks(s
 				       int clock_source,
 				       struct sh_mobile_lcdc_priv *priv)
 {
-	char clk_name[8];
 	char *str;
 	int icksel;
 
@@ -580,23 +580,17 @@ static int sh_mobile_lcdc_setup_clocks(s
 
 	priv->lddckr = icksel << 16;
 
-	atomic_set(&priv->clk_usecnt, -1);
-	snprintf(clk_name, sizeof(clk_name), "lcdc%d", pdev->id);
-	priv->clk = clk_get(&pdev->dev, clk_name);
-	if (IS_ERR(priv->clk)) {
-		dev_err(&pdev->dev, "cannot get clock \"%s\"\n", clk_name);
-		return PTR_ERR(priv->clk);
-	}
-
 	if (str) {
 		priv->dot_clk = clk_get(&pdev->dev, str);
 		if (IS_ERR(priv->dot_clk)) {
 			dev_err(&pdev->dev, "cannot get dot clock %s\n", str);
-			clk_put(priv->clk);
 			return PTR_ERR(priv->dot_clk);
 		}
 	}
-
+	atomic_set(&priv->hw_usecnt, -1);
+	pm_suspend_ignore_children(priv->dev, true);
+	pm_runtime_set_suspended(priv->dev);
+	pm_runtime_enable(priv->dev);
 	return 0;
 }
 
@@ -761,6 +755,7 @@ static int __init sh_mobile_lcdc_probe(s
 	}
 
 	priv->irq = i;
+	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 	pdata = pdev->dev.platform_data;
 
@@ -888,7 +883,6 @@ static int __init sh_mobile_lcdc_probe(s
 		if (info->fbdefio)
 			sh_mobile_lcdc_clk_off(priv);
 	}
-
 	return 0;
  err1:
 	sh_mobile_lcdc_remove(pdev);
@@ -924,7 +918,6 @@ static int sh_mobile_lcdc_remove(struct 
 
 	if (priv->dot_clk)
 		clk_put(priv->dot_clk);
-	clk_put(priv->clk);
 
 	if (priv->base)
 		iounmap(priv->base);

From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/05] video: Runtime PM for SuperH Mobile LCDC
Date: Fri, 14 Aug 2009 19:49:08 +0900
Message-ID: <20090814104908.32396.91559.sendpatchset__33357.4482043788$1250247269$gmane$org@rx1.opensource.se>
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

This patch modifies the SuperH Mobile LCDC framebuffer driver
to support Runtime PM. The driver is using the functions

 - pm_runtime_get_sync()
 - pm_runtime_put_sync()

to inform the bus code if the hardware is idle or not. If the
hardware is idle then the bus code may call the runtime dev_pm_ops
callbacks to save and restore state. pm_runtime_resume() is used
to allow the driver to access the hardware from probe().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V2:
 - implemented proper device register save and restore
 - use pm_runtime_resume() to support probe() hardware usage

 Changes since V1:
 - use pm_runtime_get_sync() and pm_runtime_put_sync()
 - use pm_runtime_disable()
 - no need for pm_runtime_set_suspended()
 - incomplete runtime pm functions for dev_pm_ops
 - work around with pm_runtime_put_noidle()/pm_runtime_get_noresume()

 drivers/video/sh_mobile_lcdcfb.c |  154 ++++++++++++++++++++++++++------------
 1 file changed, 109 insertions(+), 45 deletions(-)

--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2009-08-11 19:54:43.000000000 +0900
@@ -14,6 +14,7 @@
 #include <linux/mm.h>
 #include <linux/fb.h>
 #include <linux/clk.h>
+#include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
@@ -23,33 +24,6 @@
 
 #define PALETTE_NR 16
 
-struct sh_mobile_lcdc_priv;
-struct sh_mobile_lcdc_chan {
-	struct sh_mobile_lcdc_priv *lcdc;
-	unsigned long *reg_offs;
-	unsigned long ldmt1r_value;
-	unsigned long enabled; /* ME and SE in LDCNT2R */
-	struct sh_mobile_lcdc_chan_cfg cfg;
-	u32 pseudo_palette[PALETTE_NR];
-	struct fb_info *info;
-	dma_addr_t dma_handle;
-	struct fb_deferred_io defio;
-	struct scatterlist *sglist;
-	unsigned long frame_end;
-	wait_queue_head_t frame_end_wait;
-};
-
-struct sh_mobile_lcdc_priv {
-	void __iomem *base;
-	int irq;
-	atomic_t clk_usecnt;
-	struct clk *dot_clk;
-	struct clk *clk;
-	unsigned long lddckr;
-	struct sh_mobile_lcdc_chan ch[2];
-	int started;
-};
-
 /* shared registers */
 #define _LDDCKR 0x410
 #define _LDDCKSTPR 0x414
@@ -63,11 +37,23 @@ struct sh_mobile_lcdc_priv {
 #define _LDDWAR 0x900
 #define _LDDRAR 0x904
 
+/* shared registers and their order for context save/restore */
+static int lcdc_shared_regs[] = {
+	_LDDCKR,
+	_LDDCKSTPR,
+	_LDINTR,
+	_LDDDSR,
+	_LDCNT1R,
+	_LDCNT2R,
+};
+#define NR_SHARED_REGS ARRAY_SIZE(lcdc_shared_regs)
+
 /* per-channel registers */
 enum { LDDCKPAT1R, LDDCKPAT2R, LDMT1R, LDMT2R, LDMT3R, LDDFR, LDSM1R,
-       LDSM2R, LDSA1R, LDMLSR, LDHCNR, LDHSYNR, LDVLNR, LDVSYNR, LDPMR };
+       LDSM2R, LDSA1R, LDMLSR, LDHCNR, LDHSYNR, LDVLNR, LDVSYNR, LDPMR,
+       NR_CH_REGS };
 
-static unsigned long lcdc_offs_mainlcd[] = {
+static unsigned long lcdc_offs_mainlcd[NR_CH_REGS] = {
 	[LDDCKPAT1R] = 0x400,
 	[LDDCKPAT2R] = 0x404,
 	[LDMT1R] = 0x418,
@@ -85,7 +71,7 @@ static unsigned long lcdc_offs_mainlcd[]
 	[LDPMR] = 0x460,
 };
 
-static unsigned long lcdc_offs_sublcd[] = {
+static unsigned long lcdc_offs_sublcd[NR_CH_REGS] = {
 	[LDDCKPAT1R] = 0x408,
 	[LDDCKPAT2R] = 0x40c,
 	[LDMT1R] = 0x600,
@@ -110,6 +96,35 @@ static unsigned long lcdc_offs_sublcd[] 
 #define LDINTR_FE	0x00000400
 #define LDINTR_FS	0x00000004
 
+struct sh_mobile_lcdc_priv;
+struct sh_mobile_lcdc_chan {
+	struct sh_mobile_lcdc_priv *lcdc;
+	unsigned long *reg_offs;
+	unsigned long ldmt1r_value;
+	unsigned long enabled; /* ME and SE in LDCNT2R */
+	struct sh_mobile_lcdc_chan_cfg cfg;
+	u32 pseudo_palette[PALETTE_NR];
+	unsigned long saved_ch_regs[NR_CH_REGS];
+	struct fb_info *info;
+	dma_addr_t dma_handle;
+	struct fb_deferred_io defio;
+	struct scatterlist *sglist;
+	unsigned long frame_end;
+	wait_queue_head_t frame_end_wait;
+};
+
+struct sh_mobile_lcdc_priv {
+	void __iomem *base;
+	int irq;
+	atomic_t hw_usecnt;
+	struct device *dev;
+	struct clk *dot_clk;
+	unsigned long lddckr;
+	struct sh_mobile_lcdc_chan ch[2];
+	unsigned long saved_shared_regs[NR_SHARED_REGS];
+	int started;
+};
+
 static void lcdc_write_chan(struct sh_mobile_lcdc_chan *chan,
 			    int reg_nr, unsigned long data)
 {
@@ -188,8 +203,8 @@ struct sh_mobile_lcdc_sys_bus_ops sh_mob
 
 static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 {
-	if (atomic_inc_and_test(&priv->clk_usecnt)) {
-		clk_enable(priv->clk);
+	if (atomic_inc_and_test(&priv->hw_usecnt)) {
+		pm_runtime_get_sync(priv->dev);
 		if (priv->dot_clk)
 			clk_enable(priv->dot_clk);
 	}
@@ -197,10 +212,10 @@ static void sh_mobile_lcdc_clk_on(struct
 
 static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
 {
-	if (atomic_sub_return(1, &priv->clk_usecnt) == -1) {
+	if (atomic_sub_return(1, &priv->hw_usecnt) == -1) {
 		if (priv->dot_clk)
 			clk_disable(priv->dot_clk);
-		clk_disable(priv->clk);
+		pm_runtime_put(priv->dev);
 	}
 }
 
@@ -569,7 +584,6 @@ static int sh_mobile_lcdc_setup_clocks(s
 				       int clock_source,
 				       struct sh_mobile_lcdc_priv *priv)
 {
-	char clk_name[8];
 	char *str;
 	int icksel;
 
@@ -583,23 +597,21 @@ static int sh_mobile_lcdc_setup_clocks(s
 
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
+	atomic_set(&priv->hw_usecnt, -1);
 
+	/* Runtime PM support involves two step for this driver:
+	 * 1) Enable Runtime PM
+	 * 2) Force Runtime PM Resume since hardware is accessed from probe()
+	 */
+	pm_runtime_enable(priv->dev);
+	pm_runtime_resume(priv->dev);
 	return 0;
 }
 
@@ -717,9 +729,59 @@ static int sh_mobile_lcdc_resume(struct 
 	return sh_mobile_lcdc_start(platform_get_drvdata(pdev));
 }
 
+static int sh_mobile_lcdc_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_mobile_lcdc_priv *p = platform_get_drvdata(pdev);
+	struct sh_mobile_lcdc_chan *ch;
+	int k, n;
+
+	/* save per-channel registers */
+	for (k = 0; k < ARRAY_SIZE(p->ch); k++) {
+		ch = &p->ch[k];
+		if (!ch->enabled)
+			continue;
+		for (n = 0; n < NR_CH_REGS; n++)
+			ch->saved_ch_regs[n] = lcdc_read_chan(ch, n);
+	}
+
+	/* save shared registers */
+	for (n = 0; n < NR_SHARED_REGS; n++)
+		p->saved_shared_regs[n] = lcdc_read(p, lcdc_shared_regs[n]);
+
+	/* turn off LCDC hardware */
+	lcdc_write(p, _LDCNT1R, 0);
+	return 0;
+}
+
+static int sh_mobile_lcdc_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sh_mobile_lcdc_priv *p = platform_get_drvdata(pdev);
+	struct sh_mobile_lcdc_chan *ch;
+	int k, n;
+
+	/* restore per-channel registers */
+	for (k = 0; k < ARRAY_SIZE(p->ch); k++) {
+		ch = &p->ch[k];
+		if (!ch->enabled)
+			continue;
+		for (n = 0; n < NR_CH_REGS; n++)
+			lcdc_write_chan(ch, n, ch->saved_ch_regs[n]);
+	}
+
+	/* restore shared registers */
+	for (n = 0; n < NR_SHARED_REGS; n++)
+		lcdc_write(p, lcdc_shared_regs[n], p->saved_shared_regs[n]);
+
+	return 0;
+}
+
 static struct dev_pm_ops sh_mobile_lcdc_dev_pm_ops = {
 	.suspend = sh_mobile_lcdc_suspend,
 	.resume = sh_mobile_lcdc_resume,
+	.runtime_suspend = sh_mobile_lcdc_runtime_suspend,
+	.runtime_resume = sh_mobile_lcdc_runtime_resume,
 };
 
 static int sh_mobile_lcdc_remove(struct platform_device *pdev);
@@ -764,6 +826,7 @@ static int __init sh_mobile_lcdc_probe(s
 	}
 
 	priv->irq = i;
+	priv->dev = &pdev->dev;
 	platform_set_drvdata(pdev, priv);
 	pdata = pdev->dev.platform_data;
 
@@ -935,7 +998,8 @@ static int sh_mobile_lcdc_remove(struct 
 
 	if (priv->dot_clk)
 		clk_put(priv->dot_clk);
-	clk_put(priv->clk);
+
+	pm_runtime_disable(priv->dev);
 
 	if (priv->base)
 		iounmap(priv->base);

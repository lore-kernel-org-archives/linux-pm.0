From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/4] thermal: rcar: Add missing clock handling
Date: Tue,  7 Jan 2014 19:57:15 +0100
Message-ID: <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
Sender: linux-sh-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>
List-Id: linux-pm@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

When using DT to instantiate the rcar-thermal device, it prints the
following error:

    rcar_thermal e61f0000.thermal: thermal sensor was broken

Explicitly request and enable the thermal clock to fix this.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 drivers/thermal/rcar_thermal.c |   40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 88f92e1a9944..a5629500723a 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -17,6 +17,7 @@
  *  with this program; if not, write to the Free Software Foundation, Inc.,
  *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
  */
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/irq.h>
@@ -53,6 +54,7 @@ struct rcar_thermal_common {
 	struct device *dev;
 	struct list_head head;
 	spinlock_t lock;
+	struct clk *clk;
 };
 
 struct rcar_thermal_priv {
@@ -378,23 +380,38 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 	spin_lock_init(&common->lock);
 	common->dev = dev;
 
+	common->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(common->clk)) {
+		dev_err(&pdev->dev, "cannot get clock\n");
+		return PTR_ERR(common->clk);
+	}
+
+	ret = clk_prepare(common->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to prepare clock\n");
+		return ret;
+	}
+
+	clk_enable(common->clk);
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
 	if (irq) {
-		int ret;
+		int ret2;
 
 		/*
 		 * platform has IRQ support.
 		 * Then, drier use common register
 		 */
 
-		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
-				       dev_name(dev), common);
-		if (ret) {
+		ret2 = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
+					dev_name(dev), common);
+		if (ret2) {
 			dev_err(dev, "irq request failed\n ");
-			return ret;
+			ret = ret2;
+			goto error_unpm;
 		}
 
 		/*
@@ -402,8 +419,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		 */
 		res = platform_get_resource(pdev, IORESOURCE_MEM, mres++);
 		common->base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(common->base))
-			return PTR_ERR(common->base);
+		if (IS_ERR(common->base)) {
+			ret = PTR_ERR(common->base);
+			goto error_unpm;
+		}
 
 		/* enable temperature comparation */
 		rcar_thermal_common_write(common, ENR, 0x00030303);
@@ -465,9 +484,13 @@ error_unregister:
 			rcar_thermal_irq_disable(priv);
 	}
 
+error_unpm:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
+	clk_disable(common->clk);
+	clk_unprepare(common->clk);
+
 	return ret;
 }
 
@@ -486,6 +509,9 @@ static int rcar_thermal_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
 
+	clk_disable(common->clk);
+	clk_unprepare(common->clk);
+
 	return 0;
 }
 
-- 
1.7.9.5


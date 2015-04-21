From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH/RFC 03/03] irqchip: renesas-irqc: Rely on Runtime PM for wakeup
Date: Wed, 22 Apr 2015 00:01:48 +0900
Message-ID: <20150421150148.14288.86804.sendpatchset@little-apple>
References: <20150421150115.14288.88519.sendpatchset@little-apple>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150421150115.14288.88519.sendpatchset@little-apple>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: jason@lakedaemon.net, geert+renesas@glider.be, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, horms@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Get rid of the clock control code and rely on Runtime PM
for wakeup handling. This more or less reverts the earlier
commit "irqchip: renesas-irqc: Add wake-up support" however
to work ->irq_enable() and ->irq_disable() need to manage
Runtime PM state.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Needs testing before applying.

 drivers/irqchip/irq-renesas-irqc.c |   26 +-------------------------
 1 file changed, 1 insertion(+), 25 deletions(-)

--- 0003/drivers/irqchip/irq-renesas-irqc.c
+++ work/drivers/irqchip/irq-renesas-irqc.c	2015-04-21 23:25:06.106368239 +0900
@@ -17,7 +17,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -67,7 +66,6 @@ struct irqc_priv {
 	struct platform_device *pdev;
 	struct irq_chip irq_chip;
 	struct irq_domain *irq_domain;
-	struct clk *clk;
 };
 
 static void irqc_dbg(struct irqc_irq *i, char *str)
@@ -139,21 +137,6 @@ static int irqc_irq_set_type(struct irq_
 	return 0;
 }
 
-static int irqc_irq_set_wake(struct irq_data *d, unsigned int on)
-{
-	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
-
-	if (!p->clk)
-		return 0;
-
-	if (on)
-		clk_enable(p->clk);
-	else
-		clk_disable(p->clk);
-
-	return 0;
-}
-
 static irqreturn_t irqc_irq_handler(int irq, void *dev_id)
 {
 	struct irqc_irq *i = dev_id;
@@ -216,12 +199,6 @@ static int irqc_probe(struct platform_de
 	p->pdev = pdev;
 	platform_set_drvdata(pdev, p);
 
-	p->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(p->clk)) {
-		dev_warn(&pdev->dev, "unable to get clock\n");
-		p->clk = NULL;
-	}
-
 	pm_runtime_enable(&pdev->dev);
 
 	/* get hold of manadatory IOMEM */
@@ -266,8 +243,7 @@ static int irqc_probe(struct platform_de
 	irq_chip->irq_mask = irqc_irq_mask;
 	irq_chip->irq_unmask = irqc_irq_unmask;
 	irq_chip->irq_set_type = irqc_irq_set_type;
-	irq_chip->irq_set_wake = irqc_irq_set_wake;
-	irq_chip->flags	= IRQCHIP_MASK_ON_SUSPEND;
+	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
 
 	p->irq_domain = irq_domain_add_simple(pdev->dev.of_node,
 					      p->number_of_irqs,

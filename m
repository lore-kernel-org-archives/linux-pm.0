From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] irqchip: renesas-irqc: Add wake-up support
Date: Wed,  1 Apr 2015 14:00:06 +0200
Message-ID: <1427889606-18671-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

The IRQC module clock is managed through Runtime PM and PM Domains.
If wake-up is enabled, this clock must not be disabled during system
suspend.

Hence implement irq_chip.irq_set_wake(), which increments/decrements the
clock's enable_count when needed.

This fixes wake-up by gpio-keys on r8a73a4/ape6evm.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Against irqchip/renesas

 drivers/irqchip/irq-renesas-irqc.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 718f01cd1aea19f6..cdf80b7794cd738e 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -66,6 +67,7 @@ struct irqc_priv {
 	struct platform_device *pdev;
 	struct irq_chip irq_chip;
 	struct irq_domain *irq_domain;
+	struct clk *clk;
 };
 
 static void irqc_dbg(struct irqc_irq *i, char *str)
@@ -119,6 +121,21 @@ static int irqc_irq_set_type(struct irq_data *d, unsigned int type)
 	return 0;
 }
 
+static int irqc_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
+
+	if (!p->clk)
+		return 0;
+
+	if (on)
+		clk_enable(p->clk);
+	else
+		clk_disable(p->clk);
+
+	return 0;
+}
+
 static irqreturn_t irqc_irq_handler(int irq, void *dev_id)
 {
 	struct irqc_irq *i = dev_id;
@@ -181,6 +198,12 @@ static int irqc_probe(struct platform_device *pdev)
 	p->pdev = pdev;
 	platform_set_drvdata(pdev, p);
 
+	p->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(p->clk)) {
+		dev_warn(&pdev->dev, "unable to get clock\n");
+		p->clk = NULL;
+	}
+
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -224,7 +247,8 @@ static int irqc_probe(struct platform_device *pdev)
 	irq_chip->irq_mask = irqc_irq_disable;
 	irq_chip->irq_unmask = irqc_irq_enable;
 	irq_chip->irq_set_type = irqc_irq_set_type;
-	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
+	irq_chip->irq_set_wake = irqc_irq_set_wake;
+	irq_chip->flags	= IRQCHIP_MASK_ON_SUSPEND;
 
 	p->irq_domain = irq_domain_add_simple(pdev->dev.of_node,
 					      p->number_of_irqs,
-- 
1.9.1


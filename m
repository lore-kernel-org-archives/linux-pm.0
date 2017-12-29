From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/3] irqchip/renesas-irqc: Use WAKEUP_PATH driver PM flag
Date: Fri, 29 Dec 2017 14:31:43 +0100
Message-ID: <1514554304-18989-3-git-send-email-ulf.hansson@linaro.org>
References: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Since commit 6f46aedb9c85873b ("irqchip: renesas-irqc: Add wake-up
support"), when an IRQ is used for wakeup, the INTC block's module clock is
manually kept running during system suspend, to make sure the device stays
active.

However, this explicit clock handling is merely a workaround for a failure
to properly communicate wakeup information to the PM core. Instead, set the
WAKEUP_PATH driver PM flag to indicate that the device is part of the
wakeup path, which further also enables middle-layers and PM domains (like
genpd) to act on this.

In case the device is attached to genpd and depending on if it has an
active wakeup configuration, genpd will keep the device active (the clock
running) during system suspend when needed. This enables us to remove all
explicit clock handling code from the driver, so let's do that as well.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Ulf: Converted to use the WAKEUP_PATH driver PM flag]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/irqchip/irq-renesas-irqc.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 52304b1..70d1409 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -17,7 +17,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -64,7 +63,7 @@ struct irqc_priv {
 	struct platform_device *pdev;
 	struct irq_chip_generic *gc;
 	struct irq_domain *irq_domain;
-	struct clk *clk;
+	unsigned wakeup_path:1;
 };
 
 static struct irqc_priv *irq_data_to_priv(struct irq_data *data)
@@ -111,15 +110,7 @@ static int irqc_irq_set_wake(struct irq_data *d, unsigned int on)
 	int hw_irq = irqd_to_hwirq(d);
 
 	irq_set_irq_wake(p->irq[hw_irq].requested_irq, on);
-
-	if (!p->clk)
-		return 0;
-
-	if (on)
-		clk_enable(p->clk);
-	else
-		clk_disable(p->clk);
-
+	p->wakeup_path = on;
 	return 0;
 }
 
@@ -159,12 +150,6 @@ static int irqc_probe(struct platform_device *pdev)
 	p->pdev = pdev;
 	platform_set_drvdata(pdev, p);
 
-	p->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(p->clk)) {
-		dev_warn(&pdev->dev, "unable to get clock\n");
-		p->clk = NULL;
-	}
-
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
@@ -276,6 +261,18 @@ static int irqc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int irqc_suspend(struct device *dev)
+{
+	struct irqc_priv *p = dev_get_drvdata(dev);
+
+	dev_pm_set_driver_flags(dev, p->wakeup_path ? DPM_FLAG_WAKEUP_PATH : 0);
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(irqc_pm_ops, irqc_suspend, NULL);
+
 static const struct of_device_id irqc_dt_ids[] = {
 	{ .compatible = "renesas,irqc", },
 	{},
@@ -288,6 +285,7 @@ static struct platform_driver irqc_device_driver = {
 	.driver		= {
 		.name	= "renesas_irqc",
 		.of_match_table	= irqc_dt_ids,
+		.pm	= &irqc_pm_ops,
 	}
 };
 
-- 
2.7.4

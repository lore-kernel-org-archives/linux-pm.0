From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 2/3] irqchip/renesas-irqc: Use wakeup_path i.s.o. explicit clock handling
Date: Thu,  9 Nov 2017 14:48:32 +0100
Message-ID: <1510235313-32445-3-git-send-email-geert+renesas@glider.be>
References: <1510235313-32445-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510235313-32445-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Since commit 6f46aedb9c85873b ("irqchip: renesas-irqc: Add wake-up
support"), when an IRQ is used for wakeup, the INTC
block's module clock is manually kept running during system suspend, to
make sure the device stays active.

However, this explicit clock handling is merely a workaround for a
failure to properly communicate wakeup information to the device core.

Instead, set the device's power.wakeup_path field, to indicate this
device is part of the wakeup path.  Depending on the PM Domain's
active_wakeup configuration, the genpd core code will keep the device
enabled (and the clock running) during system suspend when needed.
This allows for the removal of all explicit clock handling code from the
driver.

Note that the dev_pm_info.wakeup_path field exists only if
CONFIG_PM_SLEEP is enabled, hence the whole suspend infrastructure is
protected by #ifdef CONFIG_PM_SLEEP.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To avoid regressions, this must not be applied before "soc: renesas:
rcar-sysc: Keep wakeup sources active during system suspend" has landed
upstream, hence the "RFC"!

This driver is used on Renesas R-Mobile, R-Car Gen2/3, and RZ/G1
platforms.  While the pm-rmobile driver already keeps wakeup sources
active during system suspend, this is not the case on R-Car Gen2/3 and
RZ/G1 yet.

v3:
  - New.
---
 drivers/irqchip/irq-renesas-irqc.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 52304b139aa46a60..d91dab43268f9d0a 100644
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
 
@@ -276,6 +261,21 @@ static int irqc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int irqc_suspend(struct device *dev)
+{
+	struct irqc_priv *p = dev_get_drvdata(dev);
+
+	dev->power.wakeup_path = p->wakeup_path;
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(irqc_pm_ops, irqc_suspend, NULL);
+#define DEV_PM_OPS	&irqc_pm_ops
+#else
+#define DEV_PM_OPS	NULL
+#endif
+
 static const struct of_device_id irqc_dt_ids[] = {
 	{ .compatible = "renesas,irqc", },
 	{},
@@ -288,6 +288,7 @@ static struct platform_driver irqc_device_driver = {
 	.driver		= {
 		.name	= "renesas_irqc",
 		.of_match_table	= irqc_dt_ids,
+		.pm	= DEV_PM_OPS,
 	}
 };
 
-- 
2.7.4

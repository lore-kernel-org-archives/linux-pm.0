From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 1/3] irqchip/renesas-intc-irqpin: Use wakeup_path i.s.o. explicit clock handling
Date: Thu,  9 Nov 2017 14:48:31 +0100
Message-ID: <1510235313-32445-2-git-send-email-geert+renesas@glider.be>
References: <1510235313-32445-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510235313-32445-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Since commit 705bc96c2c15313c ("irqchip: renesas-intc-irqpin: Add
minimal runtime PM support"), when an IRQ is used for wakeup, the INTC
block's module clock (if exists) is manually kept running during system
suspend, to make sure the device stays active.

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
This driver is used on Renesas R-Mobile and R-Car Gen1 platforms.

As (1) the pm-rmobile driver already keeps wakeup sources active during
system suspend, and (2) the INTC block on R-Car Gen1 doesn't have a
controllable module clock, this patch should be safe to apply.

v3:
  - New.
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 45 +++++++++++++------------------
 1 file changed, 18 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 06f29cf5018a151f..85ed4c9b9fd5b90f 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -17,7 +17,6 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#include <linux/clk.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -78,16 +77,14 @@ struct intc_irqpin_priv {
 	struct platform_device *pdev;
 	struct irq_chip irq_chip;
 	struct irq_domain *irq_domain;
-	struct clk *clk;
 	unsigned shared_irqs:1;
-	unsigned needs_clk:1;
+	unsigned wakeup_path:1;
 	u8 shared_irq_mask;
 };
 
 struct intc_irqpin_config {
 	unsigned int irlm_bit;
 	unsigned needs_irlm:1;
-	unsigned needs_clk:1;
 };
 
 static unsigned long intc_irqpin_read32(void __iomem *iomem)
@@ -287,15 +284,7 @@ static int intc_irqpin_irq_set_wake(struct irq_data *d, unsigned int on)
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
 
@@ -365,12 +354,10 @@ static const struct irq_domain_ops intc_irqpin_irq_domain_ops = {
 static const struct intc_irqpin_config intc_irqpin_irlm_r8a777x = {
 	.irlm_bit = 23, /* ICR0.IRLM0 */
 	.needs_irlm = 1,
-	.needs_clk = 0,
 };
 
 static const struct intc_irqpin_config intc_irqpin_rmobile = {
 	.needs_irlm = 0,
-	.needs_clk = 1,
 };
 
 static const struct of_device_id intc_irqpin_dt_ids[] = {
@@ -422,18 +409,6 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, p);
 
 	config = of_device_get_match_data(dev);
-	if (config)
-		p->needs_clk = config->needs_clk;
-
-	p->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(p->clk)) {
-		if (p->needs_clk) {
-			dev_err(dev, "unable to get clock\n");
-			ret = PTR_ERR(p->clk);
-			goto err0;
-		}
-		p->clk = NULL;
-	}
 
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
@@ -602,12 +577,28 @@ static int intc_irqpin_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int intc_irqpin_suspend(struct device *dev)
+{
+	struct intc_irqpin_priv *p = dev_get_drvdata(dev);
+
+	dev->power.wakeup_path = p->wakeup_path;
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(intc_irqpin_pm_ops, intc_irqpin_suspend, NULL);
+#define DEV_PM_OPS	&intc_irqpin_pm_ops
+#else
+#define DEV_PM_OPS	NULL
+#endif
+
 static struct platform_driver intc_irqpin_device_driver = {
 	.probe		= intc_irqpin_probe,
 	.remove		= intc_irqpin_remove,
 	.driver		= {
 		.name	= "renesas_intc_irqpin",
 		.of_match_table = intc_irqpin_dt_ids,
+		.pm	= DEV_PM_OPS,
 	}
 };
 
-- 
2.7.4

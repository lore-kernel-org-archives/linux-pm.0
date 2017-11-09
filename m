From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 3/3] gpio: rcar: Use wakeup_path i.s.o. explicit clock handling
Date: Thu,  9 Nov 2017 14:48:33 +0100
Message-ID: <1510235313-32445-4-git-send-email-geert+renesas@glider.be>
References: <1510235313-32445-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510235313-32445-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Since commit ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable
when wake-up is enabled"), when a GPIO is used for wakeup, the GPIO
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
To avoid regressions, this must not be applied before "soc: renesas:
rcar-sysc: Keep wakeup sources active during system suspend" has landed
upstream, hence the "RFC"!

This driver is used on Renesas R-Car and RZ/G1 platforms.
While the GPIO block on R-Car Gen1 doesn't have a controllable module
clock and is thus fine, the rcar-sysc driver doesn't keep wakeup sources
active during system suspend yet on R-Car Gen2 and Gen3, and on RZ/G1.

v3:
  - New.
---
 drivers/gpio/gpio-rcar.c | 43 ++++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 2cf5f458928b2af7..12bf87414213614d 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -14,7 +14,6 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
@@ -37,10 +36,9 @@ struct gpio_rcar_priv {
 	struct platform_device *pdev;
 	struct gpio_chip gpio_chip;
 	struct irq_chip irq_chip;
-	struct clk *clk;
 	unsigned int irq_parent;
 	bool has_both_edge_trigger;
-	bool needs_clk;
+	bool wakeup_path;
 };
 
 #define IOINTSEL 0x00	/* General IO/Interrupt Switching Register */
@@ -186,14 +184,7 @@ static int gpio_rcar_irq_set_wake(struct irq_data *d, unsigned int on)
 		}
 	}
 
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
 
@@ -330,17 +321,14 @@ static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
 
 struct gpio_rcar_info {
 	bool has_both_edge_trigger;
-	bool needs_clk;
 };
 
 static const struct gpio_rcar_info gpio_rcar_info_gen1 = {
 	.has_both_edge_trigger = false,
-	.needs_clk = false,
 };
 
 static const struct gpio_rcar_info gpio_rcar_info_gen2 = {
 	.has_both_edge_trigger = true,
-	.needs_clk = true,
 };
 
 static const struct of_device_id gpio_rcar_of_table[] = {
@@ -403,7 +391,6 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
 	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
 	*npins = ret == 0 ? args.args[2] : RCAR_MAX_GPIO_PER_BANK;
 	p->has_both_edge_trigger = info->has_both_edge_trigger;
-	p->needs_clk = info->needs_clk;
 
 	if (*npins == 0 || *npins > RCAR_MAX_GPIO_PER_BANK) {
 		dev_warn(&p->pdev->dev,
@@ -415,6 +402,21 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int gpio_rcar_suspend(struct device *dev)
+{
+	struct gpio_rcar_priv *p = dev_get_drvdata(dev);
+
+	dev->power.wakeup_path = p->wakeup_path;
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(gpio_rcar_pm_ops, gpio_rcar_suspend, NULL);
+#define DEV_PM_OPS	&gpio_rcar_pm_ops
+#else
+#define DEV_PM_OPS	NULL
+#endif
+
 static int gpio_rcar_probe(struct platform_device *pdev)
 {
 	struct gpio_rcar_priv *p;
@@ -440,16 +442,6 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, p);
 
-	p->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(p->clk)) {
-		if (p->needs_clk) {
-			dev_err(dev, "unable to get clock\n");
-			ret = PTR_ERR(p->clk);
-			goto err0;
-		}
-		p->clk = NULL;
-	}
-
 	pm_runtime_enable(dev);
 
 	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
@@ -536,6 +528,7 @@ static struct platform_driver gpio_rcar_device_driver = {
 	.remove		= gpio_rcar_remove,
 	.driver		= {
 		.name	= "gpio_rcar",
+		.pm     = DEV_PM_OPS,
 		.of_match_table = of_match_ptr(gpio_rcar_of_table),
 	}
 };
-- 
2.7.4

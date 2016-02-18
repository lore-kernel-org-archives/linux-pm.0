From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC v2] gpio: rcar: Add Runtime PM handling for interrupts
Date: Thu, 18 Feb 2016 17:06:30 +0100
Message-ID: <1455811590-15836-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

The R-Car GPIO driver handles Runtime PM for requested GPIOs only.

When using a GPIO purely as an interrupt source, no Runtime PM handling
is done, and the GPIO module's clock may not be enabled.

To fix this:
  - Add .irq_request_resources() and .irq_release_resources() callbacks
    to handle Runtime PM when an interrupt is requested,
  - Add irq_bus_lock() and sync_unlock() callbacks to handle Runtime PM
    when e.g. disabling/enabling an interrupt, or configuring the
    interrupt type.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This fixes ravb Ethernet on r8a7795/Salvator-X, which was "broken" by
commit d5c3d84657db57bd ("net: phy: Avoid polling PHY with
PHY_IGNORE_INTERRUPTS").

Does it also fix the HDMI interrupt on r8a7791/Koelsch?

v2:
  - Handle Runtime PM in .irq_bus_{lock,sync_unlock}() instead of
    .irq_{dis,en}able() and .irq_set_type(),
  - Drop WARN() checks, they were just for testing.
    In case of failures, please re-add

	WARN(pm_runtime_suspended(&p->pdev->dev),
				  "%s: %s is runtime-suspended\n", __func__,
				  dev_name(&p->pdev->dev));

    to gpio_rcar_read() and gpio_rcar_write().
---
 drivers/gpio/gpio-rcar.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index cf41440aff91971e..d9ab0cd1d2059635 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -196,6 +196,44 @@ static int gpio_rcar_irq_set_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
+static void gpio_rcar_irq_bus_lock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
+
+	pm_runtime_get_sync(&p->pdev->dev);
+}
+
+static void gpio_rcar_irq_bus_sync_unlock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
+
+	pm_runtime_put(&p->pdev->dev);
+}
+
+
+static int gpio_rcar_irq_request_resources(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
+	int error;
+
+	error = pm_runtime_get_sync(&p->pdev->dev);
+	if (error < 0)
+		return error;
+
+	return 0;
+}
+
+static void gpio_rcar_irq_release_resources(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct gpio_rcar_priv *p = gpiochip_get_data(gc);
+
+	pm_runtime_put(&p->pdev->dev);
+}
+
 static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
 {
 	struct gpio_rcar_priv *p = dev_id;
@@ -450,6 +488,10 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	irq_chip->irq_unmask = gpio_rcar_irq_enable;
 	irq_chip->irq_set_type = gpio_rcar_irq_set_type;
 	irq_chip->irq_set_wake = gpio_rcar_irq_set_wake;
+	irq_chip->irq_bus_lock = gpio_rcar_irq_bus_lock;
+	irq_chip->irq_bus_sync_unlock = gpio_rcar_irq_bus_sync_unlock;
+	irq_chip->irq_request_resources = gpio_rcar_irq_request_resources;
+	irq_chip->irq_release_resources = gpio_rcar_irq_release_resources;
 	irq_chip->flags	= IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
 
 	ret = gpiochip_add_data(gpio_chip, p);
-- 
1.9.1

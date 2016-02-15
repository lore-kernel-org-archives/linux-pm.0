From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH/RFC] gpio: rcar: Add Runtime PM handling for interrupts
Date: Mon, 15 Feb 2016 23:10:48 +0100
Message-ID: <CACRpkdYPdjFzMW7YfObjmmaLk9=K-DkyJprsz0v0eAg+c-_y=A@mail.gmail.com>
References: <1455031183-18294-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33630 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbcBOWKt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Feb 2016 17:10:49 -0500
Received: by mail-ob0-f173.google.com with SMTP id jq7so46789815obb.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Feb 2016 14:10:48 -0800 (PST)
In-Reply-To: <1455031183-18294-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Feb 9, 2016 at 4:19 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

Quoting in verbatim as we add new recipients.

I don't know about any runtime_pm_get():s from the irqchip functions:
Ulf and others are discussing with Thomas Gleixner about a more general
solution here.

But since it's a regression I guess we need quick decisions.

> The R-Car GPIO driver handles Runtime PM for requested GPIOs only.
>
> When using a GPIO purely as an interrupt source, no Runtime PM handling
> is done, and the GPIO module's clock may not be enabled.
>
> To fix this:
>   - Add .irq_request_resources() and .irq_release_resources() callbacks
>     to handle Runtime PM when an interrupt is requested,

This is pretty OK since they are slowpath.

>   - Runtime-resume the device before writing to the GPIO module's
>     registers for disabling/enabling an interrupt, or for configuring
>     the interrupt type,

Will that have *any* effect now that .irq_request_resources has increased
usecount to 1?

Isn't it enough with the patches to .irq_request/release_resources to get
this working?

>   - Add checks to warn when the GPIO module's registers are accessed
>     while the device is runtime-suspended.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This fixes ravb Ethernet on r8a7795/Salvator-X, which was "broken" by
> commit d5c3d84657db57bd ("net: phy: Avoid polling PHY with
> PHY_IGNORE_INTERRUPTS").
>
> Does it also fix the HDMI interrupt on r8a7791/Koelsch?
>
> Notes:
>   1. I assume gpio_rcar_irq_{dis,en}able() may be called from contexts
>      where pm_runtime_get_sync() may not be called.
>      However, so far I didn't see any reports from the might_sleep_if()
>      check in __pm_runtime_resume(),
>   2. gpio_rcar_irq_disable() is called from the IRQ core before
>      gpio_rcar_irq_set_type().
>      Else an alternative solution could be to just runtime-resume the
>      device from gpio_rcar_irq_set_type() when an interrupt is setup,
>      and never call pm_runtime_put() again. That would cause issues when
>      compiling gpio-rcar as a module, though.
> ---
>  drivers/gpio/gpio-rcar.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index cf41440aff91971e..63b679b3af5d6d16 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -59,12 +59,18 @@ struct gpio_rcar_priv {
>
>  static inline u32 gpio_rcar_read(struct gpio_rcar_priv *p, int offs)
>  {
> +       WARN(pm_runtime_suspended(&p->pdev->dev),
> +                                 "%s: %s is runtime-suspended\n", __func__,
> +                                 dev_name(&p->pdev->dev));
>         return ioread32(p->base + offs);
>  }
>
>  static inline void gpio_rcar_write(struct gpio_rcar_priv *p, int offs,
>                                    u32 value)
>  {
> +       WARN(pm_runtime_suspended(&p->pdev->dev),
> +                                 "%s: %s is runtime-suspended\n", __func__,
> +                                 dev_name(&p->pdev->dev));
>         iowrite32(value, p->base + offs);
>  }
>
> @@ -86,7 +92,11 @@ static void gpio_rcar_irq_disable(struct irq_data *d)
>         struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>         struct gpio_rcar_priv *p = gpiochip_get_data(gc);
>
> +       if (pm_runtime_get_sync(&p->pdev->dev) < 0)
> +               return;
> +
>         gpio_rcar_write(p, INTMSK, ~BIT(irqd_to_hwirq(d)));
> +       pm_runtime_put(&p->pdev->dev);
>  }
>
>  static void gpio_rcar_irq_enable(struct irq_data *d)
> @@ -94,7 +104,11 @@ static void gpio_rcar_irq_enable(struct irq_data *d)
>         struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>         struct gpio_rcar_priv *p = gpiochip_get_data(gc);
>
> +       if (pm_runtime_get_sync(&p->pdev->dev) < 0)
> +               return;
> +
>         gpio_rcar_write(p, MSKCLR, BIT(irqd_to_hwirq(d)));
> +       pm_runtime_put(&p->pdev->dev);
>  }
>
>  static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
> @@ -105,6 +119,9 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
>  {
>         unsigned long flags;
>
> +       if (pm_runtime_get_sync(&p->pdev->dev) < 0)
> +               return;
> +
>         /* follow steps in the GPIO documentation for
>          * "Setting Edge-Sensitive Interrupt Input Mode" and
>          * "Setting Level-Sensitive Interrupt Input Mode"
> @@ -130,6 +147,8 @@ static void gpio_rcar_config_interrupt_input_mode(struct gpio_rcar_priv *p,
>                 gpio_rcar_write(p, INTCLR, BIT(hwirq));
>
>         spin_unlock_irqrestore(&p->lock, flags);
> +
> +       pm_runtime_put(&p->pdev->dev);
>  }
>
>  static int gpio_rcar_irq_set_type(struct irq_data *d, unsigned int type)
> @@ -196,6 +215,27 @@ static int gpio_rcar_irq_set_wake(struct irq_data *d, unsigned int on)
>         return 0;
>  }
>
> +static int gpio_rcar_irq_request_resources(struct irq_data *d)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +       struct gpio_rcar_priv *p = gpiochip_get_data(gc);
> +       int error;
> +
> +       error = pm_runtime_get_sync(&p->pdev->dev);
> +       if (error < 0)
> +               return error;
> +
> +       return 0;
> +}
> +
> +static void gpio_rcar_irq_release_resources(struct irq_data *d)
> +{
> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +       struct gpio_rcar_priv *p = gpiochip_get_data(gc);
> +
> +       pm_runtime_put(&p->pdev->dev);
> +}
> +
>  static irqreturn_t gpio_rcar_irq_handler(int irq, void *dev_id)
>  {
>         struct gpio_rcar_priv *p = dev_id;
> @@ -450,6 +490,8 @@ static int gpio_rcar_probe(struct platform_device *pdev)
>         irq_chip->irq_unmask = gpio_rcar_irq_enable;
>         irq_chip->irq_set_type = gpio_rcar_irq_set_type;
>         irq_chip->irq_set_wake = gpio_rcar_irq_set_wake;
> +       irq_chip->irq_request_resources = gpio_rcar_irq_request_resources;
> +       irq_chip->irq_release_resources = gpio_rcar_irq_release_resources;
>         irq_chip->flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
>
>         ret = gpiochip_add_data(gpio_chip, p);
> --
> 1.9.1
>

Yours,
Linus Walleij

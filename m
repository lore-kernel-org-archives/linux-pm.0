From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] gpio: rcar: Use WAKEUP_PATH driver PM flag
Date: Tue, 2 Jan 2018 11:32:10 +0100
Message-ID: <CAJZ5v0gWtr1bwi7WVeEbTJPu3KC8YfPvfUh5XDmomiK8TFmfyg@mail.gmail.com>
References: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org> <1514554304-18989-4-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34017 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbeABKcL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 05:32:11 -0500
In-Reply-To: <1514554304-18989-4-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-gpio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Dec 29, 2017 at 2:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Since commit ab82fa7da4dce5c7 ("gpio: rcar: Prevent module clock disable
> when wake-up is enabled"), when a GPIO is used for wakeup, the GPIO block's
> module clock (if exists) is manually kept running during system suspend, to
> make sure the device stays active.
>
> However, this explicit clock handling is merely a workaround for a failure
> to properly communicate wakeup information to the PM core. Instead, set the
> WAKEUP_PATH driver PM flag to indicate that the device is part of the
> wakeup path, which further also enables middle-layers and PM domains (like
> genpd) to act on this.
>
> In case the device is attached to genpd and depending on if it has an
> active wakeup configuration, genpd will keep the device active (the clock
> running) during system suspend when needed. This enables us to remove all
> explicit clock handling code from the driver, so let's do that as well.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> [Ulf: Converted to use the WAKEUP_PATH driver PM flag]
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/gpio/gpio-rcar.c | 40 +++++++++++++++-------------------------
>  1 file changed, 15 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index e76de57..d414511 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -14,7 +14,6 @@
>   * GNU General Public License for more details.
>   */
>
> -#include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/gpio.h>
>  #include <linux/init.h>
> @@ -37,10 +36,9 @@ struct gpio_rcar_priv {
>         struct platform_device *pdev;
>         struct gpio_chip gpio_chip;
>         struct irq_chip irq_chip;
> -       struct clk *clk;
>         unsigned int irq_parent;
>         bool has_both_edge_trigger;
> -       bool needs_clk;
> +       bool wakeup_path;
>  };
>
>  #define IOINTSEL 0x00  /* General IO/Interrupt Switching Register */
> @@ -186,14 +184,7 @@ static int gpio_rcar_irq_set_wake(struct irq_data *d, unsigned int on)
>                 }
>         }
>
> -       if (!p->clk)
> -               return 0;
> -
> -       if (on)
> -               clk_enable(p->clk);
> -       else
> -               clk_disable(p->clk);
> -
> +       p->wakeup_path = on;
>         return 0;
>  }
>
> @@ -330,17 +321,14 @@ static int gpio_rcar_direction_output(struct gpio_chip *chip, unsigned offset,
>
>  struct gpio_rcar_info {
>         bool has_both_edge_trigger;
> -       bool needs_clk;
>  };
>
>  static const struct gpio_rcar_info gpio_rcar_info_gen1 = {
>         .has_both_edge_trigger = false,
> -       .needs_clk = false,
>  };
>
>  static const struct gpio_rcar_info gpio_rcar_info_gen2 = {
>         .has_both_edge_trigger = true,
> -       .needs_clk = true,
>  };
>
>  static const struct of_device_id gpio_rcar_of_table[] = {
> @@ -403,7 +391,6 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
>         ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &args);
>         *npins = ret == 0 ? args.args[2] : RCAR_MAX_GPIO_PER_BANK;
>         p->has_both_edge_trigger = info->has_both_edge_trigger;
> -       p->needs_clk = info->needs_clk;
>
>         if (*npins == 0 || *npins > RCAR_MAX_GPIO_PER_BANK) {
>                 dev_warn(&p->pdev->dev,
> @@ -415,6 +402,18 @@ static int gpio_rcar_parse_dt(struct gpio_rcar_priv *p, unsigned int *npins)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int gpio_rcar_suspend(struct device *dev)
> +{
> +       struct gpio_rcar_priv *p = dev_get_drvdata(dev);
> +
> +       dev_pm_set_driver_flags(dev, p->wakeup_path ? DPM_FLAG_WAKEUP_PATH : 0);

Why don't you simply set dev->power.wakeup_path here?

> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(gpio_rcar_pm_ops, gpio_rcar_suspend, NULL);
> +
>  static int gpio_rcar_probe(struct platform_device *pdev)
>  {
>         struct gpio_rcar_priv *p;

Thanks,
Rafael

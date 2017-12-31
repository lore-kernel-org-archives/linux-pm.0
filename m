From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/3] irqchip/renesas-intc-irqpin: Use WAKEUP_PATH
 driver PM flag
Date: Sun, 31 Dec 2017 01:58:49 +0100
Message-ID: <CAJZ5v0iiuJeodMVgV5PhKLr-YBRDfUPoBj86_L88mBu=8zJnbg@mail.gmail.com>
References: <1514554304-18989-1-git-send-email-ulf.hansson@linaro.org> <1514554304-18989-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1514554304-18989-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-gpio@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 29, 2017 at 2:31 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Since commit 705bc96c2c15313c ("irqchip: renesas-intc-irqpin: Add minimal
> runtime PM support"), when an IRQ is used for wakeup, the INTC block's
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
>  drivers/irqchip/irq-renesas-intc-irqpin.c | 42 +++++++++++--------------------
>  1 file changed, 15 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
> index 06f29cf..bfc2c5c 100644
> --- a/drivers/irqchip/irq-renesas-intc-irqpin.c
> +++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
> @@ -17,7 +17,6 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
>
> -#include <linux/clk.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -78,16 +77,14 @@ struct intc_irqpin_priv {
>         struct platform_device *pdev;
>         struct irq_chip irq_chip;
>         struct irq_domain *irq_domain;
> -       struct clk *clk;
>         unsigned shared_irqs:1;
> -       unsigned needs_clk:1;
> +       unsigned wakeup_path:1;
>         u8 shared_irq_mask;
>  };
>
>  struct intc_irqpin_config {
>         unsigned int irlm_bit;
>         unsigned needs_irlm:1;
> -       unsigned needs_clk:1;
>  };
>
>  static unsigned long intc_irqpin_read32(void __iomem *iomem)
> @@ -287,15 +284,7 @@ static int intc_irqpin_irq_set_wake(struct irq_data *d, unsigned int on)
>         int hw_irq = irqd_to_hwirq(d);
>
>         irq_set_irq_wake(p->irq[hw_irq].requested_irq, on);
> -
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
> @@ -365,12 +354,10 @@ static const struct irq_domain_ops intc_irqpin_irq_domain_ops = {
>  static const struct intc_irqpin_config intc_irqpin_irlm_r8a777x = {
>         .irlm_bit = 23, /* ICR0.IRLM0 */
>         .needs_irlm = 1,
> -       .needs_clk = 0,
>  };
>
>  static const struct intc_irqpin_config intc_irqpin_rmobile = {
>         .needs_irlm = 0,
> -       .needs_clk = 1,
>  };
>
>  static const struct of_device_id intc_irqpin_dt_ids[] = {
> @@ -422,18 +409,6 @@ static int intc_irqpin_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, p);
>
>         config = of_device_get_match_data(dev);
> -       if (config)
> -               p->needs_clk = config->needs_clk;
> -
> -       p->clk = devm_clk_get(dev, NULL);
> -       if (IS_ERR(p->clk)) {
> -               if (p->needs_clk) {
> -                       dev_err(dev, "unable to get clock\n");
> -                       ret = PTR_ERR(p->clk);
> -                       goto err0;
> -               }
> -               p->clk = NULL;
> -       }
>
>         pm_runtime_enable(dev);
>         pm_runtime_get_sync(dev);
> @@ -602,12 +577,25 @@ static int intc_irqpin_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static int intc_irqpin_suspend(struct device *dev)
> +{
> +       struct intc_irqpin_priv *p = dev_get_drvdata(dev);
> +
> +       dev_pm_set_driver_flags(dev, p->wakeup_path ? DPM_FLAG_WAKEUP_PATH : 0);

If you want that thing to be a DPM_FLAG_, then please follow the rule
that these flags are only set once at the probe time.

> +       return 0;
> +}
> +#endif

Thanks,
Rafael

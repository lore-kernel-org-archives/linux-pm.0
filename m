From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 5/8] gpio: gpio-wcove: Use first level PMIC GPIO irq
Date: Sat, 3 Jun 2017 16:01:41 +0300
Message-ID: <CAHp75VefidiGD2foON5C7xPM+xpUcBc-UY1BJGnb1ZD9LbCq+g@mail.gmail.com>
References: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170531070225.bymdhhpclidwwtpt@dell> <5490d3e89249bfa9edc219ff83055ab457c8b6ea.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <5490d3e89249bfa9edc219ff83055ab457c8b6ea.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andy@infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 1, 2017 at 1:37 AM,
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> PMIC mfd driver only exports first level irq for GPIO device.
> But currently we are reading the irqs from the second level irq
> chip, So this patch fixes this issue by adding support to use
> first level PMIC GPIO irq.
>

Shouldn't be this squashed to patch 4?

> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpio/gpio-wcove.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> Changes since v1:
>  * used correct mask for GPIO0 and GPIO1 interrupts
>
> Changes since v2:
>  * Rebased on top of latest release.
>  * Removed IRQ0 and IRQ1 mask defines.
>
> Changes since v3:
>  * None
>
> diff --git a/drivers/gpio/gpio-wcove.c b/drivers/gpio/gpio-wcove.c
> index 7b1bc20..bba7704 100644
> --- a/drivers/gpio/gpio-wcove.c
> +++ b/drivers/gpio/gpio-wcove.c
> @@ -401,7 +401,7 @@ static int wcove_gpio_probe(struct platform_device *pdev)
>         if (!wg)
>                 return -ENOMEM;
>
> -       wg->regmap_irq_chip = pmic->irq_chip_data_level2;
> +       wg->regmap_irq_chip = pmic->irq_chip_data;
>
>         platform_set_drvdata(pdev, wg);
>
> @@ -449,6 +449,18 @@ static int wcove_gpio_probe(struct platform_device *pdev)
>
>         gpiochip_set_nested_irqchip(&wg->chip, &wcove_irqchip, virq);
>
> +       /* Enable GPIO0 interrupts */
> +       ret = regmap_update_bits(wg->regmap, IRQ_MASK_BASE, GPIO_IRQ0_MASK,
> +                                0x00);
> +       if (ret)
> +               return ret;
> +
> +       /* Enable GPIO1 interrupts */
> +       ret = regmap_update_bits(wg->regmap, IRQ_MASK_BASE + 1, GPIO_IRQ1_MASK,
> +                                0x00);
> +       if (ret)
> +               return ret;
> +
>         return 0;
>  }
>
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko

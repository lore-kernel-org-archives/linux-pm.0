From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 6/8] mfd: intel_soc_pmic_bxtwc: Utilize devm_*
 functions in driver probe
Date: Sat, 3 Jun 2017 16:03:11 +0300
Message-ID: <CAHp75Ve+t4CvFkbheMk7okwG81znKYHtUgn2goEQ9UFro1t62g@mail.gmail.com>
References: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170531070225.bymdhhpclidwwtpt@dell> <423581e996e0524b4ea4e73f9dfda634d8cf7046.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <423581e996e0524b4ea4e73f9dfda634d8cf7046.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andy@infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 1, 2017 at 1:37 AM,
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> Cleanup the resource allocation/free code in probe function by using
> devm_* calls.

This change is okay.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c | 54 +++++++++++++-------------------------
>  1 file changed, 18 insertions(+), 36 deletions(-)
>
> Changes since v1:
>  * None
>
> Changes since v2:
>  * Rebased on top of latest release.
>
> Changes since v3:
>  * None
>
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index af11c43..feeda6e 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -399,45 +399,44 @@ static int bxtwc_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
> -                                 IRQF_ONESHOT | IRQF_SHARED,
> -                                 0, &bxtwc_regmap_irq_chip,
> -                                 &pmic->irq_chip_data);
> +       ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
> +                                      IRQF_ONESHOT | IRQF_SHARED,
> +                                      0, &bxtwc_regmap_irq_chip,
> +                                      &pmic->irq_chip_data);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to add IRQ chip\n");
>                 return ret;
>         }
>
> -       ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
> -                                 IRQF_ONESHOT | IRQF_SHARED,
> -                                 0, &bxtwc_regmap_irq_chip_level2,
> -                                 &pmic->irq_chip_data_level2);
> +       ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
> +                                      IRQF_ONESHOT | IRQF_SHARED,
> +                                      0, &bxtwc_regmap_irq_chip_level2,
> +                                      &pmic->irq_chip_data_level2);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to add secondary IRQ chip\n");
> -               goto err_irq_chip_level2;
> +               return ret;
>         }
>
> -       ret = regmap_add_irq_chip(pmic->regmap, pmic->irq,
> -                                 IRQF_ONESHOT | IRQF_SHARED,
> -                                 0, &bxtwc_regmap_irq_chip_tmu,
> -                                 &pmic->irq_chip_data_tmu);
> +       ret = devm_regmap_add_irq_chip(&pdev->dev, pmic->regmap, pmic->irq,
> +                                      IRQF_ONESHOT | IRQF_SHARED,
> +                                      0, &bxtwc_regmap_irq_chip_tmu,
> +                                      &pmic->irq_chip_data_tmu);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to add TMU IRQ chip\n");
> -               goto err_irq_chip_tmu;
> +               return ret;
>         }
>
> -       ret = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, bxt_wc_dev,
> -                             ARRAY_SIZE(bxt_wc_dev), NULL, 0,
> -                             NULL);
> +       ret = devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, bxt_wc_dev,
> +                                  ARRAY_SIZE(bxt_wc_dev), NULL, 0, NULL);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to add devices\n");
> -               goto err_mfd;
> +               return ret;
>         }
>
>         ret = sysfs_create_group(&pdev->dev.kobj, &bxtwc_group);
>         if (ret) {
>                 dev_err(&pdev->dev, "Failed to create sysfs group %d\n", ret);
> -               goto err_sysfs;
> +               return ret;
>         }
>
>         /*
> @@ -451,28 +450,11 @@ static int bxtwc_probe(struct platform_device *pdev)
>                                 BXTWC_MIRQLVL1_MCHGR, 0);
>
>         return 0;
> -
> -err_sysfs:
> -       mfd_remove_devices(&pdev->dev);
> -err_mfd:
> -       regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_tmu);
> -err_irq_chip_tmu:
> -       regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_level2);
> -err_irq_chip_level2:
> -       regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
> -
> -       return ret;
>  }
>
>  static int bxtwc_remove(struct platform_device *pdev)
>  {
> -       struct intel_soc_pmic *pmic = dev_get_drvdata(&pdev->dev);
> -
>         sysfs_remove_group(&pdev->dev.kobj, &bxtwc_group);
> -       mfd_remove_devices(&pdev->dev);
> -       regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data);
> -       regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_level2);
> -       regmap_del_irq_chip(pmic->irq, pmic->irq_chip_data_tmu);
>
>         return 0;
>  }
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko

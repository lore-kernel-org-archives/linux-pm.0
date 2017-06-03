From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 3/8] thermal: intel_bxt_pmic_thermal: Use first level
 PMIC thermal irq
Date: Sat, 3 Jun 2017 16:00:52 +0300
Message-ID: <CAHp75Vd5uPmz-0uyPcwYaqyGZhC7caHWj5PbfMJTzSQ6G+1o3w@mail.gmail.com>
References: <cover.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20170531070225.bymdhhpclidwwtpt@dell> <3e58ab749a67cce5c956ef13db8563fb0a8bc190.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <3e58ab749a67cce5c956ef13db8563fb0a8bc190.1496266871.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, "edubezval@gmail.com" <edubezval@gmail.com>, "dvhart@infradead.org" <dvhart@infradead.org>, "Zhang, Rui" <rui.zhang@intel.com>, Lee Jones <lee.jones@linaro.org>, Andy Shevchenko <andy@infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 1, 2017 at 1:37 AM,
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
> PMIC mfd driver only exports first level irq for thermal device.
> But currently we are reading the irqs from the second level irq
> chip, So this patch fixes this issue by adding support to use
> first level PMIC thermal irq.
>

Shouldn't be this squashed to patch 2?

> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/intel_bxt_pmic_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Changes since v1:
>  * None
>
> Changes since v2:
>  * Rebased on top of latest release.
>
> Changes since v3:
>  * Rebased on top of latest release.
>
> diff --git a/drivers/thermal/intel_bxt_pmic_thermal.c b/drivers/thermal/intel_bxt_pmic_thermal.c
> index 0f19a39..ef6b322 100644
> --- a/drivers/thermal/intel_bxt_pmic_thermal.c
> +++ b/drivers/thermal/intel_bxt_pmic_thermal.c
> @@ -241,7 +241,7 @@ static int pmic_thermal_probe(struct platform_device *pdev)
>         }
>
>         regmap = pmic->regmap;
> -       regmap_irq_chip = pmic->irq_chip_data_level2;
> +       regmap_irq_chip = pmic->irq_chip_data;
>
>         pmic_irq_count = 0;
>         while ((irq = platform_get_irq(pdev, pmic_irq_count)) != -ENXIO) {
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko

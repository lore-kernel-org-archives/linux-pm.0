From: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/3] thermal: Add Mediatek thermal controller support
Date: Wed, 23 Sep 2015 21:31:12 +0300
Message-ID: <5602EFF0.8040207@mentor.com>
References: <1443015463-23639-1-git-send-email-s.hauer@pengutronix.de>
 <1443015463-23639-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1443015463-23639-3-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Hi Sascha,

On 23.09.2015 16:37, Sascha Hauer wrote:
> This adds support for the Mediatek thermal controller found on MT8173
> and likely other SoCs.
> The controller is a bit special. It does not have its own ADC, instead
> it controls the on-SoC AUXADC via AHB bus accesses. For this reason
> we need the physical address of the AUXADC. Also it controls a mux
> using AHB bus accesses, so we need the APMIXEDSYS physical address aswell.
> 
> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Reviewed-by: Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/thermal/Kconfig       |   8 +
>  drivers/thermal/Makefile      |   1 +
>  drivers/thermal/mtk_thermal.c | 537 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 546 insertions(+)
>  create mode 100644 drivers/thermal/mtk_thermal.c
> 

[snip]

> +
> +	auxadc = of_parse_phandle(np, "mediatek,auxadc", 0);
> +	if (!auxadc) {
> +		dev_err(&pdev->dev, "missing auxadc node\n");
> +		return -ENODEV;
> +	}
> +
> +	auxadc_phys_base = of_get_phys_base(auxadc);

in case of OF_DYNAMIC enabled of_parse_phandle() requires of_node_put(),
which is fine to place right here.

> +	if (auxadc_phys_base == OF_BAD_ADDR) {
> +		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
> +		return -EINVAL;
> +	}
> +

[snip]

> +
> +	/*
> +	 * These calibration values should finally be provided by the
> +	 * firmware or fuses. For now use default values.
> +	 */
> +	mt->calib_slope = -123;
> +	mt->calib_offset = 465124;
> +
> +	for (i = 0; i < MT8173_NUM_ZONES; i++)
> +		mtk_thermal_init_bank(mt, i, apmixed_phys_base, auxadc_phys_base);
> +
> +	platform_set_drvdata(pdev, mt);
> +
> +	for (i = 0; i < MT8173_NUM_ZONES; i++) {
> +		struct mtk_thermal_bank *bank = &mt->banks[i];
> +
> +		bank->tzd = thermal_zone_of_sensor_register(&pdev->dev, i, bank,
> +				&mtk_thermal_ops);

I would propose to add return value checks here, otherwise there might
be an oops in mtk_thermal_remove(), if something goes wrong.

--
With best wishes,
Vladimir

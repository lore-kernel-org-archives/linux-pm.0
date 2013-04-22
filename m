From: amit kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH 5/6] thermal:exynos4: Enable support for Exynos4412 SoCs
Date: Mon, 22 Apr 2013 11:55:01 +0530
Message-ID: <CADGdYn5LTq7iwuP0Hx=7BpdgQBU=Q7L-3pnSyu8MfQ0v3vVS1A@mail.gmail.com>
References: <1366389493-8239-1-git-send-email-l.majewski@samsung.com>
	<1366389493-8239-6-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1366389493-8239-6-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Zhang Rui <rui.zhang@intel.com>, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi,

I have one suggestion,

On Fri, Apr 19, 2013 at 10:08 PM, Lukasz Majewski
<l.majewski@samsung.com> wrote:
> Enable TMU support for Exynos4412 based target with device tree.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/thermal/exynos_thermal.c |    4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
> index e922fa4..f54066d 100644
> --- a/drivers/thermal/exynos_thermal.c
> +++ b/drivers/thermal/exynos_thermal.c
> @@ -819,6 +819,10 @@ static const struct of_device_id exynos_tmu_match[] = {
>                 .data = (void *)EXYNOS4210_TMU_DRV_DATA,
>         },
>         {
> +               .compatible = "samsung,exynos4412-tmu",
> +               .data = (void *)EXYNOS_TMU_DRV_DATA,
> +       },
Instead of adding a new compatible string, "exynos5250-tmu" name can
be re-used in the 4412 DT node file as 4412 and 5250 TMU controller
are same.

Thanks,
Amit Daniel
> +       {
>                 .compatible = "samsung,exynos5250-tmu",
>                 .data = (void *)EXYNOS_TMU_DRV_DATA,
>         },
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

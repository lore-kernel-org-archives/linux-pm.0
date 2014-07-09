From: amit daniel kachhap <amit.daniel@samsung.com>
Subject: Re: [PATCH] thermal: exynos: fix ordering in exynos_tmu_remove()
Date: Wed, 9 Jul 2014 08:16:33 +0530
Message-ID: <CADGdYn48PPc=kXxny936cShcwKPy2Qs93d7-86ta2GVLJNutJw@mail.gmail.com>
References: <10113119.9fnj2984Hk@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <10113119.9fnj2984Hk@amdc1032>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, Kyungmin Park <kyungmin.park@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 8, 2014 at 6:39 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> It might not be a problem currently but unregister/uninitialize things
> in the reverse order that they are registered/initialized.
>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Changes look fine,
Reviewed-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index d7ca9f4..6243ba0 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -759,10 +759,10 @@ static int exynos_tmu_remove(struct platform_device *pdev)
>  {
>         struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>
> -       exynos_tmu_control(pdev, false);
> -
>         exynos_unregister_thermal(data->reg_conf);
>
> +       exynos_tmu_control(pdev, false);
> +
>         clk_unprepare(data->clk);
>         if (!IS_ERR(data->clk_sec))
>                 clk_unprepare(data->clk_sec);
> --
> 1.8.2.3
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

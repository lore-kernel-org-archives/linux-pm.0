From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] Thermal: exynos: Add clk_{un}prepare APIs
Date: Mon, 22 Apr 2013 23:44:00 +0530
Message-ID: <CAK9yfHxun_x4ae0MTKJo6zgTrHNS855MFEh-1s=qY-0arfJunw@mail.gmail.com>
References: <1366285079-10395-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:51566 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510Ab3DVSOB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Apr 2013 14:14:01 -0400
Received: by mail-ob0-f169.google.com with SMTP id tb18so1542077obb.28
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2013 11:14:00 -0700 (PDT)
In-Reply-To: <1366285079-10395-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rui.zhang@intel.com, eduardo.valentin@ti.com, sachin.kamat@linaro.org, kgene.kim@samsung.com, patches@linaro.org, Amit Daniel Kachhap <amit.daniel@samsung.com>

Hi Eduardo,

Any comments on this series? If possible would like to have this in
3.10 itself as without this TMU support would be broken on exynos
machines due to migration to common clock framework.

On 18 April 2013 17:07, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> clk_{un}prepare APIs are required to migrate to common
> clock framework. While at it convert to use devm_clk_get as
> it removes some cleanup code.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  drivers/thermal/exynos_thermal.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
> index e34d842..9df96e5 100644
> --- a/drivers/thermal/exynos_thermal.c
> +++ b/drivers/thermal/exynos_thermal.c
> @@ -937,12 +937,16 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       data->clk = clk_get(NULL, "tmu_apbif");
> +       data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");
>         if (IS_ERR(data->clk)) {
>                 dev_err(&pdev->dev, "Failed to get clock\n");
>                 return  PTR_ERR(data->clk);
>         }
>
> +       ret = clk_prepare(data->clk);
> +       if (ret)
> +               return ret;
> +
>         if (pdata->type == SOC_ARCH_EXYNOS ||
>                                 pdata->type == SOC_ARCH_EXYNOS4210)
>                 data->soc = pdata->type;
> @@ -994,7 +998,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>         return 0;
>  err_clk:
>         platform_set_drvdata(pdev, NULL);
> -       clk_put(data->clk);
> +       clk_unprepare(data->clk);
>         return ret;
>  }
>
> @@ -1006,7 +1010,7 @@ static int exynos_tmu_remove(struct platform_device *pdev)
>
>         exynos_unregister_thermal();
>
> -       clk_put(data->clk);
> +       clk_unprepare(data->clk);
>
>         platform_set_drvdata(pdev, NULL);
>
> --
> 1.7.9.5
>



-- 
With warm regards,
Sachin

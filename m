From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH 5/5] thermal: exynos: Directly return 0 instead of using
 local ret variable
Date: Thu, 8 Oct 2015 22:17:01 +0530
Message-ID: <CAGOxZ52iP98Dh4tsFmmkOC8CszUYwGmSWf7QXBWWJeyEnnDGYw@mail.gmail.com>
References: <1444282446-6419-1-git-send-email-k.kozlowski@samsung.com> <1444282446-6419-5-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:34483 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933491AbbJHQrl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 12:47:41 -0400
In-Reply-To: <1444282446-6419-5-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello,

On Thu, Oct 8, 2015 at 11:04 AM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> The 'ret' variable in exynos5440_tmu_initialize() is initialized to 0
> and returned as is. Replace it with direct return statement. This also
> fixes coccinelle warning:
> drivers/thermal/samsung/exynos_tmu.c:611:5-8: Unneeded variable: "ret". Return "0" on line 654
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  drivers/thermal/samsung/exynos_tmu.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index 1af7ea8dda71..f340e6edcb49 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -608,7 +608,7 @@ static int exynos5440_tmu_initialize(struct platform_device *pdev)
>  {
>         struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>         unsigned int trim_info = 0, con, rising_threshold;
> -       int ret = 0, threshold_code;
> +       int threshold_code;
>         int crit_temp = 0;
>
>         /*
> @@ -651,7 +651,8 @@ static int exynos5440_tmu_initialize(struct platform_device *pdev)
>         /* Clear the PMIN in the common TMU register */
>         if (!data->id)
>                 writel(0, data->base_second + EXYNOS5440_TMU_PMIN);
> -       return ret;
> +
> +       return 0;
>  }
>
>  static int exynos7_tmu_initialize(struct platform_device *pdev)
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
Alim

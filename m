From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 1/1] thermal: exynos: Use of_match_ptr() macro
Date: Fri, 04 Jan 2013 15:36:58 +0800
Message-ID: <1357285018.2152.5.camel@rzhang1-mobl4>
References: <1355307864-22194-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:13841 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346Ab3ADHhM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jan 2013 02:37:12 -0500
In-Reply-To: <1355307864-22194-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, patches@linaro.org

On Wed, 2012-12-12 at 15:54 +0530, Sachin Kamat wrote:
> This eliminates having an #ifdef returning NULL for the case
> when OF is disabled.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

applied to thermal-next.

thanks,
rui

> ---
>  drivers/thermal/exynos_thermal.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
> index 7772d16..3f6a54a 100644
> --- a/drivers/thermal/exynos_thermal.c
> +++ b/drivers/thermal/exynos_thermal.c
> @@ -800,8 +800,6 @@ static const struct of_device_id exynos_tmu_match[] = {
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, exynos_tmu_match);
> -#else
> -#define  exynos_tmu_match NULL
>  #endif
>  
>  static struct platform_device_id exynos_tmu_driver_ids[] = {
> @@ -982,7 +980,7 @@ static struct platform_driver exynos_tmu_driver = {
>  		.name   = "exynos-tmu",
>  		.owner  = THIS_MODULE,
>  		.pm     = EXYNOS_TMU_PM,
> -		.of_match_table = exynos_tmu_match,
> +		.of_match_table = of_match_ptr(exynos_tmu_match),
>  	},
>  	.probe = exynos_tmu_probe,
>  	.remove	= __devexit_p(exynos_tmu_remove),



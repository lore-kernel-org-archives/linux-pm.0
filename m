From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 1/2] Thermal: exynos: Add clk_{un}prepare APIs
Date: Mon, 22 Apr 2013 14:25:00 -0400
Message-ID: <5175807C.4090005@ti.com>
References: <1366285079-10395-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35386 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522Ab3DVSZU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Apr 2013 14:25:20 -0400
In-Reply-To: <1366285079-10395-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pm@vger.kernel.org, rui.zhang@intel.com, eduardo.valentin@ti.com, kgene.kim@samsung.com, patches@linaro.org, Amit Daniel Kachhap <amit.daniel@samsung.com>

On 18-04-2013 07:37, Sachin Kamat wrote:
> clk_{un}prepare APIs are required to migrate to common
> clock framework. While at it convert to use devm_clk_get as
> it removes some cleanup code.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>   drivers/thermal/exynos_thermal.c |   10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/exynos_thermal.c b/drivers/thermal/exynos_thermal.c
> index e34d842..9df96e5 100644
> --- a/drivers/thermal/exynos_thermal.c
> +++ b/drivers/thermal/exynos_thermal.c
> @@ -937,12 +937,16 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>
> -	data->clk = clk_get(NULL, "tmu_apbif");
> +	data->clk = devm_clk_get(&pdev->dev, "tmu_apbif");

Here you are also changing the sequence from clk_get(NULL, ...) to 
clk_get(&pdev->dev, ...). Is your platform code ready to match to your 
device node?

>   	if (IS_ERR(data->clk)) {
>   		dev_err(&pdev->dev, "Failed to get clock\n");
>   		return  PTR_ERR(data->clk);
>   	}
>
> +	ret = clk_prepare(data->clk);
> +	if (ret)
> +		return ret;
> +
>   	if (pdata->type == SOC_ARCH_EXYNOS ||
>   				pdata->type == SOC_ARCH_EXYNOS4210)
>   		data->soc = pdata->type;
> @@ -994,7 +998,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>   	return 0;
>   err_clk:
>   	platform_set_drvdata(pdev, NULL);
> -	clk_put(data->clk);
> +	clk_unprepare(data->clk);
>   	return ret;
>   }
>
> @@ -1006,7 +1010,7 @@ static int exynos_tmu_remove(struct platform_device *pdev)
>
>   	exynos_unregister_thermal();
>
> -	clk_put(data->clk);
> +	clk_unprepare(data->clk);
>
>   	platform_set_drvdata(pdev, NULL);
>
>


From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v7 2/3] thermal: tegra: fix memory allocation
Date: Mon, 18 Feb 2019 11:24:06 +0100
Message-ID: <e02ad969-129f-1967-57c2-78533e2c7dbe@linaro.org>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <1546510369-28491-3-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546510369-28491-3-git-send-email-wni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Ni <wni@nvidia.com>, edubezval@gmail.com
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/01/2019 11:12, Wei Ni wrote:
> Fix memory allocation to store the pointers to
> thermal_zone_device.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---

Good catch

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


>  drivers/thermal/tegra/soctherm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index f07de8258e93..fd2703c0cfc5 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -1339,7 +1339,7 @@ static int tegra_soctherm_probe(struct platform_device *pdev)
>  	}
>  
>  	tegra->thermctl_tzs = devm_kcalloc(&pdev->dev,
> -					   soc->num_ttgs, sizeof(*z),
> +					   soc->num_ttgs, sizeof(z),
>  					   GFP_KERNEL);
>  	if (!tegra->thermctl_tzs)
>  		return -ENOMEM;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

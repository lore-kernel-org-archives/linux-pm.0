From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v7 1/3] thermal: tegra: remove unnecessary warnings
Date: Mon, 18 Feb 2019 10:47:48 +0100
Message-ID: <ec484530-0a07-b725-a376-43c65ca4a723@linaro.org>
References: <1546510369-28491-1-git-send-email-wni@nvidia.com>
 <1546510369-28491-2-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546510369-28491-2-git-send-email-wni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Ni <wni@nvidia.com>, edubezval@gmail.com
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/01/2019 11:12, Wei Ni wrote:
> Convert warnings to info as not all platforms may
> have all the thresholds and sensors enabled.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

>  drivers/thermal/tegra/soctherm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index ed28110a3535..f07de8258e93 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -569,7 +569,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>  set_throttle:
>  	ret = get_hot_temp(tz, &trip, &temperature);
>  	if (ret) {
> -		dev_warn(dev, "throttrip: %s: missing hot temperature\n",
> +		dev_info(dev, "throttrip: %s: missing hot temperature\n",
>  			 sg->name);
>  		return 0;
>  	}
> @@ -600,7 +600,7 @@ static int tegra_soctherm_set_hwtrips(struct device *dev,
>  	}
>  
>  	if (i == THROTTLE_SIZE)
> -		dev_warn(dev, "throttrip: %s: missing throttle cdev\n",
> +		dev_info(dev, "throttrip: %s: missing throttle cdev\n",
>  			 sg->name);
>  
>  	return 0;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

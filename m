From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 12/12] thermal: qoriq: Add hwmon support
Date: Tue, 16 Apr 2019 19:17:37 +0200
Message-ID: <b0fb8610-25c5-255d-8d4e-7722d37c70d7@linaro.org>
References: <20190413082748.29990-1-andrew.smirnov@gmail.com>
 <20190413082748.29990-13-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190413082748.29990-13-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 13/04/2019 10:27, Andrey Smirnov wrote:
> Expose thermal readings as a HWMON device, so that it could be
> accessed using lm-sensors.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


>  drivers/thermal/qoriq_thermal.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 5c459a9d0db3..897b3424b43b 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -12,6 +12,7 @@
>  #include <linux/thermal.h>
>  
>  #include "thermal_core.h"
> +#include "thermal_hwmon.h"
>  
>  #define SITES_MAX	16
>  
> @@ -93,6 +94,10 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
>  		case -ENODEV:
>  			continue;
>  		case 0:
> +			ret = devm_thermal_add_hwmon_sysfs(tzd);
> +			if (ret)
> +				dev_warn(dev,
> +				     "Failed to add hwmon sysfs attributes\n");
>  			break;
>  		default:
>  			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

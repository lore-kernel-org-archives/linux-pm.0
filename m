From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 13/13] thermal: qoriq: Add hwmon support
Date: Thu, 4 Apr 2019 11:11:56 +0200
Message-ID: <4c6ef4cb-8214-cda6-bfa9-8f0887fc2170@linaro.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-14-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401041418.5999-14-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Expose thermal readings as a HWMON device, so that it could be
> accessed using lm-sensors.
> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> Cc: linux-imx@nxp.com
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/thermal/qoriq_thermal.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 9d227654f879..7fb9321a0d8c 100644
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
> @@ -103,7 +104,10 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
>  		case -ENODEV:
>  			continue;
>  		case 0:
> -			break;
> +			ret = devm_thermal_add_hwmon_sysfs(tzd);
> +			if (!ret)
> +				break;
> +			/* fallthrough */

Do we really want to disable the thermal zone if the hwmon fails to
register ?

>  		default:
>  			regmap_write(qdata->regmap, REGS_TMR, TMR_DISABLE);
>  			return ret;
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

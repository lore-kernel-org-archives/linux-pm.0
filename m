From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 12/13] thermal_hwmon: Add devres wrapper for
 thermal_add_hwmon_sysfs()
Date: Thu, 4 Apr 2019 11:10:25 +0200
Message-ID: <ec9203b2-9f5f-80e2-bcd0-9318083331ef@linaro.org>
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-13-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401041418.5999-13-andrew.smirnov@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>, linux-pm@vger.kernel.org
Cc: Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Angus Ainslie <angus@akkea.ca>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/04/2019 06:14, Andrey Smirnov wrote:
> Add devres wrapper for thermal_add_hwmon_sysfs() to simplify driver
> code.
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

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/thermal/thermal_hwmon.c | 28 ++++++++++++++++++++++++++++
>  drivers/thermal/thermal_hwmon.h |  7 +++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index 40c69a533b24..4e79524182e1 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -244,3 +244,31 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>  	kfree(hwmon);
>  }
>  EXPORT_SYMBOL_GPL(thermal_remove_hwmon_sysfs);
> +
> +static void devm_thermal_hwmon_release(struct device *dev, void *res)
> +{
> +	thermal_remove_hwmon_sysfs(*(struct thermal_zone_device **)res);
> +}
> +
> +int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
> +{
> +	struct thermal_zone_device **ptr;
> +	int ret;
> +
> +	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
> +			   GFP_KERNEL);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	ret = thermal_add_hwmon_sysfs(tz);
> +	if (ret) {
> +		devres_free(ptr);
> +		return ret;
> +	}
> +
> +	*ptr = tz;
> +	devres_add(&tz->device, ptr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_thermal_add_hwmon_sysfs);
> diff --git a/drivers/thermal/thermal_hwmon.h b/drivers/thermal/thermal_hwmon.h
> index a160b9d62dd0..1a9d65f6a6a8 100644
> --- a/drivers/thermal/thermal_hwmon.h
> +++ b/drivers/thermal/thermal_hwmon.h
> @@ -17,6 +17,7 @@
>  
>  #ifdef CONFIG_THERMAL_HWMON
>  int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
> +int devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz);
>  void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz);
>  #else
>  static inline int
> @@ -25,6 +26,12 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>  	return 0;
>  }
>  
> +static inline int
> +devm_thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
> +{
> +	return 0;
> +}
> +
>  static inline void
>  thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>  {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

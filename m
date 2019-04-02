From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 7/7] hwmon/drivers/core: Simplify complex dependency
Date: Tue, 2 Apr 2019 11:23:51 -0700
Message-ID: <20190402182351.GA12622@roeck-us.net>
References: <20190402161256.11044-1-daniel.lezcano@linaro.org>
 <20190402161256.11044-7-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190402161256.11044-7-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 02, 2019 at 06:12:50PM +0200, Daniel Lezcano wrote:
> As the thermal framework does not longer compile as a module, we can
> simplify this condition below:
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
>        (!defined(CONFIG_THERMAL_HWMON) || \
>         !(defined(MODULE) && IS_MODULE(CONFIG_THERMAL)))
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
>        (!defined(CONFIG_THERMAL_HWMON) || \
>         !(defined(MODULE) && 0))
> 
> => (whatever && 0) = 0
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
>        (!defined(CONFIG_THERMAL_HWMON) || !(0))
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
>        (!defined(CONFIG_THERMAL_HWMON) || 1)
> 
> => (whatever || 1) = 1
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
>        (1)
> 
> => (whatever && 1) = whatever
> 
>  if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF)
> 
> CONFIG_THERMAL can not be a module anymore, then:
> 
>  if defined(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF)
> 
> And CONFIG_THERMAL_OF already depends on CONFIG_THERMAL, so:
> 
>  if defined(CONFIG_THERMAL_OF)
> 
> Thus,
> 
>  ifdef CONFIG_THERMAL_OF
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

... assuming this will be pushed with the series. Otherwise please
let me know.

Thanks,
Guenter

> ---
>  drivers/hwmon/hwmon.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> index c22dc1e07911..6f76f2484db0 100644
> --- a/drivers/hwmon/hwmon.c
> +++ b/drivers/hwmon/hwmon.c
> @@ -118,9 +118,7 @@ static DEFINE_IDA(hwmon_ida);
>   * The complex conditional is necessary to avoid a cyclic dependency
>   * between hwmon and thermal_sys modules.
>   */
> -#if IS_REACHABLE(CONFIG_THERMAL) && defined(CONFIG_THERMAL_OF) && \
> -	(!defined(CONFIG_THERMAL_HWMON) || \
> -	 !(defined(MODULE) && IS_MODULE(CONFIG_THERMAL)))
> +#ifdef CONFIG_THERMAL_OF
>  static int hwmon_thermal_get_temp(void *data, int *temp)
>  {
>  	struct hwmon_thermal_data *tdata = data;
> -- 
> 2.17.1
> 

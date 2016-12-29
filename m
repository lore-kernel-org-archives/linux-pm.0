From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RESEND] thermal: hwmon: Properly report critical temperature
 in sysfs
Date: Thu, 29 Dec 2016 19:43:49 +0800
Message-ID: <1483011829.2342.0.camel@intel.com>
References: <20161228173528.4419-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20161228173528.4419-1-krzk@kernel.org>
Sender: stable-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-12-28 at 19:35 +0200, Krzysztof Kozlowski wrote:
> In the critical sysfs entry the thermal hwmon was returning wrong
> temperature to the user-space.  It was reporting the temperature of
> the
> first trip point instead of the temperature of critical trip point.
> 
> For example:
> 	/sys/class/hwmon/hwmon0/temp1_crit:50000
> 	/sys/class/thermal/thermal_zone0/trip_point_0_temp:50000
> 	/sys/class/thermal/thermal_zone0/trip_point_0_type:active
> 	/sys/class/thermal/thermal_zone0/trip_point_3_temp:120000
> 	/sys/class/thermal/thermal_zone0/trip_point_3_type:critical
> 
> Since commit e68b16abd91d ("thermal: add hwmon sysfs I/F") the driver
> have been registering a sysfs entry if get_crit_temp() callback was
> provided.  However when accessed, it was calling get_trip_temp()
> instead
> of the get_crit_temp().
> 
> Fixes: e68b16abd91d ("thermal: add hwmon sysfs I/F")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

The patch is already in upstream kernel.

thanks,
rui
> ---
>  drivers/thermal/thermal_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c
> b/drivers/thermal/thermal_hwmon.c
> index c41c7742903a..2dcd4194d103 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -98,7 +98,7 @@ temp_crit_show(struct device *dev, struct
> device_attribute *attr, char *buf)
>  	int temperature;
>  	int ret;
>  
> -	ret = tz->ops->get_trip_temp(tz, 0, &temperature);
> +	ret = tz->ops->get_crit_temp(tz, &temperature);
>  	if (ret)
>  		return ret;
>  

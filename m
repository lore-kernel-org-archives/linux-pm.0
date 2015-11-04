From: walter harms <wharms@bfs.de>
Subject: Re: [patch] thermal: underflow in trip_point_temp_store()
Date: Wed, 04 Nov 2015 13:26:47 +0100
Message-ID: <5639F987.4070402@bfs.de>
References: <20151103221434.GB19280@mwanda>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20151103221434.GB19280@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



Am 03.11.2015 23:14, schrieb Dan Carpenter:
> This is to address a static checker warning about an underflow in
> imx_set_trip_temp().  The checker is complaining that we have a user
> supplied value for "temp" from kstrtoul() where we treat it as signed,
> we cap the upper but we accept negative values.
> 
> This looks unintentional since the caller is using unsigned longs to
> represent the temperature.  Let's change it to int and reject negatives
> in the caller.
> 
> Also I changed it to reject negative "trip" values as well.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Someday we will use super cooled CPUs and we will need to rethink this
> code.  :)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d9e525c..151a630 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -664,7 +664,7 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>  {
>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
>  	int trip, ret;
> -	unsigned long temperature;
> +	int temperature;
>  
>  	if (!tz->ops->set_trip_temp)
>  		return -EPERM;
> @@ -672,7 +672,9 @@ trip_point_temp_store(struct device *dev, struct device_attribute *attr,
>  	if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
>  		return -EINVAL;
>  
> -	if (kstrtoul(buf, 10, &temperature))
> +	if (kstrtoint(buf, 10, &temperature))
> +		return -EINVAL;
> +	if (trip < 0 || temperature < 0)
>  		return -EINVAL;
>  
>  	ret = tz->ops->set_trip_temp(tz, trip, temperature);


IMHO the test should be near the point where the value is generated.


if (!sscanf(attr->attr.name, "trip_point_%d_temp", &trip))
  		return -EINVAL;
if (trip < 0)
  		return -EINVAL;

if (kstrtoint(buf, 10, &temperature))
		return -EINVAL;

if (temperature < 0)
		return -EINVAL;


That way it is easily visible under what condition -EINVAL is generated (to many).

hope that helps,
re,
 wh


From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 3/4] thermal: Use IS_ENABLED instead of #ifdef
Date: Mon, 06 Jul 2015 12:24:26 +0200
Message-ID: <20150706122426.326f72f4@amdc2363>
References: <1436168777-10463-1-git-send-email-s.hauer@pengutronix.de>
 <1436168777-10463-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51202 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbbGFKYe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jul 2015 06:24:34 -0400
In-reply-to: <1436168777-10463-4-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>

Hi Sascha,

> Use IS_ENABLED(CONFIG_THERMAL_EMULATION) to make the code more
> readable and to get rid of the addtional #ifdef around the variable
> definitions in thermal_zone_get_temp().

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/thermal/thermal_core.c | 45
> ++++++++++++++++++------------------------ 1 file changed, 19
> insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c index aa0a661..67296da 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -477,11 +477,9 @@ static void handle_thermal_trip(struct
> thermal_zone_device *tz, int trip) int thermal_zone_get_temp(struct
> thermal_zone_device *tz, unsigned long *temp) {
>  	int ret = -EINVAL;
> -#ifdef CONFIG_THERMAL_EMULATION
>  	int count;
>  	unsigned long crit_temp = -1UL;
>  	enum thermal_trip_type type;
> -#endif
>  
>  	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
>  		goto exit;
> @@ -489,25 +487,21 @@ int thermal_zone_get_temp(struct
> thermal_zone_device *tz, unsigned long *temp) mutex_lock(&tz->lock);
>  
>  	ret = tz->ops->get_temp(tz, temp);
> -#ifdef CONFIG_THERMAL_EMULATION
> -	if (!tz->emul_temperature)
> -		goto skip_emul;
> -
> -	for (count = 0; count < tz->trips; count++) {
> -		ret = tz->ops->get_trip_type(tz, count, &type);
> -		if (!ret && type == THERMAL_TRIP_CRITICAL) {
> -			ret = tz->ops->get_trip_temp(tz, count,
> &crit_temp);
> -			break;
> -		}
> -	}
>  
> -	if (ret)
> -		goto skip_emul;
> +	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) &&
> tz->emul_temperature) {
> +		for (count = 0; count < tz->trips; count++) {
> +			ret = tz->ops->get_trip_type(tz, count,
> &type);
> +			if (!ret && type == THERMAL_TRIP_CRITICAL) {
> +				ret = tz->ops->get_trip_temp(tz,
> count,
> +						&crit_temp);
> +				break;
> +			}
> +		}
>  
> -	if (*temp < crit_temp)
> -		*temp = tz->emul_temperature;
> -skip_emul:
> -#endif
> +		if (!ret && *temp < crit_temp)
> +			*temp = tz->emul_temperature;
> +	}
> + 
>  	mutex_unlock(&tz->lock);
>  exit:
>  	return ret;
> @@ -847,7 +841,6 @@ policy_show(struct device *dev, struct
> device_attribute *devattr, char *buf) return sprintf(buf, "%s\n",
> tz->governor->name); }
>  
> -#ifdef CONFIG_THERMAL_EMULATION
>  static ssize_t
>  emul_temp_store(struct device *dev, struct device_attribute *attr,
>  		     const char *buf, size_t count)
> @@ -873,7 +866,6 @@ emul_temp_store(struct device *dev, struct
> device_attribute *attr, return ret ? ret : count;
>  }
>  static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
> -#endif/*CONFIG_THERMAL_EMULATION*/
>  
>  static ssize_t
>  sustainable_power_show(struct device *dev, struct device_attribute
> *devattr, @@ -1802,11 +1794,12 @@ struct thermal_zone_device
> *thermal_zone_device_register(const char *type, goto unregister;
>  	}
>  
> -#ifdef CONFIG_THERMAL_EMULATION
> -	result = device_create_file(&tz->device,
> &dev_attr_emul_temp);
> -	if (result)
> -		goto unregister;
> -#endif
> +	if (IS_ENABLED(CONFIG_THERMAL_EMULATION)) {
> +		result = device_create_file(&tz->device,
> &dev_attr_emul_temp);
> +		if (result)
> +			goto unregister;
> +	}
> +
>  	/* Create policy attribute */
>  	result = device_create_file(&tz->device, &dev_attr_policy);
>  	if (result)



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

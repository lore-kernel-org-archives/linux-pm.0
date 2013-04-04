From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCHv2 2/3] thermal: expose thermal_zone_get_temp API
Date: Thu, 4 Apr 2013 17:13:52 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59C650B4@BGSMSX101.gar.corp.intel.com>
References: <1365027197-2793-1-git-send-email-eduardo.valentin@ti.com>
 <1365027197-2793-3-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55339 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763694Ab3DDROC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Apr 2013 13:14:02 -0400
In-Reply-To: <1365027197-2793-3-git-send-email-eduardo.valentin@ti.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> Sent: Thursday, April 04, 2013 3:43 AM
> To: Zhang, Rui
> Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; R, Durgadoss;
> Eduardo Valentin
> Subject: [PATCHv2 2/3] thermal: expose thermal_zone_get_temp API
> 
> This patch exports the thermal_zone_get_temp API so that driver
> writers can fetch temperature of thermal zones managed by other
> drivers.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

Looks fine,
Acked-By: Durgadoss R <durgadoss.r@intel.com>

> ---
>  drivers/thermal/thermal_sys.c |   20 +++++++++++++++++---
>  include/linux/thermal.h       |    1 +
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 6e1da0a..e8afb7f 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -371,16 +371,28 @@ static void handle_thermal_trip(struct
> thermal_zone_device *tz, int trip)
>  	monitor_thermal_zone(tz);
>  }
> 
> -static int thermal_zone_get_temp(struct thermal_zone_device *tz,
> -				unsigned long *temp)
> +/**
> + * thermal_zone_get_temp() - returns its the temperature of thermal zone
> + * @tz: a valid pointer to a struct thermal_zone_device
> + * @temp: a valid pointer to where to store the resulting temperature.
> + *
> + * When a valid thermal zone reference is passed, it will fetch its
> + * temperature and fill @temp.
> + *
> + * Return: On success returns 0, an error code otherwise
> + */
> +int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned
> long *temp)
>  {
> -	int ret = 0;
> +	int ret = -EINVAL;
>  #ifdef CONFIG_THERMAL_EMULATION
>  	int count;
>  	unsigned long crit_temp = -1UL;
>  	enum thermal_trip_type type;
>  #endif
> 
> +	if (IS_ERR_OR_NULL(tz))
> +		goto exit;
> +
>  	mutex_lock(&tz->lock);
> 
>  	ret = tz->ops->get_temp(tz, temp);
> @@ -404,8 +416,10 @@ static int thermal_zone_get_temp(struct
> thermal_zone_device *tz,
>  skip_emul:
>  #endif
>  	mutex_unlock(&tz->lock);
> +exit:
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(thermal_zone_get_temp);
> 
>  static void update_temperature(struct thermal_zone_device *tz)
>  {
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 0cf9eb5..8eea86c 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -238,6 +238,7 @@ struct thermal_cooling_device
> *thermal_cooling_device_register(char *, void *,
>  		const struct thermal_cooling_device_ops *);
>  void thermal_cooling_device_unregister(struct thermal_cooling_device *);
>  struct thermal_zone_device *thermal_zone_get_zone_by_name(const
> char *name);
> +int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned
> long *temp);
> 
>  int thermal_zone_trend_get(struct thermal_zone_device *, int);
>  struct thermal_instance *thermal_instance_get(struct
> thermal_zone_device *,
> --
> 1.7.7.1.488.ge8e1c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: "R, Durgadoss" <durgadoss.r-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] thermal: use device node to get thermal zone
Date: Wed, 8 Jan 2014 11:10:11 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59E09ED1@BGSMSX101.gar.corp.intel.com>
References: <1389172011-32107-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389172011-32107-1-git-send-email-wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "eduardo.valentin-l0cyMroinI0@public.gmane.org" <eduardo.valentin-l0cyMroinI0@public.gmane.org>, "Zhang, Rui" <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: "MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org" <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Wei,

> -----Original Message-----
> From: linux-pm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-pm-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Wei Ni
> Sent: Wednesday, January 08, 2014 2:37 PM
> To: eduardo.valentin-l0cyMroinI0@public.gmane.org; Zhang, Rui; mark.rutland-5wv7dgnIgG8@public.gmane.org
> Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org; swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org; linux-
> pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Wei Ni
> Subject: [PATCH] thermal: use device node to get thermal zone
> 
> If use name to get the thermal zone, sometimes it can't
> get the unique thermal zone, because the thermal fw support
> same name for different thermal zone.
> So we can change to use device node to get thermal zone.

Eduardo introduced this API because we wanted to get the
tzd pointer by using the name. So, for your case, can you
introduce a new API *get_by_node instead of changing this
API ?

Thanks,
Durga

> 
> Signed-off-by: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/thermal/of-thermal.c   |    6 ++++--
>  drivers/thermal/thermal_core.c |   37 ++++++++++++++++---------------------
>  include/linux/thermal.h        |    4 +++-
>  3 files changed, 23 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 04b1be7..97c12cf 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -330,7 +330,7 @@ thermal_zone_of_add_sensor(struct device_node *zone,
>  	struct thermal_zone_device *tzd;
>  	struct __thermal_zone *tz;
> 
> -	tzd = thermal_zone_get_zone_by_name(zone->name);
> +	tzd = thermal_zone_get_zone_by_node(zone);
>  	if (IS_ERR(tzd))
>  		return ERR_PTR(-EPROBE_DEFER);
> 
> @@ -804,6 +804,8 @@ int __init of_parse_thermal_zones(void)
>  			of_thermal_free_zone(tz);
>  			/* attempting to build remaining zones still */
>  		}
> +
> +		zone->np = child;
>  	}
> 
>  	return 0;
> @@ -837,7 +839,7 @@ void of_thermal_destroy_zones(void)
>  	for_each_child_of_node(np, child) {
>  		struct thermal_zone_device *zone;
> 
> -		zone = thermal_zone_get_zone_by_name(child->name);
> +		zone = thermal_zone_get_zone_by_node(child);
>  		if (IS_ERR(zone))
>  			continue;
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 338a88b..89e0637 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1635,42 +1635,37 @@ void thermal_zone_device_unregister(struct
> thermal_zone_device *tz)
>  EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
> 
>  /**
> - * thermal_zone_get_zone_by_name() - search for a zone and returns its ref
> - * @name: thermal zone name to fetch the temperature
> + * thermal_zone_get_zone_by_node() - search for a zone and returns its ref
> + * @node: device node of the thermal zone
>   *
> - * When only one zone is found with the passed name, returns a reference to it.
> + * When thermal zone is found with the passed device node, returns a
> reference
> + * to it.
>   *
>   * Return: On success returns a reference to an unique thermal zone with
> - * matching name equals to @name, an ERR_PTR otherwise (-EINVAL for invalid
> - * paramenters, -ENODEV for not found and -EEXIST for multiple matches).
> + * matching device node, an ERR_PTR otherwise (-EINVAL for invalid
> + * paramenters, -ENODEV for not found).
>   */
> -struct thermal_zone_device *thermal_zone_get_zone_by_name(const char
> *name)
> +struct thermal_zone_device *
> +thermal_zone_get_zone_by_node(struct device_node *node)
>  {
> -	struct thermal_zone_device *pos = NULL, *ref = ERR_PTR(-EINVAL);
> -	unsigned int found = 0;
> +	struct thermal_zone_device *pos = NULL, *ref = ERR_PTR(-ENODEV);
> +	bool found = false;
> 
> -	if (!name)
> -		goto exit;
> +	if (!node)
> +		return ERR_PTR(-EINVAL);
> 
>  	mutex_lock(&thermal_list_lock);
>  	list_for_each_entry(pos, &thermal_tz_list, node)
> -		if (!strnicmp(name, pos->type, THERMAL_NAME_LENGTH)) {
> -			found++;
> +		if (node == pos->np) {
>  			ref = pos;
> +			found = true;
> +			break;
>  		}
>  	mutex_unlock(&thermal_list_lock);
> 
> -	/* nothing has been found, thus an error code for it */
> -	if (found == 0)
> -		ref = ERR_PTR(-ENODEV);
> -	else if (found > 1)
> -	/* Success only when an unique zone is found */
> -		ref = ERR_PTR(-EEXIST);
> -
> -exit:
>  	return ref;
>  }
> -EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_name);
> +EXPORT_SYMBOL_GPL(thermal_zone_get_zone_by_node);
> 
>  #ifdef CONFIG_NET
>  static const struct genl_multicast_group thermal_event_mcgrps[] = {
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f7e11c7..a94de8c 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -162,6 +162,7 @@ struct thermal_zone_device {
>  	int id;
>  	char type[THERMAL_NAME_LENGTH];
>  	struct device device;
> +	struct device_node *np;
>  	struct thermal_attr *trip_temp_attrs;
>  	struct thermal_attr *trip_type_attrs;
>  	struct thermal_attr *trip_hyst_attrs;
> @@ -285,7 +286,8 @@ struct thermal_cooling_device *
>  thermal_of_cooling_device_register(struct device_node *np, char *, void *,
>  				   const struct thermal_cooling_device_ops *);
>  void thermal_cooling_device_unregister(struct thermal_cooling_device *);
> -struct thermal_zone_device *thermal_zone_get_zone_by_name(const char
> *name);
> +struct thermal_zone_device *
> +thermal_zone_get_zone_by_node(struct device_node *node);
>  int thermal_zone_get_temp(struct thermal_zone_device *tz, unsigned long
> *temp);
> 
>  int get_tz_trend(struct thermal_zone_device *, int);
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Keerthy <a0393675@ti.com>
Subject: Re: [PATCHv3 04/48] thermal: core: use dev.groups to manage always
 present tz attributes
Date: Tue, 31 May 2016 10:43:40 +0530
Message-ID: <574D1D84.7080407@ti.com>
References: <1464646584-14322-1-git-send-email-edubezval@gmail.com>
 <1464646584-14322-5-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56172 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbcEaFNv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 01:13:51 -0400
In-Reply-To: <1464646584-14322-5-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>



On Tuesday 31 May 2016 03:45 AM, Eduardo Valentin wrote:
> Thermal zones attributes are all being created using
> device_create_file(). This has the disadvantage of making the code
> complicated and sometimes we may miss the cleanup of them.
>
> This patch starts to move the thermal zone sysfs attributes to the
> dev.groups, so Linux device core manage them for us. For now, this patch
> only moves those attributes are always present regardless of thermal
> zone condition.
>
> This change has also the advantage of cleaning up the thermal zone
> parameters sysfs entries that are left unclean after device
> registration.

I bisected. This is the commit which seems to break boot when thermal 
modules are built in kernel.

>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> ---
>   drivers/thermal/thermal_core.c | 86 ++++++++++++++++--------------------------
>   1 file changed, 33 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 3ce7882..926442e 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -989,42 +989,46 @@ create_s32_tzp_attr(slope);
>   create_s32_tzp_attr(offset);
>   #undef create_s32_tzp_attr
>
> +/*
> + * These are thermal zone device attributes that will always be present.
> + * All the attributes created for tzp (create_s32_tzp_attr) also are always
> + * present on the sysfs interface.
> + */
>   static DEVICE_ATTR(type, 0444, type_show, NULL);
>   static DEVICE_ATTR(temp, 0444, temp_show, NULL);
> -static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
> -static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
>   static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
>   static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
> -static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
>   static DEVICE_ATTR(sustainable_power, S_IWUSR | S_IRUGO, sustainable_power_show,
>   		   sustainable_power_store);
>
> -static struct device_attribute *dev_tzp_attrs[] = {
> -	&dev_attr_sustainable_power,
> -	&dev_attr_k_po,
> -	&dev_attr_k_pu,
> -	&dev_attr_k_i,
> -	&dev_attr_k_d,
> -	&dev_attr_integral_cutoff,
> -	&dev_attr_slope,
> -	&dev_attr_offset,
> -};
> -
> -static int create_tzp_attrs(struct device *dev)
> -{
> -	int i;
> +/* These thermal zone device attributes are created based on conditions */
> +static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
> +static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
> +static DEVICE_ATTR(emul_temp, S_IWUSR, NULL, emul_temp_store);
>
> -	for (i = 0; i < ARRAY_SIZE(dev_tzp_attrs); i++) {
> -		int ret;
> -		struct device_attribute *dev_attr = dev_tzp_attrs[i];
> +static struct attribute *thermal_zone_dev_attrs[] = {
> +	&dev_attr_type.attr,
> +	&dev_attr_temp.attr,
> +	&dev_attr_policy.attr,
> +	&dev_attr_available_policies.attr,
> +	&dev_attr_sustainable_power.attr,
> +	&dev_attr_k_po.attr,
> +	&dev_attr_k_pu.attr,
> +	&dev_attr_k_i.attr,
> +	&dev_attr_k_d.attr,
> +	&dev_attr_integral_cutoff.attr,
> +	&dev_attr_slope.attr,
> +	&dev_attr_offset.attr,
> +};
>
> -		ret = device_create_file(dev, dev_attr);
> -		if (ret)
> -			return ret;
> -	}
> +static struct attribute_group thermal_zone_attribute_group = {
> +	.attrs = thermal_zone_dev_attrs,
> +};
>
> -	return 0;
> -}
> +static const struct attribute_group *thermal_zone_attribute_groups[] = {
> +	&thermal_zone_attribute_group,
> +	NULL
> +};
>
>   /**
>    * power_actor_get_max_power() - get the maximum power that a cdev can consume
> @@ -1846,6 +1850,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>   	tz->trips = trips;
>   	tz->passive_delay = passive_delay;
>   	tz->polling_delay = polling_delay;
> +
> +	/* Add nodes that are always present via .groups */
> +	tz->device.groups = thermal_zone_attribute_groups;
>   	/* A new thermal zone needs to be updated anyway. */
>   	atomic_set(&tz->need_update, 1);
>
> @@ -1892,29 +1899,6 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>   			goto unregister;
>   	}
>
> -	result = device_create_file(&tz->device, &dev_attr_type);
> -	if (result)
> -		goto unregister;
> -
> -	result = device_create_file(&tz->device, &dev_attr_temp);
> -	if (result)
> -		goto unregister;
> -
> -	/* Create policy attribute */
> -	result = device_create_file(&tz->device, &dev_attr_policy);
> -	if (result)
> -		goto unregister;
> -
> -	/* Create available_policies attribute */
> -	result = device_create_file(&tz->device, &dev_attr_available_policies);
> -	if (result)
> -		goto unregister;
> -
> -	/* Add thermal zone params */
> -	result = create_tzp_attrs(&tz->device);
> -	if (result)
> -		goto unregister;
> -
>   	/* Update 'this' zone's governor information */
>   	mutex_lock(&thermal_governor_lock);
>
> @@ -2009,12 +1993,8 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>
>   	thermal_zone_device_set_polling(tz, 0);
>
> -	device_remove_file(&tz->device, &dev_attr_type);
> -	device_remove_file(&tz->device, &dev_attr_temp);
>   	if (tz->ops->get_mode)
>   		device_remove_file(&tz->device, &dev_attr_mode);
> -	device_remove_file(&tz->device, &dev_attr_policy);
> -	device_remove_file(&tz->device, &dev_attr_available_policies);
>   	remove_trip_attrs(tz);
>   	thermal_set_governor(tz, NULL);
>
>

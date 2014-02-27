From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v4 1/2] thermal: add available policies attribute
Date: Thu, 27 Feb 2014 15:06:10 +0800
Message-ID: <1393484770.2637.18.camel@rzhang1-mobl4>
References: <1390211732-5853-1-git-send-email-wni@nvidia.com>
	 <1390211732-5853-2-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:63365 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbaB0HGP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Feb 2014 02:06:15 -0500
In-Reply-To: <1390211732-5853-2-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: eduardo.valentin@ti.com, durgadoss.r@intel.com, MLongnecker@nvidia.com, linux-pm@vger.kernel.org

On Mon, 2014-01-20 at 17:55 +0800, Wei Ni wrote:
> The Linux thermal framework support to change thermal governor
> policy in userspace, but it can't show what available policies
> supported.
> 
> This patch adds available_policies attribute to the thermal
> framework, it can list the thermal governors which can be
> used for a particular zone. This attribute is read only.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>

applied.

thanks,
rui
> ---
>  Documentation/thermal/sysfs-api.txt |    6 ++++++
>  drivers/thermal/thermal_core.c      |   28 ++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index 87519cb..8459d45 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -172,6 +172,7 @@ Thermal zone device sys I/F, created once it's registered:
>      |---temp:			Current temperature
>      |---mode:			Working mode of the thermal zone
>      |---policy:			Thermal governor used for this zone
> +    |---available_policies	Available thermal governors for this zone
>      |---trip_point_[0-*]_temp:	Trip point temperature
>      |---trip_point_[0-*]_type:	Trip point type
>      |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
> @@ -238,6 +239,10 @@ policy
>  	One of the various thermal governors used for a particular zone.
>  	RW, Required
>  
> +available_policies
> +	Available thermal governors which can be used for a particular zone.
> +	RO, Required
> +
>  trip_point_[0-*]_temp
>  	The temperature above which trip point will be fired.
>  	Unit: millidegree Celsius
> @@ -330,6 +335,7 @@ method, the sys I/F structure will be built like this:
>      |---temp:			37000
>      |---mode:			enabled
>      |---policy:			step_wise
> +    |---available_policies:	step_wise fair_share
>      |---trip_point_0_temp:	100000
>      |---trip_point_0_type:	critical
>      |---trip_point_1_temp:	80000
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 338a88b..a91684b 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -761,6 +761,27 @@ policy_show(struct device *dev, struct device_attribute *devattr, char *buf)
>  	return sprintf(buf, "%s\n", tz->governor->name);
>  }
>  
> +static ssize_t
> +available_policies_show(struct device *dev, struct device_attribute *devattr,
> +			char *buf)
> +{
> +	struct thermal_governor *pos;
> +	ssize_t count = 0;
> +	ssize_t size = 0;
> +
> +	mutex_lock(&thermal_governor_lock);
> +
> +	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
> +		size = PAGE_SIZE - count;
> +		count += scnprintf(buf + count, size, "%s ", pos->name);
> +	}
> +	count += scnprintf(buf + count, size, "\n");
> +
> +	mutex_unlock(&thermal_governor_lock);
> +
> +	return count;
> +}
> +
>  #ifdef CONFIG_THERMAL_EMULATION
>  static ssize_t
>  emul_temp_store(struct device *dev, struct device_attribute *attr,
> @@ -794,6 +815,7 @@ static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
>  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive_store);
>  static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_store);
> +static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_show, NULL);
>  
>  /* sys I/F for cooling device */
>  #define to_cooling_device(_dev)	\
> @@ -1527,6 +1549,11 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  	if (result)
>  		goto unregister;
>  
> +	/* Create available_policies attribute */
> +	result = device_create_file(&tz->device, &dev_attr_available_policies);
> +	if (result)
> +		goto unregister;
> +
>  	/* Update 'this' zone's governor information */
>  	mutex_lock(&thermal_governor_lock);
>  
> @@ -1622,6 +1649,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  	if (tz->ops->get_mode)
>  		device_remove_file(&tz->device, &dev_attr_mode);
>  	device_remove_file(&tz->device, &dev_attr_policy);
> +	device_remove_file(&tz->device, &dev_attr_available_policies);
>  	remove_trip_attrs(tz);
>  	tz->governor = NULL;
>  



From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH] thermal: provide a way for the governors to have private
 data for each thermal zone
Date: Fri, 28 Mar 2014 16:32:05 +0800
Message-ID: <53353385.2030806@nvidia.com>
References: <1394638735-31540-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15819 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752307AbaC1IcI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Mar 2014 04:32:08 -0400
In-Reply-To: <1394638735-31540-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Punit.Agrawal@arm.com" <Punit.Agrawal@arm.com>

On 03/12/2014 11:38 PM, Javi Merino wrote:
> A governor may need to store its current state between calls to
> throttle().  That state depends on the thermal zone, so store it as
> private data in struct thermal_zone_device.
> 
> The governors may have two new ops: bind_to_tz() and unbind_from_tz().
> When provided, these functions allow a governor to do some
> initialization when it is bound to a tz and possibly store that
> information in the governor_data field of the struct
> thermal_zone_device.
> 
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> 
> ---
> Hi,
> 
> We are working[1] on a new governor that has a Proportional Integral
> Derivative (PID) controller in it so we need a way to store its
> current state.  We're sending this as an RFC as there isn't any user
> for this in the kernel yet.  Our plan is to include it as part of the
> series of the governor.  This is an RFC to gather comments and see if
> this is a valid solution to the problem.
> 
> [1] http://article.gmane.org/gmane.linux.power-management.general/43243
> 
>  drivers/thermal/thermal_core.c |   49 +++++++++++++++++++++++++++++++++-------
>  include/linux/thermal.h        |    3 +++
>  2 files changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 71b0ec0..d937083 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -72,6 +72,27 @@ static struct thermal_governor *__find_governor(const char *name)
>  	return NULL;
>  }
>  
> +static int thermal_set_governor(struct thermal_zone_device *tz,
> +				struct thermal_governor *gov)

In the of-thermal framework, we can't set the governor_name in the DT,
so it mean we only can use the default governor in the initialization.
I think we can export this function, so the platform driver can use it
to change the governor to what he want.
Such as:
static int thermal_set_governor(struct thermal_zone_device *tz,
				const char *name)
I think it's better to pass the "name", not the pointer of "gov".

> +{
> +	int ret = 0;
> +
> +	if (tz->governor && tz->governor->unbind_from_tz)
> +		tz->governor->unbind_from_tz(tz);
> +
> +	if (gov && gov->bind_to_tz) {
> +		ret = gov->bind_to_tz(tz);
> +		if (ret) {
> +			tz->governor = NULL;
> +			return ret;
> +		}
> +	}
> +
> +	tz->governor = gov;
> +
> +	return ret;
> +}
> +
>  int thermal_register_governor(struct thermal_governor *governor)
>  {
>  	int err;
> @@ -104,8 +125,12 @@ int thermal_register_governor(struct thermal_governor *governor)
>  
>  		name = pos->tzp->governor_name;
>  
> -		if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH))
> -			pos->governor = governor;
> +		if (!strnicmp(name, governor->name, THERMAL_NAME_LENGTH)) {
> +			int ret = thermal_set_governor(pos, governor);
> +			if (ret)
> +				pr_warn("Failed to set governor %s for zone %d: %d\n",
> +					governor->name, pos->id, ret);
> +		}
>  	}
>  
>  	mutex_unlock(&thermal_list_lock);
> @@ -131,7 +156,7 @@ void thermal_unregister_governor(struct thermal_governor *governor)
>  	list_for_each_entry(pos, &thermal_tz_list, node) {
>  		if (!strnicmp(pos->governor->name, governor->name,
>  						THERMAL_NAME_LENGTH))
> -			pos->governor = NULL;
> +			thermal_set_governor(pos, NULL);
>  	}
>  
>  	mutex_unlock(&thermal_list_lock);
> @@ -756,8 +781,9 @@ policy_store(struct device *dev, struct device_attribute *attr,
>  	if (!gov)
>  		goto exit;
>  
> -	tz->governor = gov;
> -	ret = count;
> +	ret = thermal_set_governor(tz, gov);
> +	if (!ret)
> +		ret = count;
>  
>  exit:
>  	mutex_unlock(&thermal_governor_lock);
> @@ -1452,6 +1478,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  	int result;
>  	int count;
>  	int passive = 0;
> +	struct thermal_governor *governor;
>  
>  	if (type && strlen(type) >= THERMAL_NAME_LENGTH)
>  		return ERR_PTR(-EINVAL);
> @@ -1542,9 +1569,15 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  	mutex_lock(&thermal_governor_lock);
>  
>  	if (tz->tzp)
> -		tz->governor = __find_governor(tz->tzp->governor_name);
> +		governor = __find_governor(tz->tzp->governor_name);
>  	else
> -		tz->governor = def_governor;
> +		governor = def_governor;
> +
> +	result = thermal_set_governor(tz, governor);
> +	if (result) {
> +		mutex_unlock(&thermal_governor_lock);
> +		goto unregister;
> +	}
>  
>  	mutex_unlock(&thermal_governor_lock);
>  
> @@ -1634,7 +1667,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  		device_remove_file(&tz->device, &dev_attr_mode);
>  	device_remove_file(&tz->device, &dev_attr_policy);
>  	remove_trip_attrs(tz);
> -	tz->governor = NULL;
> +	thermal_set_governor(tz, NULL);
>  
>  	thermal_remove_hwmon_sysfs(tz);
>  	release_idr(&thermal_tz_idr, &thermal_idr_lock, tz->id);
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f7e11c7..baac212 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -177,6 +177,7 @@ struct thermal_zone_device {
>  	struct thermal_zone_device_ops *ops;
>  	const struct thermal_zone_params *tzp;
>  	struct thermal_governor *governor;
> +	void *governor_data;
>  	struct list_head thermal_instances;
>  	struct idr idr;
>  	struct mutex lock; /* protect thermal_instances list */
> @@ -187,6 +188,8 @@ struct thermal_zone_device {
>  /* Structure that holds thermal governor information */
>  struct thermal_governor {
>  	char name[THERMAL_NAME_LENGTH];
> +	int (*bind_to_tz)(struct thermal_zone_device *tz);
> +	void (*unbind_from_tz)(struct thermal_zone_device *tz);
>  	int (*throttle)(struct thermal_zone_device *tz, int trip);
>  	struct list_head	governor_list;
>  };
> 


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

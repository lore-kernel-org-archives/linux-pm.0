From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v4 2/2] thermal: add interface to support tune governor
 in run-time
Date: Mon, 20 Jan 2014 17:58:24 +0800
Message-ID: <52DCF340.6050406@nvidia.com>
References: <1390211732-5853-1-git-send-email-wni@nvidia.com>
 <1390211732-5853-3-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4037 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbaATJ61 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jan 2014 04:58:27 -0500
In-Reply-To: <1390211732-5853-3-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "rui.zhang@intel.com" <rui.zhang@intel.com>
Cc: "durgadoss.r@intel.com" <durgadoss.r@intel.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Wei Ni <wni@nvidia.com>

On 01/20/2014 05:55 PM, Wei Ni wrote:
> In the of-thermal driver, it register a thermal zone device
> without governor, since the governers are not static, we
> should be able to update to a new one in run-time, so I add
> a new fucntion thermal_update_governor() to do it.
> 
> Change-Id: Ie4995d6404d6d4f16250958487f3e3b8f63fc4c6

Oh, I need to remove change id.

> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  Documentation/thermal/sysfs-api.txt |    4 ++++
>  drivers/thermal/thermal_core.c      |   38 ++++++++++++++++++++++++++++-------
>  include/linux/thermal.h             |    1 +
>  3 files changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/thermal/sysfs-api.txt
> index 8459d45..bcd50b5 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -405,3 +405,7 @@ platform data is provided, this uses the step_wise throttling policy.
>  This function serves as an arbitrator to set the state of a cooling
>  device. It sets the cooling device to the deepest cooling state if
>  possible.
> +
> +5.5:thermal_update_governor:
> +This function update the thermal zone's governor to a new one.
> +Returns 0 if success, an erro code otherwise.
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index a91684b..ef0fc40 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -130,6 +130,35 @@ exit:
>  	return;
>  }
>  
> +/**
> + * thermal_update_governor() - update the thermal zone device's governor
> + * to a new one.
> + * @tzd: pointer of thermal zone device, which need to update governor.
> + * @name: new governor name.
> + *
> + * Return: On success returns 0, an error code otherwise
> + */
> +int thermal_update_governor(struct thermal_zone_device *tzd,
> +			    const char *name)
> +{
> +	struct thermal_governor *new_gov;
> +	int ret = 0;
> +
> +	mutex_lock(&thermal_governor_lock);
> +
> +	new_gov = __find_governor(name);
> +	if (!new_gov) {
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	tzd->governor = new_gov;
> +
> +exit:
> +	mutex_unlock(&thermal_governor_lock);
> +	return ret;
> +}
> +
>  static int get_idr(struct idr *idr, struct mutex *lock, int *id)
>  {
>  	int ret;
> @@ -734,22 +763,17 @@ policy_store(struct device *dev, struct device_attribute *attr,
>  {
>  	int ret = -EINVAL;
>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
> -	struct thermal_governor *gov;
>  	char name[THERMAL_NAME_LENGTH];
>  
>  	snprintf(name, sizeof(name), "%s", buf);
>  
> -	mutex_lock(&thermal_governor_lock);
> -
> -	gov = __find_governor(strim(name));
> -	if (!gov)
> +	ret = thermal_update_governor(tz, strim(name));
> +	if (ret < 0)
>  		goto exit;
>  
> -	tz->governor = gov;
>  	ret = count;
>  
>  exit:
> -	mutex_unlock(&thermal_governor_lock);
>  	return ret;
>  }
>  
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f7e11c7..715b3cd 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -293,6 +293,7 @@ struct thermal_instance *get_thermal_instance(struct thermal_zone_device *,
>  		struct thermal_cooling_device *, int);
>  void thermal_cdev_update(struct thermal_cooling_device *);
>  void thermal_notify_framework(struct thermal_zone_device *, int);
> +int thermal_update_governor(struct thermal_zone_device *, const char *);
>  
>  #ifdef CONFIG_NET
>  extern int thermal_generate_netlink_event(struct thermal_zone_device *tz,
> 


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

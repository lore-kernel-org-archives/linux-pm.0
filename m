From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Revert "thermal: thermal_hwmon: Convert to
 hwmon_device_register_with_info()"
Date: Mon, 23 Jan 2017 09:10:36 -0800
Message-ID: <20170123171036.GB23924@roeck-us.net>
References: <1485184438-26016-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50761 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbdAWRKl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Jan 2017 12:10:41 -0500
Content-Disposition: inline
In-Reply-To: <1485184438-26016-1-git-send-email-festevam@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: rui.zhang@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

On Mon, Jan 23, 2017 at 01:13:58PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> This reverts commit 7611fb68062f8d7f416f3272894d1edf7bbff29c.
> 
> Pavel Machek reported breakage in the Nokia N900 due to this commit.
> 
> We can revisit a proper fix for the warning later.
> 
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/thermal/thermal_hwmon.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index c4a508a..541af59 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -59,6 +59,14 @@ static LIST_HEAD(thermal_hwmon_list);
>  static DEFINE_MUTEX(thermal_hwmon_list_lock);
>  
>  static ssize_t
> +name_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
> +	return sprintf(buf, "%s\n", hwmon->type);
> +}
> +static DEVICE_ATTR_RO(name);
> +
> +static ssize_t
>  temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	int temperature;
> @@ -157,12 +165,15 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>  
>  	INIT_LIST_HEAD(&hwmon->tz_list);
>  	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
> -	hwmon->device = hwmon_device_register_with_info(NULL, hwmon->type,
> -							hwmon, NULL, NULL);
> +	hwmon->device = hwmon_device_register(NULL);
>  	if (IS_ERR(hwmon->device)) {
>  		result = PTR_ERR(hwmon->device);
>  		goto free_mem;
>  	}
> +	dev_set_drvdata(hwmon->device, hwmon);
> +	result = device_create_file(hwmon->device, &dev_attr_name);
> +	if (result)
> +		goto free_mem;
>  
>   register_sys_interface:
>  	temp = kzalloc(sizeof(*temp), GFP_KERNEL);
> @@ -211,8 +222,10 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>   free_temp_mem:
>  	kfree(temp);
>   unregister_name:
> -	if (new_hwmon_device)
> +	if (new_hwmon_device) {
> +		device_remove_file(hwmon->device, &dev_attr_name);
>  		hwmon_device_unregister(hwmon->device);
> +	}
>   free_mem:
>  	if (new_hwmon_device)
>  		kfree(hwmon);
> @@ -254,6 +267,7 @@ void thermal_remove_hwmon_sysfs(struct thermal_zone_device *tz)
>  	list_del(&hwmon->node);
>  	mutex_unlock(&thermal_hwmon_list_lock);
>  
> +	device_remove_file(hwmon->device, &dev_attr_name);
>  	hwmon_device_unregister(hwmon->device);
>  	kfree(hwmon);
>  }
> -- 
> 2.7.4
> 

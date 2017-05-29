From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Fixed hwmon_register_device() error regression
Date: Mon, 29 May 2017 21:17:21 +0800
Message-ID: <1496063841.2572.3.camel@intel.com>
References: <20170529023858.GA1713@localhost.highwinds.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7814 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdE2NR0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 29 May 2017 09:17:26 -0400
In-Reply-To: <20170529023858.GA1713@localhost.highwinds.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Benson <handle2001@gmail.com>, edubezval@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Josh

On Sun, 2017-05-28 at 22:38 -0400, Josh Benson wrote:
> Signed-off-by: Josh Benson <handle2001@gmail.com>

First of all, you're missing a proper changelog here.
Second, this patch has already been reverted by commit
3feb479cea37 because the name of some thermal devices contains special
characters which is incompatible with hwmon.

thanks,
rui
> ---
>  drivers/thermal/thermal_hwmon.c | 20 +++-----------------
>  1 file changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c
> b/drivers/thermal/thermal_hwmon.c
> index 541af5946203..c4a508a124dc 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -59,14 +59,6 @@ static LIST_HEAD(thermal_hwmon_list);
>  static DEFINE_MUTEX(thermal_hwmon_list_lock);
>  
>  static ssize_t
> -name_show(struct device *dev, struct device_attribute *attr, char
> *buf)
> -{
> -	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
> -	return sprintf(buf, "%s\n", hwmon->type);
> -}
> -static DEVICE_ATTR_RO(name);
> -
> -static ssize_t
>  temp_input_show(struct device *dev, struct device_attribute *attr,
> char *buf)
>  {
>  	int temperature;
> @@ -165,15 +157,12 @@ int thermal_add_hwmon_sysfs(struct
> thermal_zone_device *tz)
>  
>  	INIT_LIST_HEAD(&hwmon->tz_list);
>  	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
> -	hwmon->device = hwmon_device_register(NULL);
> +	hwmon->device = hwmon_device_register_with_info(NULL, hwmon-
> >type,
> +							hwmon, NULL,
> NULL);
>  	if (IS_ERR(hwmon->device)) {
>  		result = PTR_ERR(hwmon->device);
>  		goto free_mem;
>  	}
> -	dev_set_drvdata(hwmon->device, hwmon);
> -	result = device_create_file(hwmon->device, &dev_attr_name);
> -	if (result)
> -		goto free_mem;
>  
>   register_sys_interface:
>  	temp = kzalloc(sizeof(*temp), GFP_KERNEL);
> @@ -222,10 +211,8 @@ int thermal_add_hwmon_sysfs(struct
> thermal_zone_device *tz)
>   free_temp_mem:
>  	kfree(temp);
>   unregister_name:
> -	if (new_hwmon_device) {
> -		device_remove_file(hwmon->device, &dev_attr_name);
> +	if (new_hwmon_device)
>  		hwmon_device_unregister(hwmon->device);
> -	}
>   free_mem:
>  	if (new_hwmon_device)
>  		kfree(hwmon);
> @@ -267,7 +254,6 @@ void thermal_remove_hwmon_sysfs(struct
> thermal_zone_device *tz)
>  	list_del(&hwmon->node);
>  	mutex_unlock(&thermal_hwmon_list_lock);
>  
> -	device_remove_file(hwmon->device, &dev_attr_name);
>  	hwmon_device_unregister(hwmon->device);
>  	kfree(hwmon);
>  }

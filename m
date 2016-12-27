From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] thermal: thermal_hwmon: Convert to
 hwmon_device_register_with_info()
Date: Tue, 27 Dec 2016 09:01:03 -0800
Message-ID: <20161227170103.GA3091@roeck-us.net>
References: <1482855852-26188-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41117 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933027AbcL0RBG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Dec 2016 12:01:06 -0500
Content-Disposition: inline
In-Reply-To: <1482855852-26188-1-git-send-email-festevam@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

Hi Fabio,

On Tue, Dec 27, 2016 at 02:24:12PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Booting Linux on a mx6q based board leads to the following warning:
> 
> (NULL device *): hwmon_device_register() is deprecated. Please convert the
> driver to use hwmon_device_register_with_info().
> 
> ,so do as suggested.
> 
> Also, this results in the core taking care of creating the 'name'
> attribute, so drop the code doing that from the thermal driver.
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> Changes since RFC:
> - Properly use hwmon_device_register_with_info()
> - Remove device_create_file() from the thermal driver as the hwmon core
> will take care of it
> 
>  drivers/thermal/thermal_hwmon.c | 19 +++----------------
>  1 file changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index 541af59..39d8a90 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -59,14 +59,6 @@ static LIST_HEAD(thermal_hwmon_list);
>  static DEFINE_MUTEX(thermal_hwmon_list_lock);
>  
>  static ssize_t
> -name_show(struct device *dev, struct device_attribute *attr, char *buf)
> -{
> -	struct thermal_hwmon_device *hwmon = dev_get_drvdata(dev);
> -	return sprintf(buf, "%s\n", hwmon->type);
> -}
> -static DEVICE_ATTR_RO(name);
> -
> -static ssize_t
>  temp_input_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	int temperature;
> @@ -165,15 +157,13 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>  
>  	INIT_LIST_HEAD(&hwmon->tz_list);
>  	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
> -	hwmon->device = hwmon_device_register(NULL);
> +	hwmon->device = hwmon_device_register_with_info(NULL, hwmon->type,
> +							hwmon, NULL, NULL);
>  	if (IS_ERR(hwmon->device)) {
>  		result = PTR_ERR(hwmon->device);
>  		goto free_mem;
>  	}
>  	dev_set_drvdata(hwmon->device, hwmon);

You can drop this as well; it is done by the core.

Thanks,
Guenter

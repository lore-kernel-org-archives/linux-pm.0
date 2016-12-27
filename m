From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC] thermal: thermal_hwmon: Convert to
 hwmon_device_register_with_info()
Date: Tue, 27 Dec 2016 07:24:18 -0800
Message-ID: <a48feeaa-c2b4-c8b1-bb18-915bf84e64de@roeck-us.net>
References: <1482843640-25255-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52955 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753057AbcL0PYU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Dec 2016 10:24:20 -0500
In-Reply-To: <1482843640-25255-1-git-send-email-festevam@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

On 12/27/2016 05:00 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> Booting Linux on a mx6q based board leads to the following warning:
>
> (NULL device *): hwmon_device_register() is deprecated. Please convert the
> driver to use hwmon_device_register_with_info().
>
> ,so do as suggested.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  drivers/thermal/thermal_hwmon.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
> index 541af59..22397dd 100644
> --- a/drivers/thermal/thermal_hwmon.c
> +++ b/drivers/thermal/thermal_hwmon.c
> @@ -165,7 +165,8 @@ int thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
>
>  	INIT_LIST_HEAD(&hwmon->tz_list);
>  	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
> -	hwmon->device = hwmon_device_register(NULL);
> +	hwmon->device = hwmon_device_register_with_info(NULL, NULL, NULL,
> +							NULL, NULL);

Interesting way of defeating the purpose ;-).

Any interest in at least trying (NULL, hwmon->type, hwmon, NULL, NULL) ?

This should result in the core taking care of creating the 'name'
attribute, so it should be possible to drop the code doing that from
the thermal driver.

Guenter

>  	if (IS_ERR(hwmon->device)) {
>  		result = PTR_ERR(hwmon->device);
>  		goto free_mem;
>


From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] Fix multiple definition error under lto
Date: Mon, 12 Dec 2016 11:45:06 +0800
Message-ID: <1481514306.2325.1.camel@intel.com>
References: <20161126222528.15261-1-pefoley2@pefoley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:20847 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751680AbcLLDpK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 11 Dec 2016 22:45:10 -0500
In-Reply-To: <20161126222528.15261-1-pefoley2@pefoley.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Foley <pefoley2@pefoley.com>, linux-kernel@vger.kernel.org, edubezval@gmail.com, linux-pm@vger.kernel.org

On Sat, 2016-11-26 at 17:25 -0500, Peter Foley wrote:
> drivers/thermal/built-in.o: In function `type_show.lto_priv.33':
> (.text+0x3d80): multiple definition of `type_show.lto_priv.33'
> drivers/base/built-in.o:(.text+0x2a40): first defined here
> 
can you illustrate how to reproduce this problem?

thanks,
rui
> Signed-off-by: Peter Foley <pefoley2@pefoley.com>
> ---
>  drivers/thermal/thermal_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c
> index 226b0b4aced6..23ec1dd2ff3b 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -643,7 +643,7 @@ static void thermal_zone_device_check(struct
> work_struct *work)
>  	container_of(_dev, struct thermal_zone_device, device)
>  
>  static ssize_t
> -type_show(struct device *dev, struct device_attribute *attr, char
> *buf)
> +thermal_type_show(struct device *dev, struct device_attribute *attr,
> char *buf)
>  {
>  	struct thermal_zone_device *tz = to_thermal_zone(dev);
>  
> @@ -1159,7 +1159,7 @@ int power_actor_set_power(struct
> thermal_cooling_device *cdev,
>  	return 0;
>  }
>  
> -static DEVICE_ATTR(type, 0444, type_show, NULL);
> +static DEVICE_ATTR(type, 0444, thermal_type_show, NULL);
>  static DEVICE_ATTR(temp, 0444, temp_show, NULL);
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
>  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show,
> passive_store);

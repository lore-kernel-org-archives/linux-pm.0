From: Caesar Wang <sasukewxt@163.com>
Subject: Re: [PATCH 1/3] thermal: handle get_temp() errors properly
Date: Sat, 19 Nov 2016 11:21:39 +0800
Message-ID: <b798233b-7525-3264-247c-5d9c6374d105@163.com>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from m50-138.163.com ([123.125.50.138]:33247 "EHLO m50-138.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752223AbcKSDYL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Nov 2016 22:24:11 -0500
In-Reply-To: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Barber <smbarber@chromium.org>, linux-rockchip@lists.infradead.org, Caesar Wang <wxt@rock-chips.com>

Brian,
在 2016年11月19日 07:52, Brian Norris 写道:
> If using CONFIG_THERMAL_EMULATION, there's a corner case where we might
> get an error from the zone's get_temp() callback, but we'll ignore that
> and keep using its value. Let's just error out properly instead.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
Tested-by: Caesar Wang <wxt@rock-chips.com>

[    8.111296] thermal thermal_zone4: power_allocator: sustainable_power 
will be estimated
[    8.119420] thermal_zone_get_temp:537 the ret=-19, no such device, 
look like the A/D value had no ready yet.
..
Anyway, this patch is useful for improving thermal.

-Caesar
> ---
>   drivers/thermal/thermal_core.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 911fd964c742..0fa497f10d25 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -494,6 +494,8 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>   	mutex_lock(&tz->lock);
>   
>   	ret = tz->ops->get_temp(tz, temp);
> +	if (ret)
> +		goto exit_unlock;
>   
>   	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {
>   		for (count = 0; count < tz->trips; count++) {
> @@ -514,6 +516,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>   			*temp = tz->emul_temperature;
>   	}
>    
> +exit_unlock:
>   	mutex_unlock(&tz->lock);
>   exit:
>   	return ret;



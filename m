From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/3] thermal: handle get_temp() errors properly
Date: Fri, 18 Nov 2016 19:41:59 -0800
Message-ID: <20161119034158.GA26405@localhost.localdomain>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33503 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752234AbcKSDmD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Nov 2016 22:42:03 -0500
Content-Disposition: inline
In-Reply-To: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Caesar Wang <wxt@rock-chips.com>, Stephen Barber <smbarber@chromium.org>

On Fri, Nov 18, 2016 at 03:52:55PM -0800, Brian Norris wrote:
> If using CONFIG_THERMAL_EMULATION, there's a corner case where we might
> get an error from the zone's get_temp() callback, but we'll ignore that
> and keep using its value. Let's just error out properly instead.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>  drivers/thermal/thermal_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 911fd964c742..0fa497f10d25 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -494,6 +494,8 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>  	mutex_lock(&tz->lock);
>  
>  	ret = tz->ops->get_temp(tz, temp);
> +	if (ret)
> +		goto exit_unlock;

Yeah, but the follow through is intentional, if I am not mistaken.


>  
>  	if (IS_ENABLED(CONFIG_THERMAL_EMULATION) && tz->emul_temperature) {

Even if the driver is not able to read real temperature, but emul temp
is configured, then there is still opportunity to report the emulated
temperature.

>  		for (count = 0; count < tz->trips; count++) {
> @@ -514,6 +516,7 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
>  			*temp = tz->emul_temperature;

And if you check the lines at the bottom of the loop, you will see that,
in the fail case, we will stil compare to what is the content of temp,
which might be problematic.

I would prefer we consider the patch I sent
some time ago:
https://patchwork.kernel.org/patch/7876381/

>  	}
>   
> +exit_unlock:
>  	mutex_unlock(&tz->lock);
>  exit:
>  	return ret;
> -- 
> 2.8.0.rc3.226.g39d4020
> 

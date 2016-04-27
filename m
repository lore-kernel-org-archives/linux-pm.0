From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 4/4] thermal: bang-bang governor: act on lower trip
 boundary
Date: Wed, 27 Apr 2016 14:54:26 -0700
Message-ID: <20160427215425.GD6438@localhost.localdomain>
References: <1461553367-24744-1-git-send-email-wxt@rock-chips.com>
 <1461553367-24744-5-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32962 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249AbcD0Vya (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Apr 2016 17:54:30 -0400
Content-Disposition: inline
In-Reply-To: <1461553367-24744-5-git-send-email-wxt@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, briannorris@google.com, smbarber@google.com, linux-rockchip@lists.infradead.org, dmitry.torokhov@gmail.com, huangtao@rock-chips.com, eddie.cai@rock-chips.com, Sascha Hauer <s.hauer@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Apr 25, 2016 at 11:02:47AM +0800, Caesar Wang wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> With interrupt driven thermal zones we pass the lower and upper
> temperature on which shall be acted, so in the governor we have to act on
> the exact lower temperature to be consistent. Otherwise an interrupt maybe
> generated on the exact lower temperature, but the bang bang governor does
> not react.

What is the expected impact on polling driven zones that use bang bang
after this change?

> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: linux-pm@vger.kernel.org
> 
> ---
> 
>  drivers/thermal/gov_bang_bang.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/gov_bang_bang.c b/drivers/thermal/gov_bang_bang.c
> index 70836c5..9d1dfea 100644
> --- a/drivers/thermal/gov_bang_bang.c
> +++ b/drivers/thermal/gov_bang_bang.c
> @@ -59,7 +59,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>  		if (instance->target == 0 && tz->temperature >= trip_temp)
>  			instance->target = 1;
>  		else if (instance->target == 1 &&
> -				tz->temperature < trip_temp - trip_hyst)
> +				tz->temperature <= trip_temp - trip_hyst)
>  			instance->target = 0;
>  
>  		dev_dbg(&instance->cdev->device, "target=%d\n",
> -- 
> 1.9.1
> 

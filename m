From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH RESEND 3/4] thermal: cleanup: use dev_* helper functions
Date: Wed, 2 Jan 2013 15:51:18 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59252E4B@BGSMSX101.gar.corp.intel.com>
References: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
 <1357140582-8151-4-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:64834 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752931Ab3ABPvY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jan 2013 10:51:24 -0500
In-Reply-To: <1357140582-8151-4-git-send-email-eduardo.valentin@ti.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> Sent: Wednesday, January 02, 2013 9:00 PM
> To: Zhang, Rui
> Cc: R, Durgadoss; linux-pm@lists.linux-foundation.org; linux-
> pm@vger.kernel.org; Eduardo Valentin
> Subject: [PATCH RESEND 3/4] thermal: cleanup: use dev_* helper functions
> 
> Change the logging messages to used dev_* helper functions.

A good to have Change :-)

> 

Reviewed-by: Durgadoss R <durgadoss.r@intel.com>

Thanks,
Durga

> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> ---
>  drivers/thermal/thermal_sys.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 70ce100..fba27c3 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -354,8 +354,9 @@ static void handle_critical_trips(struct
> thermal_zone_device *tz,
>  		tz->ops->notify(tz, trip, trip_type);
> 
>  	if (trip_type == THERMAL_TRIP_CRITICAL) {
> -		pr_emerg("Critical temperature reached(%d C),shutting
> down\n",
> -			 tz->temperature / 1000);
> +		dev_emerg(&tz->device,
> +			  "critical temperature reached(%d C),shutting
> down\n",
> +			  tz->temperature / 1000);
>  		orderly_poweroff(true);
>  	}
>  }
> @@ -386,7 +387,8 @@ static void update_temperature(struct
> thermal_zone_device *tz)
> 
>  	ret = tz->ops->get_temp(tz, &temp);
>  	if (ret) {
> -		pr_warn("failed to read out thermal zone %d\n", tz->id);
> +		dev_warn(&tz->device, "failed to read out thermal zone
> %d\n",
> +			 tz->id);
>  		goto exit;
>  	}
> 
> @@ -1770,7 +1772,7 @@ int thermal_generate_netlink_event(struct
> thermal_zone_device *tz,
> 
>  	result = genlmsg_multicast(skb, 0, thermal_event_mcgrp.id,
> GFP_ATOMIC);
>  	if (result)
> -		pr_info("failed to send netlink event:%d\n", result);
> +		dev_err(&tz->device, "Failed to send netlink event:%d",
> result);
> 
>  	return result;
>  }
> --
> 1.7.7.1.488.ge8e1c
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

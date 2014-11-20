From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: core: ignore invalid trip temperature
Date: Thu, 20 Nov 2014 10:25:31 +0800
Message-ID: <1416450331.5808.3.camel@rzhang1-toshiba>
References: <1415835809-23376-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21468 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756174AbaKTCZS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 19 Nov 2014 21:25:18 -0500
In-Reply-To: <1415835809-23376-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: edubezval@gmail.com, linux-pm@vger.kernel.org


For some reason, I did not see the discussion between Lukasz and you via
email. I can only see it via patchwork.

Lukasz,

if the regulator for thermal unit is not enabled, what will you get?
temperature 0xFF + trip point -1? or Just temperature 0xFF?
I don't think this patch makes any difference in the second case.

BTW, if you expect some indicator when the thermal unit is not enabled,
system critical shutdown is not a proper one, we can either check the
sysfs I/F, and we can add a warning message here, telling that invalid
trip point is found.

thanks,
rui

On Wed, 2014-11-12 at 15:43 -0800, Srinivas Pandruvada wrote:
> Ignore invalid trip temperature less or equal to zero. Some
> buggy systems have invalid trips, causing system shutdown.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Acked-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 9bf10aa..fbf301a 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -368,7 +368,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>  	tz->ops->get_trip_temp(tz, trip, &trip_temp);
>  
>  	/* If we have not crossed the trip_temp, we do not care. */
> -	if (tz->temperature < trip_temp)
> +	if (trip_temp <= 0 || tz->temperature < trip_temp)
>  		return;
>  
>  	trace_thermal_zone_trip(tz, trip, trip_type);




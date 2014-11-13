From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] thermal: core: ignore invalid trip temperature
Date: Thu, 13 Nov 2014 10:23:11 +0100
Message-ID: <20141113102311.64331d60@amdc2363>
References: <1415835809-23376-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:40021 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932164AbaKMKKF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 13 Nov 2014 05:10:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gll-linux-pm2@m.gmane.org>)
	id 1XorLm-0001G8-Nd
	for linux-pm@vger.kernel.org; Thu, 13 Nov 2014 11:10:02 +0100
Received: from 217-67-201-162.itsa.net.pl ([217.67.201.162])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2014 11:10:02 +0100
Received: from l.majewski by 217-67-201-162.itsa.net.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-pm@vger.kernel.org>; Thu, 13 Nov 2014 11:10:02 +0100
In-Reply-To: <1415835809-23376-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi Srinivas,

> Ignore invalid trip temperature less or equal to zero. Some
> buggy systems have invalid trips, causing system shutdown.
> 
> Signed-off-by: Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> Acked-by: Zhang Rui
> <rui.zhang@intel.com> ---
>  drivers/thermal/thermal_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c index 9bf10aa..fbf301a 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -368,7 +368,7 @@ static void handle_critical_trips(struct
> thermal_zone_device *tz, tz->ops->get_trip_temp(tz, trip, &trip_temp);
>  
>  	/* If we have not crossed the trip_temp, we do not care. */
> -	if (tz->temperature < trip_temp)
> +	if (trip_temp <= 0 || tz->temperature < trip_temp)

To be honest, I regard this as a feature :-), not bug.

In this way I know that on some systems the regulator for thermal unit
is not enabled (which results in read temp of 0xFF).

I'd prefer to keep this as is.

>  		return;
>  
>  	trace_thermal_zone_trip(tz, trip, trip_type);



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group



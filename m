From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] of: thermal: Fixed governor at each thermal zone
Date: Tue, 27 Sep 2016 09:46:57 +0800
Message-ID: <1474940817.4284.0.camel@intel.com>
References: <1474247932-1026-1-git-send-email-hugh.kang@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39942 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932504AbcI0BrA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Sep 2016 21:47:00 -0400
In-Reply-To: <1474247932-1026-1-git-send-email-hugh.kang@lge.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Inhyuk Kang <hugh.kang@lge.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 一, 2016-09-19 at 10:18 +0900, Inhyuk Kang wrote:
> It is necessary to be added governor at each thermal_zone.
> Because some governors should be operated in the during the kernel
> booting
> in order to avoid heating problem.
> 
> Default governor cannot be covered all thermal zones policy because
> some thermal zones want to apply different one.
> For example, the power allocator governor operates differently with
> step wise governor.
> Hence, it is better to parse governor parameter from the device tree.
> 
> Signed-off-by: Inhyuk Kang <hugh.kang@lge.com>
> 
The patch looks okay to me.
Eduardo, what do you think of this patch?

thanks,
rui
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-
> thermal.c
> index b8e509c..382c440 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -970,6 +970,7 @@ int __init of_parse_thermal_zones(void)
>  		struct thermal_zone_device *zone;
>  		struct thermal_zone_params *tzp;
>  		int i, mask = 0;
> +		const char *governor;
>  		u32 prop;
>  
>  		tz = thermal_of_build_thermal_zone(child);
> @@ -996,6 +997,9 @@ int __init of_parse_thermal_zones(void)
>  		if (!of_property_read_u32(child, "sustainable-
> power", &prop))
>  			tzp->sustainable_power = prop;
>  
> +		if (!of_property_read_string(child, "governor-name", 
> &governor))
> +			strcpy(tzp->governor_name, governor);
> +
>  		for (i = 0; i < tz->ntrips; i++)
>  			mask |= 1 << i;
>  

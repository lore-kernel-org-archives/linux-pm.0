From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: of: use the default governor when registering
 thermal zones from DT
Date: Thu, 27 Feb 2014 14:43:06 +0800
Message-ID: <1393483386.2637.9.camel@rzhang1-mobl4>
References: <1393263953-4590-1-git-send-email-javi.merino@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11699 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbaB0GnJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Feb 2014 01:43:09 -0500
In-Reply-To: <1393263953-4590-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: linux-pm@vger.kernel.org, sudeep.holla@arm.com, punit.agrawal@arm.com, Eduardo Valentin <eduardo.valentin@ti.com>

Hi,

On Mon, 2014-02-24 at 17:45 +0000, Javi Merino wrote:
> Thermal zones specified in the DT get no governor because the
> thermal_zone_parameters they pass to thermal_zone_device_register()
> has an empty governor_name entry.  As there is no way to set the
> governor from the DT at the moment, make them register the default
> governor.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: Javi Merino <javi.merino@arm.com>
> ---
> 
> Another alternative would be to set governor_name to the default in
> thermal_zone_device_register() if it receives the empty string.
> 
agreed.
please check if the patch at https://patchwork.kernel.org/patch/3730391/
fixes the problem for you or not.

thanks,
rui


> There are no other users of thermal_zone_parameters in the kernel and
> there is no user of the governor_name.  I was tempted to kill
> governor_name, but I guess it's there to be used by external modules.
> 
>  drivers/thermal/of-thermal.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 04b1be7..3f850f2 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -791,6 +791,13 @@ int __init of_parse_thermal_zones(void)
>  		/* No hwmon because there might be hwmon drivers registering */
>  		tzp->no_hwmon = true;
>  
> +		/*
> +		 * We can't specify the governor in the DT, so use the
> +		 * default one
> +		 */
> +		strncpy(tzp->governor_name, DEFAULT_THERMAL_GOVERNOR,
> +			ARRAY_SIZE(tzp->governor_name));
> +
>  		zone = thermal_zone_device_register(child->name, tz->ntrips,
>  						    0, tz,
>  						    ops, tzp,



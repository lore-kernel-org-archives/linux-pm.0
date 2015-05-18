From: Mikko Perttunen <mikko.perttunen@kapsi.fi>
Subject: Re: [PATCH 12/15] thermal: of: implement .set_trips for device tree
 thermal zones
Date: Mon, 18 May 2015 12:09:07 +0300
Message-ID: <5559AC33.10604@kapsi.fi>
References: <1431507163-19933-1-git-send-email-s.hauer@pengutronix.de> <1431507163-19933-13-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:46632 "EHLO mail.kapsi.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752579AbbERJJV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 18 May 2015 05:09:21 -0400
In-Reply-To: <1431507163-19933-13-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, kernel@pengutronix.de, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Brian Norris <computersforpeace@gmail.com>

On 05/13/15 11:52, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   drivers/thermal/of-thermal.c | 12 ++++++++++++
>   include/linux/thermal.h      |  3 +++
>   2 files changed, 15 insertions(+)
>
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index bd3185e..f8dd847 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -97,6 +97,17 @@ static int of_thermal_get_temp(struct thermal_zone_device *tz,
>   	return data->ops->get_temp(data->sensor_data, temp);
>   }
>
> +static int of_thermal_set_trips(struct thermal_zone_device *tz,
> +			       int low, int high)
> +{
> +	struct __thermal_zone *data = tz->devdata;
> +
> +	if (!data->ops || !data->ops->set_trips)
> +		return -ENOSYS;
> +
> +	return data->ops->set_trips(data->sensor_data, low, high);
> +}
> +
>   /**
>    * of_thermal_get_ntrips - function to export number of available trip
>    *			   points.
> @@ -367,6 +378,7 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
>
>   static const struct thermal_zone_device_ops of_thermal_ops = {
>   	.get_temp = of_thermal_get_temp,
> +	.set_trips = of_thermal_set_trips,
>   	.get_trend = of_thermal_get_trend,
>   	.set_emul_temp = of_thermal_set_emul_temp,
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index aef6e13..b751f6b 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -267,12 +267,15 @@ struct thermal_genl_event {
>    *
>    * Optional:
>    * @get_trend: a pointer to a function that reads the sensor temperature trend.
> + * @set_trips: a pointer to a function that sets a temperature window which shall
> + *             trigger an interrupt when it is left.

Perhaps this documentation should be expanded a little; the commit 
message in the previous patch looked pretty good. The fact that the 
driver needs to call thermal_zone_device_update should be mentioned 
somewhere.

>    * @set_emul_temp: a pointer to a function that sets sensor emulated
>    *		   temperature.
>    */
>   struct thermal_zone_of_device_ops {
>   	int (*get_temp)(void *, int *);
>   	int (*get_trend)(void *, int, enum thermal_trend *);
> +	int (*set_trips)(void *, int, int);
>   	int (*set_emul_temp)(void *, int);
>   };
>
>

Thanks,
Mikko.

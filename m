From: Matt Longnecker <mlongnecker@nvidia.com>
Subject: Re: [PATCH v3 3/4] thermal: of: enable temperature notifications
Date: Wed, 30 Mar 2016 09:54:15 -0700
Message-ID: <56FC04B7.5050808@nvidia.com>
References: <1459298497-29481-1-git-send-email-srikars@nvidia.com>
 <1459298497-29481-4-git-send-email-srikars@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13912 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252AbcC3QyR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 12:54:17 -0400
In-Reply-To: <1459298497-29481-4-git-send-email-srikars@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srikar Srimath Tirumala <srikars@nvidia.com>, edubezval@gmail.com, rui.zhang@intel.com, srinivas.pandruvada@intel.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org

Looks good to me.

On 03/29/2016 05:41 PM, Srikar Srimath Tirumala wrote:
> * Add a state variable to track if trip point is triggered.
> * Enable trip events only when the state of the tirp point changes.
> * Implement the get\set callbacks for trip state.
>
> Change-Id: I1bd6a7b0e5e520d8ee678b83111d23cada7a580c
> Signed-off-by: Srikar Srimath Tirumala <srikars@nvidia.com>
> ---
>   drivers/thermal/of-thermal.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)
>
> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> index 49ac23d..f6d9d3d 100644
> --- a/drivers/thermal/of-thermal.c
> +++ b/drivers/thermal/of-thermal.c
> @@ -379,6 +379,43 @@ static int of_thermal_get_crit_temp(struct thermal_zone_device *tz,
>   	return -EINVAL;
>   }
>   
> +static bool of_thermal_enb_temp_notify(struct thermal_zone_device *tz, int trip)
> +{
> +	bool ret = true;
> +	struct __thermal_zone *data = tz->devdata;
> +
> +	if (trip >= data->ntrips || trip < 0)
> +		ret = false;
> +
> +	return ret;
> +}
> +
> +static int of_thermal_get_trip_state(struct thermal_zone_device *tz, int trip,
> +				     enum thermal_trip_state *state)
> +{
> +	struct __thermal_zone *data = tz->devdata;
> +
> +	if (trip >= data->ntrips || trip < 0)
> +		return -EDOM;
> +
> +	*state = data->trips[trip].state;
> +
> +	return 0;
> +}
> +
> +static int of_thermal_set_trip_state(struct thermal_zone_device *tz, int trip,
> +				     enum thermal_trip_state state)
> +{
> +	struct __thermal_zone *data = tz->devdata;
> +
> +	if (trip >= data->ntrips || trip < 0)
> +		return -EDOM;
> +
> +	data->trips[trip].state = state;
> +
> +	return 0;
> +}
> +
>   static struct thermal_zone_device_ops of_thermal_ops = {
>   	.get_mode = of_thermal_get_mode,
>   	.set_mode = of_thermal_set_mode,
> @@ -392,6 +429,10 @@ static struct thermal_zone_device_ops of_thermal_ops = {
>   
>   	.bind = of_thermal_bind,
>   	.unbind = of_thermal_unbind,
> +
> +	.get_trip_state = of_thermal_get_trip_state,
> +	.set_trip_state = of_thermal_set_trip_state,
> +	.enb_temp_notify = of_thermal_enb_temp_notify,
>   };
>   
>   /***   sensor API   ***/
> @@ -782,6 +823,8 @@ static int thermal_of_populate_trip(struct device_node *np,
>   		return ret;
>   	}
>   
> +	trip->state = THERMAL_TRIP_NOT_TRIPPED;
> +
>   	/* Required for cooling map matching */
>   	trip->np = np;
>   	of_node_get(np);


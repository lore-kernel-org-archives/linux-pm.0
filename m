From: Matt Longnecker <mlongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 2/4] thermal: send notifications for tz temperature
Date: Wed, 30 Mar 2016 09:43:01 -0700
Message-ID: <56FC0215.1060802@nvidia.com>
References: <1459298497-29481-1-git-send-email-srikars@nvidia.com>
 <1459298497-29481-3-git-send-email-srikars@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459298497-29481-3-git-send-email-srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srikar Srimath Tirumala <srikars-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, srinivas.pandruvada-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 03/29/2016 05:41 PM, Srikar Srimath Tirumala wrote:
> * Update the 'temp' attr of a thermal_zone sysfs node, when the
>    temperature goes above\below a trip point. Use sysfs_notify to send
>    the notifications.
Rather than notifying temp, would it make sense to notify 
trip_pointX_temp when temperature crosses the trip point going up and 
trip_pointX_hyst when temperature crosses the trip point going down? 
That would allow userspace to watch for only a subset of events by 
polling/selecting on the relevant nodes.

>   
>   struct thermal_cooling_device_ops {
> @@ -348,6 +358,7 @@ struct thermal_zone_of_device_ops {
>    * @temperature: temperature value in miliCelsius
>    * @hysteresis: relative hysteresis in miliCelsius
>    * @type: trip point type
> + * @state: trip point state
>    */
>   
>   struct thermal_trip {
> @@ -355,6 +366,7 @@ struct thermal_trip {
>   	unsigned long int temperature;
>   	unsigned long int hysteresis;
>   	enum thermal_trip_type type;
> +	enum thermal_trip_state state;
This looks vestigial. Remove it?

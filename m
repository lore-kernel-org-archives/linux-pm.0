From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v6 4/8] thermal:boost: Automatic enable/disable of BOOST
 feature
Date: Mon, 12 Aug 2013 11:17:31 +0200
Message-ID: <20130812111731.60fca98b@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-1-git-send-email-l.majewski@samsung.com>
 <1374770011-22171-5-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:41946 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755679Ab3HLJR5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2013 05:17:57 -0400
In-reply-to: <1374770011-22171-5-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, durgadoss.r@intel.com

Dear Zhang, Eduardo,

> This patch provides auto disable/enable operation for boost. When any
> defined trip point is passed, the boost is disabled.
> In that moment thermal monitor workqueue is woken up and it monitors
> if the device temperature drops below 75% of the smallest trip point.
> When device cools down, the boost is enabled again.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
> 
> ---
> Changes for v6:
> - Disable boost only when supported and enabled
> - Protect boost related thermal_zone_device struct fields with mutex
> - Evaluate temperature trend during boost enable decision
> - Create separate methods to handle boost enable/disable
>   (thermal_boost_{enable|disable}) operations
> - Boost is disabled at any trip point passage (not only the non
> critical one)
> - Add stub definitions for cpufreq boost functions used when
>   CONFIG_CPU_FREQ is NOT defined.
> 
> Changes for v5:
> - Move boost disable code from cpu_cooling.c to thermal_core.c
>   (to handle_non_critical_trips)
> - Extent struct thermal_zone_device by adding overheated bool flag
> - Implement auto enable of boost after device cools down
> - Introduce boost_polling flag, which indicates if thermal uses it's
> predefined pool delay or has woken up thermal workqueue only to wait
> until device cools down.
> 
> Changes for v4:
> - New patch
> 

ping...

>  drivers/thermal/thermal_core.c |   55
> ++++++++++++++++++++++++++++++++++++++++
> include/linux/cpufreq.h        |   15 +++++++++++
> include/linux/thermal.h        |    2 ++ 3 files changed, 72
> insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c index 1f02e8e..8f4be55 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -34,6 +34,7 @@
>  #include <linux/thermal.h>
>  #include <linux/reboot.h>
>  #include <linux/string.h>
> +#include <linux/cpufreq.h>
>  #include <net/netlink.h>
>  #include <net/genetlink.h>
>  
> @@ -354,9 +355,59 @@ static void handle_critical_trips(struct
> thermal_zone_device *tz, }
>  }
>  
> +static int thermal_boost_enable(struct thermal_zone_device *tz)
> +{
> +	enum thermal_trend trend = get_tz_trend(tz, 0);
> +	long trip_temp;
> +
> +	if (!tz->ops->get_trip_temp || !tz->overheated)
> +		return -EPERM;
> +	if (trend == THERMAL_TREND_RAISING || trend ==
> THERMAL_TREND_RAISE_FULL)
> +		return -EBUSY;
> +
> +	tz->ops->get_trip_temp(tz, 0, &trip_temp);
> +	/*
> +	 * Enable boost again only when current temperature is less
> +	 * than 75% of trip_temp[0]
> +	 */
> +	if ((tz->temperature + (trip_temp >> 2)) < trip_temp) {
> +		mutex_lock(&tz->lock);
> +		tz->overheated = false;
> +		if (tz->boost_polling) {
> +			tz->boost_polling = false;
> +			tz->polling_delay = 0;
> +		}
> +		mutex_unlock(&tz->lock);
> +		cpufreq_boost_trigger_state(1);
> +		return 0;
> +	}
> +	return -EBUSY;
> +}
> +
> +static void thermal_boost_disable(struct thermal_zone_device *tz)
> +{
> +	cpufreq_boost_trigger_state(0);
> +
> +	/*
> +	 * If no workqueue for monitoring is running - start one with
> +	 * 1000 ms monitoring period
> +	 * If workqueue already running - do not change its period
> and only
> +	 * test if target CPU has cooled down
> +	 */
> +	mutex_lock(&tz->lock);
> +	if (!tz->polling_delay) {
> +		tz->boost_polling = true;
> +		tz->polling_delay = 1000;
> +	}
> +	tz->overheated = true;
> +	mutex_unlock(&tz->lock);
> +}
> +
>  static void handle_thermal_trip(struct thermal_zone_device *tz, int
> trip) {
>  	enum thermal_trip_type type;
> +	if (cpufreq_boost_supported() && cpufreq_boost_enabled())
> +		thermal_boost_disable(tz);
>  
>  	tz->ops->get_trip_type(tz, trip, &type);
>  
> @@ -455,6 +506,10 @@ static void thermal_zone_device_check(struct
> work_struct *work) struct thermal_zone_device *tz =
> container_of(work, struct thermal_zone_device,
>  						      poll_queue.work);
> +	if (cpufreq_boost_supported())
> +		if (!thermal_boost_enable(tz))
> +			return;
> +
>  	thermal_zone_device_update(tz);
>  }
>  
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 49a73c9..3d9276d 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -435,9 +435,24 @@ int cpufreq_frequency_table_target(struct
> cpufreq_policy *policy, unsigned int relation,
>  				   unsigned int *index);
>  
> +#ifdef CONFIG_CPU_FREQ
>  int cpufreq_boost_trigger_state(int state);
>  int cpufreq_boost_supported(void);
>  int cpufreq_boost_enabled(void);
> +#else
> +static inline int cpufreq_boost_trigger_state(int state)
> +{
> +	return 0;
> +}
> +static inline int cpufreq_boost_supported(void)
> +{
> +	return 0;
> +}
> +static inline int cpufreq_boost_enabled(void)
> +{
> +	return 0;
> +}
> +#endif
>  /* the following 3 funtions are for cpufreq core use only */
>  struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned
> int cpu); 
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index a386a1c..f1aa3c2 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -172,6 +172,8 @@ struct thermal_zone_device {
>  	int emul_temperature;
>  	int passive;
>  	unsigned int forced_passive;
> +	bool overheated;
> +	bool boost_polling;
>  	const struct thermal_zone_device_ops *ops;
>  	const struct thermal_zone_params *tzp;
>  	struct thermal_governor *governor;



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

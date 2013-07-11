From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v5 5/7] thermal:boost: Automatic enable/disable of BOOST
 feature
Date: Thu, 11 Jul 2013 10:08:32 +0200
Message-ID: <20130711100832.48fe3b33@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-1-git-send-email-l.majewski@samsung.com>
 <1372927830-2949-6-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1372927830-2949-6-git-send-email-l.majewski@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, "R, Durgadoss" <durgadoss.r@intel.com>, Myungjoo Ham <myungjoo.ham@samsung.com>
List-Id: linux-pm@vger.kernel.org

Dear Zhang, Eduardo

Do you have any comments/feedback for me regarding this thermal
framework related patch?

I've already received some feedback from Durga for this patch, but I
think that maintainers are most welcome to express their opinion :-)

Thanks in advance.

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
>  drivers/thermal/thermal_core.c |   31 +++++++++++++++++++++++++++++++
>  include/linux/thermal.h        |    2 ++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c
> b/drivers/thermal/thermal_core.c index d755440..12adbad 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -33,6 +33,7 @@
>  #include <linux/idr.h>
>  #include <linux/thermal.h>
>  #include <linux/reboot.h>
> +#include <linux/cpufreq.h>
>  #include <net/netlink.h>
>  #include <net/genetlink.h>
>  
> @@ -326,6 +327,15 @@ static void monitor_thermal_zone(struct
> thermal_zone_device *tz) static void handle_non_critical_trips(struct
> thermal_zone_device *tz, int trip, enum thermal_trip_type trip_type)
>  {
> +	if (cpufreq_boost_supported()) {
> +		tz->overheated = true;
> +		cpufreq_boost_trigger_state(0);
> +		if (!tz->polling_delay) {
> +			tz->boost_polling = true;
> +			tz->polling_delay = 1000;
> +		}
> +	}
> +
>  	if (tz->governor)
>  		tz->governor->throttle(tz, trip);
>  }
> @@ -453,6 +463,27 @@ static void thermal_zone_device_check(struct
> work_struct *work) struct thermal_zone_device *tz =
> container_of(work, struct thermal_zone_device,
>  						      poll_queue.work);
> +	long trip_temp;
> +
> +	if (cpufreq_boost_supported() && tz->overheated) {
> +		tz->ops->get_trip_temp(tz, 0, &trip_temp);
> +		/*
> +		 * Enable boost again only when current temperature
> is less
> +		 * than 75% of trip_temp[0]
> +		 */
> +		if ((tz->temperature + (trip_temp >> 2)) <
> trip_temp) {
> +			tz->overheated = false;
> +			if (tz->boost_polling) {
> +				tz->boost_polling = false;
> +				tz->polling_delay = 0;
> +				monitor_thermal_zone(tz);
> +			}
> +
> +			cpufreq_boost_trigger_state(1);
> +			return;
> +		}
> +	}
> +
>  	thermal_zone_device_update(tz);
>  }
>  
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

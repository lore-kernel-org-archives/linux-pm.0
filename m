From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] thermal: Add notifier call chain for hot/critical
 events
Date: Tue, 23 Oct 2018 10:17:48 +0200
Message-ID: <7c7d14e2-3c58-fcbb-14b1-e0a2fecb0224@linaro.org>
References: <20181022203218.7007-1-zwisler@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181022203218.7007-1-zwisler@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ross Zwisler <zwisler@google.com>, linux-kernel@vger.kernel.org
Cc: Duncan Laurie <dlaurie@chromium.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 22/10/2018 22:32, Ross Zwisler wrote:
> From: Duncan Laurie <dlaurie@chromium.org>
> 
> This will allow drivers to register a callback for important
> thermal events and log critical thresholds that cause the system
> to shut down.
> 
> There are other places this might work, but after consideration
> I think it makes sense to have the chain at this level:
> 
> The ACPI thermal driver has an existing notify function that is
> eventually called into, but that would limit the notifier to only
> working on systems that use ACPI.
> 
> The cpufreq driver is already getting a notify callback executed
> in this path (tz->ops->notify) but the threshold info is not passed
> to the cpu_cooling notifier chain so it is not useful for logging.
> 
> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> Reviewed-by: Olof Johansson <olofj@chromium.org>
> Reviewed-by: Vincent Palatin <vpalatin@chromium.org>
> [ rez: updated changelog for upstream ]
> Signed-off-by: Ross Zwisler <zwisler@google.com>
> ---

At the critical code path, the thermal framework gives a chance to
orderly_poweroff() to complete but the execution is bounded by a delay
which in turn forces a kernel power off.

The usage of a notifier call chain is inadequate in this code path. When
the system is reaching a critical temperature it has to *urgently* take
action. By adding this notifier that allows anyone to hook this path and
add an overhead/delays.



>  drivers/thermal/thermal_core.c | 38 ++++++++++++++++++++++++++++++++++
>  include/linux/thermal.h        |  4 ++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 6ab982309e6a0..e1f8764b3d9f9 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -15,6 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/kdev_t.h>
>  #include <linux/idr.h>
> +#include <linux/notifier.h>
>  #include <linux/thermal.h>
>  #include <linux/reboot.h>
>  #include <linux/string.h>
> @@ -313,12 +314,46 @@ static void monitor_thermal_zone(struct thermal_zone_device *tz)
>  	mutex_unlock(&tz->lock);
>  }
>  
> +static BLOCKING_NOTIFIER_HEAD(thermal_notifier_list);
> +
> +/**
> + * register_thermal_notifier - Register function to be called for
> + *                             critical thermal events.
> + *
> + * @nb: Info about notifier function to be called
> + *
> + * Currently always returns zero, as blocking_notifier_chain_register()
> + * always returns zero.
> + */
> +int register_thermal_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&thermal_notifier_list, nb);
> +}
> +EXPORT_SYMBOL(register_thermal_notifier);
> +
> +/**
> + * unregister_thermal_notifier - Unregister thermal notifier
> + *
> + * @nb: Hook to be unregistered
> + *
> + * Returns zero on success, or %-ENOENT on failure.
> + */
> +int unregister_thermal_notifier(struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&thermal_notifier_list, nb);
> +}
> +EXPORT_SYMBOL(unregister_thermal_notifier);
> +
> +
>  static void handle_non_critical_trips(struct thermal_zone_device *tz,
>  				      int trip,
>  				      enum thermal_trip_type trip_type)
>  {
>  	tz->governor ? tz->governor->throttle(tz, trip) :
>  		       def_governor->throttle(tz, trip);
> +
> +	blocking_notifier_call_chain(&thermal_notifier_list,
> +				     trip_type, NULL);
>  }
>  
>  /**
> @@ -385,6 +420,9 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
>  	if (tz->ops->notify)
>  		tz->ops->notify(tz, trip, trip_type);
>  
> +	blocking_notifier_call_chain(&thermal_notifier_list,
> +				     trip_type, NULL);
> +
>  	if (trip_type == THERMAL_TRIP_CRITICAL) {
>  		dev_emerg(&tz->device,
>  			  "critical temperature reached (%d C), shutting down\n",
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5f4705f46c2f9..b948344d55cab 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -13,6 +13,7 @@
>  #include <linux/of.h>
>  #include <linux/idr.h>
>  #include <linux/device.h>
> +#include <linux/notifier.h>
>  #include <linux/sysfs.h>
>  #include <linux/workqueue.h>
>  #include <uapi/linux/thermal.h>
> @@ -542,4 +543,7 @@ static inline int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>  }
>  #endif
>  
> +extern int register_thermal_notifier(struct notifier_block *);
> +extern int unregister_thermal_notifier(struct notifier_block *);
> +
>  #endif /* __THERMAL_H__ */
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

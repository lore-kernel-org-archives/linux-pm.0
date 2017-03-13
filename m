From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH] fix: thermal: avoid possible deadlock calling
 thermal_zone_get_temp()
Date: Mon, 13 Mar 2017 10:43:54 +0800
Message-ID: <1489373034.5841.14.camel@intel.com>
References: <20170210161547.28625-1-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:36925 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755789AbdCMCnw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 12 Mar 2017 22:43:52 -0400
In-Reply-To: <20170210161547.28625-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>, edubezval@gmail.com, linux-pm@vger.kernel.org

On Fri, 2017-02-10 at 16:15 +0000, Lukasz Luba wrote:
> There is possible scenario when the system hits deadlock.
> One of the examples is when IPA (power_allocator.c) calculates
> power budget and calls every cooling device in the thermal zone
> using function get_requested_power().
> This function in devfreq_cooling calls driver's code via
> get_static_power().
> If the driver code tries to calculate properly static power
> based on current temperature, it might call API functions:
> tz = thermal_zone_get_zone_by_name(priv->tz_name)
> and then:
> thermal_zone_get_temp(tz, &temp)
> 
> Here is the call graph:
> 
> tz->gov->throttle() [=power_allocator_throttle]
>   power_allocator_throttle
>     allocate_power
> ==>   (lock tz->lock taken)
>       (for each cooling device:)
>          cdev->ops->get_requested_power
>          [=devfreq_cooling_get_requested_power]
>               get_static_power
>                  (call driver specific function)
>                  dfc->power_ops->get_static_power
>                  [=mock_devfreq_get_static_power]
>                       tz = thermal_zone_get_zone_by_name()
>                       thermal_zone_get_temp(tz, &temp)
> ===>                    (try to lock again tz->lock)
> 
I didn't find mock_devfreq_get_static_power, thus I don't understand
why thermal_zone_get_zone_by_name() and thermal_zone_get_temp() needs
to be called in .get_static_power() callback.

> This patch changes the mutex_lock into mutex_trylock
> just to avoid the deadlock.
> 
Well, I don't think this is the right solution.
We should either avoid poking thermal lock in .get_static_power()
callback, in the thermal driver, or avoid invoking the callback with
lock hold, in power_allocator code.

thanks,
rui
> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> ---
> Hi,
> 
> This is a RFC to start some discussion.
> I am not sure if it should go with stable label
> (it affects few versions back though).
> It is based on v4.10-rc7.
> 
> Regards,
> Lukasz Luba
> 
>  drivers/thermal/thermal_helpers.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_helpers.c
> b/drivers/thermal/thermal_helpers.c
> index 8cdf75a..7b01a85 100644
> --- a/drivers/thermal/thermal_helpers.c
> +++ b/drivers/thermal/thermal_helpers.c
> @@ -75,6 +75,12 @@ EXPORT_SYMBOL(get_thermal_instance);
>   * When a valid thermal zone reference is passed, it will fetch its
>   * temperature and fill @temp.
>   *
> + * IMPORTANT NOTICE:
> + * This function should not be used from driver's code which is
> called
> + * by IPA (power_allocator.c). The IPA already holds the tz->lock.
> + * Therefore, it is possible to get the temperature in driver code
> + * in a simple way: reading tz->temperature.
> + *
>   * Return: On success returns 0, an error code otherwise
>   */
>  int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
> @@ -87,7 +93,8 @@ int thermal_zone_get_temp(struct
> thermal_zone_device *tz, int *temp)
>  	if (!tz || IS_ERR(tz) || !tz->ops->get_temp)
>  		goto exit;
>  
> -	mutex_lock(&tz->lock);
> +	if (!mutex_trylock(&tz->lock))
> +		goto exit;
>  
>  	ret = tz->ops->get_temp(tz, temp);
>  

From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V3 1/3] Thermal: initialize thermal zone device correctly
Date: Mon, 6 Apr 2015 11:46:26 -0700
Message-ID: <20150406184621.GA4472@localhost.localdomain>
References: <1427768815-20948-1-git-send-email-rui.zhang@intel.com>
 <1427768815-20948-2-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36374 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbbDFSqR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Apr 2015 14:46:17 -0400
Received: by pdea3 with SMTP id a3so52655059pde.3
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2015 11:46:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1427768815-20948-2-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org

Hello Rui,

On Tue, Mar 31, 2015 at 10:26:53AM +0800, Zhang Rui wrote:
> After thermal zone device registered, as we have not read any
> temperature before, thus tz->temperature should not be 0, which actually
> means 0C, and thermal trend is not available.
> In this case, we need specially handling for the first
> thermal_zone_device_update().
> 
> Both thermal core framework and step_wise governor is enhanced to handle this.
> 
> CC: <stable@vger.kernel.org> #3.18+
> Tested-by: Manuel Krause <manuelkrause@netscape.net>
> Tested-by: szegad <szegadlo@poczta.onet.pl>
> Tested-by: prash <prash.n.rao@gmail.com>
> Tested-by: amish <ammdispose-arch@yahoo.com>
> Tested-by: Matthias <morpheusxyz123@yahoo.de>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/step_wise.c    | 15 +++++++++++++--
>  drivers/thermal/thermal_core.c | 19 +++++++++++++++++--
>  drivers/thermal/thermal_core.h |  1 +
>  include/linux/thermal.h        |  3 +++
>  4 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> index 5a0f12d..c2bb37c 100644
> --- a/drivers/thermal/step_wise.c
> +++ b/drivers/thermal/step_wise.c
> @@ -63,6 +63,16 @@ static unsigned long get_target_state(struct thermal_instance *instance,
>  	next_target = instance->target;
>  	dev_dbg(&cdev->device, "cur_state=%ld\n", cur_state);
>  
> +	if (!instance->initialized) {
> +		if (throttle) {
> +			next_target = (cur_state + 1) >= instance->upper ?
> +					instance->upper :
> +					((cur_state + 1) < instance->lower ?
> +					instance->lower : (cur_state + 1));

This code is a nop for THERMAL_TREND_RAISING and
THERMAL_TREND_RAISE_FULL because the switch below will overwrite what
we decide here regardless the instance being initialized or not.

Same comment applies for THERMAL_TREND_DROPPING when cur_state >
instance->lower.

> +		} else
> +			next_target = THERMAL_NO_TARGET;

For this case, the same comment applies for THERMAL_TREND_DROPPING
(cur_state <= instance->lower) and for THERMAL_TREND_DROP_FULL
(cur_state == instance->lower).

Can you please add a early return at this point

+		return next_target;
		
to make the behavior consistent and expected for all cases?

Besides, if the instance has an invalid trend, it means the 'trend'
value is unreliable and we should not do the actions below, right?

> +	}
> +
>  	switch (trend) {
>  	case THERMAL_TREND_RAISING:
>  		if (throttle) {
> @@ -149,7 +159,8 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>  		dev_dbg(&instance->cdev->device, "old_target=%d, target=%d\n",
>  					old_target, (int)instance->target);
>  
> -		if (old_target == instance->target)
> +		if (instance->initialized &&
> +		    old_target == instance->target)
>  			continue;
>  
>  		/* Activate a passive thermal instance */
> @@ -161,7 +172,7 @@ static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
>  			instance->target == THERMAL_NO_TARGET)
>  			update_passive_instance(tz, trip_type, -1);
>  
> -
> +		instance->initialized = true;
>  		instance->cdev->updated = false; /* cdev needs update */
>  	}
>  
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 174d3bc..9d6f71b 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -469,8 +469,22 @@ static void update_temperature(struct thermal_zone_device *tz)
>  	mutex_unlock(&tz->lock);
>  
>  	trace_thermal_temperature(tz);
> -	dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
> -				tz->last_temperature, tz->temperature);
> +	if (tz->last_temperature == THERMAL_TEMP_INVALID)
> +		dev_dbg(&tz->device, "last_temperature N/A, current_temperature=%d\n",
> +			tz->temperature);
> +	else
> +		dev_dbg(&tz->device, "last_temperature=%d, current_temperature=%d\n",
> +			tz->last_temperature, tz->temperature);
> +}
> +
> +static void thermal_zone_device_reset(struct thermal_zone_device *tz)
> +{
> +	struct thermal_instance *pos;
> +
> +	tz->temperature = THERMAL_TEMP_INVALID;
> +	tz->passive = 0;
> +	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> +		pos->initialized = false;
>  }
>  
>  void thermal_zone_device_update(struct thermal_zone_device *tz)
> @@ -1574,6 +1588,7 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
>  	if (!tz->ops->get_temp)
>  		thermal_zone_device_set_polling(tz, 0);
>  
> +	thermal_zone_device_reset(tz);
>  	thermal_zone_device_update(tz);
>  
>  	return tz;
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 0531c75..6d9ffa5 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -41,6 +41,7 @@ struct thermal_instance {
>  	struct thermal_zone_device *tz;
>  	struct thermal_cooling_device *cdev;
>  	int trip;
> +	bool initialized;

Given that the problem is about invalid trend, can we use a more
descriptive name here? 'trend_valid' for instance.

I would prefer if we could keep governor specific data isolated.

>  	unsigned long upper;	/* Highest cooling state for this trip point */
>  	unsigned long lower;	/* Lowest cooling state for this trip point */
>  	unsigned long target;	/* expected cooling state */
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 5eac316..8650b0b 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -40,6 +40,9 @@
>  /* No upper/lower limit requirement */
>  #define THERMAL_NO_LIMIT	((u32)~0)
>  
> +/* Invalid/uninitialized temperature */
> +#define THERMAL_TEMP_INVALID	-27400

As mentioned already, you may want to fix the above to represent 0K.
Also please include a comment describing the value for the distracted
reader understand what we mean by 0K. :-)

> +
>  /* Unit conversion macros */
>  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
>  				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

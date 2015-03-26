From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH V2 1/3] Thermal: initialize thermal zone device correctly
Date: Thu, 26 Mar 2015 12:40:53 +0000
Message-ID: <9hh4mp82ap6.fsf@e105922-lin.cambridge.arm.com>
References: <1427269996-29501-1-git-send-email-rui.zhang@intel.com>
	<1427269996-29501-2-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1427269996-29501-2-git-send-email-rui.zhang@intel.com> (Zhang
	Rui's message of "Wed, 25 Mar 2015 15:53:14 +0800")
Sender: stable-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Zhang Rui <rui.zhang@intel.com> writes:

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
> +		} else
> +			next_target = THERMAL_NO_TARGET;
> +	}
> +

Instead of checking whether the instance has been initialised, you could
add THERMAL_TREND_INVALID to the thermal_trend enum. That can then be
handled in the switch case below instead of needing special case
handling like above.

What do you think?

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

[...]

> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
> index 0531c75..6d9ffa5 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -41,6 +41,7 @@ struct thermal_instance {
>  	struct thermal_zone_device *tz;
>  	struct thermal_cooling_device *cdev;
>  	int trip;
> +	bool initialized;
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
> +

Did you mean -274000 (note the missing '0') which is < 0K? A comment
would be helpful for anybody reading the code. Took me a while to parse
it.

>  /* Unit conversion macros */
>  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
>  				((long)t-2732+5)/10 : ((long)t-2732-5)/10)

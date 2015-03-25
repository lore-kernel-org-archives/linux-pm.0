From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 1/3] Thermal: initialize thermal zone device correctly
Date: Wed, 25 Mar 2015 02:14:57 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263014BA954@SHSMSX101.ccr.corp.intel.com>
References: <1427174490-7974-1-git-send-email-rui.zhang@intel.com>
 <1427174490-7974-2-git-send-email-rui.zhang@intel.com>
 <20150324150004.GB29155@developer.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34318 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751851AbbCYCPC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2015 22:15:02 -0400
In-Reply-To: <20150324150004.GB29155@developer.hsd1.ca.comcast.net>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>



> -----Original Message-----
> From: Eduardo Valentin [mailto:edubezval@gmail.com]
> Sent: Tuesday, March 24, 2015 11:00 PM
> To: Zhang, Rui
> Cc: linux-pm@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH 1/3] Thermal: initialize thermal zone device correctly
> Importance: High
> 
> Rui,
> 
> A couple of comments.
> 
> On Tue, Mar 24, 2015 at 01:21:28PM +0800, Zhang Rui wrote:
> > After thermal zone device registered, as we have not read any
> > temperature before, thus tz->temperature should not be 0, which
> > actually means 0C, and thermal trend is not available.
> > In this case, we need specially handling for the first
> > thermal_zone_device_update().
> >
> > Both thermal core framework and step_wise governor is enhanced to handle
> this.
> >
> > CC: <stable@vger.kernel.org> #3.18+
> > Tested-by: Manuel Krause <manuelkrause@netscape.net>
> > Tested-by: szegad <szegadlo@poczta.onet.pl>
> > Tested-by: prash <prash.n.rao@gmail.com>
> > Tested-by: amish <ammdispose-arch@yahoo.com>
> > Tested-by: Matthias <morpheusxyz123@yahoo.de>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/step_wise.c    | 15 +++++++++++++--
> >  drivers/thermal/thermal_core.c | 19 +++++++++++++++++--
> > drivers/thermal/thermal_core.h |  1 +
> >  include/linux/thermal.h        |  3 +++
> >  4 files changed, 34 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> 
> Should this patch also include changes in other governors ?
> 
No, I've checked the code, step_wise/bang_bang/user_space governor does not have this problem.

> > index 5a0f12d..c2bb37c 100644
> > --- a/drivers/thermal/step_wise.c
> > +++ b/drivers/thermal/step_wise.c
> > @@ -63,6 +63,16 @@ static unsigned long get_target_state(struct
> thermal_instance *instance,
> >  	next_target = instance->target;
> >  	dev_dbg(&cdev->device, "cur_state=%ld\n", cur_state);
> >
> > +	if (!instance->initialized) {
> > +		if (throttle) {
> > +			next_target = (cur_state + 1) >= instance->upper ?
> > +					instance->upper :
> > +					((cur_state + 1) < instance->lower ?
> > +					instance->lower : (cur_state + 1));
> 
> Why it makes sense to change the next state if a instance is uninitialized?
> 
For thermal safety reason, I prefer to use a higher cooling state because the system is overheating with current cooling state
I even used to think about using instance->upper directly, but in this case, cooling devices like processors are put into the lowest frequency, and processors on ACPI based platform are put into lowest t-state, which is overkill.

> > +		} else
> > +			next_target = THERMAL_NO_TARGET;
> > +	}
> > +
> >  	switch (trend) {
> >  	case THERMAL_TREND_RAISING:
> >  		if (throttle) {
> > @@ -149,7 +159,8 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
> >  		dev_dbg(&instance->cdev->device, "old_target=%d,
> target=%d\n",
> >  					old_target, (int)instance->target);
> >
> > -		if (old_target == instance->target)
> > +		if (instance->initialized &&
> > +		    old_target == instance->target)
> >  			continue;
> >
> >  		/* Activate a passive thermal instance */ @@ -161,7 +172,7
> @@
> > static void thermal_zone_trip_update(struct thermal_zone_device *tz, int trip)
> >  			instance->target == THERMAL_NO_TARGET)
> >  			update_passive_instance(tz, trip_type, -1);
> >
> > -
> > +		instance->initialized = true;
> >  		instance->cdev->updated = false; /* cdev needs update */
> >  	}
> >
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c index 174d3bc..9d6f71b 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -469,8 +469,22 @@ static void update_temperature(struct
> thermal_zone_device *tz)
> >  	mutex_unlock(&tz->lock);
> >
> >  	trace_thermal_temperature(tz);
> > -	dev_dbg(&tz->device, "last_temperature=%d,
> current_temperature=%d\n",
> > -				tz->last_temperature, tz->temperature);
> > +	if (tz->last_temperature == THERMAL_TEMP_INVALID)
> > +		dev_dbg(&tz->device, "last_temperature N/A,
> current_temperature=%d\n",
> > +			tz->temperature);
> > +	else
> > +		dev_dbg(&tz->device, "last_temperature=%d,
> current_temperature=%d\n",
> > +			tz->last_temperature, tz->temperature);
> 
> Should we also teach the tracing facility about THERMAL_TEMP_INVALID?
> 
Hmm, I don't quite understand your question.

Thanks,
rui
> > +}
> > +
> > +static void thermal_zone_device_reset(struct thermal_zone_device *tz)
> > +{
> > +	struct thermal_instance *pos;
> > +
> > +	tz->temperature = THERMAL_TEMP_INVALID;
> > +	tz->passive = 0;
> > +	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
> > +		pos->initialized = false;
> >  }
> >
> >  void thermal_zone_device_update(struct thermal_zone_device *tz) @@
> > -1574,6 +1588,7 @@ struct thermal_zone_device
> *thermal_zone_device_register(const char *type,
> >  	if (!tz->ops->get_temp)
> >  		thermal_zone_device_set_polling(tz, 0);
> >
> > +	thermal_zone_device_reset(tz);
> >  	thermal_zone_device_update(tz);
> >
> >  	return tz;
> > diff --git a/drivers/thermal/thermal_core.h
> > b/drivers/thermal/thermal_core.h index 0531c75..6d9ffa5 100644
> > --- a/drivers/thermal/thermal_core.h
> > +++ b/drivers/thermal/thermal_core.h
> > @@ -41,6 +41,7 @@ struct thermal_instance {
> >  	struct thermal_zone_device *tz;
> >  	struct thermal_cooling_device *cdev;
> >  	int trip;
> > +	bool initialized;
> >  	unsigned long upper;	/* Highest cooling state for this trip point */
> >  	unsigned long lower;	/* Lowest cooling state for this trip point */
> >  	unsigned long target;	/* expected cooling state */
> > diff --git a/include/linux/thermal.h b/include/linux/thermal.h index
> > 5eac316..8650b0b 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -40,6 +40,9 @@
> >  /* No upper/lower limit requirement */
> >  #define THERMAL_NO_LIMIT	((u32)~0)
> >
> > +/* Invalid/uninitialized temperature */
> > +#define THERMAL_TEMP_INVALID	-27400
> > +
> >  /* Unit conversion macros */
> >  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
> >  				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
> > --
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org More majordomo info
> > at  http://vger.kernel.org/majordomo-info.html

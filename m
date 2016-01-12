From: "Chen, Yu C" <yu.c.chen@intel.com>
Subject: RE: [PATCH 1/3][v3] Thermal: initialize thermal zone device
 correctly
Date: Tue, 12 Jan 2016 06:42:00 +0000
Message-ID: <36DF59CE26D8EE47B0655C516E9CE640286B0B42@shsmsx102.ccr.corp.intel.com>
References: <cover.1446192980.git.yu.c.chen@intel.com>
 <3e6dafce0f659ca2510750f1e03dbba4bc5767c9.1446192980.git.yu.c.chen@intel.com>
 <20151231184344.GB14127@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151231184344.GB14127@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: "javi.merino@arm.com" <javi.merino@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo,
Thanks for your review and sorry for that I missed your email.

> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Eduardo Valentin
> Sent: Friday, January 01, 2016 2:44 AM
> To: Chen, Yu C
> Cc: Zhang, Rui; javi.merino@arm.com; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH 1/3][v3] Thermal: initialize thermal zone device correctly
> 
> For some reason, I thought Rui had picked this already.
> 
> Anyways, here are a couple of comments:
> 
> On Fri, Oct 30, 2015 at 04:31:47PM +0800, Chen Yu wrote:
> > From: Zhang Rui <rui.zhang@intel.com>
> >
> > After thermal zone device registered, as we have not read any
> > temperature before, thus tz->temperature should not be 0, which
> > actually means 0C, and thermal trend is not available.
> > In this case, we need specially handling for the first
> > thermal_zone_device_update().
> >
> > Both thermal core framework and step_wise governor is enhanced to
> > handle this. And since the step_wise governor is the only one that
> > uses trends, so it's the only thermal governor that needs to be
> > updated.
> >
> > CC: <stable@vger.kernel.org> #3.18+
> > Tested-by: Manuel Krause <manuelkrause@netscape.net>
> > Tested-by: szegad <szegadlo@poczta.onet.pl>
> > Tested-by: prash <prash.n.rao@gmail.com>
> > Tested-by: amish <ammdispose-arch@yahoo.com>
> > Tested-by: Matthias <morpheusxyz123@yahoo.de>
> > Reviewed-by: Javi Merino <javi.merino@arm.com>
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/thermal/step_wise.c    | 17 +++++++++++++++--
> >  drivers/thermal/thermal_core.c | 19 +++++++++++++++++--
> > drivers/thermal/thermal_core.h |  1 +
> 
> I would prefer if you could split this patch in two. One for thermal core
> another one for step wise.
[Yu]  It would be better if we can split this patch into two, for stable material.
What do you think, Rui?
> 
> >  include/linux/thermal.h        |  3 +++
> >  4 files changed, 36 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> > index 2f9f708..ea9366a 100644
> > --- a/drivers/thermal/step_wise.c
> > +++ b/drivers/thermal/step_wise.c
> > @@ -63,6 +63,19 @@ static unsigned long get_target_state(struct
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
> > +		} else {
> > +			next_target = THERMAL_NO_TARGET;
> > +		}
> > +
> > +		return next_target;
> > +	}
> > +
> >  	switch (trend) {
> >  	case THERMAL_TREND_RAISING:
> >  		if (throttle) {
> > @@ -149,7 +162,7 @@ static void thermal_zone_trip_update(struct
> thermal_zone_device *tz, int trip)
> >  		dev_dbg(&instance->cdev->device, "old_target=%d,
> target=%d\n",
> >  					old_target, (int)instance->target);
> >
> > -		if (old_target == instance->target)
> > +		if (instance->initialized && old_target == instance->target)
> >  			continue;
> >
> >  		/* Activate a passive thermal instance */ @@ -161,7 +174,7
> @@
> > static void thermal_zone_trip_update(struct thermal_zone_device *tz, int
> trip)
> >  			instance->target == THERMAL_NO_TARGET)
> >  			update_passive_instance(tz, trip_type, -1);
> >
> > -
> > +		instance->initialized = true;
> >  		instance->cdev->updated = false; /* cdev needs update */
> >  	}
> >
> 
> Considering that I understood the problem and your proposal well, I would
> say these changes on step wise are the perfect case for setting up a
> step_wise.bind_to_tz(). bind_to_tz() is already designed as an opportunity
> for governor to check the thermal zone status at the time of binding.
> Remember that moving to bind_to_tz() covers not only registration time, but
> governor switching too (say, user chooses user_space, then step_wise).

[Yu] The  code change in step_wise. get_target_state is mainly for
suspend/resume scenario, which  is not involved with thermal zone/governor bindings IMO.
> 
> The above code seams to be correct, but after reviewing the code of
> step_wise.throttle(), I would say it is already complicated and deserves
> simplification, when possible.
> 
> 
> 
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c index d9e525c..682bc1e 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -532,8 +532,22 @@ static void update_temperature(struct
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
> > +			tz->last_temperature, tz->temperature); }
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
> > -1900,6 +1914,7 @@ struct thermal_zone_device
> > *thermal_zone_device_register(const char *type,
> >
> >  	INIT_DELAYED_WORK(&(tz->poll_queue),
> thermal_zone_device_check);
> >
> > +	thermal_zone_device_reset(tz);
> >  	thermal_zone_device_update(tz);
> >
> >  	return tz;
> > diff --git a/drivers/thermal/thermal_core.h
> > b/drivers/thermal/thermal_core.h index d7ac1fc..749d41a 100644
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
> > 157d366..5bcabc7 100644
> > --- a/include/linux/thermal.h
> > +++ b/include/linux/thermal.h
> > @@ -43,6 +43,9 @@
> >  /* Default weight of a bound cooling device */  #define
> > THERMAL_WEIGHT_DEFAULT 0
> >
> > +/* use value, which < 0K, to indicate an invalid/uninitialized temperature
> */
> > +#define THERMAL_TEMP_INVALID	-274000
> > +
> >  /* Unit conversion macros */
> >  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
> >  				((long)t-2732+5)/10 : ((long)t-2732-5)/10)
> > --
> > 1.8.4.2

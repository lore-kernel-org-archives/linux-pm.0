From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH V2 1/3] Thermal: initialize thermal zone device correctly
Date: Mon, 30 Mar 2015 07:51:12 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263014C92BA@SHSMSX101.ccr.corp.intel.com>
References: <1427269996-29501-1-git-send-email-rui.zhang@intel.com>
	<1427269996-29501-2-git-send-email-rui.zhang@intel.com>
 <9hh4mp82ap6.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5618 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797AbbC3HvS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2015 03:51:18 -0400
In-Reply-To: <9hh4mp82ap6.fsf@e105922-lin.cambridge.arm.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>



> -----Original Message-----
> From: Punit Agrawal [mailto:punit.agrawal@arm.com]
> Sent: Thursday, March 26, 2015 8:41 PM
> To: Zhang, Rui
> Cc: linux-pm@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH V2 1/3] Thermal: initialize thermal zone device correctly
> Importance: High
> 
> Zhang Rui <rui.zhang@intel.com> writes:
> 
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
> > +		} else
> > +			next_target = THERMAL_NO_TARGET;
> > +	}
> > +
> 
> Instead of checking whether the instance has been initialised, you could add
> THERMAL_TREND_INVALID to the thermal_trend enum. That can then be
> handled in the switch case below instead of needing special case handling like
> above.
> 
> What do you think?
> 
Well, that's what I did in my initial proposal, but I found it is not enough.
Say, for the problem fixed in patch 3/3, when a cooling device is registered after
the thermal zone, the thermal trend is not THEMAL_TREND_INVALID, but we need
to get a proper cooling state for the newly registered cooling device.
Thus a per thermal_instance flag is introduced instead.

Thanks,
rui

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
> 
> [...]
> 
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
> 
> Did you mean -274000 (note the missing '0') which is < 0K? A comment would be
> helpful for anybody reading the code. Took me a while to parse it.
> 
> >  /* Unit conversion macros */
> >  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
> >  				((long)t-2732+5)/10 : ((long)t-2732-5)/10)

From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH V2 1/3] Thermal: initialize thermal zone device correctly
Date: Wed, 1 Apr 2015 07:21:22 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B909263014CB2BB@SHSMSX101.ccr.corp.intel.com>
References: <1427269996-29501-1-git-send-email-rui.zhang@intel.com>
	<1427269996-29501-2-git-send-email-rui.zhang@intel.com>
 <9hh4mp82ap6.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <9hh4mp82ap6.fsf@e105922-lin.cambridge.arm.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

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
Oops, I missed this one.
Yes, I want to use -274000 which is < 0K to indicate an invalid/uninitialized temperature.
Updated in patch V4. Thanks for pointing it out.

-rui

> >  /* Unit conversion macros */
> >  #define KELVIN_TO_CELSIUS(t)	(long)(((long)t-2732 >= 0) ?	\
> >  				((long)t-2732+5)/10 : ((long)t-2732-5)/10)

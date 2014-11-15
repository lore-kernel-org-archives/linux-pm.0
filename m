From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] thermal: core: ignore invalid trip temperature
Date: Sat, 15 Nov 2014 09:24:46 -0800
Message-ID: <1416072286.2865.14.camel@spandruv-hsb-test>
References: <1415835809-23376-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20141113102311.64331d60@amdc2363>
	 <1415892544.4581.17.camel@spandruv-hsb-test>
	 <20141114125054.64e93e5b@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63305 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138AbaKORYr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 15 Nov 2014 12:24:47 -0500
In-Reply-To: <20141114125054.64e93e5b@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: linux-pm@vger.kernel.org

On Fri, 2014-11-14 at 12:50 +0100, Lukasz Majewski wrote:
> Hi Srinivas,
> 
> > Hi Lukasz,
> > 
> > Thanks for your review and comment.
> > 
> > On Thu, 2014-11-13 at 10:23 +0100, Lukasz Majewski wrote:
> > > Hi Srinivas,
> > > 
> > > > Ignore invalid trip temperature less or equal to zero. Some
> > > > buggy systems have invalid trips, causing system shutdown.
> > > > 
> > > > Signed-off-by: Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> Acked-by: Zhang Rui
> > > > <rui.zhang@intel.com> ---
> > > >  drivers/thermal/thermal_core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/thermal/thermal_core.c
> > > > b/drivers/thermal/thermal_core.c index 9bf10aa..fbf301a 100644
> > > > --- a/drivers/thermal/thermal_core.c
> > > > +++ b/drivers/thermal/thermal_core.c
> > > > @@ -368,7 +368,7 @@ static void handle_critical_trips(struct
> > > > thermal_zone_device *tz, tz->ops->get_trip_temp(tz, trip,
> > > > &trip_temp); 
> > > >  	/* If we have not crossed the trip_temp, we do not care.
> > > > */
> > > > -	if (tz->temperature < trip_temp)
> > > > +	if (trip_temp <= 0 || tz->temperature < trip_temp)
> > > 
> > > To be honest, I regard this as a feature :-), not bug.
> > 
> > I am not saying bug is in the code, saying buggy system with invalid
> > configuration of critical trip.
> > 
> > > In this way I know that on some systems the regulator for thermal
> > > unit is not enabled (which results in read temp of 0xFF).
> > > 
> > So are you saying that trip temp of <= 0 is a valid trip in your
> > system?
> 
> No. Please find below explanation.
> 
> I have 4 available trip points in my system (e.g. Eynos4/5). The last
> trip point is critical (e.g. 120 C degrees).
So this change will still work for you, since your trip > 0.
> 
> When everything is properly configured (i.e. power supply is provided
> to thermal unit, clocks are setup) and we pass the critical trip point
> then interrupt is triggered and my board is shut down unconditionally by
> internal SoC's power management IP block.
> 
> However, when something is misconfigured, wrong value of temperature is
> read (max possible value - 0xFF) and passed to the driver.
> 
> In such a situation, I see that something is wrong, since I cannot fully
> boot up my system.
> 
> I don't mind the patch, but please pay a note that on some systems
> value of -1 is also expected.
If critical trip is -1, then this change will simply return as no need
to evaluate temp for trip for a given temp change.

I am forwarding this to linux-pm list, let me see if others have a
problem.

Thanks,
Srinivas

> 
> > 
> > Thanks,
> > Srinivas
> > 
> > > I'd prefer to keep this as is.
> > > 
> > > >  		return;
> > > >  
> > > >  	trace_thermal_zone_trip(tz, trip, trip_type);
> > > 
> > > 
> > > 
> > 
> > 
> 
> 
> 



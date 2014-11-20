From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] thermal: core: ignore invalid trip temperature
Date: Thu, 20 Nov 2014 09:13:10 -0800
Message-ID: <1416503590.2043.172.camel@spandruv-desktop.jf.intel.com>
References: <1415835809-23376-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <1416450331.5808.3.camel@rzhang1-toshiba>
	 <20141120112534.7187a21d@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:12116 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664AbaKTRNY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 20 Nov 2014 12:13:24 -0500
In-Reply-To: <20141120112534.7187a21d@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, edubezval@gmail.com, linux-pm@vger.kernel.org

On Thu, 2014-11-20 at 11:25 +0100, Lukasz Majewski wrote: 
> Hi Zhang,
> 
> > 
> > For some reason, I did not see the discussion between Lukasz and you
> > via email. I can only see it via patchwork.
> 
> It is strange. However I'd appreciate to be in CC of this e-mail :-)
> 
> > 
> > Lukasz,
> > 
> > if the regulator for thermal unit is not enabled, what will you get?
> > temperature 0xFF + trip point -1? or Just temperature 0xFF?
> 
> Just 0xFF temperature.
> 
> Since 0xFF is larger than SW_TRIP point (mapped to
> THERMAL_TRIP_CRITICAL), the code at handle_critical_trips() is executed.
> 
> From my standpoint 0xFF is a possible and valid temperature in Exynos.
> 
> Srinivas, what is your error/use case that you need this check?
critical trip point < 0 because buggy FW and temp read is more than trip
temp.

Thanks,
Srinivas 
> 
> > I don't think this patch makes any difference in the second case.
> > 
> > BTW, if you expect some indicator when the thermal unit is not
> > enabled, 
> 
> Actually, the TMU is enabled and configured, 
> Lack of proper regulator (vtmu) for TMU is the culprit of this
> situation.
> 
> > system critical shutdown is not a proper one, we can either
> > check the sysfs I/F, and we can add a warning message here, telling
> > that invalid trip point is found.
> 
> I think that, it would be a good idea to abort Exynos TMU probe when
> "vtmu" regulator is not found.
> 
> > 
> > thanks,
> > rui
> > 
> > On Wed, 2014-11-12 at 15:43 -0800, Srinivas Pandruvada wrote:
> > > Ignore invalid trip temperature less or equal to zero. Some
> > > buggy systems have invalid trips, causing system shutdown.
> > > 
> > > Signed-off-by: Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> Acked-by: Zhang Rui
> > > <rui.zhang@intel.com> ---
> > >  drivers/thermal/thermal_core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/thermal/thermal_core.c
> > > b/drivers/thermal/thermal_core.c index 9bf10aa..fbf301a 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -368,7 +368,7 @@ static void handle_critical_trips(struct
> > > thermal_zone_device *tz, tz->ops->get_trip_temp(tz, trip,
> > > &trip_temp); 
> > >  	/* If we have not crossed the trip_temp, we do not care. */
> > > -	if (tz->temperature < trip_temp)
> > > +	if (trip_temp <= 0 || tz->temperature < trip_temp)
> > >  		return;
> > >  
> > >  	trace_thermal_zone_trip(tz, trip, trip_type);
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> 



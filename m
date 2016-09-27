From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] of: thermal: Fixed governor at each thermal zone
Date: Tue, 27 Sep 2016 12:28:27 +0100
Message-ID: <20160927112827.GB2955@e104805>
References: <1474247932-1026-1-git-send-email-hugh.kang@lge.com>
 <1474940817.4284.0.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474940817.4284.0.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inhyuk Kang <hugh.kang@lge.com>, Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 27, 2016 at 09:46:57AM +0800, Zhang Rui wrote:
> On 一, 2016-09-19 at 10:18 +0900, Inhyuk Kang wrote:
> > It is necessary to be added governor at each thermal_zone.
> > Because some governors should be operated in the during the kernel
> > booting
> > in order to avoid heating problem.
> > 
> > Default governor cannot be covered all thermal zones policy because
> > some thermal zones want to apply different one.
> > For example, the power allocator governor operates differently with
> > step wise governor.
> > Hence, it is better to parse governor parameter from the device tree.
> > 
> > Signed-off-by: Inhyuk Kang <hugh.kang@lge.com>
> > 
> The patch looks okay to me.
> Eduardo, what do you think of this patch?

This has been proposed in the past[0] and Eduardo said no[1] (as did
Krzysztof Kozlowski and Mark Rutland)

[0] https://marc.info/?l=linux-kernel&m=143893141227189&w=4
[1] https://marc.info/?l=linux-pm&m=144649947022547&w=4

Cheers,
Javi

> > diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-
> > thermal.c
> > index b8e509c..382c440 100644
> > --- a/drivers/thermal/of-thermal.c
> > +++ b/drivers/thermal/of-thermal.c
> > @@ -970,6 +970,7 @@ int __init of_parse_thermal_zones(void)
> >  		struct thermal_zone_device *zone;
> >  		struct thermal_zone_params *tzp;
> >  		int i, mask = 0;
> > +		const char *governor;
> >  		u32 prop;
> >  
> >  		tz = thermal_of_build_thermal_zone(child);
> > @@ -996,6 +997,9 @@ int __init of_parse_thermal_zones(void)
> >  		if (!of_property_read_u32(child, "sustainable-
> > power", &prop))
> >  			tzp->sustainable_power = prop;
> >  
> > +		if (!of_property_read_string(child, "governor-name", 
> > &governor))
> > +			strcpy(tzp->governor_name, governor);
> > +
> >  		for (i = 0; i < tz->ntrips; i++)
> >  			mask |= 1 << i;
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

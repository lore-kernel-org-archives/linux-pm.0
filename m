From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] thermal: Default OF created trip points to writable
Date: Wed, 25 Feb 2015 18:36:14 -0800
Message-ID: <1424918174.24754.2.camel@spandruv-mobl2>
References: <1423592506-20620-1-git-send-email-punit.agrawal@arm.com>
	 <20150216151432.GB8648@developer.hsd1.ca.comcast.net>
	 <9hh1tloaj1l.fsf@e105922-lin.cambridge.arm.com>
	 <20150224195201.GB353@developer.amazonguestwifi.org>
	 <1424881442.7759.22.camel@spandruv-DESK3.jf.intel.com>
	 <20150225185223.GG2306@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4037 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267AbbBZCg1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Feb 2015 21:36:27 -0500
In-Reply-To: <20150225185223.GG2306@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org

Hi Eduardo,
On Wed, 2015-02-25 at 14:52 -0400, Eduardo Valentin wrote:
> Srinivas,
> 
> > > 
> > > I am copying Srinivas here too. Srinivas, do you think that option (1)
> > > above will break things in userspace on your side?
> > I am not sure distros like ubuntu starts Linux Thermal Daemon on ARM
> > systems. This has option to take over thermal control from kernel by
> > changing governor to user space. I take writable trips as a way to get
> > threshold temp notification for users space governor by setting offset
> > from a read only passive/active/critical trips. This way we get notified
> > before, to monitor an do proactive control. For example if there is a
> > critical trip at X, take action at X-a to avoid shutdown.
> 
> Let me ask differently. If the trip points are read only, would the
> daemon still work?
Yes.

Thanks,
Srinivas
> 
> If not, the change needs to make writable in x86 builds, right?
> 
> BR,
> 
> > Thanks,
> > Srinivas 
> > > 
> > > > 
> > > > Cheers,
> > > > Punit
> > > > 
> > > > >
> > > > >
> > > > > BR,
> > > > >
> > > > > Eduardo Valentin
> > > > >
> > > > >> 
> > > > >> Comments welcome.
> > > > >> 
> > > > >> Cheers,
> > > > >> Punit
> > > > >> 
> > > > >>  drivers/thermal/of-thermal.c | 6 +++++-
> > > > >>  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > >> 
> > > > >> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> > > > >> index 668fb1b..b7ad5c0 100644
> > > > >> --- a/drivers/thermal/of-thermal.c
> > > > >> +++ b/drivers/thermal/of-thermal.c
> > > > >> @@ -865,6 +865,7 @@ int __init of_parse_thermal_zones(void)
> > > > >>  	for_each_child_of_node(np, child) {
> > > > >>  		struct thermal_zone_device *zone;
> > > > >>  		struct thermal_zone_params *tzp;
> > > > >> +		int i, mask = 0;
> > > > >>  
> > > > >>  		/* Check whether child is enabled or not */
> > > > >>  		if (!of_device_is_available(child))
> > > > >> @@ -891,8 +892,11 @@ int __init of_parse_thermal_zones(void)
> > > > >>  		/* No hwmon because there might be hwmon drivers registering */
> > > > >>  		tzp->no_hwmon = true;
> > > > >>  
> > > > >> +		for (i = 0; i < tz->ntrips; i++)
> > > > >> +			mask |= 1 << i;
> > > > >> +
> > > > >>  		zone = thermal_zone_device_register(child->name, tz->ntrips,
> > > > >> -						    0, tz,
> > > > >> +						    mask, tz,
> > > > >>  						    ops, tzp,
> > > > >>  						    tz->passive_delay,
> > > > >>  						    tz->polling_delay);
> > > > >> -- 
> > > > >> 2.1.4
> > > > >> 
> > 
> > 



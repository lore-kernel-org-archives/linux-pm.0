From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] thermal: Default OF created trip points to writable
Date: Wed, 25 Feb 2015 08:24:02 -0800
Message-ID: <1424881442.7759.22.camel@spandruv-DESK3.jf.intel.com>
References: <1423592506-20620-1-git-send-email-punit.agrawal@arm.com>
	 <20150216151432.GB8648@developer.hsd1.ca.comcast.net>
	 <9hh1tloaj1l.fsf@e105922-lin.cambridge.arm.com>
	 <20150224195201.GB353@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53296 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbbBYQZH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 25 Feb 2015 11:25:07 -0500
In-Reply-To: <20150224195201.GB353@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Punit Agrawal <punit.agrawal@arm.com>, rui.zhang@intel.com, linux-pm@vger.kernel.org

On Tue, 2015-02-24 at 15:52 -0400, Eduardo Valentin wrote: 
> On Tue, Feb 17, 2015 at 11:12:22AM +0000, Punit Agrawal wrote:
> > Eduardo Valentin <edubezval@gmail.com> writes:
> > 
> > > Hey Punit,
> > >
> > > On Tue, Feb 10, 2015 at 06:21:46PM +0000, Punit Agrawal wrote:
> > >> When registering a thermal zone from device tree, default the trip
> > >> points to writable. By default, only the root user can change these.
> > >> 
> > >> This allows the trip points to be tweaked after the system has
> > >> booted.
> > >
> > > Can you please elaborate more on why having default writable makes sense
> > > against having default read only? The purpose of this patch seams to be
> > > targeted to development/debugging systems, not productions systems. The
> > > default has to make sense for production systems.
> > 
> > Agreed about the default making sense for production systems.
> > 
> > We've seen deployments in the field where the default value of the trip
> > temperatures are modulated by a userspace component that has contextual
> > knowledge about workloads and device margins. Using OF for thermal
> > setup, it is not possible to get this functionality.
> > 
> > I guess you are worried about safety - as you still need root privileges
> > to be able to change the trip temperatures so it's not by-passing the
> > security setup of the system.
> > 
> > >
> > >> 
> > >> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> > >> ---
> > >> Hi Eduardo,
> > >> 
> > >> We've been using this patch internally and haven't run into any
> > >>  issues. Without these changes there is no way to change trip points
> > >>  from a running system.
> > >
> > > Ok. I see.
> > >
> > > So, the problem statement here is to be able to change the trip points
> > > from a running system. What is the purpose? Do you have something in
> > > userland that is benefiting of having these trips writable? Or is it
> > > just for development fun?
> > 
> > Sure it helps with development too. In a workflow where the development
> > of the drivers and the tuning are separate activities, and not
> > necessarily done by the same people, it is very helpful to be able to
> > evaluate different parameters for power-performance-thermal tuning
> > without having to rebuild the dtb and reboot the system.
> > 
> > I think it makes it easier for folks to get up and running with OF and
> > thermals. But I'll defer to your judgement here.
> 
> 
> Punit,
> 
> I understand your concerns and thoughts. Let me make a counterproposal.
> Instead of making the trip points populated by of-thermal writable by default,
> how about if we do the following?
> 
> (1) - Change thermal core to have a Kconfig option to allow system
> integrator to choose if trip points are writable or not. So, on top of
> the mask index flags for each trip, the Kconfig must be enabled at
> compilation time. If the Kconfig option is disable, no trip points will
> get write access, regardless the mask provided by the thermal drivers.
> Here, I would prefer to have the default behavior as readonly.

On x86 system the parameters provided through ACPI, shouldn't be
modified, as this voids warranty from manufacturer and will not pass
security review. So they have to be read only. 
> 
> (2) - Change of-thermal to provide writable trip points by default
> (essentially, this present patch).
I understand this change is only for tuning trip point. May be you
should use debugfs to specify +/- offsets from default trip. In one of
my driver I provided debugfs to specify offset from trip for tuning. 
Once tuned the ACPI config can change to reflect correct settings. 
> 
> Al though no changes in this patch are required, I would prefer to merge
> first number (1) above.
> 
> In this way, we allow an option to system engineers that do not want user
> space to mess with their kernel thermal policy. And we also allow people
> who has userspace thermal policy to work properly. And, by grant, we
> have an option to make development easier.
> 
> What is your optionion?
> 
> I am copying Srinivas here too. Srinivas, do you think that option (1)
> above will break things in userspace on your side?
I am not sure distros like ubuntu starts Linux Thermal Daemon on ARM
systems. This has option to take over thermal control from kernel by
changing governor to user space. I take writable trips as a way to get
threshold temp notification for users space governor by setting offset
from a read only passive/active/critical trips. This way we get notified
before, to monitor an do proactive control. For example if there is a
critical trip at X, take action at X-a to avoid shutdown.
Thanks,
Srinivas 
> 
> > 
> > Cheers,
> > Punit
> > 
> > >
> > >
> > > BR,
> > >
> > > Eduardo Valentin
> > >
> > >> 
> > >> Comments welcome.
> > >> 
> > >> Cheers,
> > >> Punit
> > >> 
> > >>  drivers/thermal/of-thermal.c | 6 +++++-
> > >>  1 file changed, 5 insertions(+), 1 deletion(-)
> > >> 
> > >> diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
> > >> index 668fb1b..b7ad5c0 100644
> > >> --- a/drivers/thermal/of-thermal.c
> > >> +++ b/drivers/thermal/of-thermal.c
> > >> @@ -865,6 +865,7 @@ int __init of_parse_thermal_zones(void)
> > >>  	for_each_child_of_node(np, child) {
> > >>  		struct thermal_zone_device *zone;
> > >>  		struct thermal_zone_params *tzp;
> > >> +		int i, mask = 0;
> > >>  
> > >>  		/* Check whether child is enabled or not */
> > >>  		if (!of_device_is_available(child))
> > >> @@ -891,8 +892,11 @@ int __init of_parse_thermal_zones(void)
> > >>  		/* No hwmon because there might be hwmon drivers registering */
> > >>  		tzp->no_hwmon = true;
> > >>  
> > >> +		for (i = 0; i < tz->ntrips; i++)
> > >> +			mask |= 1 << i;
> > >> +
> > >>  		zone = thermal_zone_device_register(child->name, tz->ntrips,
> > >> -						    0, tz,
> > >> +						    mask, tz,
> > >>  						    ops, tzp,
> > >>  						    tz->passive_delay,
> > >>  						    tz->polling_delay);
> > >> -- 
> > >> 2.1.4
> > >> 



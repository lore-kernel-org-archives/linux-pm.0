From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v2 0/7] The power allocator thermal governor
Date: Mon, 2 Mar 2015 16:28:24 +0000
Message-ID: <20150302162824.GB5756@e104805>
References: <1424977233-15965-1-git-send-email-javi.merino@arm.com>
 <20150226221606.GB5564@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47718 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbbCBQ21 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Mar 2015 11:28:27 -0500
Content-Disposition: inline
In-Reply-To: <20150226221606.GB5564@developer.amazonguestwifi.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>, "broonie@kernel.org" <broonie@kernel.org>, "tixy@linaro.org" <tixy@linaro.org>

On Thu, Feb 26, 2015 at 10:16:09PM +0000, Eduardo Valentin wrote:
> On Thu, Feb 26, 2015 at 07:00:26PM +0000, Javi Merino wrote:
> > Hi linux-pm,
> > 
> > The power allocator governor allocates device power to control
> > temperature.  This requires transforming performance requests into
> > requested power, which we do with an extended cooling device API
> > introduced in patch 2 (thermal: extend the cooling device API to
> > include power information).  Patch 3 (thermal: cpu_cooling: implement
> > the power cooling device API) extends the cpu cooling device using a
> > simple power model.
> > 
> > This series are based on branch "linus" of Eduardo's linux-soc-thermal
> > tree:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
> > 
> > Changes since v1:
> >   - Removed a memory leak pointed out by Steve Rostedt
> >   - Relax the constraint of the trip points to be the first and last
> >     passive trip point as Lina Iyer suggested.
> >   - Update how the governor treats weights to mimic the behavior of
> >     fair share in v3 of the weight fixes series.
> >   - Don't cache the cpufreq_cooling_device and scan for it whenever
> >     we need it.
> >   - Consider the rate of changes in the derivative term of the PID
> >     controller
> > 
> > Changes since RFC v6:
> >   - Addressed Eduardo's review
> >     + Pass the interval to the static power function as suggested by
> >       Eduardo
> >     + Make the cooling device ops return 0 or -E* and put the
> >       calculation in a parameter, like the rest of the cooling device
> >       ops
> >     + Documentation improvements
> >   - Use thermal_cdev_update() to change cooling device states
> >   - Add a patch to export the power allocator governor's tzp
> >     parameters to sysfs
> > 
> > Changes since RFC v5:
> >   - Addressed Stephen's review of the trace patches.
> >   - Removed power actors and extended the cooling device interface
> >     instead.
> >   - Let platforms override the power allocator governor parameters in
> >     their thermal zone parameters
> > 
> > Changes since RFC v4:
> >   - Add more tracing
> >   - Document some of the limitations of the power allocator governor
> >   - Export the power_actor API and move power_actor.h to include/linux
> > 
> > Changes since RFC v3:
> >   - Use tz->passive to poll faster when the first trip point is hit.
> >   - Don't make a special directory for power_actors
> >   - Add a DT property for sustainable-power
> >   - Simplify the static power interface and pass the current thermal
> >     zone in every power_actor_ops to remove the controversial
> >     enum power_actor_types
> >   - Use locks with the actor_list list
> >   - Use cpufreq_get() to get the frequency of the cpu instead of
> >     using the notifiers.
> >   - Remove the prompt for THERMAL_POWER_ACTOR_CPU when configuring
> >     the kernel
> > 
> > Changes since RFC v2:
> >   - Changed the PI controller into a PID controller
> >   - Added static power to the cpu power model
> >   - tz parameter max_dissipatable_power renamed to sustainable_power
> >   - Register the cpufreq cooling device as part of the
> >     power_cpu_actor registration.
> > 
> > Changes since RFC v1:
> >   - Fixed finding cpufreq cooling devices in cpufreq_frequency_change()
> >   - Replaced the cooling device interface with a separate power actor
> >     API
> >   - Addressed most of Eduardo's comments
> >   - Incorporated ftrace support for bitmask to trace cpumasks
> > 
> > Cheers,
> > Javi & Punit
> > 
> > Javi Merino (6):
> >   thermal: let governors have private data for each thermal zone
> >   thermal: extend the cooling device API to include power information
> >   thermal: cpu_cooling: implement the power cooling device API
> >   thermal: introduce the Power Allocator governor
> >   thermal: add trace events to the power allocator governor
> >   thermal: export thermal_zone_parameters to sysfs
> 
> I am applying patches 1-3 and 6.

Patch 6 depends on patch 4, as it accesses tzp->sustainable_power
which is introduced in patch 4.  Can you unapply it and keep the
order?

> Patches 4 and 7 need extra effort, but are
> minor changes. Patch 5 depends on 4, so, cannot be applied now.

I'll send a v3 with the minor changes based on your linus branch later
today.

Cheers,
Javi

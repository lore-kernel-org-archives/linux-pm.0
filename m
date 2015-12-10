From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Thu, 10 Dec 2015 14:04:46 +0100
Message-ID: <8633351.YrHIUtRzE5@skinner>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <1536293.WV9n2YBamr@skinner> <1449692513.3240.231.camel@spandruv-desk3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51884 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbbLJNEs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Dec 2015 08:04:48 -0500
In-Reply-To: <1449692513.3240.231.camel@spandruv-desk3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org

On Wednesday, December 09, 2015 12:21:53 PM Srinivas Pandruvada wrote:
> On Wed, 2015-12-09 at 15:34 +0100, Thomas Renninger wrote:
> > On Tuesday, December 08, 2015 10:02:23 AM Srinivas Pandruvada wrote:
> > > On Tue, 2015-12-08 at 16:27 +0100, Thomas Renninger wrote:
> > > > Hi,
> > > > 
> > > > There may be atoms clustered in server platforms and there may be
> > > > performance oriented CPU models built into laptops.
> > > 
> > > You mean BYT/CHT ATOM used as servers not Avaton, which has different
> > > id.
> > 
> > I have no idea.
> > And since Intel does not build mainboards anymore afaik or most
> > are built by OEMs, you also have no idea which CPUs end up on which kind
> > of system, right?
> > 
> > Default policy to go for performance, IO, workload based switching or
> > whatever tunables are modified should be, as you said, platform oriented.
> > 
> > So instead of calling the params:
> > silvermont, airmont, knl_params (knights landing, right?), whatever CPU...
> 
> > Better call them:
> These param structure is much more than just policy specification. They
> have callback to get limits. For example, silvermont and airmont has
> different scaling methods. So they can't be common to all.
Sure this is HW specific.

> The function
> to get next state can be common. There is no airmont/silvermont name
> attached to this (get_target_pstate_use_cpu_load or
> get_target_pstate_use_performance). So the default callback
> ".get_target_pstate" can be changed based on preference.
> 
> This is the order I am thinking of in the order of priority high to
> low :
> - User policy (either command line or via cpu-freq scaling_governor)
> - ACPI
> - Pickup defaults based on CPU ID.

Why by CPU ID? This doesn't make sense to me and unnecessarily complicates
things.

But, please do not submit anything half baken:
a new pstate ondemand governor or different
workload optizmized algorithms inside this governor, or later possibly as
separate governors, defaults based on CPU ID or platform type and
then later userspace tunable...

We should not only think, but implement a final concept and submit altogether.
Otherwise there are several kernels flying around which do implement half
of the implementation and the confusion is perfect.

I would also be interested in some figures.
Are there any measurements how many power is saved, how big the performance
overhead is, etc?

I formerly used the tools/power/cpupower/bench/ tool to find out worst case 
workload scenarios between ondemand and performance governor with different
tuning knobs.
It could even do some nice plots showing performance issues when increasing
polling time, etc., IIRC.
Are these new RAPL registers fine grained enough to be used to measure
power consumption on different workloads with different dynamic cpufreq
algorithms/tunables?

On a platform which exposes itself as "Enterprise Server" or "Performance
Server" (ACPI PM Profile, cmp with chapter 5.2.9 of ACPI spec) I expect 
default will be the current performance governor, which means dynamic CPU 
frequency off and run on high frequency statically, right?

> The current patch-set only addresses the cpu id based selection.
> BTW changing a pid set point can be done from user space without
> changing code.

You mean:
/sys/kernel/debug/pstate_snb/p_gain_pct
/sys/kernel/debug/pstate_snb/setpoint
/sys/kernel/debug/pstate_snb/deadband
/sys/kernel/debug/pstate_snb/i_gain_pct
/sys/kernel/debug/pstate_snb/d_gain_pct
/sys/kernel/debug/pstate_snb/sample_rate_ms

These should better not be picked as API by userspace tools...
 
> > I had a quick look, but providing whole governors seem to be a lot
> > overhead. But with some luck you do not have to fill up whole structures
> > you have to pass to cpufreq_register_governor(..).
> 
> Adding a external governor is easy (Your RFC patch already does that).
> But inside cpufreq core logic there is different processing based on
> whether there are internal governor or cpufreq governor. So that needs
> to be addressed first.

Yep, not sure that is perfect.
I also try to have a closer look.
Quite some open questions...

        Thomas

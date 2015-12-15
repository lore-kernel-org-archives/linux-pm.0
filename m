From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Tue, 15 Dec 2015 15:13:27 +0100
Message-ID: <1462813.tnyS2JedD3@skinner>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <3489712.H9ngXOW7TX@skinner> <3235621.PFgIvoUBvm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58380 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753715AbbLOON3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 15 Dec 2015 09:13:29 -0500
In-Reply-To: <3235621.PFgIvoUBvm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org

On Monday, December 14, 2015 11:06:22 PM Rafael J. Wysocki wrote:
> On Monday, December 14, 2015 05:22:12 PM Thomas Renninger wrote:
> > On Thursday, December 10, 2015 11:01:18 PM Rafael J. Wysocki wrote:
> > > On Thursday, December 10, 2015 02:04:46 PM Thomas Renninger wrote:
> > > > On Wednesday, December 09, 2015 12:21:53 PM Srinivas Pandruvada wrote:

...

> This means that, from intel_pstate perspective and from the point of view of
> finding a useful balance between energy efficiency and performace, it
> doesn't make sense to use a performace-oriented algorithm on them anyway,
> because energy efficiency and performance are not balanced then.

Ok. But this has nothing to do with a specific CPU ID. This is not even
Intel specific.

It is about workload.
If HW specific side-effects as "race-to-idle is an efficient strategy for the 
given CPU" comes into the game... This also is not Intel specific.

My point is:
The cpufreq subsystem nicely splitted out workload policy into governors.
intel_pstate violated this concept by implementing it's own policy into
the HW driver.
We now know that this caused:
- quite some confusion.
- needs userspace to adopt to HW driver specific knobs
- isn't very elegant and rather ungeneric

Now even more different policy algorithms should get mangled into the HW
driver. I do see why you want to do this... It's easy (for now). But I am 
questioning whether this is the right way to go for (on longterm)...

I do not have a final solution at hand. You may want to evaluate the
possibility to move to a governor based solution.
If this is not feasible you should at least write to syslog which algorithm
has been taken and why.

> > And in the end it will show up as an "Enterprise Server" platform where
> > your partners like HP, SAP, Dell,... have to explicitly state to disable
> > specific powersaving features on OS level, because the CPU driver keeps
> > ignoring any BIOS provided information.
> 
> Well, so let's consider the current state of affairs for a while.  Where do
> we take the BIOS-provided information in question into account today?

Are you talking about general BIOS-provided information?
-> There are a hundred places and we cannot boot if BIOS data is
   wrong, right?
For the pm profile I guess none.
I sent patches to expose this to sysfs quite some years ago,
when I realized that OEMs started to not only provide "unknown", but fill it 
with correct data.
Since then it's easy to read out and it was always correct when I double 
checked.

The other point is: It's going to be even more correct and used, when we use 
it. It's a public spec and OEMs have to stick to it and as said 99% should do.

And if not: It's the old game: provide acpi.pm_profile=MyPlatform param.
You/we are not to blame. 
What is much worse is the back and forth to use BIOS provided data.

With acpi_idle BIOS data was used to identify C-states.
All major server vendors provided OS independent documentation how to disable
deep sleep states in BIOS for specific number cruncher or database workloads.

Then Intel violated the specs by switching to intel_idle.

Similar for P-states.
ACPI (acpi-cpufreq) -> MSR (intel_pstate) -> partly ACPI again ?!?
(commit 37afb00032424d684a48d649fc)

So we, Linux kernel, have to rely on some BIOS info to be correct
And the BIOS has to rely on the kernel drivers to use some BIOS info it
provides...
And then both should stick to it...

What I want to say: It's not only the BIOS guys doing things wrong and
in the end you have to trust some interfaces.
 
> The best approach IMO is to use all of the sources of information available
> and make a choice on the basis of all that information combined, but we need
> to start somewhere.
> 
> If your concern is that we are going to discard all of the BIOS-provided
> information going forward, then this is not our current plan.
> 
> Which doesn't prove that it can't be wrong and I've seen enough systems
> where BIOS-provided information is simply incorrect to base any decisions
> on that information alone if I have any other choice.


> 
> > > The BIOS may always lie to us and we can't entirely rely on it for
> > > figuring
> > > out the system profile,
> > 
> > We can. Because otherwise the ACPI pm profile is set "unknown".
> 
> Well, it should be.  It will be if everything is done correctly, but is it
> really guaraneed in any way?
> 
> > BTW: There were rumours that Intel's microcode had some sever bugs as well
> > recently. So what, we have to rely on this piece of software as well...
> > 
> > IMO we see a bit too much CPU ID matching and it's getting more and more.
> > Perfect would be no CPU ID matching at all.
> > We had this with the acpi-cpufreq driver which in the end worked out
> > perfectly for 99% of all machines out there.
> 
> Had it worked perfectly, intel_pstate wouldn't have been introduced.  Simple
> as that.

>From my experience, yes. It worked more or less perfect after years of 
stabilization and improvments. intel_pstate still has to go through this.

> 
> > Hm, apropos id matching... I thought intel_pstate got introduced because
> > the CPUs it supports can switch to any frequency between min and max. And
> > this is not reflected by ACPI which does export a maximum amount of X
> > (10?) frequency states.
> 
> That was one of the factors taken into consideration, but not the only one.
> 
> > Seeing this:
> >         static int silvermont_freq_table[] = {
> >         
> >                 83300, 100000, 133300, 116700, 80000};
> >         
> >         static int airmont_freq_table[] = {
> >         
> >                 83300, 100000, 133300, 116700, 80000,
> >                 93300, 90000, 88900, 87500};
> > 
> > makes me think, whether these shouldn't simply use the acpi_cpufreq
> > driver.
> > Or in the near future we may have tons of such defines?
> > And you are back at "real" governors...
> 
> I'm not sure what you mean here.  These are used for computing a single
> parameter of the algorithm at the initialization time AFAICS.

Ah yes, too quick.

      Thomas

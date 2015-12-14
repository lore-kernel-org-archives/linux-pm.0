From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Mon, 14 Dec 2015 23:06:22 +0100
Message-ID: <3235621.PFgIvoUBvm@vostro.rjw.lan>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <2402797.hEhmBtxRMB@vostro.rjw.lan> <3489712.H9ngXOW7TX@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51416 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932271AbbLNVgQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2015 16:36:16 -0500
In-Reply-To: <3489712.H9ngXOW7TX@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org

On Monday, December 14, 2015 05:22:12 PM Thomas Renninger wrote:
> On Thursday, December 10, 2015 11:01:18 PM Rafael J. Wysocki wrote:
> > On Thursday, December 10, 2015 02:04:46 PM Thomas Renninger wrote:
> > > On Wednesday, December 09, 2015 12:21:53 PM Srinivas Pandruvada wrote:
> > > > On Wed, 2015-12-09 at 15:34 +0100, Thomas Renninger wrote:
> > > > > On Tuesday, December 08, 2015 10:02:23 AM Srinivas Pandruvada wrote:
> > > > > > On Tue, 2015-12-08 at 16:27 +0100, Thomas Renninger wrote:
> > [cut]
> > 
> > > > This is the order I am thinking of in the order of priority high to
> > > > low :
> > > > - User policy (either command line or via cpu-freq scaling_governor)
> > > > - ACPI
> > > > - Pickup defaults based on CPU ID.
> > > 
> > > Why by CPU ID?
> > 
> > For a couple of reasons.
> > 
> > First of all, processors are designed in a specific way and some ways of
> > P-states management may not lead to good results on them no matter what,
> > while others may match them a lot better.
> >
> > The processors in question here are designed with energy efficiency in mind.
> > For this reason, an approach skewed towards performance (which the original
> > algorithm in intel_pstate is) is really suboptimal there as the performance
> > is not there in the first place, quite fundamentally.  Even if anyone used
> > any chip based on those cores in a server, that would be a "low-power
> > server" so to speak, so using an algorithm more oriented towards energy
> > efficiency would still make sense for it.
> 
> Ok, so we have these:
> Desktop processors (Bay Trail-D)
> Server processors (Avoton)
> 
> Are you sure that your partners may not sell these CPUs clustered on servers 
> due to other features on these CPUs (than powersavings), or possibly due to
> simple marketing reasons, because Atom or ARM servers are trendy nowadays.

No I don't, and I've never said I do.

The point here is that even if a bunch of Baytrails is clustered in a server
(which I don't think is extremely likely, as in that case it would make much
more sense to cluster Avotons - or use just one of them for that matter - and
they have a different CPU ID), they still are designed with energy efficiency
rather than with performance in mind.

This means that, from intel_pstate perspective and from the point of view of
finding a useful balance between energy efficiency and performace, it doesn't
make sense to use a performace-oriented algorithm on them anyway, because
energy efficiency and performance are not balanced then.

> And in the end it will show up as an "Enterprise Server" platform where
> your partners like HP, SAP, Dell,... have to explicitly state to disable
> specific powersaving features on OS level, because the CPU driver keeps 
> ignoring any BIOS provided information.

Well, so let's consider the current state of affairs for a while.  Where do
we take the BIOS-provided information in question into account today?

The best approach IMO is to use all of the sources of information available
and make a choice on the basis of all that information combined, but we need
to start somewhere.

If your concern is that we are going to discard all of the BIOS-provided
information going forward, then this is not our current plan.

> > Second, the CPU ID is the most reliable piece of information about the
> > type of the system we can possibly get.
> 
> This is wrong.
> Differing by battery or not is more reliable than any CPU id matching.

Well, not really, because it doesn't tell you, for example, whether or not
race-to-idle is an efficient strategy for the given CPU.  If it is not,
skweing towards performance is likely a bad choice.

> And for the last at least 3 years, I have not seen a system where pm profile
> was set wrong. In our server room I can show you a hundred servers that
> all match the "Enterprise Sever" ACPI profile. Laptops as well.

Which doesn't prove that it can't be wrong and I've seen enough systems where
BIOS-provided information is simply incorrect to base any decisions on that
information alone if I have any other choice.

> > The BIOS may always lie to us and we can't entirely rely on it for figuring
> > out the system profile,
> 
> We can. Because otherwise the ACPI pm profile is set "unknown".

Well, it should be.  It will be if everything is done correctly, but is it
really guaraneed in any way?

> BTW: There were rumours that Intel's microcode had some sever bugs as well
> recently. So what, we have to rely on this piece of software as well...
> 
> IMO we see a bit too much CPU ID matching and it's getting more and more.
> Perfect would be no CPU ID matching at all.
> We had this with the acpi-cpufreq driver which in the end worked out perfectly
> for 99% of all machines out there.

Had it worked perfectly, intel_pstate wouldn't have been introduced.  Simple
as that.

> Hm, apropos id matching... I thought intel_pstate got introduced because the
> CPUs it supports can switch to any frequency between min and max. And this
> is not reflected by ACPI which does export a maximum amount of X (10?) 
> frequency states.

That was one of the factors taken into consideration, but not the only one.

> Seeing this:
>         static int silvermont_freq_table[] = {
>                 83300, 100000, 133300, 116700, 80000};
> 
>         static int airmont_freq_table[] = {
>                 83300, 100000, 133300, 116700, 80000,
>                 93300, 90000, 88900, 87500};
> 
> makes me think, whether these shouldn't simply use the acpi_cpufreq driver.
> Or in the near future we may have tons of such defines?
> And you are back at "real" governors...

I'm not sure what you mean here.  These are used for computing a single parameter
of the algorithm at the initialization time AFAICS.

> 
> > but as I said, if a CPU designed for energy-efficient systems is used in the
> > given one, that is a strong indication on what the system is or it would
> > have used a different CPU otherwise.
> 
> Are you sure? And is this statement in line with your sales and product 
> managers. These guys often tend to think differently than the developers ;)

Well, maybe, but I'm talking from the technical viewpoint only.

And, again, what intel_pstate in its default mode tries to do is to balance
energy efficiency with performance.  In other words, we try to maximize the
performance/power ratio here and quite frankly I find it rather hard to
understand why the same strategy of doing that should be suitable for all
of the processors in the market.  Especially given the known differences
between them.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

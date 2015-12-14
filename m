From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Mon, 14 Dec 2015 17:22:12 +0100
Message-ID: <3489712.H9ngXOW7TX@skinner>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <8633351.YrHIUtRzE5@skinner> <2402797.hEhmBtxRMB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33067 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbbLNQWQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Dec 2015 11:22:16 -0500
In-Reply-To: <2402797.hEhmBtxRMB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org

On Thursday, December 10, 2015 11:01:18 PM Rafael J. Wysocki wrote:
> On Thursday, December 10, 2015 02:04:46 PM Thomas Renninger wrote:
> > On Wednesday, December 09, 2015 12:21:53 PM Srinivas Pandruvada wrote:
> > > On Wed, 2015-12-09 at 15:34 +0100, Thomas Renninger wrote:
> > > > On Tuesday, December 08, 2015 10:02:23 AM Srinivas Pandruvada wrote:
> > > > > On Tue, 2015-12-08 at 16:27 +0100, Thomas Renninger wrote:
> [cut]
> 
> > > This is the order I am thinking of in the order of priority high to
> > > low :
> > > - User policy (either command line or via cpu-freq scaling_governor)
> > > - ACPI
> > > - Pickup defaults based on CPU ID.
> > 
> > Why by CPU ID?
> 
> For a couple of reasons.
> 
> First of all, processors are designed in a specific way and some ways of
> P-states management may not lead to good results on them no matter what,
> while others may match them a lot better.
>
> The processors in question here are designed with energy efficiency in mind.
> For this reason, an approach skewed towards performance (which the original
> algorithm in intel_pstate is) is really suboptimal there as the performance
> is not there in the first place, quite fundamentally.  Even if anyone used
> any chip based on those cores in a server, that would be a "low-power
> server" so to speak, so using an algorithm more oriented towards energy
> efficiency would still make sense for it.

Ok, so we have these:
Desktop processors (Bay Trail-D)
Server processors (Avoton)

Are you sure that your partners may not sell these CPUs clustered on servers 
due to other features on these CPUs (than powersavings), or possibly due to
simple marketing reasons, because Atom or ARM servers are trendy nowadays.

And in the end it will show up as an "Enterprise Server" platform where
your partners like HP, SAP, Dell,... have to explicitly state to disable
specific powersaving features on OS level, because the CPU driver keeps 
ignoring any BIOS provided information.

> Second, the CPU ID is the most reliable piece of information about the
> type of the system we can possibly get.

This is wrong.
Differing by battery or not is more reliable than any CPU id matching.

And for the last at least 3 years, I have not seen a system where pm profile
was set wrong. In our server room I can show you a hundred servers that
all match the "Enterprise Sever" ACPI profile. Laptops as well.

> The BIOS may always lie to us and we can't entirely rely on it for figuring
> out the system profile,

We can. Because otherwise the ACPI pm profile is set "unknown".
BTW: There were rumours that Intel's microcode had some sever bugs as well
recently. So what, we have to rely on this piece of software as well...

IMO we see a bit too much CPU ID matching and it's getting more and more.
Perfect would be no CPU ID matching at all.
We had this with the acpi-cpufreq driver which in the end worked out perfectly
for 99% of all machines out there.

Hm, apropos id matching... I thought intel_pstate got introduced because the
CPUs it supports can switch to any frequency between min and max. And this
is not reflected by ACPI which does export a maximum amount of X (10?) 
frequency states.
Seeing this:
        static int silvermont_freq_table[] = {
                83300, 100000, 133300, 116700, 80000};

        static int airmont_freq_table[] = {
                83300, 100000, 133300, 116700, 80000,
                93300, 90000, 88900, 87500};

makes me think, whether these shouldn't simply use the acpi_cpufreq driver.
Or in the near future we may have tons of such defines?
And you are back at "real" governors...

> but as I said, if a CPU designed for energy-efficient systems is used in the
> given one, that is a strong indication on what the system is or it would
> have used a different CPU otherwise.

Are you sure? And is this statement in line with your sales and product 
managers. These guys often tend to think differently than the developers ;)

    Thomas


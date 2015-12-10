From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V6 1/3] cpufreq: intel_pstate: configurable algorithm to get target pstate
Date: Thu, 10 Dec 2015 23:01:18 +0100
Message-ID: <2402797.hEhmBtxRMB@vostro.rjw.lan>
References: <1449247235-29389-1-git-send-email-philippe.longepe@linux.intel.com> <1449692513.3240.231.camel@spandruv-desk3.jf.intel.com> <8633351.YrHIUtRzE5@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63052 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752928AbbLJVbR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 16:31:17 -0500
In-Reply-To: <8633351.YrHIUtRzE5@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Philippe Longepe <philippe.longepe@linux.intel.com>, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Prarit Bhargava <prarit@redhat.com>, viresh.kumar@linaro.org

On Thursday, December 10, 2015 02:04:46 PM Thomas Renninger wrote:
> On Wednesday, December 09, 2015 12:21:53 PM Srinivas Pandruvada wrote:
> > On Wed, 2015-12-09 at 15:34 +0100, Thomas Renninger wrote:
> > > On Tuesday, December 08, 2015 10:02:23 AM Srinivas Pandruvada wrote:
> > > > On Tue, 2015-12-08 at 16:27 +0100, Thomas Renninger wrote:

[cut]

> > 
> > This is the order I am thinking of in the order of priority high to
> > low :
> > - User policy (either command line or via cpu-freq scaling_governor)
> > - ACPI
> > - Pickup defaults based on CPU ID.
> 
> Why by CPU ID?

For a couple of reasons.

First of all, processors are designed in a specific way and some ways of
P-states management may not lead to good results on them no matter what,
while others may match them a lot better.

The processors in question here are designed with energy efficiency in mind.
For this reason, an approach skewed towards performance (which the original
algorithm in intel_pstate is) is really suboptimal there as the performance
is not there in the first place, quite fundamentally.  Even if anyone used
any chip based on those cores in a server, that would be a "low-power server"
so to speak, so using an algorithm more oriented towards energy efficiency
would still make sense for it.

Second, the CPU ID is the most reliable piece of information about the
type of the system we can possibly get.  The BIOS may always lie to us and
we can't entirely rely on it for figuring out the system profile, but as I
said, if a CPU designed for energy-efficient systems is used in the given
one, that is a strong indication on what the system is or it would have
used a different CPU otherwise.

> This doesn't make sense to me and unnecessarily complicates
> things.
> 
> But, please do not submit anything half baken:
> a new pstate ondemand governor or different
> workload optizmized algorithms inside this governor, or later possibly as
> separate governors, defaults based on CPU ID or platform type and
> then later userspace tunable...
> 
> We should not only think, but implement a final concept and submit altogether.
> Otherwise there are several kernels flying around which do implement half
> of the implementation and the confusion is perfect.

On the other hand, making changes in smaller steps allows us to use a more
evolutionary approach in which changes that turn out to cause problems to
happen may be easily reverted and replaced with something better.

> I would also be interested in some figures.
> Are there any measurements how many power is saved, how big the performance
> overhead is, etc?

Philippe will provide the data.

Thanks,
Rafael


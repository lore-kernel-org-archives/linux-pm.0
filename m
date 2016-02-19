From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Fri, 19 Feb 2016 17:26:04 +0000
Message-ID: <20160219172545.GA27380@e106622-lin>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <2044559.7ypXocW9OZ@vostro.rjw.lan>
 <3499355.2JlaSruvOa@vostro.rjw.lan>
 <16016177.YFqb4gVNBo@vostro.rjw.lan>
 <CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
 <20160219080917.GE22643@pablo>
 <1455900129.7375.231.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:47609 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424899AbcBSRZP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Feb 2016 12:25:15 -0500
Content-Disposition: inline
In-Reply-To: <1455900129.7375.231.camel@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi Srinivas,

On 19/02/16 08:42, Srinivas Pandruvada wrote:
> On Fri, 2016-02-19 at 08:09 +0000, Juri Lelli wrote:
> Hi Juri,
> > >=A0
> > Hi Rafael,
> >=20
> > On 18/02/16 21:22, Rafael J. Wysocki wrote:
> > > On Mon, Feb 15, 2016 at 10:47 PM, Rafael J. Wysocki <rjw@rjwysock=
i.
> > > net> wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >=20
> >=20
> [...]
>=20
> > However, I still don't quite get why we want to introduce an
> > interface
> > for explicit passing of util and max if we are not using such
> > parameters
> > yet. Also, I couldn't find any indication of how such parameters wi=
ll
> > be
> > used in the future. If what we need today is a periodic kick for
> > cpufreq
> > governors that need it, we should simply do how we already do for R=
T
> > and
> > DL, IMHO. Also because the places where the current hooks reside
> > might
> > not be the correct and useful one once we'll start using the
> > utilization
> > parameters. I could probably make a case for DL where we should pla=
ce
> > hooks in admission control path (or somewhere else when more
> > sophisticated mechanisms we'll be in place) rather then in the
> > periodic
> > tick.
> We did experiments using util/max in intel_pstate. For some benchmark=
s
> there were regression of 4 to 5%, for some benchmarks it performed at
> par with getting utilization from the processor. Further optimization
> in the algorithm is possible and still in progress. Idea is that we c=
an
> change P-State fast enough and be more reactive. Once I have good dat=
a,
> I will send to this list. The algorithm can be part of the cpufreq
> governor too.
>=20

Thanks for your answer. What you are experimenting with looks really
interesting and I'm certainly more than interested in looking at your
findings and patches when they will hit the list.

My point was more on what we can look at today, though. Without a clear
understanding about how and where util and max will be used and from
which scheduler paths such information should come from, it is a bit
difficult to tell if the current interface and hooks are fine, IMHO.
I'd suggest we leave this part to the discussion we will have once your
proposal will be public; and to facilitate that we should remove those
arguments from the current interface.

Best,

- Juri

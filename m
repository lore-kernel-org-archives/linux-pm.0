From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Fri, 19 Feb 2016 08:42:09 -0800
Message-ID: <1455900129.7375.231.camel@linux.intel.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	 <2044559.7ypXocW9OZ@vostro.rjw.lan> <3499355.2JlaSruvOa@vostro.rjw.lan>
	 <16016177.YFqb4gVNBo@vostro.rjw.lan>
	 <CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
	 <20160219080917.GE22643@pablo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:3302 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756632AbcBSQng (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 19 Feb 2016 11:43:36 -0500
In-Reply-To: <20160219080917.GE22643@pablo>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Fri, 2016-02-19 at 08:09 +0000, Juri Lelli wrote:
Hi Juri,
> >=C2=A0
> Hi Rafael,
>=20
> On 18/02/16 21:22, Rafael J. Wysocki wrote:
> > On Mon, Feb 15, 2016 at 10:47 PM, Rafael J. Wysocki <rjw@rjwysocki.
> > net> wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >=20
>=20
[...]

> However, I still don't quite get why we want to introduce an
> interface
> for explicit passing of util and max if we are not using such
> parameters
> yet. Also, I couldn't find any indication of how such parameters will
> be
> used in the future. If what we need today is a periodic kick for
> cpufreq
> governors that need it, we should simply do how we already do for RT
> and
> DL, IMHO. Also because the places where the current hooks reside
> might
> not be the correct and useful one once we'll start using the
> utilization
> parameters. I could probably make a case for DL where we should place
> hooks in admission control path (or somewhere else when more
> sophisticated mechanisms we'll be in place) rather then in the
> periodic
> tick.
We did experiments using util/max in intel_pstate. For some benchmarks
there were regression of 4 to 5%, for some benchmarks it performed at
par with getting utilization from the processor. Further optimization
in the algorithm is possible and still in progress. Idea is that we can
change P-State fast enough and be more reactive. Once I have good data,
I will send to this list. The algorithm can be part of the cpufreq
governor too.

Thanks,
Srinivas



From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6/6] cpufreq: schedutil: New governor based on scheduler
 utilization data
Date: Thu, 10 Mar 2016 11:56:14 +0100
Message-ID: <20160310105614.GK6375@twins.programming.kicks-ass.net>
References: <20160308112759.GF6356@twins.programming.kicks-ass.net>
 <CAJZ5v0i+KFmpggrGKqtL_SB1=Fv=b_AbVeL-9jPfo4rYt6-q5A@mail.gmail.com>
 <20160308192640.GD6344@twins.programming.kicks-ass.net>
 <CAJZ5v0g=dXmoPr0jR6AVuynVYbSwJvnS2dFhb7QnUKq9LRRnrQ@mail.gmail.com>
 <20160309163930.GP6356@twins.programming.kicks-ass.net>
 <CAJZ5v0iKn4dT4ta6WaEcPbdYmA7P08=bmKU+dwcMx+Msk7WRFg@mail.gmail.com>
 <CAKfTPtB1g6VgA8NBep553C4MZ19B-rD4Xdp6EpZNAu+mYmx+2w@mail.gmail.com>
 <20160310100728.GT6344@twins.programming.kicks-ass.net>
 <CAKfTPtCbjgbJn+68NJPCnmPFtcHD0wGmZRYaw37zSqPXNpo_Uw@mail.gmail.com>
 <20160310103008.GU6344@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33387 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbcCJK4U (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Mar 2016 05:56:20 -0500
Content-Disposition: inline
In-Reply-To: <20160310103008.GU6344@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Juri Lelli <juri.lelli@arm.com>, mturquette <mturquette@baylibre.com>, Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steve Muckle <steve.muckle@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Mar 10, 2016 at 11:30:08AM +0100, Peter Zijlstra wrote:
> On Thu, Mar 10, 2016 at 05:23:54PM +0700, Vincent Guittot wrote:
> 
> > > No, since its a compile time thing, we can simply do:
> > >
> > > #ifdef arch_scale_freq_capacity
> > >         next_freq = (1 + 1/n) * max_freq * (util / max)
> > > #else
> > >         next_freq = (1 + 1/n) * current_freq * (util_raw / max)
> > > #endif
> > 
> > selecting formula at compilation is clearly better. I wrongly thought that
> > it can't be accepted as a solution.
> 
> Well, its bound to get more 'interesting' since I forse implementations
> not always actually doing the invariant thing.
> 
> Take for example the thing I send:
> 
>   lkml.kernel.org/r/20160303162829.GB6375@twins.programming.kicks-ass.net
> 
> it both shows why you cannot talk about current_freq but also that the
> above needs a little more help (for the !X86_FEATURE_APERFMPERF case).
> 
> But the !arch_scale_freq_capacity case should indeed be that simple.

Maybe something like:

#ifdef arch_scale_freq_capacity
#ifndef arch_scale_freq_invariant
#define arch_scale_freq_invariant()	(true)
#endif
#else /* arch_scale_freq_capacity */
#define arch_scale_freq_invariant()	(false)
#endif

	if (arch_scale_freq_invariant())

And have archs that have conditional arch_scale_freq_capacity()
implementation provide a arch_scale_freq_invariant implementation.

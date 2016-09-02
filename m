From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched: fix incorrect PELT values on SMT
Date: Fri, 2 Sep 2016 10:58:07 +0100
Message-ID: <20160902095805.GD9409@e105550-lin.cambridge.arm.com>
References: <1471571741-19504-1-git-send-email-smuckle@linaro.org>
 <20160819153038.GB25262@e105550-lin.cambridge.arm.com>
 <20160831130720.GE10138@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751660AbcIBJ55 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 2 Sep 2016 05:57:57 -0400
Content-Disposition: inline
In-Reply-To: <20160831130720.GE10138@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

On Wed, Aug 31, 2016 at 03:07:20PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 19, 2016 at 04:30:39PM +0100, Morten Rasmussen wrote:
> > I can't convince myself whether this is the right thing to do. SMT is a
> > bit 'special' and it depends on how you model SMT capacity.
> > 
> > I'm no SMT expert, but the way I understand the current SMT capacity
> > model is that capacity_orig represents the capacity of the SMT-thread
> > when all its thread-siblings are busy.
> 
> Correct. Has a weird side effect if you have >2 siblings and unplug some
> but not symmetric. Rather uncommon case though.
> 
> > The true capacity of an
> > SMT-thread where all thread-siblings are idle is actually 1024, but we
> > don't model this (it would be nightmare to track when the capacity
> > should change). 
> 
> Right, so we have some dynamics in the capacity, but doing things like
> that (and the power7 asymmetric SMT) requires changing the capacity of
> other CPUs, which gets to be real interesting real quick.
> 
> The current dynamics are limited to CPU local things, like having RT
> tasks eat time.
> 
> > The capacity of a core with two or more SMT-threads is
> > chosen to be 1024 + smt_gain, where smt_gain is supposed represent the
> 
> 	(1024 * smt_gain) >> 10

Looking at the code it seems that we just use smt_gain as the core
capacity, so the SMT capacity is simply sd->smt_gain/sd->span_weight,
where sd->smt_gain is initialized to 1178 by default. But it really
doesn't matter ;-)

> > additional throughput we gain for the additional SMT-threads. The reason
> > why we don't have 1024 per thread is that we would prefer to have only
> > one task per core if possible.
> 
> Not really, it stems from the fact that 1024 used (and still might in
> some places) represent 1 (nice-0) task (at 100% utilization).
> 
> And if you have SMT you really don't want to stick 2 tasks on if you can
> do differently. Simply because 2 threads on a core do not get the same
> throughput (in general) as 2 cores do.

Agreed, that is what I failed to communicate above.

> Now, these days SD_PREFER_SIBLING might actually be the main force that
> gets us 1 task per core if possible. We no longer use the capacity stuff
> to compute how many tasks we can run (with exception of
> update_numa_stats it seems).

Okay. I think the load_above_capacity stuff still does that and we tried
to get rid of that a while back. If we can rely on SD_PREFER_SIBLING
alone, it would certainly make things simpler.

> > With util_avg scaling to 1024 a core (capacity = 2*589) would be nearly
> > 'full' with just one always-running task. If we change util_avg to max
> > out at 589, it would take two always-running tasks for the combined
> > utilization to match the core capacity. So we may loose some bias
> > towards spreading for SMT systems.
> 
> Right, so this is always going to be a bit weird, as util numbers shrink
> under load. Therefore they too shrink when you saturate a core with SMT
> threads.

Shouldn't utilization increase, not shrink, if you saturate more SMT
threads? The effective throughput of each SMT thread should reduce when
more threads are saturated so the utilization should go up since
utilization is time-based?

> > AFAICT, group_is_overloaded() and group_has_capacity() would both be
> > affected by this patch.
> > 
> > Interestingly, Vincent recently proposed to set the SMT-thread capacity
> > to 1024 which would affectively make all the current SMT code redundant.
> > It would make things a lot simpler, but I'm not sure if we can get away
> > with it. It would need discussion at least.
> > 
> > Opinions?
> 
> Time I go stare at SMT again I suppose.. :-)

I'm afraid so.

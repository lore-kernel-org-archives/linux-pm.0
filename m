From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: fix incorrect PELT values on SMT
Date: Wed, 31 Aug 2016 15:07:20 +0200
Message-ID: <20160831130720.GE10138@twins.programming.kicks-ass.net>
References: <1471571741-19504-1-git-send-email-smuckle@linaro.org>
 <20160819153038.GB25262@e105550-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160819153038.GB25262@e105550-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 19, 2016 at 04:30:39PM +0100, Morten Rasmussen wrote:
> I can't convince myself whether this is the right thing to do. SMT is a
> bit 'special' and it depends on how you model SMT capacity.
> 
> I'm no SMT expert, but the way I understand the current SMT capacity
> model is that capacity_orig represents the capacity of the SMT-thread
> when all its thread-siblings are busy.

Correct. Has a weird side effect if you have >2 siblings and unplug some
but not symmetric. Rather uncommon case though.

> The true capacity of an
> SMT-thread where all thread-siblings are idle is actually 1024, but we
> don't model this (it would be nightmare to track when the capacity
> should change). 

Right, so we have some dynamics in the capacity, but doing things like
that (and the power7 asymmetric SMT) requires changing the capacity of
other CPUs, which gets to be real interesting real quick.

The current dynamics are limited to CPU local things, like having RT
tasks eat time.

> The capacity of a core with two or more SMT-threads is
> chosen to be 1024 + smt_gain, where smt_gain is supposed represent the

	(1024 * smt_gain) >> 10

> additional throughput we gain for the additional SMT-threads. The reason
> why we don't have 1024 per thread is that we would prefer to have only
> one task per core if possible.

Not really, it stems from the fact that 1024 used (and still might in
some places) represent 1 (nice-0) task (at 100% utilization).

And if you have SMT you really don't want to stick 2 tasks on if you can
do differently. Simply because 2 threads on a core do not get the same
throughput (in general) as 2 cores do.

Now, these days SD_PREFER_SIBLING might actually be the main force that
gets us 1 task per core if possible. We no longer use the capacity stuff
to compute how many tasks we can run (with exception of
update_numa_stats it seems).

> With util_avg scaling to 1024 a core (capacity = 2*589) would be nearly
> 'full' with just one always-running task. If we change util_avg to max
> out at 589, it would take two always-running tasks for the combined
> utilization to match the core capacity. So we may loose some bias
> towards spreading for SMT systems.

Right, so this is always going to be a bit weird, as util numbers shrink
under load. Therefore they too shrink when you saturate a core with SMT
threads.

> AFAICT, group_is_overloaded() and group_has_capacity() would both be
> affected by this patch.
> 
> Interestingly, Vincent recently proposed to set the SMT-thread capacity
> to 1024 which would affectively make all the current SMT code redundant.
> It would make things a lot simpler, but I'm not sure if we can get away
> with it. It would need discussion at least.
> 
> Opinions?

Time I go stare at SMT again I suppose.. :-)

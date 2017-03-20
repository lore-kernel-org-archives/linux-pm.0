From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC][PATCH 2/2] cpufreq: schedutil: Force max frequency on busy
 CPUs
Date: Mon, 20 Mar 2017 14:13:08 +0000
Message-ID: <20170320141308.GD27896@e110439-lin>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <20170320125009.nmi3mvrxappjrvgo@hirez.programming.kicks-ass.net>
 <20170320130615.GC27896@e110439-lin>
 <11131190.KAQLyFuH4P@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11131190.KAQLyFuH4P@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 20-Mar 14:05, Rafael J. Wysocki wrote:
> On Monday, March 20, 2017 01:06:15 PM Patrick Bellasi wrote:
> > On 20-Mar 13:50, Peter Zijlstra wrote:
> > > On Mon, Mar 20, 2017 at 01:35:12PM +0100, Rafael J. Wysocki wrote:
> > > > On Monday, March 20, 2017 11:36:45 AM Peter Zijlstra wrote:
> > > > > On Sun, Mar 19, 2017 at 02:34:32PM +0100, Rafael J. Wysocki wrote:
> > > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > > 
> > > > > > The PELT metric used by the schedutil governor underestimates the
> > > > > > CPU utilization in some cases.  The reason for that may be time spent
> > > > > > in interrupt handlers and similar which is not accounted for by PELT.
> > > > > > 
> > > > > > That can be easily demonstrated by running kernel compilation on
> > > > > > a Sandy Bridge Intel processor, running turbostat in parallel with
> > > > > > it and looking at the values written to the MSR_IA32_PERF_CTL
> > > > > > register.  Namely, the expected result would be that when all CPUs
> > > > > > were 100% busy, all of them would be requested to run in the maximum
> > > > > > P-state, but observation shows that this clearly isn't the case.
> > > > > > The CPUs run in the maximum P-state for a while and then are
> > > > > > requested to run slower and go back to the maximum P-state after
> > > > > > a while again.  That causes the actual frequency of the processor to
> > > > > > visibly oscillate below the sustainable maximum in a jittery fashion
> > > > > > which clearly is not desirable.
> > > > > > 
> > > > > > To work around this issue use the observation that, from the
> > > > > > schedutil governor's perspective, CPUs that are never idle should
> > > > > > always run at the maximum frequency and make that happen.
> > > > > > 
> > > > > > To that end, add a counter of idle calls to struct sugov_cpu and
> > > > > > modify cpuidle_idle_call() to increment that counter every time it
> > > > > > is about to put the given CPU into an idle state.  Next, make the
> > > > > > schedutil governor look at that counter for the current CPU every
> > > > > > time before it is about to start heavy computations.  If the counter
> > > > > > has not changed for over SUGOV_BUSY_THRESHOLD time (equal to 50 ms),
> > > > > > the CPU has not been idle for at least that long and the governor
> > > > > > will choose the maximum frequency for it without looking at the PELT
> > > > > > metric at all.
> > > > > 
> > > > > Why the time limit?
> > > > 
> > > > One iteration appeared to be a bit too aggressive, but honestly I think
> > > > I need to check again if this thing is regarded as viable at all.
> > > > 
> > > 
> > > I don't hate the idea; if we don't hit idle; we shouldn't shift down. I
> > > just wonder if we don't already keep a idle-seqcount somewhere; NOHZ and
> > > RCU come to mind as things that might already use something like that.
> > 
> > Maybe the problem is not going down (e.g. when there are only small
> > CFS tasks it makes perfectly sense) but instead not being fast enough
> > on rampin-up when a new RT task is activated.
> > 
> > And this boils down to two main point:
> > 1) throttling for up transitions perhaps is only harmful
> > 2) the call sites for schedutils updates are not properly positioned
> >    in specific scheduler decision points.
> > 
> > The proposed patch is adding yet another throttling mechanism, perhaps
> > on top of one which already needs to be improved.
> 
> It is not throttling anything.

It's a kind-of...

-       if (flags & SCHED_CPUFREQ_RT_DL) { 
+       if ((flags & SCHED_CPUFREQ_RT_DL) || sugov_cpu_is_busy(sg_cpu)) {
                next_f = policy->cpuinfo.max_freq;

This check disregard any signal the scheduler can provide.

A 60% CFS task with a 100ms period, with such a policy will end up
running at the highest OPP for just 10% of its entire activation.
Moreover, when it completes, we are likely to enter an idle OPP while
still remaining at the highest OPP.

IMHO the ultimate goal of scheduitl should be that to be driven by the
scheduler, which has (or can have) all the required information to
support OPP selection.

If something is not working, well, then we should properly fix the
signals and/or provide (at least) a per-task tunable interface.

Adding an hardcoded threshold is an easy fix but it will ultimately
increase the complexity of the governor.

-- 
#include <best/regards.h>

Patrick Bellasi

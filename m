From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC][PATCH 2/2] cpufreq: schedutil: Force max frequency on busy CPUs
Date: Mon, 20 Mar 2017 13:48:30 +0100
Message-ID: <1796123.TpDRLupsEh@aspire.rjw.lan>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan> <20170320035745.GC25659@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51332 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753318AbdCTM41 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2017 08:56:27 -0400
In-Reply-To: <20170320035745.GC25659@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On Monday, March 20, 2017 09:27:45 AM Viresh Kumar wrote:
> On 19-03-17, 14:34, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The PELT metric used by the schedutil governor underestimates the
> > CPU utilization in some cases.  The reason for that may be time spent
> > in interrupt handlers and similar which is not accounted for by PELT.
> > 
> > That can be easily demonstrated by running kernel compilation on
> > a Sandy Bridge Intel processor, running turbostat in parallel with
> > it and looking at the values written to the MSR_IA32_PERF_CTL
> > register.  Namely, the expected result would be that when all CPUs
> > were 100% busy, all of them would be requested to run in the maximum
> > P-state, but observation shows that this clearly isn't the case.
> > The CPUs run in the maximum P-state for a while and then are
> > requested to run slower and go back to the maximum P-state after
> > a while again.  That causes the actual frequency of the processor to
> > visibly oscillate below the sustainable maximum in a jittery fashion
> > which clearly is not desirable.
> > 
> > To work around this issue use the observation that, from the
> > schedutil governor's perspective, CPUs that are never idle should
> > always run at the maximum frequency and make that happen.
> > 
> > To that end, add a counter of idle calls to struct sugov_cpu and
> > modify cpuidle_idle_call() to increment that counter every time it
> > is about to put the given CPU into an idle state.  Next, make the
> > schedutil governor look at that counter for the current CPU every
> > time before it is about to start heavy computations.  If the counter
> > has not changed for over SUGOV_BUSY_THRESHOLD time (equal to 50 ms),
> > the CPU has not been idle for at least that long and the governor
> > will choose the maximum frequency for it without looking at the PELT
> > metric at all.
> 
> Looks like we are fixing a PELT problem with a schedutil Hack :)

Did you notice the "To work around this issue" phrase above?  This is a
workaround, not a fix.

But it is an optimization too, because avoiding heavy computations if they
are not necessary should be a win in any case.

> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  include/linux/sched/cpufreq.h    |    6 ++++++
> >  kernel/sched/cpufreq_schedutil.c |   38 ++++++++++++++++++++++++++++++++++++--
> >  kernel/sched/idle.c              |    3 +++
> >  3 files changed, 45 insertions(+), 2 deletions(-)
> > 
> > Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> > ===================================================================
> > --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> > +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> > @@ -20,6 +20,7 @@
> >  #include "sched.h"
> >  
> >  #define SUGOV_KTHREAD_PRIORITY	50
> > +#define SUGOV_BUSY_THRESHOLD	(50 * NSEC_PER_MSEC)
> >  
> >  struct sugov_tunables {
> >  	struct gov_attr_set attr_set;
> > @@ -55,6 +56,9 @@ struct sugov_cpu {
> >  
> >  	unsigned long iowait_boost;
> >  	unsigned long iowait_boost_max;
> > +	unsigned long idle_calls;
> > +	unsigned long saved_idle_calls;

The above two could be unsigned int, BTW.

> > +	u64 busy_start;
> >  	u64 last_update;
> >  
> >  	/* The fields below are only needed when sharing a policy. */
> > @@ -192,6 +196,34 @@ static void sugov_iowait_boost(struct su
> >  	sg_cpu->iowait_boost >>= 1;
> >  }
> >  
> > +void cpufreq_schedutil_idle_call(void)
> > +{
> > +	struct sugov_cpu *sg_cpu = this_cpu_ptr(&sugov_cpu);
> > +
> > +	sg_cpu->idle_calls++;
> > +}
> > +
> > +static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
> > +{
> > +	if (sg_cpu->idle_calls != sg_cpu->saved_idle_calls) {
> > +		sg_cpu->busy_start = 0;
> > +		return false;
> > +	}
> > +
> > +	if (!sg_cpu->busy_start) {
> > +		sg_cpu->busy_start = sg_cpu->last_update;
> > +		return false;
> > +	}
> > +
> > +	return sg_cpu->last_update - sg_cpu->busy_start > SUGOV_BUSY_THRESHOLD;
> > +}
> > +
> > +static void sugov_save_idle_calls(struct sugov_cpu *sg_cpu)
> > +{
> > +	if (!sg_cpu->busy_start)
> > +		sg_cpu->saved_idle_calls = sg_cpu->idle_calls;
> 
> Why aren't we doing this in sugov_cpu_is_busy() itself ?

No, we aren't.

sugov_cpu_is_busy() may not be called at all sometimes.

> And isn't it possible for idle_calls to get incremented by this time?

No, it isn't.

The idle loop does that and after it has disabled interrupts.  If this code is
running, we surely are not in there on the same CPU, are we?

> > +}
> > +
> >  static void sugov_update_single(struct update_util_data *hook, u64 time,
> >  				unsigned int flags)
> >  {
> > @@ -207,7 +239,7 @@ static void sugov_update_single(struct u
> >  	if (!sugov_should_update_freq(sg_policy, time))
> >  		return;
> >  
> > -	if (flags & SCHED_CPUFREQ_RT_DL) {
> > +	if ((flags & SCHED_CPUFREQ_RT_DL) || sugov_cpu_is_busy(sg_cpu)) {
> >  		next_f = policy->cpuinfo.max_freq;
> >  	} else {
> >  		sugov_get_util(&util, &max);
> > @@ -215,6 +247,7 @@ static void sugov_update_single(struct u
> >  		next_f = get_next_freq(sg_policy, util, max);
> >  	}
> >  	sugov_update_commit(sg_policy, time, next_f);
> > +	sugov_save_idle_calls(sg_cpu);
> >  }
> >  
> >  static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu)
> > @@ -278,12 +311,13 @@ static void sugov_update_shared(struct u
> >  	sg_cpu->last_update = time;
> >  
> >  	if (sugov_should_update_freq(sg_policy, time)) {
> > -		if (flags & SCHED_CPUFREQ_RT_DL)
> > +		if ((flags & SCHED_CPUFREQ_RT_DL) || sugov_cpu_is_busy(sg_cpu))
> 
> What about others CPUs in this policy?

We'll check this for them when they get updated.

The point is that we can just bail out earlier here and avoid the heavy stuff,
but we don't have to.  This is opportunistic.

> >  			next_f = sg_policy->policy->cpuinfo.max_freq;
> >  		else
> >  			next_f = sugov_next_freq_shared(sg_cpu);
> >  
> >  		sugov_update_commit(sg_policy, time, next_f);
> > +		sugov_save_idle_calls(sg_cpu);
> >  	}
> >  
> >  	raw_spin_unlock(&sg_policy->update_lock);
> 
> 

Thanks,
Rafael

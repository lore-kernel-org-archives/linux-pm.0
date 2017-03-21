From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 11:56:19 +0000
Message-ID: <20170321115619.GC11054@e110439-lin>
References: <4366682.tsferJN35u@aspire.rjw.lan>
 <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan>
 <CAKfTPtB0WpvSz66UNK5HNQF8W-PKCYNyRSCzz9L9WRAKNy+KYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757199AbdCUL43 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Mar 2017 07:56:29 -0400
Content-Disposition: inline
In-Reply-To: <CAKfTPtB0WpvSz66UNK5HNQF8W-PKCYNyRSCzz9L9WRAKNy+KYw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On 21-Mar 09:50, Vincent Guittot wrote:
> On 20 March 2017 at 22:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The way the schedutil governor uses the PELT metric causes it to
> > underestimate the CPU utilization in some cases.
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
> > schedutil governor's perspective, it does not make sense to decrease
> > the frequency of a CPU that doesn't enter idle and avoid decreasing
> > the frequency of busy CPUs.
> 
> I don't fully agree with that statement.
> If there are 2 runnable tasks on CPU A and scheduler migrates the
> waiting task to another CPU B so CPU A is less loaded now, it makes
> sense to reduce the OPP. That's even for that purpose that we have
> decided to use scheduler metrics in cpufreq governor so we can adjust
> OPP immediately when tasks migrate.
> That being said, i probably know why you see such OPP switches in your
> use case. When we migrate a task, we also migrate/remove its
> utilization from CPU.
> If the CPU is not overloaded, it means that runnable tasks have all
> computation that they need and don't have any reason to use more when
> a task migrates to another CPU. so decreasing the OPP makes sense
> because the utilzation is decreasing
> If the CPU is overloaded, it means that runnable tasks have to share
> CPU time and probably don't have all computations that they would like
> so when a task migrate, the remaining tasks on the CPU will increase
> their utilization and fill space left by the task that has just
> migrated. So the CPU's utilization will decrease when a task migrates
> (and as a result the OPP) but then its utilization will increase with
> remaining tasks running more time as well as the OPP
> 
> So you need to make the difference between this 2 cases: Is a CPU
> overloaded or not. You can't really rely on the utilization to detect
> that but you could take advantage of the load which take into account
> the waiting time of tasks

Right, we can use "overloaded" for the time being until we push the
"overutilized" bits.

[...]

> > +#ifdef CONFIG_NO_HZ_COMMON
> > +static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
> > +{
> > +       unsigned long idle_calls = tick_nohz_get_idle_calls();
> > +       bool ret = idle_calls == sg_cpu->saved_idle_calls;

Vincent: are you proposing something like this?

   +     if (this_rq()->rd->overload)
   +             return false;

> > +
> > +       sg_cpu->saved_idle_calls = idle_calls;
> > +       return ret;
> > +}
> > +#else
> > +static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
> > +#endif /* CONFIG_NO_HZ_COMMON */
> > +
> > +static void sugov_update_commit(struct sugov_cpu *sg_cpu,
> > +                               struct sugov_policy *sg_policy,
> > +                               u64 time, unsigned int next_freq)
> >  {
> >         struct cpufreq_policy *policy = sg_policy->policy;
> >
> > +       if (sugov_cpu_is_busy(sg_cpu) && next_freq < sg_policy->next_freq)
> > +               next_freq = sg_policy->next_freq;
> > +
> >         if (policy->fast_switch_enabled) {
> >                 if (sg_policy->next_freq == next_freq) {
> >                         trace_cpu_frequency(policy->cur, smp_processor_id());
> > @@ -214,7 +234,7 @@ static void sugov_update_single(struct u
> >                 sugov_iowait_boost(sg_cpu, &util, &max);
> >                 next_f = get_next_freq(sg_policy, util, max);
> >         }
> > -       sugov_update_commit(sg_policy, time, next_f);
> > +       sugov_update_commit(sg_cpu, sg_policy, time, next_f);
> >  }
> >

[...]

-- 
#include <best/regards.h>

Patrick Bellasi

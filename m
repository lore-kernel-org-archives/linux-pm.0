From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH 2/5] cpufreq: schedutil: support scheduler cpufreq
 callbacks on remote CPUs
Date: Thu, 19 May 2016 11:40:55 -0700
Message-ID: <20160519184055.GD17223@graphite.smuckle.net>
References: <1462828814-32530-1-git-send-email-smuckle@linaro.org>
 <1462828814-32530-3-git-send-email-smuckle@linaro.org>
 <CAJZ5v0jcFNdYMXdaBDaTzyxCaPn9=q2YxUMqziEaprwiOm=5dA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35756 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431AbcESSlA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 14:41:00 -0400
Received: by mail-pf0-f180.google.com with SMTP id b66so11956794pfb.2
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 11:41:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jcFNdYMXdaBDaTzyxCaPn9=q2YxUMqziEaprwiOm=5dA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>

On Thu, May 19, 2016 at 01:24:41AM +0200, Rafael J. Wysocki wrote:
> On Mon, May 9, 2016 at 11:20 PM, Steve Muckle <steve.muckle@linaro.org> wrote:
> > In preparation for the scheduler cpufreq callback happening on remote
> > CPUs, add support for this in schedutil.
> >
> > Schedutil currently requires the callback occur on the CPU being
> > updated in order to support fast frequency switches. Remove this
> > limitation by checking for the current CPU being outside the target
> > CPU's cpufreq policy and if this is the case, enqueuing an irq_work on
> > the target CPU. The irq_work for schedutil is modified to carry out a
> > fast frequency switch if that is enabled for the policy.
> >
> > If the callback occurs on a CPU within the target CPU's policy, the
> > transition is carried out on the local CPU.
> >
> > Signed-off-by: Steve Muckle <smuckle@linaro.org>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 86 ++++++++++++++++++++++++++++++----------
> >  1 file changed, 65 insertions(+), 21 deletions(-)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 154ae3a51e86..c81f9432f520 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -76,27 +76,61 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> >         return delta_ns >= sg_policy->freq_update_delay_ns;
> >  }
> >
> > -static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> > +static void sugov_fast_switch(struct sugov_policy *sg_policy, int cpu,
> > +                             unsigned int next_freq)
> > +{
> > +       struct cpufreq_policy *policy = sg_policy->policy;
> > +
> > +       next_freq = cpufreq_driver_fast_switch(policy, next_freq);
> > +       if (next_freq == CPUFREQ_ENTRY_INVALID)
> > +               return;
> > +
> > +       policy->cur = next_freq;
> > +       trace_cpu_frequency(next_freq, cpu);
> > +}
> > +
> > +#ifdef CONFIG_SMP
> 
> schedutil depends on CONFIG_SMP now, so that's not necessary at least
> for the time being.

Will remove.

> 
> > +static inline bool sugov_queue_remote_callback(struct sugov_policy *sg_policy,
> > +                                        int cpu)
> > +{
> > +       struct cpufreq_policy *policy = sg_policy->policy;
> > +
> > +       if (!cpumask_test_cpu(smp_processor_id(), policy->cpus)) {
> 
> This check is overkill for policies that aren't shared (and we have a
> special case for them already).

I don't see why it is overkill - regardless of whether the policy is
shared, we need to determine whether or not we are running on one of the
CPUs (or in the case of a non-shared policy, the single CPU) within that
policy to know whether we can immediately change the frequency in this
context or a remote call is required.

> > +               sg_policy->work_in_progress = true;
> > +               irq_work_queue_on(&sg_policy->irq_work, cpu);
> > +               return true;
> > +       }
> > +
> > +       return false;
> > +}
> > +#else
> > +static inline bool sugov_queue_remote_callback(struct sugov_policy *sg_policy,
> > +                                        int cpu)
> > +{
> > +       return false;
> > +}
> > +#endif
> > +
> > +static void sugov_update_commit(struct sugov_cpu *sg_cpu, int cpu, u64 time,
> 
> It looks like you might pass hook here instead of the sg_cpu, cpu pair.

I can do that but it means having to do the comtainer_of operation
again. Strictly speaking this seems slightly less efficient than passing
the above values which are already available in the callers.

> 
> >                                 unsigned int next_freq)
> >  {
> > +       struct sugov_policy *sg_policy = sg_cpu->sg_policy;
> >         struct cpufreq_policy *policy = sg_policy->policy;
> >
> >         sg_policy->last_freq_update_time = time;
> >
> > +       if (sg_policy->next_freq == next_freq) {
> > +               trace_cpu_frequency(policy->cur, cpu);
> > +               return;
> > +       }
> 
> There was a reason why I put the above under the fast_switch_enabled
> branch and it was because this check/trace is not necessary otherwise.

I remember asking about this tracepoint earlier. You had said it was
required because powertop would not work without it (reporting the CPU
as idle in certain situations).

I'm not sure why that is only true for the fast switch enabled case but
it seems like an odd inconsistency for the governor to trace unchanged
frequencies when fast switches are enabled but not otherwise. It'd be
useful I think for profiling and tuning if the tracing was consistent.

This behavioral change is admittedly not part of the purpose of the
patch and could be split out if needbe.

thanks,
Steve

From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC][PATCH v2 2/2] cpufreq: schedutil: Avoid decreasing
 frequency of busy CPUs
Date: Tue, 21 Mar 2017 09:50:28 +0100
Message-ID: <CAKfTPtB0WpvSz66UNK5HNQF8W-PKCYNyRSCzz9L9WRAKNy+KYw@mail.gmail.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34765 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932305AbdCUI6R (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Mar 2017 04:58:17 -0400
Received: by mail-oi0-f49.google.com with SMTP id w81so33940497oig.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Mar 2017 01:58:16 -0700 (PDT)
In-Reply-To: <3300960.HE4b3sK4dn@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>

On 20 March 2017 at 22:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The way the schedutil governor uses the PELT metric causes it to
> underestimate the CPU utilization in some cases.
>
> That can be easily demonstrated by running kernel compilation on
> a Sandy Bridge Intel processor, running turbostat in parallel with
> it and looking at the values written to the MSR_IA32_PERF_CTL
> register.  Namely, the expected result would be that when all CPUs
> were 100% busy, all of them would be requested to run in the maximum
> P-state, but observation shows that this clearly isn't the case.
> The CPUs run in the maximum P-state for a while and then are
> requested to run slower and go back to the maximum P-state after
> a while again.  That causes the actual frequency of the processor to
> visibly oscillate below the sustainable maximum in a jittery fashion
> which clearly is not desirable.
>
> To work around this issue use the observation that, from the
> schedutil governor's perspective, it does not make sense to decrease
> the frequency of a CPU that doesn't enter idle and avoid decreasing
> the frequency of busy CPUs.

I don't fully agree with that statement.
If there are 2 runnable tasks on CPU A and scheduler migrates the
waiting task to another CPU B so CPU A is less loaded now, it makes
sense to reduce the OPP. That's even for that purpose that we have
decided to use scheduler metrics in cpufreq governor so we can adjust
OPP immediately when tasks migrate.
That being said, i probably know why you see such OPP switches in your
use case. When we migrate a task, we also migrate/remove its
utilization from CPU.
If the CPU is not overloaded, it means that runnable tasks have all
computation that they need and don't have any reason to use more when
a task migrates to another CPU. so decreasing the OPP makes sense
because the utilzation is decreasing
If the CPU is overloaded, it means that runnable tasks have to share
CPU time and probably don't have all computations that they would like
so when a task migrate, the remaining tasks on the CPU will increase
their utilization and fill space left by the task that has just
migrated. So the CPU's utilization will decrease when a task migrates
(and as a result the OPP) but then its utilization will increase with
remaining tasks running more time as well as the OPP

So you need to make the difference between this 2 cases: Is a CPU
overloaded or not. You can't really rely on the utilization to detect
that but you could take advantage of the load which take into account
the waiting time of tasks

Vincent
>
> To that end, use the counter of idle calls in the timekeeping code.
> Namely, make the schedutil governor look at that counter for the
> current CPU every time before it is about to set a new frequency
> for that CPU's policy.  If the counter has not changed since the
> previous iteration, the CPU has been busy for all that time and
> its frequency should not be decreased, so if the new frequency would
> be lower than the one set previously, the governor will skip the
> frequency update.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> This is a slightly different approach (avoid decreasing frequency for busy CPUs
> instead of bumping if for them to the max upfront) and it works around the
> original problem too.
>
> I tried to address a few Peter's comments here and the result doesn't seem to
> be too heavy-wieght.
>
> Thanks,
> Rafael
>
> ---
>  include/linux/tick.h             |    1 +
>  kernel/sched/cpufreq_schedutil.c |   28 ++++++++++++++++++++++++----
>  kernel/time/tick-sched.c         |   12 ++++++++++++
>  3 files changed, 37 insertions(+), 4 deletions(-)
>
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -56,6 +56,9 @@ struct sugov_cpu {
>         unsigned long iowait_boost;
>         unsigned long iowait_boost_max;
>         u64 last_update;
> +#ifdef CONFIG_NO_HZ_COMMON
> +       unsigned long saved_idle_calls;
> +#endif
>
>         /* The fields below are only needed when sharing a policy. */
>         unsigned long util;
> @@ -88,11 +91,28 @@ static bool sugov_should_update_freq(str
>         return delta_ns >= sg_policy->freq_update_delay_ns;
>  }
>
> -static void sugov_update_commit(struct sugov_policy *sg_policy, u64 time,
> -                               unsigned int next_freq)
> +#ifdef CONFIG_NO_HZ_COMMON
> +static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
> +{
> +       unsigned long idle_calls = tick_nohz_get_idle_calls();
> +       bool ret = idle_calls == sg_cpu->saved_idle_calls;
> +
> +       sg_cpu->saved_idle_calls = idle_calls;
> +       return ret;
> +}
> +#else
> +static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
> +#endif /* CONFIG_NO_HZ_COMMON */
> +
> +static void sugov_update_commit(struct sugov_cpu *sg_cpu,
> +                               struct sugov_policy *sg_policy,
> +                               u64 time, unsigned int next_freq)
>  {
>         struct cpufreq_policy *policy = sg_policy->policy;
>
> +       if (sugov_cpu_is_busy(sg_cpu) && next_freq < sg_policy->next_freq)
> +               next_freq = sg_policy->next_freq;
> +
>         if (policy->fast_switch_enabled) {
>                 if (sg_policy->next_freq == next_freq) {
>                         trace_cpu_frequency(policy->cur, smp_processor_id());
> @@ -214,7 +234,7 @@ static void sugov_update_single(struct u
>                 sugov_iowait_boost(sg_cpu, &util, &max);
>                 next_f = get_next_freq(sg_policy, util, max);
>         }
> -       sugov_update_commit(sg_policy, time, next_f);
> +       sugov_update_commit(sg_cpu, sg_policy, time, next_f);
>  }
>
>  static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu)
> @@ -283,7 +303,7 @@ static void sugov_update_shared(struct u
>                 else
>                         next_f = sugov_next_freq_shared(sg_cpu);
>
> -               sugov_update_commit(sg_policy, time, next_f);
> +               sugov_update_commit(sg_cpu, sg_policy, time, next_f);
>         }
>
>         raw_spin_unlock(&sg_policy->update_lock);
> Index: linux-pm/include/linux/tick.h
> ===================================================================
> --- linux-pm.orig/include/linux/tick.h
> +++ linux-pm/include/linux/tick.h
> @@ -117,6 +117,7 @@ extern void tick_nohz_idle_enter(void);
>  extern void tick_nohz_idle_exit(void);
>  extern void tick_nohz_irq_exit(void);
>  extern ktime_t tick_nohz_get_sleep_length(void);
> +extern unsigned long tick_nohz_get_idle_calls(void);
>  extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
>  extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
>  #else /* !CONFIG_NO_HZ_COMMON */
> Index: linux-pm/kernel/time/tick-sched.c
> ===================================================================
> --- linux-pm.orig/kernel/time/tick-sched.c
> +++ linux-pm/kernel/time/tick-sched.c
> @@ -993,6 +993,18 @@ ktime_t tick_nohz_get_sleep_length(void)
>         return ts->sleep_length;
>  }
>
> +/**
> + * tick_nohz_get_idle_calls - return the current idle calls counter value
> + *
> + * Called from the schedutil frequency scaling governor in scheduler context.
> + */
> +unsigned long tick_nohz_get_idle_calls(void)
> +{
> +       struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +       return ts->idle_calls;
> +}
> +
>  static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
>  {
>  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
>

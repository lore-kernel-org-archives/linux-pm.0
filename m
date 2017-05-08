From: Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [RFC][PATCH v3 2/2] cpufreq: schedutil: Avoid reducing frequency
 of busy CPUs prematurely
Date: Mon, 8 May 2017 11:49:48 +0800
Message-ID: <CANRm+Cwem_C6geyWScZhr4A62ben9fKhyL2OPd+Vdhh3bRJqKw@mail.gmail.com>
References: <4366682.tsferJN35u@aspire.rjw.lan> <2185243.flNrap3qq1@aspire.rjw.lan>
 <3300960.HE4b3sK4dn@aspire.rjw.lan> <2997922.DidfPadJuT@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33377 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbdEHDtt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 May 2017 23:49:49 -0400
In-Reply-To: <2997922.DidfPadJuT@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

Hi Rafael,
2017-03-22 7:08 GMT+08:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
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
> That has been attributed to CPU utilization metric updates on task
> migration that cause the total utilization value for the CPU to be
> reduced by the utilization of the migrated task.  If that happens,
> the schedutil governor may see a CPU utilization reduction and will
> attempt to reduce the CPU frequency accordingly right away.  That
> may be premature, though, for example if the system is generally
> busy and there are other runnable tasks waiting to be run on that
> CPU already.
>
> This is unlikely to be an issue on systems where cpufreq policies are
> shared between multiple CPUs, because in those cases the policy
> utilization is computed as the maximum of the CPU utilization values

Sorry for one question maybe not associated with this patch. If the
cpufreq policy is shared between multiple CPUs, the function
intel_cpufreq_target()  just updates IA32_PERF_CTL MSR of the cpu
which is managing this policy, I wonder whether other cpus which are
affected should also update their per-logical cpu's IA32_PERF_CTL MSR?

Regards,
Wanpeng Li

> over the whole policy and if that turns out to be low, reducing the
> frequency for the policy most likely is a good idea anyway.  On
> systems with one CPU per policy, however, it may affect performance
> adversely and even lead to increased energy consumption in some cases.
>
> On those systems it may be addressed by taking another utilization
> metric into consideration, like whether or not the CPU whose
> frequency is about to be reduced has been idle recently, because if
> that's not the case, the CPU is likely to be busy in the near future
> and its frequency should not be reduced.
>
> To that end, use the counter of idle calls in the timekeeping code.
> Namely, make the schedutil governor look at that counter for the
> current CPU every time before its frequency is about to be reduced.
> If the counter has not changed since the previous iteration of the
> governor computations for that CPU, the CPU has been busy for all
> that time and its frequency should not be decreased, so if the new
> frequency would be lower than the one set previously, the governor
> will skip the frequency update.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  include/linux/tick.h             |    1 +
>  kernel/sched/cpufreq_schedutil.c |   27 +++++++++++++++++++++++++++
>  kernel/time/tick-sched.c         |   12 ++++++++++++
>  3 files changed, 40 insertions(+)
>
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -61,6 +61,11 @@ struct sugov_cpu {
>         unsigned long util;
>         unsigned long max;
>         unsigned int flags;
> +
> +       /* The field below is for single-CPU policies only. */
> +#ifdef CONFIG_NO_HZ_COMMON
> +       unsigned long saved_idle_calls;
> +#endif
>  };
>
>  static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
> @@ -192,6 +197,19 @@ static void sugov_iowait_boost(struct su
>         sg_cpu->iowait_boost >>= 1;
>  }
>
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
>  static void sugov_update_single(struct update_util_data *hook, u64 time,
>                                 unsigned int flags)
>  {
> @@ -200,6 +218,7 @@ static void sugov_update_single(struct u
>         struct cpufreq_policy *policy = sg_policy->policy;
>         unsigned long util, max;
>         unsigned int next_f;
> +       bool busy;
>
>         sugov_set_iowait_boost(sg_cpu, time, flags);
>         sg_cpu->last_update = time;
> @@ -207,12 +226,20 @@ static void sugov_update_single(struct u
>         if (!sugov_should_update_freq(sg_policy, time))
>                 return;
>
> +       busy = sugov_cpu_is_busy(sg_cpu);
> +
>         if (flags & SCHED_CPUFREQ_RT_DL) {
>                 next_f = policy->cpuinfo.max_freq;
>         } else {
>                 sugov_get_util(&util, &max);
>                 sugov_iowait_boost(sg_cpu, &util, &max);
>                 next_f = get_next_freq(sg_policy, util, max);
> +               /*
> +                * Do not reduce the frequency if the CPU has not been idle
> +                * recently, as the reduction is likely to be premature then.
> +                */
> +               if (busy && next_f < sg_policy->next_freq)
> +                       next_f = sg_policy->next_freq;
>         }
>         sugov_update_commit(sg_policy, time, next_f);
>  }
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

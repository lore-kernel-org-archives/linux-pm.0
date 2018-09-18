From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 02/14] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
Date: Tue, 18 Sep 2018 23:33:22 +0200
Message-ID: <CAJZ5v0gL+NurA8UcN5oweqwxfgS10HgO1Zjh_cod4_Sr5nWQHQ@mail.gmail.com>
References: <20180912091309.7551-1-quentin.perret@arm.com> <20180912091309.7551-3-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180912091309.7551-3-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org, Saravana Kannan <skann>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 12, 2018 at 11:14 AM Quentin Perret <quentin.perret@arm.com> wrote:
>
> Schedutil requests frequency by aggregating utilization signals from
> the scheduler (CFS, RT, DL, IRQ) and applying and 25% margin on top of
> them. Since Energy Aware Scheduling (EAS) needs to be able to predict
> the frequency requests, it needs to forecast the decisions made by the
> governor.
>
> In order to prepare the introduction of EAS, introduce
> schedutil_freq_util() to centralize the aforementioned signal
> aggregation and make it available to both schedutil and EAS. Since
> frequency selection and energy estimation still need to deal with RT and
> DL signals slightly differently, schedutil_freq_util() is called with a
> different 'type' parameter in those two contexts, and returns an
> aggregated utilization signal accordingly. While at it, introduce the
> map_util_freq() function which is designed to make schedutil's 25%
> margin usable easily for both sugov and EAS.
>
> As EAS will be able to predict schedutil's frequency requests more
> accurately than any other governor by design, it'd be sensible to make
> sure EAS cannot be used without schedutil. This will be done later, once
> EAS has actually been introduced.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Quentin Perret <quentin.perret@arm.com>

While the overall idea is fine by me, I would do a couple of things
differently (see below).

> ---
>  include/linux/sched/cpufreq.h    |  6 +++
>  kernel/sched/cpufreq_schedutil.c | 89 +++++++++++++++++++++-----------
>  kernel/sched/sched.h             | 14 +++++
>  3 files changed, 80 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
> index 59667444669f..afa940cd50dc 100644
> --- a/include/linux/sched/cpufreq.h
> +++ b/include/linux/sched/cpufreq.h
> @@ -20,6 +20,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
>                         void (*func)(struct update_util_data *data, u64 time,
>                                     unsigned int flags));
>  void cpufreq_remove_update_util_hook(int cpu);
> +
> +static inline unsigned long map_util_freq(unsigned long util,
> +                                       unsigned long freq, unsigned long cap)
> +{
> +       return (freq + (freq >> 2)) * util / cap;
> +}
>  #endif /* CONFIG_CPU_FREQ */
>
>  #endif /* _LINUX_SCHED_CPUFREQ_H */
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 3fffad3bc8a8..8356cb0072a6 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -13,6 +13,7 @@
>
>  #include "sched.h"
>
> +#include <linux/sched/cpufreq.h>
>  #include <trace/events/power.h>
>
>  struct sugov_tunables {
> @@ -167,7 +168,7 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         unsigned int freq = arch_scale_freq_invariant() ?
>                                 policy->cpuinfo.max_freq : policy->cur;
>
> -       freq = (freq + (freq >> 2)) * util / max;
> +       freq = map_util_freq(util, freq, max);
>
>         if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
>                 return sg_policy->next_freq;
> @@ -197,15 +198,15 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>   * based on the task model parameters and gives the minimal utilization
>   * required to meet deadlines.
>   */
> -static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> +unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
> +                                 enum schedutil_type type)

The new "type" argument should be documented.

Also IMO using the special enum for it is quite confusing, because you
ever only check one value from it directly.  What would be wrong with
using a plain "bool" instead?

>  {
> -       struct rq *rq = cpu_rq(sg_cpu->cpu);
> +       struct rq *rq = cpu_rq(cpu);
>         unsigned long util, irq, max;
>
> -       sg_cpu->max = max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> -       sg_cpu->bw_dl = cpu_bw_dl(rq);
> +       max = arch_scale_cpu_capacity(NULL, cpu);
>
> -       if (rt_rq_is_runnable(&rq->rt))
> +       if (type == FREQUENCY_UTIL && rt_rq_is_runnable(&rq->rt))
>                 return max;
>
>         /*
> @@ -223,20 +224,33 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>          * utilization (PELT windows are synchronized) we can directly add them
>          * to obtain the CPU's actual utilization.
>          */
> -       util = cpu_util_cfs(rq);
> +       util = util_cfs;
>         util += cpu_util_rt(rq);
>
> -       /*
> -        * We do not make cpu_util_dl() a permanent part of this sum because we
> -        * want to use cpu_bw_dl() later on, but we need to check if the
> -        * CFS+RT+DL sum is saturated (ie. no idle time) such that we select
> -        * f_max when there is no idle time.
> -        *
> -        * NOTE: numerical errors or stop class might cause us to not quite hit
> -        * saturation when we should -- something for later.
> -        */
> -       if ((util + cpu_util_dl(rq)) >= max)
> -               return max;
> +       if (type == FREQUENCY_UTIL) {
> +               /*
> +                * For frequency selection we do not make cpu_util_dl() a
> +                * permanent part of this sum because we want to use
> +                * cpu_bw_dl() later on, but we need to check if the
> +                * CFS+RT+DL sum is saturated (ie. no idle time) such
> +                * that we select f_max when there is no idle time.
> +                *
> +                * NOTE: numerical errors or stop class might cause us
> +                * to not quite hit saturation when we should --
> +                * something for later.
> +                */
> +
> +               if ((util + cpu_util_dl(rq)) >= max)
> +                       return max;
> +       } else {
> +               /*
> +                * OTOH, for energy computation we need the estimated
> +                * running time, so include util_dl and ignore dl_bw.
> +                */
> +               util += cpu_util_dl(rq);
> +               if (util >= max)
> +                       return max;
> +       }
>
>         /*
>          * There is still idle time; further improve the number by using the
> @@ -250,17 +264,34 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
>         util = scale_irq_capacity(util, irq, max);
>         util += irq;
>
> -       /*
> -        * Bandwidth required by DEADLINE must always be granted while, for
> -        * FAIR and RT, we use blocked utilization of IDLE CPUs as a mechanism
> -        * to gracefully reduce the frequency when no tasks show up for longer
> -        * periods of time.
> -        *
> -        * Ideally we would like to set bw_dl as min/guaranteed freq and util +
> -        * bw_dl as requested freq. However, cpufreq is not yet ready for such
> -        * an interface. So, we only do the latter for now.
> -        */
> -       return min(max, util + sg_cpu->bw_dl);
> +       if (type == FREQUENCY_UTIL) {
> +               /*
> +                * Bandwidth required by DEADLINE must always be granted
> +                * while, for FAIR and RT, we use blocked utilization of
> +                * IDLE CPUs as a mechanism to gracefully reduce the
> +                * frequency when no tasks show up for longer periods of
> +                * time.
> +                *
> +                * Ideally we would like to set bw_dl as min/guaranteed
> +                * freq and util + bw_dl as requested freq. However,
> +                * cpufreq is not yet ready for such an interface. So,
> +                * we only do the latter for now.
> +                */
> +               util += cpu_bw_dl(rq);
> +       }
> +
> +       return min(max, util);
> +}
> +
> +static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
> +{
> +       struct rq *rq = cpu_rq(sg_cpu->cpu);
> +       unsigned long util = cpu_util_cfs(rq);
> +
> +       sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
> +       sg_cpu->bw_dl = cpu_bw_dl(rq);
> +
> +       return schedutil_freq_util(sg_cpu->cpu, util, FREQUENCY_UTIL);

If you add a "max" argument to schedutil_freq_util(), you can avoid
the second (and arguably redundant) evaluation of
arch_scale_cpu_capacity() in there.

>  }
>
>  /**
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 481e6759441b..d59effb34786 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2172,7 +2172,15 @@ static inline void cpufreq_update_util(struct rq *rq, unsigned int flags) {}
>  # define arch_scale_freq_invariant()   false
>  #endif
>
> +enum schedutil_type {
> +       FREQUENCY_UTIL,
> +       ENERGY_UTIL,
> +};

As I said above, I would just use "bool" instead of this new enum (it
has two values too) or the new type needs to be documented.

> +
>  #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> +unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
> +                                 enum schedutil_type type);
> +
>  static inline unsigned long cpu_bw_dl(struct rq *rq)
>  {
>         return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >> BW_SHIFT;
> @@ -2199,6 +2207,12 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
>  {
>         return READ_ONCE(rq->avg_rt.util_avg);
>  }
> +#else /* CONFIG_CPU_FREQ_GOV_SCHEDUTIL */
> +static inline unsigned long schedutil_freq_util(int cpu, unsigned long util,
> +                                 enum schedutil_type type)
> +{
> +       return util;
> +}
>  #endif

And I would add a wrapper around schedutil_freq_util(), called say
schedutil_energy_util(), that would pass a specific value as the
"type".

>
>  #ifdef HAVE_SCHED_AVG_IRQ
> --

Cheers,
Rafael

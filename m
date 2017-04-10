From: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC/RFT][PATCH 2/2] cpufreq: schedutil: Utilization aggregation
Date: Sun, 9 Apr 2017 23:39:31 -0700
Message-ID: <CAJWu+orhpeirhB1u-KTOBjWTQoTEJdStR3BP14WxkB=RZP49sg@mail.gmail.com>
References: <3498238.liCqOyIkGA@aspire.rjw.lan> <2242635.g1ACnTm5vK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2242635.g1ACnTm5vK@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Sun, Apr 9, 2017 at 5:11 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Due to the limitation of the rate of frequency changes the schedutil
> governor only estimates the CPU utilization entirely when it is about
> to update the frequency for the corresponding cpufreq policy.  As a
> result, the intermediate utilization values are discarded by it,
> but that is not appropriate in general (like, for example, when
> tasks migrate from one CPU to another or exit, in which cases the
> utilization measured by PELT may change abruptly between frequency
> updates).
>
> For this reason, modify schedutil to estimate CPU utilization
> completely whenever it is invoked for the given CPU and store the
> maximum encountered value of it as input for subsequent new frequency
> computations.  This way the new frequency is always based on the
> maximum utilization value seen by the governor after the previous
> frequency update which effectively prevents intermittent utilization
> variations from causing it to be reduced unnecessarily.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  kernel/sched/cpufreq_schedutil.c |   90 +++++++++++++++++++++------------------
>  1 file changed, 50 insertions(+), 40 deletions(-)
>
> Index: linux-pm/kernel/sched/cpufreq_schedutil.c
> ===================================================================
> --- linux-pm.orig/kernel/sched/cpufreq_schedutil.c
> +++ linux-pm/kernel/sched/cpufreq_schedutil.c
> @@ -57,7 +57,6 @@ struct sugov_cpu {
>         unsigned long iowait_boost_max;
>         u64 last_update;
>
> -       /* The fields below are only needed when sharing a policy. */
>         unsigned long util;
>         unsigned long max;
>         unsigned int flags;
> @@ -154,22 +153,30 @@ static unsigned int get_next_freq(struct
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
>
> -static void sugov_get_util(unsigned long *util, unsigned long *max)
> +static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned int flags)
>  {
> +       unsigned long cfs_util, cfs_max;
>         struct rq *rq = this_rq();
> -       unsigned long cfs_max;
>
> -       cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +       sg_cpu->flags |= flags & SCHED_CPUFREQ_RT_DL;
> +       if (sg_cpu->flags & SCHED_CPUFREQ_RT_DL)
> +               return;
>
> -       *util = min(rq->cfs.avg.util_avg, cfs_max);
> -       *max = cfs_max;
> +       cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +       cfs_util = min(rq->cfs.avg.util_avg, cfs_max);
> +       if (sg_cpu->util * cfs_max < sg_cpu->max * cfs_util) {

Assuming all CPUs have equal compute capacity, doesn't this mean that
sg_cpu->util is updated only if cfs_util > sg_cpu->util?

Maybe I missed something, but wouldn't we want sg_cpu->util to be
reduced as well when cfs_util reduces? Doesn't this condition
basically discard all updates to sg_cpu->util that could have reduced
it?

> +               sg_cpu->util = cfs_util;
> +               sg_cpu->max = cfs_max;
> +       }
>  }

Thanks,
Joel

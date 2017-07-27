From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [Eas-dev] [PATCH V4 2/3] cpufreq: schedutil: Process remote
 callback for shared policies
Date: Wed, 26 Jul 2017 22:49:34 -0700
Message-ID: <CAEi0qNmWDQpbj6NjS+fbX1krc9-QEa7LujWydjy8eaeczJxSCg@mail.gmail.com>
References: <cover.1501060871.git.viresh.kumar@linaro.org> <d3e7bcbd5c87690b8d7607f92763081a4416af9c.1501060871.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38129 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdG0Ftg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jul 2017 01:49:36 -0400
In-Reply-To: <d3e7bcbd5c87690b8d7607f92763081a4416af9c.1501060871.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, smuckle.linux@gmail.com, eas-dev@lists.linaro.org, Joel Fernandes <joelaf@google.com>

On Wed, Jul 26, 2017 at 2:22 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> This patch updates the schedutil governor to process cpufreq utilization
> update hooks called for remote CPUs where the remote CPU is managed by
> the cpufreq policy of the local CPU.
>
> Based on initial work from Steve Muckle.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Joel Fernandes <joelaf@google.com>


thanks,

-Joel


> ---
>  kernel/sched/cpufreq_schedutil.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index bb834747e49b..c3baf70d360c 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -72,13 +72,12 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>
>  /************************ Governor internals ***********************/
>
> -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
> -                                    int target_cpu)
> +static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
>  {
>         s64 delta_ns;
>
> -       /* Don't allow remote callbacks */
> -       if (smp_processor_id() != target_cpu)
> +       /* Allow remote callbacks only on the CPUs sharing cpufreq policy */
> +       if (!cpumask_test_cpu(smp_processor_id(), sg_policy->policy->cpus))
>                 return false;
>
>         if (sg_policy->work_in_progress)
> @@ -159,12 +158,12 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
>         return cpufreq_driver_resolve_freq(policy, freq);
>  }
>
> -static void sugov_get_util(unsigned long *util, unsigned long *max)
> +static void sugov_get_util(unsigned long *util, unsigned long *max, int cpu)
>  {
> -       struct rq *rq = this_rq();
> +       struct rq *rq = cpu_rq(cpu);
>         unsigned long cfs_max;
>
> -       cfs_max = arch_scale_cpu_capacity(NULL, smp_processor_id());
> +       cfs_max = arch_scale_cpu_capacity(NULL, cpu);
>
>         *util = min(rq->cfs.avg.util_avg, cfs_max);
>         *max = cfs_max;
> @@ -226,7 +225,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>         sugov_set_iowait_boost(sg_cpu, time, flags);
>         sg_cpu->last_update = time;
>
> -       if (!sugov_should_update_freq(sg_policy, time, hook->cpu))
> +       if (!sugov_should_update_freq(sg_policy, time))
>                 return;
>
>         busy = sugov_cpu_is_busy(sg_cpu);
> @@ -234,7 +233,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>         if (flags & SCHED_CPUFREQ_RT_DL) {
>                 next_f = policy->cpuinfo.max_freq;
>         } else {
> -               sugov_get_util(&util, &max);
> +               sugov_get_util(&util, &max, hook->cpu);
>                 sugov_iowait_boost(sg_cpu, &util, &max);
>                 next_f = get_next_freq(sg_policy, util, max);
>                 /*
> @@ -295,7 +294,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>         unsigned long util, max;
>         unsigned int next_f;
>
> -       sugov_get_util(&util, &max);
> +       sugov_get_util(&util, &max, hook->cpu);
>
>         raw_spin_lock(&sg_policy->update_lock);
>
> @@ -306,7 +305,7 @@ static void sugov_update_shared(struct update_util_data *hook, u64 time,
>         sugov_set_iowait_boost(sg_cpu, time, flags);
>         sg_cpu->last_update = time;
>
> -       if (sugov_should_update_freq(sg_policy, time, hook->cpu)) {
> +       if (sugov_should_update_freq(sg_policy, time)) {
>                 if (flags & SCHED_CPUFREQ_RT_DL)
>                         next_f = sg_policy->policy->cpuinfo.max_freq;

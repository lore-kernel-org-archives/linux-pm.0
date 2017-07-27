From: "Joel Fernandes (Google)" <joel.opensrc@gmail.com>
Subject: Re: [Eas-dev] [PATCH V4 1/3] sched: cpufreq: Allow remote cpufreq callbacks
Date: Wed, 26 Jul 2017 22:34:58 -0700
Message-ID: <CAEi0qN=ipk9SR+3DYcLk-5SoKnsfK=PQV62VH9KAoXz2PDRkjQ@mail.gmail.com>
References: <cover.1501060871.git.viresh.kumar@linaro.org> <8797d4993baa6580e3af741d081be492032ce9dd.1501060871.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8797d4993baa6580e3af741d081be492032ce9dd.1501060871.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, smuckle.linux@gmail.com, eas-dev@lists.linaro.org, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On Wed, Jul 26, 2017 at 2:22 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> We do not call cpufreq callbacks from scheduler core for remote
> (non-local) CPUs currently. But there are cases where such remote
> callbacks are useful, specially in the case of shared cpufreq policies.
>
> This patch updates the scheduler core to call the cpufreq callbacks for
> remote CPUs as well.
>
> For now, all the registered utilization update callbacks are updated to
> return early if remote callback is detected. That is, this patch just
> moves the decision making down in the hierarchy.
>
> Later patches would enable remote callbacks for shared policies.
>
> Based on initial work from Steve Muckle.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
<snip>
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -72,10 +72,15 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
>
>  /************************ Governor internals ***********************/
>
> -static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
> +static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time,
> +                                    int target_cpu)
>  {
>         s64 delta_ns;
>
> +       /* Don't allow remote callbacks */
> +       if (smp_processor_id() != target_cpu)
> +               return false;
> +
>         if (sg_policy->work_in_progress)
>                 return false;
>
> @@ -221,7 +226,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
>         sugov_set_iowait_boost(sg_cpu, time, flags);
>         sg_cpu->last_update = time;
>
> -       if (!sugov_should_update_freq(sg_policy, time))
> +       if (!sugov_should_update_freq(sg_policy, time, hook->cpu))
>                 return;

Since with the remote callbacks now possible, isn't it unsafe to
modify sg_cpu and sg_policy structures without a lock in
sugov_update_single?

Unlike sugov_update_shared, we don't acquire any lock in
sugov_update_single before updating these structures. Did I miss
something?


thanks,

-Joel

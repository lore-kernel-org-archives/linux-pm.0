From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [RFCv5 PATCH 41/46] sched/fair: add triggers for OPP change requests
Date: Wed, 08 Jul 2015 08:42:15 -0700
Message-ID: <20150708154215.9112.98060@quantum>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-42-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436293469-25707-42-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>, peterz@infradead.org, mingo@redhat.com
Cc: vincent.guittot@linaro.org, daniel.lezcano@linaro.org, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, yuyang.du@intel.com, rjw@rjwysocki.net, Juri Lelli <Juri.Lelli@arm.com>, sgurrappadi@nvidia.com, pang.xunlei@zte.com.cn, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Juri,

Quoting Morten Rasmussen (2015-07-07 11:24:24)
> From: Juri Lelli <juri.lelli@arm.com>
> 
> Each time a task is {en,de}queued we might need to adapt the current
> frequency to the new usage. Add triggers on {en,de}queue_task_fair() for
> this purpose.  Only trigger a freq request if we are effectively waking up
> or going to sleep.  Filter out load balancing related calls to reduce the
> number of triggers.
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> ---
>  kernel/sched/fair.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f74e9d2..b8627c6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4281,7 +4281,10 @@ static inline void hrtick_update(struct rq *rq)
>  }
>  #endif
>  
> +static unsigned int capacity_margin = 1280; /* ~20% margin */

This is a 25% margin. Calling it ~20% is a bit misleading :)

Should margin be scaled for cpus that do not have max capacity == 1024?
In other words, should margin be dynamically calculated to be 20% of
*this* cpu's max capacity?

I'm imagining a corner case where a heterogeneous cpu system is set up
in such a way that adding margin that is hard-coded to 25% of 1024
almost always puts req_cap to the highest frequency, skipping some
reasonable capacity states in between.

> +
>  static bool cpu_overutilized(int cpu);
> +static unsigned long get_cpu_usage(int cpu);
>  struct static_key __sched_energy_freq __read_mostly = STATIC_KEY_INIT_FALSE;
>  
>  /*
> @@ -4332,6 +4335,26 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 if (!task_new && !rq->rd->overutilized &&
>                     cpu_overutilized(rq->cpu))
>                         rq->rd->overutilized = true;
> +               /*
> +                * We want to trigger a freq switch request only for tasks that
> +                * are waking up; this is because we get here also during
> +                * load balancing, but in these cases it seems wise to trigger
> +                * as single request after load balancing is done.
> +                *
> +                * XXX: how about fork()? Do we need a special flag/something
> +                *      to tell if we are here after a fork() (wakeup_task_new)?
> +                *
> +                * Also, we add a margin (same ~20% used for the tipping point)
> +                * to our request to provide some head room if p's utilization
> +                * further increases.
> +                */
> +               if (sched_energy_freq() && !task_new) {
> +                       unsigned long req_cap = get_cpu_usage(cpu_of(rq));
> +
> +                       req_cap = req_cap * capacity_margin
> +                                       >> SCHED_CAPACITY_SHIFT;

Probably a dumb question:

Can we "cheat" here and just assume that capacity and load use the same
units? That would avoid the multiplication and change your code to the
following:

	#define capacity_margin SCHED_CAPACITY_SCALE >> 2; /* 25% */
	req_cap += SCHED_CAPACITY_SCALE;

> +                       cpufreq_sched_set_cap(cpu_of(rq), req_cap);
> +               }
>         }
>         hrtick_update(rq);
>  }
> @@ -4393,6 +4416,23 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>         if (!se) {
>                 sub_nr_running(rq, 1);
>                 update_rq_runnable_avg(rq, 1);
> +               /*
> +                * We want to trigger a freq switch request only for tasks that
> +                * are going to sleep; this is because we get here also during
> +                * load balancing, but in these cases it seems wise to trigger
> +                * as single request after load balancing is done.
> +                *
> +                * Also, we add a margin (same ~20% used for the tipping point)
> +                * to our request to provide some head room if p's utilization
> +                * further increases.
> +                */
> +               if (sched_energy_freq() && task_sleep) {
> +                       unsigned long req_cap = get_cpu_usage(cpu_of(rq));
> +
> +                       req_cap = req_cap * capacity_margin
> +                                       >> SCHED_CAPACITY_SHIFT;
> +                       cpufreq_sched_set_cap(cpu_of(rq), req_cap);

Filtering out the load_balance bits is neat.

Regards,
Mike

> +               }
>         }
>         hrtick_update(rq);
>  }
> @@ -4959,8 +4999,6 @@ static int find_new_capacity(struct energy_env *eenv,
>         return idx;
>  }
>  
> -static unsigned int capacity_margin = 1280; /* ~20% margin */
> -
>  static bool cpu_overutilized(int cpu)
>  {
>         return (capacity_of(cpu) * 1024) <
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

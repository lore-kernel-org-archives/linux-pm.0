From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv5 PATCH 41/46] sched/fair: add triggers for OPP change requests
Date: Tue, 4 Aug 2015 15:41:34 +0200
Message-ID: <CAKfTPtBfNV=K+gwb7dfQXqBEbByMWRoFDb0FtfeeY1hh33j4XA@mail.gmail.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-42-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:33382 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756289AbbHDNl4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 09:41:56 -0400
Received: by lady2 with SMTP id y2so3602892lad.0
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 06:41:54 -0700 (PDT)
In-Reply-To: <1436293469-25707-42-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Yuyang Du <yuyang.du@intel.com>, Michael Turquette <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, Sai Charan Gurrappadi <sgurrappadi@nvidia.com>, pang.xunlei@zte.com.cn, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Juri,

On 7 July 2015 at 20:24, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
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

Could you clarify why you want to trig a freq switch for tasks that
are going to sleep ?
The cpu_usage should not changed that much as the se_utilization of
the entity moves from utilization_load_avg to utilization_blocked_avg
of the rq and the usage and the freq are updated periodically.
It should be the same for the wake up of a task in enqueue_task_fair
above, even if it's less obvious for this latter use case because the
cpu might wake up from a long idle phase during which its
utilization_blocked_avg has not been updated. Nevertheless, a trig of
the freq switch at wake up of the cpu once its usage has been updated
should do the job.

So tick, migration of tasks, new tasks, entering/leaving idle state of
cpu should be enough to trig freq switch

Regards,
Vincent


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

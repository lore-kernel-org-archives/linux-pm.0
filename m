From: Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 07/12] sched/core: uclamp: enforce last task UCLAMP_MAX
Date: Fri, 20 Jul 2018 18:23:57 -0700
Message-ID: <CAJuCfpH6CsDVG35Z3NV87mUgJW9TmoCuOs8GeW2TEqkP0K0f9g@mail.gmail.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com> <20180716082906.6061-8-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716082906.6061-8-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Patrick,

On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> When a util_max clamped task sleeps, its clamp constraints are removed
> from the CPU. However, the blocked utilization on that CPU can still be
> higher than the max clamp value enforced while that task was running.
> This max clamp removal when a CPU is going to be idle could thus allow
> unwanted CPU frequency increases, right while the task is not running.
>
> This can happen, for example, where there is another (smaller) task
> running on a different CPU of the same frequency domain.
> In this case, when we aggregates the utilization of all the CPUs in a

typo: we aggregate

> shared frequency domain, schedutil can still see the full non clamped
> blocked utilization of all the CPUs and thus eventually increase the
> frequency.
>
> Let's fix this by using:
>
>    uclamp_cpu_put_id(UCLAMP_MAX)
>       uclamp_cpu_update(last_clamp_value)
>
> to detect when a CPU has no more RUNNABLE clamped tasks and to flag this
> condition. Thus, while a CPU is idle, we can still enforce the last used
> clamp value for it.
>
> To the contrary, we do not track any UCLAMP_MIN since, while a CPU is
> idle, we don't want to enforce any minimum frequency
> Indeed, we relay just on blocked load decay to smoothly reduce the

typo: We rely

> frequency.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  kernel/sched/core.c  | 30 ++++++++++++++++++++++++++----
>  kernel/sched/sched.h |  2 ++
>  2 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b2424eea7990..0cb6e0aa4faa 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -930,7 +930,8 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
>   * For the specified clamp index, this method computes the new CPU utilization
>   * clamp to use until the next change on the set of RUNNABLE tasks on that CPU.
>   */
> -static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
> +static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
> +                                    unsigned int last_clamp_value)
>  {
>         struct uclamp_group *uc_grp = &rq->uclamp.group[clamp_id][0];
>         int max_value = UCLAMP_NONE;
> @@ -948,6 +949,19 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
>                 if (max_value >= SCHED_CAPACITY_SCALE)
>                         break;
>         }
> +
> +       /*
> +        * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
> +        * task, we keep the CPU clamped to the last task's clamp value.
> +        * This avoids frequency spikes to MAX when one CPU, with an high
> +        * blocked utilization, sleeps and another CPU, in the same frequency
> +        * domain, do not see anymore the clamp on the first CPU.
> +        */
> +       if (clamp_id == UCLAMP_MAX && max_value == UCLAMP_NONE) {
> +               rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
> +               max_value = last_clamp_value;
> +       }
> +
>         rq->uclamp.value[clamp_id] = max_value;
>  }
>
> @@ -977,13 +991,21 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
>         uc_grp = &rq->uclamp.group[clamp_id][0];
>         uc_grp[group_id].tasks += 1;
>
> +       /* Force clamp update on idle exit */
> +       uc_cpu = &rq->uclamp;
> +       clamp_value = p->uclamp[clamp_id].value;
> +       if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {

The condition below is not needed because UCLAMP_FLAG_IDLE is set only
for UCLAMP_MAX clamp_id, therefore the above condition already covers
the one below.

> +               if (clamp_id == UCLAMP_MAX)
> +                       uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;
> +               uc_cpu->value[clamp_id] = clamp_value;
> +               return;
> +       }
> +
>         /*
>          * If this is the new max utilization clamp value, then we can update
>          * straight away the CPU clamp value. Otherwise, the current CPU clamp
>          * value is still valid and we are done.
>          */
> -       uc_cpu = &rq->uclamp;
> -       clamp_value = p->uclamp[clamp_id].value;
>         if (uc_cpu->value[clamp_id] < clamp_value)
>                 uc_cpu->value[clamp_id] = clamp_value;
>  }
> @@ -1028,7 +1050,7 @@ static inline void uclamp_cpu_put_id(struct task_struct *p,
>         uc_cpu = &rq->uclamp;
>         clamp_value = uc_grp[group_id].value;
>         if (clamp_value >= uc_cpu->value[clamp_id])
> -               uclamp_cpu_update(rq, clamp_id);
> +               uclamp_cpu_update(rq, clamp_id, clamp_value);
>  }
>
>  /**
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1207add36478..7e4f10c507b7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -783,6 +783,8 @@ struct uclamp_group {
>   * values, i.e. no min/max clamping at all.
>   */
>  struct uclamp_cpu {
> +#define UCLAMP_FLAG_IDLE 0x01
> +       int flags;
>         int value[UCLAMP_CNT];
>         struct uclamp_group group[UCLAMP_CNT][CONFIG_UCLAMP_GROUPS_COUNT + 1];
>  };
> --
> 2.17.1
>

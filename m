From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v3 4/6] sched/rt: fast switch to maximum frequency when RT
 tasks are scheduled
Date: Wed, 6 Dec 2017 10:39:52 +0100
Message-ID: <CAKfTPtCoUVoxhG5mem9fcf30VoQBUCMZr-CLkFVoKRMHr_=btQ@mail.gmail.com>
References: <20171130114723.29210-1-patrick.bellasi@arm.com> <20171130114723.29210-5-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130114723.29210-5-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>
List-Id: linux-pm@vger.kernel.org

Hi Patrick,

On 30 November 2017 at 12:47, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> Currently schedutil updates are triggered for the RT class using a single
> call place, which is part of the rt::update_curr_rt() used in:
>
> - dequeue_task_rt:
>   but it does not make sense to set the schedutil's SCHED_CPUFREQ_RT in
>   case the next task should not be an RT one
>
> - put_prev_task_rt:
>   likewise, we set the SCHED_CPUFREQ_RT flag without knowing if required
>   by the next task
>
> - pick_next_task_rt:
>   likewise, the schedutil's SCHED_CPUFREQ_RT is set in case the prev task
>   was RT, while we don't yet know if the next will be RT
>
> - task_tick_rt:
>   that's the only really useful call, which can ramp up the frequency in
>   case a RT task started its execution without a chance to order a
>   frequency switch (e.g. because of the schedutil ratelimit)
>
> Apart from the last call in task_tick_rt, the others are at least useless.
> Thus, although being a simple solution, not all the call sites of that
> update_curr_rt() are interesting to trigger a frequency switch as well as
> some of the most interesting points are not covered by that call.
> For example, a task set to RT has to wait the next tick to get the
> frequency boost.
>
> This patch fixes these issues by placing explicitly the schedutils
> update calls in the only sensible places, which are:
> - when an RT task wakes up and it's enqueued in a CPU
> - when we actually pick a RT task for execution
> - at each tick time
> - when a task is set to be RT
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
>
> ---
> Changes from v2:
> - rebased on v4.15-rc1
> - use cpufreq_update_util() instead of cpufreq_update_this_cpu()
>
> Change-Id: I3794615819270fe175cb118eef3f7edd61f602ba
> ---
>  kernel/sched/rt.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4056c19ca3f0..6984032598a6 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -959,9 +959,6 @@ static void update_curr_rt(struct rq *rq)
>         if (unlikely((s64)delta_exec <= 0))
>                 return;
>
> -       /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> -       cpufreq_update_util(rq, SCHED_CPUFREQ_RT);
> -
>         schedstat_set(curr->se.statistics.exec_max,
>                       max(curr->se.statistics.exec_max, delta_exec));
>
> @@ -1327,6 +1324,9 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
>
>         if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
>                 enqueue_pushable_task(rq, p);
> +
> +       /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> +       cpufreq_update_util(rq, SCHED_CPUFREQ_RT);
>  }
>
>  static void dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
> @@ -1564,6 +1564,9 @@ pick_next_task_rt(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>
>         p = _pick_next_task_rt(rq);
>
> +       /* Kick cpufreq (see the comment in kernel/sched/sched.h). */

p is null when there is no rt task to pick.
You should test this condition before calling cpufreq_update_util

> +       cpufreq_update_util(rq, SCHED_CPUFREQ_RT);
> +
>         /* The running task is never eligible for pushing */
>         dequeue_pushable_task(rq, p);
>
> @@ -2282,6 +2285,9 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
>  {
>         struct sched_rt_entity *rt_se = &p->rt;
>
> +       /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> +       cpufreq_update_util(rq, SCHED_CPUFREQ_RT);
> +
>         update_curr_rt(rq);
>
>         watchdog(rq, p);
> @@ -2317,6 +2323,9 @@ static void set_curr_task_rt(struct rq *rq)
>
>         p->se.exec_start = rq_clock_task(rq);
>
> +       /* Kick cpufreq (see the comment in kernel/sched/sched.h). */
> +       cpufreq_update_util(rq, SCHED_CPUFREQ_RT);

Is this change linked to the "- when a task is set to be RT" in the
commit message ?

I can't see a situation where this is call without the previous one.
AFAICT, enqueue_task_rt will be called before each call to this
function

> +
>         /* The running task is never eligible for pushing */
>         dequeue_pushable_task(rq, p);
>  }
> --
> 2.14.1
>

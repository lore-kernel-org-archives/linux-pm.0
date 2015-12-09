From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in scale_rt_capacity
Date: Wed, 9 Dec 2015 09:50:27 +0100
Message-ID: <CAKfTPtCV4d=1nSDcU8J4x=MF7HmuyRxKr-4XiYAxPZYPKd1okA@mail.gmail.com>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org> <1449641971-20827-10-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35716 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbbLIIus (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 03:50:48 -0500
Received: by lfdl133 with SMTP id l133so29267781lfd.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2015 00:50:47 -0800 (PST)
In-Reply-To: <1449641971-20827-10-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>, Luca Abeni <luca.abeni@unitn.it>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

adding Lucas

On 9 December 2015 at 07:19, Steve Muckle <steve.muckle@linaro.org> wrote:
> From: Vincent Guittot <vincent.guittot@linaro.org>
>
> Instead of monitoring the exec time of deadline tasks to evaluate the
> CPU capacity consumed by deadline scheduler class, we can directly
> calculate it thanks to the sum of utilization of deadline tasks on the
> CPU.  We can remove deadline tasks from rt_avg metric and directly use
> the average bandwidth of deadline scheduler in scale_rt_capacity.
>
> Based in part on a similar patch from Luca Abeni <luca.abeni@unitn.it>.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Steve Muckle <smuckle@linaro.org>
> ---
>  kernel/sched/deadline.c | 33 +++++++++++++++++++++++++++++++--
>  kernel/sched/fair.c     |  8 ++++++++
>  kernel/sched/sched.h    |  2 ++
>  3 files changed, 41 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 8b0a15e..9d9eb50 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -43,6 +43,24 @@ static inline int on_dl_rq(struct sched_dl_entity *dl_se)
>         return !RB_EMPTY_NODE(&dl_se->rb_node);
>  }
>
> +static void add_average_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
> +{
> +       u64 se_bw = dl_se->dl_bw;
> +
> +       dl_rq->avg_bw += se_bw;
> +}
> +
> +static void clear_average_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
> +{
> +       u64 se_bw = dl_se->dl_bw;
> +
> +       dl_rq->avg_bw -= se_bw;
> +       if (dl_rq->avg_bw < 0) {
> +               WARN_ON(1);
> +               dl_rq->avg_bw = 0;
> +       }
> +}
> +
>  static inline int is_leftmost(struct task_struct *p, struct dl_rq *dl_rq)
>  {
>         struct sched_dl_entity *dl_se = &p->dl;
> @@ -494,6 +512,9 @@ static void update_dl_entity(struct sched_dl_entity *dl_se,
>         struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
>         struct rq *rq = rq_of_dl_rq(dl_rq);
>
> +       if (dl_se->dl_new)
> +               add_average_bw(dl_se, dl_rq);
> +
>         /*
>          * The arrival of a new instance needs special treatment, i.e.,
>          * the actual scheduling parameters have to be "renewed".
> @@ -741,8 +762,6 @@ static void update_curr_dl(struct rq *rq)
>         curr->se.exec_start = rq_clock_task(rq);
>         cpuacct_charge(curr, delta_exec);
>
> -       sched_rt_avg_update(rq, delta_exec);
> -
>         dl_se->runtime -= dl_se->dl_yielded ? 0 : delta_exec;
>         if (dl_runtime_exceeded(dl_se)) {
>                 dl_se->dl_throttled = 1;
> @@ -1241,6 +1260,8 @@ static void task_fork_dl(struct task_struct *p)
>  static void task_dead_dl(struct task_struct *p)
>  {
>         struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
> +       struct dl_rq *dl_rq = dl_rq_of_se(&p->dl);
> +       struct rq *rq = rq_of_dl_rq(dl_rq);
>
>         /*
>          * Since we are TASK_DEAD we won't slip out of the domain!
> @@ -1249,6 +1270,8 @@ static void task_dead_dl(struct task_struct *p)
>         /* XXX we should retain the bw until 0-lag */
>         dl_b->total_bw -= p->dl.dl_bw;
>         raw_spin_unlock_irq(&dl_b->lock);
> +
> +       clear_average_bw(&p->dl, &rq->dl);
>  }
>
>  static void set_curr_task_dl(struct rq *rq)
> @@ -1556,7 +1579,9 @@ retry:
>         }
>
>         deactivate_task(rq, next_task, 0);
> +       clear_average_bw(&next_task->dl, &rq->dl);
>         set_task_cpu(next_task, later_rq->cpu);
> +       add_average_bw(&next_task->dl, &later_rq->dl);
>         activate_task(later_rq, next_task, 0);
>         ret = 1;
>
> @@ -1644,7 +1669,9 @@ static void pull_dl_task(struct rq *this_rq)
>                         resched = true;
>
>                         deactivate_task(src_rq, p, 0);
> +                       clear_average_bw(&p->dl, &src_rq->dl);
>                         set_task_cpu(p, this_cpu);
> +                       add_average_bw(&p->dl, &this_rq->dl);
>                         activate_task(this_rq, p, 0);
>                         dmin = p->dl.deadline;
>
> @@ -1750,6 +1777,8 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
>         if (!start_dl_timer(p))
>                 __dl_clear_params(p);
>
> +       clear_average_bw(&p->dl, &rq->dl);
> +
>         /*
>          * Since this might be the only -deadline task on the rq,
>          * this is the right place to try to pull some other one
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4c49f76..ce05f61 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6203,6 +6203,14 @@ static unsigned long scale_rt_capacity(int cpu)
>
>         used = div_u64(avg, total);
>
> +       /*
> +        * deadline bandwidth is defined at system level so we must
> +        * weight this bandwidth with the max capacity of the system.
> +        * As a reminder, avg_bw is 20bits width and
> +        * scale_cpu_capacity is 10 bits width
> +        */
> +       used += div_u64(rq->dl.avg_bw, arch_scale_cpu_capacity(NULL, cpu));
> +
>         if (likely(used < SCHED_CAPACITY_SCALE))
>                 return SCHED_CAPACITY_SCALE - used;
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 08858d1..e44c6be 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -519,6 +519,8 @@ struct dl_rq {
>  #else
>         struct dl_bw dl_bw;
>  #endif
> +       /* This is the "average utilization" for this runqueue */
> +       s64 avg_bw;
>  };
>
>  #ifdef CONFIG_SMP
> --
> 2.4.10
>

From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC PATCH 01/10] sched: Make load tracking frequency scale-invariant
Date: Wed, 17 Dec 2014 09:28:34 +0100
Message-ID: <CAKfTPtBGv7-Y8EevxKgzB0wmBvAtQmoFcheuZp14nPcBz5-5PQ@mail.gmail.com>
References: <1417529192-11579-1-git-send-email-morten.rasmussen@arm.com> <1417529192-11579-2-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417529192-11579-2-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Paul Turner <pjt@google.com>, Benjamin Segall <bsegall@google.com>, Michael Turquette <mturquette@linaro.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2 December 2014 at 15:06, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>
> Apply frequency scale-invariance correction factor to load tracking.
> Each segment of the sched_avg::runnable_avg_sum geometric series is now
> scaled by the current frequency so the sched_avg::load_avg_contrib of each
> entity will be invariant with frequency scaling. As a result,
> cfs_rq::runnable_load_avg which is the sum of sched_avg::load_avg_contrib,
> becomes invariant too. So the load level that is returned by
> weighted_cpuload, stays relative to the max frequency of the cpu.
>
> Then, we want the keep the load tracking values in a 32bits type, which
> implies that the max value of sched_avg::{runnable|running}_avg_sum must
> be lower than 2^32/88761=48388 (88761 is the max weight of a task). As
> LOAD_AVG_MAX = 47742, arch_scale_freq_capacity must return a value less
> than (48388/47742) << SCHED_CAPACITY_SHIFT = 1037 (SCHED_SCALE_CAPACITY =
> 1024). So we define the range to [0..SCHED_SCALE_CAPACITY] in order to
> avoid overflow.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/fair.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ee76d52..b41f03d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2507,9 +2507,9 @@ static __always_inline int __update_entity_runnable_avg(u64 now, int cpu,
>                                                         int runnable,
>                                                         int running)
>  {
> -       u64 delta, periods;
> -       u32 runnable_contrib;
> -       int delta_w, decayed = 0;
> +       u64 delta, scaled_delta, periods;
> +       u32 runnable_contrib, scaled_runnable_contrib;
> +       int delta_w, scaled_delta_w, decayed = 0;
>         unsigned long scale_freq = arch_scale_freq_capacity(NULL, cpu);
>
>         delta = now - sa->last_runnable_update;
> @@ -2543,11 +2543,12 @@ static __always_inline int __update_entity_runnable_avg(u64 now, int cpu,
>                  * period and accrue it.
>                  */
>                 delta_w = 1024 - delta_w;
> +               scaled_delta_w = (delta_w * scale_freq) >> SCHED_CAPACITY_SHIFT;
> +
>                 if (runnable)
> -                       sa->runnable_avg_sum += delta_w;
> +                       sa->runnable_avg_sum += scaled_delta_w;
>                 if (running)
> -                       sa->running_avg_sum += delta_w * scale_freq
> -                               >> SCHED_CAPACITY_SHIFT;
> +                       sa->running_avg_sum += scaled_delta_w;
>                 sa->avg_period += delta_w;
>
>                 delta -= delta_w;
> @@ -2565,20 +2566,23 @@ static __always_inline int __update_entity_runnable_avg(u64 now, int cpu,
>
>                 /* Efficiently calculate \sum (1..n_period) 1024*y^i */
>                 runnable_contrib = __compute_runnable_contrib(periods);
> +               scaled_runnable_contrib = (runnable_contrib * scale_freq)
> +                                               >> SCHED_CAPACITY_SHIFT;
> +
>                 if (runnable)
> -                       sa->runnable_avg_sum += runnable_contrib;
> +                       sa->runnable_avg_sum += scaled_runnable_contrib;
>                 if (running)
> -                       sa->running_avg_sum += runnable_contrib * scale_freq
> -                               >> SCHED_CAPACITY_SHIFT;
> +                       sa->running_avg_sum += scaled_runnable_contrib;
>                 sa->avg_period += runnable_contrib;
>         }
>
>         /* Remainder of delta accrued against u_0` */
> +       scaled_delta = (delta * scale_freq) >> SCHED_CAPACITY_SHIFT;
> +
>         if (runnable)
> -               sa->runnable_avg_sum += delta;
> +               sa->runnable_avg_sum += scaled_delta;
>         if (running)
> -               sa->running_avg_sum += delta * scale_freq
> -                       >> SCHED_CAPACITY_SHIFT;
> +               sa->running_avg_sum += scaled_delta;
>         sa->avg_period += delta;
>
>         return decayed;

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> --
> 1.9.1
>
>

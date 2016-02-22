From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Mon, 22 Feb 2016 15:33:02 +0100
Message-ID: <CAKfTPtBEREXmhOdZSsY0DM76YdZg=WJn7TN1ADTfAQ806+YN5w@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan> <2044559.7ypXocW9OZ@vostro.rjw.lan>
 <3499355.2JlaSruvOa@vostro.rjw.lan> <16016177.YFqb4gVNBo@vostro.rjw.lan>
 <CAJZ5v0jthTo8rXMp_ad=k5EcFBcwLgKRMnwPsznqDhois84uYA@mail.gmail.com>
 <20160219080917.GE22643@pablo> <1455900129.7375.231.camel@linux.intel.com>
 <56C750B7.6090701@linaro.org> <20160222105224.GE6356@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160222105224.GE6356@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 22 February 2016 at 11:52, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Feb 19, 2016 at 09:28:23AM -0800, Steve Muckle wrote:
>> On 02/19/2016 08:42 AM, Srinivas Pandruvada wrote:
>> > We did experiments using util/max in intel_pstate. For some benchmarks
>> > there were regression of 4 to 5%, for some benchmarks it performed at
>> > par with getting utilization from the processor. Further optimization
>> > in the algorithm is possible and still in progress. Idea is that we can
>> > change P-State fast enough and be more reactive. Once I have good data,
>> > I will send to this list. The algorithm can be part of the cpufreq
>> > governor too.
>>
>> There has been a lot of work in the area of scheduler-driven CPU
>> frequency selection by Linaro and ARM as well. It was posted most
>> recently a couple months ago:
>>
>> http://thread.gmane.org/gmane.linux.power-management.general/69176
>>
>> It was also posted as part of the energy-aware scheduling series last
>> July. There's a new RFC series forthcoming which I had hoped (and
>> failed) to post prior to my business travel this week; it should be out
>> next week. It will address the feedback received thus far along with
>> locking and other things.
>
> Right, so I had a wee look at that again, and had a quick chat with Juri
> on IRC. So the main difference seems to be that you guys want to know
> why the utilization changed, as opposed to purely _that_ it changed.

Yes, the main goal was to be able to filter the useful and useless
update of rq's utilization in order to minimize/optimize the trig of
an update of the frequency. These patches have been made for a cpufreq
driver that reacts far slower than scheduler. It's might worth
starting with a simple solution and update it after

>
> And hence you have callbacks all over the place.
>
> I'm not too sure I really like that too much, it bloats the code and
> somewhat obfuscates the point.
>
> So I would really like there to be just the one callback when we
> actually compute a new number, and that is update_load_avg().
>
> Now I think we can 'easily' propagate the information you want into
> update_load_avg() (see below), but I would like to see actual arguments
> for why you would need this.

Your proposal is interesting except that we are interested in the rq's
utilization more that se's ones so we should better use
update_cfs_rq_load_avg and few additional place like
attach_entity_load_avg which bypasses update_cfs_rq_load_avg to update
rq's utilization and load

>
> For one, the migration bits don't really make sense. We typically do not
> call migration code local on both cpus, typically just one, but possibly
> neither. That means you cannot actually update the relevant CPU state
> from these sites anyway.
>
>> The scheduler hooks for utilization-based cpufreq operation deserve a
>> lot more debate I think. They could quite possibly have different
>> requirements than hooks which are chosen just to guarantee periodic
>> callbacks into sampling-based governors.
>
> I'll repeat what Rafael said, the periodic callback nature is a
> 'temporary' hack, simply because current cpufreq depends on that.
>
> The idea is to wane cpufreq off of that requirement and then drop that
> part.
>
> Very-much-not-signed-off-by: Peter Zijlstra
> ---
>  kernel/sched/fair.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7ce24a456322..f3e95d8b65c3 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -2528,6 +2528,17 @@ static inline void update_cfs_shares(struct cfs_rq *cfs_rq)
>  }
>  #endif /* CONFIG_FAIR_GROUP_SCHED */
>
> +enum load_update_type {
> +       LOAD_NONE,
> +       LOAD_TICK,
> +       LOAD_PUT,
> +       LOAD_SET,
> +       LOAD_ENQUEUE,
> +       LOAD_DEQUEUE,
> +       LOAD_ENQUEUE_MOVE = LOAD_ENQUEUE + 2,
> +       LOAD_DEQUEUE_MOVE = LOAD_DEQUEUE + 2,
> +};
> +
>  #ifdef CONFIG_SMP
>  /* Precomputed fixed inverse multiplies for multiplication by y^n */
>  static const u32 runnable_avg_yN_inv[] = {
> @@ -2852,7 +2863,8 @@ static inline int update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  }
>
>  /* Update task and its cfs_rq load average */
> -static inline void update_load_avg(struct sched_entity *se, int update_tg)
> +static inline void update_load_avg(struct sched_entity *se, int update_tg,
> +                                  enum load_update_type type)
>  {
>         struct cfs_rq *cfs_rq = cfs_rq_of(se);
>         u64 now = cfs_rq_clock_task(cfs_rq);
> @@ -2940,7 +2952,7 @@ enqueue_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  static inline void
>  dequeue_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -       update_load_avg(se, 1);
> +       update_load_avg(se, 1, LOAD_DEQUEUE);
>
>         cfs_rq->runnable_load_avg =
>                 max_t(long, cfs_rq->runnable_load_avg - se->avg.load_avg, 0);
> @@ -3006,7 +3018,8 @@ static int idle_balance(struct rq *this_rq);
>
>  #else /* CONFIG_SMP */
>
> -static inline void update_load_avg(struct sched_entity *se, int update_tg) {}
> +static inline void update_load_avg(struct sched_entity *se, int update_tg,
> +                                  enum load_update_type type) {}
>  static inline void
>  enqueue_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
>  static inline void
> @@ -3327,7 +3340,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
>                 if (schedstat_enabled())
>                         update_stats_wait_end(cfs_rq, se);
>                 __dequeue_entity(cfs_rq, se);
> -               update_load_avg(se, 1);
> +               update_load_avg(se, 1, LOAD_SET);
>         }
>
>         update_stats_curr_start(cfs_rq, se);
> @@ -3431,7 +3444,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
>                 /* Put 'current' back into the tree. */
>                 __enqueue_entity(cfs_rq, prev);
>                 /* in !on_rq case, update occurred at dequeue */
> -               update_load_avg(prev, 0);
> +               update_load_avg(prev, 0, LOAD_PUT);
>         }
>         cfs_rq->curr = NULL;
>  }
> @@ -3447,7 +3460,7 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>         /*
>          * Ensure that runnable average is periodically updated.
>          */
> -       update_load_avg(curr, 1);
> +       update_load_avg(curr, 1, LOAD_TICK);
>         update_cfs_shares(cfs_rq);
>
>  #ifdef CONFIG_SCHED_HRTICK
> @@ -4320,7 +4333,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 if (cfs_rq_throttled(cfs_rq))
>                         break;
>
> -               update_load_avg(se, 1);
> +               update_load_avg(se, 1, LOAD_ENQUEUE + (p->on_rq & TASK_ON_RQ_MIGRATING));
>                 update_cfs_shares(cfs_rq);
>         }
>
> @@ -4380,7 +4393,7 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>                 if (cfs_rq_throttled(cfs_rq))
>                         break;
>
> -               update_load_avg(se, 1);
> +               update_load_avg(se, 1, LOAD_DEQUEUE + (p->on_rq & TASK_ON_RQ_MIGRATING));
>                 update_cfs_shares(cfs_rq);
>         }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

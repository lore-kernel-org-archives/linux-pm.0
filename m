From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/7] sched/core: uclamp: add CPU clamp groups accounting
Date: Fri, 13 Apr 2018 10:43:02 +0200
Message-ID: <20180413084302.GR4043@hirez.programming.kicks-ass.net>
References: <20180409165615.2326-1-patrick.bellasi@arm.com>
 <20180409165615.2326-2-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180409165615.2326-2-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 09, 2018 at 05:56:09PM +0100, Patrick Bellasi wrote:
> +static inline void uclamp_task_update(struct rq *rq, struct task_struct *p)
> +{
> +	int cpu = cpu_of(rq);
> +	int clamp_id;
> +
> +	/* The idle task does not affect CPU's clamps */
> +	if (unlikely(p->sched_class == &idle_sched_class))
> +		return;
> +	/* DEADLINE tasks do not affect CPU's clamps */
> +	if (unlikely(p->sched_class == &dl_sched_class))
> +		return;
> +
> +	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +		if (uclamp_task_affects(p, clamp_id))
> +			uclamp_cpu_put(p, cpu, clamp_id);
> +		else
> +			uclamp_cpu_get(p, cpu, clamp_id);
> +	}
> +}

Is that uclamp_task_affects() thing there to fix up the fact you failed
to propagate the calling context (enqueue/dequeue) ?

I find this code _really_ hard to read...

> @@ -743,6 +929,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>  	if (!(flags & ENQUEUE_RESTORE))
>  		sched_info_queued(rq, p);
>  
> +	uclamp_task_update(rq, p);
>  	p->sched_class->enqueue_task(rq, p, flags);
>  }
>  
> @@ -754,6 +941,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
>  	if (!(flags & DEQUEUE_SAVE))
>  		sched_info_dequeued(rq, p);
>  
> +	uclamp_task_update(rq, p);
>  	p->sched_class->dequeue_task(rq, p, flags);
>  }
>  

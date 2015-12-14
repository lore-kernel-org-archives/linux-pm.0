From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Mon, 14 Dec 2015 16:17:29 +0100
Message-ID: <20151214151729.GQ6357@twins.programming.kicks-ass.net>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1449641971-20827-10-git-send-email-smuckle@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>, Luca Abeni <luca.abeni@unitn.it>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 08, 2015 at 10:19:30PM -0800, Steve Muckle wrote:
> From: Vincent Guittot <vincent.guittot@linaro.org>

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 8b0a15e..9d9eb50 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -43,6 +43,24 @@ static inline int on_dl_rq(struct sched_dl_entity *dl_se)
>  	return !RB_EMPTY_NODE(&dl_se->rb_node);
>  }
>  
> +static void add_average_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
> +{
> +	u64 se_bw = dl_se->dl_bw;
> +
> +	dl_rq->avg_bw += se_bw;
> +}
> +
> +static void clear_average_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
> +{
> +	u64 se_bw = dl_se->dl_bw;
> +
> +	dl_rq->avg_bw -= se_bw;
> +	if (dl_rq->avg_bw < 0) {
> +		WARN_ON(1);
> +		dl_rq->avg_bw = 0;
> +	}
> +}


> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 4c49f76..ce05f61 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6203,6 +6203,14 @@ static unsigned long scale_rt_capacity(int cpu)
>  
>  	used = div_u64(avg, total);
>  
> +	/*
> +	 * deadline bandwidth is defined at system level so we must
> +	 * weight this bandwidth with the max capacity of the system.
> +	 * As a reminder, avg_bw is 20bits width and
> +	 * scale_cpu_capacity is 10 bits width
> +	 */
> +	used += div_u64(rq->dl.avg_bw, arch_scale_cpu_capacity(NULL, cpu));
> +
>  	if (likely(used < SCHED_CAPACITY_SCALE))
>  		return SCHED_CAPACITY_SCALE - used;
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 08858d1..e44c6be 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -519,6 +519,8 @@ struct dl_rq {
>  #else
>  	struct dl_bw dl_bw;
>  #endif
> +	/* This is the "average utilization" for this runqueue */
> +	s64 avg_bw;
>  };

So I don't think this is right. AFAICT this projects the WCET as the
amount of time actually used by DL. This will, under many circumstances,
vastly overestimate the amount of time actually spend on it. Therefore
unduly pessimisme the fair capacity of this CPU.

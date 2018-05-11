From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] sched/fair: schedutil: explicit update only when
 required
Date: Fri, 11 May 2018 11:13:15 +0530
Message-ID: <20180511054315.6jhvg4pveyyeqkws@vireshk-i7>
References: <20180510150553.28122-1-patrick.bellasi@arm.com>
 <20180510150553.28122-4-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180510150553.28122-4-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On 10-05-18, 16:05, Patrick Bellasi wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> -static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
>  	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
>  
> @@ -3762,7 +3736,6 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
>  
> -	cfs_rq_util_change(cfs_rq, flags);

Was leaving a blank line at the end of routine intentional ?

>  }
>  
>  /**
> @@ -3781,7 +3754,6 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  
>  	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
>  
> -	cfs_rq_util_change(cfs_rq, 0);

Here too.

>  }
-- 
viresh

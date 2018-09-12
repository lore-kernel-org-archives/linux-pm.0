From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Wed, 12 Sep 2018 18:24:27 +0200
Message-ID: <20180912162427.GA24106@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180828135324.21976-3-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 28, 2018 at 02:53:10PM +0100, Patrick Bellasi wrote:
>  static inline int __setscheduler_uclamp(struct task_struct *p,
>  					const struct sched_attr *attr)

But large for inline now.

>  {
> +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> +	int lower_bound, upper_bound;
> +	struct uclamp_se *uc_se;
> +	int result = 0;

I think the thing would become much more readable if you set
lower/upper_bound right here.
>  
> +	mutex_lock(&uclamp_mutex);
>  
> +	/* Find a valid group_id for each required clamp value */
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +		upper_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> +			? attr->sched_util_max
> +			: p->uclamp[UCLAMP_MAX].value;
> +
> +		if (upper_bound == UCLAMP_NOT_VALID)
> +			upper_bound = SCHED_CAPACITY_SCALE;
> +		if (attr->sched_util_min > upper_bound) {
> +			result = -EINVAL;
> +			goto done;
> +		}
> +
> +		result = uclamp_group_find(UCLAMP_MIN, attr->sched_util_min);
> +		if (result == -ENOSPC) {
> +			pr_err(UCLAMP_ENOSPC_FMT, "MIN");

AFAICT this is an unpriv part of the syscall; and you can spam the log
without limits. Not good.

> +			goto done;
> +		}
> +		group_id[UCLAMP_MIN] = result;
> +	}
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +		lower_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> +			? attr->sched_util_min
> +			: p->uclamp[UCLAMP_MIN].value;
> +
> +		if (lower_bound == UCLAMP_NOT_VALID)
> +			lower_bound = 0;
> +		if (attr->sched_util_max < lower_bound ||
> +		    attr->sched_util_max > SCHED_CAPACITY_SCALE) {
> +			result = -EINVAL;
> +			goto done;
> +		}
> +
> +		result = uclamp_group_find(UCLAMP_MAX, attr->sched_util_max);
> +		if (result == -ENOSPC) {
> +			pr_err(UCLAMP_ENOSPC_FMT, "MAX");
> +			goto done;
> +		}
> +		group_id[UCLAMP_MAX] = result;
> +	}
> +
> +	/* Update each required clamp group */
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> +		uc_se = &p->uclamp[UCLAMP_MIN];
> +		uclamp_group_get(UCLAMP_MIN, group_id[UCLAMP_MIN],
> +				 uc_se, attr->sched_util_min);
> +	}
> +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> +		uc_se = &p->uclamp[UCLAMP_MAX];
> +		uclamp_group_get(UCLAMP_MAX, group_id[UCLAMP_MAX],
> +				 uc_se, attr->sched_util_max);
> +	}
> +
> +done:
> +	mutex_unlock(&uclamp_mutex);
> +
> +	return result;
> +}

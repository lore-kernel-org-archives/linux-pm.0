From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Thu, 6 Sep 2018 15:00:26 +0100
Message-ID: <20180906140026.GC25636@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180906081728.GB27626@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180906081728.GB27626@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 06-Sep 10:17, Juri Lelli wrote:
> On 28/08/18 14:53, Patrick Bellasi wrote:
> 
> [...]
> 
> >  static inline int __setscheduler_uclamp(struct task_struct *p,
> >  					const struct sched_attr *attr)
> >  {
> > -	if (attr->sched_util_min > attr->sched_util_max)
> > -		return -EINVAL;
> > -	if (attr->sched_util_max > SCHED_CAPACITY_SCALE)
> > -		return -EINVAL;
> > +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > +	int lower_bound, upper_bound;
> > +	struct uclamp_se *uc_se;
> > +	int result = 0;
> >  
> > -	p->uclamp[UCLAMP_MIN] = attr->sched_util_min;
> > -	p->uclamp[UCLAMP_MAX] = attr->sched_util_max;
> > +	mutex_lock(&uclamp_mutex);
> >  
> > -	return 0;
> > +	/* Find a valid group_id for each required clamp value */
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> > +		upper_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> > +			? attr->sched_util_max
> > +			: p->uclamp[UCLAMP_MAX].value;
> > +
> > +		if (upper_bound == UCLAMP_NOT_VALID)
> > +			upper_bound = SCHED_CAPACITY_SCALE;
> > +		if (attr->sched_util_min > upper_bound) {
> > +			result = -EINVAL;
> > +			goto done;
> > +		}
> > +
> > +		result = uclamp_group_find(UCLAMP_MIN, attr->sched_util_min);
> > +		if (result == -ENOSPC) {
> > +			pr_err(UCLAMP_ENOSPC_FMT, "MIN");
> > +			goto done;
> > +		}
> > +		group_id[UCLAMP_MIN] = result;
> > +	}
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> > +		lower_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> > +			? attr->sched_util_min
> > +			: p->uclamp[UCLAMP_MIN].value;
> > +
> > +		if (lower_bound == UCLAMP_NOT_VALID)
> > +			lower_bound = 0;
> > +		if (attr->sched_util_max < lower_bound ||
> > +		    attr->sched_util_max > SCHED_CAPACITY_SCALE) {
> > +			result = -EINVAL;
> > +			goto done;
> > +		}
> > +
> > +		result = uclamp_group_find(UCLAMP_MAX, attr->sched_util_max);
> > +		if (result == -ENOSPC) {
> > +			pr_err(UCLAMP_ENOSPC_FMT, "MAX");
> > +			goto done;
> > +		}
> > +		group_id[UCLAMP_MAX] = result;
> > +	}
> 
> Don't you have to reset result to 0 here (it seems what follows cannot
> fail anymore)? Otherwise this function will return latest
> uclamp_group_find return value, which will be interpreted as error if
> not 0.

Yes, wired.. it uses to work on my tests just because I return from
the caller on !0 and:
 - that's just good enough to set by uclamps
 - my current rt-app integration does not check the sycall return value
 - my tests never request the clamp_group mapped on group_id=0

:(

Will fix both this and the rt-app integration and the tests !

Cheers Patrick

-- 
#include <best/regards.h>

Patrick Bellasi

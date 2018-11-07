From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v5 03/15] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Wed, 7 Nov 2018 14:53:55 +0000
Message-ID: <20181107145355.GI14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-4-patrick.bellasi@arm.com>
 <20181107143713.GS9781@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107143713.GS9781@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 07-Nov 15:37, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 06:32:57PM +0000, Patrick Bellasi wrote:
> > +static int __setscheduler_uclamp(struct task_struct *p,
> > +				 const struct sched_attr *attr)
> > +{
> > +	unsigned int lower_bound = p->uclamp[UCLAMP_MIN].value;
> > +	unsigned int upper_bound = p->uclamp[UCLAMP_MAX].value;
> > +	int result = 0;
> > +
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
> > +		lower_bound = attr->sched_util_min;
> > +
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
> > +		upper_bound = attr->sched_util_max;
> > +
> > +	if (lower_bound > upper_bound ||
> > +	    upper_bound > SCHED_CAPACITY_SCALE)
> >  		return -EINVAL;
> >  
> > +	mutex_lock(&uclamp_mutex);
> >  
> > +	/* Update each required clamp group */
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
> > +		uclamp_group_get(&p->uclamp[UCLAMP_MIN],
> > +				 UCLAMP_MIN, lower_bound);
> > +	}
> > +	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
> > +		uclamp_group_get(&p->uclamp[UCLAMP_MAX],
> > +				 UCLAMP_MAX, upper_bound);
> > +	}
> > +
> > +	mutex_unlock(&uclamp_mutex);
> > +
> > +	return result;
> > +}
> 
> I'm missing where we error due to lack of groups.

Again, after:

   sched/core: uclamp: add clamp group bucketing support

we should never error.

Perhaps I should really squash the bucketing in these first patches
directly... lemme see what's your take on those bits, if you like them
better not in a separate patch, I'll squash them on v6.

-- 
#include <best/regards.h>

Patrick Bellasi

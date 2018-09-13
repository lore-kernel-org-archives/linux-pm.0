From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 02/16] sched/core: uclamp: map TASK's clamp values
 into CPU's clamp groups
Date: Thu, 13 Sep 2018 21:20:34 +0200
Message-ID: <20180913192034.GA24082@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-3-patrick.bellasi@arm.com>
 <20180912162427.GA24106@hirez.programming.kicks-ass.net>
 <20180912174209.GI1413@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180912174209.GI1413@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Sep 12, 2018 at 06:42:09PM +0100, Patrick Bellasi wrote:
> On 12-Sep 18:24, Peter Zijlstra wrote:
> > On Tue, Aug 28, 2018 at 02:53:10PM +0100, Patrick Bellasi wrote:

> > >  {
> > > +	int group_id[UCLAMP_CNT] = { UCLAMP_NOT_VALID };
> > > +	int lower_bound, upper_bound;
> > > +	struct uclamp_se *uc_se;
> > > +	int result = 0;
> > 
> > I think the thing would become much more readable if you set
> > lower/upper_bound right here.

> Actually it could also make sense to have them before the mutex ;)

Indeed.

+               upper_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
+                       ? attr->sched_util_max
+                       : p->uclamp[UCLAMP_MAX].value;
+               
+               if (upper_bound == UCLAMP_NOT_VALID)
+                       upper_bound = SCHED_CAPACITY_SCALE;
+               if (attr->sched_util_min > upper_bound) {
+                       result = -EINVAL;
+                       goto done;
+               }
+             
+               result = uclamp_group_find(UCLAMP_MIN, attr->sched_util_min);
+               if (result == -ENOSPC) {
+                       pr_err(UCLAMP_ENOSPC_FMT, "MIN");
+                       goto done;
+               }
+               group_id[UCLAMP_MIN] = result;
+       }
+       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX) {
+               lower_bound = (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
+                       ? attr->sched_util_min
+                       : p->uclamp[UCLAMP_MIN].value;
+ 
+               if (lower_bound == UCLAMP_NOT_VALID)
+                       lower_bound = 0;
+               if (attr->sched_util_max < lower_bound ||
+                   attr->sched_util_max > SCHED_CAPACITY_SCALE) {
+                       result = -EINVAL;
+                       goto done;
+               }

That would end up soething like:

	unsigned int lower_bound = p->uclamp[UCLAMP_MIN].value;
	unsigned int upper_bound = p->uclamp[UCLAMP_MAX].value;

	if (sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN)
		lower_bound = attr->sched_util_min;

	if (sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX)
		upper_bound = attr->sched_util_max;

	if (lower_bound > upper_bound ||
	    upper_bound > SCHED_CAPACITY_MAX)
		return -EINVAL;

	mutex_lock(...);

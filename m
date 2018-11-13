From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v5 07/15] sched/core: uclamp: add clamp group bucketing
 support
Date: Tue, 13 Nov 2018 07:29:48 -0800
Message-ID: <20181113152948.GC7681@darkstar>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-9-patrick.bellasi@arm.com>
 <20181112000910.GC3038@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181112000910.GC3038@worktop>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 12-Nov 01:09, Peter Zijlstra wrote:
> On Mon, Oct 29, 2018 at 06:33:02PM +0000, Patrick Bellasi wrote:
> > The number of clamp groups configured at compile time defines the range
> > of utilization clamp values tracked by each CPU clamp group.
> > For example, with the default configuration:
> >    CONFIG_UCLAMP_GROUPS_COUNT 5
> > we will have 5 clamp groups tracking 20% utilization each. In this case,
> > a task with util_min=25% will have group_id=1.
> 
> OK I suppose; but should we not do a wholesale s/group/bucket/ at this
> point?

Yes, if bucketization is acceptable, we should probably rename.

Question is: are you ok for a renaming in this patch. or you better
prefer I use that naming since the beginning ?

If we wanna use "bucket" since the beginning, then we should also
probably squash the entire patch into the previous ones and drop this
one.

I personally prefer to keep this concept into a separate patch, but at
the same time I don't very like the idea of a massive renaming in this
patch.

> 
> We should probably raise the minimum number of buckets from 1 though :-)

Mmm... the default is already set to what fits into a single cache
line... perhaps we can use that as a minimum too ?

But. technically we can (partially) track different clamp values also
with just one bucket... (explanation in the following comment).

> > +/*
> > + * uclamp_group_value: get the "group value" for a given "clamp value"
> > + * @value: the utiliation "clamp value" to translate
> > + *
> > + * The number of clamp group, which is defined at compile time, allows to
> > + * track a finite number of different clamp values. Thus clamp values are
> > + * grouped into bins each one representing a different "group value".
> > + * This method returns the "group value" corresponding to the specified
> > + * "clamp value".
> > + */
> > +static inline unsigned int uclamp_group_value(unsigned int clamp_value)
> > +{
> > +#define UCLAMP_GROUP_DELTA (SCHED_CAPACITY_SCALE / CONFIG_UCLAMP_GROUPS_COUNT)
> > +#define UCLAMP_GROUP_UPPER (UCLAMP_GROUP_DELTA * CONFIG_UCLAMP_GROUPS_COUNT)
> > +
> > +	if (clamp_value >= UCLAMP_GROUP_UPPER)
> > +		return SCHED_CAPACITY_SCALE;
> > +
> > +	return UCLAMP_GROUP_DELTA * (clamp_value / UCLAMP_GROUP_DELTA);
> > +}
> 
> Can't we further simplify; I mean, at this point all we really need to
> know is the rq's highest group_id that is in use. We don't need to
> actually track the value anymore.

This will force to track each clamp value with the exact bucket value.

Instead, by tracking the actual clamp value within a bucket, we have
the chance to updte the bucket value to the actual (max) clamp value
of the RUNNABLE tasks in that bucket.

In a properly configured system, this allows to track exact clamp
values with a minimum number of buckets.

-- 
#include <best/regards.h>

Patrick Bellasi

From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v5 04/15] sched/core: uclamp: add CPU's clamp groups
 refcounting
Date: Thu, 22 Nov 2018 14:20:45 +0000
Message-ID: <20181122142045.GM14309@e110439-lin>
References: <20181029183311.29175-1-patrick.bellasi@arm.com>
 <20181029183311.29175-6-patrick.bellasi@arm.com>
 <20181111164754.GA3038@worktop>
 <20181113151127.GA7681@darkstar>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181113151127.GA7681@darkstar>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 13-Nov 07:11, Patrick Bellasi wrote:
> On 11-Nov 17:47, Peter Zijlstra wrote:
> > On Mon, Oct 29, 2018 at 06:32:59PM +0000, Patrick Bellasi wrote:

[...]

> > > +		/* Both min and max clamps are MAX aggregated */
> > > +		if (max_value < rq->uclamp.group[clamp_id][group_id].value)
> > > +			max_value = rq->uclamp.group[clamp_id][group_id].value;
> > 
> > 		max_value = max(max_value, rq->uclamp.group[clamp_id][group_id].value);
> 
> Right, I get used to this pattern to avoid write instructions.
> I guess that here, being just a function local variable, we don't
> really care much...

The above does not work also because we now use bitfields:

In file included from ./include/linux/list.h:9:0,
                 from ./include/linux/rculist.h:10,
                 from ./include/linux/pid.h:5,
                 from ./include/linux/sched.h:14,
                 from kernel/sched/sched.h:5,
                 from kernel/sched/core.c:8:
   kernel/sched/core.c: In function ‘uclamp_cpu_update’:
   kernel/sched/core.c:867:5: error: ‘typeof’ applied to a bit-field
           rq->uclamp.group[clamp_id][group_id].value);
           ^

[...]

> > > +	if (rq->uclamp.value[clamp_id] < p->uclamp[clamp_id].value)
> > > +		rq->uclamp.value[clamp_id] = p->uclamp[clamp_id].value;
> > 
> > 	rq->uclamp.value[clamp_id] = max(rq->uclamp.value[clamp_id],
> > 					 p->uclamp[clamp_id].value);
> 
> In this case instead, since we are updating a variable visible from
> other CPUs, should not be preferred to avoid assignment when not
> required ?

And what about this ?

> Is the compiler is smart enough to optimize the code above?
> ... will check better.

Did not really checked what the compiler does in the two cases but,
given also the above, for consistency I would probably prefer to keep
both max aggregation as originally defined.

What do you think ?

-- 
#include <best/regards.h>

Patrick Bellasi

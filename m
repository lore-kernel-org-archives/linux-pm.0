From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
Date: Thu, 16 Aug 2018 15:07:31 +0100
Message-ID: <20180816140731.GD2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-10-patrick.bellasi@arm.com>
 <20180816090906.GC2661@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180816090906.GC2661@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 16-Aug 14:39, Pavan Kondeti wrote:
> On Mon, Aug 06, 2018 at 05:39:41PM +0100, Patrick Bellasi wrote:

[...]

> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 8f48e64fb8a6..3fac2d098084 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -589,6 +589,11 @@ struct uclamp_se {
> >  	unsigned int value;
> >  	/* Utilization clamp group for this constraint */
> >  	unsigned int group_id;
> > +	/* Effective clamp  for tasks in this group */
> > +	struct {
> > +		unsigned int value;
> > +		unsigned int group_id;
> > +	} effective;
> >  };
> 
> Are these needed when CONFIG_UCLAMP_TASK_GROUP is disabled?

Mmm... not entirely, at least not the value.

While working on v4 I've notice that:

   (1) task_struct::uclamp::effective::group_id

can be used for the back annotation we add in:

   [PATCH v3 11/14] sched/core: uclamp: use TG's clamps to restrict Task's clamps

using the additional field:

   (2) task_struct::uclamp_group_id

So, I'm updating that patch to re-use (1) instead of adding (2).

Regarding:

   (3) task_struct::uclamp::effective::value

it can be used to track the task's effective clamp value once I add
the discretization support discussed with Juri in:

   https://lore.kernel.org/lkml/20180809152313.lewfhufidhxb2qrk@darkstar/


So, I would say that in v4 I can try to see if and how we can guard
(some of) the effective values on !CONFIG_UCLAMP_TASK_GROUP
configurations...

>
> >  union rcu_special {
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2ba55a4afffb..f692df3787bd 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1237,6 +1237,8 @@ static inline void init_uclamp_sched_group(void)
> >  		uc_se = &root_task_group.uclamp[clamp_id];
> >  		uc_se->value = uclamp_none(clamp_id);
> >  		uc_se->group_id = group_id;
> > +		uc_se->effective.value = uclamp_none(clamp_id);
> > +		uc_se->effective.group_id = group_id;
> >  
> >  		/* Attach root TG's clamp group */
> >  		uc_map[group_id].se_count = 1;
> >  
> 
> <snip>
> 
> > @@ -7622,11 +7687,19 @@ static struct cftype cpu_legacy_files[] = {
> >  		.read_u64 = cpu_util_min_read_u64,
> >  		.write_u64 = cpu_util_min_write_u64,
> >  	},
> > +	{
> > +		.name = "util.min.effective",
> > +		.read_u64 = cpu_util_min_effective_read_u64,
> > +	},
> >  	{
> >  		.name = "util.max",
> >  		.read_u64 = cpu_util_max_read_u64,
> >  		.write_u64 = cpu_util_max_write_u64,
> >  	},
> > +	{
> > +		.name = "util.max.effective",
> > +		.read_u64 = cpu_util_max_effective_read_u64,
> > +	},
> >  #endif
> >  	{ }	/* Terminate */
> >  };
> 
> Is there any reason why these are not added for the default hierarchy?

Not really, good point!

I think I've just forgot them... which makes me notice that I still
have to improve the coverage for my tests on the default hierarchy.

I don't expect big difference, since the behaviors should be the
same but...

Thanks for pointing this out... will had the attributes in the
upcoming v4.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi

From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups
 accounting
Date: Fri, 14 Sep 2018 10:07:51 +0100
Message-ID: <20180914090751.GN1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-4-patrick.bellasi@arm.com>
 <20180913191209.GY24082@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180913191209.GY24082@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 13-Sep 21:12, Peter Zijlstra wrote:
> On Tue, Aug 28, 2018 at 02:53:11PM +0100, Patrick Bellasi wrote:
> > +static inline void uclamp_cpu_get_id(struct task_struct *p,
> > +				     struct rq *rq, int clamp_id)
> > +{
> > +	struct uclamp_group *uc_grp;
> > +	struct uclamp_cpu *uc_cpu;
> > +	int clamp_value;
> > +	int group_id;
> > +
> > +	/* Every task must reference a clamp group */
> > +	group_id = p->uclamp[clamp_id].group_id;
> 
> > +}
> > +
> > +static inline void uclamp_cpu_put_id(struct task_struct *p,
> > +				     struct rq *rq, int clamp_id)
> > +{
> > +	struct uclamp_group *uc_grp;
> > +	struct uclamp_cpu *uc_cpu;
> > +	unsigned int clamp_value;
> > +	int group_id;
> > +
> > +	/* New tasks don't have a previous clamp group */
> > +	group_id = p->uclamp[clamp_id].group_id;
> > +	if (group_id == UCLAMP_NOT_VALID)
> > +		return;
> 
> *confused*, so on enqueue they must have a group_id, but then on dequeue
> they might no longer have?

Why not ?

Tasks always have a (task-specific) group_id, once set the first time.

IOW, init_task::group_id is UCLAMP_NOT_VALID, as well as all the tasks
forked under reset_on_fork, otherwise the get the group_id of the
parent.

Actually, I just noted that the reset_on_fork path is now setting
p::group_id=0, which is semantically equivalent to UCLAMP_NOT_VALID...
but will update that assignment for consistency in v5.

The only way to set a !UCLAMP_NOT_VALID value for p::group_id is via
the syscall, which will either fails or set a new valid group_id.

Thus, if we have a valid p::group_id @enqueue time, we will have one
@dequeue time too. Eventually it could be a different one, because
while RUNNABLE we do a syscall... but this case is addressed by the
following patch:

   [PATCH v4 04/16] sched/core: uclamp: update CPU's refcount on clamp changes
   https://lore.kernel.org/lkml/20180828135324.21976-5-patrick.bellasi@arm.com/

Does that makes sense ?

> > +}
> 
> > @@ -1110,6 +1313,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
> >  	if (!(flags & ENQUEUE_RESTORE))
> >  		sched_info_queued(rq, p);
> >  
> > +	uclamp_cpu_get(rq, p);
> >  	p->sched_class->enqueue_task(rq, p, flags);
> >  }
> >  
> > @@ -1121,6 +1325,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >  	if (!(flags & DEQUEUE_SAVE))
> >  		sched_info_dequeued(rq, p);
> >  
> > +	uclamp_cpu_put(rq, p);
> >  	p->sched_class->dequeue_task(rq, p, flags);
> >  }
> 
> The ordering, is that right? We get while the task isn't enqueued yet,
> which would suggest we put when the task is dequeued.


That's the "usual trick" required for correct schedutil updates.

The scheduler class code will likely poke schedutil and thus we
wanna be sure to have updated CPU clamps by the time we have to
compute the next OPP.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi

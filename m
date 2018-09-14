From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 03/16] sched/core: uclamp: add CPU's clamp groups
 accounting
Date: Fri, 14 Sep 2018 13:52:17 +0200
Message-ID: <20180914115217.GI24124@hirez.programming.kicks-ass.net>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-4-patrick.bellasi@arm.com>
 <20180913191209.GY24082@hirez.programming.kicks-ass.net>
 <20180914090751.GN1413@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180914090751.GN1413@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 14, 2018 at 10:07:51AM +0100, Patrick Bellasi wrote:
> On 13-Sep 21:12, Peter Zijlstra wrote:
> > On Tue, Aug 28, 2018 at 02:53:11PM +0100, Patrick Bellasi wrote:
> > > +static inline void uclamp_cpu_get_id(struct task_struct *p,
> > > +				     struct rq *rq, int clamp_id)
> > > +{
> > > +	struct uclamp_group *uc_grp;
> > > +	struct uclamp_cpu *uc_cpu;
> > > +	int clamp_value;
> > > +	int group_id;
> > > +
> > > +	/* Every task must reference a clamp group */
> > > +	group_id = p->uclamp[clamp_id].group_id;
> > 
> > > +}
> > > +
> > > +static inline void uclamp_cpu_put_id(struct task_struct *p,
> > > +				     struct rq *rq, int clamp_id)
> > > +{
> > > +	struct uclamp_group *uc_grp;
> > > +	struct uclamp_cpu *uc_cpu;
> > > +	unsigned int clamp_value;
> > > +	int group_id;
> > > +
> > > +	/* New tasks don't have a previous clamp group */
> > > +	group_id = p->uclamp[clamp_id].group_id;
> > > +	if (group_id == UCLAMP_NOT_VALID)
> > > +		return;
> > 
> > *confused*, so on enqueue they must have a group_id, but then on dequeue
> > they might no longer have?
> 
> Why not ?

That's what it says on the tin, right? enqueue: "every task must reference clamp
group" while on dequeue: "new tasks don't have a (previous) clamp group"
and we check for NOT_VALID.

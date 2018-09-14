From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v4 06/16] sched/cpufreq: uclamp: add utilization clamping
 for FAIR tasks
Date: Fri, 14 Sep 2018 14:57:12 +0100
Message-ID: <20180914135712.GQ1413@e110439-lin>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-7-patrick.bellasi@arm.com>
 <20180914093240.GB24082@hirez.programming.kicks-ass.net>
 <20180914131919.GO1413@e110439-lin>
 <20180914133654.GL24124@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180914133654.GL24124@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 14-Sep 15:36, Peter Zijlstra wrote:
> On Fri, Sep 14, 2018 at 02:19:19PM +0100, Patrick Bellasi wrote:
> > On 14-Sep 11:32, Peter Zijlstra wrote:
> 
> > > Should that not be:
> > > 
> > > 	util = clamp_util(rq, cpu_util_cfs(rq));
> > > 
> > > Because if !util might we not still want to enforce the min clamp?
> > 
> > If !util CFS tasks should have been gone since a long time
> > (proportional to their estimated utilization) and thus it probably
> > makes sense to not affect further energy efficiency for tasks of other
> > classes.
> 
> I don't remember what we do for util for new tasks; but weren't we
> talking about setting that to 0 recently? IIRC the problem was that if
> we start at 1 with util we'll always run new tasks on big cores, or
> something along those lines.

Mmm.. could have been in a recent discussion with Quentin, but I
think I've missed it. I know we have something similar on Android for
similar reasons.

> So new tasks would still trigger this case until they'd accrued enough
> history.

Well, yes and no. New tasks will be clamped which means that if they
are generated from a capped parent (or within a cgroups with a
suitable util_max) they can still live in a smaller capacity CPU
despite their utilization being 1024. Thus, to a certain extend,
UtilClamp could be a fix for the above misbehavior whenever needed.

NOTE: this series does not include tasks biasing bits.

> Either way around, I don't much care at this point except I think it
> would be good to have a comment to record the assumptions.

Sure, will add a comment on that and a warning about possible side
effects on tasks placement

> > > Would that not be more readable as:
> > > 
> > > static inline unsigned int uclamp_value(struct rq *rq, int clamp_id)
> > > {
> > > 	unsigned int val = rq->uclamp.value[clamp_id];
> > > 
> > > 	if (unlikely(val == UCLAMP_NOT_VALID))
> > > 		val = uclamp_none(clamp_id);
> > > 
> > > 	return val;
> > > }
> > 
> > I'm trying to keep consistency in variable names usages by always
> > accessing the rq's clamps via a *uc_cpu to make it easy grepping the
> > code. Does this argument make sense ?
> > 
> > On the other side, what you propose above is more easy to read
> > by looking just at that function.... so, if you prefer it better, I'll
> > update it on v5.
> 
> I prefer my version, also because it has a single load of the value (yes
> I know about CSE passes). I figure one can always grep for uclamp or
> something.

+1

> > > And how come NOT_VALID is possible? I thought the idea was to always
> > > have all things a valid value.
> > 
> > When we update the CPU's clamp for a "newly idle" CPU, there are not
> > tasks refcounting clamps and thus we end up with UCLAMP_NOT_VALID for
> > that CPU. That's how uclamp_cpu_update() is currently encoded.
> > 
> > Perhaps we can set the value to uclamp_none(clamp_id) from that
> > function, but I was thinking that perhaps it could be useful to track
> > explicitly that the CPU is now idle.
> 
> IIRC you added an explicit flag to track idle somewhere.. to keep the
> last max clamp in effect or something.

Right... that patch was after this one on v3, but know that I've moved
it before we can probably simplify this path.

> I think, but haven't overly thought about this, that if you always
> ensure these things are valid you can avoid a bunch of NOT_VALID
> conditions. And less conditions is always good, right? :-)

Right, will check better all the usages and remove them when not
strictly required.

Cheers,
Patrick

-- 
#include <best/regards.h>

Patrick Bellasi

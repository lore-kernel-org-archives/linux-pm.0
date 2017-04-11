From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Tue, 11 Apr 2017 18:58:33 +0100
Message-ID: <20170411175833.GI29455@e110439-lin>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <20170320145131.GA3623@htj.duckdns.org>
 <20170320172233.GA28391@e110439-lin>
 <20170410073622.2y6tnpcd2ssuoztz@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:36614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751951AbdDKR6j (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Apr 2017 13:58:39 -0400
Content-Disposition: inline
In-Reply-To: <20170410073622.2y6tnpcd2ssuoztz@hirez.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Chris Redpath <chris.redpath@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

Hi Peter,
sorry for this pretty long response, but I think that if you will have
time to patiently go through all the following comments and questions
it will be a big step forward on defining what we really want.

On 10-Apr 09:36, Peter Zijlstra wrote:
> On Mon, Mar 20, 2017 at 05:22:33PM +0000, Patrick Bellasi wrote:
> 
> > a) Bias OPP selection.
> >    Thus granting that certain critical tasks always run at least at a
> >    specified frequency.
> > 
> > b) Bias TASKS placement, which requires an additional extension not
> >    yet posted to keep things simple.
> >    This allows heterogeneous systems, where different CPUs have
> >    different capacities, to schedule important tasks in more capable
> >    CPUs.
> 
> So I dislike the capacity min/max knobs because:

>From your following points I see two main topics: "fundamental
concepts" and "implementation details".

Let's star from the "fundamental concepts", since I think we are not
yet aligned on the overall view and goals for this proposal.


.:: Fundamental Concepts

>  1) capacity is more an implementation detail than a primary metric;

Capacity has been defined in a "platform independent" way, it's a
metric which is normalized to 1024 for the most capable CPU running at
the maximum OPP.

To me it seems it can be considered as a primary metric, maybe not in
the current form, i.e. by exposing a raw number in [0..1024] range.

We should consider also that at the CPUFreq side we already expose
knobs like scaling_{min,max}_freq which are much more platform
dependant than capacity.

>     illustrated per your above points in that it affects both, while in
>     fact it actually modifies another metric, namely util_avg.

I don't see it modifying in any direct way util_avg.

Capacity_{min,max} are tracked independently from util_avg and used
"on demand" to "clamp" the original util_avg signal.

There are two main concepts I would like to know your opinion about:

1) we like to have a support to bias OPPs selection and tasks placement

2) since util_avg is directly affecting both OPPs and tasks placement,
   we can consider to somehow "bias" the "usage of" util_avg to
   achieve these goals

IMHO, if our goal is to bias OPP selection and tasks placement, we
should consider to "work on top of" util_avg thus getting a better
separation of concerns:
- util_avg is (already) used to define how utilization is "produced"
- capacity_{min,max} is used to _bias_ how utilization is "consumed"
  i.e. by schedutil and the FAIR scheduler).


>  2) they look like an absolute clamp for a best effort class; while it
>     very much is not. This also leads to very confusing nesting
>     properties re cgroup.

If by absolute you mean something mandatory, I agree. We are still in
the best effort domain. But perhaps it's just a naming issue.

We want to request a possible minimum capacity, for example to
prefer a big CPUs vs a LITTLE one.
However, being "not mandatory" to me does not mean that it has to be
necessary "more abstract" like the one you are proposing below.

Since, we are defining a "tuning interface" what is the _possible_
effect of a certain value should be easy to understand and to map on a
possible effect.
To me the proposed capacity clamping satisfies this goal while in a
previous proposal, where we advanced the idea of a more generic
"boost" value, there was complains (e.g. from PJT) about not being
really clear what was the possible end result.

Sorry, I don't get instead what are the "confusing nesting properties"
you are referring to?

>  4) they have muddled semantics, because while its presented as a task
>     property, it very much is not.

Actually we always presented it as a task group property, while other
people suggested it should be a per-task API.

Still, IMO it could make sense also as a per-task API, for example
considering a specific RT task which we know in our system is
perfectly fine to always run it below a certain OPP.

Do you think it should be a per-task API?
Should we focus (at least initially) on providing a per task-group API?

>     The max(min) and min(max) of all
>     runnable tasks is applied to the aggregate util signal. Also see 2.

Regarding the max/min aggregations they are an intended feature.
The idea is to implement a sort-of (best-effort of course)
inheritance mechanism.

For example, if we have these two RUNNABLE tasks on a CPU:
 Task A, capacity_min=200
 Task B, capacity_min=400
then we want to run the CPU at least at 40% capacity even when A is
running while B is enqueued.

Don't you think this makes sense?


.:: Implementation details

>  3) they have absolutely unacceptable overhead in implementation. Two
>     more RB tree operations per enqueue/dequeue is just not going to
>     happen.

This last point is about "implementation details", I'm pretty
confident that if we find an agreement on the previous point than
this last will be simple to solve.

Just to be clear, the rb-trees are per CPU and used to track just the
RUNNABLE tasks on each CPUs and, as I described in the previous
example, for the OPP biasing to work I think we really need an
aggregation mechanism.

Ideally, every time a task is enqueue/dequeued from a CPU we want to
know what is the currently required capacity clamping. This requires
to maintain an ordered list of values and rb-trees are the most effective
solution.

Perhaps, if we accept a certain level of approximation, we can
potentially reduce the set of tracked values to a finite set (maybe
corresponding to the EM capacity values) and use just a per-cpu
ref-counting array.
Still the min/max aggregation will have a worst case O(N) search
complexity, where N is the number of finite values we want to use.

Do you think such a solution can work better?

Just for completeness I've reported at the end an overhead analysis
for the current implementation, have a look only if the response to
the previous question was negative ;-)

> So 'nice' is a fairly well understood knob; it controls relative time
> received between competing tasks (and we really should replace the cpu
> controllers 'shares' file with a 'nice' file, see below).

Agree on that point, it's an interesting cleanup/consolidation,
however I cannot see it fitting for our goals...

> I would much rather introduce something like nice-opp, which only
> affects the OPP selection in a relative fashion. This immediately also
> has a natural and obvious extension to cgroup hierarchies (just like
> regular nice).

... affecting OPPs in a relative fashion sounds like a nice abstract
interface but I'm not convinced it can do the job:

a) We should defined what "relative" means.
   While time partitioning between competitive tasks makes perfectly
   sense, I struggle to find how we can boost a task relatively to
   other co-scheduled tasks.
   Does it even make any sense?

b) Nice values have this 10% time-delta each step which will be odd to
   map on OPPs selection.
   What it means to boost a task 10% less than another?

c) Nice values have a well defined discrete range [-20..19].
   Does is make sense to have such a range for OPPs biasing?
   Using a 10% relative delta for each step does not makes this range
   to wide?
   For example, at 5 OPP nice we can probably be already at the minimum OPP.

d) How do we use nice-opp to bias tasks placement?


> And could be folded as a factor in util_avg (just as we do with weight
> in load_avg), although this will mess up everything else we use util for
> :/.

Not if we use get() methods which are called from the code places
where we are interested in getting the biased value.

> Or, alternatively, decompose the aggregate value upon usage and only
> apply the factor for the current running task or something.... Blergh..
> difficult..

Maybe just because we are trying to abstract too much a relatively
simple concept?

Still I don't completely get the downside of using a simple, well
defined and generic concept like "capacity"...


> ---
>  kernel/sched/core.c  | 29 +++++++++++++++++++++--------
>  kernel/sched/fair.c  |  2 +-
>  kernel/sched/sched.h |  1 +
>  3 files changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 27b4dd55b0c7..20ed17369cb1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6963,18 +6963,31 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
>  }
> 
>  #ifdef CONFIG_FAIR_GROUP_SCHED
> -static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
> -				struct cftype *cftype, u64 shareval)
> +static int cpu_nice_write_s64(struct cgroup_subsys_state *css,
> +				struct cftype *cftype, s64 val)
>  {
> -	return sched_group_set_shares(css_tg(css), scale_load(shareval));
> +	struct task_group *tg = css_tg(css);
> +	unsigned long weight;
> +
> +	int ret;
> +
> +	if (val < MIN_NICE || val > MAX_NICE)
> +		return -EINVAL;
> +
> +	weight = sched_prio_to_weight[val - MIN_NICE];
> +
> +	ret = sched_group_set_shares(tg, scale_load(weight));
> +
> +	if (!ret)
> +		tg->nice = val;
>  }
> 
> -static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
> +static u64 cpu_shares_read_s64(struct cgroup_subsys_state *css,
                 ^^^^^^^
you mean:     cpu_nice_write_s64
>  			       struct cftype *cft)
>  {
>  	struct task_group *tg = css_tg(css);
> 
> -	return (u64) scale_load_down(tg->shares);
> +	return (s64)tg->nice;
>  }
> 
>  #ifdef CONFIG_CFS_BANDWIDTH
> @@ -7252,9 +7265,9 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
>  static struct cftype cpu_files[] = {
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	{
> -		.name = "shares",
> -		.read_u64 = cpu_shares_read_u64,
> -		.write_u64 = cpu_shares_write_u64,
> +		.name = "nice",
> +		.read_s64 = cpu_nice_read_s64,
> +		.write_s64 = cpu_nice_write_s64,

However, isn't this going to break a user-space API?

>  	},
>  #endif
>  #ifdef CONFIG_CFS_BANDWIDTH
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 76f67b3e34d6..8088043f46d1 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9471,7 +9471,7 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
>  	if (!tg->se[0])
>  		return -EINVAL;
> 
> -	shares = clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_SHARES));
> +	shares = clamp(shares, MIN_SHARES, scale_load(MAX_SHARES));
                               ^^^^^^^^^^

Why you remove the scaling here?

> 
>  	mutex_lock(&shares_mutex);
>  	if (tg->shares == shares)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 57caf3606114..27f1ffe763bc 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -283,6 +283,7 @@ struct task_group {
>  	/* runqueue "owned" by this group on each cpu */
>  	struct cfs_rq **cfs_rq;
>  	unsigned long shares;
> +	int nice;
> 
>  #ifdef	CONFIG_SMP
>  	/*


.:: Overhead analysis for the current solution

Here are the stats on completion times I've got for 30 runs of:
   perf bench sched messaging --pipe --thread --group 1 --loop 5000
with tasks pinned in the two big CPUs of a Juno2 board and using the
performance governor:

        count   mean    std    min    25%    50%    75%   max
with:    30.0  4.666  0.164  4.228  4.585  4.649  4.781  4.95
without: 30.0  4.830  0.178  4.444  4.751  4.813  4.951  5.14

The average slowdown is ~3.5%, which we can easily agree it's not
negligible.

However, a couple of considerations are still worth:

1) this is certainly not the target use-case, the proposed API is not
   targeting server and/or high intensive workloads. In these cases
   this support should not be enabled at kernel compilation time.
   We are mainly targeting low-utilization and latency sensitive
   workloads.

2) the current implementation perhaps can be optimized by disabling it
   at run-time under certain working conditions, e.g. using something
   similar to what we do for EAS once we cross the tipping-point and the
   system is marked as over-utilized.

3) there is a run-time overhead, of course, but if it gives
   energy/performance benefits for certain low-utilization workloads
   it's still worth to be payed.



-- 
#include <best/regards.h>

Patrick Bellasi

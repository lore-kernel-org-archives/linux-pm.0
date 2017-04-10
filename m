From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Mon, 10 Apr 2017 09:36:22 +0200
Message-ID: <20170410073622.2y6tnpcd2ssuoztz@hirez.programming.kicks-ass.net>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <20170320145131.GA3623@htj.duckdns.org>
 <20170320172233.GA28391@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170320172233.GA28391@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 20, 2017 at 05:22:33PM +0000, Patrick Bellasi wrote:

> a) Bias OPP selection.
>    Thus granting that certain critical tasks always run at least at a
>    specified frequency.
> 
> b) Bias TASKS placement, which requires an additional extension not
>    yet posted to keep things simple.
>    This allows heterogeneous systems, where different CPUs have
>    different capacities, to schedule important tasks in more capable
>    CPUs.

So I dislike the capacity min/max knobs because:

 1) capacity is more an implementation detail than a primary metric;
    illustrated per your above points in that it affects both, while in
    fact it actually modifies another metric, namely util_avg.

 2) they look like an absolute clamp for a best effort class; while it
    very much is not. This also leads to very confusing nesting
    properties re cgroup.

 3) they have absolutely unacceptable overhead in implementation. Two
    more RB tree operations per enqueue/dequeue is just not going to
    happen.

 4) they have muddled semantics, because while its presented as a task
    property, it very much is not. The max(min) and min(max) of all
    runnable tasks is applied to the aggregate util signal. Also see 2.


So 'nice' is a fairly well understood knob; it controls relative time
received between competing tasks (and we really should replace the cpu
controllers 'shares' file with a 'nice' file, see below).


I would much rather introduce something like nice-opp, which only
affects the OPP selection in a relative fashion. This immediately also
has a natural and obvious extension to cgroup hierarchies (just like
regular nice).


And could be folded as a factor in util_avg (just as we do with weight
in load_avg), although this will mess up everything else we use util for
:/. Or, alternatively, decompose the aggregate value upon usage and only
apply the factor for the current running task or something.... Blergh..
difficult..




---
 kernel/sched/core.c  | 29 +++++++++++++++++++++--------
 kernel/sched/fair.c  |  2 +-
 kernel/sched/sched.h |  1 +
 3 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 27b4dd55b0c7..20ed17369cb1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6963,18 +6963,31 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
-				struct cftype *cftype, u64 shareval)
+static int cpu_nice_write_s64(struct cgroup_subsys_state *css,
+				struct cftype *cftype, s64 val)
 {
-	return sched_group_set_shares(css_tg(css), scale_load(shareval));
+	struct task_group *tg = css_tg(css);
+	unsigned long weight;
+
+	int ret;
+
+	if (val < MIN_NICE || val > MAX_NICE)
+		return -EINVAL;
+
+	weight = sched_prio_to_weight[val - MIN_NICE];
+
+	ret = sched_group_set_shares(tg, scale_load(weight));
+
+	if (!ret)
+		tg->nice = val;
 }
 
-static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
+static u64 cpu_shares_read_s64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
 {
 	struct task_group *tg = css_tg(css);
 
-	return (u64) scale_load_down(tg->shares);
+	return (s64)tg->nice;
 }
 
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -7252,9 +7265,9 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 static struct cftype cpu_files[] = {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	{
-		.name = "shares",
-		.read_u64 = cpu_shares_read_u64,
-		.write_u64 = cpu_shares_write_u64,
+		.name = "nice",
+		.read_s64 = cpu_nice_read_s64,
+		.write_s64 = cpu_nice_write_s64,
 	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 76f67b3e34d6..8088043f46d1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9471,7 +9471,7 @@ int sched_group_set_shares(struct task_group *tg, unsigned long shares)
 	if (!tg->se[0])
 		return -EINVAL;
 
-	shares = clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_SHARES));
+	shares = clamp(shares, MIN_SHARES, scale_load(MAX_SHARES));
 
 	mutex_lock(&shares_mutex);
 	if (tg->shares == shares)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 57caf3606114..27f1ffe763bc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -283,6 +283,7 @@ struct task_group {
 	/* runqueue "owned" by this group on each cpu */
 	struct cfs_rq **cfs_rq;
 	unsigned long shares;
+	int nice;
 
 #ifdef	CONFIG_SMP
 	/*

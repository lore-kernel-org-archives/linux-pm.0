From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v4 08/12] sched: Add over-utilization/tipping point
 indicator
Date: Fri, 6 Jul 2018 13:39:21 +0200
Message-ID: <20180706113921.GT2458@hirez.programming.kicks-ass.net>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-9-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180628114043.24724-9-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 28, 2018 at 12:40:39PM +0100, Quentin Perret wrote:
>  static inline void update_sg_lb_stats(struct lb_env *env,
>  			struct sched_group *group, int load_idx,
>  			int local_group, struct sg_lb_stats *sgs,
> -			bool *overload)
> +			bool *overload, int *overutilized)

> @@ -8308,7 +8336,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  		}
>  
>  		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
> -						&overload);
> +						&overload, &overutilized);
>  
>  		if (local_group)
>  			goto next_group;

I'm thinking maybe we should reduce arguments here a little.

@load_idx and @local_group look to be trivially computable..

and possibly we could frob overload and overutilized in a single
variable with some flags?


diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 321cd5dcf2e8..091859069620 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8114,10 +8114,12 @@ static bool update_nohz_stats(struct rq *rq, bool force)
  * @overload: Indicate more than one runnable task for any CPU.
  */
 static inline void update_sg_lb_stats(struct lb_env *env,
-			struct sched_group *group, int load_idx,
-			int local_group, struct sg_lb_stats *sgs,
+			struct sched_group *group,
+			struct sg_lb_stats *sgs,
 			bool *overload)
 {
+	int local_group = cpumask_test_cpu(env->dst_cpu, sched_group_span(sd));
+	int load_idx = get_sd_load_idx(env->sd, env->idle);
 	unsigned long load;
 	int i, nr_running;
 
@@ -8278,7 +8280,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	struct sched_group *sg = env->sd->groups;
 	struct sg_lb_stats *local = &sds->local_stat;
 	struct sg_lb_stats tmp_sgs;
-	int load_idx, prefer_sibling = 0;
+	int prefer_sibling = 0;
 	bool overload = false;
 
 	if (child && child->flags & SD_PREFER_SIBLING)
@@ -8289,8 +8291,6 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		env->flags |= LBF_NOHZ_STATS;
 #endif
 
-	load_idx = get_sd_load_idx(env->sd, env->idle);
-
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
 		int local_group;
@@ -8305,8 +8305,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 				update_group_capacity(env->sd, env->dst_cpu);
 		}
 
-		update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
-						&overload);
+		update_sg_lb_stats(env, sg, sgs, &overload);
 
 		if (local_group)
 			goto next_group;

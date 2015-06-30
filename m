From: pang.xunlei@zte.com.cn
Subject: Re: [RFCv4 PATCH 25/34] sched: Add over-utilization/tipping point indicator
Date: Tue, 30 Jun 2015 17:35:41 +0800
Message-ID: <OF461FAF0B.652BAC50-ON48257E74.0030491E-48257E74.0034AB06@zte.com.cn>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com> <1431459549-18343-26-git-send-email-morten.rasmussen@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431459549-18343-26-git-send-email-morten.rasmussen@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, morten.rasmussen@arm.com, mturquette@linaro.org, peterz@infradead.org, preeti@linux.vnet.ibm.com, rjw@rjwysocki.net, sgurrappadi@nvidia.com, vincent.guittot@linaro.org, yuyang.du@intel.com, pang.xunlei@linaro.org
List-Id: linux-pm@vger.kernel.org

Hi Morten,

Morten Rasmussen <morten.rasmussen@arm.com> wrote 2015-05-13 AM 03:39:00:
> 
> [RFCv4 PATCH 25/34] sched: Add over-utilization/tipping point indicator
> 
> Energy-aware scheduling is only meant to be active while the system is
> _not_ over-utilized. That is, there are spare cycles available to shift
> tasks around based on their actual utilization to get a more
> energy-efficient task distribution without depriving any tasks. When
> above the tipping point task placement is done the traditional way,
> spreading the tasks across as many cpus as possible based on priority
> scaled load to preserve smp_nice.
> 
> The over-utilization condition is conservatively chosen to indicate
> over-utilization as soon as one cpu is fully utilized at it's highest
> frequency. We don't consider groups as lumping usage and capacity
> together for a group of cpus may hide the fact that one or more cpus in
> the group are over-utilized while group-siblings are partially idle. The
> tasks could be served better if moved to another group with completely
> idle cpus. This is particularly problematic if some cpus have a
> significantly reduced capacity due to RT/IRQ pressure or if the system
> has cpus of different capacity (e.g. ARM big.LITTLE).
> 
> cc: Ingo Molnar <mingo@redhat.com>
> cc: Peter Zijlstra <peterz@infradead.org>
> 
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> ---
>  kernel/sched/fair.c  | 35 +++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h |  3 +++
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f36ab2f3..5b7bc28 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4266,6 +4266,8 @@ static inline void hrtick_update(struct rq *rq)
>  }
>  #endif
> 
> +static bool cpu_overutilized(int cpu);
> +
>  /*
>   * The enqueue_task method is called before nr_running is
>   * increased. Here we update the fair scheduling stats and
> @@ -4276,6 +4278,7 @@ enqueue_task_fair(struct rq *rq, struct 
> task_struct *p, int flags)
>  {
>     struct cfs_rq *cfs_rq;
>     struct sched_entity *se = &p->se;
> +   int task_new = !(flags & ENQUEUE_WAKEUP);
> 
>     for_each_sched_entity(se) {
>        if (se->on_rq)
> @@ -4310,6 +4313,9 @@ enqueue_task_fair(struct rq *rq, struct 
> task_struct *p, int flags)
>     if (!se) {
>        update_rq_runnable_avg(rq, rq->nr_running);
>        add_nr_running(rq, 1);
> +      if (!task_new && !rq->rd->overutilized &&
> +          cpu_overutilized(rq->cpu))
> +         rq->rd->overutilized = true;
>     }
>     hrtick_update(rq);
>  }
> @@ -4937,6 +4943,14 @@ static int find_new_capacity(struct energy_env 
*eenv,
>     return idx;
>  }
> 
> +static unsigned int capacity_margin = 1280; /* ~20% margin */
> +
> +static bool cpu_overutilized(int cpu)
> +{
> +   return (capacity_of(cpu) * 1024) <
> +            (get_cpu_usage(cpu) * capacity_margin);
> +}
> +
>  /*
>   * sched_group_energy(): Returns absolute energy consumption of 
> cpus belonging
>   * to the sched_group including shared resources shared only by 
> members of the
> @@ -6732,11 +6746,12 @@ static enum group_type group_classify(struct
> lb_env *env,
>   * @local_group: Does group contain this_cpu.
>   * @sgs: variable to hold the statistics for this group.
>   * @overload: Indicate more than one runnable task for any CPU.
> + * @overutilized: Indicate overutilization for any CPU.
>   */
>  static inline void update_sg_lb_stats(struct lb_env *env,
>           struct sched_group *group, int load_idx,
>           int local_group, struct sg_lb_stats *sgs,
> -         bool *overload)
> +         bool *overload, bool *overutilized)
>  {
>     unsigned long load;
>     int i;
> @@ -6766,6 +6781,9 @@ static inline void update_sg_lb_stats(struct 
> lb_env *env,
>        sgs->sum_weighted_load += weighted_cpuload(i);
>        if (idle_cpu(i))
>           sgs->idle_cpus++;
> +
> +      if (cpu_overutilized(i))
> +         *overutilized = true;
>     }
> 
>     /* Adjust by relative CPU capacity of the group */
> @@ -6871,7 +6889,7 @@ static inline void update_sd_lb_stats(struct 
> lb_env *env, struct sd_lb_stats *sd
>     struct sched_group *sg = env->sd->groups;
>     struct sg_lb_stats tmp_sgs;
>     int load_idx, prefer_sibling = 0;
> -   bool overload = false;
> +   bool overload = false, overutilized = false;
> 
>     if (child && child->flags & SD_PREFER_SIBLING)
>        prefer_sibling = 1;
> @@ -6893,7 +6911,7 @@ static inline void update_sd_lb_stats(struct 
> lb_env *env, struct sd_lb_stats *sd
>        }
> 
>        update_sg_lb_stats(env, sg, load_idx, local_group, sgs,
> -                  &overload);
> +                  &overload, &overutilized);
> 
>        if (local_group)
>           goto next_group;
> @@ -6935,8 +6953,14 @@ static inline void update_sd_lb_stats(struct 
> lb_env *env, struct sd_lb_stats *sd
>        /* update overload indicator if we are at root domain */
>        if (env->dst_rq->rd->overload != overload)
>           env->dst_rq->rd->overload = overload;
> -   }
> 
> +      /* Update over-utilization (tipping point, U >= 0) indicator */
> +      if (env->dst_rq->rd->overutilized != overutilized)
> +         env->dst_rq->rd->overutilized = overutilized;
> +   } else {
> +      if (!env->dst_rq->rd->overutilized && overutilized)
> +         env->dst_rq->rd->overutilized = true;
> +   }
>  }
> 
>  /**
> @@ -8300,6 +8324,9 @@ static void task_tick_fair(struct rq *rq, 
> struct task_struct *curr, int queued)
>        task_tick_numa(rq, curr);
> 
>     update_rq_runnable_avg(rq, 1);
> +
> +   if (!rq->rd->overutilized && cpu_overutilized(task_cpu(curr)))
> +      rq->rd->overutilized = true;
>  }
> 
>  /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index b627dfa..a5d2d69 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -535,6 +535,9 @@ struct root_domain {
>     /* Indicate more than one runnable task for any CPU */
>     bool overload;
> 
> +   /* Indicate one or more cpus over-utilized (tipping point) */
> +   bool overutilized;
> +
>     /*
>      * The bit corresponding to a CPU gets set here if such CPU has more
>      * than one runnable -deadline task (as it is below for RT tasks).
> -- 
> 1.9.1
> 

The tipping point idea is great for EAS, but I wonder if it is 
an issue below that I found during my test:

I used rt-app to emulate the work load to test the patchset.

First of all, I added rt-app small work load gradually until 
the utilization was around the tipping point, and EAS worked 
great putting tasks on small cores.

Then I went on to add some extra small load to break the 
tipping point, immediately CFS load-balancer took over EAS
(as I could see the big cores had some tasks running), but 
at this point it seemed that the system fluctuated back and 
forth badly between the big cores and small cores, and the 
util result displayed by "top" was a bit weird.

I guess when exceeding the tipping point, CFS takes over EAS,
so it will migrate tasks from small cores to big cores, as
a result, the cpu util of small cores will be again below the 
tipping point due to some tasks migrated by CFS load-balancer, 
which will activate the EAS again.

Therefore, the system just fluctuates like that.

-Xunlei

--------------------------------------------------------
ZTE Information Security Notice: The information contained in this mail (and any attachment transmitted herewith) is privileged and confidential and is intended for the exclusive use of the addressee(s).  If you are not an intended recipient, any disclosure, reproduction, distribution or other dissemination or use of the information contained is strictly prohibited.  If you have received this mail in error, please delete it and notify us immediately.

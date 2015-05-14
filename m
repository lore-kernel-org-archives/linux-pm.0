From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [RFCv4 PATCH 31/34] sched: Energy-aware wake-up task placement
Date: Thu, 14 May 2015 16:10:11 +0100
Message-ID: <20150514151011.GC26396@e105550-lin.cambridge.arm.com>
References: <1431459549-18343-1-git-send-email-morten.rasmussen@arm.com>
 <1431459549-18343-32-git-send-email-morten.rasmussen@arm.com>
 <OF168B7415.9556008C-ON48257E45.003388D7-48257E45.00349D8D@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39592 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933401AbbENPIk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 May 2015 11:08:40 -0400
Content-Disposition: inline
In-Reply-To: <OF168B7415.9556008C-ON48257E45.003388D7-48257E45.00349D8D@zte.com.cn>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>
Cc: Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "peterz@infradead.org" <peterz@infradead.org>, "preeti@linux.vnet.ibm.com" <preeti@linux.vnet.ibm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>

On Thu, May 14, 2015 at 10:34:20AM +0100, pang.xunlei@zte.com.cn wrote:
> Morten Rasmussen <morten.rasmussen@arm.com> wrote 2015-05-13 AM 03:39:06:
> > [RFCv4 PATCH 31/34] sched: Energy-aware wake-up task placement
> >
> > Let available compute capacity and estimated energy impact select
> > wake-up target cpu when energy-aware scheduling is enabled and the
> > system in not over-utilized (above the tipping point).
> >
> > energy_aware_wake_cpu() attempts to find group of cpus with sufficient
> > compute capacity to accommodate the task and find a cpu with enough spare
> > capacity to handle the task within that group. Preference is given to
> > cpus with enough spare capacity at the current OPP. Finally, the energy
> > impact of the new target and the previous task cpu is compared to select
> > the wake-up target cpu.
> >
> > cc: Ingo Molnar <mingo@redhat.com>
> > cc: Peter Zijlstra <peterz@infradead.org>
> >
> > Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> > ---
> >  kernel/sched/fair.c | 85 ++++++++++++++++++++++++++++++++++++++++++
> > ++++++++++-
> >  1 file changed, 84 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index bb44646..fe41e1e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5394,6 +5394,86 @@ static int select_idle_sibling(struct
> > task_struct *p, int target)
> >     return target;
> >  }
> >
> > +static int energy_aware_wake_cpu(struct task_struct *p)
> > +{
> > +   struct sched_domain *sd;
> > +   struct sched_group *sg, *sg_target;
> > +   int target_max_cap = INT_MAX;
> > +   int target_cpu = task_cpu(p);
> > +   int i;
> > +
> > +   sd = rcu_dereference(per_cpu(sd_ea, task_cpu(p)));
> > +
> > +   if (!sd)
> > +      return -1;
> > +
> > +   sg = sd->groups;
> > +   sg_target = sg;
> > +
> > +   /*
> > +    * Find group with sufficient capacity. We only get here if no cpu is
> > +    * overutilized. We may end up overutilizing a cpu by adding the task,
> > +    * but that should not be any worse than select_idle_sibling().
> > +    * load_balance() should sort it out later as we get above the tipping
> > +    * point.
> > +    */
> > +   do {
> > +      /* Assuming all cpus are the same in group */
> > +      int max_cap_cpu = group_first_cpu(sg);
> > +
> > +      /*
> > +       * Assume smaller max capacity means more energy-efficient.
> > +       * Ideally we should query the energy model for the right
> > +       * answer but it easily ends up in an exhaustive search.
> > +       */
> > +      if (capacity_of(max_cap_cpu) < target_max_cap &&
> > +          task_fits_capacity(p, max_cap_cpu)) {
> > +         sg_target = sg;
> > +         target_max_cap = capacity_of(max_cap_cpu);
> > +      }
> > +   } while (sg = sg->next, sg != sd->groups);
> > +
> > +   /* Find cpu with sufficient capacity */
> > +   for_each_cpu_and(i, tsk_cpus_allowed(p), sched_group_cpus(sg_target)) {
> > +      /*
> > +       * p's blocked utilization is still accounted for on prev_cpu
> > +       * so prev_cpu will receive a negative bias due the double
> > +       * accouting. However, the blocked utilization may be zero.
> > +       */
> > +      int new_usage = get_cpu_usage(i) + task_utilization(p);
> > +
> > +      if (new_usage >   capacity_orig_of(i))
> > +         continue;
> > +
> > +      if (new_usage <   capacity_curr_of(i)) {
> > +         target_cpu = i;
> > +         if (cpu_rq(i)->nr_running)
> > +            break;
> > +      }
> > +
> > +      /* cpu has capacity at higher OPP, keep it as fallback */
> > +      if (target_cpu == task_cpu(p))
> > +         target_cpu = i;
> > +   }
> > +
> > +   if (target_cpu != task_cpu(p)) {
> > +      struct energy_env eenv = {
> > +         .usage_delta   = task_utilization(p),
> > +         .src_cpu   = task_cpu(p),
> > +         .dst_cpu   = target_cpu,
> > +      };
> 
> At this point, p hasn't been queued in src_cpu, but energy_diff() below will
> still substract its utilization from src_cpu, is that right?

energy_aware_wake_cpu() should only be called for existing tasks, i.e.
SD_BALANCE_WAKE, so p should have been queued on src_cpu in the past.
New tasks (SD_BALANCE_FORK) take the find_idlest_{group, cpu}() route.

Or did I miss something?

Since p was last scheduled on src_cpu its usage should still be
accounted for in the blocked utilization of that cpu. At wake-up we are
effectively turning blocked utilization into runnable utilization. The
cpu usage (get_cpu_usage()) is the sum of the two and this is basis for
the energy calculations. So if we migrate the task at wake-up we should
remove the task utilization from the previous cpu and add it to dst_cpu.

As Sai has raised previously, it is not the full story. The blocked
utilization contribution of p on the previous cpu may have decayed while
the task utilization stored in p->se.avg has not. It is therefore
misleading to subtract the non-decayed utilization from src_cpu blocked
utilization. It is on the todo-list to fix that issue.

Does that make any sense?

Morten

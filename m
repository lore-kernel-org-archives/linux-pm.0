From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v3 08/14] sched/core: uclamp: extend cpu's cgroup
 controller
Date: Fri, 17 Aug 2018 15:24:15 +0100
Message-ID: <20180817142415.GK2960@e110439-lin>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-9-patrick.bellasi@arm.com>
 <82db1123-339f-0dbf-9332-7e37ee9e4f20@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <82db1123-339f-0dbf-9332-7e37ee9e4f20@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 17-Aug 14:21, Dietmar Eggemann wrote:
> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
> 
> [...]
> 
> >Give the above mechanisms, it is now possible to extend the cpu
> >controller to specify what is the minimum (or maximum) utilization which
> >a task is expected (or allowed) to generate.
> >Constraints on minimum and maximum utilization allowed for tasks in a
> >CPU cgroup can improve the control on the actual amount of CPU bandwidth
> >consumed by tasks.
> 
> I assume this is covered by the s/bandwidth/capacity/ you had w/ Juri on
> 01/14.

Yes... I need to update this changelog too.

> [...]
> 
> >diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >index ff76b000bbe8..2ba55a4afffb 100644
> >--- a/kernel/sched/core.c
> >+++ b/kernel/sched/core.c
> >@@ -1211,6 +1211,74 @@ static inline void uclamp_group_get(struct task_struct *p,
> >  	uclamp_group_put(clamp_id, prev_group_id);
> >  }
> >+#ifdef CONFIG_UCLAMP_TASK_GROUP
> >+/**
> >+ * init_uclamp_sched_group: initialize data structures required for TG's
> >+ *                          utilization clamping
> >+ */
> >+static inline void init_uclamp_sched_group(void)
> >+{
> >+	struct uclamp_map *uc_map;
> >+	struct uclamp_se *uc_se;
> >+	int group_id;
> >+	int clamp_id;
> >+
> >+	/* Root TG's is statically assigned to the first clamp group */
> >+	group_id = 0;
> >+
> >+	/* Initialize root TG's to default (none) clamp values */
> >+	for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> >+		uc_map = &uclamp_maps[clamp_id][0];
> >+
> >+		/* Map root TG's clamp value */
> >+		uclamp_group_init(clamp_id, group_id, uclamp_none(clamp_id));
> >+
> >+		/* Init root TG's clamp group */
> >+		uc_se = &root_task_group.uclamp[clamp_id];
> >+		uc_se->value = uclamp_none(clamp_id);
> >+		uc_se->group_id = group_id;
> >+
> >+		/* Attach root TG's clamp group */
> >+		uc_map[group_id].se_count = 1;
> >+	}
> >+}
> 
> Can you not save some lines here:
> 
>  static inline void init_uclamp_sched_group(void)
>  {
> -       struct uclamp_map *uc_map;
>         struct uclamp_se *uc_se;
>         int group_id;
>         int clamp_id;
> @@ -1228,8 +1227,6 @@ static inline void init_uclamp_sched_group(void)
> 
>         /* Initialize root TG's to default (none) clamp values */
>         for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> -               uc_map = &uclamp_maps[clamp_id][0];
> -
>                 /* Map root TG's clamp value */
>                 uclamp_group_init(clamp_id, group_id,
> uclamp_none(clamp_id));
> 
> @@ -1239,7 +1236,7 @@ static inline void init_uclamp_sched_group(void)
>                 uc_se->group_id = group_id;
> 
>                 /* Attach root TG's clamp group */
> -               uc_map[group_id].se_count = 1;
> +               uclamp_maps[clamp_id][group_id].se_count = 1;
>         }
> 
> This would also make uclamp_group_available() smaller.

Unfortunately this var name and its matrix indexes tends to become
quite long easily and in some usages we exceed the 80 columns sometimes.

That's why, for consistency, I always shortcut to *uc_map a reference
to a clamp group and use that variable name consistently in the code.

I'll see if it's possible to get rid of the shortcut in the next version.

-- 
#include <best/regards.h>

Patrick Bellasi

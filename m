From: Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 09/16] sched/core: uclamp: map TG's clamp values into
 CPU's clamp groups
Date: Sun, 9 Sep 2018 11:52:12 -0700
Message-ID: <CAJuCfpEbmW0Gr26FSDmtLB5C1gk0M83AYQihLr_Dz=gXY_-+qA@mail.gmail.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com> <20180828135324.21976-10-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828135324.21976-10-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 28, 2018 at 6:53 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> Utilization clamping requires to map each different clamp value
> into one of the available clamp groups used by the scheduler's fast-path
> to account for RUNNABLE tasks. Thus, each time a TG's clamp value
> sysfs attribute is updated via:
>    cpu_util_{min,max}_write_u64()
> we need to get (if possible) a reference to the new value's clamp group
> and release the reference to the previous one.
>
> Let's ensure that, whenever a task group is assigned a specific
> clamp_value, this is properly translated into a unique clamp group to be
> used in the fast-path (i.e. at enqueue/dequeue time).
> We do that by slightly refactoring uclamp_group_get() to make the
> *task_struct parameter optional. This allows to re-use the code already
> available to support the per-task API.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Quentin Perret <quentin.perret@arm.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
>
> ---
> Changes in v4:
>  Others:
>  - rebased on v4.19-rc1
>
> Changes in v3:
>  Message-ID: <CAJuCfpF6=L=0LrmNnJrTNPazT4dWKqNv+thhN0dwpKCgUzs9sg@mail.gmail.com>
>  - add explicit calls to uclamp_group_find(), which is now not more
>    part of uclamp_group_get()
>  Others:
>  - rebased on tip/sched/core
> Changes in v2:
>  - rebased on v4.18-rc4
>  - this code has been split from a previous patch to simplify the review
> ---
>  include/linux/sched.h | 11 +++--
>  kernel/sched/core.c   | 95 +++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 95 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 2da130d17e70..4e5522ed57e0 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -587,17 +587,22 @@ struct sched_dl_entity {
>   * The same "group_id" can be used by multiple scheduling entities, i.e.
>   * either tasks or task groups, to enforce the same clamp "value" for a given
>   * clamp index.
> + *
> + * Scheduling entity's specific clamp group index can be different
> + * from the effective clamp group index used at enqueue time since
> + * task groups's clamps can be restricted by their parent task group.
>   */
>  struct uclamp_se {
>         unsigned int value;
>         unsigned int group_id;
>         /*
> -        * Effective task (group) clamp value.
> -        * For task groups is the value (eventually) enforced by a parent task
> -        * group.
> +        * Effective task (group) clamp value and group index.
> +        * For task groups it's the value (eventually) enforced by a parent
> +        * task group.
>          */
>         struct {
>                 unsigned int value;
> +               unsigned int group_id;
>         } effective;
>  };
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b2d438b6484b..e617a7b18f2d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1250,24 +1250,51 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
>                                            struct task_group *parent)
>  {
>         struct uclamp_se *uc_se;
> +       int next_group_id;
>         int clamp_id;
>
>         for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
>                 uc_se = &tg->uclamp[clamp_id];
> +
>                 uc_se->effective.value =
>                         parent->uclamp[clamp_id].effective.value;
> -               uc_se->value = parent->uclamp[clamp_id].value;
> -               uc_se->group_id = parent->uclamp[clamp_id].group_id;
> +               uc_se->effective.group_id =
> +                       parent->uclamp[clamp_id].effective.group_id;
> +
> +               next_group_id = parent->uclamp[clamp_id].group_id;
> +               uc_se->group_id = UCLAMP_NOT_VALID;
> +               uclamp_group_get(NULL, clamp_id, next_group_id, uc_se,
> +                                parent->uclamp[clamp_id].value);
>         }
>
>         return 1;
>  }
> +
> +/**
> + * release_uclamp_sched_group: release utilization clamp references of a TG

free_uclamp_sched_group

> + * @tg: the task group being removed
> + *
> + * An empty task group can be removed only when it has no more tasks or child
> + * groups. This means that we can also safely release all the reference
> + * counting to clamp groups.
> + */
> +static inline void free_uclamp_sched_group(struct task_group *tg)
> +{
> +       struct uclamp_se *uc_se;
> +       int clamp_id;
> +
> +       for (clamp_id = 0; clamp_id < UCLAMP_CNT; ++clamp_id) {
> +               uc_se = &tg->uclamp[clamp_id];
> +               uclamp_group_put(clamp_id, uc_se->group_id);
> +       }
> +}
>  #else /* CONFIG_UCLAMP_TASK_GROUP */
>  static inline int alloc_uclamp_sched_group(struct task_group *tg,
>                                            struct task_group *parent)
>  {
>         return 1;
>  }
> +static inline void free_uclamp_sched_group(struct task_group *tg) { }
>  #endif /* CONFIG_UCLAMP_TASK_GROUP */
>
>  static inline int __setscheduler_uclamp(struct task_struct *p,
> @@ -1417,9 +1444,18 @@ static void __init init_uclamp(void)
>  #ifdef CONFIG_UCLAMP_TASK_GROUP
>                 /* Init root TG's clamp group */
>                 uc_se = &root_task_group.uclamp[clamp_id];
> +
>                 uc_se->effective.value = uclamp_none(clamp_id);
> -               uc_se->value = uclamp_none(clamp_id);
> -               uc_se->group_id = 0;
> +               uc_se->effective.group_id = 0;
> +
> +               /*
> +                * The max utilization is always allowed for both clamps.
> +                * This is required to not force a null minimum utiliation on
> +                * all child groups.
> +                */
> +               uc_se->group_id = UCLAMP_NOT_VALID;
> +               uclamp_group_get(NULL, clamp_id, 0, uc_se,
> +                                uclamp_none(UCLAMP_MAX));

I don't quite get why you are using uclamp_none(UCLAMP_MAX) for both
UCLAMP_MIN and UCLAMP_MAX clamps. I assume the comment above is to
explain this but I'm still unclear why this is done. Maybe expand the
comment to explain the intention? With this I think all TGs will get
boosted by default, won't they?

>  #endif
>         }
>  }
> @@ -1427,6 +1463,7 @@ static void __init init_uclamp(void)
>  #else /* CONFIG_UCLAMP_TASK */
>  static inline void uclamp_cpu_get(struct rq *rq, struct task_struct *p) { }
>  static inline void uclamp_cpu_put(struct rq *rq, struct task_struct *p) { }
> +static inline void free_uclamp_sched_group(struct task_group *tg) { }
>  static inline int alloc_uclamp_sched_group(struct task_group *tg,
>                                            struct task_group *parent)
>  {
> @@ -6984,6 +7021,7 @@ static DEFINE_SPINLOCK(task_group_lock);
>
>  static void sched_free_group(struct task_group *tg)
>  {
> +       free_uclamp_sched_group(tg);
>         free_fair_sched_group(tg);
>         free_rt_sched_group(tg);
>         autogroup_free(tg);
> @@ -7234,6 +7272,7 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
>   * @css: the task group to update
>   * @clamp_id: the clamp index to update
>   * @value: the new task group clamp value
> + * @group_id: the group index mapping the new task clamp value
>   *
>   * The effective clamp for a TG is expected to track the most restrictive
>   * value between the TG's clamp value and it's parent effective clamp value.
> @@ -7252,9 +7291,12 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
>   * be propagated down to all the descendants. When a subgroup is found which
>   * has already its effective clamp value matching its clamp value, then we can
>   * safely skip all its descendants which are granted to be already in sync.
> + *
> + * The TG's group_id is also updated to ensure it tracks the effective clamp
> + * value.
>   */
>  static void cpu_util_update_hier(struct cgroup_subsys_state *css,
> -                                int clamp_id, int value)
> +                                int clamp_id, int value, int group_id)
>  {
>         struct cgroup_subsys_state *top_css = css;
>         struct uclamp_se *uc_se, *uc_parent;
> @@ -7282,24 +7324,30 @@ static void cpu_util_update_hier(struct cgroup_subsys_state *css,
>                 }
>
>                 /* Propagate the most restrictive effective value */
> -               if (uc_parent->effective.value < value)
> +               if (uc_parent->effective.value < value) {
>                         value = uc_parent->effective.value;
> +                       group_id = uc_parent->effective.group_id;
> +               }
>                 if (uc_se->effective.value == value)
>                         continue;
>
>                 uc_se->effective.value = value;
> +               uc_se->effective.group_id = group_id;
>         }
>  }
>
>  static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
>                                   struct cftype *cftype, u64 min_value)
>  {
> +       struct uclamp_se *uc_se;
>         struct task_group *tg;
>         int ret = -EINVAL;
> +       int group_id;
>
>         if (min_value > SCHED_CAPACITY_SCALE)
>                 return -ERANGE;
>
> +       mutex_lock(&uclamp_mutex);
>         rcu_read_lock();
>
>         tg = css_tg(css);
> @@ -7310,11 +7358,25 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
>         if (tg->uclamp[UCLAMP_MAX].value < min_value)
>                 goto out;
>
> +       /* Find a valid group_id */
> +       ret = uclamp_group_find(UCLAMP_MIN, min_value);
> +       if (ret == -ENOSPC) {
> +               pr_err(UCLAMP_ENOSPC_FMT, "MIN");
> +               goto out;
> +       }
> +       group_id = ret;
> +       ret = 0;
> +
>         /* Update effective clamps to track the most restrictive value */
> -       cpu_util_update_hier(css, UCLAMP_MIN, min_value);
> +       cpu_util_update_hier(css, UCLAMP_MIN, min_value, group_id);
> +
> +       /* Update TG's reference count */
> +       uc_se = &tg->uclamp[UCLAMP_MIN];
> +       uclamp_group_get(NULL, UCLAMP_MIN, group_id, uc_se, min_value);
>
>  out:
>         rcu_read_unlock();
> +       mutex_unlock(&uclamp_mutex);
>
>         return ret;
>  }
> @@ -7322,12 +7384,15 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
>  static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
>                                   struct cftype *cftype, u64 max_value)
>  {
> +       struct uclamp_se *uc_se;
>         struct task_group *tg;
>         int ret = -EINVAL;
> +       int group_id;
>
>         if (max_value > SCHED_CAPACITY_SCALE)
>                 return -ERANGE;
>
> +       mutex_lock(&uclamp_mutex);
>         rcu_read_lock();
>
>         tg = css_tg(css);
> @@ -7338,11 +7403,25 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
>         if (tg->uclamp[UCLAMP_MIN].value > max_value)
>                 goto out;
>
> +       /* Find a valid group_id */
> +       ret = uclamp_group_find(UCLAMP_MAX, max_value);
> +       if (ret == -ENOSPC) {
> +               pr_err(UCLAMP_ENOSPC_FMT, "MAX");
> +               goto out;
> +       }
> +       group_id = ret;
> +       ret = 0;
> +
>         /* Update effective clamps to track the most restrictive value */
> -       cpu_util_update_hier(css, UCLAMP_MAX, max_value);
> +       cpu_util_update_hier(css, UCLAMP_MAX, max_value, group_id);
> +
> +       /* Update TG's reference count */
> +       uc_se = &tg->uclamp[UCLAMP_MAX];
> +       uclamp_group_get(NULL, UCLAMP_MAX, group_id, uc_se, max_value);
>
>  out:
>         rcu_read_unlock();
> +       mutex_unlock(&uclamp_mutex);
>
>         return ret;
>  }
> --
> 2.18.0
>

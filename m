From: Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 11/12] sched/core: uclamp: update CPU's refcount on
 TG's clamp changes
Date: Sat, 21 Jul 2018 20:17:57 -0700
Message-ID: <CAJuCfpFdxG=1hELqg4MQoKfRCTDCGCkuvkRS=QdYAjdkU=r_8Q@mail.gmail.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com> <20180716082906.6061-12-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180716082906.6061-12-patrick.bellasi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> When a task group refcounts a new clamp group, we need to ensure that
> the new clamp values are immediately enforced to all its tasks which are
> currently RUNNABLE. This is to ensure that all currently RUNNABLE task

tasks

> are boosted and/or clamped as requested as soon as possible.
>
> Let's ensure that, whenever a new clamp group is refcounted by a task
> group, all its RUNNABLE tasks are correctly accounted in their
> respective CPUs. We do that by slightly refactoring uclamp_group_get()
> to get an additional parameter *cgroup_subsys_state which, when
> provided, it's used to walk the list of tasks in the correspond TGs and

corresponding TGs

> update the RUNNABLE ones.
>
> This is a "brute force" solution which allows to reuse the same refcount
> update code already used by the per-task API. That's also the only way
> to ensure a prompt enforcement of new clamp constraints on RUNNABLE
> tasks, as soon as a task group attribute is tweaked.
>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Paul Turner <pjt@google.com>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Steve Muckle <smuckle@google.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Morten Rasmussen <morten.rasmussen@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> ---
>  kernel/sched/core.c | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 50613d3d5b83..42cff5ffddae 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1198,21 +1198,43 @@ static inline void uclamp_group_put(int clamp_id, int group_id)
>         raw_spin_unlock_irqrestore(&uc_map[group_id].se_lock, flags);
>  }
>
> +static inline void uclamp_group_get_tg(struct cgroup_subsys_state *css,
> +                                      int clamp_id, unsigned int group_id)
> +{
> +       struct css_task_iter it;
> +       struct task_struct *p;
> +
> +       /* Update clamp groups for RUNNABLE tasks in this TG */
> +       css_task_iter_start(css, 0, &it);
> +       while ((p = css_task_iter_next(&it)))
> +               uclamp_task_update_active(p, clamp_id, group_id);
> +       css_task_iter_end(&it);
> +}
> +
>  /**
>   * uclamp_group_get: increase the reference count for a clamp group
>   * @p: the task which clamp value must be tracked
> - * @clamp_id: the clamp index affected by the task
> - * @uc_se: the utilization clamp data for the task
> - * @clamp_value: the new clamp value for the task
> + * @css: the task group which clamp value must be tracked
> + * @clamp_id: the clamp index affected by the task (group)
> + * @uc_se: the utilization clamp data for the task (group)
> + * @clamp_value: the new clamp value for the task (group)
>   *
>   * Each time a task changes its utilization clamp value, for a specified clamp
>   * index, we need to find an available clamp group which can be used to track
>   * this new clamp value. The corresponding clamp group index will be used by
>   * the task to reference count the clamp value on CPUs while enqueued.
>   *
> + * When the cgroup's cpu controller utilization clamping support is enabled,
> + * each task group has a set of clamp values which are used to restrict the
> + * corresponding task specific clamp values.
> + * When a clamp value for a task group is changed, all the (active) tasks
> + * belonging to that task group must be update to ensure they are refcounting

must be updated

> + * the correct CPU's clamp value.
> + *
>   * Return: -ENOSPC if there are no available clamp groups, 0 on success.
>   */
>  static inline int uclamp_group_get(struct task_struct *p,
> +                                  struct cgroup_subsys_state *css,
>                                    int clamp_id, struct uclamp_se *uc_se,
>                                    unsigned int clamp_value)
>  {
> @@ -1240,6 +1262,10 @@ static inline int uclamp_group_get(struct task_struct *p,
>         uc_map[next_group_id].se_count += 1;
>         raw_spin_unlock_irqrestore(&uc_map[next_group_id].se_lock, flags);
>
> +       /* Newly created TG don't have tasks assigned */
> +       if (css)
> +               uclamp_group_get_tg(css, clamp_id, next_group_id);
> +
>         /* Update CPU's clamp group refcounts of RUNNABLE task */
>         if (p)
>                 uclamp_task_update_active(p, clamp_id, next_group_id);
> @@ -1307,7 +1333,7 @@ static inline int alloc_uclamp_sched_group(struct task_group *tg,
>                 uc_se->value = parent->uclamp[clamp_id].value;
>                 uc_se->group_id = UCLAMP_NONE;
>
> -               if (uclamp_group_get(NULL, clamp_id, uc_se,
> +               if (uclamp_group_get(NULL, NULL, clamp_id, uc_se,
>                                      parent->uclamp[clamp_id].value)) {
>                         ret = 0;
>                         goto out;
> @@ -1362,12 +1388,12 @@ static inline int __setscheduler_uclamp(struct task_struct *p,
>
>         /* Update min utilization clamp */
>         uc_se = &p->uclamp[UCLAMP_MIN];
> -       retval |= uclamp_group_get(p, UCLAMP_MIN, uc_se,
> +       retval |= uclamp_group_get(p, NULL, UCLAMP_MIN, uc_se,
>                                    attr->sched_util_min);
>
>         /* Update max utilization clamp */
>         uc_se = &p->uclamp[UCLAMP_MAX];
> -       retval |= uclamp_group_get(p, UCLAMP_MAX, uc_se,
> +       retval |= uclamp_group_get(p, NULL, UCLAMP_MAX, uc_se,
>                                    attr->sched_util_max);
>
>         mutex_unlock(&uclamp_mutex);
> @@ -7274,7 +7300,7 @@ static int cpu_util_min_write_u64(struct cgroup_subsys_state *css,
>
>         /* Update TG's reference count */
>         uc_se = &tg->uclamp[UCLAMP_MIN];
> -       ret = uclamp_group_get(NULL, UCLAMP_MIN, uc_se, min_value);
> +       ret = uclamp_group_get(NULL, css, UCLAMP_MIN, uc_se, min_value);
>
>  out:
>         rcu_read_unlock();
> @@ -7306,7 +7332,7 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
>
>         /* Update TG's reference count */
>         uc_se = &tg->uclamp[UCLAMP_MAX];
> -       ret = uclamp_group_get(NULL, UCLAMP_MAX, uc_se, max_value);
> +       ret = uclamp_group_get(NULL, css, UCLAMP_MAX, uc_se, max_value);
>
>  out:
>         rcu_read_unlock();
> --
> 2.17.1
>

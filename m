Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBFA4DEC34
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 14:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556320; cv=pass; b=R6OqLA/l8sPHL17tcWwyafmnlPSyeL6mMljvyKIXira4tgvsdlPIXNOeqwjsb/1tOxHroryjqZNU3MW6jRqSKzcVM3JxIwtqlCoRdt0s90KOLk9397wDcidbNgc+oH0uhVC21Lm6SBx5IUc+uKMPVjt2Us0+dzwFwPFUH1CX1OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556320; c=relaxed/simple;
	bh=8WemYrC/oSkykk2cbuno6NjVlVtiVXE9sVqDSzzwasY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Em4yBbvvbSjg6+wKpg6EBw9D7WuV/ezOfq+MJc8KeaCYg2bpA5flHLBY8nBdIH+CbBL2tnUeMpeCL4QQ/VQ8kcCcZFqOkRiq0Nd5fa6pHr6h2TQNi0PHGHnCUICFwdCFYEDpBNo0ZtssA4w5pZ/SK4qwJRUmlSDJXiowq9F+swA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QslhYVNM; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QslhYVNM"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2a4e013a44so1002857866b.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 07:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791556314; cv=none;
        d=google.com; s=arc-20260327;
        b=D3Z5FmB25ZPeXnL8Q+WR625Nm5WGfLLtC1nR3948j0q0O+WOEgRTejIS5I6acrObpb
         xiRhj13JXsUO8H7Spn/WW2HIBfvgpZyf4lBlFMVMmsVmx96hGhEX74PkObbCkyem7B5u
         3Y6vFRzkf6tf83m78zvSbXfSW1bT2crBIcOSu7xnQZNh8/UsNbrxOmGKFF84nqYEyxDW
         mnWRFHOAXpGVk8a6snBoZvSrCZsEYxO/Gw3g2Qf5OvijOOAEgsVs8l7k5jxWSdyS54v7
         5nEdhwKC0Bacu/0CnojChHMs8jZU+zBVyYDd4XArdKf6l8PLj+8z/A1+iaImU0jEL56n
         Cjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5PSoFAItGPZhsVEIFbAaCSaiW8S1Vyp54l9kPWqyoWk=;
        fh=ijx0beYCPav2FWk6opiroSgi755jsIAAHUne7/uxD5g=;
        b=V4CMP4PSxZ0tR5jJKH+pzM1BR+U5EFj+MxvdAOy02bNb612UA8uQIWElm/WSes/Rwo
         FKpcMKOs2O6wMM5mZzv6Cr5S5sPtpcVE6fHdjQOa3oLS5U1irWk2JEYLJLNZTM0g4Nuc
         FdKj0th77naPYaRt1FrRT278UogG/FhDSHGZJQcxzWwaIkV8HLgUzwtddz40AsOI4Etg
         Dcm4AjUcb1wjV/b6EIXqMi6ezdD+fu926sa+qGcGZdfak/sGgw/QHYLmwliLvaB11pxG
         kv4abO2lL7jrt8TJtCvLkNZYkyKs07u0QaXH23aMLH9GOZZdApFRI7fjd70O2fIZgInv
         OEHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791556314; x=1792161114; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5PSoFAItGPZhsVEIFbAaCSaiW8S1Vyp54l9kPWqyoWk=;
        b=QslhYVNMJf1686/44TXPgy0zE6zKXZfYdgspJFzaSNvAOe4nXD4yj5VAkvVgWWJMWn
         UG1AkYrSPR72HYcN7sc1Sp7J8s/HiijB0bCGFel+oM0+L3sbuOaa9m3cKbPmgfmb+EYe
         v+GD7fGLei5mho9AiHQuPY0C3Cpw3BcQwTmM2INH7B/viqseWgKObbuuLqxMLm8o/YKN
         f3b/B1Hdt/jO2WQLmOWIVtCDZQn+o5RMut39Fwc7dX3uwCYCqqAZxP8BPFOY5eDypY4D
         tPtpdc2/jzVbSl2uE4sMf6WquyGAMsCmIniHiSwc4xyhzpDB09f9WrrvqBIq9o95LHsh
         MzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791556314; x=1792161114;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5PSoFAItGPZhsVEIFbAaCSaiW8S1Vyp54l9kPWqyoWk=;
        b=nv7OREGe7fOJ3VO3ziBbEvNwQ7twtTB/UGh84bE6foWynK5ptYHsFVYET7o1ciP0bn
         Ur96Z/TeoVIw3P/evubJeJHxP2b79SYv6bcSvTfMKOi/brsbeVTNI0MY8psD7qaNi2Mk
         AGRcJ7QimsZEYi/zpoWULRVilsZVwuxf8n8DuBXFhAg33qZaJYc8FYcDYuW8UoJzQZjg
         CybYNE6Bqrgb9PicsGsRwi1vnc5sQUNjYTxss48a7yeI36WGSEBz63VlaICkopyDQdiN
         YmqC5gIuuI+G6cu1I1bNSfCVt6pIBdl96BQVL2llgo6wB0uvWFFd0JDNGwJK78ZIYD2L
         GWgA==
X-Forwarded-Encrypted: i=1; AKwUvBz+09eeQHixvlwKK6VkkDAdzJwx/PxgGyrq3sG9wG/6YfxUYhbDcR72IzPAIiXMPm62+uyOazsU9g==@vger.kernel.org
X-Gm-Message-State: AFq9FYKPkaaN4FDIb1tOUVHni0ZR+H+KRStTERVk7foWf5NRv/kgpQWf
	vo4/efLN1u7SkZ6I7dsHTCO12b7rtvpMQtbWWtSDOp6W0jJD1lP5Jj/qNo6UdSgwALCmMmHV5qI
	ri8xPhyonud8yu+S+KevGLNchAsuj7Tr/tl7GLSR7Gg==
X-Gm-Gg: AYBFou02zOy6zom1EpD0RxL2ITzdzVVvEBVplvyuZy/8mrUnDwaQShM5uxQGwoqLpZX
	g6l07M0v5Z/olnO2qYZ/0kVUO3ZgTtv1Y5lXEwjN1unVzKYBoV6NxTzXr1MpRltvnpUTacd5LSy
	EwiJsKv4bgPSYYD3w4rKnyCDIGxfgsS6eJPobxCfN9RAwpnasuEDGrd2+sZMzx+4TS9Y6996L0n
	qiJTbvCfkTYbwmX9jvexNE0s1I9dvzy1e7Wb16mfR/J/8q+Z9fLiEnNKXsx2wFWe5LNxWbAQELi
	SYu/GMGQNuKt9lU3lG65tAVklfx88gHaibKse1MfXlOWjXFTEj+06lXXxEoU/FltyXEmqX9CG63
	dKqv1xkIQ63og9o75LrECjg==
X-Received: by 2002:a17:907:a08a:b0:c2d:d289:e9ed with SMTP id
 a640c23a62f3a-c31aa0293b1mr220927066b.44.1791556311764; Fri, 09 Oct 2026
 07:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org> <asWyZtW7zPVo3k-A@chenyu-dev>
In-Reply-To: <asWyZtW7zPVo3k-A@chenyu-dev>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:31:40 +0200
X-Gm-Features: AclHuK-MW_1VEazm_dXyGcrzmICV3562LXn8DvrGfbug8xrX-mkbFJMdjIJUVpo
Message-ID: <CAKfTPtCyRiBbxT_bU8egEuXtRsOW6TGw3TczyObBLKsE99dMpQ@mail.gmail.com>
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
To: Chen Yu <yu.c.chen@intel.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, 
	qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	sshegde@linux.ibm.com, chen.yu@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Oct 2026 at 04:59, Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Fri, Oct 02, 2026 at 05:44:04PM +0200, Vincent Guittot wrote:
> > EAS is based on wakeup events to efficiently place tasks on the system, but
> > there are cases where a task doesn't have wakeup events anymore or at a far
> > too low pace. For such situation, we can take advantage of the task being
> > put back in the enqueued list to check if it should be pushed on another
> > CPU.
> >
> > Add a push task mechanism that enables fair scheduler to push runnable
> > tasks. EAS will be one user but other feature like filling idle CPUs or
> > short slice tasks can also take advantage of it.
> >
>
> A hackbench was launched on a Xeon server with 192 cores, using the default
> settings to see if there was any regression. According to the test results,
> there is no obvious difference, so I think it is good now. Later, I'll also
> test with a mix of different time slice workloads:
>
> =========================================
> Hackbench comparison
> BASE: baseline
> TEST: push
> =========================================
> MODE     G  FD |         BASE(s) |         TEST(s) |   DIFF% | RESULT
> ------- -- ----+-----------------+-----------------+---------+----------
> process 16  20 |     76.438/0.2% |     76.310/0.1% |   0.17% | IMPROVED
> process  1  20 |     52.532/2.3% |     51.217/1.1% |   2.50% | IMPROVED
> process  4  20 |     61.754/0.6% |     61.758/1.8% |  -0.01% | REGRESSED
> process  8  20 |     76.817/0.5% |     79.049/0.2% |  -2.91% | REGRESSED
> threads 16  20 |     66.290/1.5% |     67.120/3.5% |  -1.25% | REGRESSED
> threads  1  20 |     62.311/2.3% |     61.518/1.7% |   1.27% | IMPROVED
> threads  4  20 |     56.376/0.8% |     57.455/0.8% |  -1.91% | REGRESSED
> threads  8  20 |     63.871/3.8% |     68.611/0.3% |  -7.42% | REGRESSED
>
> Besides, as suggested by Qais, cache-aware scheduling could also be a user
> of the push mechanism. This is an evaluation patch that uses task push for
> cache-aware scheduling by allowing the cache-aware sensitive task to leverage
> the push path to be pushed to its preferred LLC.
>
> In my opinion, task pushing is triggered less frequently than task wakeup,
> because it has a high bar to be launched(preempted runnable task)
> This could reduce the risk of contention between the task pushing and the
> cache-aware load balancer, and achieve faster task aggregation on its
> preferred LLC.
>
> We have launched a simple migration test based on the following change, and
> will update later to see what the result is.
>
> ---
>  kernel/sched/fair.c  | 88 ++++++++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h |  1 +
>  2 files changed, 82 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7eea0414fd46..d5c6bbf04b47 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1391,7 +1391,8 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
>
>  #include "pelt.h"
>
> -static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu);
> +static int select_idle_sibling(struct task_struct *p, int prev_cpu, int cpu,
> +                              int push_cpu);
>  static unsigned long task_h_load(struct task_struct *p);
>  static unsigned long capacity_of(int cpu);
>
> @@ -9325,7 +9326,8 @@ static inline bool asym_fits_cpu(unsigned long util,
>  /*
>   * Try and locate an idle core/thread in the LLC cache domain.
>   */
> -static int select_idle_sibling(struct task_struct *p, int prev, int target)
> +static int select_idle_sibling(struct task_struct *p, int prev, int target,
> +                              int push_cpu)
>  {
>         bool has_idle_core = false;
>         struct sched_domain *sd;
> @@ -9348,6 +9350,19 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>          */
>         lockdep_assert_irqs_disabled();
>
> +       /*
> +        * push_cpu must be checked before the target: when
> +        * a task is pushed from the tick, it is rq->curr, so
> +        * idle_cpu_without() would consider the target as
> +        * idle and keep the task on its current (non-preferred) LLC.
> +        */
> +       if (push_cpu != -1 && push_cpu != target && !cpus_share_cache(push_cpu, target)) {
> +               target = push_cpu;
> +               if (choose_idle_cpu(push_cpu, p) &&
> +                   asym_fits_cpu(task_util, util_min, util_max, push_cpu))
> +                       goto select_smt_priority;
> +       }
> +
>         if (choose_idle_cpu(target, p) &&
>             asym_fits_cpu(task_util, util_min, util_max, target))
>                 goto select_smt_priority;
> @@ -10156,6 +10171,15 @@ static bool check_pushable_short_task(struct rq *rq, struct task_struct *p)
>         return false;
>  }
>
> +#ifdef CONFIG_SCHED_CACHE
> +static int check_pushable_cache_task(int this_cpu, struct task_struct *p);
> +#else
> +static inline int check_pushable_cache_task(int this_cpu, struct task_struct *p)
> +{
> +       return -1;
> +}
> +#endif
> +
>  static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
>  {
>         if (!__check_pushable_fair_task(rq, p))
> @@ -10167,6 +10191,9 @@ static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struc
>         if (check_pushable_short_task(rq, p))
>                 return true;
>
> +       if (check_pushable_cache_task(rq->cpu, p) != -1)
> +               return true;
> +
>         return false;
>  }
>
> @@ -10231,7 +10258,7 @@ static bool fair_push_task(struct rq *rq)
>         if (!raw_spin_trylock(&next_task->pi_lock))
>                 return true;
>
> -       new_cpu = select_task_rq_fair(next_task, prev_cpu, 0);
> +       new_cpu = select_task_rq_fair(next_task, prev_cpu, WF_RQ_PUSH);
>
>         /* Task doesn't need to migrate */
>         if (new_cpu == prev_cpu)
> @@ -10335,7 +10362,7 @@ static inline bool tick_pushable_task(struct task_struct *p, struct rq *rq, stru
>         if (!raw_spin_trylock(&p->pi_lock))
>                 return false;
>
> -       new_cpu = select_task_rq_fair(p, cpu, 0);
> +       new_cpu = select_task_rq_fair(p, cpu, WF_RQ_PUSH);
>
>         raw_spin_unlock(&p->pi_lock);
>
> @@ -10382,7 +10409,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
>  {
>         int sync = (select_flags & WF_SYNC) && !(current->flags & PF_EXITING);
>         int want_sibling = !(select_flags & (WF_EXEC | WF_FORK));
> -       int new_cpu, cpu = smp_processor_id();
> +       int new_cpu, cpu = smp_processor_id(), push_cpu;
>         struct sched_domain *tmp, *sd = NULL;
>         /* SD_flags and WF_flags share the first nibble */
>         int sd_flag = select_flags & 0xF;
> @@ -10414,6 +10441,15 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
>         if (select_flags & WF_TTWU)
>                 want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
>
> +       /*
> +        * Only a push triggered by cache aware scheduling will push the
> +        * task towards its preferred LLC. Pushes for other reasons, like short
> +        * slice task, uses the default push strategy.
> +        */
> +       push_cpu = -1;
> +       if (select_flags & WF_RQ_PUSH)
> +               push_cpu = check_pushable_cache_task(prev_cpu, p);

Is there any reason that you do'nt want to migrate the task at wakeup too ?

> +
>         new_cpu = prev_cpu;
>
>         for_each_domain(cpu, tmp) {
> @@ -10441,7 +10477,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
>                         break;
>         }
>
> -       /* Slow path */
> +       /* Slow path,  push task will not go inside due to flags = 0 */
>         if (unlikely(sd)) {
>                 new_cpu = sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
>                 return select_idle_smt_cpu(p, new_cpu);
> @@ -10449,7 +10485,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
>
>         /* Fast path */
>         if (want_sibling)
> -               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
> +               new_cpu = select_idle_sibling(p, prev_cpu, new_cpu, push_cpu);
>
>         return new_cpu;
>  }
> @@ -11572,6 +11608,44 @@ static bool migrate_degrades_llc(struct task_struct *p, struct lb_env *env)
>         return true;
>  }
>
> +/*
> + * Return the preferred CPU that task p running on this_cpu should be
> + * pushed to for better LLC locality, or -1 if no such push is wanted.
> + */
> +static int check_pushable_cache_task(int this_cpu, struct task_struct *p)
> +{
> +       struct sched_cache_group *grp;
> +       int pref_cpu;
> +
> +       if (!sched_cache_enabled())
> +               return -1;
> +
> +       /* preemption already disabled */
> +       grp = rcu_dereference_all(p->sched_cache_grp);
> +       if (!grp)
> +               return -1;
> +
> +       pref_cpu = READ_ONCE(grp->cpu);
> +       /* If the task's pref_cpu is on the wrong(non-preferred) LLC, move it there */
> +       if (pref_cpu == -1 || cpus_share_cache(pref_cpu, this_cpu))
> +               return -1;
> +
> +       if (!cpumask_test_cpu(pref_cpu, p->cpus_ptr) ||
> +           !cpumask_test_cpu(pref_cpu, cpu_active_mask))
> +               return -1;
> +
> +#ifdef CONFIG_NUMA_BALANCING
> +       if (static_branch_likely(&sched_numa_balancing) &&
> +           p->numa_preferred_nid != NUMA_NO_NODE &&
> +           p->numa_preferred_nid != cpu_to_node(pref_cpu))
> +               return -1;
> +#endif
> +       if (can_migrate_llc(this_cpu, pref_cpu, task_util(p), true) == mig_forbid)
> +               return -1;
> +
> +       return pref_cpu;
> +}
> +
>  #else
>  static inline bool get_llc_stats(int cpu, unsigned long *util,
>                                  unsigned long *cap)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 95a18c0d21c6..85527034572d 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2559,6 +2559,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
>  #define WF_CURRENT_CPU         0x40 /* Prefer to move the wakee to the current CPU. */
>  #define WF_RQ_SELECTED         0x80 /* ->select_task_rq() was called */
>  #define WF_TTWU_RQ             0x100 /* Wakeup completed through ttwu_runnable() */
> +#define WF_RQ_PUSH             0x200 /* Push the task  */
>
>  static_assert(WF_EXEC == SD_BALANCE_EXEC);
>  static_assert(WF_FORK == SD_BALANCE_FORK);
> --
> 2.43.0
>

Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9327B53CA7E
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992253; cv=pass; b=c+S6iCRhMtMIDGDorzkQAzYc4haYZmKu9caXxd4J1K0Ive8wXKpruoDsHPxxJIVp+sba7jO8JlthzcnwY9C23NwjMuVAWrn3OIPUDU4NUM8WEnSBRl/ruyswRnowk6zShTuSsZbxne7BHvnHoFt8vBnIPFNHRkJ/GuZsb7JAbgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992253; c=relaxed/simple;
	bh=eN9RmH4BI2cnExW/4JcWr15L/o/fC5a8DaLSvML2mAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otCco+jhynqf8VOBER+qnsYiIjGn0RnjTOF10DM6WQBDo+sGg5samYTrF6YYGz45XYKH2F1+28359MdFHllMCyUGNaMfQsOk01UHXPkQ7q94X0PLIm6hM5uWx2N2tfX+e0Gxml9op39EtHaV2GxqQGuo/5IapiyVSPebqkSaFYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CrKd5u+7; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CrKd5u+7"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c38ac26cc5dso219934066b.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 08:37:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791992250; cv=none;
        d=google.com; s=arc-20260327;
        b=eXwJI2AsAWhOgyxdUt6mFTG8tubvug+fzM4AhBcwYo4iy5HeZSi8O15Wh+8/RiwI9e
         uuE73UsI0GaVXi5kzAFWPtlx3j01ir52Is863t2TPKa6FqkIxHAg+RwADb4aaXWV9LlD
         yfbnzSRDVlaA27ydUCl+fo6yufWGesZve448/jD6SLueNxiWWw8m0LSKO4ufYG6hFZ76
         2bQCTqJSOQcFKX0IP4LJPHK/2IhoQ+gkRrtVoA9rtuQLtN2FBqqRZJaKGSXtoPXL4igx
         +hfOLwX3YFFgdjN8tW8l6Z1wKCIEmdqHdMWEHvwLLT3R04lGwPZdK7MEEyWRI3imMV3u
         vWuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fnNwm6C79wpN7fbQEqclVUnBkZYtp3MvR4gRBYtaF2g=;
        fh=OK34sq1VIMitGvRLZLR1plmrh3nPBNAW7cg+A8sJhu8=;
        b=gZWuzYzufAKBIETym7aSuhNx/EAT1pwBfnYdlOuhjF3U+4H9/zULa+MlTBUK7taCEF
         12iCMdhOTFu5WqTQjNJXuHk/l/7F5fW2O6FTyJ+/NUpn7p0XEjWZwACjge8qbiqaWC4z
         QWd9mMQqi+wYESR4YuTr9+N2Rjn/Iz6sH+hs2n34ee34BYrM0xbjZM/iQR804NGtLAfl
         CnIrWbgnSmzTBATLRWBHsv1Onl4oqerHNg5dnhL5yY/jWlbMg0ABIC5x9+u98z++HSsa
         YCE7cZoYMhuKJX9N9v0hxZx1Eh+0UQnjzYpshRRiid3OYpw18Rq9+ndqeWaEyWiVVMZb
         jdug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791992250; x=1792597050; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fnNwm6C79wpN7fbQEqclVUnBkZYtp3MvR4gRBYtaF2g=;
        b=CrKd5u+747hxNi5W2Gu729RrDHs7Q/8rLF0k6JIWI0cWgzI39nXR2BKPBKZdy7GplZ
         f4V/5XlZXK68Eo3x14dcEtHa1q9tUKsaG5xSucR6PXL+Cpft7p7wVEipXu8RkK+msuX2
         JuXjDV35WtqnqQoODHIKY5l0YV9w65RVkUXV+KdD0fdeVuLR8QKE6b1J5hwMjFEW8kbF
         cVAgM/irL0tjpuNZi9aEq0Qi/+cSCRBi5MWvB31aV7nKyEuLy9zbK+gmRFVxPmw9TuqB
         Pml22URKV4uFE2us55ok1cmbHT/7PfmxZaTwEh1QH8nYMA4dH8yZlrBaHR38D7zb6IPY
         EyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791992250; x=1792597050;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fnNwm6C79wpN7fbQEqclVUnBkZYtp3MvR4gRBYtaF2g=;
        b=08HwZl38wOsshT6CvCoRAdrx+gRBRBqJlkeRRfzTYiEukopAReZ13qub1SzWj19tMm
         tz0M5kZ0lzNkEJp8o30kugEoSc7pClW/gKGiM73CHWhrlhW3NbhH0SYMpWYpt+3baosW
         N5a87U0VliFP/NmbQ7wioUMvFiu+a/QCMXz9+iEjYsY04cE3OK2q7yJVIAbGdZtSsn/Q
         44uVYWvObK6GtPmfDkEmG0T5Z7c26Rfu/YHvZiOGfy1O2YTFfT4VjCQBN/9/ALLFdIYj
         f9VYbfQL0zQyn47n9oBoRer0TpUhAm4qUWeZ4vpHyguDRB4EVon+aUSmWj5vNSMmCHWA
         UjVA==
X-Forwarded-Encrypted: i=1; AKwUvBwFewsFE0V0QNGTXVZcxR5yD63opz74nPWcyC0mxit8LYj/Rd1BippZggxTI2HmGXXdTie5vTwOCA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ2gI2mZZL4mTz6jGZ+ma8tJZJ5BPVVn7WnXBnm40KrqyfrenHs
	mFyA5QZBqnpRiFb6hp6wbDmnPHVSbebm5/hzvxR8T6Yyvu69cZ4JFGDjRqXPDaR6+QgV+0BAZgM
	L5eAqEcahgd4SbLno+YvmM+AfIG9+TI6cliDaifgOYA==
X-Gm-Gg: AYBFou2JK5CwDLs0xJYobc3B6dePg5QBN9Exy82PFU5NSCPZjMCbS/P+Wc9ZwgZPQGU
	t42K1t8iOd7GLwW0BhTaFzZcsVyRrZyfGEBZIr2MFqsdxVpNc6E1x0Y1vaa1Wfr7wOp5PRreZ4t
	oEwRIFIanC0LpWIlrKMnW305Qd4FTvpefboUmfRKEQ5w3avJgyLNZAF8//fL/LJRnCxbqDY7eEZ
	LuzMR4Qf/a/2W6/wtScBtnmviDIAUod4PYkxDvWOh9O17i0QU8q3rGJV+bd5pZJR7H00qQU9Pk3
	JUbt8I+EAc2nbBHYYMGCb6T2xch6+EZNpZEWMYGqtORe7FnDxwQ7nDBZkwGEkuhj6hXk5IX/bvZ
	Ujk3oKXCEzUA=
X-Received: by 2002:a17:907:eccc:b0:c25:4f7c:8ec5 with SMTP id
 a640c23a62f3a-c31aa0291acmr1487426866b.23.1791992249514; Wed, 14 Oct 2026
 08:37:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
 <20261002154415.2270586-8-vincent.guittot@linaro.org> <a18e6fe1-e14e-46be-9779-3704ab8625a0@linux.ibm.com>
In-Reply-To: <a18e6fe1-e14e-46be-9779-3704ab8625a0@linux.ibm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 14 Oct 2026 17:37:17 +0200
X-Gm-Features: AclHuK-CGGWcfZAYs4XYXiC55pivspaDbdCD0_NPFeWvFdImCVIM28r15KKP_4U
Message-ID: <CAKfTPtDkSs8KOUYAdSOz_h93khGbT6TaVc9gCa1Cpa0JbmKEGw@mail.gmail.com>
Subject: Re: [PATCH 07/18] sched/fair: Add push task mechanism for fair
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: qyousef@layalina.io, christian.loehle@arm.com, pierre.gondois@arm.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, 
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com, rafael@kernel.org, 
	linux-pm@vger.kernel.org, tj@kernel.org, void@manifault.com, 
	arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Oct 2026 at 16:07, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>
> Hi Vincent,
>
> Disclaimer:
> I haven't read the full series yet. I will try to do. Sorry in case i read
> it wrong.
> Thought of quickly checking the push path since i had recently worked on it.
>
> On 10/2/26 9:14 PM, Vincent Guittot wrote:
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
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/core.c  |   4 +-
> >   kernel/sched/fair.c  | 163 +++++++++++++++++++++++++++++++++++++++++++
> >   kernel/sched/sched.h |   7 ++
> >   3 files changed, 172 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 837dc74c9a8d..18692b752814 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2553,8 +2553,8 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
> >    *
> >    * Returns (locked) new rq. Old rq's lock is released.
> >    */
> > -static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
> > -                                struct task_struct *p, int new_cpu)
> > +struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
> > +                         struct task_struct *p, int new_cpu)
> >       __must_hold(__rq_lockp(rq))
> >   {
> >       lockdep_assert_rq_held(rq);
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index f12678850ce2..00078ac7fada 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8179,6 +8179,8 @@ static void dequeue_hierarchy(struct task_struct *p, int flags)
> >       }
> >   }
> >
> > +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
> > +
> >   /*
> >    * The part of dequeue_task_fair() that is needed to dequeue delayed tasks.
> >    *
> > @@ -8195,6 +8197,7 @@ static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
> >       bool task_delayed = flags & DEQUEUE_DELAYED;
> >
> >       clear_buddies(cfs_rq, se);
> > +     fair_remove_pushable_task(rq, p);
> >
> >       update_curr_eevdf(cfs_rq);
> >       update_entity_lag(cfs_rq, se);
> > @@ -9799,6 +9802,157 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >       return target;
> >   }
> >
> > +DEFINE_STATIC_KEY_FALSE(sched_push_task);
> > +
> > +static inline bool sched_push_task_enabled(void)
> > +{
> > +     return static_branch_unlikely(&sched_push_task);
> > +}
> > +
> > +static bool __check_pushable_fair_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     if (!task_on_rq_queued(p))
> > +             return false;
> > +
> > +     if (p->se.sched_delayed)
> > +             return false;
> > +
> > +     if (p->nr_cpus_allowed <= 1)
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
> > +static bool fair_check_pushable_task(struct rq *rq, struct task_struct *p, struct task_struct *next)
> > +{
> > +     if (!__check_pushable_fair_task(rq, p))
> > +             return false;
> > +
> > +     return false;
> > +}
> > +
> > +static inline int has_pushable_tasks(struct rq *rq)
> > +{
> > +     return !plist_head_empty(&rq->cfs.pushable_tasks);
> > +}
> > +
>
> Should this use static key?
>
> > +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
> > +{
> > +     struct task_struct *p;
> > +
> > +     if (!has_pushable_tasks(rq))
> > +             return NULL;
> > +
> > +     p = plist_first_entry(&rq->cfs.pushable_tasks,
> > +                           struct task_struct, pushable_tasks);
> > +
> > +     WARN_ON_ONCE(rq->cpu != task_cpu(p));
> > +     WARN_ON_ONCE(task_current(rq, p));
> > +     WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
> > +     WARN_ON_ONCE(!task_on_rq_queued(p));
> > +
> > +     /*
> > +      * Remove task from the pushable list as we try only once after that
> > +      * the task has been put back in enqueued list.
> > +      */
> > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +
> > +     return p;
> > +}
> > +
> > +static int
> > +select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags);
> > +
> > +/*
> > + * See if the non running fair tasks on this rq can be sent on other CPUs
> > + * that fits better with their profile.
> > + */
> > +static bool fair_push_task(struct rq *rq)
> > +{
> > +     struct task_struct *next_task;
> > +     int prev_cpu, new_cpu;
> > +     struct rq_flags rf;
> > +     struct rq *cur_rq;
>
> You likely need below to keep clang's context tracking to be happy.
>
>         context_unsafe_alias(rq);

I just noticed that I didn't answer to this one

Why should I need this ?

rq remains the same in fair_push_task(). I'm using rq and new_rq to
differentiate both current and new rq

>
> > +
> > +     next_task = pick_next_pushable_fair_task(rq);
> > +     if (!next_task)
> > +             return false;
> > +
> > +     if (is_migration_disabled(next_task))
> > +             return true;
>
> If migration is disabled, then it shouldn't endup on pushable_tasks?
>
> > +
> > +     /* We might release rq lock */
> > +     get_task_struct(next_task);
> > +
> > +     prev_cpu = rq->cpu;
> > +
> > +     /*
> > +      * We need to release rq lock and take both task and rq w/o
> > +      * triggering a deadlock.
> > +      */
> > +     raw_spin_rq_unlock(rq);
> > +
> > +     cur_rq = task_rq_lock(next_task, &rf);
> > +
> > +     /* Task already migrated */
> > +     if (cur_rq->cpu != prev_cpu)
> > +             goto skip_push;
> > +
> > +     new_cpu = select_task_rq_fair(next_task, prev_cpu, 0);
> > +
> > +     /* Task doesn't need to migrate */
> > +     if (new_cpu == prev_cpu)
> > +             goto skip_push;
> > +
> > +     update_rq_clock(cur_rq);
> > +     cur_rq = move_queued_task(cur_rq, &rf, next_task, new_cpu);
> > +
> > +skip_push:
> > +     task_rq_unlock(cur_rq, next_task, &rf);
> > +
> > +     /* Restore rq state */
> > +     raw_spin_rq_lock(rq);
> > +     put_task_struct(next_task);
> > +
> > +     return true;
> > +}
> > +
> > +static void fair_push_tasks(struct rq *rq)
> > +{
> > +     /* fair_push_task() will return true if it moved a fair task */
> > +     while (fair_push_task(rq))
> > +             ;
> > +}
>
> Would it better to iterate through the list? This is bit difficult
> to read at first.
>
> In failure cases also, it can return true. No? for example,
> is_migration_disabled(), It is needed since you need to iterate the
> rq to see if there is a task to move.
>
> > +
> > +static DEFINE_PER_CPU(struct balance_callback, fair_push_head);
> > +
> > +static inline void fair_queue_push_tasks(struct rq *rq)
> > +{
> > +     if (!sched_push_task_enabled() || !has_pushable_tasks(rq))
> > +             return;
> > +
> > +     queue_balance_callback(rq, &per_cpu(fair_push_head, rq->cpu), fair_push_tasks);
> > +}
> > +
> > +static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     if (sched_push_task_enabled())
> > +             plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +}
> > +
> > +static void __fair_add_pushable_task(struct rq *rq, struct task_struct *p)
> > +{
> > +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +     plist_node_init(&p->pushable_tasks, p->prio);
> > +     plist_add(&p->pushable_tasks, &rq->cfs.pushable_tasks);
> > +}
> > +
> > +static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev, struct task_struct *next)
> > +{
> > +     if (sched_push_task_enabled() && fair_check_pushable_task(rq, prev, next))
> > +             __fair_add_pushable_task(rq, prev);
> > +}
> > +
> >   /*
> >    * select_task_rq_fair: Select a target runqueue for the task.
> >    * There are 2 ways to select the target runqueue:
> > @@ -10272,6 +10426,12 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
> >       cfs_rq->curr = NULL;
> >       if (se->on_rq)
> >               __enqueue_entity(cfs_rq, se);
> > +
> > +     /*
> > +      * The previous task might be eligible for being pushed on another cpu
> > +      * if it is still active.
> > +      */
> > +     fair_add_pushable_prev(rq, prev, next);
> >   }
> >
> >   /*
> > @@ -15379,6 +15539,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
> >               goto repick;
> >
> >       clear_buddies(cfs_rq, se);
> > +     fair_remove_pushable_task(rq, p);
> >
> >       if (on_rq)
> >               __dequeue_entity(cfs_rq, se);
> > @@ -15423,6 +15584,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, enum snt_e
> >
> >       update_misfit_status(p, rq);
> >       sched_fair_update_stop_tick(rq, p);
> > +     fair_queue_push_tasks(rq);
> >
> >   repick:
> >       /*
> > @@ -15439,6 +15601,7 @@ void init_cfs_rq(struct cfs_rq *cfs_rq)
> >   {
> >       cfs_rq->tasks_timeline = RB_ROOT_CACHED;
> >       cfs_rq->zero_vruntime = (u64)(-(1LL << 20));
> > +     plist_head_init(&cfs_rq->pushable_tasks);
> >       raw_spin_lock_init(&cfs_rq->removed.lock);
> >   }
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index e025d2a6c302..74130bd2a2c8 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -721,6 +721,8 @@ struct cfs_rq {
> >               unsigned long   runnable_avg;
> >       } removed;
> >
> > +     struct plist_head       pushable_tasks;
> > +
> >   #ifdef CONFIG_FAIR_GROUP_SCHED
> >       u64                     last_update_tg_load_avg;
> >       unsigned long           tg_load_avg_contrib;
> > @@ -3877,6 +3879,8 @@ static inline bool sched_energy_enabled(void) { return false; }
> >
> >   #endif /* !(CONFIG_ENERGY_MODEL && CONFIG_CPU_FREQ_GOV_SCHEDUTIL) */
> >
> > +DECLARE_STATIC_KEY_FALSE(sched_push_task);
> > +
> >   #ifdef CONFIG_MEMBARRIER
> >
> >   /*
> > @@ -4209,6 +4213,9 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
> >       wakeup_preempt(dst_rq, task, 0);
> >   }
> >
> > +extern struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
> > +                                struct task_struct *p, int new_cpu);
> > +
> >   static inline
> >   bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
> >   {
>

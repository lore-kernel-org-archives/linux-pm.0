Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702A44A409
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791962379; cv=pass; b=pOfHAn6b6KqWLsjH5I4izYOD4ltXzJmjufrcTJLBlwCmKrLFA+s7HJU/gQOL6r2URc4TFVnLkcKE69EzqHCm9Y868TVQe+U2mwMzSAfAMWwgvHMNqWNRX4o2Org7kz+7Thhs5l1d9NfxrdmAfx3f9yweeCR/3sGmfv1nEhG+ByQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791962379; c=relaxed/simple;
	bh=+nKE0aerXq5zcerPMktiueb2dpi7N/wqcFUGs1sFppk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmZ79v+CRe0MWAqV4FKhXrjrGC4GzeeCKYI/isEv81Mi1RH1dvyOE3psVDjOr2V3py/1dHbGhzUN3aeeVBrDfMS6y8uER5fLJ7D8DGJBYleQGtzGTRmH1O8/GiCuid/XRe5hfE0NJBSlNeo0B0kcnJLYySROTaV4wp9k9Um6JkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJHEFm4D; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJHEFm4D"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c2afa22e1dcso536160866b.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 00:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791962375; cv=none;
        d=google.com; s=arc-20260327;
        b=qXp7zoI06OSnk1tE/21m1c2lFPv1L1RWHFISVuMELix5N8a/idHSurnud5jxowXGbx
         Izp1Ca96sGVFyGCT9CIuZqVTppMqG4zCaqDcMWvMLHb+kW4pH67wPZFgZ9Q8u2T5lEgw
         MNZkpuKuZ11nIgOYvkVExNqyD4arQxiCx91ttafB2KoUp8Bi0MpxbtzEj2rOvGPeEYut
         +oRMd4egcko7xFAS2+VGoPvooTbqilyONRMQ3RsV/bJGCKHpucHPGwVA7y45Eh0RZBjy
         zcJCsMify7ikGDp8MIyjuKr4OaJVCc++vWr3TsiTiDHglHHTT83U3PW3qwyxAXDybdQ6
         3ZgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qbDfcVSYXH9BTPxOSJl5CrroWP8L6dvonpMNak5vQvA=;
        fh=bMzMQ9ggy60xvJ8EXZ64/PlTPik4D9YUWMcLmeJhxn4=;
        b=lPTRJ0JJQAvrK+PhE31GsiDsjrjIdrwlSNszlJNtwNovuPPddvbjBfoRJD9Me2GjcA
         yDOlos5ZoDbtN9Vimxh9Hn6vHrc2JqLQAwuLGONCtnMEwWcBlzU0Ixl/vx/LWV0fj00W
         y/D8Vlg5G1YTBBWc0WnuTl2/IDltkvIrQx9OQJO+NPABTfNKWuZFliJD2YVqTeD1PYDC
         qMaNphWwait/d6aLa/rcqdnj/Q0+R+LCkPtvQqUYxbYZmdEo0ta7Rt7SA4iT5EvHY3df
         Ei13x+4lNdM00w6isr6XVOTuQE+WbpELAkbOOUZ9vGLlJexAx/6ZF2Gep1+qG6mKfC36
         E2Wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791962375; x=1792567175; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qbDfcVSYXH9BTPxOSJl5CrroWP8L6dvonpMNak5vQvA=;
        b=MJHEFm4DfeaFr5Y3s0VCOgVDhNeVCC5a1Qc0EJgfOwolWyAOIvQ0j/ELHnEXdb8Lkl
         vChBWsad3TsCZSqhT6F7j4Pzak1jqJM4RACHReV+LX4KJHDJKrl1N/OrwG5hCKrvNcjD
         xnQXJtVbVbiNfZlsBI0tub94qyAB50BlmBnQDaxl4TneGL6kVA3KrHd8rz0pf+NzknXS
         Y2A6i0mQQMkk3N4oXGgPu40hCfpZw+2ju55rMAaG/yTNYM80BBRT8VHsTvVgnQ3rCj8F
         jMQbvwo1nR9BXp83aLw1ZkB2fuR/DTJykNjHas/Q5FwE21gp5bSQuQbWjndZond7dPQk
         wzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791962375; x=1792567175;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qbDfcVSYXH9BTPxOSJl5CrroWP8L6dvonpMNak5vQvA=;
        b=AG7EetuHN+WsCsOBFBJbrf/E3VGESoplMpgZuFi1bH5h0ghrvEx3L6mUNmek6bkCo8
         0DlhGvQSQorSAehc87isgZnetwT2keWfnbvf/WRv7Cfab0ieXny/nbTXWhrNoSP/pROS
         fTC25HuPIwOhehDhU6Vh5b3JVNVCr/zUrgTNzdt0yuyjMxuqBvzspvCEJ542o1PRDHmT
         RXEC99gokjYtP/JJXnnoJFz4OPpnh6rWpEyWMHCfGlcr5AWmFL14ADYyPi+Y1sMMYadw
         6sfvB7LZF4g0u4zVz1dpHYo3x+VpK86SOuWxca6U1uYesKS9B4QfhgPdehRRoLgTKRTp
         BHcg==
X-Forwarded-Encrypted: i=1; AKwUvBxEt1Ip67MJR1xeCSg3J8yrCFusq5jH9iqs35dWJflllfmnuMSyCkw5AYygahD9kcx09ZYrtOYuZQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLl9aRdnCKvrr1qtOLOJ0iaRQxyzvU+llhfOWUwmdPt840rdWHV
	7MRLJJ8QUNtA6n6TQKR5yls+tm/V1yfQha3AHinbdD2k5naG79lrYGpuCnTL8qw5oYKIQH1MjVn
	S0f1ZuIq2dxmK8Yn+WjlPcJsuLRv9K8UJVj+38kUuSQ==
X-Gm-Gg: AYBFou0mjNXwHMZ4amGsmzXGE+v93k4sXr+SsPrR2Kc/Gagx5DkRRVZM1P1Yd1tjHGu
	qZEF7voxKHkA4vbpslb96TZQP6lHQ92MF6p8bRYYqO5jE0wqxo+HsOjPA/lfh1yH0PPPgEr13sq
	365fwOV1daM4N3BebZERSsZvIZyIuP8/dzfnsMWIarvm1XxMg7mqsrn7rV7cQSyYK6KMJb+MApk
	42oOZAzYElVayz58510Ce74/0+NmQbDEWsrqM2mEVBrolYvTe8AOFw2iLjI4xXu74Ofwy4nZAX/
	w3GAv2jmtg8OmwiFlkTKKpibgu/JXE96R5EurXJEG8c69X2JWYKuborND1Q07OU/Kh7GNTF39p7
	4f/CmvnxMRIg=
X-Received: by 2002:a17:907:6095:b0:c34:c5e8:1dc5 with SMTP id
 a640c23a62f3a-c34c5e82123mr828929666b.20.1791962373480; Wed, 14 Oct 2026
 00:19:33 -0700 (PDT)
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
Date: Wed, 14 Oct 2026 09:19:21 +0200
X-Gm-Features: AclHuK8o97-tByDZxo3ZbCUEwmJUGSdqAopCL1P-qHwY8E-185Z3bC_zZwQQAnI
Message-ID: <CAKfTPtCh1ZSWudmniet1UoGDAS3cQJYkLTuH-QuubGc8-rxOCw@mail.gmail.com>
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

Not needed, teh statis key has been test prior calling it

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

This can happen after it has been added to the list

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

I followed what is done in RT and deadline

>
> In failure cases also, it can return true. No? for example,
> is_migration_disabled(), It is needed since you need to iterate the
> rq to see if there is a task to move.

Yes, we skip the current task and continue witht the next one

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

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473956;
	b=esTlaNwsbsI5wInH3zDcC0mrqdasyEN0UXW0ZBlJMmITtlfvetIgzeC0yCJ11WkAtMzU
	 fWkuomclfCXKylwtd5omifuPvkW7a8OZ9xf18AIV0TTrRs8r8Y1vKlrwvJDe1lS8xMf9d
	 uR7FsLGxNs8eY0F+Dc8MwlKYa9VltBuE7tXSzcQf4g1ETLDTFWiDSSjsZ4IqFH9yfoGjF
	 8A06CfBYbP/bShM2J45dkaDzoIhUhLzK3BJUARhO0Bx6KtOnSEZR1uSYjxtQOhDUCPfNz
	 g9/A+5K+oym76J7d6m/5IgSUHrWX1JNITqJHa8StO6kDW0iSOK0aGJbIHla/bDqXVYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=bmJojf3pY/qEboTN92H+9CbR3tHwgZeXXWT8llFOKek=;
	b=kWCbrd2iEDOLbmI0M2D3KdQhFFoCLv2UCsPKO3hSWnl/3BU57pdiKSYOWmBvNNT67Ao7
	 fRb34qsX51MdAmZn5wdcd52pqzBIWMPaefA6reEsUyPJgSzpNXH4vz4qWyc8aKfiPzTEv
	 oD8XXDDrtcFH3n4Qjnw8uV2dwC6S4WeLRIVNeNbo3SyjANz2YRrEkzmfUU2olftAIwyWI
	 oBR1J4bV+MMX9QxjWCvJRauteNvDcqr/18IKsGY3x9RmLKE77jwOkFzPoao6oeXutKTfZ
	 Dl0RhjCuFPDlQYT+LHuhuL8wTinYHoY8aLAN9IkmW+9cAqdFqFEkuRMbHvhJjw5VSFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DBterSNJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA23606A327
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 08:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA23606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DBterSNJ
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c40e30c26a4so108339666b.0
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 00:59:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794473954; cv=none;
        d=google.com; s=arc-20260327;
        b=JgTxkR02WfrRjwin+b9aZahVZxiQMTML5er4dEsK+VDbPW+OAMHn3FkxN9dzAXtui5
         MdncZkSxEZmlYV60S5g/Ey85jJ9RYfpYmI7p6Mu9XQkDQhKQggmx9wVwxuvypjpr3Tnh
         4ZkIK/qnaQR1341xylZ9A8Pa+ev9iGVZhGulsWvF9aSPyzJyW4TPAWH3n/Sx/8ntXZSb
         PCDjh0GWv/TdwgUHYr0tVzM+D+eoG4wXIIluzGe5lavdasNDPZz+S/s6yeQZGMx1mmoL
         kd/+bQyvq+n7bdnmjYq2oOzT6KtQdZGDZS/kFerU2W3i4BQC5+LRmMqeqmnOB8/UlH5c
         RrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bmJojf3pY/qEboTN92H+9CbR3tHwgZeXXWT8llFOKek=;
        fh=tCCmC+BmtU2ppUvjtOLbaFFAzZ6TYMylbPAxjIy+pAM=;
        b=amzRRHl2D6WOExkBUcH8ZJjc/6tFLfoUmNZgqg61tDizGhCm1atlWiQHPrTeIv391X
         eObuShGo70eBhj6Df2O8nx1wgB4GsYetKSQemc8Jhg84lgVpcMCtZwp6bdtTnfOXAH+N
         MNphQN09YGPoRxCR6CMLdZ3S8W646QNTEngmtb1GrWJgYJ2i1Ga7dZXq1lxvfdEzDh7N
         j/fOn3pVaAjrN43DrgGDLbAADEPqDFVxLZ1i2iyEgkc2/xBxJT17cuk88IL9lP/KU6c/
         eS3OgXGbdiMMvhHQPMnNjVzVpa2xi+4GwLm0FgJdGOyHbosYu3WLnUCEWH/z1DK9ObbG
         zmOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794473954; x=1795078754; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmJojf3pY/qEboTN92H+9CbR3tHwgZeXXWT8llFOKek=;
        b=DBterSNJNoXADQeeYBvvBNRDD+ROe/wqijTyp2NW2kr4oGsv7zJO0ijd/74ARtU8lp
         aWR6+qyYXgwhFAfK9pxuYGKkzJV9wBeyfQVKUJ1rDa6OFjhRGHCrkWACcVyrxA1VoXkz
         dBordoeW+7uqHpf7TuqtG1UCX/oZk8S1LQbp4ummnqM4yAV8BNPpmc3+xx6clHf9iuRb
         JLqzUEg4i2b/jmILd0euDU+GroTj8FdoZangn9uit6/Qul3lUZpue3TEn0Bf+HLuWcSG
         FMQDrtiqYYPP/iy5tw7Obu4aM8aR3rYWZfcCGuHBRiN1SumhkKuCsIQDH5i+0wyP7n5A
         0PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794473954; x=1795078754;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bmJojf3pY/qEboTN92H+9CbR3tHwgZeXXWT8llFOKek=;
        b=W5oRSJkmTGYMD52gTjq+iGIuyxZZzlbiAH23MwL3C/ScsiCxlr6C3NJgAYDdPgPvHZ
         jnFzGPviWbfkhnyFXhczacHQpm2Hjt9Phg18nFArKxnoZZKyeXfdEGSGIB9wRS+MgLD4
         eMxrQOZNiM0m8Lwmlz1MTi1sCJv9P4t6yL/RKqTun554qRvfv/4vDCuYu5er3YJVlLk7
         5+VUMrkFo7SRBenouxUM2CIBviFc9YAdv7blI3cfIAaIYG8dhHOrDcLxo8DkMBMfqCwz
         iWadOcMvRy4JTO6CKO9J1GO0C1BEmoDeDxpiU6F6cJUOi9CBombnXApLra7/O0GAtmp5
         yYzA==
X-Forwarded-Encrypted: i=1; AL+hErF6jSWfvYjFF7hI7ohFjMboLpooggKW71MubEiRTXKEIFTI+PfXuXh77bc+12NMFOHx3kNjwDr8dg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/kB4k2HfaE6xo1CDfIfOFICooVTRbyQ1YzZZymDAQUaJ2i7guz
	7XgEkQmFWVxPGkdM/CcbjlcxQhatblI3Mza5baA5CJXuKtjSDjKGC3TNTUQMeGP7Iu/nmqK+2Me
	gu/pTrjubBv93q1Ge/cGXkhWpYA66cPor3SRCZHBJ7w==
X-Gm-Gg: AYBFou02Ow6azjhwDRo9K8xf9wWfL2I0q77/NCowsNAXo1jgPQ4Bq8nqQc1EAjXGXyc
	MhasW2ZaWbHNEiMD76S61dLRrhoCwJ5mr+AWeNQRxY5NaRCpjBoapzNWfq0/ik4amKNeONGz97I
	E2b+8ojtyrAoGxXiM1d4BDYRnrYKqtCE3hMC/an+RuGj4fCD2uNzsJRpST1YQWk0R0dgvHtJpYW
	QjCzeRppRDM3q30kTVTddn2Ksy8Ql8QwO7TVdGS+zCFx17/p69M4o44FJuQpPeJSskiBbVvUitB
	MCB0gafwV+HZdFPlGJIvyIxTIB81BbbG46+fjBuiM+6e3VViS/RHyII1DQN1WlEVU02qZRyplZd
	G+aL3X+1zA6zjf3pB5ghtGhxjn9dc3Zk4H6EXBAv91YSiSyh3kjVEU+JryBXwFVw8gOWdeg==
X-Received: by 2002:a17:906:eec1:b0:c42:bc58:f21 with SMTP id
 a640c23a62f3a-c507b65104dmr153692266b.15.1794473953856; Thu, 12 Nov 2026
 00:59:13 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103154603.1893325-1-nigro.fra@gmail.com> <5af4860d-096a-4e9d-a3b3-0b8277924146@amd.com>
In-Reply-To: <5af4860d-096a-4e9d-a3b3-0b8277924146@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 12 Nov 2026 09:59:02 +0100
X-Gm-Features: AclHuK9R6C_bOlom15ehGv14H644n5gFMFk1LgznMOgTBWOtDHmFp_ndZwAQhCI
Message-ID: <CAKfTPtCGmZQ9XVYJL_5f603qTf6_CdeKsq_pAYM_Ldqs3NaXaA@mail.gmail.com>
Subject: Re: [REPORT] sched: ITMT + DELAY_DEQUEUE: woken task waits ~1 ms
 behind another task on the preferred CPU while allowed CPUs are idle
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Francesco Nigro <nigro.fra@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Mike Galbraith <efault@gmx.de>, 
	Mario Limonciello <mario.limonciello@amd.com>, Huang Rui <ray.huang@amd.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 05:11, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Francesco,
>
> On 11/3/2026 9:16 PM, Francesco Nigro wrote:
> > Hi,
> >
> > A woken thread waits behind another running thread while other CPUs it
> > is allowed to use are idle.
> >
> > I see this on an AMD Ryzen 9 7950X running Fedora's 7.1.13 kernel, with
> > ITMT (AMD preferred cores) and DELAY_DEQUEUE enabled. Two busy threads
> > end up on the same CPU, the highest-ranked of the ones they are allowed
> > on. When one of them is woken, it is queued behind the other one and
> > starts one full CPU burst late (1 ms here). That happens to 0.08-0.36 %
>
> That % seems very low for this to make a visible impact but yes, since
> wakeups and load-balancing is lockless, there is a chance concurrent
> instances can stack tasks, momentarily, on the same idle CPU that
> suddenly turns very busy.
>
> > of wakeups. Reproducer, scripts and raw results (commit 49b6d72):
> > https://github.com/franz1981/itmt-delay-dequeue-repro
> >
> > Kernel and machine
> >
> >   - Fedora 7.1.13-100.fc43.x86_64, untainted, Fedora's stock .config
> >     (at the link above): HZ=1000, PREEMPT_DYNAMIC (lazy), SCHED_MC_PRIO,
> >     SCHED_AUTOGROUP, FAIR_GROUP_SCHED, NO_HZ_FULL. Fedora's
> >     patch-7.1-redhat.patch touches nothing under kernel/sched/, nor
> >     itmt.c, amd-pstate or cpufreq. I cannot boot mainline or a patched
> >     kernel on this machine.
> >   - AMD Ryzen 9 7950X, SMT on, amd_pstate active with prefcore,
> >     sched_itmt_enabled=Y. CPUs pinned at 4300 MHz, boost off.
> >   - CPUs 4-7 have prefcore rankings 211, 216, 231, 221 and the same
> >     amd_pstate_highest_perf (166): CPU 6 is not faster than the others.
> >
> > Reproducer
> >
> > Two threads each run a calibrated 1 ms CPU burst and block on an eventfd.
> > A waker thread on CPU 2 busy-polls and writes each eventfd 10 us after
> > that thread's burst ends. A handoff (waker's timestamp before the write
> > to read() returning) of 0.5 ms or more counts as a stall.
> >
> >     gcc -O2 -pthread -o asym_min asym_min.c
> >     taskset -c 4-7 ./asym_min 1000 10 30 2
> >
> > asym_min.c (195 lines):
> > https://github.com/franz1981/itmt-delay-dequeue-repro/blob/main/asym_min.c
> >
> > Results, 5 interleaved rounds of 30 s (results-final-min.txt):
> >
> >     setting                      stalls per run         total
> >     defaults                     212  49  48  76 214    599 of 294616
> >     sched_itmt_enabled=0           1   0   0   0   0      1 of 295349
>
> Since you say ITMT disabled actually solves this issue, I suspect there is a
> race between the idle balancer moving the delayed task to a preferred CPU vs
> a wakeup that also lands on the same CPU.
>
> The only time load balancer looks at the asym priority is is for idle /
> newidle balance and stacking is only possible from a race - back at OSPM
> Vincent and I had a discussion if we should just block a delayed task on
> idle migration, and also use the wakelist to offload the activation to the
> remote ,idle CPU; that may make a difference here.

Sorry for being late on this.

If the root problem is the migration of a delayed task during
newly_idle load balance which transiently make the CPU not idle
anymore for another task waking up simultaenously, can't we just
prevent migrating delayed task for newly_idle case in can_migrate ?
Migrating a delayed task to a newly idle CPU doesn't really make sense
because it will be the only task that will e migrated and will be
immediatly dequeued.

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11771,7 +11771,7 @@ int can_migrate_task(struct task_struct *p,
struct lb_env *env)
         * 5) are cache-hot on their current CPU, or
         * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
         */
-       if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
+       if ((p->se.sched_delayed) && (env->idle == CPU_NEWLY_IDLE ||
env->migration_type != migrate_load))
                return 0;

        if (lb_throttled_hierarchy(p, env->dst_cpu))

>
> If it isn't too much trouble, could you please try the below changes
> prepared on top of v7.4-rc1:
>
>   (Lightly tested on top of v7.4-rc1)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 1c93da75226e..6420e3d72904 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -994,6 +994,8 @@ struct task_struct {
>         /* Used for emulating ABI behavior of previous Linux versions: */
>         unsigned int                    personality;
>
> +       unsigned int                    sched_remote_wakeup;
> +
>         /* Scheduler bits, serialized by scheduler locks: */
>         unsigned                        sched_reset_on_fork:1;
>         unsigned                        sched_contributes_to_load:1;
> @@ -1005,20 +1007,6 @@ struct task_struct {
>
>         /* Unserialized, strictly 'current' */
>
> -       /*
> -        * This field must not be in the scheduler word above due to wakelist
> -        * queueing no longer being serialized by p->on_cpu. However:
> -        *
> -        * p->XXX = X;                  ttwu()
> -        * schedule()                     if (p->on_rq && ..) // false
> -        *   smp_mb__after_spinlock();    if (smp_load_acquire(&p->on_cpu) && //true
> -        *   deactivate_task()                ttwu_queue_wakelist())
> -        *     p->on_rq = 0;                    p->sched_remote_wakeup = Y;
> -        *
> -        * guarantees all stores of 'current' are visible before
> -        * ->sched_remote_wakeup gets used, so it can be in this word.
> -        */
> -       unsigned                        sched_remote_wakeup:1;
>  #ifdef CONFIG_RT_MUTEXES
>         unsigned                        sched_rt_mutex:1;
>  #endif
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 04b62c16fa8c..fbaa47496cb2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3981,7 +3981,12 @@ void sched_ttwu_pending(void *arg)
>                 if (WARN_ON_ONCE(task_cpu(p) != cpu_of(rq)))
>                         set_task_cpu(p, cpu_of(rq));
>
> -               ttwu_do_activate(rq, p, p->sched_remote_wakeup ? WF_MIGRATED : 0, &rf);
> +               if (p->sched_remote_wakeup & WF_LB_MIGRATED) {
> +                       attach_task(rq, p);
> +                       continue;
> +               }
> +
> +               ttwu_do_activate(rq, p, p->sched_remote_wakeup, &rf);
>         }
>
>         /*
> @@ -4020,11 +4025,11 @@ bool call_function_single_prep_ipi(int cpu)
>   * via sched_ttwu_wakeup() for activation so the wakee incurs the cost
>   * of the wakeup instead of the waker.
>   */
> -static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
> +void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
>  {
>         struct rq *rq = cpu_rq(cpu);
>
> -       p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
> +       p->sched_remote_wakeup = wake_flags;
>
>         WRITE_ONCE(rq->ttwu_pending, 1);
>  #ifdef CONFIG_SMP
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index cfc982205b98..b8c26a6ca82d 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -10617,6 +10617,7 @@ enum migration_type {
>  #define LBF_ACTIVE_LB  0x10
>  #define LBF_LLC_PINNED 0x20
>  #define LBF_ACTIVE_LB_LLC      0x40
> +#define LBF_FIRST_MIGRATION    0x80
>
>  struct lb_env {
>         struct sched_domain     *sd;
> @@ -11404,11 +11405,72 @@ static int detach_tasks(struct lb_env *env)
>                         break;
>                 }
>
> +               /* First migration to an idle CPU */
> +               if (env->flags & LBF_FIRST_MIGRATION) {
> +                       /*
> +                        * If a delayed task is moving to an idle CPU,
> +                        * block it here. It is okay to skip detach
> +                        * accounting since imbalance from this move has
> +                        * already been subtracted.
> +                        */
> +                       if (p->se.sched_delayed) {
> +                               dequeue_task(env->src_rq, p,
> +                                            DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> +                               continue;
> +                       }
> +                       /*
> +                        * Prevent further wakeup on the dst_cpu
> +                        * if it was idle by signalling pending wakeup.
> +                        */
> +                       WRITE_ONCE(env->dst_rq->ttwu_pending, 1);
> +               }
> +
>                 detach_task(p, env);
> -               list_add(&p->se.group_node, &env->tasks);
>
> -               detached++;
> +               if (env->flags & LBF_FIRST_MIGRATION) {
> +                       env->flags &= ~LBF_FIRST_MIGRATION;
> +                       /*
> +                        * Destination is idle; Let it do the enqueue.
> +                        * Detach accountng in unnecessary since
> +                        * imbalance is already subtracted.
> +                        *
> +                        * Note: It is necessary to check p->__state to ensure
> +                        * the task cannot receive a concurrent wakeup else, it
> +                        * is possible to deadlock like:
> +                        *
> +                        * Initial state:
> +                        *
> +                        *   p->__state = TASK_UNINTERRUPTIBLE;
> +                        *   <p preempted>
> +                        *
> +                        *              CPU0                            CPU1
> +                        *              ====                            ====
> +                        * sched_balance_rq()
> +                        *   # CPU3 is the busiest with task p
> +                        *   detach_task(p)
> +                        *     p->on_rq = TASK_ON_RQ_MIGRATING
> +                        *   __ttwu_queue_wakelist(p, 1)        -> IRQ
> +                        *                                        try_to_wake_up(p)
> +                        *                                          if (ttwu_state_match())
> +                        *                                            ttwu_runnable()
> +                        *                                              __task_rq_lock()
> +                        *                                                !! Deadlock !!
> +                        *
> +                        * The remote enqueue should complete for wakeup to
> +                        * proceed but the call function interrupt is queued
> +                        * behind the IRQ doing the wakeup.
> +                        */
> +                       if (sched_feat(TTWU_QUEUE) &&
> +                           READ_ONCE(p->__state) == TASK_RUNNING &&
> +                           env->dst_cpu != smp_processor_id()) {
> +                               __ttwu_queue_wakelist(p, env->dst_cpu, WF_LB_MIGRATED);
> +                               goto skip_enqueue;
> +                       }
> +               }
>
> +               list_add(&p->se.group_node, &env->tasks);
> +               detached++;
> +skip_enqueue:
>  #ifdef CONFIG_PREEMPTION
>                 /*
>                  * NEWIDLE balancing is a source of latency, so preemptible
> @@ -13799,6 +13861,10 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>         ld_moved = 0;
>         /* Clear this flag as soon as we find a pullable task */
>         env.flags |= LBF_ALL_PINNED;
> +
> +       if (env.idle)
> +               env.flags |= LBF_FIRST_MIGRATION;
> +
>         if (busiest->nr_running > 1) {
>                 /*
>                  * Attempt to move tasks. If sched_balance_find_src_group has found
> @@ -13831,6 +13897,13 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>                 if (cur_ld_moved) {
>                         attach_tasks(&env);
>                         ld_moved += cur_ld_moved;
> +                       /*
> +                        * detach_tasks() above can set the "ttwu_pending" on
> +                        * the destination to prevent concurrent wakeup on the
> +                        * same CPU. Clear it here. Since rq->nr_running is
> +                        * non-zero after attach, idle_cpu() will return false.
> +                        */
> +                       WRITE_ONCE(env.dst_rq->ttwu_pending, 0);
>                 }
>
>                 local_irq_restore(rf.flags);
> @@ -13870,6 +13943,9 @@ static int sched_balance_rq(int this_cpu, struct rq *this_rq,
>                         env.loop         = 0;
>                         env.loop_break   = SCHED_NR_MIGRATE_BREAK;
>
> +                       if (idle_cpu(env.dst_cpu))
> +                               env.flags |= LBF_FIRST_MIGRATION;
> +
>                         /*
>                          * Go back to "more_balance" rather than "redo" since we
>                          * need to continue with same src_cpu.
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 6c7c5633524a..ea216b06fd92 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2575,6 +2575,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
>  #define WF_CURRENT_CPU         0x40 /* Prefer to move the wakee to the current CPU. */
>  #define WF_RQ_SELECTED         0x80 /* ->select_task_rq() was called */
>  #define WF_TTWU_RQ             0x100 /* Wakeup completed through ttwu_runnable() */
> +#define WF_LB_MIGRATED         0x200 /* Wakeup completed through ttwu_runnable() */
>
>  static_assert(WF_EXEC == SD_BALANCE_EXEC);
>  static_assert(WF_FORK == SD_BALANCE_FORK);
> @@ -3162,6 +3163,7 @@ static inline void __block_task(struct rq *rq, struct task_struct *p)
>         smp_store_release(&p->on_rq, 0);
>  }
>
> +extern void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags);
>  extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
>  extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
>
> ---
>
> There is still chance of stacking but theoretically, it should reduce
> the chances of stacking a delayed task on a busy CPU.
>
> >     NO_DELAY_DEQUEUE              21   9  11  26  14     81 of 295201
> >     defaults, SMT siblings
> >     20-23 also allowed            16  27  15  13   2     73 of 295215
> >
> > The median handoff is 3 us in every setting.
> >
> > Trace
> >
> > stackcheck.bt records, per wakeup, whether se.sched_delayed was set at
> > try_to_wake_up() and whether select_task_rq_fair() ran. Two 30 s runs with
> > the defaults (results-final-min-trace.txt):
> >
> >                                                     run 1    run 2
> >     worker wakeups                                  58592    58770
> >       delayed, no select_task_rq_fair()               340      174
> >     waits >= 0.5 ms                                   310      153
> >       on CPU 6 behind the other thread                288      137
> >       after a delayed wakeup, no CPU selection        280      139
> >       other thread moved to CPU 6 by
> >         active_load_balance_cpu_stop()                 30       12
> >
> > In a third run (stackcheck-idle.bt), 3 of the 4 allowed CPUs were idle
> > when the waiting thread was woken, in all 102 waits >= 0.5 ms.
> >
> > The code path in 7.1.13:
> >
> >     fair.c:dequeue_entity()
> >         if (sched_feat(DELAY_DEQUEUE) && delay &&
> >             !entity_eligible(cfs_rq, se)) {
> >             ...
> >             set_delayed(se);
> >             return false;
> >         }
> >
> >     core.c:try_to_wake_up()
> >         if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
> >             break;
> >         ...
> >         cpu = select_task_rq(p, p->wake_cpu, &wake_flags);
> >
> >     core.c:ttwu_runnable()
> >         if (p->se.sched_delayed)
> >             enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
> >
> > Sequence, from the trace flags and the code above (A waits, B runs):
> >
> >     CPU 6                                   CPUs 4, 5, 7
> >     -----                                   ------------
> >     A ends its burst and blocks while
> >     not eligible: stays queued, delayed
>
> So at this point, I would have expected B to have already been
> moved by a newidle / idle balance. Reduced stacking from ITMT
> disabled kinda points to the wakeup vs load balancing race.
>
> >     B runs its 1 ms burst                   idle
> >     the waker writes A's eventfd;
> >     ttwu_runnable() re-queues A on CPU 6,
> >     no select_task_rq()                     idle
> >     B's burst ends, A runs ~1 ms late
> >
> > A task alone on its cfs_rq is always eligible, so A can only be delayed
> > while B shares CPU 6. How the two first end up there is only partly
> > traced (active balance in 30 and 12 of the waits above).
> >
> > Mainline (7.4-rc1) still re-queues a delayed task in place in
> > ttwu_runnable(). I have not run it.
> >
> > Related, not tested here
> >
> >   - Mike Galbraith, "sched/fair: Dequeue sched_delayed tasks when waking
> >     to a busy CPU" (tip sched/urgent, 2024-11-11; not in 7.1.13 or
> >     7.4-rc1) and its V2 thread:
> >     https://lore.kernel.org/all/bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de/
> >   - Peter Zijlstra, "[PATCH v2 11/12] sched: Change ttwu_runnable() vs
> >     sched_delayed" (2025-07-02, not merged):
> >     https://lore.kernel.org/all/20250702121159.535226098@infradead.org/
> >   - "sched/fair: DELAY_DEQUEUE causes ~25% pipe IPC regression on
> >     Raspberry Pi 5" (2026-04), a different symptom, no ITMT:
> >     https://lore.kernel.org/all/20260423080453.GQ3126523@noisy.programming.kicks-ass.net/
> >
> > Questions
> >
> >   1. Is this cost expected when a delayed task is woken on a busy CPU
> >      while other allowed CPUs are idle? Here the busy CPU is not faster
> >      than the idle ones, and each stall costs one full burst.
> >   2. Is the ttwu_runnable() change in the threads above still planned,
> >      and would it be expected to cover this case?
> >   3. What else would be useful to trace or measure on this machine?
> >
> > Notes
> >
> >   - Tested on this machine only; Intel ITMT is untested. Which settings
> >     matter elsewhere is a guess: the allowed CPUs relative to the
> >     preferred-core ranking, SMT siblings, the waker CPU. scan.sh at the
> >     link above tries several CPU sets without root.
> >   - asym_stack2.c at the link above is an earlier, longer version of the
> >     reproducer. It showed the same pattern at about 3x the stall rate
> >     (results-final.txt); I don't know why the rates differ.
> >
> > Tool use: an AI coding assistant (Claude Code, Claude Opus 5.5) wrote
> > the scripts, ran the measurements on this machine and drafted this
> > report; Codex helped with earlier analysis. I reviewed the method and
> > the numbers against the raw files and can answer for them.
>
> Thanks a ton for all the details. The only preferred core system I have
> at the moment is my laptop (4C/8T) so I'll try to give your reproducer
> a spin there and meanwhile, I'll check if I can borrow a 7950x
> internally and test this out.
>
> Thank you again for the report.
>
> --
> Thanks and Regards,
> Prateek
>

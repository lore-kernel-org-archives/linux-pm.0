Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720784;
	b=zV9EttHOmjSqBVy47cdxMI62LHHLeN3wzqY0vOAn5Ren60X7aYllG0ykSDLyMlL+746O
	 sZgdx/XbNEKMkha3H1H8PvwrD4pn0UQ8YPWEttJkeUkPzDCZf7xGDVmrFO6BcI3sZE+5+
	 R9VIVH+7XmE4ar+8yHrA7E3iv8KN0jbXER+CxtE5PsUEAuWqfCtKLo9s4t8E8zDPyV5is
	 DMj9OopltzCI2t0b/bqN6Qj8OjU6x9vF2yDrASAKqzpWImJCK0kZ6W0knZLLXl1Jyvq3P
	 SHcNkpLmhF69r0ZMI7lp2G3MERyvggjABouEPZkpUxYJDqb6SI3hktfUW/kLaEFilRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=f/WZYQLdPkHbIQApsbqkOqPa3g52v+aebL2Gv1OKZH0=;
	b=xM0murm9cJ2rEM2Hkb73Vi3Waw2pkzSwEp9QUOnI4La3yOOYlN2nYrUSq4dqsHMiRT7F
	 ovvjgMKaS7r6MGzSaVgP50MNXYzjq4zbiZb6hUSFJ8ilN8mTtwG1Omc/ywIAbsN3KY87V
	 L9F9LLpBQgTnKSnTpKq/67xoo4fYKFg3PCjqeVcvqgxYr6tIjKmw4ChMxVU8AJkeZlULO
	 aKtOAgtntim7EHkspgV+wkm3AQNiiO0x7WCr3fVm/Tqmyh1sHNwjf/JJtDfVXW9ZW+u54
	 07lXyyyTEGY0aUGflpGCVvgSaUjAiVSRPqGfzhPy4X8Jgo4cgceBDNLNiGe08zd/mkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UAjttzsT;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEA1606A338
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 15:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BEA1606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UAjttzsT
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so44004325e9.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793720782; x=1794325582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f/WZYQLdPkHbIQApsbqkOqPa3g52v+aebL2Gv1OKZH0=;
        b=UAjttzsTfNvl7dxIbR5d7BqbeC2CMb8wBixKhjw58wn/iu2+dyv9vNdl+jqW9Dr3Sa
         xghVO/HqPxWrZ8g0rDE7O/XOhk02zxbotvhAXpkQKa9trJUEWlJTlDgqP+hSpW2BVuI1
         uXJVUle3uJbJgYHvNTOK4kbLzpugBRI7bcapy74OsatXrU4NQxRnuYDo0w60cDosh7Ma
         atyqhuljGWimjdV9WUiqPo7x6cC0f0zF10g7mo79yzRRavIffWb1ZRIWRo2Im+vmHyiP
         t2HefdOKEFOH0VFiHpiL9opWUiNBhiB4vQxwotTrhRPxBLp1q64iksEmsSm5DKoS12Iu
         ei1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793720782; x=1794325582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/WZYQLdPkHbIQApsbqkOqPa3g52v+aebL2Gv1OKZH0=;
        b=XS7t+lYa3kHGX/RWuqgyURyTksxGlwtCoovbgv46yOYSyxA5k1dSu7eR/u5SA8EJ5j
         6AEVaqpmeUmp43YqhjKkZfkxuQzvjdAeYSJ/W9OvR2BYUVuws1pV3+xbMYtk7KGWkSAs
         8FYFzYwll7509hOYgjlk6Lln+PYdWg+DRBPq+JzdhTR1M1dOvvl4kHKZ3GLhSGGhqJSe
         0f4PrH6rbsMoA2eQAKpmvxL730H6wivQRkjWIm7EkgCAkOSiWKD8t7U4yweuVDdEb2mF
         w9+UObLpobIiz5o9xxmVdsUHRioxF0goG0r1KCiBBWeBooVhR5gRFJFO4xTmqYE+Gm+/
         R2UQ==
X-Forwarded-Encrypted: i=1; AKwUvBy8T4B99ylUypUob2s95GIt4VX/rq+h2RMZibSDy7PGVjRgIUdxer60rO0ANCwZUYeGaKceKm/9/Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+r8dPk+0yI8hS6Zqcd5aey/QcHw8K7Np9AdO4CyPmqBtS58Qpg
	zJq3UQCUO17P3C0TWV4ES/7o4U9fglslnUcQse2zcxcclsjXwxdYI85/
X-Gm-Gg: AYBFou0JC//edBmYmiK54NYZ2eYpZgzqYDv95l53N110G3rRBTLIawMq5yd2LJnGELn
	kxbj/9Quu2MosmbvoUFN+LTu/RHJw9oTWYY1Mcg8dK1SbqVAgzC4cGsvqSB5Ibmep59yrMMRTZM
	iXIUQJmM2C2UJVYEuMD4D8U+tgy8X7Pl7kbXH48c48GjXML5aB2xFuEskU+Bh2b0vjnmdXyDI/L
	PUc2Vt7tkqkeUjIVQXORYb04gtTHNK3WytmgcPTyZ8c0ScC5oERm5Qm4eyboxMOjRVd1Gwmy05s
	x0d7Wt9H3fHpjPe+s4trZfMvamDBfj9XLXnzRDYbEVmTXHsOqRCG8wNtTQCXAAAvtpDEk314FRA
	2F7y+H3FmLfRQmCFtl88GybGy7eqYKoMwbT75f3Wu3GwV8AdkEqtVi26rVo/ZOg83h3Ra79NwMG
	tx9Acfvp4bzqGuiL7USzP3zU0MoWyV7ciGY7gep1Bal11BdvViAijl++OEMMonzhsyS1pkNEIUm
	0jK1qGBtu1qb1w9J7xQEUkjstb/yCf3U4BjX0EQVFYT+zoLRQfxWIeFI80hZHH1zQuz5IN5TweJ
	WBm46nn/8AEeDUHFsBE=
X-Received: by 2002:a05:600c:4f0f:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4ac17b2cde9mr354368685e9.7.1793720781489;
        Tue, 03 Nov 2026 07:46:21 -0800 (PST)
Received: from fedora ([2.35.201.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a8d60bc5sm70002245e9.8.2026.11.03.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:46:19 -0800 (PST)
From: Francesco Nigro <nigro.fra@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mike Galbraith <efault@gmx.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [REPORT] sched: ITMT + DELAY_DEQUEUE: woken task waits ~1 ms behind another task on the preferred CPU while allowed CPUs are idle
Date: Tue,  3 Nov 2026 16:46:03 +0100
Message-ID: <20261103154603.1893325-1-nigro.fra@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

A woken thread waits behind another running thread while other CPUs it
is allowed to use are idle.

I see this on an AMD Ryzen 9 7950X running Fedora's 7.1.13 kernel, with
ITMT (AMD preferred cores) and DELAY_DEQUEUE enabled. Two busy threads
end up on the same CPU, the highest-ranked of the ones they are allowed
on. When one of them is woken, it is queued behind the other one and
starts one full CPU burst late (1 ms here). That happens to 0.08-0.36 %
of wakeups. Reproducer, scripts and raw results (commit 49b6d72):
https://github.com/franz1981/itmt-delay-dequeue-repro

Kernel and machine

  - Fedora 7.1.13-100.fc43.x86_64, untainted, Fedora's stock .config
    (at the link above): HZ=1000, PREEMPT_DYNAMIC (lazy), SCHED_MC_PRIO,
    SCHED_AUTOGROUP, FAIR_GROUP_SCHED, NO_HZ_FULL. Fedora's
    patch-7.1-redhat.patch touches nothing under kernel/sched/, nor
    itmt.c, amd-pstate or cpufreq. I cannot boot mainline or a patched
    kernel on this machine.
  - AMD Ryzen 9 7950X, SMT on, amd_pstate active with prefcore,
    sched_itmt_enabled=Y. CPUs pinned at 4300 MHz, boost off.
  - CPUs 4-7 have prefcore rankings 211, 216, 231, 221 and the same
    amd_pstate_highest_perf (166): CPU 6 is not faster than the others.

Reproducer

Two threads each run a calibrated 1 ms CPU burst and block on an eventfd.
A waker thread on CPU 2 busy-polls and writes each eventfd 10 us after
that thread's burst ends. A handoff (waker's timestamp before the write
to read() returning) of 0.5 ms or more counts as a stall.

    gcc -O2 -pthread -o asym_min asym_min.c
    taskset -c 4-7 ./asym_min 1000 10 30 2

asym_min.c (195 lines):
https://github.com/franz1981/itmt-delay-dequeue-repro/blob/main/asym_min.c

Results, 5 interleaved rounds of 30 s (results-final-min.txt):

    setting                      stalls per run         total
    defaults                     212  49  48  76 214    599 of 294616
    sched_itmt_enabled=0           1   0   0   0   0      1 of 295349
    NO_DELAY_DEQUEUE              21   9  11  26  14     81 of 295201
    defaults, SMT siblings
    20-23 also allowed            16  27  15  13   2     73 of 295215

The median handoff is 3 us in every setting.

Trace

stackcheck.bt records, per wakeup, whether se.sched_delayed was set at
try_to_wake_up() and whether select_task_rq_fair() ran. Two 30 s runs with
the defaults (results-final-min-trace.txt):

                                                    run 1    run 2
    worker wakeups                                  58592    58770
      delayed, no select_task_rq_fair()               340      174
    waits >= 0.5 ms                                   310      153
      on CPU 6 behind the other thread                288      137
      after a delayed wakeup, no CPU selection        280      139
      other thread moved to CPU 6 by
        active_load_balance_cpu_stop()                 30       12

In a third run (stackcheck-idle.bt), 3 of the 4 allowed CPUs were idle
when the waiting thread was woken, in all 102 waits >= 0.5 ms.

The code path in 7.1.13:

    fair.c:dequeue_entity()
        if (sched_feat(DELAY_DEQUEUE) && delay &&
            !entity_eligible(cfs_rq, se)) {
            ...
            set_delayed(se);
            return false;
        }

    core.c:try_to_wake_up()
        if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
            break;
        ...
        cpu = select_task_rq(p, p->wake_cpu, &wake_flags);

    core.c:ttwu_runnable()
        if (p->se.sched_delayed)
            enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);

Sequence, from the trace flags and the code above (A waits, B runs):

    CPU 6                                   CPUs 4, 5, 7
    -----                                   ------------
    A ends its burst and blocks while
    not eligible: stays queued, delayed
    B runs its 1 ms burst                   idle
    the waker writes A's eventfd;
    ttwu_runnable() re-queues A on CPU 6,
    no select_task_rq()                     idle
    B's burst ends, A runs ~1 ms late

A task alone on its cfs_rq is always eligible, so A can only be delayed
while B shares CPU 6. How the two first end up there is only partly
traced (active balance in 30 and 12 of the waits above).

Mainline (7.4-rc1) still re-queues a delayed task in place in
ttwu_runnable(). I have not run it.

Related, not tested here

  - Mike Galbraith, "sched/fair: Dequeue sched_delayed tasks when waking
    to a busy CPU" (tip sched/urgent, 2024-11-11; not in 7.1.13 or
    7.4-rc1) and its V2 thread:
    https://lore.kernel.org/all/bf4f50886c462ee1f33cc404843944fea4817616.camel@gmx.de/
  - Peter Zijlstra, "[PATCH v2 11/12] sched: Change ttwu_runnable() vs
    sched_delayed" (2025-07-02, not merged):
    https://lore.kernel.org/all/20250702121159.535226098@infradead.org/
  - "sched/fair: DELAY_DEQUEUE causes ~25% pipe IPC regression on
    Raspberry Pi 5" (2026-04), a different symptom, no ITMT:
    https://lore.kernel.org/all/20260423080453.GQ3126523@noisy.programming.kicks-ass.net/

Questions

  1. Is this cost expected when a delayed task is woken on a busy CPU
     while other allowed CPUs are idle? Here the busy CPU is not faster
     than the idle ones, and each stall costs one full burst.
  2. Is the ttwu_runnable() change in the threads above still planned,
     and would it be expected to cover this case?
  3. What else would be useful to trace or measure on this machine?

Notes

  - Tested on this machine only; Intel ITMT is untested. Which settings
    matter elsewhere is a guess: the allowed CPUs relative to the
    preferred-core ranking, SMT siblings, the waker CPU. scan.sh at the
    link above tries several CPU sets without root.
  - asym_stack2.c at the link above is an earlier, longer version of the
    reproducer. It showed the same pattern at about 3x the stall rate
    (results-final.txt); I don't know why the rates differ.

Tool use: an AI coding assistant (Claude Code, Claude Opus 5.5) wrote
the scripts, ran the measurements on this machine and drafted this
report; Codex helped with earlier analysis. I reviewed the method and
the numbers against the raw files and can answer for them.

Thanks,
Franz

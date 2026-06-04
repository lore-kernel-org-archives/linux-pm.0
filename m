Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9529333434
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780558956; cv=pass; b=Bm1vFy36A2whtvmZuwgV+QQ1lWqKqStftoTNFQbmYMigWpcVHEtTuaEQHAb+A07b66TDySCuUL6N2ExkY4yaSwxbtquf9XC3E99DnwiKLLf/B0qmcSlUSplZtRvOHYX3n0AZua5O4IhcJbdAXiWfAFni4I8fJoR6WEuehqoD0+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780558956; c=relaxed/simple;
	bh=uLUmWkNkX983z+Mz5gwP3c8Y6jiszfqm2v15+A8RWto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpN86+CrVmBtwR9HiNhpkmbaFBySmX22E50fENddyaqrbUNvAsO5Q7jIpHUsk8cDBKBC+rgj6MUYllr0iWQkNZvvSp3kdIhseAv30ikFOHCtIsAPy7FBuhhoRXjjfR7zbdjFINDvBBVNfTM/hvD3jvyI/QO4JwZZUXQvy1KcR34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=monWNIR+; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="monWNIR+"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bebb72b845aso14862266b.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 00:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780558953; cv=none;
        d=google.com; s=arc-20240605;
        b=BVE8/0WWULON1JhBkHEgGMpaz3tIwWvq7A2R6Tq63NkEG2Vg+IHgUBLC+SoNCk/9zM
         e9cAXL2/su3MmYCWhIFuFienDIMuUU0J+a6ejRc4UOnaRytq53X+iZ4vo5dPV2iDla/L
         MwGY/giPSW9XW32mON9hSNGfHZ7K8MjnaBpyR6ciTpSKpjccG/RJt7whc1bAHUzFJllU
         BWq0kQMyq3Smi3jt9PxeXGRaAmiN89ojQz+992jA9WI9XrxzhgL2oRPdQri1OveWH4L1
         VUajvDb+2+zpnTpIzMvR6dTG5eWCYxtn7154I+kGJJ56jAJ4OKss2RyJDsLdeITvhH3Q
         GzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y3SUmoWqZ8EDI39oYny14e6+iXlg4i8lU1i+cV3Qzko=;
        fh=8OjNCWim8WH4xexb1emjcDsMop9wvSoj9wysMVl1hX8=;
        b=GbuIY8VHrR8Kak/L6KijqzfKnk1rYuK1jqQDFzTroLsn7UH2O49e5jLBWxzdRM/nEi
         esK7xxR2ge2lapcKDDgxqgfzPKtQuk4Zk+/sSUtinL652txni9NtD5fK3k90s0LUG52s
         q2MfgIOTwZgXjdw/TGbOMZUKcrIdJqU69IAiAZMg9RG4Xl8nqZnSJWIEW263qWBEVtRc
         kvHp5nyjbT6P4z2beR3r215xDCqPM8JAq3IeIUkgPsqlmqn0vhTEtq36k/XQXvJFMF7A
         FnlP8ooja8IQoJYnnEhS7PQ+GH4t7SgMQhT4ooQVdimN5AZ8PWfkMyjVQ3QUt3IIGCdb
         ZTaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780558953; x=1781163753; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y3SUmoWqZ8EDI39oYny14e6+iXlg4i8lU1i+cV3Qzko=;
        b=monWNIR+f8+nQk3dcpdtqLiNGA0A9/PAwfj8TLden6JG7WSq5H5cmGKIqOhdVJeel7
         IRR3lKMSyybspi5jaqs/7homdLcn0jBLh8se7dUbnEyt/6pITIXPhWa9kUDVVo9gNp+F
         bEFCXj06EqScaHuP2zYHLXOK7TyCZ6zwnZARqhAjFdOA0Re3cLpHg1C/lgU4dSkq6DrW
         5bWSkrRbCwmtvCufSOdBZ6L7seLlC8ValhXiYgB7ss7pMazg3SKlZK+EFDriyr+OhVcC
         XBQzqRU0VdUa5axauEXherAB+Sgr8FgJMVeIw8/07hm1gKXrMBq0gmuQbsbYLx5lOLUS
         nYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780558953; x=1781163753;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3SUmoWqZ8EDI39oYny14e6+iXlg4i8lU1i+cV3Qzko=;
        b=g8RFhxjKTNylCu3x9lXu+FOy+dwVa5qo/fMJ0314wKGAx/aGXRucMSv+io75NvmuMU
         ilQyIBqd2VzuMHrq+QXpeMD8KzGgFp8r0gtzBi51vjqHwCgEJdtmS473PLDz1CMvhS5/
         0UIntzhcL0H58onQ20d++OtZzrT75CUVdt3L6oQ5/Ou2Au3yETz7n83POO1I4+GHZlju
         vmxzrYwp15UxMbkjL7326AJCQeCZUCnmswzcwyMqUtrevK/jSUfalnQcBFzxggRXEjid
         oF65ZuVGuWGQVHBQDesLVm2/Ex9s6Dm7s5w+ZNPJnpTI50v8IG6YSVDzba+n1at8Eeiz
         n0Lw==
X-Forwarded-Encrypted: i=1; AFNElJ/aGsxuproMRAmtZzTKHtYZfRJw5x97PSlGJ6dlXaArWinzyyP+FroOpxi+g1Ylr3sd6VRfPPnd4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyRW/JaOcHXU9t9Yo0onSQt5oJpUFEXGyWAu56qh9BwRtsHHVIG
	+T/7ySq7X8d4gmVFRjM+3srJezqNsswrRtf0Ji8FIZHerD3Zt7XVGT8NNS+/9NaQssOOT9N47a3
	t7AYTFl2pqve+J6ROAk8kXO7/L2HD+Is/G0eo5pndnQ==
X-Gm-Gg: Acq92OFJWXGRL1lzULWLDWuk7Y9Zz7sqfukXKKCqL3wlq9pLaXmL6u/3LJmWLVaIw6t
	0B2TCYPt7XJHnyCyFsN1LKlsHUWPKkrFCtGqTaCa1cZiP0MTe/O8qYtgMj3VO0X8w/iUNz0DC71
	wXgVaiDWyHTTuaon2/x3+kg5DVQbWzJ+CftZgZh84za2wm9fT1MzSSav5OpYWu2de6N42H7d7C5
	a2oEoH8SICThiHAej2XGEf3jrE2hpCKiXzLRkPRsSh+S6Yfl5n7Zj4YAU/rYlVzTAp/Fts+hnFJ
	22Os2UAUk5/TNoVyKG1xdDyWGL+xN6QYXQriqfuTrT2nlRE=
X-Received: by 2002:a17:906:c10b:b0:bef:d412:cecb with SMTP id
 a640c23a62f3a-bf0a8a341d5mr371899366b.20.1780558953043; Thu, 04 Jun 2026
 00:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528023611.2433-1-hongyan.xia@transsion.com>
In-Reply-To: <20260528023611.2433-1-hongyan.xia@transsion.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 4 Jun 2026 09:42:20 +0200
X-Gm-Features: AVHnY4IKlN8Ij2qiXOhV8bAEq_UI_JJx8n7NZFdMCNvw9lkgcsEgez0izE1Zqgs
Message-ID: <CAKfTPtCnXrwBBvj6vGJfmLgESf4_3zwA4-m-N1ceMJ3ghOvFKQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: Revert boost in cpu_util()
To: Hongyan Xia <hongyan.xia@transsion.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Pu Hu <hupu@transsion.com>, 
	Jiazi Li <jiazi.li@transsion.com>, 
	"christian.loehle@arm.com" <christian.loehle@arm.com>, "qyousef@layalina.io" <qyousef@layalina.io>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 May 2026 at 04:36, Hongyan Xia <hongyan.xia@transsion.com> wrote:
>
> From: Hongyan Xia <hongyan.xia@transsion.com>
>
> We have seen a massive power consumption regression (20% SoC power
> increase in many apps) after updating our kernel. After bisection we

It's always good to provide more details: kernel, version, hardware
and the test condition

> pinpointed the regression to the cpu_util(boost) feature. After
> reverting the boost feature the massive energy regression is gone.
> Detailed trace analysis down below. The regression is found across quite
> many apps but Youtube is one of the worst offenders. Some energy
> benchmark numbers are here.
>
> Youtube 1080p60fps video benchmark:
>                 FPS   SoC Power  diff
> w/  boost      59.94   913.6mW
> w/o boost      59.93   720.4mW  -21.15%
>
> Mobile Legends (gaming)
>                FPS   sdev   Total power  diff
> w/  boost     120.16  0.47   3294.10mW
> w/o boost     120.07  0.56   2996.09mW  -9.05%
>
> Genshin Impact (gaming, medium quality)
>                 FPS   sdev  Total power  diff
> w/  boost      60.05  0.34   6215.84mW
> w/o boost      60.03  0.35   5695.46mW  -8.37%
>
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
>
> ---
> Changed in v2:
> - Sync all comments with code changes.
> - Update commit message with more benchmark numbers.
>
> Analysis:
>
> We found several problems that result in the power spike:
>
> 1. Arithmetic should not happen between util_avg and runnable_avg:
>
> After util = max(util, runnable) which potentially picks runnable value
> in cpu_util(), we then add or subtract task util values from it. This
> produces a value that is half-runnable-half-util which is ill-defined.
> This alone should be a warning sign. This breaks EAS calculations in
> many cases, leading to sub-optimal task placements.

This can be easily fixed

>
> 2. Using the absolute value of runnable_avg to drive frequency is
>    too high to be reasonable:
>
> Schedutil use runnable in a _relative_ way to util to know whether there
> is contention in several places. However, the _absolute_ value should
> not be used like util. Runnable_avg tends to be significantly higher,
> making it much easier to saturate frequency.
>
> For example, if three tasks each with a util of 100 contend on the same
> rq, the rq util is 300 but runnable_avg shoots up to 600, which is often
> much higher than needed.

In the email thread of the prev version, you said that using
runnable_avg is good but not like the current implementation. So
instead of blindly reverting it, please submit a better usage, as this
was added to fix some performance issues.

>
> 3. Runnable_avg may not even reflect true contention:
>
> When tasks are dependent, the bottleneck is often the data flow between
> tasks, not the contention seen by runnable_avg. Boosting frequency with
> runnable in such scenarios wastes power without performance benefits.
>
> We found 1 has minor power regression but 2 and 3 regresses power
> significantly. We have seen multiple applications with the
> producer-consumer model with many worker threads suffer. When there is
> IPC between producer and consumer, boosting frequency blindly does not
> help performance at all if consumer is limited by how much data is flown
> through. Youtube suffer from 1, 2 and 3 at the same time, leading to a
> total SoC power regression of 20% shown in the results above.

Tasks contention is a real problem and runnable_avg is one metric that
reflects this.

>
> ---
>  kernel/sched/cpufreq_schedutil.c |  2 +-
>  kernel/sched/fair.c              | 34 ++++++++------------------------
>  kernel/sched/sched.h             |  1 -
>  3 files changed, 9 insertions(+), 28 deletions(-)
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index ae9fd211cec1..ba867192513b 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -228,7 +228,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
>         unsigned long min, max, util = scx_cpuperf_target(sg_cpu->cpu);
>
>         if (!scx_switched_all())
> -               util += cpu_util_cfs_boost(sg_cpu->cpu);
> +               util += cpu_util_cfs(sg_cpu->cpu);
>         util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
>         util = max(util, boost);
>         sg_cpu->bw_min = min;
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 728965851842..ecf8b4860951 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8192,7 +8192,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   * @cpu: the CPU to get the utilization for
>   * @p: task for which the CPU utilization should be predicted or NULL
>   * @dst_cpu: CPU @p migrates to, -1 if @p moves from @cpu or @p == NULL
> - * @boost: 1 to enable boosting, otherwise 0
>   *
>   * The unit of the return value must be the same as the one of CPU capacity
>   * so that CPU utilization can be compared with CPU capacity.
> @@ -8210,12 +8209,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   * be when a long-sleeping task wakes up. The contribution to CPU utilization
>   * of such a task would be significantly decayed at this point of time.
>   *
> - * Boosted CPU utilization is defined as max(CPU runnable, CPU utilization).
> - * CPU contention for CFS tasks can be detected by CPU runnable > CPU
> - * utilization. Boosting is implemented in cpu_util() so that internal
> - * users (e.g. EAS) can use it next to external users (e.g. schedutil),
> - * latter via cpu_util_cfs_boost().
> - *
>   * CPU utilization can be higher than the current CPU capacity
>   * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because
>   * of rounding errors as well as task migrations or wakeups of new tasks.
> @@ -8226,19 +8219,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>   * though since this is useful for predicting the CPU capacity required
>   * after task migrations (scheduler-driven DVFS).
>   *
> - * Return: (Boosted) (estimated) utilization for the specified CPU.
> + * Return: (Estimated) utilization for the specified CPU.
>   */
>  static unsigned long
> -cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
> +cpu_util(int cpu, struct task_struct *p, int dst_cpu)
>  {
>         struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
>         unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
> -       unsigned long runnable;
> -
> -       if (boost) {
> -               runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
> -               util = max(util, runnable);
> -       }
>
>         /*
>          * If @dst_cpu is -1 or @p migrates from @cpu to @dst_cpu remove its
> @@ -8295,12 +8282,7 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
>
>  unsigned long cpu_util_cfs(int cpu)
>  {
> -       return cpu_util(cpu, NULL, -1, 0);
> -}
> -
> -unsigned long cpu_util_cfs_boost(int cpu)
> -{
> -       return cpu_util(cpu, NULL, -1, 1);
> +       return cpu_util(cpu, NULL, -1);
>  }
>
>  /*
> @@ -8322,7 +8304,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
>         if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
>                 p = NULL;
>
> -       return cpu_util(cpu, p, -1, 0);
> +       return cpu_util(cpu, p, -1);
>  }
>
>  /*
> @@ -8489,7 +8471,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
>         int cpu;
>
>         for_each_cpu(cpu, pd_cpus) {
> -               unsigned long util = cpu_util(cpu, p, -1, 0);
> +               unsigned long util = cpu_util(cpu, p, -1);
>
>                 busy_time += effective_cpu_util(cpu, util, NULL, NULL);
>         }
> @@ -8513,7 +8495,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
>
>         for_each_cpu(cpu, pd_cpus) {
>                 struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
> -               unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
> +               unsigned long util = cpu_util(cpu, p, dst_cpu);
>                 unsigned long eff_util, min, max;
>
>                 /*
> @@ -8675,7 +8657,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                         if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>                                 continue;
>
> -                       util = cpu_util(cpu, p, cpu, 0);
> +                       util = cpu_util(cpu, p, cpu);
>                         cpu_cap = capacity_of(cpu);
>
>                         /*
> @@ -11848,7 +11830,7 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
>                         break;
>
>                 case migrate_util:
> -                       util = cpu_util_cfs_boost(i);
> +                       util = cpu_util_cfs(i);
>
>                         /*
>                          * Don't try to pull utilization from a CPU with one
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 9f63b15d309d..1c934dd126b2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3551,7 +3551,6 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
>
>
>  extern unsigned long cpu_util_cfs(int cpu);
> -extern unsigned long cpu_util_cfs_boost(int cpu);
>
>  static inline unsigned long cpu_util_rt(struct rq *rq)
>  {
> --
> 2.47.3
>

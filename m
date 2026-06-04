Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B31DF73C
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 08:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562918; cv=pass; b=qpGLCqok0+D0WPJP6oubNgHBUjDQLh6lteTzQ13qZNqeGrI0l46acqMxlVS03YbYKf1nCPeJCb8qgEy/7tlSlnPIHmba3KrP0oS1FHnWqqTD54SW5RkjYeaO/vERrcJBhdVMFotEzjNwa4u+1a/aY90AWyG4NXH6QLPKTgVCKqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562918; c=relaxed/simple;
	bh=aHAlTyJEiIHg5Dm3j3KlkAoWV8NF4Z0rzCeopJ0RJEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfhZa8YTS/aBUrxNAfyJRJAds1uX9JYCqlYEthZxsglGHApfjFPLr4rFvKD6Vcn7l5p3Wwdtd5G/DiXrsxHv72UimBzinUI89wHEMb9n5s98KZ0seJLAv06VFhCH6SvzV66tlRETADHxKV+HG1RFl1MaIkii2wWknixUrBaqTts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MRqb9f7d; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MRqb9f7d"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68e5f7c1131so779960a12.2
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 01:48:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780562915; cv=none;
        d=google.com; s=arc-20240605;
        b=X1kriigKFSL8FmWlmY40gBiP+lRNxfuPVaS8u/lLwyD7QS2bGbrm7mD0EW7XZ/I8Lx
         CeFxQWN7a51TNbBE0d2LK8mtMvzXwXe3HfFi/bPZEm/rekY1EuVoxJTVPLkDZM0UuiOo
         MO5XvNFYn6Z8ejgT8R8C7H3zq9awi7fsXWj7hTeFwvT9P6ijtAQceY7LLccScV7UNm/v
         zYzbf5E5PZhVhusvYzwReY3BAEvOQ5ccYtu6CtrOABbCypfg7uhYKCVSIZyEIYzIYrBw
         0QGWLvLSlHMCuqs23S1yhShcBmBYf15roGVpdJUa0ibTCrgd9HggDKvDl/72ZeukzUBA
         PLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Wub8tXtsARABoIz3kb+2wKOYALzNJEKrHZpvo28yOCg=;
        fh=0jq2gVD5zgo/d9zhK6cOQb57wuiLLXG1OSr3F9IbqHs=;
        b=KrmvhPE9qcqIYSjRl7BXCvtOCS62HNwvU8m7p/5ox7/kS/Gs1KPE7aCn7eMqMgmOZl
         7Ld6mNqa+V5pluTo3vAVquX/vzPMkq6zpY6fkKe0nOpQ7TsuGkb65NBKWiHjyxBC5t+B
         70oHBsXJlVaFp2BpvjU5+rTJdDbkxPgZ8WaBjFNTZm6bQdWmPgSWpJ+bBl6tlmwj/1h8
         v2UBWMLcLbOMMAn0PYFn+OgP5LUrcjljQlZkhEZEvNyyIOcDL1SAjtvyo4H3FaYoctYf
         nkNTrY45Vg6smr3ps1FbBRxBWP98EjmtV/b99q2lt2/Kd3fOn7M1XE5s67Z6rp7+rvVr
         qKPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780562915; x=1781167715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wub8tXtsARABoIz3kb+2wKOYALzNJEKrHZpvo28yOCg=;
        b=MRqb9f7dAjMQXgUK+J64nadWjgktdUHa1Eg/A43QhinJxrc23kY7AgYSFdO07phZq+
         UFTg2Ufp1rCIOzcWiRViig17kXp1zt3QqjhNg0RR9JOphrZQ4SPWT4FCaCIIDGfSqZz4
         DDHUKHXs7f1ieDe/4OokqItjepZdDo836UPGnhcLZ+gNTS1SMTKIYN8YYWjH8NzT92Ob
         0BX1EA92BJn84C1Is+1d1vam9yQCCfhRsEXbAwuSQCw0cwIgHGQ6jBNj4LQ7iMAAuU2T
         YAdKN7mQ70cfWZ0trciqCkhfqG8/uaR6bjJO+bhjZxQ4IMSBeBlFpP22S8UYaAMlYRx2
         3jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562915; x=1781167715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wub8tXtsARABoIz3kb+2wKOYALzNJEKrHZpvo28yOCg=;
        b=e8GCCcwsVoi5OiHC3rxfKOiKapPoKIXlxEmvok7r25jIa1T4MAPw4JRevy6SwyTh07
         GWgcQDT0qC6Ktwaz/wE8rx92Ca1O4MpnJbv06wahOc01CTAgUqwkcNZRQZ81SvSqSfBY
         WgGrFuxtgs1OZpG3TbNptzOQpOxEIXnhwMkfRduWe50Jep5NgsLt4Z/jSH0Gl47gH87P
         hiadMLnz8tRoz6EwWDZEd9NcQTHxA/fFvIdzt9lW9nB4aQtPO4QZmKfR3UA8Oqt7Fdx7
         LUhxpniWSoEH5YNCnb8vmZftfEIv3fK3CpmaGGsyiLeyL0HutenDftDn14ddYiRxn9BU
         gHMw==
X-Forwarded-Encrypted: i=1; AFNElJ85elcmCtHfz3uhZuOk6XchydQLiVDJ12Ep19t/SAY5AX3cjaqDc5p+i98/u7nHCZ6zKJJ4R/0NWg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGGsKXBbpHdwahQux26i4RRuU8jZPYW8txeXk5MMMdxZaTlvs
	ri6zvB9/YhG/4MvebyXkK9vTLaNgNjbhO8yZoXz7vt+QjdukDu9HJJJVZ5hAV+hKD5Vmy1PnrSS
	zBbOHvhlyeDLP0x+45P1UildYvGMZHlCEBxmMmozqDg==
X-Gm-Gg: Acq92OFFg/OgBbhsS0yhJ1T9QY+EzYTYP3ZQITGl6BnqTeAICjmo/9W1LovFSLanBwt
	/yTeBOMc+10Y3v+J2nwqotUeau0bOYYt/Z7PQUkVNBZKVM1X7nmFx/y3M2T2X9CxTHFA0fAlwhy
	mGgn0cgoOrik2mpZCSmz5hKNrkugXV+78Y8eHafPVEGOL8SiC123seQ97BuDQsKlx0gsyHs7qUU
	Z9UnTArbwWfRlxFoou9EnQ1WHEq2cZvB1P3kaQn/WZYWgteVDwGFvikYOb3FJKGcHYKwa+HOy3a
	x50O//Z+xiD8G6S6NfuXtHN0dWYoI89IKgjvk7+q8Gpmb5U=
X-Received: by 2002:a05:6402:3215:b0:679:223c:d191 with SMTP id
 4fb4d7f45d1cf-68e713e3123mr3790751a12.13.1780562915185; Thu, 04 Jun 2026
 01:48:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528023611.2433-1-hongyan.xia@transsion.com>
 <CAKfTPtCnXrwBBvj6vGJfmLgESf4_3zwA4-m-N1ceMJ3ghOvFKQ@mail.gmail.com> <d665e99b-31f6-46e1-9cb4-6931642388ce@transsion.com>
In-Reply-To: <d665e99b-31f6-46e1-9cb4-6931642388ce@transsion.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 4 Jun 2026 10:48:23 +0200
X-Gm-Features: AVHnY4JtCCuwZLSDBESA8QoM-sdjfspfBgyFQFMzGeec89mUShvsP4f2aJDjFww
Message-ID: <CAKfTPtBJOtgMJLm1PhiLPFup9OWYLPCChumy5EKuLuEEbu2gYg@mail.gmail.com>
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

On Thu, 4 Jun 2026 at 10:21, Hongyan Xia <hongyan.xia@transsion.com> wrote:
>
> On 6/4/2026 3:42 PM, Vincent Guittot wrote:
> > On Thu, 28 May 2026 at 04:36, Hongyan Xia <hongyan.xia@transsion.com> wrote:
> >>
> >> From: Hongyan Xia <hongyan.xia@transsion.com>
> >>
> >> We have seen a massive power consumption regression (20% SoC power
> >> increase in many apps) after updating our kernel. After bisection we
> >
> > It's always good to provide more details: kernel, version, hardware
> > and the test condition
>
> This is on Dimensity 8400 SoC (1 big 3 mid 4 little). We just updated to
> the Android GKI kernel 6.6 which picked up this patch. We removed all
> scheduler vendor stuff so scheduler-wise this is close to an upstream
> 6.6 kernel. We run common Android apps on schedutil.
>
> I will add the above in the commit message.
>
> >> pinpointed the regression to the cpu_util(boost) feature. After
> >> reverting the boost feature the massive energy regression is gone.
> >> Detailed trace analysis down below. The regression is found across quite
> >> many apps but Youtube is one of the worst offenders. Some energy
> >> benchmark numbers are here.
> >>
> >> Youtube 1080p60fps video benchmark:
> >>                  FPS   SoC Power  diff
> >> w/  boost      59.94   913.6mW
> >> w/o boost      59.93   720.4mW  -21.15%
> >>
> >> Mobile Legends (gaming)
> >>                 FPS   sdev   Total power  diff
> >> w/  boost     120.16  0.47   3294.10mW
> >> w/o boost     120.07  0.56   2996.09mW  -9.05%
> >>
> >> Genshin Impact (gaming, medium quality)
> >>                  FPS   sdev  Total power  diff
> >> w/  boost      60.05  0.34   6215.84mW
> >> w/o boost      60.03  0.35   5695.46mW  -8.37%
> >>
> >> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> >>
> >> ---
> >> Changed in v2:
> >> - Sync all comments with code changes.
> >> - Update commit message with more benchmark numbers.
> >>
> >> Analysis:
> >>
> >> We found several problems that result in the power spike:
> >>
> >> 1. Arithmetic should not happen between util_avg and runnable_avg:
> >>
> >> After util = max(util, runnable) which potentially picks runnable value
> >> in cpu_util(), we then add or subtract task util values from it. This
> >> produces a value that is half-runnable-half-util which is ill-defined.
> >> This alone should be a warning sign. This breaks EAS calculations in
> >> many cases, leading to sub-optimal task placements.
> >
> > This can be easily fixed
>
> I thought about adding or subtracting runnable_avg instead, but that is
> still wrong. Given three tasks each with 100 util, if they wake up at
> the same time and running on the same rq, their util is 100, 100, 100,
> rq total util is 300. Their runnable_avg is 100, 200, 300, rq total
> runnable_avg is 600. If the 1st task leaves the rq, the remaining two
> task runnable_avg will then become 100, 200, giving a total rq
> runnable_avg of 300. However, subtracting the runnable_avg of the 1st
> task gives 600 - 100 = 500, which is very wrong.

Substracting/adding se.avg.runnable_avg is still the right solution
because this is what will happen if the task migrate

>
> I failed to find a way to fix this. The root cause is that it is
> impossible to know how much contention there is between the task you are
> adding or subtracting and other tasks on the same rq.
>
> >>
> >> 2. Using the absolute value of runnable_avg to drive frequency is
> >>     too high to be reasonable:
> >>
> >> Schedutil use runnable in a _relative_ way to util to know whether there
> >> is contention in several places. However, the _absolute_ value should
> >> not be used like util. Runnable_avg tends to be significantly higher,
> >> making it much easier to saturate frequency.
> >>
> >> For example, if three tasks each with a util of 100 contend on the same
> >> rq, the rq util is 300 but runnable_avg shoots up to 600, which is often
> >> much higher than needed.
> >
> > In the email thread of the prev version, you said that using
> > runnable_avg is good but not like the current implementation. So
> > instead of blindly reverting it, please submit a better usage, as this
> > was added to fix some performance issues.
>
> There might be some confusion in the prev email. I was saying that I
> agree we can use runnable_avg in comparison with util_avg to detect
> contention, but using the absolute runnable_avg in EAS and frequency
> selection is questionable.
>
> Actually my personal belief after many failed attempts is that using the
> absolute value of runnable_avg in place of util will just not work.
>
> >>
> >> 3. Runnable_avg may not even reflect true contention:
> >>
> >> When tasks are dependent, the bottleneck is often the data flow between
> >> tasks, not the contention seen by runnable_avg. Boosting frequency with
> >> runnable in such scenarios wastes power without performance benefits.
> >>
> >> We found 1 has minor power regression but 2 and 3 regresses power
> >> significantly. We have seen multiple applications with the
> >> producer-consumer model with many worker threads suffer. When there is
> >> IPC between producer and consumer, boosting frequency blindly does not
> >> help performance at all if consumer is limited by how much data is flown
> >> through. Youtube suffer from 1, 2 and 3 at the same time, leading to a
> >> total SoC power regression of 20% shown in the results above.
> >
> > Tasks contention is a real problem and runnable_avg is one metric that
> > reflects this.
>
> I agree, and it is used in places like util_est_update() to detect
> contention by comparing it with util_avg. I'm just saying the raw
> absolute value of runnable_avg is not a good metric to use in EAS and
> CPUFreq, regressing power by more than 20% in apps without much gain.
>
> >>
> >> ---
> >>   kernel/sched/cpufreq_schedutil.c |  2 +-
> >>   kernel/sched/fair.c              | 34 ++++++++------------------------
> >>   kernel/sched/sched.h             |  1 -
> >>   3 files changed, 9 insertions(+), 28 deletions(-)
> >>
> >> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> >> index ae9fd211cec1..ba867192513b 100644
> >> --- a/kernel/sched/cpufreq_schedutil.c
> >> +++ b/kernel/sched/cpufreq_schedutil.c
> >> @@ -228,7 +228,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu, unsigned long boost)
> >>          unsigned long min, max, util = scx_cpuperf_target(sg_cpu->cpu);
> >>
> >>          if (!scx_switched_all())
> >> -               util += cpu_util_cfs_boost(sg_cpu->cpu);
> >> +               util += cpu_util_cfs(sg_cpu->cpu);
> >>          util = effective_cpu_util(sg_cpu->cpu, util, &min, &max);
> >>          util = max(util, boost);
> >>          sg_cpu->bw_min = min;
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 728965851842..ecf8b4860951 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -8192,7 +8192,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>    * @cpu: the CPU to get the utilization for
> >>    * @p: task for which the CPU utilization should be predicted or NULL
> >>    * @dst_cpu: CPU @p migrates to, -1 if @p moves from @cpu or @p == NULL
> >> - * @boost: 1 to enable boosting, otherwise 0
> >>    *
> >>    * The unit of the return value must be the same as the one of CPU capacity
> >>    * so that CPU utilization can be compared with CPU capacity.
> >> @@ -8210,12 +8209,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>    * be when a long-sleeping task wakes up. The contribution to CPU utilization
> >>    * of such a task would be significantly decayed at this point of time.
> >>    *
> >> - * Boosted CPU utilization is defined as max(CPU runnable, CPU utilization).
> >> - * CPU contention for CFS tasks can be detected by CPU runnable > CPU
> >> - * utilization. Boosting is implemented in cpu_util() so that internal
> >> - * users (e.g. EAS) can use it next to external users (e.g. schedutil),
> >> - * latter via cpu_util_cfs_boost().
> >> - *
> >>    * CPU utilization can be higher than the current CPU capacity
> >>    * (f_curr/f_max * max CPU capacity) or even the max CPU capacity because
> >>    * of rounding errors as well as task migrations or wakeups of new tasks.
> >> @@ -8226,19 +8219,13 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
> >>    * though since this is useful for predicting the CPU capacity required
> >>    * after task migrations (scheduler-driven DVFS).
> >>    *
> >> - * Return: (Boosted) (estimated) utilization for the specified CPU.
> >> + * Return: (Estimated) utilization for the specified CPU.
> >>    */
> >>   static unsigned long
> >> -cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
> >> +cpu_util(int cpu, struct task_struct *p, int dst_cpu)
> >>   {
> >>          struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
> >>          unsigned long util = READ_ONCE(cfs_rq->avg.util_avg);
> >> -       unsigned long runnable;
> >> -
> >> -       if (boost) {
> >> -               runnable = READ_ONCE(cfs_rq->avg.runnable_avg);
> >> -               util = max(util, runnable);
> >> -       }
> >>
> >>          /*
> >>           * If @dst_cpu is -1 or @p migrates from @cpu to @dst_cpu remove its
> >> @@ -8295,12 +8282,7 @@ cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
> >>
> >>   unsigned long cpu_util_cfs(int cpu)
> >>   {
> >> -       return cpu_util(cpu, NULL, -1, 0);
> >> -}
> >> -
> >> -unsigned long cpu_util_cfs_boost(int cpu)
> >> -{
> >> -       return cpu_util(cpu, NULL, -1, 1);
> >> +       return cpu_util(cpu, NULL, -1);
> >>   }
> >>
> >>   /*
> >> @@ -8322,7 +8304,7 @@ static unsigned long cpu_util_without(int cpu, struct task_struct *p)
> >>          if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
> >>                  p = NULL;
> >>
> >> -       return cpu_util(cpu, p, -1, 0);
> >> +       return cpu_util(cpu, p, -1);
> >>   }
> >>
> >>   /*
> >> @@ -8489,7 +8471,7 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
> >>          int cpu;
> >>
> >>          for_each_cpu(cpu, pd_cpus) {
> >> -               unsigned long util = cpu_util(cpu, p, -1, 0);
> >> +               unsigned long util = cpu_util(cpu, p, -1);
> >>
> >>                  busy_time += effective_cpu_util(cpu, util, NULL, NULL);
> >>          }
> >> @@ -8513,7 +8495,7 @@ eenv_pd_max_util(struct energy_env *eenv, struct cpumask *pd_cpus,
> >>
> >>          for_each_cpu(cpu, pd_cpus) {
> >>                  struct task_struct *tsk = (cpu == dst_cpu) ? p : NULL;
> >> -               unsigned long util = cpu_util(cpu, p, dst_cpu, 1);
> >> +               unsigned long util = cpu_util(cpu, p, dst_cpu);
> >>                  unsigned long eff_util, min, max;
> >>
> >>                  /*
> >> @@ -8675,7 +8657,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >>                          if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> >>                                  continue;
> >>
> >> -                       util = cpu_util(cpu, p, cpu, 0);
> >> +                       util = cpu_util(cpu, p, cpu);
> >>                          cpu_cap = capacity_of(cpu);
> >>
> >>                          /*
> >> @@ -11848,7 +11830,7 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
> >>                          break;
> >>
> >>                  case migrate_util:
> >> -                       util = cpu_util_cfs_boost(i);
> >> +                       util = cpu_util_cfs(i);
> >>
> >>                          /*
> >>                           * Don't try to pull utilization from a CPU with one
> >> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> >> index 9f63b15d309d..1c934dd126b2 100644
> >> --- a/kernel/sched/sched.h
> >> +++ b/kernel/sched/sched.h
> >> @@ -3551,7 +3551,6 @@ static inline unsigned long cpu_util_dl(struct rq *rq)
> >>
> >>
> >>   extern unsigned long cpu_util_cfs(int cpu);
> >> -extern unsigned long cpu_util_cfs_boost(int cpu);
> >>
> >>   static inline unsigned long cpu_util_rt(struct rq *rq)
> >>   {
> >> --
> >> 2.47.3
> >>
>

From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [RFC 2/3] sched/fair: use util_est in LB
Date: Tue, 29 Aug 2017 10:15:58 +0530
Message-ID: <CAEU1=P=EWa78hM0Wha=38qC7AqqVzhWahmhHNTrAco=nG=Ou9w@mail.gmail.com>
References: <20170825102008.4626-1-patrick.bellasi@arm.com> <20170825102008.4626-3-patrick.bellasi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55854 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbdH2EqB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 00:46:01 -0400
In-Reply-To: <20170825102008.4626-3-patrick.bellasi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>

On Fri, Aug 25, 2017 at 3:50 PM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> When the scheduler looks at the CPU utlization, the current PELT value
> for a CPU is returned straight away. In certain scenarios this can have
> undesired side effects on task placement.
>

<snip>

> +/**
> + * cpu_util_est: estimated utilization for the specified CPU
> + * @cpu: the CPU to get the estimated utilization for
> + *
> + * The estimated utilization of a CPU is defined to be the maximum between its
> + * PELT's utilization and the sum of the estimated utilization of the tasks
> + * currently RUNNABLE on that CPU.
> + *
> + * This allows to properly represent the expected utilization of a CPU which
> + * has just got a big task running since a long sleep period. At the same time
> + * however it preserves the benefits of the "blocked load" in describing the
> + * potential for other tasks waking up on the same CPU.
> + *
> + * Return: the estimated utlization for the specified CPU
> + */
> +static inline unsigned long cpu_util_est(int cpu)
> +{
> +       struct sched_avg *sa = &cpu_rq(cpu)->cfs.avg;
> +       unsigned long util = cpu_util(cpu);
> +
> +       if (!sched_feat(UTIL_EST))
> +               return util;
> +
> +       return max(util, util_est(sa, UTIL_EST_LAST));
> +}
> +
>  static inline int task_util(struct task_struct *p)
>  {
>         return p->se.avg.util_avg;
> @@ -6007,11 +6033,19 @@ static int cpu_util_wake(int cpu, struct task_struct *p)
>
>         /* Task has no contribution or is new */
>         if (cpu != task_cpu(p) || !p->se.avg.last_update_time)
> -               return cpu_util(cpu);
> +               return cpu_util_est(cpu);
>
>         capacity = capacity_orig_of(cpu);
>         util = max_t(long, cpu_rq(cpu)->cfs.avg.util_avg - task_util(p), 0);
>
> +       /*
> +        * Estimated utilization tracks only tasks already enqueued, but still
> +        * sometimes can return a bigger value than PELT, for example when the
> +        * blocked load is negligible wrt the estimated utilization of the
> +        * already enqueued tasks.
> +        */
> +       util = max_t(long, util, cpu_util_est(cpu));
> +

We are supposed to discount the task's util from its CPU. But the
cpu_util_est() can potentially return cpu_util() which includes the
task's utilization.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project

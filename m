From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [RFC 2/3] sched/fair: use util_est in LB
Date: Mon, 4 Sep 2017 20:29:27 +0530
Message-ID: <CAEU1=P=iRCbFx-dBzDq+yBK+tJ6z_qp+7PZuCj1vqD551k9YBg@mail.gmail.com>
References: <20170825102008.4626-1-patrick.bellasi@arm.com>
 <20170825102008.4626-3-patrick.bellasi@arm.com> <CAEU1=P=EWa78hM0Wha=38qC7AqqVzhWahmhHNTrAco=nG=Ou9w@mail.gmail.com>
 <20170904141817.GD2618@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904141817.GD2618@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <juri.lelli@arm.com>, Tim Murray <timmurray@google.com>, Todd Kjos <tkjos@android.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 4, 2017 at 7:48 PM, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> On 29-Aug 10:15, Pavan Kondeti wrote:
>> On Fri, Aug 25, 2017 at 3:50 PM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>> > When the scheduler looks at the CPU utlization, the current PELT value
>> > for a CPU is returned straight away. In certain scenarios this can have
>> > undesired side effects on task placement.
>> >
>>
>> <snip>
>>
>> > +/**
>> > + * cpu_util_est: estimated utilization for the specified CPU
>> > + * @cpu: the CPU to get the estimated utilization for
>> > + *
>> > + * The estimated utilization of a CPU is defined to be the maximum between its
>> > + * PELT's utilization and the sum of the estimated utilization of the tasks
>> > + * currently RUNNABLE on that CPU.
>> > + *
>> > + * This allows to properly represent the expected utilization of a CPU which
>> > + * has just got a big task running since a long sleep period. At the same time
>> > + * however it preserves the benefits of the "blocked load" in describing the
>> > + * potential for other tasks waking up on the same CPU.
>> > + *
>> > + * Return: the estimated utlization for the specified CPU
>> > + */
>> > +static inline unsigned long cpu_util_est(int cpu)
>> > +{
>> > +       struct sched_avg *sa = &cpu_rq(cpu)->cfs.avg;
>> > +       unsigned long util = cpu_util(cpu);
>> > +
>> > +       if (!sched_feat(UTIL_EST))
>> > +               return util;
>> > +
>> > +       return max(util, util_est(sa, UTIL_EST_LAST));
>> > +}
>> > +
>> >  static inline int task_util(struct task_struct *p)
>> >  {
>> >         return p->se.avg.util_avg;
>> > @@ -6007,11 +6033,19 @@ static int cpu_util_wake(int cpu, struct task_struct *p)
>> >
>> >         /* Task has no contribution or is new */
>> >         if (cpu != task_cpu(p) || !p->se.avg.last_update_time)
>> > -               return cpu_util(cpu);
>> > +               return cpu_util_est(cpu);
>> >
>> >         capacity = capacity_orig_of(cpu);
>> >         util = max_t(long, cpu_rq(cpu)->cfs.avg.util_avg - task_util(p), 0);
>> >
>> > +       /*
>> > +        * Estimated utilization tracks only tasks already enqueued, but still
>> > +        * sometimes can return a bigger value than PELT, for example when the
>> > +        * blocked load is negligible wrt the estimated utilization of the
>> > +        * already enqueued tasks.
>> > +        */
>> > +       util = max_t(long, util, cpu_util_est(cpu));
>> > +
>>
>> We are supposed to discount the task's util from its CPU. But the
>> cpu_util_est() can potentially return cpu_util() which includes the
>> task's utilization.
>
> You right, this instead should cover all the cases:
>
> ---8<---
>  static int cpu_util_wake(int cpu, struct task_struct *p)
>  {
> -       unsigned long util, capacity;
> +       unsigned long util_est = cpu_util_est(cpu);
> +       unsigned long capacity;
>
>         /* Task has no contribution or is new */
>         if (cpu != task_cpu(p) || !p->se.avg.last_update_time)
> -               return cpu_util(cpu);
> +               return util_est;
>
>         capacity = capacity_orig_of(cpu);
> -       util = max_t(long, cpu_rq(cpu)->cfs.avg.util_avg - task_util(p), 0);
> +       if (cpu_util(cpu) > util_est)
> +               util = max_t(long, cpu_util(cpu) - task_util(p), 0);
> +       else
> +               util = util_est;
>
>         return (util >= capacity) ? capacity : util;
>  }
> ---8<---
>
> Indeed:
>
> - if *p is the only task sleeping on that CPU, then:
>       (cpu_util == task_util) > (cpu_util_est == 0)
>   and thus we return:
>       (cpu_util - task_util) == 0
>
> - if other tasks are SLEEPING on the same CPU, which however is IDLE, then:
>       cpu_util > (cpu_util_est == 0)
>   and thus we discount *p's blocked load by returning:
>       (cpu_util - task_util) >= 0
>
> - if other tasks are RUNNABLE on that CPU and
>       (cpu_util_est > cpu_util)
>   then we wanna use cpu_util_est since it returns a more restrictive
>   estimation of the spare capacity on that CPU, by just considering
>   the expected utilization of tasks already runnable on that CPU.
>
> What do you think?
>

This looks good to me.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project

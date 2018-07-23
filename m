From: Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v2 10/12] sched/core: uclamp: use TG's clamps to restrict
 Task's clamps
Date: Mon, 23 Jul 2018 10:11:17 -0700
Message-ID: <CAJuCfpHJ=O1QVFZZ2dpaDDQe+dX1aGkzWdcd76c9zZpxw2fNtA@mail.gmail.com>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-11-patrick.bellasi@arm.com> <CAJuCfpFnj2g3+ZpR4fP4yqfxs0zd=c-Zehr2XM7m_C+WdL9jNA@mail.gmail.com>
 <20180723154025.GF2683@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723154025.GF2683@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 23, 2018 at 8:40 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 21-Jul 20:05, Suren Baghdasaryan wrote:
>> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>> > When a task's util_clamp value is configured via sched_setattr(2), this
>> > value has to be properly accounted in the corresponding clamp group
>> > every time the task is enqueued and dequeued. When cgroups are also in
>> > use, per-task clamp values have to be aggregated to those of the CPU's
>> > controller's Task Group (TG) in which the task is currently living.
>> >
>> > Let's update uclamp_cpu_get() to provide aggregation between the task
>> > and the TG clamp values. Every time a task is enqueued, it will be
>> > accounted in the clamp_group which defines the smaller clamp between the
>> > task specific value and its TG value.
>>
>> So choosing smallest for both UCLAMP_MIN and UCLAMP_MAX means the
>> least boosted value and the most clamped value between syscall and TG
>> will be used.
>
> Right
>
>> My understanding is that boost means "at least this much" and clamp
>> means "at most this much".
>
> Right
>
>> So to satisfy both TG and syscall requirements I think you would
>> need to choose the largest value for UCLAMP_MIN and the smallest one
>> for UCLAMP_MAX, meaning the most boosted and most clamped range.
>> Current implementation choses the least boosted value, so
>> effectively one of the UCLAMP_MIN requirements (either from TG or
>> from syscall) are being ignored...  Could you please clarify why
>> this choice is made?
>
> The TG values are always used to specify a _restriction_ on
> task-specific values.
>
> Thus, if you look or example at the CPU mask for a task, you can have
> a task with affinity to CPUs 0-1, currently running on a cgroup with
> cpuset.cpus=0... then the task can run only on CPU 0 (althought its
> affinity includes CPU1 too).
>
> Same we do here: if a task has util_min=10, but it's running in a
> cgroup with cpu.util_min=0, then it will not be boosted.
>
> IOW, this allows to implement a "nice" policy at task level, where a
> task (via syscall) can decide to be less boosted with respect to its
> group but never more boosted. The same task can also decide to be more
> clamped, but not less clamped then its current group.
>

The fact that boost means "at least this much" to me seems like we can
safely choose higher CPU bandwidth (as long as it's lower than
UCLAMP_MAX) but from your description sounds like TG's UCLAMP_MIN
means "at most this much boost" and it's not safe to use CPU bandwidth
higher than TG's UCLAMP_MIN. So instead of specifying min CPU
bandwidth for a task it specifies the max allowed boost. Seems like a
discrepancy to me but maybe there are compelling usecases when this
behavior is necessary? In that case would be good to spell them out to
explain why this choice is made.

> [...]
>
>> > @@ -982,18 +989,30 @@ static inline void uclamp_cpu_get_id(struct task_struct *p,
>> >         int clamp_value;
>> >         int group_id;
>> >
>> > -       /* No task specific clamp values: nothing to do */
>> >         group_id = p->uclamp[clamp_id].group_id;
>> > +       clamp_value = p->uclamp[clamp_id].value;
>> > +#ifdef CONFIG_UCLAMP_TASK_GROUP
>> > +       /* Use TG's clamp value to limit task specific values */
>> > +       if (group_id == UCLAMP_NONE ||
>> > +           clamp_value >= task_group(p)->uclamp[clamp_id].value) {
>>
>> Not a big deal but do you need to override if (clamp_value ==
>> task_group(p)->uclamp[clamp_id].value)? Maybe:
>> -           clamp_value >= task_group(p)->uclamp[clamp_id].value) {
>> +          clamp_value > task_group(p)->uclamp[clamp_id].value) {
>
> Good point, yes... the override is not really changing anything here.
> Will fix this!
>
>> > +               clamp_value = task_group(p)->uclamp[clamp_id].value;
>> > +               group_id = task_group(p)->uclamp[clamp_id].group_id;
>> > +       }
>> > +#else
>> > +       /* No task specific clamp values: nothing to do */
>> >         if (group_id == UCLAMP_NONE)
>> >                 return;
>> > +#endif
>> >
>> >         /* Reference count the task into its current group_id */
>> >         uc_grp = &rq->uclamp.group[clamp_id][0];
>> >         uc_grp[group_id].tasks += 1;
>> >
>> > +       /* Track the effective clamp group */
>> > +       p->uclamp_group_id[clamp_id] = group_id;
>> > +
>> >         /* Force clamp update on idle exit */
>> >         uc_cpu = &rq->uclamp;
>> > -       clamp_value = p->uclamp[clamp_id].value;
>> >         if (unlikely(uc_cpu->flags & UCLAMP_FLAG_IDLE)) {
>> >                 if (clamp_id == UCLAMP_MAX)
>> >                         uc_cpu->flags &= ~UCLAMP_FLAG_IDLE;
>
> [...]
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi

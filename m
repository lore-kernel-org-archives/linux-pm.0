From: Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v4 11/16] sched/core: uclamp: add system default clamps
Date: Tue, 11 Sep 2018 12:25:28 -0700
Message-ID: <CAJuCfpGK0PRt9-=+mjOM=VQqas8DPxT7YPiZojiQQiVuhua7bA@mail.gmail.com>
References: <20180828135324.21976-1-patrick.bellasi@arm.com>
 <20180828135324.21976-12-patrick.bellasi@arm.com> <CAJuCfpGSUzo9gxWZABUUKaEEEvxdnvny9d1ErnLVLEKrkYf+eQ@mail.gmail.com>
 <20180911164637.GC1413@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180911164637.GC1413@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Quentin Perret <quentin.perret@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Sep 11, 2018 at 9:46 AM, Patrick Bellasi
<patrick.bellasi@arm.com> wrote:
> On 10-Sep 09:20, Suren Baghdasaryan wrote:
>> On Tue, Aug 28, 2018 at 6:53 AM, Patrick Bellasi
>> <patrick.bellasi@arm.com> wrote:
>
> [...]
>
>> > @@ -1509,12 +1633,17 @@ static void __init init_uclamp(void)
>> >                 uc_se->group_id = UCLAMP_NOT_VALID;
>> >                 uclamp_group_get(NULL, clamp_id, 0, uc_se,
>> >                                  uclamp_none(clamp_id));
>> > +               /*
>> > +                * By default we do not want task-specific clamp values,
>> > +                * so that system default values apply.
>> > +                */
>> > +               uc_se->value = UCLAMP_NOT_VALID;
>> >
>> >  #ifdef CONFIG_UCLAMP_TASK_GROUP
>> >                 /* Init root TG's clamp group */
>> >                 uc_se = &root_task_group.uclamp[clamp_id];
>> >
>> > -               uc_se->effective.value = uclamp_none(clamp_id);
>> > +               uc_se->effective.value = uclamp_none(UCLAMP_MAX);
>>
>> Both clamps are initialized with 1023 because children can go lower
>> but can't go higher? Comment might be helpful.
>
> Yes, that's because with CGroups we set the max allowed value, which
> is also the one used for a clamp IFF:
>  - the task is not part of a more restrictive group
>  - the task has not a more restrictive task specific value
>
> I'll improve this comment on the next respin.
>
>> I saw this pattern of using uclamp_none(UCLAMP_MAX) for both clamps in
>> couple places.
>
> The other place is to define / initialize "uclamp_default_perf", which
> is the default clamps used for RT tasks, introduce by the last patch:
>
>  https://lore.kernel.org/lkml/20180828135324.21976-17-patrick.bellasi@arm.com/
>
> So, RT tasks and root task group are the only two exceptions for
> which, by default, we want a maximum boosting.
>
>> Maybe would be better to have smth like:
>>
>> static inline int tg_uclamp_none(int clamp_id) {
>>     /* TG's min and max clamps default to SCHED_CAPACITY_SCALE to
>> allow children to tighten the restriction */
>>     return SCHED_CAPACITY_SCALE;
>> }
>>
>> and use tg_uclamp_none(clamp_id) instead of uclamp_none(UCLAMP_MAX)?
>> Functionally the same but much more readable.
>
> Not entirely convinced, maybe because of the name you suggest: it
> cannot contain tg, because it applies also to RT tasks when TG are not
> in use.
>
> Maybe something like: uclamp_max_boost(clamp_id) could work instead ?

Sounds good to me.

>
> It will make more explicit that the configuration will maps into a:
>
>      util.min = util.max = SCHED_CAPACITY_SCALE
>
> Cheers,
> Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi

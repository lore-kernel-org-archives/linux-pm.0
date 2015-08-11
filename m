From: Juri Lelli <juri.lelli@arm.com>
Subject: Re: [RFCv5 PATCH 41/46] sched/fair: add triggers for OPP change requests
Date: Tue, 11 Aug 2015 16:07:48 +0100
Message-ID: <55CA0FC4.4050908@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-42-git-send-email-morten.rasmussen@arm.com> <CAKfTPtBfNV=K+gwb7dfQXqBEbByMWRoFDb0FtfeeY1hh33j4XA@mail.gmail.com> <55C8AA92.8000201@arm.com> <CAKfTPtAJY5zH4YeFibLSg7BbCwV76++fJ_f+uNz8=0t8V8TJWA@mail.gmail.com> <55C9BB78.1090508@arm.com> <CAKfTPtDWTon2m=tYU+taZYxgJV2OhPQXX_+Ku+ty=EjEpAzDsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:63665 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752281AbbHKPHL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 11 Aug 2015 11:07:11 -0400
In-Reply-To: <CAKfTPtDWTon2m=tYU+taZYxgJV2OhPQXX_+Ku+ty=EjEpAzDsA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Morten Rasmussen <Morten.Rasmussen@arm.com>, Peter Zijlstra <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Yuyang Du <yuyang.du@intel.com>, Michael Turquette <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Sai Charan Gurrappadi <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

Hi Vincent,

On 11/08/15 12:41, Vincent Guittot wrote:
> On 11 August 2015 at 11:08, Juri Lelli <juri.lelli@arm.com> wrote:
>> On 10/08/15 16:07, Vincent Guittot wrote:
>>> On 10 August 2015 at 15:43, Juri Lelli <juri.lelli@arm.com> wrote:
>>>>
>>>> Hi Vincent,
>>>>
>>>> On 04/08/15 14:41, Vincent Guittot wrote:
>>>>> Hi Juri,
>>>>>
>>>>> On 7 July 2015 at 20:24, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>>>>>> From: Juri Lelli <juri.lelli@arm.com>
>>>>>>
>>>>>> Each time a task is {en,de}queued we might need to adapt the current
>>>>>> frequency to the new usage. Add triggers on {en,de}queue_task_fair() for
>>>>>> this purpose.  Only trigger a freq request if we are effectively waking up
>>>>>> or going to sleep.  Filter out load balancing related calls to reduce the
>>>>>> number of triggers.
>>>>>>
>>>>>> cc: Ingo Molnar <mingo@redhat.com>
>>>>>> cc: Peter Zijlstra <peterz@infradead.org>
>>>>>>
>>>>>> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
>>>>>> ---
>>>>>>  kernel/sched/fair.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>>>>>>  1 file changed, 40 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>>> index f74e9d2..b8627c6 100644
>>>>>> --- a/kernel/sched/fair.c
>>>>>> +++ b/kernel/sched/fair.c
>>>>>> @@ -4281,7 +4281,10 @@ static inline void hrtick_update(struct rq *rq)
>>>>>>  }
>>>>>>  #endif
>>>>>>
>>>>>> +static unsigned int capacity_margin = 1280; /* ~20% margin */
>>>>>> +
>>>>>>  static bool cpu_overutilized(int cpu);
>>>>>> +static unsigned long get_cpu_usage(int cpu);
>>>>>>  struct static_key __sched_energy_freq __read_mostly = STATIC_KEY_INIT_FALSE;
>>>>>>
>>>>>>  /*
>>>>>> @@ -4332,6 +4335,26 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>>>>                 if (!task_new && !rq->rd->overutilized &&
>>>>>>                     cpu_overutilized(rq->cpu))
>>>>>>                         rq->rd->overutilized = true;
>>>>>> +               /*
>>>>>> +                * We want to trigger a freq switch request only for tasks that
>>>>>> +                * are waking up; this is because we get here also during
>>>>>> +                * load balancing, but in these cases it seems wise to trigger
>>>>>> +                * as single request after load balancing is done.
>>>>>> +                *
>>>>>> +                * XXX: how about fork()? Do we need a special flag/something
>>>>>> +                *      to tell if we are here after a fork() (wakeup_task_new)?
>>>>>> +                *
>>>>>> +                * Also, we add a margin (same ~20% used for the tipping point)
>>>>>> +                * to our request to provide some head room if p's utilization
>>>>>> +                * further increases.
>>>>>> +                */
>>>>>> +               if (sched_energy_freq() && !task_new) {
>>>>>> +                       unsigned long req_cap = get_cpu_usage(cpu_of(rq));
>>>>>> +
>>>>>> +                       req_cap = req_cap * capacity_margin
>>>>>> +                                       >> SCHED_CAPACITY_SHIFT;
>>>>>> +                       cpufreq_sched_set_cap(cpu_of(rq), req_cap);
>>>>>> +               }
>>>>>>         }
>>>>>>         hrtick_update(rq);
>>>>>>  }
>>>>>> @@ -4393,6 +4416,23 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>>>>         if (!se) {
>>>>>>                 sub_nr_running(rq, 1);
>>>>>>                 update_rq_runnable_avg(rq, 1);
>>>>>> +               /*
>>>>>> +                * We want to trigger a freq switch request only for tasks that
>>>>>> +                * are going to sleep; this is because we get here also during
>>>>>> +                * load balancing, but in these cases it seems wise to trigger
>>>>>> +                * as single request after load balancing is done.
>>>>>> +                *
>>>>>> +                * Also, we add a margin (same ~20% used for the tipping point)
>>>>>> +                * to our request to provide some head room if p's utilization
>>>>>> +                * further increases.
>>>>>> +                */
>>>>>> +               if (sched_energy_freq() && task_sleep) {
>>>>>> +                       unsigned long req_cap = get_cpu_usage(cpu_of(rq));
>>>>>> +
>>>>>> +                       req_cap = req_cap * capacity_margin
>>>>>> +                                       >> SCHED_CAPACITY_SHIFT;
>>>>>> +                       cpufreq_sched_set_cap(cpu_of(rq), req_cap);
>>>>>
>>>>> Could you clarify why you want to trig a freq switch for tasks that
>>>>> are going to sleep ?
>>>>> The cpu_usage should not changed that much as the se_utilization of
>>>>> the entity moves from utilization_load_avg to utilization_blocked_avg
>>>>> of the rq and the usage and the freq are updated periodically.
>>>>
>>>> I think we still need to cover multiple back-to-back dequeues. Suppose
>>>> that you have, let's say, 3 tasks that get enqueued at the same time.
>>>> After some time the first one goes to sleep and its utilization, as you
>>>> say, gets moved to utilization_blocked_avg. So, nothing changes, and
>>>> the trigger is superfluous (even if no freq change I guess will be
>>>> issued as we are already servicing enough capacity). However, after a
>>>> while, the second task goes to sleep. Now we still use get_cpu_usage()
>>>> and the first task contribution in utilization_blocked_avg should have
>>>> been decayed by this time. Same thing may than happen for the third task
>>>> as well. So, if we don't check if we need to scale down in
>>>> dequeue_task_fair, it seems to me that we might miss some opportunities,
>>>> as blocked contribution of other tasks could have been successively
>>>> decayed.
>>>>
>>>> What you think?
>>>
>>> The tick is used to monitor such variation of the usage (in both way,
>>> decay of the usage of sleeping tasks and increase of the usage of
>>> running tasks). So in your example, if the duration between the sleep
>>> of the 2 tasks is significant enough, the tick will handle this
>>> variation
>>>
>>
>> The tick is used to decide if we need to scale up (to max OPP for the
>> time being), but we don't scale down. It makes more logical sense to
> 
> why don't you want to check if you need to scale down ?
> 

Well, because if I'm still executing something the cpu usage is only
subject to raise.

>> scale down at task deactivation, or wakeup after a long time, IMHO.
> 
> But waking up or going to sleep don't have any impact on the usage of
> a cpu. The only events that impact the cpu usage are:
> -task migration,

We explicitly cover this on load balancing paths.

> -new task

We cover this in enqueue_task_fair(), introducing a new flag.

> -time that elapse which can be monitored by periodically checking the usage.

Do you mean when a task utilization crosses some threshold
related to the current OPP? If that is the case, we have a
check in task_tick_fair().

> -and for nohz system when cpu enter or leave idle state
> 

We address this in dequeue_task_fair(). In particular, if
the cpu is going to be idle we don't trigger any change as
it seems not always wise to wake up a thread to just change
the OPP and the go idle; some platforms might require this
behaviour anyway, but it probably more cpuidle/fw related?

I would also add:

- task is going to die

We address this in dequeue as well, as its contribution is
removed from usage (mod Yuyang's patches).

> waking up and going to sleep events doesn't give any useful
> information and using them to trig the monitoring of the usage
> variation doesn't give you a predictable/periodic update of it whereas
> the tick will
> 

So, one key point of this solution is to get away as much
as we can from periodic updates/sampling and move towards a
(fully) event driven approach. The event logically associated
to task_tick_fair() is when we realize that a task is going
to saturate the current capacity; in this case we trigger a
freq switch to an higher capacity. Also, if we never react
to normal wakeups (as I understand you are proposing) we might
miss some chances to adapt quickly enough. As an example, if
you have a big task that suddenly goes to sleep, and sleeps
until its decayed utilization goes almost to zero; when it
wakes up, if we don't have a trigger in enqueue_task_fair(),
we'll have to wait until the next tick to select an appropriate
(low) OPP.

Best,

- Juri

>>
>> Best,
>>
>> - Juri
>>
>>> Regards,
>>> Vincent
>>>>
>>>> Thanks,
>>>>
>>>> - Juri
>>>>
>>>>> It should be the same for the wake up of a task in enqueue_task_fair
>>>>> above, even if it's less obvious for this latter use case because the
>>>>> cpu might wake up from a long idle phase during which its
>>>>> utilization_blocked_avg has not been updated. Nevertheless, a trig of
>>>>> the freq switch at wake up of the cpu once its usage has been updated
>>>>> should do the job.
>>>>>
>>>>> So tick, migration of tasks, new tasks, entering/leaving idle state of
>>>>> cpu should be enough to trig freq switch
>>>>>
>>>>> Regards,
>>>>> Vincent
>>>>>
>>>>>
>>>>>> +               }
>>>>>>         }
>>>>>>         hrtick_update(rq);
>>>>>>  }
>>>>>> @@ -4959,8 +4999,6 @@ static int find_new_capacity(struct energy_env *eenv,
>>>>>>         return idx;
>>>>>>  }
>>>>>>
>>>>>> -static unsigned int capacity_margin = 1280; /* ~20% margin */
>>>>>> -
>>>>>>  static bool cpu_overutilized(int cpu)
>>>>>>  {
>>>>>>         return (capacity_of(cpu) * 1024) <
>>>>>> --
>>>>>> 1.9.1
>>>>>>
>>>>>
>>>>
>>>
>>
> 


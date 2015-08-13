From: Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFCv5 PATCH 41/46] sched/fair: add triggers for OPP change requests
Date: Thu, 13 Aug 2015 14:08:28 +0200
Message-ID: <CAKfTPtCewGQ_JRvtJPo9yQVcr5vdSr7WY+Z0ahX3DJOX8tpw7w@mail.gmail.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com>
 <1436293469-25707-42-git-send-email-morten.rasmussen@arm.com>
 <CAKfTPtBfNV=K+gwb7dfQXqBEbByMWRoFDb0FtfeeY1hh33j4XA@mail.gmail.com>
 <55C8AA92.8000201@arm.com> <CAKfTPtAJY5zH4YeFibLSg7BbCwV76++fJ_f+uNz8=0t8V8TJWA@mail.gmail.com>
 <55C9BB78.1090508@arm.com> <CAKfTPtDWTon2m=tYU+taZYxgJV2OhPQXX_+Ku+ty=EjEpAzDsA@mail.gmail.com>
 <55CA0FC4.4050908@arm.com> <CAKfTPtBic7ZeJE4Fdk7-xs7j_wRE798umrDQ7CLXuMKpj_jsPQ@mail.gmail.com>
 <55CB6311.4040300@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35746 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbbHMMIu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2015 08:08:50 -0400
Received: by lbcbn3 with SMTP id bn3so25619627lbc.2
        for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2015 05:08:49 -0700 (PDT)
In-Reply-To: <55CB6311.4040300@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Morten Rasmussen <Morten.Rasmussen@arm.com>, Peter Zijlstra <peterz@infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Yuyang Du <yuyang.du@intel.com>, Michael Turquette <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Sai Charan Gurrappadi <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 12 August 2015 at 17:15, Juri Lelli <juri.lelli@arm.com> wrote:
> On 11/08/15 17:37, Vincent Guittot wrote:
>> On 11 August 2015 at 17:07, Juri Lelli <juri.lelli@arm.com> wrote:
>>> Hi Vincent,
>>>
>>> On 11/08/15 12:41, Vincent Guittot wrote:
>>>> On 11 August 2015 at 11:08, Juri Lelli <juri.lelli@arm.com> wrote:
>>>>> On 10/08/15 16:07, Vincent Guittot wrote:
>>>>>> On 10 August 2015 at 15:43, Juri Lelli <juri.lelli@arm.com> wrote:
>>>>>>>
>>>>>>> Hi Vincent,
>>>>>>>
>>>>>>> On 04/08/15 14:41, Vincent Guittot wrote:
>>>>>>>> Hi Juri,
>>>>>>>>
>>>>>>>> On 7 July 2015 at 20:24, Morten Rasmussen <morten.rasmussen@arm.com> wrote:
>>>>>>>>> From: Juri Lelli <juri.lelli@arm.com>

 [snip]

>>>>>>>>>  }
>>>>>>>>> @@ -4393,6 +4416,23 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>>>>>>>         if (!se) {
>>>>>>>>>                 sub_nr_running(rq, 1);
>>>>>>>>>                 update_rq_runnable_avg(rq, 1);
>>>>>>>>> +               /*
>>>>>>>>> +                * We want to trigger a freq switch request only for tasks that
>>>>>>>>> +                * are going to sleep; this is because we get here also during
>>>>>>>>> +                * load balancing, but in these cases it seems wise to trigger
>>>>>>>>> +                * as single request after load balancing is done.
>>>>>>>>> +                *
>>>>>>>>> +                * Also, we add a margin (same ~20% used for the tipping point)
>>>>>>>>> +                * to our request to provide some head room if p's utilization
>>>>>>>>> +                * further increases.
>>>>>>>>> +                */
>>>>>>>>> +               if (sched_energy_freq() && task_sleep) {
>>>>>>>>> +                       unsigned long req_cap = get_cpu_usage(cpu_of(rq));
>>>>>>>>> +
>>>>>>>>> +                       req_cap = req_cap * capacity_margin
>>>>>>>>> +                                       >> SCHED_CAPACITY_SHIFT;
>>>>>>>>> +                       cpufreq_sched_set_cap(cpu_of(rq), req_cap);
>>>>>>>>
>>>>>>>> Could you clarify why you want to trig a freq switch for tasks that
>>>>>>>> are going to sleep ?
>>>>>>>> The cpu_usage should not changed that much as the se_utilization of
>>>>>>>> the entity moves from utilization_load_avg to utilization_blocked_avg
>>>>>>>> of the rq and the usage and the freq are updated periodically.
>>>>>>>
>>>>>>> I think we still need to cover multiple back-to-back dequeues. Suppose
>>>>>>> that you have, let's say, 3 tasks that get enqueued at the same time.
>>>>>>> After some time the first one goes to sleep and its utilization, as you
>>>>>>> say, gets moved to utilization_blocked_avg. So, nothing changes, and
>>>>>>> the trigger is superfluous (even if no freq change I guess will be
>>>>>>> issued as we are already servicing enough capacity). However, after a
>>>>>>> while, the second task goes to sleep. Now we still use get_cpu_usage()
>>>>>>> and the first task contribution in utilization_blocked_avg should have
>>>>>>> been decayed by this time. Same thing may than happen for the third task
>>>>>>> as well. So, if we don't check if we need to scale down in
>>>>>>> dequeue_task_fair, it seems to me that we might miss some opportunities,
>>>>>>> as blocked contribution of other tasks could have been successively
>>>>>>> decayed.
>>>>>>>
>>>>>>> What you think?
>>>>>>
>>>>>> The tick is used to monitor such variation of the usage (in both way,
>>>>>> decay of the usage of sleeping tasks and increase of the usage of
>>>>>> running tasks). So in your example, if the duration between the sleep
>>>>>> of the 2 tasks is significant enough, the tick will handle this
>>>>>> variation
>>>>>>
>>>>>
>>>>> The tick is used to decide if we need to scale up (to max OPP for the
>>>>> time being), but we don't scale down. It makes more logical sense to
>>>>
>>>> why don't you want to check if you need to scale down ?
>>>>
>>>
>>> Well, because if I'm still executing something the cpu usage is only
>>> subject to raise.
>>
>> This is only true for  system with NO HZ idle
>>
>
> Well, even with !NO_HZ_IDLE usage only decreases when cpu is idle. But,

Well, thanks for this obvious statement that usage only decreases when
cpu is idle but my question has never been about usage variation of
idle/running cpu but about the tick.

> I think I got your point; for !NO_HZ_IDLE configurations we might end
> up not scaling down frequency even if we have the tick running and
> the cpu is idle. I might need some more time to think this through, but
> it seems to me that we are still fine without an explicit trigger in
> task_tick_fair(); if we are running a !NO_HZ_IDLE system we are probably
> not so much concerned about power savings and still we react
> to tasks waking up, sleeping, leaving or moving around (which seems the
> real important events to me); OTOH, we might add that trigger, but this
> will generate unconditional checks at tick time for NO_HZ_IDLE

That will be far less critical than unconditionally check during all
task wake up or sleep. A task that wakes up every 200us will generate
much more check in the wake up hot path of the cpu that is already
busy with another task

> configurations, for a benefit that it seems to be still not completely
> clear.
>
>>>
>>>>> scale down at task deactivation, or wakeup after a long time, IMHO.
>>>>
>>>> But waking up or going to sleep don't have any impact on the usage of
>>>> a cpu. The only events that impact the cpu usage are:
>>>> -task migration,
>>>
>>> We explicitly cover this on load balancing paths.

But task can migrate out of the load balancing; At wake up for example
and AFAICT, you don't use this event to notify the decrease of the
usage of the cpu and check if a new OPP will fit better with the new
usage.

>>>
>>>> -new task
>>>
>>> We cover this in enqueue_task_fair(), introducing a new flag.
>>>
>>>> -time that elapse which can be monitored by periodically checking the usage.
>>>
>>> Do you mean when a task utilization crosses some threshold
>>> related to the current OPP? If that is the case, we have a
>>> check in task_tick_fair().
>>>
>>>> -and for nohz system when cpu enter or leave idle state
>>>>
>>>
>>> We address this in dequeue_task_fair(). In particular, if
>>> the cpu is going to be idle we don't trigger any change as
>>> it seems not always wise to wake up a thread to just change
>>> the OPP and the go idle; some platforms might require this
>>> behaviour anyway, but it probably more cpuidle/fw related?
>>
>> I would say that it's interesting to notifiy sched-dvfs that a cpu
>> becomes idle because we could decrease the opp of a cluster of cpus
>> that share the same clock if this cpu is the one that requires the max
>> capacity of the cluster (and other cpus are still running).
>>
>
> Well, we reset the capacity request of the cpu that is going idle.

And i'm fine with the fact that you use the cpu idle event

> The idea is that the next event on one of the other related cpus
> will update the cluster freq correctly. If any other cpu in the
> cluster is running something we keep the same frequency until
> the task running on that cpu goes to sleep; this seems fine to
> me because that task might end up being heavy and we saved a
> back to back lower to higher OPP switch; if the task is instead
> light it will probably be dequeued pretty soon, and at that time
> we switch to a lower OPP (since we cleared the idle cpu request
> before). Also, if the other cpus in the cluster are all idle
> we'll most probably enter an idle state, so no freq switch is
> most likely required.
>
>>>
>>> I would also add:
>>>
>>> - task is going to die
>>>
>>> We address this in dequeue as well, as its contribution is
>>> removed from usage (mod Yuyang's patches).
>>>
>>>> waking up and going to sleep events doesn't give any useful
>>>> information and using them to trig the monitoring of the usage
>>>> variation doesn't give you a predictable/periodic update of it whereas
>>>> the tick will
>>>>
>>>
>>> So, one key point of this solution is to get away as much
>>> as we can from periodic updates/sampling and move towards a
>>> (fully) event driven approach. The event logically associated
>>> to task_tick_fair() is when we realize that a task is going
>>> to saturate the current capacity; in this case we trigger a
>>> freq switch to an higher capacity. Also, if we never react
>>> to normal wakeups (as I understand you are proposing) we might
>>> miss some chances to adapt quickly enough. As an example, if
>>> you have a big task that suddenly goes to sleep, and sleeps
>>> until its decayed utilization goes almost to zero; when it
>>> wakes up, if we don't have a trigger in enqueue_task_fair(),

I'm not against having a trigger in enqueue, i'm against bindly
checking all task wake up in order to be sure to catch the useful
event like the cpu leave idle event of your example

>>> we'll have to wait until the next tick to select an appropriate
>>> (low) OPP.
>>
>> I assume that the cpu is idle in this case. This situation only
>> happens on Nohz idle system because tick is disable and you have to
>> update statistics when leaving idle as it is done for the jiffies or
>> the cpu_load array. So you should track cpu enter/leave idle (for nohz
>> system only) instead of tracking all tasks wake up/sleep events.
>>
>
> I think I already replied to this in what above. Did I? :)

In fact, It was not a question, i just state that using all wake up /
sleep events to be sure to trig the check of cpu capacity when the cpu
leave an idle phase (and especially a long one like in your example
above), is wrong. You have to use the leave idle event instead of
checking all wake up events to be sure to catch the right one. You say
that you want to get away as much as possible the periodic
updates/sampling but it's exactly what you do with these 2 events.
Using them only enables you to periodically check if the capacity has
changed since the last time like the tick already does. But instead of
using a periodic and controlled event, you use these random (with
regards to capacity evolution) and uncontrolled events in order to
catch useful change. As an example, If a cpu run a task and there is a
short running task that wakes up every 100us for running 100us, you
will call cpufreq_sched_set_cap, 5000 times per second for no good
reason as you already have the tick to periodically check the
evolution of the usage.

>
>> So you can either use update_cpu_load_nohz like it is already done for
>> cpu_load array
>> or you should use some conditions like below if you want to stay in
>> enqueue/dequeue_task_fair but task wake up or sleep event are not the
>> right condition
>> if (!(flags & ENQUEUE_WAKEUP) || rq->nr_running == 1 ) in enqueue_task_fair
>> and
>> if (!task_sleep || rq->nr_running == 0) in dequeue_task_fair
>>
>> We can probably optimized by using  rq->cfs.h_nr_running instead of
>> rq->nr_running as only cfs tasks really modifies the usage
>>
>
> I already filter out enqueues/dequeues that comes from load balancing;
> and I use cfs.nr_running because, as you say, we currently work with CFS
> tasks only.

But not for the enqueue where you should use it instead of all wake up events.

Just to be clear: Using all enqueue/dequeue events (including task
wake up and sleep) to check a change of the usage of a cpu was doing a
lot of sense when mike has sent his v3 of the scheduler driven cpu
frequency selection because the usage was not accounting the blocked
tasks at that time so it was changing for all enqueue/dequeue events.
But this doesn't make sense in this patchset that account the blocked
tasks in the usage of the cpu and more generally now that yuyang's
patch set has been accepted.

Regards,
Vincent

>
> Thanks,
>
> - Juri
>
>> Regards,
>> Vincent
>>
>>>
>>> Best,
>>>
>>> - Juri
>>>
>>>>>
>>>>> Best,
>>>>>
>>>>> - Juri
>>>>>
>>>>>> Regards,
>>>>>> Vincent
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> - Juri
>>>>>>>
>>>>>>>> It should be the same for the wake up of a task in enqueue_task_fair
>>>>>>>> above, even if it's less obvious for this latter use case because the
>>>>>>>> cpu might wake up from a long idle phase during which its
>>>>>>>> utilization_blocked_avg has not been updated. Nevertheless, a trig of
>>>>>>>> the freq switch at wake up of the cpu once its usage has been updated
>>>>>>>> should do the job.
>>>>>>>>
>>>>>>>> So tick, migration of tasks, new tasks, entering/leaving idle state of
>>>>>>>> cpu should be enough to trig freq switch
>>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Vincent
>>>>>>>>
>>>>>>>>
>>>>>>>>> +               }
>>>>>>>>>         }
>>>>>>>>>         hrtick_update(rq);
>>>>>>>>>  }
>>>>>>>>> @@ -4959,8 +4999,6 @@ static int find_new_capacity(struct energy_env *eenv,
>>>>>>>>>         return idx;
>>>>>>>>>  }
>>>>>>>>>
>>>>>>>>> -static unsigned int capacity_margin = 1280; /* ~20% margin */
>>>>>>>>> -
>>>>>>>>>  static bool cpu_overutilized(int cpu)
>>>>>>>>>  {
>>>>>>>>>         return (capacity_of(cpu) * 1024) <
>>>>>>>>> --
>>>>>>>>> 1.9.1
>>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
>

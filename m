From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 07/14] sched/core: uclamp: enforce last task UCLAMP_MAX
Date: Thu, 16 Aug 2018 19:10:58 +0200
Message-ID: <e99cef73-3bd8-9982-1d09-17de7ec8f76a@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-8-patrick.bellasi@arm.com>
 <2366fe11-db1f-4f39-df03-960535611319@arm.com>
 <20180816164745.GF2960@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180816164745.GF2960@e110439-lin>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 08/16/2018 06:47 PM, Patrick Bellasi wrote:
> On 16-Aug 17:43, Dietmar Eggemann wrote:
>> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
>>> When a util_max clamped task sleeps, its clamp constraints are removed
>> >from the CPU. However, the blocked utilization on that CPU can still be
>>> higher than the max clamp value enforced while that task was running.
>>> This max clamp removal when a CPU is going to be idle could thus allow
>>> unwanted CPU frequency increases, right while the task is not running.
>>
>> So 'rq->uclamp.flags == UCLAMP_FLAG_IDLE' means CPU is IDLE because
>> non-clamped tasks are tracked as well ((group_id = 0)).
> 
> Right, but... with (group_id = 0) you mean that "non-clamped tasks are
> tracked" in the first clamp group?

Yes. I was asking myself what will happen if there are only non-clamped 
tasks runnable ...

> 
>> Maybe this is worth mentioning here?
> 
> Maybe I can explicitely say that we detect that there are not RUNNABLE
> tasks because all the clamp groups are in UCLAMP_NOT_VALID status.

Yes, would have helped me the grasp this earlier ...

[...]

>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index bc2beedec7bf..ff76b000bbe8 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -906,7 +906,8 @@ uclamp_group_find(int clamp_id, unsigned int clamp_value)
>>>    * For the specified clamp index, this method computes the new CPU utilization
>>>    * clamp to use until the next change on the set of RUNNABLE tasks on that CPU.
>>>    */
>>> -static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
>>> +static inline void uclamp_cpu_update(struct rq *rq, int clamp_id,
>>> +				     unsigned int last_clamp_value)
>>>   {
>>>   	struct uclamp_group *uc_grp = &rq->uclamp.group[clamp_id][0];
>>>   	int max_value = UCLAMP_NOT_VALID;
>>> @@ -924,6 +925,19 @@ static inline void uclamp_cpu_update(struct rq *rq, int clamp_id)
>>
>> The condition:
>>
>>      if (!uclamp_group_active(uc_grp, group_id))
>>          continue;
>>
>> in 'for (group_id = 0; group_id <= CONFIG_UCLAMP_GROUPS_COUNT; ++group_id)
>> {}' makes sure that 'max_value == UCLAMP_NOT_VALID' is true for the if
>> condition (*):
>>
>>
>>>   		if (max_value >= SCHED_CAPACITY_SCALE)
>>>   			break;
>>>   	}
>>> +
>>> +	/*
>>> +	 * Just for the UCLAMP_MAX value, in case there are no RUNNABLE
>>> +	 * task, we keep the CPU clamped to the last task's clamp value.
>>> +	 * This avoids frequency spikes to MAX when one CPU, with an high
>>> +	 * blocked utilization, sleeps and another CPU, in the same frequency
>>> +	 * domain, do not see anymore the clamp on the first CPU.
>>> +	 */
>>> +	if (clamp_id == UCLAMP_MAX && max_value == UCLAMP_NOT_VALID) {
>>> +		rq->uclamp.flags |= UCLAMP_FLAG_IDLE;
>>> +		max_value = last_clamp_value;
>>> +	}
>>> +
>>
>> (*): So the uc_grp[group_id].value stays last_clamp_value?
> 
> A bit confusing... but I think you've got the point.

OK.

> 
>> What do you do when the blocked utilization decays below this enforced
>> last_clamp_value on that CPU?
> 
> This is done _just_ for max_util:
> - it clamps a blocked utilization bigger then last_clamp_value
>    thus avoiding the selection of an OPP bigger then the one enforced
>    while the task was runnable
> - it has not effect on a blocked utilization smaller then last_clamp_value
>    thus allowing to reduce gracefully the OPP as long as the blocked
>    utilization is decayed

Ah correct, max_util is about capping, not boosting.

> 
>> I assume there are plenty of this kind of corner cases because we have
>> blocked signals (including all tasks) and clamping (including runnable
>> tasks).
> 
> This is a pretty compelling one I've noticed in my tests and thus
> worth a fix... I don't have on hand other similar corner cases, do
> you?

No not right now, will continue to watch out for them ...

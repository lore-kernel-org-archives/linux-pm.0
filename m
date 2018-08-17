From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 09/14] sched/core: uclamp: propagate parent clamps
Date: Fri, 17 Aug 2018 17:50:20 +0200
Message-ID: <d6c3b6f4-b3bd-22d9-70c0-38ad587b9339@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-10-patrick.bellasi@arm.com>
 <804c7937-2c47-0781-9c53-a8ef8eb04530@arm.com>
 <20180817144540.GL2960@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180817144540.GL2960@e110439-lin>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 08/17/2018 04:45 PM, Patrick Bellasi wrote:
> On 17-Aug 15:43, Dietmar Eggemann wrote:
>> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:
>>> In order to properly support hierarchical resources control, the cgroup
>>> delegation model requires that attribute writes from a child group never
>>> fail but still are (potentially) constrained based on parent's assigned
>>> resources. This requires to properly propagate and aggregate parent
>>> attributes down to its descendants.
>>
>> I don't understand the reason mentioned here:
>>
>> IMHO, a write to a child's (tg1/tg11) cpu.rt_runtime_us can fail if the
>> value is restricted by the parents value:
> 
> Well... that's my interpretation after this discussion:
> 
>    https://lore.kernel.org/lkml/20180410200514.GA793541@devbig577.frc2.facebook.com/

So cgroups v2 uses .effective files for config propagation. Didn't know 
that.

> AFAIU, what has not to fail is a write to a parent, which wants to enforce
> more restrictive constraints to child groups. Thus, if we have for example:
> 
>     tg1:         util_max=100%
>     tg1/tg11:    util_max=80%
> 
> It should be possible without errors to set:
> 
>     tg1:         util_max=50%
> 
> and then enforce a 50% util_max to tg1/tg11 tasks too and eventually
> use "effective" attributes to expose the effective value used at each
> level of the hierarchy.

Ok, your example makes sense. But the text above says 'that attribute 
writes from a child group never fail but still are ...'. So this is a 
little bit different.

I guess with the knowledge that this is by default cgroups v2 and that 
config propagation is implemented via the .effective files it's digestible.

> 
>> root@juno:/sys/fs/cgroup/cpu# cat cpu.rt_*
>> 1000000
>> 950000
>> root@juno:/sys/fs/cgroup/cpu# cat tg1/cpu.rt_*
>> 1000000
>> 0
>> root@juno:/sys/fs/cgroup/cpu# cat tg1/tg11/cpu.rt_*
>> 1000000
>> 0
>> root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/tg11/cpu.rt_runtime_us
>> -bash: echo: write error: Invalid argument
>> root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/cpu.rt_runtime_us
>> root@juno:/sys/fs/cgroup/cpu# echo 950000 > tg1/tg11/cpu.rt_runtime_us
>> root@juno:/sys/fs/cgroup/cpu#
> 
> This example is using the legacy hierarcy (cgroups v1).

Yeah, so your patches take unified (v2) as default.

> 
> AFAIK the default hierarcy (cgroups v2) has a much more stricy set of
> requirements for the "delegation model".

Could be ... I guess I have to study this more.

[...]

>> I assume here that the cpu.util.{min,max} of the child will not be used any
>> more because the 'effective' counterparts are taken instead.
> 
> Yes, the "effective" attributes are the one used in kernel space for
> the actual clamping.
> 
> However, the cpu.util.{min,max} of a child are still required as soon
> as the parent relax its constraints... when we use their value to
> set the "effective" value.

Yes, with the new background this make sense.

>> I wonder if this propagation not been provided with only cpu.util.{min,max}?
> 
> In the example before, if we use the same variables we miss the
> opportunity to reset:
> 
>     tg1/tg11:    util_max=80%
> 
> as soon as tg1's util_max goes back to 100%.

Yes, from the config propagation point of view this should be pretty 
close to the v2 cpuset controller from Waiman Long.

Maybe mentioning that these .effective files are the 'standard' way to 
implement proper config propagation in cgroups v2 would help 
understanding this patch.
